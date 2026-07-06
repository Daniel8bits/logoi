# Logoi — Stack Tecnológica e Dependências

> Documento complementar a `01_OVERVIEW.md` e `02_ARCHITECTURE.md`

---

## 1. Decisões Técnicas

### 1.1 Por que não usar `langchain_dart`

A spec original usava `langchain_dart` para abstração multi-provider. Removemos por:

1. **Overhead desnecessário** — o app precisa apenas de chamadas HTTP para APIs compatíveis com OpenAI format. O OpenRouter já é um gateway unificado.
2. **Dependências transitivas** — `langchain_dart` puxa sub-pacotes por provider, cada um com suas próprias dependências e ciclos de atualização.
3. **Controle fino** — com HTTP direto, temos controle total sobre retry, streaming, structured outputs e headers customizados (necessários para OpenRouter).
4. **OpenRouter como unificador** — para quem quer acesso a múltiplos providers com uma API, o OpenRouter faz a abstração na camada de rede. Não precisamos de uma segunda camada de abstração no código.

**Substituição:** Implementações diretas de `AIProvider` usando o pacote `http` do Dart. `OpenRouterProvider` e `DirectOpenAIProvider` compartilham >90% da lógica (mesmo formato de request/response).

### 1.2 Por que `flutter_secure_storage` em vez de `encrypt`

A spec original usava `encrypt` com chave derivada do machine ID. Problemas:

1. Machine IDs são previsíveis
2. Não protege contra acesso local
3. Implementação de criptografia custom é frágil

**Substituição:** `flutter_secure_storage` delega ao OS:
- macOS: Keychain
- Windows: Credential Manager (AES-GCM)
- Linux: libsecret (gnome-keyring / kwallet)

### 1.3 Editor de anotações Markdown

Três opções viáveis para avaliação durante implementação:

| Editor | Melhor para | Risco |
|---|---|---|
| `super_editor` | Customização profunda, document model flexível | Curva de aprendizado alta |
| `appflowy_editor` | UI block-based moderna (estilo Notion) | Pode ser pesado demais para anotações |
| `flutter_quill` | Ecossistema maduro, plugins existentes | Delta-based, não é Markdown nativo |

**Recomendação para Fable 5:** Começar com `super_editor` por ser o mais composável. Se a implementação de Markdown live preview se mostrar muito complexa, usar `flutter_quill` com conversão Markdown ↔ Delta.

### 1.4 Grafo de conceitos

**Recomendação:** `CustomPainter` com física force-directed implementada com Hooke's Law. Cálculos de força rodam em isolate separado. Isso dá controle total sobre rendering e performance.

**Fallback:** `graphview` com layout Fruchterman-Reingold se CustomPainter não for viável no prazo.

---

## 2. Dependências

### 2.1 Pacotes de Produção

```yaml
dependencies:
  flutter:
    sdk: flutter

  # ── PDF ──
  pdfrx: ^1.x
  # Renderização de alta fidelidade + extração de texto em desktop.
  # Baseado em PDFium. Melhor suporte a seleção de texto que alternativas.

  # ── Banco de Dados ──
  drift: ^2.x
  # ORM SQLite mais maduro para Flutter. Reactive queries, type-safe,
  # suporte completo a migrations, FTS5 e custom SQL.

  drift_flutter: ^0.x
  # Integração desktop do Drift (usa sqlite3 nativo, não WebView).

  sqlite3_flutter_libs: ^0.x
  # Binários SQLite compilados com FTS5 habilitado.

  # ── Estado ──
  flutter_riverpod: ^2.x
  # Gerenciamento de estado. Escala bem para apps complexos.
  # Suporte a code generation, async state, family providers.

  riverpod_annotation: ^2.x
  # Annotations para code generation do Riverpod.

  # ── UI / Layout ──
  multi_split_view: ^3.x
  # Painéis redimensionáveis com divisórias arrastáveis.

  super_editor: ^0.x
  # Editor de texto composável e extensível.
  # Alternativas: appflowy_editor, flutter_quill.
  # (Decisão final durante implementação da Fase 1)

  markdown_widget: ^2.x
  # Renderização de Markdown para exibição de anotações e respostas de IA.
  # Suporta custom builders, código com syntax highlighting.

  flutter_math_fork: ^0.x
  # Renderização de fórmulas LaTeX em widgets Flutter.
  # Para anotações com LaTeX inline e block.

  # ── HTTP / Networking ──
  http: ^1.x
  # Cliente HTTP para comunicação com OpenRouter, APIs diretas e Ollama.
  # Sem dependências extras. Suporte a streaming via response.stream.

  # ── Segurança ──
  flutter_secure_storage: ^9.x
  # Armazenamento seguro de API keys via OS keychain/credential manager.
  # macOS: Keychain, Windows: Credential Manager, Linux: libsecret.

  # ── Utilitários ──
  file_picker: ^8.x
  # Seleção de arquivos PDF para importação.

  path_provider: ^2.x
  # Diretórios de dados do app (Application Support, Documents).

  window_manager: ^0.x
  # Controle da janela desktop (tamanho, título dinâmico, posição).

  hotkey_manager: ^0.x
  # Atalhos de teclado globais para ações rápidas.

  uuid: ^4.x
  # Geração de UUIDs v4 para IDs de todas as entidades.

  intl: ^0.x
  # Internacionalização e formatação de datas/números.

  crypto: ^3.x
  # SHA-256 para cache keys e hashing de trechos de texto.

  freezed_annotation: ^2.x
  # Annotation para classes imutáveis (models, states).

  json_annotation: ^4.x
  # Annotation para serialização JSON.

  collection: ^1.x
  # Extensões de coleção (groupBy, sortBy, etc.).

  url_launcher: ^6.x
  # Abrir links externos no browser do sistema.

  shared_preferences: ^2.x
  # Preferências globais leves (tema, idioma, último projeto aberto).
  # Não usar para dados sensíveis — API keys vão para flutter_secure_storage.
```

