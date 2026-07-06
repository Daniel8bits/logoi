# Logoi — Interface e Experiência do Usuário

> Documento complementar a `01_OVERVIEW.md`

---

## 1. Telas do Aplicativo

### 1.1 Tela Inicial (Home / Projetos)

```
┌─────────────────────────────────────────────────────────────────────┐
│  Logoi                                              [⚙ Configurações]│
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  Seus Projetos                                    [+ Novo Projeto]  │
│                                                                     │
│  ┌───────────────┐  ┌───────────────┐  ┌───────────────┐          │
│  │ 📚 Filosofia  │  │ 📚 Mestrado   │  │ 📚 ML Papers  │          │
│  │ Moderna       │  │ Cap. 1-3      │  │               │          │
│  │               │  │               │  │               │          │
│  │ 3 documentos  │  │ 5 documentos  │  │ 12 documentos │          │
│  │ 67% lido      │  │ 23% lido      │  │ 45% lido      │          │
│  │ 42 anotações  │  │ 18 anotações  │  │ 89 anotações  │          │
│  │               │  │               │  │               │          │
│  │ Última leitura│  │ Última leitura│  │ Última leitura│          │
│  │ há 2 dias     │  │ há 1 semana   │  │ ontem         │          │
│  └───────────────┘  └───────────────┘  └───────────────┘          │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

**Funcionalidades:**
- Criar, renomear, arquivar projetos
- Card de projeto com: nome, descrição, contagem de documentos, progresso, última leitura
- Abertura rápida do último documento lido
- Botão de importar PDF direto do card

---

### 1.2 Tela Principal (Reader View)

```
┌─────────────────────────────────────────────────────────────────────┐
│  [← Projetos]  Logoi  │ documento.pdf          │ 🔵 indexing │ ⚙  │
├──────────┬──────────────────────────────────┬────────────────────────┤
│          │                                  │                        │
│ PAINEL   │       VISUALIZADOR PDF           │   PAINEL DIREITO       │
│ ESQUERDO │                                  │                        │
│          │  ┌──────────────────────────┐    │  [📝 Anotações]        │
│ • TOC    │  │                          │    │  [💬 Chat IA]          │
│ • Mapa   │  │    Conteúdo do PDF       │    │  [🔗 Conceitos]        │
│ • Busca  │  │    com highlights        │    │  [📎 Referências]      │
│ • Docs   │  │    e anotações           │    │  [📓 Caderno]          │
│          │  │    sobrepostos           │    │                        │
│          │  │                          │    │  ─────────────────     │
│          │  └──────────────────────────┘    │                        │
│          │  ◄ pág 42 / 312 ►               │  [Área ativa do        │
│          │                                  │   painel selecionado]  │
│          │                                  │                        │
└──────────┴──────────────────────────────────┴────────────────────────┘
```

**Layout:**
- Três painéis redimensionáveis via `multi_split_view`
- Painéis laterais colapsáveis com atalho de teclado
- Modo foco: esconde painéis laterais, PDF ocupa tela toda

---

## 2. Painéis

### 2.1 Painel Esquerdo — Navegação

**Aba TOC:**
- Índice do documento extraído dos headings do PDF
- Árvore colapsável com níveis de profundidade
- Clique navega para a seção

**Aba Mapa:**
- Mapa estrutural gerado por IA (quando disponível)
- Exibe resumo por seção com indicador de processamento
- Conceitos-chave por seção como badges

**Aba Busca:**
- Busca full-text no projeto (FTS5)
- Busca semântica (quando Ollama disponível)
- Resultados com preview e navegação direta
- Filtros: por documento, por página, por tipo de conteúdo

**Aba Documentos:**
- Lista de documentos do projeto
- Status de processamento de cada documento
- Drag and drop para reordenar

### 2.2 Painel Central — Leitor PDF

**Renderização:**
- Via `pdfrx` com renderização de alta fidelidade
- Modos: página única, contínuo, duas páginas
- Zoom controlável (scroll + atalhos)

**Seleção Granular:**
- Detecção automática de nível: palavra → sentença → parágrafo → seção
- Visual feedback diferente para cada nível (sublinhado, highlight, borda)
- Double-click = palavra, triple-click = sentença, drag = seleção livre

**Menu de Contexto (ao selecionar):**
```
┌────────────────────────┐
│ 📝 Anotar              │
│ ─────────────────────  │
│ 💡 Explicar            │
│ 📋 Resumir             │
│ ❓ Questionar (Socrático)│
│ ⚔️ Contra-argumentar   │
│ 🕐 Contextualizar      │
│ 🃏 Gerar Flashcards    │
│ 🗺️ Mapear Argumento    │
│ ─────────────────────  │
│ 🔗 Vincular referência │
│ 🧩 Adicionar ao grafo  │
│ 📋 Copiar citação      │
└────────────────────────┘
```

**Overlays:**
- Highlights coloridos (6 cores) sobrepostos ao texto
- Ícones de anotação na margem (clicáveis)
- Indicadores de conceitos vinculados

### 2.3 Painel Direito — Contexto e Ação

**Aba Anotações:**
- Lista de anotações filtrada por tipo/tag/página
- Preview do Markdown renderizado
- Clique para editar em editor Markdown completo
- Ordenação: por página, por data, por tipo

**Aba Chat IA:**
- Interface de chat com streaming de respostas
- Indicador de provider/modelo em uso
- Contexto automático da página e seleção ativas
- Botões de modo rápido no topo (Explicar, Resumir, etc.)
- Ancoragem de mensagens a trechos do PDF (clicável para navegar)

**Aba Conceitos:**
- Lista de conceitos da página atual e do projeto
- Miniatura do grafo de conceitos
- Botão para abrir tela de grafo completa
- Sugestões de conceitos (quando IA está disponível)

**Aba Referências:**
- Referências cruzadas da página/seleção atual
- Automáticas (detectadas por IA) e manuais
- Clique navega para o trecho referenciado

**Aba Caderno:**
- Editor Markdown completo integrado
- Vinculado ao documento atual
- Para fichamentos, rascunhos, notas livres

---

## 3. Editor de Anotações Markdown

### 3.1 Funcionalidades

O editor de anotações usa Markdown como formato nativo e deve suportar:

**Formatação de texto:**
- Headings (H1-H6)
- Bold, italic, strikethrough
- Listas ordenadas e não-ordenadas
- Checklists (task lists)
- Blockquotes
- Código inline e blocos de código com syntax highlighting

**Elementos avançados:**
- Tabelas
- Links (incluindo links para páginas do PDF: `[p.42](page:42)`)
- Imagens embutidas (coladas da área de transferência, salvas localmente)
- Fórmulas LaTeX inline (`$E = mc^2$`) e em bloco (`$$...$$`)
- Notas de rodapé
- Separadores horizontais

**Experiência de edição:**
- **Live preview** ao estilo Typora/Obsidian: Markdown renderizado em tempo real, com syntax visible apenas na linha em edição
- Toolbar com ações rápidas (bold, italic, heading, lista, tabela, código)
- Atalhos de teclado para todas as ações de formatação
- Suporte a paste de imagens direto da área de transferência
- Autocomplete de tags com `#tag`
- Referência cruzada com `[[conceito]]` para linkar ao grafo de conceitos

