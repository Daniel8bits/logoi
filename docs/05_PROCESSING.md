# Logoi — Pipeline de Processamento

> Documento complementar a `01_OVERVIEW.md`, `02_ARCHITECTURE.md` e `04_AI_LAYER.md`
> Cobre: taxonomia de execução, pipeline de importação, compressão de contexto,
> hierarquia de resumos (map-reduce), RAG local e estratégias de cache

---

## 1. Princípio Central

**Nenhuma chamada de API deve ser feita com texto bruto de um documento.**

Todo texto passa por um pipeline de preparação antes de chegar a qualquer LLM externo.
O objetivo é maximizar informação útil por token enviado, minimizando custo e latência.

---

## 2. Taxonomia de Execução

Cada feature é classificada em um dos quatro níveis. A regra é sempre usar o nível mais barato que entrega qualidade suficiente.

```
Nível 1 — Determinístico   →  custo zero, resultado previsível
Nível 2 — Heurístico       →  custo zero, resultado probabilístico local
Nível 3 — IA local         →  custo de CPU, sem API, privado
Nível 4 — API externa      →  custo por token, reservado ao que só LLM faz bem
```

### 2.1 Mapa Completo

```
NÍVEL 1 — DETERMINÍSTICO (custo zero)
────────────────────────────────────────────────────────────────
Feature                            Técnica
Extração de TOC                    Parser de estrutura do PDF (pdfrx)
Navegação e contagem de páginas    API do pdfrx
Highlights e anotações             CRUD SQLite + Markdown
Progresso de leitura               Contadores SQLite
Busca FTS5                         SQLite fts5 virtual table
Cruzamento de referências manual   Persistência de ponteiros (doc+página)
Exportação de citações             Template + metadados do PDF
Detecção de idioma                 Biblioteca local
Extração de referências bib.       Regex + heurísticas de formato
Versionamento de anotações         Snapshots SQLite

NÍVEL 2 — HEURÍSTICO (custo zero)
────────────────────────────────────────────────────────────────
Feature                            Técnica
Segmentação em parágrafos          Análise de espaçamento vertical (pdfrx)
Segmentação em sentenças           Regex + regras de pontuação por idioma
Detecção de nível de heading       Tamanho de fonte + negrito + posição Y
Estimativa de área do documento    Frequência de termos vs. wordlists de domínio
Mapa estrutural básico             TOC + hierarquia de headings sem IA
Boundary de seleção granular       Posição do cursor + segmentação local
Compressão de texto pré-API        Pipeline de limpeza determinístico (ver §4)
Detecção de rodapés/notas          Posição Y + tamanho de fonte menor

NÍVEL 3 — IA LOCAL (Ollama, custo de CPU)
────────────────────────────────────────────────────────────────
Feature                            Modelo            RAM
Embeddings de parágrafos           nomic-embed-text   ~270MB
Busca semântica (cosseno local)    nomic-embed-text   ~270MB
Cruzamento semântico entre docs    nomic-embed-text   ~270MB
Agrupamento de conceitos           nomic-embed-text   ~270MB

NÍVEL 4 — API EXTERNA (custo por token)
────────────────────────────────────────────────────────────────
Feature                            Escopo         Provider
Resumos de seção (map-reduce)      Batch/bg       Modelo barato (config do usuário)
Resumos de capítulo                Batch/bg       Modelo barato (config do usuário)
Resumo geral do livro              Uma chamada    Modelo barato (config do usuário)
Explicar trecho                    On-demand      Provider do usuário
Modo socrático                     On-demand      Provider do usuário
Contra-argumentação                On-demand      Provider do usuário
Linha do argumento                 On-demand      Provider do usuário
Detector de viés                   On-demand      Provider do usuário
Extração de conceitos              On-demand      Provider do usuário
Flashcards                         On-demand      Provider do usuário
Chat / RAG                         On-demand      Provider do usuário
Fichamento final                   Uma chamada    Provider do usuário
```

---

## 3. Pipeline de Importação

Executado em background ao importar um PDF. Cada etapa persiste resultados no SQLite para que interrupções não exijam reprocessamento.

