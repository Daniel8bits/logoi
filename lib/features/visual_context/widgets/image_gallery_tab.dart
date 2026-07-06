import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../models/media_reference.dart';

class ImageGalleryTab extends StatelessWidget {
  const ImageGalleryTab({super.key, required this.images});

  final List<MediaImage> images;

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return const Center(child: Text('Nenhuma imagem encontrada.'));
    }
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) {
        final image = images[index];
        return InkWell(
          onTap: () => _openLightbox(context, image),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: CachedNetworkImage(
                    imageUrl: image.thumbnailUrl,
                    fit: BoxFit.cover,
                    placeholder: (_, _) => const ColoredBox(
                      color: Color(0xFFE0E0E0),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    errorWidget: (_, _, _) => const Icon(Icons.broken_image),
                  ),
                ),
              ),
              if (image.title != null)
                Text(
                  image.title!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
            ],
          ),
        );
      },
    );
  }

  void _openLightbox(BuildContext context, MediaImage image) {
    showDialog<void>(
      context: context,
      builder: (ctx) => Dialog(
        child: SizedBox(
          width: 720,
          height: 520,
          child: Column(
            children: [
              AppBar(
                title: Text(image.title ?? 'Imagem'),
                automaticallyImplyLeading: false,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              Expanded(
                child: PhotoView(
                  imageProvider: CachedNetworkImageProvider(image.url),
                  backgroundDecoration: const BoxDecoration(color: Colors.black),
                ),
              ),
              if (image.source != null)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text('Fonte: ${image.source} · ${image.license ?? ''}'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
