import 'dart:convert';
import 'dart:io';

import '../../../core/ai/models.dart';
import '../../../core/ai/prompts/prompts.dart';
import '../../../core/ai/router.dart';
import '../../../core/database/daos/annotation_dao.dart';
import '../../../core/database/daos/concept_dao.dart';
import '../../../core/database/database.dart';
import '../../../core/utils/result.dart';

/// Citation styles (docs/08_ROADMAP.md §4.2).
enum CitationStyle {
  abnt('ABNT'),
  apa('APA'),
  vancouver('Vancouver');

  const CitationStyle(this.label);
  final String label;
}

/// Data export: fichamento, Zettelkasten notes, bibliography, Anki
/// flashcards and concept graph (docs/08_ROADMAP.md §4.2).
class ExportService {
  ExportService({
    required AnnotationDao annotationDao,
    required ConceptDao conceptDao,
    required String projectId,
    required String projectName,
    required String userLanguage,
    AIRouter? router,
  })  : _annotationDao = annotationDao,
        _conceptDao = conceptDao,
        _projectId = projectId,
        _projectName = projectName,
        _userLanguage = userLanguage,
        _router = router;

  final AnnotationDao _annotationDao;
  final ConceptDao _conceptDao;
  final String _projectId;
  final String _projectName;
  final String _userLanguage;
  final AIRouter? _router;

  // ── Citations (Nível 1 — deterministic, docs/05_PROCESSING.md §2.1) ──

  String formatCitation(DocumentRow doc, CitationStyle style) {
    final authors = _parseAuthors(doc.authors);
    final title = doc.title ?? doc.fileName;
    final year = doc.year?.toString() ?? 's.d.';

    return switch (style) {
      CitationStyle.abnt =>
        '${authors.map(_abntName).join('; ')}. **$title**. $year.',
      CitationStyle.apa =>
        '${authors.map(_apaName).join(', ')} ($year). *$title*.',
      CitationStyle.vancouver =>
        '${authors.map(_vancouverName).join(', ')}. $title. $year.',
    };
  }

  Future<Result<File, Failure>> exportBibliography(
    List<DocumentRow> docs,
    CitationStyle style,
    String dirPath,
  ) async {
    final buffer = StringBuffer('# Referências (${style.label})\n\n');
    for (final doc in docs) {
      buffer.writeln('- ${formatCitation(doc, style)}');
    }
    return _writeFile('$dirPath/referencias_${style.name}.md', buffer.toString());
  }

  // ── Fichamento (docs/08_ROADMAP.md §4.2 — via IA, com fallback) ──

  Future<Result<File, Failure>> exportFichamento(
    DocumentRow doc,
    String dirPath, {
    CitationStyle style = CitationStyle.abnt,
  }) async {
    final annotations = await _annotationDao.getByDocument(doc.id);
    if (annotations.isEmpty) {
      return const Result.error(
          FileFailure('Documento sem anotações para fichar.'));
    }

    final markdown = await _generateFichamento(doc, annotations, style) ??
        _deterministicFichamento(doc, annotations, style);
    return _writeFile(
      '$dirPath/fichamento_${_slug(doc.title ?? doc.fileName)}.md',
      markdown,
    );
  }

  Future<String?> _generateFichamento(
    DocumentRow doc,
    List<AnnotationRow> annotations,
    CitationStyle style,
  ) async {
    final router = _router;
    if (router == null) return null;

    final annotationsJson = jsonEncode([
      for (final a in annotations)
        {
          'page': a.pageNumber,
          'type': a.type,
          'selected_text': a.selectedText,
          'content': a.content,
          'tags': a.tags,
        },
    ]);
    final prompt = Prompts.readingSummary.render({
      'document_title': doc.title ?? doc.fileName,
      'formatted_citation': formatCitation(doc, style),
      'reading_date': DateTime.now().toIso8601String().substring(0, 10),
      'project_name': _projectName,
      'user_language': _userLanguage,
      'all_annotations_json': annotationsJson,
    });
    final result = await router.complete(
      task: AITask.readingSummary,
      messages: [AIChatMessage(role: AIChatRole.system, content: prompt)],
      documentId: doc.id,
      maxTokens: 4096,
    );
    return result.valueOrNull;
  }

  String _deterministicFichamento(
    DocumentRow doc,
    List<AnnotationRow> annotations,
    CitationStyle style,
  ) {
    final buffer = StringBuffer()
      ..writeln('# Fichamento: ${doc.title ?? doc.fileName}')
      ..writeln()
      ..writeln('**Referência:** ${formatCitation(doc, style)}')
      ..writeln('**Projeto:** $_projectName')
      ..writeln()
      ..writeln('## Anotações')
      ..writeln();
    for (final annotation in annotations) {
      buffer.writeln('### p. ${annotation.pageNumber} (${annotation.type})');
      if (annotation.selectedText != null) {
        buffer.writeln('> ${annotation.selectedText}');
        buffer.writeln();
      }
      buffer.writeln(annotation.content ?? '');
      buffer.writeln();
    }
    return buffer.toString();
  }

  // ── Zettelkasten (Obsidian/Logseq compatible) ──

