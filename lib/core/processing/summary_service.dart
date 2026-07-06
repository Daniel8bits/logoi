import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../ai/models.dart';
import '../ai/prompts/prompts.dart';
import '../ai/response_parser.dart';
import '../ai/router.dart';
import '../database/daos/document_dao.dart';
import '../database/database.dart';
import '../utils/result.dart';
import 'compressor.dart';

/// Map-reduce summary hierarchy (docs/05_PROCESSING.md §5):
/// sections → chapters → document. Each level is one cheap API call per
/// node; results are persisted permanently in `section_summaries` and are
/// idempotent (nodes with an existing summary are skipped).
///
/// The document-level overview is stored in `documents.metadata` under
/// `document_summary`, since the TOC-derived structure has no
/// document-level node.
class SummaryHierarchyService {
  SummaryHierarchyService({
    required DocumentDao documentDao,
    required AIRouter router,
    TextCompressor compressor = const TextCompressor(),
    JSONResponseParser parser = const JSONResponseParser(),
  })  : _documentDao = documentDao,
        _router = router,
        _compressor = compressor,
        _parser = parser;

  final DocumentDao _documentDao;
  final AIRouter _router;
  final TextCompressor _compressor;
  final JSONResponseParser _parser;

  static const _uuid = Uuid();

  /// Max input characters per section call (~3000 tokens).
  static const _maxSectionChars = 12000;

  /// Runs the full hierarchy for a document. Returns the number of API
  /// calls made (0 when everything was already summarized).
  Future<Result<int, Failure>> summarizeDocument(
    String documentId, {
    void Function(String stage, int done, int total)? onProgress,
  }) async {
    final structure = await _documentDao.getStructure(documentId);
    if (structure.isEmpty) {
      return const Result.error(
          AIFailure('Documento sem estrutura de seções (TOC vazio).'));
    }

    final childrenOf = <String?, List<StructureRow>>{};
    for (final node in structure) {
      childrenOf.putIfAbsent(node.parentId, () => []).add(node);
    }
    bool isLeaf(StructureRow node) =>
        (childrenOf[node.id] ?? const []).isEmpty;

    var calls = 0;

    // Level 1 — section summaries from compressed text.
    final leaves = structure.where(isLeaf).toList();
    for (var i = 0; i < leaves.length; i++) {
      final result = await _summarizeSection(documentId, leaves[i]);
      if (result.isError) return Result.error(result.errorOrNull!);
      if (result.valueOrNull == true) {
        calls++;
        await Future<void>.delayed(const Duration(seconds: 2));
      }
      onProgress?.call('sections', i + 1, leaves.length);
    }
    await _documentDao.setProcessingStatus(documentId, 'summarized');

    // Level 2 — chapter summaries from child summaries, deepest first so
    // parents always find their children already summarized.
    final parents = structure.where((n) => !isLeaf(n)).toList()
      ..sort((a, b) => _depth(b, structure).compareTo(_depth(a, structure)));
    for (var i = 0; i < parents.length; i++) {
      final children = childrenOf[parents[i].id]!;
      final result = await _summarizeChapter(parents[i], children);
      if (result.isError) return Result.error(result.errorOrNull!);
      if (result.valueOrNull == true) {
        calls++;
        await Future<void>.delayed(const Duration(seconds: 2));
      }
      onProgress?.call('chapters', i + 1, parents.length);
    }

    // Level 3 — document overview from top-level summaries.
    final roots = childrenOf[null] ?? const <StructureRow>[];
    final overview = await _summarizeWholeDocument(documentId, roots);
    if (overview.isError) return Result.error(overview.errorOrNull!);
    if (overview.valueOrNull == true) calls++;
    onProgress?.call('document', 1, 1);

    await _documentDao.setProcessingStatus(documentId, 'fully_processed');
    return Result.ok(calls);
  }

  /// Returns true when an API call was made (false = cached/skipped).
  Future<Result<bool, Failure>> _summarizeSection(
    String documentId,
    StructureRow node,
  ) async {
    if (await _documentDao.getSummaryForStructure(node.id) != null) {
      return const Result.ok(false);
    }
    await _documentDao.setStructureStatus(node.id, 'summarizing');

    final buffer = StringBuffer();
    for (var page = node.pageStart; page <= node.pageEnd; page++) {
      final content = await _documentDao.getPage(documentId, page);
      if (content != null) buffer.writeln(content.content);
    }
    var compressed = _compressor.compress(buffer.toString());
    if (compressed.length > _maxSectionChars) {
      compressed = compressed.substring(0, _maxSectionChars);
    }
    if (compressed.trim().isEmpty) {
      await _documentDao.setStructureStatus(node.id, 'done');
      return const Result.ok(false);
    }

    final result = await _router.complete(
      task: AITask.sectionSummary,
      messages: [
        AIChatMessage(
          role: AIChatRole.system,
          content: Prompts.sectionSummary.template,
        ),
        AIChatMessage(role: AIChatRole.user, content: compressed),
      ],
      documentId: documentId,
    );
    final response = result.valueOrNull;
    if (response == null) {
      await _documentDao.setStructureStatus(node.id, 'pending');
      return Result.error(result.errorOrNull!);
    }

    await _persistSummary(node.id, compressed, response);
    await _documentDao.setStructureStatus(node.id, 'done');
    return const Result.ok(true);
  }

