import 'package:flutter_riverpod/legacy.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/database.dart';
import '../../../core/providers/ai_providers.dart';
import '../../project/providers/project_providers.dart';
import '../repositories/concept_repository.dart';

part 'concept_providers.g.dart';

@riverpod
Future<ConceptRepository?> conceptRepository(Ref ref) async {
  final context = ref.watch(currentProjectProvider);
  if (context == null) return null;
  final router = await ref.watch(aiRouterProvider.future);
  return ConceptRepository(
    dao: context.db.conceptDao,
    projectId: context.project.id,
    router: router,
  );
}

@riverpod
Stream<List<ConceptRow>> conceptList(Ref ref) async* {
  final repository = await ref.watch(conceptRepositoryProvider.future);
  if (repository == null) {
    yield const [];
    return;
  }
  yield* repository.watchConcepts();
}

@riverpod
Future<ConceptGraphData?> conceptGraph(Ref ref) async {
  // Rebuild the graph whenever the concept list changes.
  ref.watch(conceptListProvider);
  final repository = await ref.watch(conceptRepositoryProvider.future);
  return repository?.getGraph();
}

@riverpod
Future<List<CrossReferenceRow>> crossRefsForPage(
  Ref ref, {
  required String documentId,
  required int pageNumber,
}) async {
  final repository = await ref.watch(conceptRepositoryProvider.future);
  if (repository == null) return const [];
  return repository.getCrossRefsForPage(documentId, pageNumber);
}

/// Source passage of a manual cross-reference in progress
/// (docs/08_ROADMAP.md §3.6 — selecionar trecho A → vincular a trecho B).
class PendingCrossRefSource {
  const PendingCrossRefSource({
    required this.documentId,
    required this.pageNumber,
    required this.text,
  });

  final String documentId;
  final int pageNumber;
  final String text;
}

final pendingCrossRefProvider =
    StateProvider<PendingCrossRefSource?>((ref) => null);
