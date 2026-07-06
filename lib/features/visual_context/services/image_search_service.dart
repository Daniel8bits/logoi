import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../settings/repositories/media_settings_repository.dart';
import '../models/media_reference.dart';

/// Wikimedia Commons image search (free).
class ImageSearchService {
  ImageSearchService({
    required MediaSettingsRepository mediaSettings,
    http.Client? client,
  })  : _mediaSettings = mediaSettings,
        _client = client ?? http.Client();

  final MediaSettingsRepository _mediaSettings;
  final http.Client _client;

  Future<List<MediaImage>> search(List<String> queries, {int limit = 12}) async {
    final results = <MediaImage>[];
    final seen = <String>{};

    for (final query in queries) {
      if (query.trim().isEmpty) continue;
      final commons = await _searchCommons(query, limit: limit ~/ 2);
      for (final img in commons) {
        if (seen.add(img.url)) results.add(img);
      }
    }

    final cseKey = await _mediaSettings.googleCseKey();
    final cseId = await _mediaSettings.googleCseId();
    if (cseKey != null && cseId != null && results.length < limit) {
      for (final query in queries.take(1)) {
        final cse = await _searchGoogleCse(query, cseKey, cseId);
        for (final img in cse) {
          if (seen.add(img.url) && results.length < limit) results.add(img);
        }
      }
    }

    return results;
  }

  Future<List<MediaImage>> _searchCommons(String query, {int limit = 6}) async {
    final url = Uri.parse(
      'https://commons.wikimedia.org/w/api.php'
      '?action=query&generator=search&gsrsearch=${Uri.encodeComponent(query)}'
      '&gsrlimit=$limit&prop=imageinfo&iiprop=url|thumburl&iiurlwidth=400&format=json',
    );
    final res = await _client.get(url);
    if (res.statusCode != 200) return const [];

    final json = jsonDecode(res.body) as Map<String, dynamic>;
    final pages = (json['query'] as Map?)?['pages'] as Map<String, dynamic>?;
    if (pages == null) return const [];

    return [
      for (final page in pages.values)
        if (page is Map<String, dynamic>)
          ...() {
            final info = (page['imageinfo'] as List?)?.first as Map?;
            if (info == null) return <MediaImage>[];
            return [
              MediaImage(
                url: info['url'] as String,
                thumbnailUrl: info['thumburl'] as String? ??
                    info['url'] as String,
                title: page['title'] as String?,
                source: 'Wikimedia Commons',
                license: 'Ver Commons',
              ),
            ];
          }(),
    ];
  }

  Future<List<MediaImage>> _searchGoogleCse(
    String query,
    String apiKey,
    String cseId,
  ) async {
    final url = Uri.parse(
      'https://www.googleapis.com/customsearch/v1'
      '?key=$apiKey&cx=$cseId&q=${Uri.encodeComponent(query)}'
      '&searchType=image&num=6',
    );
    final res = await _client.get(url);
    if (res.statusCode != 200) return const [];

    final json = jsonDecode(res.body) as Map<String, dynamic>;
    final items = json['items'] as List<dynamic>? ?? const [];
    return [
      for (final item in items)
        if (item is Map<String, dynamic>)
          MediaImage(
            url: item['link'] as String,
            thumbnailUrl: (item['image'] as Map?)?['thumbnailLink'] as String? ??
                item['link'] as String,
            title: item['title'] as String?,
            source: item['displayLink'] as String?,
          ),
    ];
  }
}
