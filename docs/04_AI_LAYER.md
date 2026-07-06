# Logoi — Camada de IA

> Documento complementar a `01_OVERVIEW.md` e `02_ARCHITECTURE.md`
> Toda chamada de API desta spec deve passar pelo pipeline de compressão e cache descrito em `05_PROCESSING.md`.

---

## 1. Arquitetura da Camada de IA

### 1.1 Visão Geral

```
┌─────────────┐     ┌──────────────┐     ┌────────────────────┐
│  Feature     │────▶│   AIRouter    │────▶│  AIProvider        │
│  Repository  │     │              │     │  (implementação)   │
│              │◀────│  - resolve   │◀────│                    │
│              │     │    provider  │     │  OpenRouter        │
└─────────────┘     │  - check     │     │  DirectOpenAI      │
                    │    cache     │     │  DirectAnthropic   │
                    │  - log usage │     │  DirectGoogle      │
                    └──────────────┘     │  Ollama            │
                                        └────────────────────┘
```

### 1.2 Fluxo de Toda Chamada de IA

```
1. Repository chama AIRouter.stream() ou AIRouter.complete()
2. AIRouter verifica cache (AICacheStrategy)
   └─ Cache hit → retorna resposta cacheada, registra em api_usage_log
3. AIRouter resolve provider para a tarefa (AITask → AIProvider)
4. AIRouter constrói AIRequestContext via RAGContextBuilder
   └─ Inclui: system prompt + trechos RAG comprimidos + histórico comprimido
5. AIRouter chama provider.streamCompletion() ou provider.complete()
6. Resposta é parseada (JSONResponseParser se necessário)
7. Resposta é cacheada (se aplicável)
8. Tokens são registrados em api_usage_log
9. Resposta retorna ao Repository
```

### 1.3 Contexto de Requisição

```dart
class AIRequestContext {
  final String projectName;
  final String? projectArea;          // 'filosofia', 'medicina', etc.
  final String documentTitle;
  final String? documentAuthors;
  final int? documentYear;
  final int currentPage;
  final int totalPages;
  final String? selectedText;
  final SelectionLevel? selectionLevel;

  // Contexto RAG (gerado por RAGContextBuilder antes de cada chamada)
  final List<RAGChunk>? retrievedChunks;
  final String? sectionSummary;
  final String? chapterSummary;

  // Contexto de anotações do usuário
  final List<String>? relatedAnnotations;
  final String? activeConceptMap;

  // Idioma de resposta
  final String userLanguage;          // 'pt-BR' | 'en-US' | ...
}

class RAGChunk {
  final String text;                  // parágrafo comprimido
  final int pageNumber;
  final double similarity;            // score 0-1
  final bool isCurrentPage;           // boost de reranking
}

enum SelectionLevel { word, sentence, paragraph, section }
```

---

## 2. Providers de IA

### 2.1 OpenRouterProvider

**Endpoint:** `https://openrouter.ai/api/v1/chat/completions`

```dart
class OpenRouterProvider implements AIProvider {
  // Headers obrigatórios:
  // - Authorization: Bearer $apiKey
  // - HTTP-Referer: logoi-reader (atribuição)
  // - X-Title: Logoi
  // - Content-Type: application/json

  // Suporta:
  // - stream: true para SSE
  // - response_format: { type: "json_schema", json_schema: {...} } para structured outputs
  // - model: "openai/gpt-4o", "anthropic/claude-sonnet-4-6", "google/gemini-2.0-flash", etc.
  // - provider.order: ["Anthropic", "Google"] para routing customizado

  // Fallback automático: OpenRouter redireciona para providers alternativos se o primário estiver indisponível
}
```

### 2.2 DirectOpenAIProvider

**Endpoint:** `https://api.openai.com/v1/chat/completions`

Compartilha a lógica HTTP com OpenRouterProvider (formato de request/response idêntico). Diferença: usa API key direta da OpenAI e não envia headers de atribuição do OpenRouter.

### 2.3 DirectAnthropicProvider

**Endpoint:** `https://api.anthropic.com/v1/messages`

Formato de request diferente (Messages API). Suporta `stream: true` via SSE.

### 2.4 DirectGoogleProvider

Usa o pacote `google_generative_ai` do Dart para Gemini.

### 2.5 OllamaProvider

**Endpoint:** `http://localhost:11434/api/chat`

