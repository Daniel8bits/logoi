import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/daos/search_dao.dart';
import '../../../core/processing/semantic_search.dart';
import '../../../core/providers/processing_providers.dart';
import '../../project/providers/project_providers.dart';

part 'search_providers.g.dart';

/// FTS5 search in the current project (docs/08_ROADMAP.md §1.7).
@riverpod
Future<List<FtsSearchHit>> ftsSearch(
  Ref ref, {
  required String query,
  String? documentId,
}) async {
  if (query.trim().length < 2) return const [];
  final context = ref.watch(currentProjectProvider);
  if (context == null) return const [];
  return context.db.searchDao.searchPages(query, documentId: documentId);
}

/// Hybrid FTS5 + semantic search (docs/05_PROCESSING.md §6.4). Degrades
/// to pure lexical when Ollama is offline or embeddings are missing.
@riverpod
Future<List<HybridHit>> hybridSearch(
  Ref ref, {
  required String query,
  String? documentId,
}) async {
  if (query.trim().length < 2) return const [];
  final service = ref.watch(hybridSearchServiceProvider);
  if (service == null) return const [];
  return service.search(query, documentId: documentId);
}
