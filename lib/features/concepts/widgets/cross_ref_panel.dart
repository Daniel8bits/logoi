import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database.dart';
import '../../reader/providers/reader_providers.dart';
import '../../reader/widgets/pdf_view_panel.dart';
import '../providers/concept_providers.dart';

String crossRefRelationLabel(String type) => switch (type) {
      'corroborates' => 'Corrobora',
      'contradicts' => 'Contradiz',
      'extends' => 'Estende',
      'cites' => 'Cita',
      'exemplifies' => 'Exemplifica',
      _ => type,
    };

/// Cross references of the current page + manual linking flow
/// (docs/08_ROADMAP.md §3.6).
class CrossRefPanel extends ConsumerWidget {
  const CrossRefPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readerState = ref.watch(readerProvider);
    final pending = ref.watch(pendingCrossRefProvider);
    final documentId = readerState.documentId;

    if (documentId == null) {
      return const Center(child: Text('Nenhum documento aberto'));
    }

    final refs = ref.watch(crossRefsForPageProvider(
      documentId: documentId,
      pageNumber: readerState.currentPage,
    ));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (pending != null)
          MaterialBanner(
            content: Text(
              'Origem marcada (p. ${pending.pageNumber}): selecione o trecho '
              'alvo no PDF e use "Concluir vínculo" no menu de contexto.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            leading: const Icon(Icons.link, size: 18),
            actions: [
              TextButton(
                onPressed: () =>
                    ref.read(pendingCrossRefProvider.notifier).state = null,
                child: const Text('Cancelar'),
              ),
            ],
          )
        else
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              'Para vincular trechos: selecione o trecho A no PDF e use '
              '"Vincular trecho" no menu de contexto.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        const Divider(height: 1),
        Expanded(
          child: refs.when(
            data: (list) => list.isEmpty
                ? const Center(
                    child: Text('Nenhuma referência cruzada nesta página'))
                : ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) => _CrossRefTile(
                      crossRef: list[index],
                      currentDocumentId: documentId,
                    ),
                  ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Erro: $e')),
          ),
        ),
      ],
    );
  }
}

class _CrossRefTile extends ConsumerWidget {
  const _CrossRefTile({
    required this.crossRef,
    required this.currentDocumentId,
  });

  final CrossReferenceRow crossRef;
  final String currentDocumentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Show the "other side" of the reference relative to the current page.
    final showTarget = crossRef.sourceDocId == currentDocumentId;
    final otherDocId = showTarget ? crossRef.targetDocId : crossRef.sourceDocId;
    final otherPage = showTarget ? crossRef.targetPage : crossRef.sourcePage;
    final otherText = showTarget ? crossRef.targetText : crossRef.sourceText;
    final otherDoc = ref.watch(documentByIdProvider(otherDocId)).value;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        dense: true,
        title: Row(
          children: [
            Chip(
              label: Text(crossRefRelationLabel(crossRef.relationType)),
              visualDensity: VisualDensity.compact,
            ),
            if (crossRef.confidence != null) ...[
              const SizedBox(width: 6),
              Text(
                '${(crossRef.confidence! * 100).toStringAsFixed(0)}%',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ],
        ),
        subtitle: Text(
          '${otherDoc?.title ?? otherDoc?.fileName ?? '(documento)'}'
          ' · p. $otherPage\n"$otherText"',
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: PopupMenuButton<String>(
          iconSize: 16,
          itemBuilder: (_) => const [
            PopupMenuItem(value: 'go', child: Text('Ir para trecho')),
            PopupMenuItem(value: 'delete', child: Text('Excluir')),
          ],
          onSelected: (action) async {
            switch (action) {
              case 'go':
                final reader = ref.read(readerProvider.notifier);
                if (ref.read(readerProvider).documentId != otherDocId) {
                  await reader.openDocument(otherDocId, initialPage: otherPage);
                }
                final controller = ref.read(pdfViewerControllerProvider);
                if (controller.isReady) {
                  await controller.goToPage(pageNumber: otherPage);
                }
              case 'delete':
                final repository =
                    await ref.read(conceptRepositoryProvider.future);
                await repository?.deleteCrossReference(crossRef.id);
                ref.invalidate(crossRefsForPageProvider);
            }
          },
        ),
      ),
    );
  }
}