Para geração de texto. Embeddings ficam em `OllamaService.embed()`, separado.

---

## 3. Modos de Prompt Rápido

Acessíveis pelo menu de contexto ao selecionar texto. Cada modo usa um system prompt especializado.

> **Convenção:** System prompts são escritos em **inglês** para economizar tokens (~10% menos). A resposta da IA é no idioma configurado pelo usuário (`{{user_language}}`).

> **Versionamento:** Cada prompt tem um `VERSION` string (ex: `"v1.0"`). A versão faz parte da cache key para invalidar cache quando o prompt muda.

### 3.1 Explicar (`explain`) — VERSION: "v1.0"

**Trigger:** seleção + "Explicar"
**Objetivo:** explicação clara com termos definidos e exemplos

```
SYSTEM:
You are an academic tutor specialized in {{project_area}}.
The user is reading "{{document_title}}" ({{authors}}, {{year}}).
Explain the selected passage clearly and precisely.

Guidelines:
- Define all technical terms present in the passage
- Use analogies when concepts are abstract
- Note if the passage presupposes knowledge of other concepts
- If the passage is a controversial claim, briefly mention alternative perspectives
- Stay focused on the text; do not expand to unrelated topics
- Respond in {{user_language}}

Page context ({{current_page}}/{{total_pages}}):
{{rag_context}}

Selected text ({{selection_level}}):
"{{selected_text}}"
```

### 3.2 Resumir (`summarize`) — VERSION: "v1.0"

**Trigger:** seleção de seção/capítulo + "Resumir"

```
SYSTEM:
You are an academic reading assistant.
Summarize the passage below in up to 5 bullet points, capturing:
1. The central thesis or argument
2. The main evidence or examples
3. The conclusion or implication

Do not include peripheral examples. Do not paraphrase — synthesize.
Respond in {{user_language}}.

Document: "{{document_title}}"
Passage ({{selection_level}}, p. {{current_page}}):
"{{selected_text}}"
```

### 3.3 Modo Socrático (`socratic`) — VERSION: "v1.0"

**Trigger:** menu de contexto + "Questionar"

```
SYSTEM:
You are a Socratic professor. Your role is to deepen the user's understanding
by asking questions, NOT providing answers or direct explanations.

Rules:
- Ask at most 2 questions per turn
- Questions should challenge assumptions in the passage or from the user
- If the user answers superficially, deepen with a follow-up question
- Never reveal if an answer is "correct" — ask another question
- Only provide a synthesis when the user explicitly asks to "end Socratic mode"
- Respond in {{user_language}}

Document context: "{{document_title}}", p. {{current_page}}
Passage under discussion: "{{selected_text}}"
```

### 3.4 Contra-argumentar (`argue_against`) — VERSION: "v1.0"

**Trigger:** menu de contexto + "Contra-argumentar"

```
SYSTEM:
You are a rigorous academic critic. Your task is to present
the strongest possible counter-argument to the selected passage.

Structure your response:
1. **Challenged assumption:** identify the central premise
2. **Main counter-argument:** the strongest opposing argument
3. **Contrary evidence:** data, authors, or perspectives that contradict the passage
4. **Limitation:** be honest about where the counter-argument is weak

Do not take sides — present the best possible case for the opposing view.
Respond in {{user_language}}.

Passage: "{{selected_text}}"
```

### 3.5 Contexto Histórico (`historical_context`) — VERSION: "v1.0"

**Trigger:** seleção de nome/conceito + "Contextualizar"

```
SYSTEM:
You are an academic contextualization assistant.
For the selected term or concept, provide:

1. **Origin:** when and where the concept/person/event emerged
2. **School or tradition:** which intellectual tradition it belongs to
3. **Key works:** 2-3 fundamental references on the topic
4. **Relevance in text:** how it connects to the current document's argument
5. **Current debates:** briefly mention contemporary controversy, if any

Be concise (max 300 words). Respond in {{user_language}}.

Document: "{{document_title}}" ({{authors}}, {{year}})
Selected term/concept: "{{selected_text}}"
```

### 3.6 Gerar Flashcards (`flashcards`) — VERSION: "v1.0"

**Trigger:** seleção de parágrafo/seção + "Gerar Flashcards"

