# Logoi — Schema do Banco de Dados

> Documento complementar a `01_OVERVIEW.md` e `02_ARCHITECTURE.md`

---

## 1. Estratégia de Persistência

- **Um arquivo `.db` por projeto** — permite backup, transferência e exclusão granular
- **ORM:** Drift (SQLite) com `drift_flutter` para desktop
- **FTS:** SQLite FTS5 para busca full-text
- **Embeddings:** armazenados como BLOB (float32 serializado)
- **JSON:** campos flexíveis armazenados como TEXT com JSON serializado, usando TypeConverters do Drift

---

## 2. Versionamento e Migrations

### 2.1 Regras

- Cada alteração de schema **incrementa** `schemaVersion` na classe do database
- Migrations são geradas via `dart run drift_dev make-migrations`
- **Testes obrigatórios:** todo schema version tem teste com `SchemaVerifier` garantindo upgrade de qualquer versão anterior
- Migrations rodam dentro de transações — falha = rollback completo
- Arquivos de migration e snapshots de schema são commitados no Git

### 2.2 Estrutura de Testes

```dart
// test/migrations/migration_test.dart
import 'package:drift_dev/api/migrations.dart';

final verifier = SchemaVerifier(GeneratedHelper());

void main() {
  test('upgrade from v1 to v2', () async {
    final connection = await verifier.startAt(1);
    await verifier.migrateAndValidate(connection, 2);
  });
}
```

---

## 3. Schema Completo

### 3.1 Projetos

```sql
CREATE TABLE projects (
  id          TEXT PRIMARY KEY,      -- UUID v4
  name        TEXT NOT NULL,
  description TEXT,
  area        TEXT,                  -- 'filosofia' | 'medicina' | 'direito' | 'computação' | ...
  language    TEXT DEFAULT 'pt-BR',  -- idioma padrão do projeto
  created_at  INTEGER NOT NULL,      -- Unix timestamp ms
  updated_at  INTEGER NOT NULL,
  settings    TEXT                   -- JSON: ProjectSettings serializado
);
```

**`settings` JSON schema:**
```json
{
  "defaultProvider": "openrouter",
  "defaultModel": "anthropic/claude-sonnet-4-6",
  "summaryProvider": "openrouter",
  "summaryModel": "anthropic/claude-haiku-4-5",
  "temperature": 0.7,
  "summaryDepth": 2,
  "autoExtractConcepts": false,
  "autoDetectCrossRefs": false,
  "maxApiRequestsPerHour": 30,
  "processOnlyWhenIdle": false
}
```

---

### 3.2 Documentos

```sql
CREATE TABLE documents (
  id                   TEXT PRIMARY KEY,
  project_id           TEXT NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
  file_name            TEXT NOT NULL,
  file_path            TEXT NOT NULL,          -- caminho absoluto local
  title                TEXT,
  authors              TEXT,                   -- JSON array: ["Author A", "Author B"]
  year                 INTEGER,
  total_pages          INTEGER,
  last_read_page       INTEGER DEFAULT 0,
  processing_status    TEXT DEFAULT 'imported', -- ver enum abaixo
  imported_at          INTEGER NOT NULL,
  metadata             TEXT                    -- JSON: metadados extras do PDF
);

CREATE INDEX idx_documents_project ON documents(project_id);
```

**`processing_status` valores:**
```
imported        — texto extraído, TOC disponível, leitura possível
segmented       — parágrafos e headings detectados
indexed         — embeddings gerados localmente
summarized      — resumos de seção prontos
fully_processed — hierarquia completa de resumos pronta
```

---

### 3.3 Conteúdo de Páginas

```sql
CREATE TABLE page_contents (
  id          TEXT PRIMARY KEY,
  document_id TEXT NOT NULL REFERENCES documents(id) ON DELETE CASCADE,
  page_number INTEGER NOT NULL,
  content     TEXT NOT NULL,
  source      TEXT DEFAULT 'extraction', -- 'extraction' | 'ocr'
  UNIQUE(document_id, page_number)
);

CREATE INDEX idx_page_contents_document ON page_contents(document_id, page_number);

-- FTS5 virtual table para busca full-text
CREATE VIRTUAL TABLE page_contents_fts USING fts5(
  content,
  content='page_contents',
  content_rowid='rowid'
);
```

---

### 3.4 Parágrafos Segmentados

```sql
CREATE TABLE paragraphs (
  id              TEXT PRIMARY KEY,
  document_id     TEXT NOT NULL REFERENCES documents(id) ON DELETE CASCADE,
  page_number     INTEGER NOT NULL,
  paragraph_index INTEGER NOT NULL,           -- ordem na página
  content         TEXT NOT NULL,
  compressed_text TEXT,                       -- após TextCompressor (gerado sob demanda)
  UNIQUE(document_id, page_number, paragraph_index)
);

CREATE INDEX idx_paragraphs_document ON paragraphs(document_id, page_number);
```

