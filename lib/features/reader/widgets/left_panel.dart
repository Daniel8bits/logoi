import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database.dart';
import '../../concepts/widgets/concept_panel.dart';
import '../../search/widgets/search_panel.dart';
import '../providers/reader_providers.dart';
import 'pdf_view_panel.dart';

/// Left panel: TOC, search and document list (docs/06_UI_UX.md §2.1).
class LeftPanel extends ConsumerWidget {
  const LeftPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          const TabBar(
            tabAlignment: TabAlignment.fill,
            labelPadding: EdgeInsets.symmetric(horizontal: 4),
            tabs: [
              Tab(icon: Icon(Icons.toc, size: 18), text: 'TOC'),
              Tab(icon: Icon(Icons.search, size: 18), text: 'Busca'),
              Tab(icon: Icon(Icons.folder_outlined, size: 18), text: 'Docs'),
              Tab(icon: Icon(Icons.hub_outlined, size: 18), text: 'Grafo'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _TocTab(),
                const SearchPanel(),
                _DocumentsTab(),
                const ConceptPanel(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TocTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documentId = ref.watch(readerProvider.select((s) => s.documentId));
    if (documentId == null) {
      return const Center(child: Text('Nenhum documento aberto'));
    }
    final structure = ref.watch(documentStructureProvider(documentId));

    return structure.when(
      data: (nodes) {
        if (nodes.isEmpty) {
          return const Center(child: Text('Sem índice disponível'));
        }
        final byParent = <String?, List<StructureRow>>{};
        for (final node in nodes) {
          byParent.putIfAbsent(node.parentId, () => []).add(node);
        }
        return ListView(
          padding: const EdgeInsets.symmetric(vertical: 4),
          children: _buildTree(context, ref, byParent, null, 0),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Erro: $e')),
    );
  }

  List<Widget> _buildTree(
    BuildContext context,
    WidgetRef ref,
    Map<String?, List<StructureRow>> byParent,
    String? parentId,
    int depth,
  ) {
    final children = byParent[parentId] ?? const <StructureRow>[];
    return [
      for (final node in children) ...[
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.only(left: 12.0 + depth * 16, right: 8),
          title: Text(
            node.title ?? '(sem título)',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: depth == 0
                ? const TextStyle(fontWeight: FontWeight.w600)
                : null,
          ),
          trailing: Text('${node.pageStart}',
              style: Theme.of(context).textTheme.labelSmall),
          onTap: () {
            final controller = ref.read(pdfViewerControllerProvider);
            if (controller.isReady) {
              controller.goToPage(pageNumber: node.pageStart);
            }
          },
        ),
        ..._buildTree(context, ref, byParent, node.id, depth + 1),
      ],
    ];
  }
}

class _DocumentsTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documents = ref.watch(documentListProvider);
    final currentDocumentId =
        ref.watch(readerProvider.select((s) => s.documentId));

    return documents.when(
      data: (list) => ListView(
        padding: const EdgeInsets.symmetric(vertical: 4),
        children: [
          for (final doc in list)
            ListTile(
              dense: true,
              selected: doc.id == currentDocumentId,
              leading: const Icon(Icons.picture_as_pdf_outlined, size: 18),
              title: Text(
                doc.title ?? doc.fileName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text('status: ${doc.processingStatus}'),
              onTap: () => ref.read(readerProvider.notifier).openDocument(
                    doc.id,
                    initialPage: doc.lastReadPage > 0 ? doc.lastReadPage : 1,
                  ),
            ),
        ],
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Erro: $e')),
    );
  }
}
