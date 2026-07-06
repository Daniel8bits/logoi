import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/database.dart';
import '../../project/providers/project_providers.dart';
import '../models/selection.dart';
import '../repositories/document_repository.dart';

part 'reader_providers.g.dart';

@riverpod
DocumentRepository documentRepository(Ref ref) {
  final context = ref.watch(currentProjectProvider);
  if (context == null) {
    throw StateError('No project open');
  }
  return DocumentRepository(
    dao: context.db.documentDao,
    projectId: context.project.id,
  );
}

@riverpod
Stream<List<DocumentRow>> documentList(Ref ref) =>
    ref.watch(documentRepositoryProvider).watchDocuments();

@riverpod
Stream<DocumentRow?> documentById(Ref ref, String documentId) =>
    ref.watch(documentRepositoryProvider).watchDocument(documentId);

@riverpod
Future<List<StructureRow>> documentStructure(Ref ref, String documentId) =>
    ref.watch(documentRepositoryProvider).getStructure(documentId);

/// Reader UI state: open document, page, panel visibility, selection.
class ReaderState {
  const ReaderState({
    this.documentId,
    this.currentPage = 1,
    this.totalPages = 0,
    this.leftPanelVisible = true,
    this.rightPanelVisible = true,
    this.focusMode = false,
    this.selection,
    this.readingSessionId,
  });

  final String? documentId;
  final int currentPage;
  final int totalPages;
  final bool leftPanelVisible;
  final bool rightPanelVisible;
  final bool focusMode;
  final ReaderSelection? selection;
  final String? readingSessionId;

  ReaderState copyWith({
    String? documentId,
    int? currentPage,
    int? totalPages,
    bool? leftPanelVisible,
    bool? rightPanelVisible,
    bool? focusMode,
    ReaderSelection? selection,
    bool clearSelection = false,
    String? readingSessionId,
  }) =>
      ReaderState(
        documentId: documentId ?? this.documentId,
        currentPage: currentPage ?? this.currentPage,
        totalPages: totalPages ?? this.totalPages,
        leftPanelVisible: leftPanelVisible ?? this.leftPanelVisible,
        rightPanelVisible: rightPanelVisible ?? this.rightPanelVisible,
        focusMode: focusMode ?? this.focusMode,
        selection: clearSelection ? null : (selection ?? this.selection),
        readingSessionId: readingSessionId ?? this.readingSessionId,
      );
}

@Riverpod(keepAlive: true)
class Reader extends _$Reader {
  DateTime? _sessionStart;
  int _sessionStartPage = 1;

  @override
  ReaderState build() => const ReaderState();

  Future<void> openDocument(String documentId, {int? initialPage}) async {
    await closeDocument();
    final repository = ref.read(documentRepositoryProvider);
    final sessionId = await repository.startReadingSession(
      documentId,
      initialPage ?? 1,
    );
    _sessionStart = DateTime.now();
    _sessionStartPage = initialPage ?? 1;
    state = ReaderState(
      documentId: documentId,
      currentPage: initialPage ?? 1,
      readingSessionId: sessionId,
    );
  }

  Future<void> closeDocument() async {
    final sessionId = state.readingSessionId;
    if (sessionId != null && _sessionStart != null) {
      await ref.read(documentRepositoryProvider).endReadingSession(
            sessionId,
            state.currentPage,
            DateTime.now().difference(_sessionStart!),
          );
    }
    _sessionStart = null;
    _sessionStartPage = 1;
    state = const ReaderState();
  }

  void setPage(int page, {int? totalPages}) {
    state = state.copyWith(currentPage: page, totalPages: totalPages);
    final documentId = state.documentId;
    if (documentId != null && page != _sessionStartPage) {
      ref.read(documentRepositoryProvider).updateLastReadPage(documentId, page);
    }
  }

  void setSelection(ReaderSelection? selection) {
    state = selection == null
        ? state.copyWith(clearSelection: true)
        : state.copyWith(selection: selection);
  }

  void toggleLeftPanel() =>
      state = state.copyWith(leftPanelVisible: !state.leftPanelVisible);

  void toggleRightPanel() =>
      state = state.copyWith(rightPanelVisible: !state.rightPanelVisible);

  void toggleFocusMode() {
    final focus = !state.focusMode;
    state = state.copyWith(
      focusMode: focus,
      leftPanelVisible: !focus,
      rightPanelVisible: !focus,
    );
  }
}
