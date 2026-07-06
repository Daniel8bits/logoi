import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/ai/models.dart';
import '../../../core/ai/prompts/prompts.dart';
import '../../../core/ai/response_parser.dart';
import '../../../core/ai/router.dart';
import '../../../core/database/daos/concept_dao.dart';
import '../../../core/database/database.dart';
import '../../../core/utils/result.dart';

/// The full concept graph of a project.
class ConceptGraphData {
  const ConceptGraphData({required this.concepts, required this.relations});

  final List<ConceptRow> concepts;
  final List<ConceptRelationRow> relations;
}

/// Concepts, concept relations and cross references
/// (docs/08_ROADMAP.md §3.5-§3.6).
class ConceptRepository {
  ConceptRepository({
    required ConceptDao dao,
    required String projectId,
    AIRouter? router,
    JSONResponseParser parser = const JSONResponseParser(),
  })  : _dao = dao,
        _projectId = projectId,
        _router = router,
        _parser = parser;

  final ConceptDao _dao;
  final String _projectId;
  final AIRouter? _router;
  final JSONResponseParser _parser;

  static const _uuid = Uuid();

  // ── Concepts ──

  Stream<List<ConceptRow>> watchConcepts() => _dao.watchByProject(_projectId);

  Future<ConceptGraphData> getGraph() async => ConceptGraphData(
        concepts: await _dao.getByProject(_projectId),
        relations: await _dao.getRelations(_projectId),
      );

  Future<void> addManual({
    required String name,
    String? definition,
    String? type,
  }) =>
      _dao.insertConcept(ConceptsCompanion(
        id: Value(_uuid.v4()),
        projectId: Value(_projectId),
        name: Value(name.trim()),
        definition: Value(definition),
        type: Value(type),
        source: const Value('user'),
        createdAt: Value(DateTime.now().millisecondsSinceEpoch),
      ));

  Future<void> deleteConcept(String id) => _dao.deleteConcept(id);

  /// AI extraction from a selected passage (docs/08_ROADMAP.md §3.5).
  /// Returns the number of newly added concepts.
  Future<Result<int, Failure>> extractFromText(
    String selectedText, {
    String? documentId,
  }) async {
    final router = _router;
    if (router == null) {
      return const Result.error(
          AIFailure('Configure um provider de IA nas configurações.'));
    }

    final existing = await _dao.getByProject(_projectId);
    final prompt = Prompts.conceptExtraction.render({
      'selected_text': selectedText,
      'existing_concepts':
          jsonEncode([for (final c in existing) c.name]),
    });
    final response = await router.complete(
      task: AITask.conceptExtraction,
      messages: [AIChatMessage(role: AIChatRole.system, content: prompt)],
      documentId: documentId,
    );
    final raw = response.valueOrNull;
    if (raw == null) return Result.error(response.errorOrNull!);

    final parsed = _parser.parse(raw);
    final json = parsed.valueOrNull;
    if (json == null) return Result.error(parsed.errorOrNull!);

    final items = (json['concepts'] as List<dynamic>? ?? const [])
        .whereType<Map<String, dynamic>>()
        .toList();

    final idByName = {
      for (final c in existing) c.name.toLowerCase(): c.id,
    };
    final now = DateTime.now().millisecondsSinceEpoch;
    var added = 0;

    for (final item in items) {
      final name = (item['name'] as String? ?? '').trim();
      if (name.isEmpty || idByName.containsKey(name.toLowerCase())) continue;
      final id = _uuid.v4();
      await _dao.insertConcept(ConceptsCompanion(
        id: Value(id),
        projectId: Value(_projectId),
        name: Value(name),
        definition: Value(item['definition'] as String?),
        type: Value(item['type'] as String?),
        source: const Value('ai'),
        createdAt: Value(now),
      ));
      idByName[name.toLowerCase()] = id;
      added++;
    }

    for (final item in items) {
      final sourceId =
          idByName[(item['name'] as String? ?? '').trim().toLowerCase()];
      if (sourceId == null) continue;
      final relations = (item['relations'] as List<dynamic>? ?? const [])
          .whereType<Map<String, dynamic>>();
      for (final relation in relations) {
        final targetId = idByName[
            (relation['related_concept'] as String? ?? '').trim().toLowerCase()];
        final relationType = relation['relation_type'] as String?;
        if (targetId == null || relationType == null || targetId == sourceId) {
          continue;
        }
        await _dao.insertRelation(ConceptRelationsCompanion(
          id: Value(_uuid.v4()),
          projectId: Value(_projectId),
          sourceId: Value(sourceId),
          targetId: Value(targetId),
          relation: Value(relationType),
          description: Value(relation['description'] as String?),
          createdAt: Value(now),
        ));
      }
    }

    return Result.ok(added);
  }

  // ── Cross references (docs/08_ROADMAP.md §3.6 — manual) ──

  Future<List<CrossReferenceRow>> getCrossRefsForPage(
    String documentId,
    int pageNumber,
  ) =>
      _dao.getCrossRefsForPage(documentId, pageNumber);

  Future<void> addCrossReference({
    required String sourceDocId,
    required int sourcePage,
    required String sourceText,
    required String targetDocId,
    required int targetPage,
    required String targetText,
    required String relationType,
  }) =>
      _dao.insertCrossRef(CrossReferencesCompanion(
        id: Value(_uuid.v4()),
        projectId: Value(_projectId),
        sourceDocId: Value(sourceDocId),
        sourcePage: Value(sourcePage),
        sourceText: Value(sourceText),
        targetDocId: Value(targetDocId),
        targetPage: Value(targetPage),
        targetText: Value(targetText),
        relationType: Value(relationType),
        sourceOrigin: const Value('user'),
        createdAt: Value(DateTime.now().millisecondsSinceEpoch),
      ));

  Future<void> deleteCrossReference(String id) => _dao.deleteCrossRef(id);
}