### 3.2 Implementação Recomendada

- **Opção A:** `super_editor` — editor composável e extensível, com controle profundo sobre o document model. Ideal para customização pesada.
- **Opção B:** `appflowy_editor` — editor block-based estilo Notion, com arquitetura moderna.
- **Opção C:** `flutter_quill` — editor delta-based mais maduro, com ecossistema maior de plugins.

> **Decisão de implementação:** Avaliar qual editor suporta melhor a renderização live de Markdown com LaTeX. Se nenhum atender, considerar `TextField` customizado com parser Markdown + renderização via `markdown_widget`.

### 3.3 Armazenamento

- Conteúdo salvo como **Markdown puro** na coluna `annotations.content` e `notebooks.content`
- Imagens embutidas salvas no diretório do projeto com referência relativa no Markdown
- Versionamento automático: snapshot salvo em `annotation_versions` a cada save com intervalo mínimo de 30 segundos

---

## 4. Tela de Grafo de Conceitos

```
┌─────────────────────────────────────────────────────────────────────┐
│  [← Voltar]  Grafo de Conceitos  │ Projeto: Filosofia Moderna      │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  [Filtros: ▾ Documento] [▾ Tipo de relação] [🔍 Buscar conceito]   │
│                                                                     │
│      ┌──────────┐                                                   │
│      │Empirismo │──── contradiz ────┌──────────────┐               │
│      └──────────┘                   │ Racionalismo │               │
│           │                         └──────────────┘               │
│        define                            │                          │
│           │                          suporta                        │
│      ┌──────────┐                        │                          │
│      │Tabula    │               ┌──────────────┐                   │
│      │Rasa      │               │ Cogito       │                   │
│      └──────────┘               └──────────────┘                   │
│                                                                     │
│  [+ Adicionar conceito]  [📥 Exportar PNG]  [📥 Exportar JSON]    │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

**Funcionalidades:**
- Canvas interativo com pan/zoom
- Layout automático force-directed
- Nós coloridos por tipo de conceito
- Arestas rotuladas com tipo de relação
- Clique em nó → navega para primeira ocorrência no PDF
- Filtros por documento e tipo de relação
- Exportar como PNG ou JSON (compatível com Obsidian)
- Adição manual ou via IA ao selecionar trecho

**Implementação:**
- `CustomPainter` com física force-directed para máximo controle e performance
- Fallback para `graphview` (Fruchterman-Reingold) se CustomPainter for muito complexo no prazo

---

## 5. Tela de Configurações

### 5.1 Configuração de Providers de IA

```
┌─────────────────────────────────────────────────────────────────────┐
│  Configurações > Providers de IA                                    │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  ┌─ OpenRouter ──────────────────────────────────────────────────┐  │
│  │ Status: ✅ Configurado                                        │  │
│  │ API Key: ●●●●●●●●●●●●ABCD  [Alterar]                        │  │
│  │ Modelo padrão: anthropic/claude-sonnet-4-6  [▾]              │  │
│  │ Modelo para resumos: anthropic/claude-haiku-4-5  [▾]         │  │
│  └───────────────────────────────────────────────────────────────┘  │
│                                                                     │
│  ┌─ Ollama (Local) ──────────────────────────────────────────────┐  │
│  │ Status: ✅ Rodando (localhost:11434)                          │  │
│  │ Modelos instalados: nomic-embed-text, llama3.2               │  │
│  │ Modelo para embeddings: nomic-embed-text  [▾]                │  │
│  └───────────────────────────────────────────────────────────────┘  │
│                                                                     │
│  ┌─ OpenAI (Direto) ────────────────────────────────────────────┐  │
│  │ Status: ⬜ Não configurado  [Configurar]                     │  │
│  └───────────────────────────────────────────────────────────────┘  │
│                                                                     │
│  ┌─ Anthropic (Direto) ─────────────────────────────────────────┐  │
│  │ Status: ⬜ Não configurado  [Configurar]                     │  │
│  └───────────────────────────────────────────────────────────────┘  │
│                                                                     │
│  ┌─ Roteamento de Tarefas ──────────────────────────────────────┐  │
│  │ Chat interativo:    OpenRouter (claude-sonnet)                │  │
│  │ Resumos batch:      OpenRouter (claude-haiku)                 │  │
│  │ Explicar/Resumir:   OpenRouter (claude-sonnet)                │  │
│  │ Embeddings:         Ollama (nomic-embed-text)                 │  │
│  │ [Personalizar roteamento]                                     │  │
│  └───────────────────────────────────────────────────────────────┘  │
│                                                                     │
│  ┌─ Dashboard de Custo ─────────────────────────────────────────┐  │
│  │ Tokens usados (este mês):  342.500 in / 89.200 out           │  │
│  │ Custo estimado:            US$ 0,18                           │  │
│  │ Cache hits:                 67%                                │  │
│  │ [Ver detalhes por projeto]                                    │  │
│  └───────────────────────────────────────────────────────────────┘  │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

