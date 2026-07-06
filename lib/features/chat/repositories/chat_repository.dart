import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/ai/models.dart';
import '../../../core/ai/prompts/prompts.dart';
import '../../../core/ai/router.dart';
import '../../../core/cache/history_compressor.dart';
import '../../../core/database/daos/annotation_dao.dart';
import '../../../core/database/daos/chat_dao.dart';
import '../../../core/database/database.dart';
import '../../../core/processing/rag.dart';
import '../../../core/utils/result.dart';
import '../models/quick_mode.dart';

/// Everything the chat needs to know about the reading context.
class ChatDocumentContext {
  const ChatDocumentContext({
    required this.projectName,
    required this.projectId,
    this.projectArea,
    required this.userLanguage,
    this.documentId,
    this.documentTitle,
    this.documentAuthors,
    this.documentYear,
    this.currentPage = 1,
    this.totalPages = 0,
    this.selectedText,
    this.selectionLevel,
  });

  final String projectName;
  final String projectId;
  final String? projectArea;
  final String userLanguage;
  final String? documentId;
  final String? documentTitle;
  final String? documentAuthors;
  final int? documentYear;
  final int currentPage;
  final int totalPages;
  final String? selectedText;
  final SelectionLevel? selectionLevel;
}

/// Chat sessions, streaming messages and quick modes
/// (docs/04_AI_LAYER.md §3, §7).
class ChatRepository {
  ChatRepository({
    required ChatDao chatDao,
    required AnnotationDao annotationDao,
    required AIRouter router,
    required RAGContextBuilder ragBuilder,
  })  : _chatDao = chatDao,
        _annotationDao = annotationDao,
        _router = router,
        _ragBuilder = ragBuilder,
        _historyCompressor =
            ChatHistoryCompressor(chatDao: chatDao, router: router);

  final ChatDao _chatDao;
  final AnnotationDao _annotationDao;
  final AIRouter _router;
  final RAGContextBuilder _ragBuilder;
  final ChatHistoryCompressor _historyCompressor;
  static const _uuid = Uuid();

  /// Pages already retrieved in each session, penalized on re-retrieval
  /// (docs/05_PROCESSING.md §6.1 reranking).
  final _usedPagesBySession = <String, Set<int>>{};

  Stream<List<ChatSessionRow>> watchSessions(String projectId) =>
      _chatDao.watchByProject(projectId);

  Stream<List<ChatMessageRow>> watchMessages(String sessionId) =>
      _chatDao.watchMessages(sessionId);

  Future<Result<String, Failure>> createSession({
    required String projectId,
    String? documentId,
    String? title,
  }) async {
    try {
      final id = _uuid.v4();
      final route = _router.resolveRoute(AITask.chat);
      await _chatDao.insertSession(ChatSessionsCompanion(
        id: Value(id),
        projectId: Value(projectId),
        documentId: Value(documentId),
        title: Value(title),
        provider: Value(route.providerId),
        model: Value(route.model),
        createdAt: Value(DateTime.now().millisecondsSinceEpoch),
      ));
      return Result.ok(id);
    } catch (e) {
      return Result.error(DatabaseFailure('Falha ao criar sessão: $e'));
    }
  }

  Future<void> deleteSession(String sessionId) =>
      _chatDao.deleteSession(sessionId);

