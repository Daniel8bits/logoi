import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:uuid/uuid.dart';

import '../../../core/ai/models.dart';
import '../../../core/ai/prompts/prompts.dart';
import '../../../core/ai/response_parser.dart';
import '../../../core/ai/router.dart';
import '../../../core/database/daos/media_dao.dart';
import '../models/media_reference.dart';
import 'image_search_service.dart';
import 'video_search_service.dart';
import 'wikidata_service.dart';

/// Orchestrates Wikidata → AI → image/video search for visual references.
class MediaResolver {
  MediaResolver({
    required MediaDao mediaDao,
    required String projectId,
    required WikidataService wikidata,
    required ImageSearchService imageSearch,
    required VideoSearchService videoSearch,
    AIRouter? router,
    JSONResponseParser parser = const JSONResponseParser(),
  })  : _mediaDao = mediaDao,
        _projectId = projectId,
        _wikidata = wikidata,
        _imageSearch = imageSearch,
        _videoSearch = videoSearch,
        _router = router,
        _parser = parser;

  final MediaDao _mediaDao;
  final String _projectId;
  final WikidataService _wikidata;
  final ImageSearchService _imageSearch;
  final VideoSearchService _videoSearch;
  final AIRouter? _router;
  final JSONResponseParser _parser;
  static const _uuid = Uuid();

  Future<MediaReferenceBundle> resolve({
    required String selectionText,
    String? documentTitle,
    int? pageNumber,
    String userLanguage = 'pt-BR',
    bool includeImages = true,
    bool includeVideos = true,
  }) async {
    final cacheKey = _cacheKey(selectionText, documentTitle, pageNumber);
    final cached = await _mediaDao.getCached(cacheKey);
    if (cached != null) {
      return MediaReferenceBundle.fromJsonString(cached);
    }

    var entity = await _wikidata.lookup(selectionText.trim());
    if (entity == null || entity.confidence < 0.7) {
      entity = await _resolveWithAi(
            selectionText: selectionText,
            documentTitle: documentTitle,
            pageNumber: pageNumber,
            userLanguage: userLanguage,
          ) ??
          entity ??
          ResolvedEntity(
            entity: selectionText.trim(),
            type: 'concept',
            imageQueries: [selectionText.trim()],
            videoQueries: [selectionText.trim()],
            confidence: 0.3,
          );
    }

    final images = includeImages
        ? await _imageSearch.search(
            entity.imageQueries.isEmpty
                ? [entity.entity, selectionText]
                : entity.imageQueries,
          )
        : const <MediaImage>[];

    final videos = includeVideos
        ? await _videoSearch.search(
            entity.videoQueries.isEmpty
                ? [entity.entity, selectionText]
                : entity.videoQueries,
          )
        : const <MediaVideo>[];

    final bundle = MediaReferenceBundle(
      entity: entity,
      selectionText: selectionText,
      images: images,
      videos: videos,
    );

    await _mediaDao.store(
      id: _uuid.v4(),
      projectId: _projectId,
      cacheKey: cacheKey,
      payload: bundle.toJsonString(),
    );
    return bundle;
  }

  Future<ResolvedEntity?> _resolveWithAi({
    required String selectionText,
    String? documentTitle,
    int? pageNumber,
    required String userLanguage,
  }) async {
    final router = _router;
    if (router == null) return null;

    final prompt = Prompts.entityResolution.render({
      'document_title': documentTitle ?? '(documento)',
      'current_page': pageNumber?.toString() ?? '?',
      'selected_text': selectionText,
      'user_language': userLanguage,
    });

    final result = await router.complete(
      task: AITask.entityResolution,
      messages: [AIChatMessage(role: AIChatRole.system, content: prompt)],
    );
    final raw = result.valueOrNull;
    if (raw == null) return null;

    final parsed = _parser.parse(raw);
    final json = parsed.valueOrNull;
    if (json == null) return null;
    return ResolvedEntity.fromJson(json);
  }

  String _cacheKey(String text, String? doc, int? page) {
    final input = '$text|${doc ?? ''}|${page ?? 0}';
    return sha256.convert(utf8.encode(input)).toString();
  }
}
