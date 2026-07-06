import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/ai/models.dart';
import '../../../core/database/database.dart';
import '../../../core/processing/rag.dart';
import '../../../core/providers/ai_providers.dart';
import '../../../core/providers/processing_providers.dart';
import '../../project/providers/project_providers.dart';
import '../../reader/providers/reader_providers.dart';
import '../models/quick_mode.dart';
import '../repositories/chat_repository.dart';

part 'chat_providers.g.dart';

@riverpod
Future<ChatRepository?> chatRepository(Ref ref) async {
  final context = ref.watch(currentProjectProvider);
  if (context == null) return null;
  final router = await ref.watch(aiRouterProvider.future);
  if (router == null) return null;
  return ChatRepository(
    chatDao: context.db.chatDao,
    annotationDao: context.db.annotationDao,
    router: router,
    ragBuilder: RAGContextBuilder(
      documentDao: context.db.documentDao,
      searchDao: context.db.searchDao,
      semanticSearch: ref.watch(semanticSearchServiceProvider),
    ),
  );
}

@riverpod
Stream<List<ChatSessionRow>> chatSessions(Ref ref) async* {
  final context = ref.watch(currentProjectProvider);
  final repository = await ref.watch(chatRepositoryProvider.future);
  if (context == null || repository == null) {
    yield const [];
    return;
  }
  yield* repository.watchSessions(context.project.id);
}

@riverpod
Stream<List<ChatMessageRow>> chatMessages(Ref ref, String sessionId) async* {
  final repository = await ref.watch(chatRepositoryProvider.future);
  if (repository == null) {
    yield const [];
    return;
  }
  yield* repository.watchMessages(sessionId);
}

/// Builds the current ChatDocumentContext from project + reader state.
@riverpod
Future<ChatDocumentContext?> chatContext(Ref ref) async {
  final project = ref.watch(currentProjectProvider);
  if (project == null) return null;
  final readerState = ref.watch(readerProvider);
  final selection = readerState.selection;

  String? documentTitle;
  String? documentAuthors;
  int? documentYear;
  if (readerState.documentId != null) {
    final doc = await ref
        .watch(documentByIdProvider(readerState.documentId!).future);
    documentTitle = doc?.title ?? doc?.fileName;
    documentAuthors = doc?.authors;
    documentYear = doc?.year;
  }

  return ChatDocumentContext(
    projectName: project.project.name,
    projectId: project.project.id,
    projectArea: project.project.area,
    userLanguage: project.project.language,
    documentId: readerState.documentId,
    documentTitle: documentTitle,
    documentAuthors: documentAuthors,
    documentYear: documentYear,
    currentPage: readerState.currentPage,
    totalPages: readerState.totalPages,
    selectedText: selection?.text,
    selectionLevel: selection != null ? SelectionLevel.paragraph : null,
  );
}

/// State of the active chat: session + in-flight streaming response.
class ActiveChatState {
  const ActiveChatState({
    this.sessionId,
    this.streamingText,
    this.error,
    this.pendingQuickMode,
  });

  final String? sessionId;
  final String? streamingText;
  final String? error;
  final QuickMode? pendingQuickMode;

  bool get isStreaming => streamingText != null;
}

@Riverpod(keepAlive: true)
class ActiveChat extends _$ActiveChat {
  DateTime? _lastSendAt;

  @override
  ActiveChatState build() => const ActiveChatState();

  void selectSession(String? sessionId) =>
      state = ActiveChatState(sessionId: sessionId);

  Future<void> send(String text, {QuickMode? quickMode}) async {
    if (state.isStreaming) return;
    final now = DateTime.now();
    if (_lastSendAt != null &&
        now.difference(_lastSendAt!) < const Duration(milliseconds: 800)) {
      return;
    }
    _lastSendAt = now;

    final repository = await ref.read(chatRepositoryProvider.future);
    final context = await ref.read(chatContextProvider.future);
    if (repository == null || context == null) {
      state = ActiveChatState(
        sessionId: state.sessionId,
        error: 'Configure um provider de IA nas configurações.',
      );
      return;
    }

    var sessionId = state.sessionId;
    if (sessionId == null) {
      final result = await repository.createSession(
        projectId: context.projectId,
        documentId: context.documentId,
        title: text.length > 40 ? '${text.substring(0, 40)}…' : text,
      );
      sessionId = result.valueOrNull;
      if (sessionId == null) {
        state = ActiveChatState(error: result.errorOrNull?.message);
        return;
      }
    }

    state = ActiveChatState(sessionId: sessionId, streamingText: '');
    try {
      await for (final accumulated in repository.sendMessage(
        sessionId: sessionId,
        userText: text,
        context: context,
        quickMode: quickMode,
      )) {
        state = ActiveChatState(sessionId: sessionId, streamingText: accumulated);
      }
      state = ActiveChatState(sessionId: sessionId);
    } catch (e) {
      state = ActiveChatState(sessionId: sessionId, error: e.toString());
    }
  }
}