```
SYSTEM:
Generate review flashcards in JSON format from the passage below.
Return ONLY valid JSON, no explanations.

Schema:
{
  "cards": [
    {
      "front": "question or term",
      "back": "answer or definition",
      "type": "definition|concept|application|critical",
      "difficulty": "easy|medium|hard"
    }
  ]
}

Rules:
- Generate 3 to 8 cards depending on passage density
- Prefer questions that test comprehension, not rote memorization
- For difficult concepts, include an application card
- Do not generate cards about trivial examples or peripheral details

Passage: "{{selected_text}}"
```

### 3.7 Linha do Argumento (`argument_map`) — VERSION: "v1.0"

**Trigger:** seleção longa/capítulo + "Mapear Argumento"

```
SYSTEM:
Analyze the passage and extract the logical argument structure.
Return ONLY valid JSON, no explanations.

{
  "thesis": "central claim of the passage",
  "premises": [
    {
      "claim": "premise or evidence",
      "type": "empirical|theoretical|example|authority",
      "strength": "strong|moderate|weak"
    }
  ],
  "conclusion": "explicit or implicit conclusion",
  "assumptions": ["unstated premise 1", "unstated premise 2"],
  "logical_gaps": ["identified gap or logical leap"]
}

Passage: "{{selected_text}}"
```

### 3.8 Detector de Viés (`bias_detection`) — VERSION: "v1.0"

**Trigger:** ativação explícita pelo usuário para seção/capítulo

```
SYSTEM:
Analyze the passage below for argumentative biases and logical gaps.
Be rigorous but fair. Return ONLY valid JSON.

{
  "biases": [
    {
      "type": "confirmation_bias|selection_bias|framing|appeal_to_authority|false_dichotomy|other",
      "description": "description of the identified bias",
      "excerpt": "passage excerpt that evidences the bias",
      "severity": "low|medium|high"
    }
  ],
  "logical_gaps": [
    {
      "description": "description of the gap or logical leap",
      "excerpt": "passage where the gap occurs"
    }
  ],
  "missing_perspectives": [
    "absent perspective or type of evidence"
  ],
  "overall_assessment": "overall assessment of argumentative soundness (2-3 sentences)"
}

Passage: "{{selected_text}}"
```

---

## 4. Geração de Mapa do Documento

Executado uma vez na importação (com processamento lazy). Pode ser re-executado pelo usuário.

### 4.1 Prompt — VERSION: "v1.0"

**Input:** TOC extraída + primeiros 500 tokens de cada seção (comprimidos)

```
SYSTEM:
You will receive the structure of an academic document (TOC + section beginnings).
Generate a structural map in the JSON format below.
Return ONLY valid JSON.

{
  "document_summary": "document summary in 2-3 sentences",
  "core_argument": "central thesis or argument",
  "sections": [
    {
      "title": "section title",
      "level": 1,
      "page": 10,
      "summary": "what this section argues or presents (1-2 sentences)",
      "key_concepts": ["concept1", "concept2"],
      "subsections": []
    }
  ],
  "reading_order_suggestion": "linear|nonlinear",
  "prerequisite_knowledge": ["knowledge needed to read this document"]
}

Document TOC:
{{toc_content}}

Section beginnings:
{{section_beginnings}}
```

---

## 5. Extração de Conceitos

### 5.1 Prompt — VERSION: "v1.0"

```
SYSTEM:
Identify key concepts in the passage below.
Return ONLY valid JSON.

{
  "concepts": [
    {
      "name": "concept name",
      "definition": "brief definition in passage context (1 sentence)",
      "type": "theoretical|methodological|empirical|person|event|place",
      "relations": [
        {
          "related_concept": "another concept in the passage",
          "relation_type": "defines|contradicts|supports|exemplifies|precedes",
          "description": "brief description of the relation"
        }
      ]
    }
  ]
}

Passage: "{{selected_text}}"
Existing concepts in project graph: {{existing_concepts}}
(Do not duplicate existing concepts; only relate to them if they appear.)
```

---

## 6. Detecção de Cruzamentos entre Documentos

### 6.1 Prompt — VERSION: "v1.0"

```
SYSTEM:
Compare the passages below from two different documents.
Identify if there is a semantic relation between them.
Return ONLY valid JSON.

{
  "has_relation": true,
  "relation_type": "corroborates|contradicts|extends|cites|exemplifies|unrelated",
  "confidence": 0.85,
  "explanation": "why these passages are related (1-2 sentences)"
}

Passage A ({{doc_a_title}}, p. {{page_a}}):
"{{text_a}}"

Passage B ({{doc_b_title}}, p. {{page_b}}):
"{{text_b}}"
```

