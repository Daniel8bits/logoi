# Logoi — Roadmap de Implementação

> Documento complementar a `01_OVERVIEW.md`
> Organizado para que cada fase resulte num app funcional e utilizável.

---

## Fase 1 — Fundação (Core Reader + Anotações)

> **Objetivo:** App funcional para ler PDFs, anotar em Markdown e navegar por documentos.  
> **IA necessária:** Nenhuma. Tudo nesta fase é determinístico ou heurístico.

### 1.1 Infraestrutura

- [ ] Criar projeto Flutter desktop com estrutura de pastas definida em `02_ARCHITECTURE.md`
- [ ] Configurar Drift com schema completo (`03_DATABASE.md`)
- [ ] Implementar migration v1 com todas as tabelas
- [ ] Criar testes de migration com `SchemaVerifier`
- [ ] Implementar `Result<T, Failure>` pattern
- [ ] Configurar Riverpod com code generation
- [ ] Configurar `freezed` para models
- [ ] Configurar `flutter_secure_storage` para credenciais
- [ ] Configurar tema (claro/escuro) com design tokens

### 1.2 Gestão de Projetos

- [ ] Tela de projetos (Home): criar, listar, abrir, renomear, arquivar
- [ ] Card de projeto com estatísticas
- [ ] Persistência de projetos no SQLite
- [ ] Diretório de projetos configurável via `path_provider`

### 1.3 Importação e Extração de PDF

- [ ] Importar PDF via `file_picker`
- [ ] Extração de texto por página via `pdfrx`
- [ ] Extração de TOC dos headings do PDF
- [ ] Detecção de metadados (título, autores, ano)
- [ ] Persistência em `page_contents`, `documents`
- [ ] Pipeline de importação com status tracking

### 1.4 Leitor de PDF

- [ ] Renderização via `pdfrx`
- [ ] Navegação: por página, por TOC, por bookmark
- [ ] Zoom, modo página única / contínuo
- [ ] Seleção de texto básica (arrastar para selecionar)
- [ ] Layout de três painéis com `multi_split_view`
- [ ] Painel esquerdo: TOC e lista de documentos
- [ ] Modo foco (esconde painéis)

### 1.5 Segmentação e Seleção Granular

- [ ] Segmentação em parágrafos (análise de espaçamento)
- [ ] Segmentação em sentenças (regex + pontuação)
- [ ] Detecção de nível de heading (fonte + negrito + posição)
- [ ] Seleção granular: word / sentence / paragraph / section
- [ ] Menu de contexto ao selecionar (inicialmente só "Anotar" e "Copiar citação")
- [ ] Persistência da segmentação em `paragraphs` + `document_structure`

### 1.6 Anotações em Markdown

- [ ] Tipos: highlight (6 cores), nota, bookmark, questão
- [ ] Editor Markdown integrado (escolher entre super_editor, appflowy_editor ou flutter_quill)
- [ ] Renderização de Markdown com `markdown_widget`
- [ ] Suporte a LaTeX via `flutter_math_fork`
- [ ] Tags com autocomplete
- [ ] Highlights sobrepostos ao PDF
- [ ] Ícones de anotação na margem
- [ ] Painel de anotações: listar, filtrar por tipo/tag/página
- [ ] Versionamento automático de anotações (`annotation_versions`)
- [ ] Undo/redo no editor

### 1.7 Busca FTS

- [ ] Busca full-text via FTS5 no projeto
- [ ] Resultados com preview e navegação direta
- [ ] Filtros: por documento, por página

### 1.8 Sessões de Leitura

- [ ] Tracking de progresso (última página, % lido)
- [ ] Registro de sessões de leitura (`reading_sessions`)
- [ ] Cleanup de sessões órfãs no startup

### Critérios de Aceitação — Fase 1

- [ ] Criar projeto, importar PDF, ler com seleção granular
- [ ] Criar anotações em Markdown com highlights
- [ ] Buscar texto no projeto
- [ ] Ver progresso de leitura
- [ ] Fechar e reabrir app sem perda de dados
- [ ] Testes unitários para DAOs e repositories
- [ ] Testes de migration

---

## Fase 2 — IA Integrada

> **Objetivo:** Chat com IA, modos de prompt rápido, configuração de providers.
> **Requer:** Provider de IA configurado (OpenRouter recomendado).

### 2.1 Configuração de Providers

- [ ] Tela de configurações com setup de providers
- [ ] OpenRouterProvider (HTTP direto)
- [ ] DirectOpenAIProvider
- [ ] DirectAnthropicProvider
- [ ] OllamaProvider (para geração de texto)
- [ ] AIRouter com resolução de provider por tarefa
- [ ] Armazenamento seguro de API keys via `flutter_secure_storage`
- [ ] Listagem de modelos disponíveis (via API do OpenRouter)
- [ ] Roteamento de tarefas configurável pelo usuário
- [ ] Wizard de onboarding (primeiro uso)

### 2.2 Chat com IA

- [ ] Interface de chat com streaming (SSE)
- [ ] System prompt contextual (página + seleção + documento)
- [ ] Histórico persistente por sessão (`chat_sessions` + `chat_messages`)
- [ ] Ancoragem de mensagens a trechos do PDF
- [ ] Múltiplas sessões por documento/projeto

### 2.3 Modos de Prompt Rápido

- [ ] Menu de contexto expandido com todas as ações de IA
- [ ] Explicar (`explain`)
- [ ] Resumir (`summarize`)
- [ ] Modo Socrático (`socratic`)
- [ ] Contra-argumentar (`argue_against`)
- [ ] Contexto Histórico (`historical_context`)
- [ ] Gerar Flashcards (`flashcards`)
- [ ] Mapear Argumento (`argument_map`)
- [ ] Detector de Viés (`bias_detection`)

