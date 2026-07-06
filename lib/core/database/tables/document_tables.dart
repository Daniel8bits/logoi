import 'package:drift/drift.dart';

import 'project_tables.dart';

/// See docs/03_DATABASE.md §3.2
@DataClassName('DocumentRow')
class Documents extends Table {
  TextColumn get id => text()();
  TextColumn get projectId =>
      text().references(Projects, #id, onDelete: KeyAction.cascade)();
  TextColumn get fileName => text()();
  TextColumn get filePath => text()();
  TextColumn get title => text().nullable()();

  /// JSON array: ["Author A", "Author B"]
  TextColumn get authors => text().nullable()();
  IntColumn get year => integer().nullable()();
  IntColumn get totalPages => integer().nullable()();
  IntColumn get lastReadPage => integer().withDefault(const Constant(0))();

  /// imported | segmented | indexed | summarized | fully_processed
  TextColumn get processingStatus =>
      text().withDefault(const Constant('imported'))();
  IntColumn get importedAt => integer()();
  TextColumn get metadata => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// See docs/03_DATABASE.md §3.3
@DataClassName('PageContentRow')
class PageContents extends Table {
  TextColumn get id => text()();
  TextColumn get documentId =>
      text().references(Documents, #id, onDelete: KeyAction.cascade)();
  IntColumn get pageNumber => integer()();
  TextColumn get content => text()();

  /// 'extraction' | 'ocr'
  TextColumn get source => text().withDefault(const Constant('extraction'))();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
        {documentId, pageNumber},
      ];
}

/// See docs/03_DATABASE.md §3.4
@DataClassName('ParagraphRow')
class Paragraphs extends Table {
  TextColumn get id => text()();
  TextColumn get documentId =>
      text().references(Documents, #id, onDelete: KeyAction.cascade)();
  IntColumn get pageNumber => integer()();
  IntColumn get paragraphIndex => integer()();
  TextColumn get content => text()();

  /// Generated on demand by TextCompressor.
  TextColumn get compressedText => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
        {documentId, pageNumber, paragraphIndex},
      ];
}

/// See docs/03_DATABASE.md §3.5
@DataClassName('ParagraphEmbeddingRow')
class ParagraphEmbeddings extends Table {
  TextColumn get id => text()();
  TextColumn get paragraphId =>
      text().references(Paragraphs, #id, onDelete: KeyAction.cascade)();

  /// float32[] serialized.
  BlobColumn get embedding => blob()();
  TextColumn get model => text()();
  IntColumn get dimensions => integer()();
  IntColumn get createdAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

/// See docs/03_DATABASE.md §3.6 — hierarchical structure (sections/chapters).
@DataClassName('StructureRow')
class DocumentStructure extends Table {
  @override
  String get tableName => 'document_structure';

  TextColumn get id => text()();
  TextColumn get documentId =>
      text().references(Documents, #id, onDelete: KeyAction.cascade)();
  TextColumn get parentId => text()
      .nullable()
      .references(DocumentStructure, #id, onDelete: KeyAction.cascade)();

  /// 1=section, 2=chapter, 3=document
  IntColumn get level => integer()();
  TextColumn get title => text().nullable()();
  IntColumn get pageStart => integer()();
  IntColumn get pageEnd => integer()();
  IntColumn get orderIndex => integer()();

  /// pending | compressing | compressed | summarizing | done
  TextColumn get processingStatus =>
      text().withDefault(const Constant('pending'))();

  @override
  Set<Column> get primaryKey => {id};
}

/// See docs/03_DATABASE.md §3.7
@DataClassName('SectionSummaryRow')
class SectionSummaries extends Table {
  TextColumn get id => text()();
  TextColumn get structureId =>
      text().references(DocumentStructure, #id, onDelete: KeyAction.cascade)();
  TextColumn get compressedText => text().nullable()();
  TextColumn get summary => text().nullable()();

  /// JSON array: ["concept1", "concept2"]
  TextColumn get keyConcepts => text().nullable()();
  IntColumn get inputTokens => integer().nullable()();
  IntColumn get outputTokens => integer().nullable()();
  TextColumn get provider => text().nullable()();
  TextColumn get model => text().nullable()();
  TextColumn get promptVersion => text().nullable()();
  IntColumn get generatedAt => integer().nullable()();

  /// SHA-256 of compressed_text.
  TextColumn get cacheHash => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// See docs/03_DATABASE.md §3.19
@DataClassName('ReadingSessionRow')
class ReadingSessions extends Table {
  TextColumn get id => text()();
  TextColumn get documentId =>
      text().references(Documents, #id, onDelete: KeyAction.cascade)();
  IntColumn get startPage => integer()();
  IntColumn get endPage => integer()();
  IntColumn get durationS => integer().nullable()();
  IntColumn get startedAt => integer()();
  IntColumn get endedAt => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