```
PDF importado
     │
     ▼
[ETAPA 1 — Determinístico]
Extração de texto bruto por página (pdfrx)
Extração de TOC e metadados
Persistência em page_contents + documents
Status: imported
     │
     ▼
[ETAPA 2 — Heurístico]
Segmentação em parágrafos e sentenças
Detecção de headings e seus níveis
Identificação de rodapés, notas, referências bib.
Detecção de idioma
Construção do mapa estrutural básico (TOC + headings)
Persistência em paragraphs + document_structure
Status: segmented
     │
     ▼
[ETAPA 3 — IA Local, background]
Geração de embeddings por parágrafo (nomic-embed-text via Ollama)
Persistência em paragraph_embeddings
Status: indexed
     │
     ▼
[ETAPA 4 — API, lazy por seção]
Compressão de texto de cada seção (heurístico, ver §4)
Resumo de cada seção via API
Persistência em section_summaries
Status: summarized
     │
     ▼
[ETAPA 5 — API, map-reduce]
Resumo de capítulos (combina resumos de seção)
Resumo geral do documento (combina resumos de capítulo)
Persistência em section_summaries (com structure_id do nível correto)
Status: fully_processed
```

### 3.1 Regras de Execução

- Cada etapa é **idempotente** — re-executar não duplica dados
- Status de processamento salvo em `documents.processing_status`
- Status por seção salvo em `document_structure.processing_status`
- **Etapa 3** só roda se Ollama estiver disponível — caso contrário, status fica em `segmented` e busca semântica é desabilitada
- **Etapa 4** processa seções na **ordem de leitura do usuário**, não na ordem do documento. Seções nunca visitadas podem nunca ser resumidas (lazy processing)
- Respeita teto de requisições por hora configurado pelo usuário

### 3.2 Prioridade de Processamento

```dart
class SectionProcessingQueue {
  // Prioridade:
  // 1. Seção atual do usuário
  // 2. Seções adjacentes (±1)
  // 3. Seções já visitadas (por timestamp)
  // 4. Ordem do documento

  // Pausa automática quando:
  // - Usuário configurou "processar apenas em idle"
  // - Teto de requisições/hora atingido
  // - Ollama indisponível (para embeddings)
}
```

---

## 4. Pipeline de Compressão de Texto Pré-API

Antes de qualquer envio para API externa, o texto passa por este pipeline determinístico.

### 4.1 Estágios

```dart
class TextCompressor {

  /// Estágio 1: Limpeza estrutural
  String removeBoilerplate(String text) {
    // - Remove cabeçalhos e rodapés repetidos
    // - Remove numeração de página isolada
    // - Remove linhas de apenas hífens, underscores (separadores visuais)
    // - Remove ISBN, DOI, copyright isolados
  }

  /// Estágio 2: Remoção de referências bibliográficas inline
  String removeInlineCitations(String text) {
    // - Remove padrões: (Autor, 2020), [1], [Autor20], ibid., op. cit.
    // - Preserva o texto ao redor — só remove o marcador de citação
  }

  /// Estágio 3: Normalização tipográfica
  String normalizeTypography(String text) {
    // - Colapsa múltiplos espaços e quebras de linha
    // - Normaliza aspas, travessões, reticências
    // - Remove hifenização de quebra de linha (palavra-\npalavra → palavra palavra)
  }

  /// Estágio 4: Remoção de notas de rodapé
  String removeFootnotes(String text) {
    // - Detectadas na etapa heurística de importação
    // - Substitui por marcador [nota:N] se a nota for relevante
  }

  /// Estágio 5: Compressão semântica leve (heurístico)
  String compressRedundancy(String text) {
    // - Remove frases de transição vazias:
    //   "Como dito anteriormente,", "Vale ressaltar que",
    //   "É importante notar que", "Conforme mencionado"
    // - Remove repetição de definição dentro do mesmo parágrafo
    // - Lista de padrões por idioma (pt-BR e en-US inicialmente)
  }

  /// Pipeline completo
  String compress(String text) {
    return compressRedundancy(
      removeFootnotes(
        normalizeTypography(
          removeInlineCitations(
            removeBoilerplate(text)
          )
        )
      )
    );
  }
}
```

### 4.2 Taxa de Compressão Esperada

| Tipo de texto | Redução típica de tokens |
|---|---|
| Texto acadêmico denso | 15–25% |
| Texto com muitas citações inline | 25–40% |
| Texto com rodapés frequentes | 20–35% |
| Texto narrativo (livros) | 10–20% |

### 4.3 Regra de Ouro

