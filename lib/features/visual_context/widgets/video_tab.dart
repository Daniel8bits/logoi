import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../models/media_reference.dart';

class VideoTab extends StatefulWidget {
  const VideoTab({super.key, required this.videos});

  final List<MediaVideo> videos;

  @override
  State<VideoTab> createState() => _VideoTabState();
}

class _VideoTabState extends State<VideoTab> {
  String? _playingId;
  YoutubePlayerController? _controller;

  @override
  void dispose() {
    _controller?.close();
    super.dispose();
  }

  Future<void> _play(MediaVideo video) async {
    _controller?.close();
    final controller = YoutubePlayerController.fromVideoId(
      videoId: video.videoId,
      autoPlay: true,
      params: const YoutubePlayerParams(showFullscreenButton: true),
    );
    setState(() {
      _playingId = video.videoId;
      _controller = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.videos.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Nenhum vídeo encontrado.\n'
            'Configure a YouTube Data API em Configurações.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Column(
      children: [
        if (_controller != null)
          AspectRatio(
            aspectRatio: 16 / 9,
            child: YoutubePlayer(controller: _controller!),
          ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.videos.length,
            itemBuilder: (context, index) {
              final video = widget.videos[index];
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: CachedNetworkImage(
                    imageUrl: video.thumbnailUrl,
                    width: 80,
                    height: 45,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(video.title, maxLines: 2),
                subtitle: Text(video.channel ?? ''),
                selected: _playingId == video.videoId,
                onTap: () => _play(video),
                trailing: IconButton(
                  icon: const Icon(Icons.open_in_new),
                  onPressed: () => launchUrl(Uri.parse(video.watchUrl)),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
