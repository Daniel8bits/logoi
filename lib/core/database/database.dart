import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'daos/ai_dao.dart';
import 'daos/annotation_dao.dart';
import 'daos/chat_dao.dart';
import 'daos/concept_dao.dart';
import 'daos/document_dao.dart';
import 'daos/media_dao.dart';
import 'daos/project_dao.dart';
import 'daos/search_dao.dart';
import 'tables/ai_tables.dart';
import 'tables/annotation_tables.dart';
import 'tables/chat_tables.dart';
import 'tables/document_tables.dart';
import 'tables/knowledge_tables.dart';
import 'tables/media_tables.dart';
import 'tables/project_tables.dart';

part 'database.drift.dart';

/// Main Drift database. One instance per project file
/// (see docs/03_DATABASE.md §1), plus one global instance for
/// app-level AI provider configuration.
@DriftDatabase(
  tables: [
    Projects,
    Documents,
    PageContents,
    Paragraphs,
    ParagraphEmbeddings,
    DocumentStructure,
    SectionSummaries,
    Annotations,
    AnnotationVersions,
    Notebooks,
    Concepts,
    ConceptRelations,
    CrossReferences,
    ChatSessions,
    ChatMessages,
    AiProviders,
    AiResponseCache,
    ApiUsageLog,
    MediaReferenceCache,
    ReadingSessions,
  ],
  daos: [
    ProjectDao,
    DocumentDao,
    AnnotationDao,
    ChatDao,
    ConceptDao,
    AiDao,
    MediaDao,
    SearchDao,
  ],
)
class LogoiDatabase extends _$LogoiDatabase {
  LogoiDatabase(super.executor);

  /// Opens (or creates) a database at [filePath].
  factory LogoiDatabase.atPath(String filePath) {
    return LogoiDatabase(
      driftDatabase(
        name: 'logoi',
        native: DriftNativeOptions(databasePath: () async => filePath),
      ),
    );
  }

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await _createFtsTable();
          await _createIndices();
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );

  Future<void> _createFtsTable() async {
    // FTS5 external-content table synced with page_contents via triggers.
    await customStatement('''
      CREATE VIRTUAL TABLE IF NOT EXISTS page_contents_fts USING fts5(
        content,
        content='page_contents',
        content_rowid='rowid'
      )
    ''');
    await customStatement('''
      CREATE TRIGGER IF NOT EXISTS page_contents_ai AFTER INSERT ON page_contents BEGIN
        INSERT INTO page_contents_fts(rowid, content) VALUES (new.rowid, new.content);
      END
    ''');
    await customStatement('''
      CREATE TRIGGER IF NOT EXISTS page_contents_ad AFTER DELETE ON page_contents BEGIN
        INSERT INTO page_contents_fts(page_contents_fts, rowid, content)
          VALUES ('delete', old.rowid, old.content);
      END
    ''');
    await customStatement('''
      CREATE TRIGGER IF NOT EXISTS page_contents_au AFTER UPDATE ON page_contents BEGIN
        INSERT INTO page_contents_fts(page_contents_fts, rowid, content)
          VALUES ('delete', old.rowid, old.content);
        INSERT INTO page_contents_fts(rowid, content) VALUES (new.rowid, new.content);
      END
    ''');
  }

  Future<void> _createIndices() async {
    const statements = [
      'CREATE INDEX IF NOT EXISTS idx_documents_project ON documents(project_id)',
      'CREATE INDEX IF NOT EXISTS idx_page_contents_document ON page_contents(document_id, page_number)',
      'CREATE INDEX IF NOT EXISTS idx_paragraphs_document ON paragraphs(document_id, page_number)',
      'CREATE INDEX IF NOT EXISTS idx_embeddings_paragraph ON paragraph_embeddings(paragraph_id)',
      'CREATE INDEX IF NOT EXISTS idx_structure_document ON document_structure(document_id)',
      'CREATE INDEX IF NOT EXISTS idx_structure_parent ON document_structure(parent_id)',
      'CREATE INDEX IF NOT EXISTS idx_summaries_structure ON section_summaries(structure_id)',
      'CREATE INDEX IF NOT EXISTS idx_annotations_document ON annotations(document_id, page_number)',
      'CREATE INDEX IF NOT EXISTS idx_annotations_type ON annotations(document_id, type)',
      'CREATE INDEX IF NOT EXISTS idx_annotation_versions ON annotation_versions(annotation_id, changed_at)',
      'CREATE INDEX IF NOT EXISTS idx_notebooks_project ON notebooks(project_id)',
      'CREATE INDEX IF NOT EXISTS idx_notebooks_document ON notebooks(document_id)',
      'CREATE INDEX IF NOT EXISTS idx_concepts_project ON concepts(project_id)',
      'CREATE INDEX IF NOT EXISTS idx_relations_source ON concept_relations(source_id)',
      'CREATE INDEX IF NOT EXISTS idx_relations_target ON concept_relations(target_id)',
      'CREATE INDEX IF NOT EXISTS idx_crossrefs_source ON cross_references(source_doc_id, source_page)',
      'CREATE INDEX IF NOT EXISTS idx_crossrefs_target ON cross_references(target_doc_id, target_page)',
      'CREATE INDEX IF NOT EXISTS idx_sessions_project ON chat_sessions(project_id)',
      'CREATE INDEX IF NOT EXISTS idx_sessions_document ON chat_sessions(document_id)',
      'CREATE INDEX IF NOT EXISTS idx_messages_session ON chat_messages(session_id, created_at)',
      'CREATE INDEX IF NOT EXISTS idx_usage_project ON api_usage_log(project_id, called_at)',
      'CREATE INDEX IF NOT EXISTS idx_usage_feature ON api_usage_log(feature, called_at)',
      'CREATE INDEX IF NOT EXISTS idx_reading_document ON reading_sessions(document_id)',
    ];
    for (final sql in statements) {
      await customStatement(sql);
    }
  }
}
