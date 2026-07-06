import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../reader/providers/reader_providers.dart';
import '../../reader/widgets/pdf_view_panel.dart';
import '../providers/search_providers.dart';

/// Full-text search over the project (docs/06_UI_UX.md §2.1 — Busca tab).
class SearchPanel extends ConsumerStatefulWidget {
  const SearchPanel({super.key});

  @override
  ConsumerState<SearchPanel> createState() => _SearchPanelState();
}

class _SearchPanelState extends ConsumerState<SearchPanel> {
  String _query = '';
  bool _onlyCurrentDocument = false;

  @override
  Widget build(BuildContext context) {
    final documentId = ref.watch(readerProvider.select((s) => s.documentId));
    final results = ref.watch(hybridSearchProvider(
      query: _query,
      documentId: _onlyCurrentDocument ? documentId : null,
    ));

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Buscar no projeto…',
              prefixIcon: Icon(Icons.search, size: 18),
            ),
            onSubmitted: (value) => setState(() => _query = value),
          ),
        ),
        if (documentId != null)
          CheckboxListTile(
            dense: true,
            title: const Text('Apenas documento atual'),
            value: _onlyCurrentDocument,
            onChanged: (value) =>
                setState(() => _onlyCurrentDocument = value ?? false),
          ),
        Expanded(
          child: results.when(
            data: (hits) {
              if (_query.isEmpty) {
                return const Center(child: Text('Digite para buscar'));
              }
              if (hits.isEmpty) {
                return const Center(child: Text('Nenhum resultado'));
              }
              return ListView.builder(
                itemCount: hits.length,
                itemBuilder: (context, index) {
                  final hit = hits[index];
                  return ListTile(
                    dense: true,
                    title: Text(
                      hit.excerpt,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Row(
                      children: [
                        Text('p. ${hit.pageNumber}'),
                        if (hit.isSemantic) ...[
                          const SizedBox(width: 6),
                          const Tooltip(
                            message: 'Resultado semântico',
                            child: Icon(Icons.blur_on, size: 12),
                          ),
                        ],
                      ],
                    ),
                    onTap: () async {
                      final reader = ref.read(readerProvider.notifier);
                      final current = ref.read(readerProvider).documentId;
                      if (current != hit.documentId) {
                        await reader.openDocument(
                          hit.documentId,
                          initialPage: hit.pageNumber,
                        );
                      }
                      final controller =
                          ref.read(pdfViewerControllerProvider);
                      if (controller.isReady) {
                        await controller.goToPage(pageNumber: hit.pageNumber);
                      }
                    },
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Erro: $e')),
          ),
        ),
      ],
    );
  }
}