### 2.2 Pacotes de Desenvolvimento

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter

  # ── Code Generation ──
  drift_dev: ^2.x
  # Gerador de código Drift (DAOs, migrations, schemas).

  riverpod_generator: ^2.x
  # Gerador de código Riverpod (@riverpod annotations).

  build_runner: ^2.x
  # Runner para code generation (drift_dev, riverpod_generator, freezed, json_serializable).

  freezed: ^2.x
  # Gerador de classes imutáveis com copyWith, == e toString.

  json_serializable: ^6.x
  # Gerador de fromJson/toJson para serialização JSON.

  # ── Testes ──
  mockito: ^5.x
  # Mocking para testes unitários.

  mocktail: ^1.x
  # Alternativa leve ao mockito (sem code generation).

  # ── Qualidade ──
  very_good_analysis: ^6.x
  # Lint rules rigorosas. Alternativa ao flutter_lints.
```

---

## 3. Pacotes Avaliados e Descartados

| Pacote | Razão do descarte |
|---|---|
| `langchain_dart` + sub-pacotes | Overhead desnecessário. OpenRouter + HTTP direto é mais simples e dá mais controle. |
| `encrypt` | Criptografia custom é frágil. `flutter_secure_storage` delega ao OS. |
| `dart_similarity` | Pacote pouco mantido. Similaridade cosseno é trivial de implementar (~10 linhas). |
| `isar` | NoSQL desnecessária. Drift + SQLite cobre todos os requisitos com FTS5, migrations e reactive queries. |
| `flutter_pdfview` | Usa WebView internamente. Péssimo para interação granular em desktop. |
| `graphview` | Funcional mas limitado. CustomPainter com force-directed dá mais controle. Mantido como fallback. |

---

## 4. Ferramentas Externas

### 4.1 Ollama (Opcional)

```bash
# Instalação:
# macOS: brew install ollama
# Linux: curl -fsSL https://ollama.com/install.sh | sh
# Windows: download do instalador em ollama.com

# Modelo necessário para embeddings:
ollama pull nomic-embed-text
```

O app detecta automaticamente se Ollama está rodando em `localhost:11434`. Se não estiver, features de embedding são desabilitadas silenciosamente.

### 4.2 OpenRouter

Requer conta em [openrouter.ai](https://openrouter.ai) e API key. O app guia o usuário no onboarding.

---

## 5. Requisitos de Sistema

| Componente | Mínimo | Recomendado |
|---|---|---|
| OS | Windows 10, macOS 11, Ubuntu 20.04 | Versões recentes |
| RAM | 4GB | 8GB+ |
| Disco | 500MB (app) + espaço para PDFs | 2GB+ |
| Tela | 1280×720 | 1920×1080+ |
| CPU | Dual-core | Quad-core+ |
| GPU | Não necessária | Qualquer (acelera Ollama) |

Requisitos adicionais com Ollama:
| Componente | Mínimo | Recomendado |
|---|---|---|
| RAM extra | +2GB (embeddings only) | +4GB (embeddings + geração) |
| Disco extra | +500MB (modelos) | +2GB |

---

## 6. Build e Distribuição

```bash
# Desenvolvimento
flutter run -d linux    # ou -d macos, -d windows

# Build de produção
flutter build linux --release --obfuscate --split-debug-info=build/debug-info
flutter build macos --release --obfuscate --split-debug-info=build/debug-info
flutter build windows --release --obfuscate --split-debug-info=build/debug-info
```

- `--obfuscate` para dificultar reverse engineering
- `--split-debug-info` para manter debug symbols separados (para crash reports)