A compressão **nunca** remove conteúdo semântico — só ruído estrutural e redundância de formatação. Sempre reversível: o texto original permanece intacto em `page_contents`; a versão comprimida é gerada sob demanda e cacheada em `paragraphs.compressed_text`.

---

## 5. Hierarquia de Resumos (Map-Reduce)

### 5.1 Estrutura em Três Níveis

```
Parágrafos (texto bruto)
     │  compressão heurística (TextCompressor)
     ▼
Seção → resumo de seção       ← uma chamada API por seção
     │  (input: texto comprimido da seção, ~500-1500 tokens)
     ▼
Capítulo → resumo de capítulo  ← uma chamada API por capítulo
     │  (input: concatenação dos resumos de seção, ~300-800 tokens)
     ▼
Documento → resumo geral       ← uma única chamada API
     │  (input: concatenação dos resumos de capítulo, ~500-2000 tokens)
     ▼
Cacheado no SQLite permanentemente
```

### 5.2 Estimativa de Custo

Para um livro de 300 páginas / 15 capítulos / 3 seções por capítulo = 45 seções:

```
Resumos de seção:
  45 seções × ~800 tokens input + ~150 tokens output = ~43.000 tokens

Resumos de capítulo:
  15 capítulos × ~400 tokens input + ~100 tokens output = ~7.500 tokens

Resumo geral:
  1 × ~1.000 tokens input + ~200 tokens output = ~1.200 tokens

Total: ~51.700 tokens
Custo estimado (modelo barato via OpenRouter): US$ 0,005 a US$ 0,02 por livro
```

### 5.3 Prompts de Resumo

**Seção** — VERSION: "v1.0":
```
SYSTEM:
Summarize the section below in 3-5 sentences. Focus on: main argument,
key evidence, conclusion.
Output: {"summary":"...","concepts":["..."]}
Return only JSON.

USER:
{{compressed_section_text}}
```

**Capítulo** — VERSION: "v1.0":
```
SYSTEM:
Synthesize the section summaries below into a chapter summary (4-6 sentences).
Identify the chapter's central argument and how sections connect.
Output: {"summary":"...","central_argument":"...","concepts":["..."]}
Return only JSON.

USER:
{{concatenated_section_summaries}}
```

**Documento** — VERSION: "v1.0":
```
SYSTEM:
Synthesize the chapter summaries into a complete document overview.
Output JSON:
{
  "document_summary": "3-5 sentences",
  "thesis": "central argument in 1-2 sentences",
  "structure": "how chapters build the argument",
  "key_concepts": ["top 10 concepts"],
  "reading_recommendation": "linear|nonlinear",
  "prerequisite_knowledge": ["..."]
}
Return only JSON.

USER:
{{concatenated_chapter_summaries}}
```

---

## 6. RAG Local

### 6.1 Pipeline

Para qualquer feature on-demand (chat, explicar, contextualizar etc.), o contexto enviado à API é sempre o resultado de uma busca de recuperação local.

```
Pergunta do usuário / trecho selecionado
     │
     ▼
[LOCAL] Gerar embedding da query (nomic-embed-text, Ollama)
     │
     ▼
[LOCAL] Busca de similaridade cosseno nos paragraph_embeddings
        Top-K parágrafos mais relevantes (K = 5 a 10)
     │
     ▼
[LOCAL] Reranking:
        - Boost para parágrafos da página atual (+0.2)
        - Boost para parágrafos de seções anotadas pelo usuário (+0.1)
        - Penalidade para parágrafos já usados nesta sessão de chat (-0.1)
     │
     ▼
[LOCAL] Compressão dos parágrafos recuperados (TextCompressor)
     │
     ▼
[API] Envio: system prompt + contexto recuperado + histórico comprimido + query
```

### 6.2 Orçamento de Contexto

```dart
class RAGContextBudget {
  static const int totalBudget = 6000;           // tokens máximos por chamada

  static const int systemPromptReserve = 800;    // system prompt + instruções
  static const int responseReserve = 1500;       // reserva para resposta da IA
  static const int historyReserve = 1200;        // histórico comprimido
  static const int retrievedContextBudget = 2500; // trechos recuperados pelo RAG

  // Se os trechos recuperados excedem 2500 tokens após compressão:
  // reduzir K (menos trechos) ou truncar os menos relevantes
}
```

### 6.3 Quando Ollama Está Indisponível

