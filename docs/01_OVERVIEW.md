# Logoi — Visão Geral do Projeto

> "Um Cursor para estudo de livros e artigos em PDF"

**Documentos complementares:**
- `02_ARCHITECTURE.md` — arquitetura de software e estrutura de pastas
- `03_DATABASE.md` — schema completo do banco de dados, índices e migrations
- `04_AI_LAYER.md` — camada de IA: providers, abstração, prompts, modos
- `05_PROCESSING.md` — pipeline de processamento, compressão, RAG, cache
- `06_UI_UX.md` — layout, componentes, fluxos de tela e acessibilidade
- `07_DEPENDENCIES.md` — stack tecnológica, pacotes e justificativas
- `08_ROADMAP.md` — fases de implementação e critérios de aceitação

---

## 1. O que é o Logoi

**Logoi** é um aplicativo desktop de leitura acadêmica com IA integrada. Trata cada sessão de leitura como um **projeto estruturado**, permitindo anotações ricas em Markdown, navegação semântica, cruzamento de referências e conversação com múltiplos modelos de linguagem — tudo armazenado localmente, sem dependência de nuvem.

**Plataforma:** Desktop (Windows, macOS, Linux)
**Stack obrigatória:** Flutter + Dart
**Armazenamento:** SQLite local (um arquivo `.db` por projeto)
**Paradigma de estado:** Riverpod (feature-first)

---

## 2. Princípios de Design

### 2.1 Local-first, sem lock-in
- Todos os dados do usuário ficam em arquivos locais (SQLite + PDFs)
- Zero dependência de servidores próprios
- Exportação completa dos dados a qualquer momento

### 2.2 IA como ferramenta, não como dependência
- O app é **totalmente funcional sem qualquer IA** configurada
- Cada feature tem um nível de execução (determinístico → heurístico → IA local → API externa)
- O nível mais barato que entrega qualidade suficiente é sempre preferido

### 2.3 Flexibilidade total de provider de IA
- O usuário pode usar **OpenRouter** (acesso a centenas de modelos), **APIs diretas** (OpenAI, Anthropic, Google) ou **IA local** (Ollama)
- Diferentes tasks podem usar diferentes providers: resumos via modelo barato, chat via modelo premium
- A troca de provider nunca exige reprocessamento de dados

### 2.4 Economia de tokens como feature
- Nenhuma chamada de API recebe texto bruto do PDF
- Pipeline de compressão determinístico reduz tokens antes de qualquer envio
- Cache agressivo elimina chamadas repetidas
- Dashboard de custo visível ao usuário

### 2.5 Anotações são cidadãs de primeira classe
- O sistema de anotações usa **Markdown completo** como formato nativo
- Suporta headings, listas, tabelas, código, links, imagens embutidas e fórmulas LaTeX
- Anotações são versionadas — o usuário vê como seu entendimento evoluiu
- Exportáveis para qualquer sistema (Obsidian, Logseq, Anki)

---

## 3. Conceitos Centrais

| Conceito | Descrição |
|---|---|
| **Projeto** | Unidade organizacional. Contém documentos, anotações, histórico de chat e grafo de conceitos. Um arquivo `.db` por projeto. |
| **Documento** | PDF importado para o projeto. Possui texto indexado, mapa estrutural e metadados extraídos. |
| **Seleção** | Qualquer unidade de texto destacada: palavra, sentença, parágrafo ou seção. Base de todas as ações de IA. |
| **Anotação** | Nota Markdown vinculada a uma seleção, com tipo, cor e tags. Possui histórico de versões. |
| **Conceito** | Entidade semântica (extraída pela IA ou definida pelo usuário). Nó no grafo de conhecimento do projeto. |
| **Sessão de Chat** | Conversa com a IA vinculada a um documento ou projeto inteiro. Possui histórico persistente comprimido. |
| **Caderno** | Coleção organizada de anotações de um documento, com estrutura livre em Markdown para fichamentos e rascunhos. |

---

## 4. Fontes de IA Suportadas

O Logoi abstrai completamente a origem da IA por trás de uma interface unificada. O usuário pode configurar múltiplas fontes simultaneamente e atribuir cada uma a diferentes tarefas.

### 4.1 OpenRouter (recomendado)

Gateway unificado que dá acesso a centenas de modelos (OpenAI, Anthropic, Google, Meta, Mistral, etc.) com uma única API key.

- **Vantagens:** Uma chave para tudo, fallback automático entre providers, roteamento inteligente por custo/qualidade, suporte a structured outputs.
- **Uso recomendado:** Provider padrão para todas as features on-demand (chat, explicar, resumir, etc.).

### 4.2 APIs Diretas

Conexão direta com OpenAI, Anthropic ou Google sem intermediário.

- **Vantagens:** Menor latência, acesso a features específicas do provider (ex: caching nativo do Anthropic).
- **Uso recomendado:** Quando o usuário já tem chave de um provider específico ou precisa de controle fino.

### 4.3 IA Local (Ollama)

Modelos rodando na máquina do usuário via Ollama.

- **Vantagens:** Zero custo, privacidade total, funciona offline.
- **Uso recomendado:** Embeddings (obrigatório para busca semântica), geração de texto quando o usuário preferir privacidade.
- **Requisitos mínimos:** 2GB RAM livres para embeddings; 4GB+ para geração de texto.

### 4.4 Configuração por Tarefa

O usuário pode configurar providers diferentes para cada tipo de operação:

```
Embeddings         → Ollama (nomic-embed-text)      — sempre local
Resumos batch      → OpenRouter (modelo barato)      — background
Chat interativo    → OpenRouter (modelo premium)     — on-demand
Explicar/Socrático → API direta (Anthropic Claude)   — on-demand
```

---

## 5. Fluxo de Uso Principal

```
1. Criar projeto → definir nome, área de estudo, providers de IA
2. Importar PDFs → extração de texto, segmentação, indexação (background)
3. Ler documento → seleção granular, highlights, anotações Markdown
4. Interagir com IA → explicar, resumir, questionar, contra-argumentar
5. Construir conhecimento → grafo de conceitos, cruzamento de referências
6. Exportar → fichamento, notas Zettelkasten, flashcards Anki
```

---

## 6. Nomenclatura no Código

- **Nomes em inglês** no código (classes, variáveis, funções)
- **Comentários** em inglês (para compatibilidade com Fable 5 e ferramentas de IA)
- **UI** em português brasileiro por padrão, com suporte a internacionalização futura
- **Documentação** em português (estes arquivos de spec)
