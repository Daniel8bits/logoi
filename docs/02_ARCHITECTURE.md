# Logoi — Arquitetura de Software

> Documento complementar a `01_OVERVIEW.md`

---

## 1. Estrutura de Pastas

```
logoi/
├── lib/
│   ├── main.dart
│   ├── app.dart                    # MaterialApp, tema, roteamento
│   ├── core/
│   │   ├── database/
│   │   │   ├── database.dart       # Drift database principal
│   │   │   ├── tables/             # Definições de tabelas Drift
│   │   │   ├── daos/               # Data Access Objects
│   │   │   ├── converters/         # TypeConverters Drift (JSON, enums)
│   │   │   └── migrations/         # Migration steps gerados por drift_dev
│   │   ├── ai/
│   │   │   ├── provider.dart       # Interface abstrata AIProvider
│   │   │   ├── providers/          # OpenRouterProvider, DirectAPIProvider, OllamaProvider
│   │   │   ├── router.dart         # AIRouter — resolve qual provider usar por tarefa
│   │   │   ├── context.dart        # AIRequestContext
│   │   │   ├── prompts/            # Templates de prompt como constantes Dart
│   │   │   ├── response_parser.dart # JSONResponseParser com fallback chain
│   │   │   └── errors.dart         # AIError sealed class
│   │   ├── pdf/
│   │   │   ├── extractor.dart      # Extração de texto e metadados via pdfrx
│   │   │   ├── segmenter.dart      # Segmentação em parágrafos/sentenças
│   │   │   └── structure.dart      # Detecção de headings, TOC
│   │   ├── processing/
│   │   │   ├── pipeline.dart       # Pipeline de importação orquestrador
│   │   │   ├── compressor.dart     # TextCompressor — compressão pré-API
│   │   │   ├── summarizer.dart     # Hierarquia de resumos map-reduce
│   │   │   ├── embeddings.dart     # Geração de embeddings via Ollama
│   │   │   ├── rag.dart            # RAGContextBuilder
│   │   │   └── queue.dart          # BackgroundProcessingQueue
│   │   ├── search/
│   │   │   ├── fts_search.dart     # Busca FTS5
│   │   │   ├── semantic_search.dart # Busca por similaridade cosseno
│   │   │   └── hybrid_search.dart  # Fusão FTS + semântica
│   │   ├── cache/
│   │   │   ├── ai_cache.dart       # AICacheStrategy
│   │   │   └── history_compressor.dart # ChatHistoryCompressor
│   │   └── services/
│   │       ├── ollama_service.dart  # Cliente Ollama, detecção, health check
│   │       ├── file_service.dart    # File picker, path provider
│   │       ├── secure_storage.dart  # Wrapper para flutter_secure_storage
│   │       └── hotkey_service.dart  # Atalhos de teclado
│   ├── features/
│   │   ├── project/
│   │   │   ├── models/
│   │   │   ├── providers/          # Riverpod providers
│   │   │   ├── repositories/       # Acesso ao DAO, lógica de negócio
│   │   │   └── widgets/            # Tela de projetos, cards, formulários
│   │   ├── reader/
│   │   │   ├── models/
│   │   │   ├── providers/
│   │   │   ├── repositories/
│   │   │   └── widgets/            # Visualizador PDF, seleção, overlays
│   │   ├── annotations/
│   │   │   ├── models/
│   │   │   ├── providers/
│   │   │   ├── repositories/
│   │   │   └── widgets/            # Editor Markdown, lista, filtros
│   │   ├── notebook/
│   │   │   ├── models/
│   │   │   ├── providers/
│   │   │   ├── repositories/
│   │   │   └── widgets/            # Caderno de notas, fichamentos
│   │   ├── chat/
│   │   │   ├── models/
│   │   │   ├── providers/
│   │   │   ├── repositories/
│   │   │   └── widgets/            # Chatbot, streaming, contexto
│   │   ├── concept_map/
│   │   │   ├── models/
│   │   │   ├── providers/
│   │   │   ├── repositories/
│   │   │   └── widgets/            # Grafo interativo, canvas
│   │   ├── document_map/
│   │   │   ├── models/
│   │   │   ├── providers/
│   │   │   ├── repositories/
│   │   │   └── widgets/            # TOC, mapa estrutural
│   │   ├── search/
│   │   │   ├── models/
│   │   │   ├── providers/
│   │   │   ├── repositories/
│   │   │   └── widgets/            # Busca, resultados, filtros
│   │   ├── export/
│   │   │   ├── models/
│   │   │   ├── providers/
│   │   │   ├── repositories/
│   │   │   └── widgets/            # Exportação Markdown, Anki, bib
│   │   └── settings/
│   │       ├── models/
│   │       ├── providers/
│   │       ├── repositories/
│   │       └── widgets/            # Configurações, providers IA, temas
│   └── shared/
│       ├── widgets/                # Componentes reutilizáveis
│       ├── theme/                  # Design tokens, tipografia, cores
│       ├── extensions/             # Extension methods
│       ├── constants/              # Constantes globais
│       └── utils/                  # Formatadores, helpers
├── assets/
│   ├── fonts/
│   └── icons/
├── test/
│   ├── unit/
│   ├── widget/
│   ├── integration/
│   └── migrations/                 # Testes de migration Drift (SchemaVerifier)
└── docs/                           # Estes documentos de especificação
```