### 2.4 Respostas JSON

- [ ] `JSONResponseParser` com fallback chain
- [ ] Structured outputs via `response_format` (quando provider suporta)
- [ ] Visualização de respostas estruturadas (flashcards, mapa de argumento, viés)

### 2.5 Cache e Economia

- [ ] `AICacheStrategy` com cache key = `hash(mode + prompt_version + input_hash + model)`
- [ ] `api_usage_log` com registro de toda chamada
- [ ] Dashboard de custo na tela de configurações
- [ ] `TextCompressor` — pipeline de compressão pré-API

### 2.6 Tratamento de Erros

- [ ] `AIError` sealed class com todos os tipos
- [ ] Retry automático para `RateLimitError`
- [ ] Feedback visual para erros de IA
- [ ] Fallback para modelos alternativos

### Critérios de Aceitação — Fase 2

- [ ] Configurar OpenRouter, enviar mensagem no chat, receber resposta em streaming
- [ ] Selecionar texto, usar "Explicar", ver resposta contextual
- [ ] Cache funcional: segunda chamada igual retorna instantaneamente
- [ ] Dashboard mostra tokens consumidos
- [ ] Funcional sem IA (todas as features de Fase 1 continuam funcionando)

---

## Fase 3 — Conhecimento e Processamento

> **Objetivo:** Grafo de conceitos, cruzamento de referências, RAG, busca semântica.
> **Requer:** Ollama para embeddings (opcional mas recomendado).

### 3.1 Ollama e Embeddings

- [ ] `OllamaService` com detecção automática
- [ ] Geração de embeddings por parágrafo (nomic-embed-text)
- [ ] Persistência em `paragraph_embeddings`
- [ ] Status de processamento na UI (`indexing...`)
- [ ] Background processing queue com prioridades

### 3.2 RAG Local

- [ ] `RAGContextBuilder` com busca semântica
- [ ] Reranking (boost página atual, anotações, penalidade repetição)
- [ ] `RAGContextBudget` com limites de tokens
- [ ] Fallback para FTS5 quando Ollama indisponível
- [ ] Integração do RAG no chat e modos rápidos

### 3.3 Hierarquia de Resumos

- [ ] Resumos de seção via API (map-reduce nível 1)
- [ ] Resumos de capítulo (map-reduce nível 2)
- [ ] Resumo geral do documento (map-reduce nível 3)
- [ ] Processing lazy: por ordem de leitura
- [ ] Mapa do documento gerado por IA

### 3.4 Compressão de Histórico

- [ ] `ChatHistoryCompressor` (após 6 turnos)
- [ ] Cacheamento de compressões anteriores

### 3.5 Grafo de Conceitos

- [ ] Extração de conceitos via IA ao selecionar trecho
- [ ] Adição manual de conceitos
- [ ] Canvas interativo (force-directed)
- [ ] Filtros por documento e tipo
- [ ] Clique navega para ocorrência no PDF

### 3.6 Cruzamento de Referências

- [ ] Manual: selecionar trecho A → vincular a trecho B
- [ ] Automático: detecção via embeddings entre documentos
- [ ] Tipos de relação com confiança
- [ ] Painel de referências cruzadas

### 3.7 Busca Semântica e Híbrida

- [ ] Busca por similaridade cosseno local
- [ ] Busca híbrida: FTS5 + semântica com score ponderado (0.35 / 0.65)
- [ ] Resultados com score de relevância

### Critérios de Aceitação — Fase 3

- [ ] Ollama detectado, embeddings gerados em background
- [ ] Chat com RAG: resposta contextualizada com trechos relevantes de todo o documento
- [ ] Grafo de conceitos navegável
- [ ] Busca semântica retorna resultados por significado, não apenas palavra
- [ ] Sem Ollama: busca FTS continua funcionando, chat usa contexto de página

---

## Fase 4 — Exportação e Polimento

> **Objetivo:** Exportação de dados, cadernos de notas, refinamentos de UX.

### 4.1 Caderno de Notas

- [ ] Feature notebook: editor Markdown livre vinculado a documento/projeto
- [ ] Template de fichamento gerado por IA

### 4.2 Exportação

- [ ] Fichamento estruturado em Markdown (gerado por IA)
- [ ] Notas em formato Zettelkasten (compatível com Obsidian/Logseq)
- [ ] Referências bibliográficas (ABNT, APA, Vancouver)
- [ ] Flashcards em formato Anki (CSV ou `.apkg`)
- [ ] Grafo de conceitos como PNG e JSON

### 4.3 Polimento de UX

- [ ] Temas: claro, escuro, sépia
- [ ] Atalhos de teclado completos
- [ ] Progresso e metas de leitura
- [ ] Undo/redo para todas as ações destrutivas
- [ ] Tooltips e feedback visual em todos os estados

### 4.4 Qualidade

- [ ] Testes de integração end-to-end
- [ ] Performance: abrir PDF de 500 páginas em < 3 segundos
- [ ] Performance: busca FTS em < 200ms
- [ ] Performance: grafo com 200 nós a 60fps

### Critérios de Aceitação — Fase 4

- [ ] Exportar fichamento completo em Markdown
- [ ] Importar notas no Obsidian sem problemas
- [ ] Gerar flashcards e importar no Anki
- [ ] Tema escuro funcional
- [ ] Todos os atalhos de teclado funcionando
