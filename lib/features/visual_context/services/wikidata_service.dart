import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/media_reference.dart';

/// Wikidata entity lookup (free, no API key).
class WikidataService {
  WikidataService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Future<ResolvedEntity?> lookup(String term) async {
    final searchUrl = Uri.parse(
      'https://www.wikidata.org/w/api.php'
      '?action=wbsearchentities&search=${Uri.encodeComponent(term)}'
      '&language=pt|en&format=json&limit=3',
    );
    final searchRes = await _client.get(searchUrl);
    if (searchRes.statusCode != 200) return null;

    final searchJson = jsonDecode(searchRes.body) as Map<String, dynamic>;
    final hits = searchJson['search'] as List<dynamic>? ?? const [];
    if (hits.isEmpty) return null;

    final best = hits.first as Map<String, dynamic>;
    final id = best['id'] as String;
    final label = best['label'] as String? ?? term;
    final description = best['description'] as String?;

    final entityUrl = Uri.parse(
      'https://www.wikidata.org/wiki/Special:EntityData/$id.json',
    );
    final entityRes = await _client.get(entityUrl);
    if (entityRes.statusCode != 200) {
      return ResolvedEntity(
        entity: label,
        type: 'concept',
        modernEquivalent: description,
        wikidataId: id,
        imageQueries: [label, term],
        videoQueries: [label, term],
        confidence: 0.6,
      );
    }

    final entityJson =
        jsonDecode(entityRes.body) as Map<String, dynamic>;
    final entity = entityJson['entities'][id] as Map<String, dynamic>;
    final claims = entity['claims'] as Map<String, dynamic>? ?? const {};

    double? lat, lon;
    final coords = claims['P625'] as List<dynamic>?;
    if (coords != null && coords.isNotEmpty) {
      final data = (coords.first as Map)['mainsnak']['datavalue']['value']
          as Map<String, dynamic>;
      lat = (data['latitude'] as num).toDouble();
      lon = (data['longitude'] as num).toDouble();
    }

    return ResolvedEntity(
      entity: label,
      type: lat != null ? 'place' : 'concept',
      modernEquivalent: description,
      wikidataId: id,
      latitude: lat,
      longitude: lon,
      imageQueries: [label, if (description != null) description, term],
      videoQueries: [label, term],
      confidence: 0.85,
    );
  }
}
