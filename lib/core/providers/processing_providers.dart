import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/project/providers/project_providers.dart';
import '../processing/embeddings.dart';
import '../processing/semantic_search.dart';
import '../processing/summary_service.dart';
import 'ai_providers.dart';
import 'core_providers.dart';

part 'processing_providers.g.dart';

@riverpod
EmbeddingIndexer? embeddingIndexer(Ref ref) {
  final context = ref.watch(currentProjectProvider);
  if (context == null) return null;
  return EmbeddingIndexer(
    documentDao: context.db.documentDao,
    ollama: ref.watch(ollamaServiceProvider),
  );
}

@riverpod
SemanticSearchService? semanticSearchService(Ref ref) {
  final context = ref.watch(currentProjectProvider);
  if (context == null) return null;
  return SemanticSearchService(
    documentDao: context.db.documentDao,
    ollama: ref.watch(ollamaServiceProvider),
  );
}

@riverpod
HybridSearchService? hybridSearchService(Ref ref) {
  final context = ref.watch(currentProjectProvider);
  final semantic = ref.watch(semanticSearchServiceProvider);
  if (context == null || semantic == null) return null;
  return HybridSearchService(
    searchDao: context.db.searchDao,
    semantic: semantic,
  );
}

@riverpod
Future<SummaryHierarchyService?> summaryService(Ref ref) async {
  final context = ref.watch(currentProjectProvider);
  if (context == null) return null;
  final router = await ref.watch(aiRouterProvider.future);
  if (router == null) return null;
  return SummaryHierarchyService(
    documentDao: context.db.documentDao,
    router: router,
  );
}

/// Per-document embedding indexing progress, for the status bar
/// (docs/05_PROCESSING.md §10 — `indexing... X%`).
@Riverpod(keepAlive: true)
class IndexingProgress extends _$IndexingProgress {
  @override
  Map<String, (int done, int total)> build() => const {};

  /// Runs stage 3 in background. Silently skips when Ollama is offline.
  Future<bool> indexDocument(String documentId) async {
    final indexer = ref.read(embeddingIndexerProvider);
    if (indexer == null || state.containsKey(documentId)) return false;

    state = {...state, documentId: (0, 1)};
    try {
      return await indexer.indexDocument(
        documentId,
        onProgress: (done, total) =>
            state = {...state, documentId: (done, total)},
      );
    } finally {
      state = {...state}..remove(documentId);
    }
  }
}