  /// Sends a user message and streams the assistant response.
  /// The returned stream yields accumulated assistant text.
  Stream<String> sendMessage({
    required String sessionId,
    required String userText,
    required ChatDocumentContext context,
    QuickMode? quickMode,
  }) async* {
    final now = DateTime.now().millisecondsSinceEpoch;
    await _chatDao.insertMessage(ChatMessagesCompanion(
      id: Value(_uuid.v4()),
      sessionId: Value(sessionId),
      role: const Value('user'),
      content: Value(userText),
      context: Value(context.selectedText != null
          ? '{"selectedText":${_jsonString(context.selectedText!)},'
              '"pageNumber":${context.currentPage},'
              '"selectionLevel":"${context.selectionLevel?.name ?? ''}"}'
          : null),
      createdAt: Value(now),
    ));

    final systemPrompt = await _buildSystemPrompt(context, quickMode, sessionId);
    final history = await _chatDao.getMessages(sessionId);
    final messages = <AIChatMessage>[
      AIChatMessage(role: AIChatRole.system, content: systemPrompt),
      for (final m in history)
        AIChatMessage(
          role: m.role == 'user'
              ? AIChatRole.user
              : m.role == 'assistant'
                  ? AIChatRole.assistant
                  : AIChatRole.system,
          content: m.content,
        ),
    ];

    final buffer = StringBuffer();
    await for (final chunk in _router.stream(
      task: quickMode?.task ?? AITask.chat,
      messages: messages,
      documentId: context.documentId,
    )) {
      buffer.write(chunk);
      yield buffer.toString();
    }

    await _chatDao.insertMessage(ChatMessagesCompanion(
      id: Value(_uuid.v4()),
      sessionId: Value(sessionId),
      role: const Value('assistant'),
      content: Value(buffer.toString()),
      createdAt: Value(DateTime.now().millisecondsSinceEpoch),
    ));

    await _historyCompressor.compressIfNeeded(sessionId);
  }

  /// Runs a JSON quick mode (flashcards, argument map, bias detection)
  /// as a one-shot completion (cached by the router).
  Future<Result<String, AIFailure>> runJsonMode({
    required QuickMode mode,
    required ChatDocumentContext context,
    bool forceRegenerate = false,
  }) async {
    final prompt = Prompts.forTask(mode.task).render(_promptValues(context));
    return _router.complete(
      task: mode.task,
      messages: [AIChatMessage(role: AIChatRole.system, content: prompt)],
      documentId: context.documentId,
      forceRegenerate: forceRegenerate,
    );
  }

  Future<String> _buildSystemPrompt(
    ChatDocumentContext context,
    QuickMode? quickMode,
    String sessionId,
  ) async {
    final values = _promptValues(context);
    final documentId = context.documentId;
    if (documentId != null) {
      final usedPages =
          _usedPagesBySession.putIfAbsent(sessionId, () => <int>{});
      final chunks = await _ragBuilder.build(
        documentId: documentId,
        currentPage: context.currentPage,
        query: context.selectedText,
        annotatedPages: await _annotationDao.getAnnotatedPages(documentId),
        penalizedPages: Set.of(usedPages),
      );
      usedPages.addAll(chunks.map((c) => c.pageNumber));
      values['rag_context'] = chunks.isEmpty
          ? '(no retrieved context)'
          : chunks.map((c) => '[p.${c.pageNumber}] ${c.text}').join('\n\n');
    } else {
      values['rag_context'] = '(no document open)';
    }
    final template =
        quickMode != null ? Prompts.forTask(quickMode.task) : Prompts.chatBase;
    return template.render(values);
  }

  Map<String, String?> _promptValues(ChatDocumentContext context) => {
        'project_name': context.projectName,
        'project_area': context.projectArea ?? 'general',
        'document_title': context.documentTitle ?? '(none)',
        'authors': context.documentAuthors ?? 'unknown',
        'year': context.documentYear?.toString() ?? 'n/d',
        'current_page': context.currentPage.toString(),
        'total_pages': context.totalPages.toString(),
        'selected_text': context.selectedText,
        'selection_level': context.selectionLevel?.name ?? 'paragraph',
        'user_language': context.userLanguage,
        'rag_context': '(no retrieved context)',
        'existing_concepts': '[]',
        'active_annotations': null,
      };

  static String _jsonString(String value) =>
      '"${value.replaceAll(r'\', r'\\').replaceAll('"', r'\"').replaceAll('\n', r'\n')}"';
}