---

## 2. Padrões Arquiteturais

### 2.1 Feature-First

Cada feature é um módulo independente com 4 camadas:

```
feature/
├── models/        ← Data classes, enums, DTOs (Dart puro, sem imports de Flutter)
├── providers/     ← Riverpod providers (estado + lógica de UI)
├── repositories/  ← Acesso a DAOs, chamadas de IA, lógica de negócio
└── widgets/       ← Widgets Flutter (UI)
```

**Regras:**
- Widgets só acessam dados via `ref.watch(provider)` — nunca chamam repositórios diretamente
- Repositories recebem DAOs e services injetados via Riverpod — nunca instanciam dependências
- Models são imutáveis (usar `freezed` ou `@immutable`)
- Comunicação entre features acontece via providers compartilhados, nunca por imports cruzados de widgets

### 2.2 Estado com Riverpod

```dart
// Provider simples — dados read-only
@riverpod
Future<List<Project>> projectList(Ref ref) async {
  return ref.watch(projectRepositoryProvider).getAll();
}

// Notifier — estado mutável com ações
@riverpod
class AnnotationEditor extends _$AnnotationEditor {
  @override
  AnnotationEditorState build(String annotationId) => AnnotationEditorState.initial();

  Future<void> save(String markdownContent) async { /* ... */ }
  void undo() { /* ... */ }
}
```

### 2.3 Tratamento de Erros

Repositories nunca lançam exceções. Usam `Result<T, Failure>`:

```dart
sealed class Failure {
  const Failure(this.message);
  final String message;
}

class DatabaseFailure extends Failure { /* ... */ }
class AIFailure extends Failure { /* ... */ }
class FileFailure extends Failure { /* ... */ }

// Uso no repository:
Future<Result<Document, Failure>> importPdf(String path) async {
  try {
    final doc = await _extractor.extract(path);
    await _dao.insert(doc);
    return Result.ok(doc);
  } catch (e) {
    return Result.error(FileFailure('Falha ao importar: $e'));
  }
}
```

### 2.4 Injeção de Dependências

Toda dependência é provida via Riverpod:

```dart
@riverpod
ProjectRepository projectRepository(Ref ref) {
  return ProjectRepository(
    dao: ref.watch(projectDaoProvider),
    aiRouter: ref.watch(aiRouterProvider),
  );
}
```

---

## 3. Fluxo de Dados

```
┌──────────┐     ┌──────────────┐     ┌──────────────┐     ┌──────────┐
│  Widget   │────▶│   Provider   │────▶│  Repository  │────▶│   DAO    │
│           │◀────│  (Riverpod)  │◀────│              │◀────│ (Drift)  │
└──────────┘     └──────────────┘     └──────────────┘     └──────────┘
                                              │
                                              ▼
                                      ┌──────────────┐
                                      │  AIRouter /   │
                                      │  Services     │
                                      └──────────────┘
```

- **Widget → Provider:** `ref.watch()` para dados reativos, `ref.read()` para ações
- **Provider → Repository:** chamadas assíncronas que retornam `Result<T, Failure>`
- **Repository → DAO:** CRUD no SQLite via Drift
- **Repository → AIRouter:** chamadas de IA roteadas pelo `AIRouter` para o provider correto
- **Repository → Services:** operações de sistema (file picker, secure storage, Ollama)

---

## 4. Comunicação com IA

### 4.1 AIRouter — O Roteador Central

O `AIRouter` é o ponto único de entrada para qualquer chamada de IA no app. Ele resolve qual provider usar baseado na configuração do usuário e no tipo de tarefa.