### 5.2 Configurações Gerais

- **Tema:** Claro / Escuro / Sépia
- **Idioma da interface:** pt-BR / en-US
- **Idioma das respostas da IA:** pt-BR / en-US / auto (detectar do documento)
- **Teto de requisições por hora:** slider (5-100)
- **Processamento em background:** Automático / Apenas em idle / Manual
- **Diretório de projetos:** path customizável

---

## 6. Atalhos de Teclado

| Ação | Atalho |
|---|---|
| Alternar painel esquerdo | `Ctrl+B` |
| Alternar painel direito | `Ctrl+Shift+B` |
| Modo foco | `Ctrl+Shift+F` |
| Busca no projeto | `Ctrl+Shift+P` |
| Nova anotação | `Ctrl+Shift+N` |
| Abrir chat | `Ctrl+Shift+C` |
| Explicar seleção | `Ctrl+E` |
| Resumir seleção | `Ctrl+Shift+S` |
| Próxima página | `→` ou `PgDown` |
| Página anterior | `←` ou `PgUp` |
| Zoom in | `Ctrl++` |
| Zoom out | `Ctrl+-` |
| Undo (anotação) | `Ctrl+Z` |
| Redo (anotação) | `Ctrl+Shift+Z` |

---

## 7. Primeiro Uso (Onboarding)

No primeiro launch, o app mostra um wizard de configuração:

```
Passo 1: Bem-vindo ao Logoi
  "Configure suas fontes de IA para começar"

Passo 2: Checklist de Setup
  ✅ / ❌  OpenRouter (API key)     [Configurar]
  ✅ / ❌  Ollama (embeddings)      [Verificar]
  ⬜       OpenAI direto            [Opcional]
  ⬜       Anthropic direto         [Opcional]

  "Você precisa de pelo menos um provider configurado.
   Recomendamos OpenRouter + Ollama para a melhor experiência."

Passo 3: Criar primeiro projeto
  Nome: ___________
  Área: [▾ Filosofia]
  [Importar PDF]
```

Se nenhum provider estiver configurado, features de IA ficam desabilitadas com tooltip explicativo. O app continua funcional para leitura, anotações e busca FTS.

---

## 8. Indicadores de Status

### 8.1 Barra de Status do Documento

Exibida na barra superior:

```
⬜ imported    — "Texto disponível, leitura possível"
🔵 indexing   — "Embeddings sendo gerados (42%)" + barra de progresso
🟡 summarizing — "Resumos sendo gerados via API"
🟢 ready      — "Processamento completo"
⚠️ ollama_off  — "Ollama indisponível — busca semântica offline"
```

### 8.2 Indicadores de IA

Na aba de chat e nas respostas de IA:
- Provider e modelo em uso (ex: "OpenRouter → claude-sonnet")
- Token count da mensagem
- Tempo de resposta
- Indicador "do cache" quando resposta veio do cache