  Future<Result<List<File>, Failure>> exportZettelkasten(
    DocumentRow doc,
    String dirPath,
  ) async {
    final annotations = await _annotationDao.getByDocument(doc.id);
    if (annotations.isEmpty) {
      return const Result.error(
          FileFailure('Documento sem anotações para exportar.'));
    }

    final docTitle = doc.title ?? doc.fileName;
    final dir = Directory('$dirPath/zettel_${_slug(docTitle)}');
    try {
      dir.createSync(recursive: true);
      final files = <File>[];
      final indexLinks = <String>[];

      for (var i = 0; i < annotations.length; i++) {
        final annotation = annotations[i];
        final noteTitle =
            '${_slug(docTitle)}-p${annotation.pageNumber}-${i + 1}';
        final tags = _parseTags(annotation.tags);
        final buffer = StringBuffer()
          ..writeln('---')
          ..writeln('id: ${annotation.id}')
          ..writeln('page: ${annotation.pageNumber}')
          ..writeln('type: ${annotation.type}')
          ..writeln('tags: [${tags.join(', ')}]')
          ..writeln('source: "$docTitle"')
          ..writeln('---')
          ..writeln();
        if (annotation.selectedText != null) {
          buffer
            ..writeln('> ${annotation.selectedText}')
            ..writeln();
        }
        buffer
          ..writeln(annotation.content ?? '')
          ..writeln()
          ..writeln('[[$docTitle]] · p. ${annotation.pageNumber}');

        final file = File('${dir.path}/$noteTitle.md')
          ..writeAsStringSync(buffer.toString());
        files.add(file);
        indexLinks.add('- [[$noteTitle]] (p. ${annotation.pageNumber})');
      }

      final index = File('${dir.path}/$docTitle.md')
        ..writeAsStringSync(
          '# $docTitle\n\nNotas de leitura:\n\n${indexLinks.join('\n')}\n',
        );
      files.add(index);
      return Result.ok(files);
    } catch (e) {
      return Result.error(FileFailure('Falha ao exportar Zettelkasten: $e'));
    }
  }

  // ── Concept graph as JSON (docs/08_ROADMAP.md §4.2) ──

  Future<Result<File, Failure>> exportConceptGraphJson(String dirPath) async {
    final concepts = await _conceptDao.getByProject(_projectId);
    final relations = await _conceptDao.getRelations(_projectId);
    final json = const JsonEncoder.withIndent('  ').convert({
      'project': _projectName,
      'exported_at': DateTime.now().toIso8601String(),
      'concepts': [
        for (final c in concepts)
          {
            'id': c.id,
            'name': c.name,
            'definition': c.definition,
            'type': c.type,
            'source': c.source,
          },
      ],
      'relations': [
        for (final r in relations)
          {
            'source': r.sourceId,
            'target': r.targetId,
            'relation': r.relation,
            'description': r.description,
          },
      ],
    });
    return _writeFile('$dirPath/grafo_conceitos.json', json);
  }

  // ── Anki flashcards as CSV (docs/08_ROADMAP.md §4.2) ──

  static String ankiCsv(List<Map<String, dynamic>> cards) {
    String escape(String? value) =>
        '"${(value ?? '').replaceAll('"', '""')}"';
    final buffer = StringBuffer();
    for (final card in cards) {
      buffer.writeln(
        '${escape(card['front'] as String?)},'
        '${escape(card['back'] as String?)},'
        '${escape(card['type'] as String?)}',
      );
    }
    return buffer.toString();
  }

  // ── Helpers ──

  Result<File, Failure> _writeFile(String path, String content) {
    try {
      final file = File(path)
        ..parent.createSync(recursive: true)
        ..writeAsStringSync(content);
      return Result.ok(file);
    } catch (e) {
      return Result.error(FileFailure('Falha ao gravar $path: $e'));
    }
  }

  static List<String> _parseAuthors(String? raw) {
    if (raw == null || raw.trim().isEmpty) return const ['AUTOR DESCONHECIDO'];
    try {
      final decoded = jsonDecode(raw);
      if (decoded is List) return decoded.cast<String>();
    } on FormatException {
      // Plain string, not JSON.
    }
    return [raw];
  }

  static List<String> _parseTags(String? raw) {
    if (raw == null || raw.trim().isEmpty) return const [];
    try {
      final decoded = jsonDecode(raw);
      if (decoded is List) return decoded.cast<String>();
    } on FormatException {
      // Plain string, not JSON.
    }
    return [raw];
  }

  static String _abntName(String fullName) {
    final parts = fullName.trim().split(RegExp(r'\s+'));
    if (parts.length < 2) return fullName.toUpperCase();
    final last = parts.removeLast().toUpperCase();
    return '$last, ${parts.join(' ')}';
  }

  static String _apaName(String fullName) {
    final parts = fullName.trim().split(RegExp(r'\s+'));
    if (parts.length < 2) return fullName;
    final last = parts.removeLast();
    final initials = parts.map((p) => '${p[0].toUpperCase()}.').join(' ');
    return '$last, $initials';
  }

  static String _vancouverName(String fullName) {
    final parts = fullName.trim().split(RegExp(r'\s+'));
    if (parts.length < 2) return fullName;
    final last = parts.removeLast();
    final initials = parts.map((p) => p[0].toUpperCase()).join();
    return '$last $initials';
  }

  static String _slug(String text) => text
      .toLowerCase()
      .replaceAll(RegExp(r'[^\w\s-]'), '')
      .trim()
      .replaceAll(RegExp(r'\s+'), '-');
}
