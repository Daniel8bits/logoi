import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../../settings/repositories/media_settings_repository.dart';
import '../models/media_reference.dart';

/// YouTube Data API v3 search.
class VideoSearchService {
  VideoSearchService({
    required MediaSettingsRepository mediaSettings,
    http.Client? client,
  })  : _mediaSettings = mediaSettings,
        _client = client ?? http.Client();

  final MediaSettingsRepository _mediaSettings;
  final http.Client _client;

  Future<List<MediaVideo>> search(List<String> queries, {int limit = 8}) async {
    final apiKey = await _mediaSettings.youtubeApiKey();
    if (apiKey == null || apiKey.isEmpty) return const [];

    final results = <MediaVideo>[];
    final seen = <String>{};

    for (final query in queries) {
      if (query.trim().isEmpty || results.length >= limit) break;
      final url = Uri.parse(
        'https://www.googleapis.com/youtube/v3/search'
        '?part=snippet&type=video&maxResults=${limit ~/ 2}'
        '&q=${Uri.encodeComponent(query)}&key=$apiKey',
      );
      final res = await _client.get(url);
      if (res.statusCode != 200) continue;

      final json = jsonDecode(res.body) as Map<String, dynamic>;
      final items = json['items'] as List<dynamic>? ?? const [];
      for (final item in items) {
        if (item is! Map<String, dynamic>) continue;
        final id = (item['id'] as Map?)?['videoId'] as String?;
        if (id == null || !seen.add(id)) continue;
        final snippet = item['snippet'] as Map<String, dynamic>;
        final thumbs = snippet['thumbnails'] as Map<String, dynamic>?;
        final thumb = thumbs?['medium'] ?? thumbs?['default'];
        results.add(MediaVideo(
          videoId: id,
          title: snippet['title'] as String? ?? '',
          thumbnailUrl: (thumb as Map?)?['url'] as String? ?? '',
          channel: snippet['channelTitle'] as String?,
        ));
        if (results.length >= limit) break;
      }
    }
    return results;
  }

  Future<void> openExternally(MediaVideo video) async {
    final uri = Uri.parse(video.watchUrl);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }
}