---

### 3.5 Embeddings de Parágrafos

```sql
CREATE TABLE paragraph_embeddings (
  id            TEXT PRIMARY KEY,
  paragraph_id  TEXT NOT NULL REFERENCES paragraphs(id) ON DELETE CASCADE,
  embedding     BLOB NOT NULL,               -- float32[] serializado
  model         TEXT NOT NULL,               -- 'nomic-embed-text'
  dimensions    INTEGER NOT NULL,            -- 768 para nomic-embed-text
  created_at    INTEGER NOT NULL
);

CREATE INDEX idx_embeddings_paragraph ON paragraph_embeddings(paragraph_id);
```

---

### 3.6 Estrutura do Documento (Hierárquica)

```sql
CREATE TABLE document_structure (
  id                TEXT PRIMARY KEY,
  document_id       TEXT NOT NULL REFERENCES documents(id) ON DELETE CASCADE,
  parent_id         TEXT REFERENCES document_structure(id) ON DELETE CASCADE,
  level             INTEGER NOT NULL,         -- 1=seção, 2=capítulo, 3=documento
  title             TEXT,
  page_start        INTEGER NOT NULL,
  page_end          INTEGER NOT NULL,
  order_index       INTEGER NOT NULL,         -- posição entre siblings
  processing_status TEXT DEFAULT 'pending'
  -- pending | compressing | compressed | summarizing | done
);

CREATE INDEX idx_structure_document ON document_structure(document_id);
CREATE INDEX idx_structure_parent ON document_structure(parent_id);
```

---

### 3.7 Resumos Gerados

```sql
CREATE TABLE section_summaries (
  id              TEXT PRIMARY KEY,
  structure_id    TEXT NOT NULL REFERENCES document_structure(id) ON DELETE CASCADE,
  compressed_text TEXT,                       -- texto após pipeline de compressão
  summary         TEXT,                       -- resumo gerado pela IA
  key_concepts    TEXT,                       -- JSON array: ["conceito1", "conceito2"]
  input_tokens    INTEGER,
  output_tokens   INTEGER,
  provider        TEXT,                       -- qual provider gerou
  model           TEXT,
  prompt_version  TEXT,                       -- versão do prompt usado (para invalidação)
  generated_at    INTEGER,
  cache_hash      TEXT                        -- SHA-256 do compressed_text
);

CREATE INDEX idx_summaries_structure ON section_summaries(structure_id);
```

---

### 3.8 Anotações

```sql
CREATE TABLE annotations (
  id            TEXT PRIMARY KEY,
  document_id   TEXT NOT NULL REFERENCES documents(id) ON DELETE CASCADE,
  page_number   INTEGER NOT NULL,
  type          TEXT NOT NULL,                -- 'highlight' | 'note' | 'bookmark' | 'question'
  color         TEXT,                         -- hex: '#FFEB3B'
  selected_text TEXT,                         -- texto original selecionado
  content       TEXT,                         -- conteúdo Markdown da anotação
  position      TEXT NOT NULL,                -- JSON: SelectionPosition
  tags          TEXT,                         -- JSON array: ["tag1", "tag2"]
  created_at    INTEGER NOT NULL,
  updated_at    INTEGER NOT NULL
);

CREATE INDEX idx_annotations_document ON annotations(document_id, page_number);
CREATE INDEX idx_annotations_type ON annotations(document_id, type);
```

**`position` JSON schema:**
```json
{
  "startOffset": 120,
  "endOffset": 245,
  "rects": [
    {"x": 72.0, "y": 340.5, "width": 200.0, "height": 14.0}
  ]
}
```

---

### 3.9 Versões de Anotações

```sql
CREATE TABLE annotation_versions (
  id            TEXT PRIMARY KEY,
  annotation_id TEXT NOT NULL REFERENCES annotations(id) ON DELETE CASCADE,
  content       TEXT NOT NULL,                -- snapshot do Markdown naquele momento
  changed_at    INTEGER NOT NULL
);

CREATE INDEX idx_annotation_versions ON annotation_versions(annotation_id, changed_at);
```

---

### 3.10 Cadernos (Notebooks)

