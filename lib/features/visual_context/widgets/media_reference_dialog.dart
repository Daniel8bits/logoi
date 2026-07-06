import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/media_reference.dart';
import '../providers/visual_context_providers.dart';
import 'image_gallery_tab.dart';
import 'map_tab.dart';
import 'video_tab.dart';

enum MediaReferenceTab { map, images, videos, all }

Future<void> showMediaReferenceDialog(
  BuildContext context,
  WidgetRef ref, {
  required String selectionText,
  String? documentTitle,
  int? pageNumber,
  MediaReferenceTab initialTab = MediaReferenceTab.all,
}) =>
    showDialog<void>(
      context: context,
      builder: (_) => _MediaReferenceDialog(
        selectionText: selectionText,
        documentTitle: documentTitle,
        pageNumber: pageNumber,
        initialTab: initialTab,
      ),
    );

class _MediaReferenceDialog extends ConsumerWidget {
  const _MediaReferenceDialog({
    required this.selectionText,
    this.documentTitle,
    this.pageNumber,
    required this.initialTab,
  });

  final String selectionText;
  final String? documentTitle;
  final int? pageNumber;
  final MediaReferenceTab initialTab;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bundle = ref.watch(mediaReferenceBundleProvider(
      selectionText: selectionText,
      documentTitle: documentTitle,
      pageNumber: pageNumber,
    ));

    return Dialog(
      child: SizedBox(
        width: 900,
        height: 640,
        child: Column(
          children: [
            AppBar(
              title: Text('Referências: "${_truncate(selectionText, 40)}"'),
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            Expanded(
              child: bundle.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Erro: $e')),
                data: (data) {
                  if (data == null) {
                    return const Center(child: Text('Projeto não aberto'));
                  }
                  final b = data;
                  return DefaultTabController(
                    length: 3,
                    initialIndex: switch (initialTab) {
                      MediaReferenceTab.map => 0,
                      MediaReferenceTab.images => 1,
                      MediaReferenceTab.videos => 2,
                      MediaReferenceTab.all => 0,
                    },
                    child: Column(
                      children: [
                        TabBar(
                          tabs: [
                            Tab(
                              text: 'Mapa',
                              icon: b.entity.hasCoordinates ||
                                      b.entity.bboxNorth != null
                                  ? null
                                  : const Icon(Icons.block, size: 14),
                            ),
                            Tab(text: 'Imagens (${b.images.length})'),
                            Tab(text: 'Vídeos (${b.videos.length})'),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              MapTab(entity: b.entity),
                              ImageGalleryTab(images: b.images),
                              VideoTab(videos: b.videos),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String _truncate(String text, int max) =>
      text.length <= max ? text : '${text.substring(0, max)}…';
}