Se Ollama não está instalado ou rodando:
- Embeddings não são gerados → busca semântica indisponível
- RAG fallback para **FTS5** (busca léxica) como fonte de contexto
- Chat funciona com contexto da página atual + ±2 páginas
- Todas as features de API externa continuam funcionando

### 6.4 Busca Híbrida (FTS5 + Semântica)

```dart
Future<List<SearchResult>> hybridSearch(String query) async {
  final lexicalResults = await fts5Search(query);
  final semanticResults = await semanticSearch(query);

  return mergeResults(
    lexical: lexicalResults,
    semantic: semanticResults,
    lexicalWeight: 0.35,
    semanticWeight: 0.65,
  );
}
```

---

## 7. Compressão de Histórico de Chat

Após **6 turnos** (12 mensagens), as mensagens mais antigas são comprimidas:

```dart
class ChatHistoryCompressor {
  // Mantém integralmente: últimos 3 turnos (6 mensagens)
  // Comprime: turnos anteriores em um bloco de resumo

  Future<String> compressOldTurns(List<ChatMessage> oldMessages) async {
    // Uma chamada API barata para resumir turnos antigos
    // Output: "[Previous context: user asked about X, was explained Y...]"
    // Cacheado — não recomprime o que já foi comprimido
    // Mensagem comprimida salva com is_compressed = 1
  }
}
```

---

## 8. Cache de Respostas de IA

### 8.1 Estratégia

```dart
class AICacheStrategy {
  /// Cache key = hash(mode + prompt_version + input_hash + model)
  ///
  /// Regras:
  /// - Cache hit: mesmo trecho + mesmo modo + mesmo prompt_version + mesmo modelo → retorna cache
  /// - Invalidação: quando prompt_version muda (novo deployment do app)
  /// - Expiração: nunca (o texto do PDF não muda)
  /// - Escopo: por projeto (cache vive no .db do projeto)
  ///
  /// O que é cacheado:
  /// - Resumos da hierarquia: permanente
  /// - Explicar/resumir/flashcards: por hash do trecho
  /// - Modos on-demand: cacheado, mas usuário pode forçar re-geração
  ///
  /// O que NÃO é cacheado:
  /// - Chat (conversacional por natureza)
  /// - Modo socrático (depende do contexto da conversa)
}
```

---

## 9. Configuração do Ollama

### 9.1 Requisitos

| Componente | Mínimo | Recomendado |
|---|---|---|
| RAM | 2GB livres | 4GB livres |
| CPU | Qualquer dual-core | Quad-core+ |
| GPU | Não necessária | Qualquer (acelera embeddings) |
| Disco | 500MB (modelo) | 1GB |

### 9.2 Modelo Recomendado

```bash
ollama pull nomic-embed-text
# 270MB, context window 8192 tokens, excelente para textos acadêmicos
```

### 9.3 Detecção e Fallback

```dart
class OllamaService {
  /// Tenta conectar em http://localhost:11434 (timeout 2s)
  Future<bool> isAvailable();

  /// Lista modelos instalados via GET /api/tags
  Future<List<String>> listModels();

  /// Gera embedding para um texto
  Future<List<double>> embed(String text, {String model = 'nomic-embed-text'});

  /// Se indisponível: features de embedding retornam silenciosamente
  /// UI indica com ícone sutil que busca semântica está offline
}
```

---

## 10. Indicadores de Status na UI

```
Ícone na barra de status do documento:
  ⬜ imported      — texto disponível, leitura possível
  🔵 indexing...   — embeddings sendo gerados (X% concluído)
  🟡 summarizing   — resumos sendo gerados via API
  🟢 ready         — processamento completo
  ⚠️ ollama_off    — Ollama indisponível, busca semântica offline
```

---

## 11. Estimativa de Custo Total

Cenário: projeto com 3 livros de 300 páginas cada (900 páginas total)

```
Processamento inicial (hierarquia de resumos via OpenRouter com modelo barato):
  3 livros × US$ 0,01 = US$ 0,03

Features on-demand (uso moderado):
  ~200 operações × ~1000 tokens médios
  = 200.000 tokens ≈ US$ 0,02 a US$ 0,10

Chat durante a leitura:
  ~50 turnos × ~3000 tokens médios (com RAG comprimido)
  = 150.000 tokens

Total estimado para 3 livros: US$ 0,05 a US$ 0,30
(dependendo do provider e modelo escolhidos)

Cache elimina 60-80% dos tokens em re-leituras e consultas repetidas.
```