```dart
class AIRouter {
  /// Resolve o provider correto para a tarefa solicitada.
  /// Ordem de resolução:
  /// 1. Override explícito do usuário para esta tarefa
  /// 2. Provider padrão do projeto
  /// 3. Provider padrão global
  AIProvider resolveProvider(AITask task);

  /// Stream para respostas em tempo real (chat, explicar)
  Stream<String> stream({
    required AITask task,
    required List<ChatMessage> messages,
    required AIRequestContext context,
  });

  /// Future para respostas completas (resumos batch, flashcards)
  Future<Result<String, AIFailure>> complete({
    required AITask task,
    required List<ChatMessage> messages,
    required AIRequestContext context,
  });
}

enum AITask {
  chat,
  explain,
  summarize,
  socratic,
  argueAgainst,
  historicalContext,
  flashcards,
  argumentMap,
  biasDetection,
  conceptExtraction,
  crossReference,
  documentMap,
  sectionSummary,
  chapterSummary,
  documentSummary,
  historyCompression,
}
```

### 4.2 Interface AIProvider

```dart
abstract class AIProvider {
  String get id;           // 'openrouter', 'openai', 'anthropic', 'google', 'ollama'
  String get displayName;
  String get model;

  /// Resposta em streaming (chat, explicações)
  Stream<String> streamCompletion({
    required List<ChatMessage> messages,
    double temperature = 0.7,
    int maxTokens = 2048,
    Map<String, dynamic>? responseFormat,  // para structured outputs
  });

  /// Resposta completa (operações batch)
  Future<String> complete({
    required List<ChatMessage> messages,
    double temperature = 0.3,
    int maxTokens = 4096,
    Map<String, dynamic>? responseFormat,
  });

  /// Verifica se o provider está configurado e acessível
  Future<bool> isAvailable();

  /// Lista modelos disponíveis (para OpenRouter, lista do API; para Ollama, modelos instalados)
  Future<List<AIModel>> listModels();
}
```

> **Nota:** `embed()` **não** faz parte desta interface. Embeddings são responsabilidade exclusiva do `OllamaService`, pois sempre rodam localmente.

### 4.3 Implementações de Provider

```
AIProvider (interface abstrata)
├── OpenRouterProvider     ← POST https://openrouter.ai/api/v1/chat/completions
├── DirectOpenAIProvider   ← POST https://api.openai.com/v1/chat/completions
├── DirectAnthropicProvider ← POST https://api.anthropic.com/v1/messages
├── DirectGoogleProvider   ← Gemini API
└── OllamaProvider         ← POST http://localhost:11434/api/chat
```

Todos os providers usam o pacote `http` do Dart diretamente — **sem `langchain_dart`**. A API do OpenRouter é compatível com o formato OpenAI, então `OpenRouterProvider` e `DirectOpenAIProvider` compartilham a maior parte da lógica HTTP.

---

## 5. Processamento em Background

### 5.1 Isolates

Tarefas pesadas rodam em Dart Isolates para não bloquear a UI:

- Extração de texto do PDF
- Segmentação de parágrafos
- Geração de embeddings
- Pipeline de compressão de texto

### 5.2 Fila de Prioridades

```dart
enum ProcessingPriority {
  p0_extraction,      // Extração de texto (bloqueia visualização)
  p1_segmentation,    // Segmentação (habilita seleção granular)
  p2_currentEmbeddings, // Embeddings da seção atual (habilita RAG)
  p3_adjacentEmbeddings, // Embeddings das seções adjacentes
  p4_visitedSummaries, // Resumos das seções visitadas
  p5_remainingEmbeddings, // Embeddings do resto do documento
  p6_unvisitedSummaries, // Resumos das seções não visitadas
}
```

O app é **totalmente utilizável** a partir do momento em que P0 completa. Cada nível seguinte habilita features adicionais progressivamente.

---

## 6. Segurança

### 6.1 API Keys

- Armazenadas via `flutter_secure_storage` (usa Keychain no macOS, Credential Manager no Windows, libsecret no Linux)
- **Nunca** persistidas em SQLite, SharedPreferences, ou arquivos de texto
- Em memória apenas durante a execução do app

### 6.2 Dados do Usuário

- Todos os dados ficam locais — o app nunca envia dados para servidores próprios
- Requisições são feitas diretamente às APIs configuradas pelo usuário
- Opção de usar Ollama para uso completamente offline e privado
- Builds de produção usam `--obfuscate` para dificultar reverse engineering