```sql
CREATE TABLE notebooks (
  id          TEXT PRIMARY KEY,
  project_id  TEXT NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
  document_id TEXT REFERENCES documents(id) ON DELETE SET NULL,  -- null = caderno do projeto
  title       TEXT NOT NULL,
  content     TEXT NOT NULL DEFAULT '',       -- Markdown livre
  created_at  INTEGER NOT NULL,
  updated_at  INTEGER NOT NULL
);

CREATE INDEX idx_notebooks_project ON notebooks(project_id);
CREATE INDEX idx_notebooks_document ON notebooks(document_id);
```

---

### 3.11 Conceitos

```sql
CREATE TABLE concepts (
  id          TEXT PRIMARY KEY,
  project_id  TEXT NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
  name        TEXT NOT NULL,
  definition  TEXT,
  type        TEXT,                           -- 'theoretical' | 'methodological' | 'empirical' | 'person' | 'event' | 'place'
  source      TEXT NOT NULL,                  -- 'user' | 'ai'
  created_at  INTEGER NOT NULL
);

CREATE INDEX idx_concepts_project ON concepts(project_id);
```

---

### 3.12 Relações entre Conceitos

```sql
CREATE TABLE concept_relations (
  id          TEXT PRIMARY KEY,
  project_id  TEXT NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
  source_id   TEXT NOT NULL REFERENCES concepts(id) ON DELETE CASCADE,
  target_id   TEXT NOT NULL REFERENCES concepts(id) ON DELETE CASCADE,
  relation    TEXT NOT NULL,                  -- 'defines' | 'contradicts' | 'supports' | 'exemplifies' | 'precedes'
  description TEXT,
  created_at  INTEGER NOT NULL,
  UNIQUE(source_id, target_id, relation)
);

CREATE INDEX idx_relations_source ON concept_relations(source_id);
CREATE INDEX idx_relations_target ON concept_relations(target_id);
```

---

### 3.13 Referências Cruzadas

```sql
CREATE TABLE cross_references (
  id              TEXT PRIMARY KEY,
  project_id      TEXT NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
  source_doc_id   TEXT NOT NULL REFERENCES documents(id) ON DELETE CASCADE,
  source_page     INTEGER NOT NULL,
  source_text     TEXT NOT NULL,
  target_doc_id   TEXT NOT NULL REFERENCES documents(id) ON DELETE CASCADE,
  target_page     INTEGER NOT NULL,
  target_text     TEXT NOT NULL,
  relation_type   TEXT NOT NULL,              -- 'corroborates' | 'contradicts' | 'extends' | 'cites' | 'exemplifies'
  confidence      REAL,                       -- 0.0 a 1.0 (null se manual)
  source_origin   TEXT NOT NULL DEFAULT 'user', -- 'user' | 'ai'
  created_at      INTEGER NOT NULL
);

CREATE INDEX idx_crossrefs_source ON cross_references(source_doc_id, source_page);
CREATE INDEX idx_crossrefs_target ON cross_references(target_doc_id, target_page);
```

---

### 3.14 Sessões de Chat

```sql
CREATE TABLE chat_sessions (
  id          TEXT PRIMARY KEY,
  project_id  TEXT NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
  document_id TEXT REFERENCES documents(id) ON DELETE SET NULL,  -- null = sessão do projeto
  title       TEXT,
  provider    TEXT NOT NULL,
  model       TEXT NOT NULL,
  created_at  INTEGER NOT NULL
);

CREATE INDEX idx_sessions_project ON chat_sessions(project_id);
CREATE INDEX idx_sessions_document ON chat_sessions(document_id);
```

---

### 3.15 Mensagens de Chat

```sql
CREATE TABLE chat_messages (
  id          TEXT PRIMARY KEY,
  session_id  TEXT NOT NULL REFERENCES chat_sessions(id) ON DELETE CASCADE,
  role        TEXT NOT NULL,                  -- 'user' | 'assistant' | 'system'
  content     TEXT NOT NULL,
  context     TEXT,                           -- JSON: { selectedText, pageNumber, selectionLevel }
  is_compressed INTEGER DEFAULT 0,           -- 1 se é resumo de mensagens antigas
  created_at  INTEGER NOT NULL
);

CREATE INDEX idx_messages_session ON chat_messages(session_id, created_at);
```

---

### 3.16 Configuração de Providers de IA

```sql
CREATE TABLE ai_providers (
  id         TEXT PRIMARY KEY,               -- 'openrouter' | 'openai' | 'anthropic' | 'google' | 'ollama'
  name       TEXT NOT NULL,
  is_active  INTEGER DEFAULT 0,
  base_url   TEXT,                           -- para Ollama ou proxies customizados
  models     TEXT,                           -- JSON array: modelos disponíveis/preferidos
  settings   TEXT                            -- JSON: { temperature, maxTokens, ... }
);
```