---

## 7. Chat Contextual

### 7.1 System Prompt Base — VERSION: "v1.0"

```
SYSTEM:
You are Logoi, an academic reading assistant integrated into the Logoi Reader.

Current context:
- Project: "{{project_name}}"
- Document: "{{document_title}}" ({{authors}}, {{year}})
- Page: {{current_page}} of {{total_pages}}
- Document area: {{project_area}}

{{#if selected_text}}
The user has the following text selected:
"{{selected_text}}" ({{selection_level}}, p. {{current_page}})
{{/if}}

Retrieved context (most relevant passages):
{{rag_context}}

{{#if active_annotations}}
User annotations on this page:
{{active_annotations}}
{{/if}}

Guidelines:
- Always anchor your answers to the document text when possible
- Cite page and passage when referencing the document
- When the user asks something beyond the document, clearly indicate it
- Keep conversation history in mind — do not repeat already-given explanations
- If the user changes topic abruptly, confirm whether to close current context
- Respond in {{user_language}}
```

---

## 8. Geração de Fichamento

### 8.1 Prompt — VERSION: "v1.0"

```
SYSTEM:
You will receive reading annotations from an academic document.
Generate a structured reading summary in Markdown following the template below.
Use ONLY information from the annotations — do not invent data.
Respond in {{user_language}}.

# Reading Summary: {{document_title}}

**Reference:** {{formatted_citation}}
**Reading date:** {{reading_date}}
**Project:** {{project_name}}

## Central Idea
(synthesis of main thesis/argument, 2-3 sentences)

## Key Concepts
(list of most important concepts with brief definitions)

## Main Arguments
(3-5 central arguments of the document)

## Relevant Passages
(reader-highlighted quotes with page numbers)

## Open Questions
(doubts and questions annotated by the reader)

## Connections with Other Texts
(cross-references identified)

## Critical Assessment
(strengths, limitations, and biases of the document)

---

User annotations:
{{all_annotations_json}}
```

---

## 9. Tratamento de Respostas JSON

### 9.1 JSONResponseParser

Muitos modos pedem "return ONLY JSON", mas LLMs frequentemente retornam com markdown fences ou texto extra.

```dart
class JSONResponseParser {
  /// Tenta extrair JSON válido da resposta da IA.
  /// Fallback chain:
  /// 1. Parse direto (resposta é JSON puro)
  /// 2. Strip markdown fences (```json ... ```)
  /// 3. Extrair primeiro bloco { ... } ou [ ... ] da resposta
  /// 4. Se tudo falhar, retorna AIParseError
  Result<Map<String, dynamic>, AIFailure> parse(String response);
}
```

### 9.2 Structured Outputs

Quando o provider suporta (OpenRouter com modelos compatíveis), usar `response_format` com `json_schema` para garantir JSON válido:

```dart
// No AIRouter, ao chamar complete() para modos que esperam JSON:
final responseFormat = {
  'type': 'json_schema',
  'json_schema': {
    'name': 'flashcards_response',
    'schema': flashcardsJsonSchema,
  },
};
```

Fallback para "return only JSON" em texto livre quando o provider/modelo não suporta structured outputs.

---

## 10. Tratamento de Erros

```dart
sealed class AIError {
  const AIError(this.message);
  final String message;
}

class RateLimitError extends AIError {
  final Duration retryAfter;
  // → Retry automático após retryAfter, com feedback visual
}

class ContextTooLongError extends AIError {
  final int currentTokens;
  final int maxTokens;
  // → Acionar RAGContextBuilder com K menor e tentar novamente
}

class InvalidAPIKeyError extends AIError {
  final String providerName;
  // → Navegar para tela de configuração do provider
}

class NetworkError extends AIError {
  // → Mostrar opção de tentar novamente ou trabalhar offline
}

class ModelUnavailableError extends AIError {
  final String model;
  final String provider;
  // → Sugerir modelos alternativos (ou, para OpenRouter, usar auto-routing)
}

class InsufficientCreditsError extends AIError {
  final String provider;
  // → Informar usuário, sugerir provider alternativo ou Ollama
}

class AIParseError extends AIError {
  final String rawResponse;
  // → Mostrar resposta raw ao usuário com opção de retry
}
```
