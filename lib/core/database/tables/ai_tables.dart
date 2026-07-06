import 'package:drift/drift.dart';

import 'document_tables.dart';
import 'project_tables.dart';

/// See docs/03_DATABASE.md §3.16 — API keys live in flutter_secure_storage,
/// never in this table.
@DataClassName('AiProviderRow')
class AiProviders extends Table {
  /// 'openrouter' | 'openai' | 'anthropic' | 'google' | 'ollama'
  TextColumn get id => text()();
  TextColumn get name => text()();
  BoolColumn get isActive => boolean().withDefault(const Constant(false))();

  /// For Ollama or custom proxies.
  TextColumn get baseUrl => text().nullable()();

  /// JSON array: available/preferred models.
  TextColumn get models => text().nullable()();

  /// JSON: { temperature, maxTokens, ... }
  TextColumn get settings => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// See docs/03_DATABASE.md §3.17
@DataClassName('AiResponseCacheRow')
class AiResponseCache extends Table {
  TextColumn get id => text()();

  /// hash(mode + prompt_version + input_hash + model)
  TextColumn get cacheKey => text().unique()();
  TextColumn get inputHash => text()();
  TextColumn get aiMode => text()();
  TextColumn get promptVersion => text()();
  TextColumn get provider => text()();
  TextColumn get model => text()();
  TextColumn get response => text()();
  IntColumn get inputTokens => integer().nullable()();
  IntColumn get outputTokens => integer().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get lastUsedAt => integer()();
  IntColumn get useCount => integer().withDefault(const Constant(1))();

  @override
  Set<Column> get primaryKey => {id};
}

/// See docs/03_DATABASE.md §3.18
@DataClassName('ApiUsageLogRow')
class ApiUsageLog extends Table {
  TextColumn get id => text()();
  TextColumn get projectId =>
      text().nullable().references(Projects, #id, onDelete: KeyAction.setNull)();
  TextColumn get documentId =>
      text().nullable().references(Documents, #id, onDelete: KeyAction.setNull)();
  TextColumn get provider => text()();
  TextColumn get model => text()();

  /// 'summarize' | 'explain' | 'chat' | ...
  TextColumn get feature => text()();
  IntColumn get inputTokens => integer()();
  IntColumn get outputTokens => integer()();
  BoolColumn get cacheHit => boolean().withDefault(const Constant(false))();
  RealColumn get costUsd => real().nullable()();
  IntColumn get calledAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