> **Nota:** API keys **não** são armazenadas nesta tabela. São gerenciadas via `flutter_secure_storage` separadamente.

---

### 3.17 Cache de Respostas de IA

```sql
CREATE TABLE ai_response_cache (
  id             TEXT PRIMARY KEY,
  cache_key      TEXT NOT NULL UNIQUE,        -- hash(mode + prompt_version + input_hash + model)
  input_hash     TEXT NOT NULL,               -- SHA-256 do texto enviado
  ai_mode        TEXT NOT NULL,               -- 'explain' | 'summarize' | 'flashcards' | ...
  prompt_version TEXT NOT NULL,               -- versão do template de prompt
  provider       TEXT NOT NULL,
  model          TEXT NOT NULL,
  response       TEXT NOT NULL,
  input_tokens   INTEGER,
  output_tokens  INTEGER,
  created_at     INTEGER NOT NULL,
  last_used_at   INTEGER NOT NULL,
  use_count      INTEGER DEFAULT 1
);
```

---

### 3.18 Log de Uso de API

```sql
CREATE TABLE api_usage_log (
  id            TEXT PRIMARY KEY,
  project_id    TEXT REFERENCES projects(id) ON DELETE SET NULL,
  document_id   TEXT REFERENCES documents(id) ON DELETE SET NULL,
  provider      TEXT NOT NULL,
  model         TEXT NOT NULL,
  feature       TEXT NOT NULL,                -- 'summarize' | 'explain' | 'chat' | ...
  input_tokens  INTEGER NOT NULL,
  output_tokens INTEGER NOT NULL,
  cache_hit     INTEGER DEFAULT 0,           -- 1 se veio do cache
  cost_usd      REAL,                        -- custo estimado (se disponível do provider)
  called_at     INTEGER NOT NULL
);

CREATE INDEX idx_usage_project ON api_usage_log(project_id, called_at);
CREATE INDEX idx_usage_feature ON api_usage_log(feature, called_at);
```

---

### 3.19 Sessões de Leitura

```sql
CREATE TABLE reading_sessions (
  id          TEXT PRIMARY KEY,
  document_id TEXT NOT NULL REFERENCES documents(id) ON DELETE CASCADE,
  start_page  INTEGER NOT NULL,
  end_page    INTEGER NOT NULL,
  duration_s  INTEGER,                       -- segundos de leitura ativa
  started_at  INTEGER NOT NULL,
  ended_at    INTEGER
);

CREATE INDEX idx_reading_document ON reading_sessions(document_id);
```

**Cleanup de sessões órfãs:** no startup, fechar automaticamente qualquer sessão onde `ended_at IS NULL` e `started_at < now() - 4 horas`.

---

## 4. Diagrama de Relacionamentos

```
projects ─┬─< documents ─┬─< page_contents
           │               ├─< paragraphs ──< paragraph_embeddings
           │               ├─< annotations ──< annotation_versions
           │               ├─< document_structure ──< section_summaries
           │               ├─< reading_sessions
           │               └─< notebooks (optional)
           ├─< concepts ──< concept_relations
           ├─< cross_references
           ├─< chat_sessions ──< chat_messages
           └─< notebooks (project-level)

ai_providers        (global, não por projeto)
ai_response_cache   (por projeto, via cache_key)
api_usage_log       (por projeto, auditoria)
```

---

## 5. Resumo de Tabelas

| # | Tabela | Registros estimados (livro 300pg) | CASCADE de |
|---|---|---|---|
| 1 | `projects` | 1 | — |
| 2 | `documents` | 1-10 | `projects` |
| 3 | `page_contents` | 300 | `documents` |
| 4 | `paragraphs` | ~3.000 | `documents` |
| 5 | `paragraph_embeddings` | ~3.000 | `paragraphs` |
| 6 | `document_structure` | ~60 | `documents` |
| 7 | `section_summaries` | ~60 | `document_structure` |
| 8 | `annotations` | ~50-500 | `documents` |
| 9 | `annotation_versions` | ~100-1.000 | `annotations` |
| 10 | `notebooks` | ~5-20 | `projects` / `documents` |
| 11 | `concepts` | ~20-200 | `projects` |
| 12 | `concept_relations` | ~30-400 | `concepts` |
| 13 | `cross_references` | ~10-100 | `documents` |
| 14 | `chat_sessions` | ~5-30 | `projects` |
| 15 | `chat_messages` | ~50-500 | `chat_sessions` |
| 16 | `ai_providers` | 5 | — |
| 17 | `ai_response_cache` | ~100-1.000 | — |
| 18 | `api_usage_log` | ~200-2.000 | `projects` |
| 19 | `reading_sessions` | ~20-100 | `documents` |
