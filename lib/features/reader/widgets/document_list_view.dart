import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/core_providers.dart';
import '../../../core/providers/processing_providers.dart';
import '../providers/reader_providers.dart';

/// Shown when the project is open but no document is being read:
/// document list + PDF import.
class DocumentListView extends ConsumerStatefulWidget {
  const DocumentListView({super.key});

  @override
  ConsumerState<DocumentListView> createState() => _DocumentListViewState();
}

class _DocumentListViewState extends ConsumerState<DocumentListView> {
  bool _importing = false;
  String _importStatus = '';

  @override
  Widget build(BuildContext context) {
    final documents = ref.watch(documentListProvider);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Documentos', style: Theme.of(context).textTheme.headlineSmall),
              FilledButton.icon(
                icon: _importing
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.upload_file),
                label: Text(_importing ? _importStatus : 'Importar PDF'),
                onPressed: _importing ? null : _importPdf,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: documents.when(
              data: (list) => list.isEmpty
                  ? const Center(
                      child: Text('Nenhum documento. Importe um PDF para começar.'),
                    )
                  : ListView.separated(
                      itemCount: list.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final doc = list[index];
                        final progress = (doc.totalPages ?? 0) > 0
                            ? doc.lastReadPage / doc.totalPages!
                            : 0.0;
                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.picture_as_pdf_outlined),
                            title: Text(doc.title ?? doc.fileName),
                            subtitle: Text(
                              '${doc.totalPages ?? '?'} páginas · '
                              '${(progress * 100).toStringAsFixed(0)}% lido · '
                              'status: ${doc.processingStatus}',
                            ),
                            trailing: PopupMenuButton<String>(
                              itemBuilder: (_) => const [
                                PopupMenuItem(
                                    value: 'delete', child: Text('Excluir')),
                              ],
                              onSelected: (action) async {
                                if (action == 'delete') {
                                  await ref
                                      .read(documentRepositoryProvider)
                                      .deleteDocument(doc.id);
                                }
                              },
                            ),
                            onTap: () =>
                                ref.read(readerProvider.notifier).openDocument(
                                      doc.id,
                                      initialPage: doc.lastReadPage > 0
                                          ? doc.lastReadPage
                                          : 1,
                                    ),
                          ),
                        );
                      },
                    ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Erro: $e')),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _importPdf() async {
    final path = await ref.read(fileServiceProvider).pickPdf();
    if (path == null) return;

    setState(() {
      _importing = true;
      _importStatus = 'Importando…';
    });
    final result = await ref.read(documentRepositoryProvider).importPdf(
          path,
          onStatus: (status) {
            if (mounted) {
              setState(() => _importStatus = switch (status) {
                    'extracting' => 'Extraindo texto…',
                    'segmenting' => 'Segmentando…',
                    _ => status,
                  });
            }
          },
        );
    if (mounted) {
      setState(() => _importing = false);
      result.when(
        // Stage 3 (embeddings) runs in background; skips if Ollama is off.
        ok: (documentId) => ref
            .read(indexingProgressProvider.notifier)
            .indexDocument(documentId),
        error: (failure) => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(failure.message))),
      );
    }
  }
}
