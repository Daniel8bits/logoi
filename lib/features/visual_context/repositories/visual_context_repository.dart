import '../../../core/ai/router.dart';
import '../../../core/database/daos/media_dao.dart';
import '../models/media_reference.dart';
import '../services/image_search_service.dart';
import '../services/media_resolver.dart';
import '../services/video_search_service.dart';
import '../services/wikidata_service.dart';

class VisualContextRepository {
  VisualContextRepository({
    required MediaDao mediaDao,
    required String projectId,
    required ImageSearchService imageSearch,
    required VideoSearchService videoSearch,
    AIRouter? router,
  }) : _resolver = MediaResolver(
          mediaDao: mediaDao,
          projectId: projectId,
          wikidata: WikidataService(),
          imageSearch: imageSearch,
          videoSearch: videoSearch,
          router: router,
        );

  final MediaResolver _resolver;

  Future<MediaReferenceBundle> resolve({
    required String selectionText,
    String? documentTitle,
    int? pageNumber,
    String userLanguage = 'pt-BR',
    bool includeImages = true,
    bool includeVideos = true,
  }) =>
      _resolver.resolve(
        selectionText: selectionText,
        documentTitle: documentTitle,
        pageNumber: pageNumber,
        userLanguage: userLanguage,
        includeImages: includeImages,
        includeVideos: includeVideos,
      );
}