  Future<Result<bool, Failure>> _summarizeChapter(
    StructureRow node,
    List<StructureRow> children,
  ) async {
    if (await _documentDao.getSummaryForStructure(node.id) != null) {
      return const Result.ok(false);
    }
    final combined = await _combineSummaries(children);
    if (combined.isEmpty) return const Result.ok(false);

    final result = await _router.complete(
      task: AITask.chapterSummary,
      messages: [
        AIChatMessage(
          role: AIChatRole.system,
          content: Prompts.chapterSummary.template,
        ),
        AIChatMessage(role: AIChatRole.user, content: combined),
      ],
      documentId: node.documentId,
    );
    final response = result.valueOrNull;
    if (response == null) return Result.error(result.errorOrNull!);

    await _persistSummary(node.id, combined, response);
    return const Result.ok(true);
  }

  Future<Result<bool, Failure>> _summarizeWholeDocument(
    String documentId,
    List<StructureRow> roots,
  ) async {
    final doc = await _documentDao.getById(documentId);
    if (doc == null) {
      return const Result.error(DatabaseFailure('Documento não encontrado'));
    }
    final metadata = doc.metadata != null
        ? jsonDecode(doc.metadata!) as Map<String, dynamic>
        : <String, dynamic>{};
    if (metadata.containsKey('document_summary')) {
      return const Result.ok(false);
    }

    final combined = await _combineSummaries(roots);
    if (combined.isEmpty) {
      return const Result.error(AIFailure('Nenhum resumo de seção gerado.'));
    }

    final result = await _router.complete(
      task: AITask.documentSummary,
      messages: [
        AIChatMessage(
          role: AIChatRole.system,
          content: Prompts.documentSummary.template,
        ),
        AIChatMessage(role: AIChatRole.user, content: combined),
      ],
      documentId: documentId,
    );
    final response = result.valueOrNull;
    if (response == null) return Result.error(result.errorOrNull!);

    metadata['document_summary'] = _parser.parse(response).valueOrNull ??
        <String, dynamic>{'document_summary': response};
    await _documentDao.updateDocument(
      documentId,
      DocumentsCompanion(metadata: Value(jsonEncode(metadata))),
    );
    return const Result.ok(true);
  }

  Future<String> _combineSummaries(List<StructureRow> nodes) async {
    final parts = <String>[];
    for (final node in nodes) {
      final summary = await _documentDao.getSummaryForStructure(node.id);
      if (summary?.summary != null) {
        parts.add('## ${node.title ?? '(sem título)'}\n${summary!.summary}');
      }
    }
    return parts.join('\n\n');
  }

  Future<void> _persistSummary(
    String structureId,
    String input,
    String response,
  ) async {
    final parsed = _parser.parse(response).valueOrNull;
    final summary = parsed?['summary'] as String? ?? response;
    final concepts = parsed?['concepts'] as List<dynamic>?;
    final route = _router.resolveRoute(AITask.sectionSummary);

    await _documentDao.upsertSectionSummary(SectionSummariesCompanion(
      id: Value(_uuid.v4()),
      structureId: Value(structureId),
      compressedText: Value(input),
      summary: Value(summary),
      keyConcepts: Value(concepts != null ? jsonEncode(concepts) : null),
      inputTokens: Value(AIRouter.estimateTokens(input)),
      outputTokens: Value(AIRouter.estimateTokens(response)),
      provider: Value(route.providerId),
      model: Value(route.model),
      promptVersion: Value(Prompts.sectionSummary.version),
      generatedAt: Value(DateTime.now().millisecondsSinceEpoch),
    ));
  }

  int _depth(StructureRow node, List<StructureRow> all) {
    var depth = 0;
    var current = node;
    while (current.parentId != null) {
      current = all.firstWhere((n) => n.id == current.parentId);
      depth++;
    }
    return depth;
  }
}
