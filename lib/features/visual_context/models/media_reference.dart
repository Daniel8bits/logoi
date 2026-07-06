import 'dart:convert';

/// Resolved entity for visual references (map, images, videos).
class ResolvedEntity {
  const ResolvedEntity({
    required this.entity,
    required this.type,
    this.modernEquivalent,
    this.wikidataId,
    this.latitude,
    this.longitude,
    this.bboxNorth,
    this.bboxSouth,
    this.bboxEast,
    this.bboxWest,
    this.imageQueries = const [],
    this.videoQueries = const [],
    this.confidence = 1.0,
  });

  final String entity;
  final String type;
  final String? modernEquivalent;
  final String? wikidataId;
  final double? latitude;
  final double? longitude;
  final double? bboxNorth;
  final double? bboxSouth;
  final double? bboxEast;
  final double? bboxWest;
  final List<String> imageQueries;
  final List<String> videoQueries;
  final double confidence;

  bool get hasCoordinates => latitude != null && longitude != null;

  Map<String, dynamic> toJson() => {
        'entity': entity,
        'type': type,
        'modernEquivalent': modernEquivalent,
        'wikidataId': wikidataId,
        'latitude': latitude,
        'longitude': longitude,
        'bboxNorth': bboxNorth,
        'bboxSouth': bboxSouth,
        'bboxEast': bboxEast,
        'bboxWest': bboxWest,
        'imageQueries': imageQueries,
        'videoQueries': videoQueries,
        'confidence': confidence,
      };

  factory ResolvedEntity.fromJson(Map<String, dynamic> json) => ResolvedEntity(
        entity: json['entity'] as String? ?? '',
        type: json['type'] as String? ?? 'concept',
        modernEquivalent: json['modernEquivalent'] as String?,
        wikidataId:
            json['wikidata_id'] as String? ?? json['wikidataId'] as String?,
        latitude: (json['latitude'] as num?)?.toDouble() ??
            ((json['coordinates'] as Map<String, dynamic>?)?['lat'] as num?)
                ?.toDouble(),
        longitude: (json['longitude'] as num?)?.toDouble() ??
            ((json['coordinates'] as Map<String, dynamic>?)?['lon'] as num?)
                ?.toDouble(),
        bboxNorth: (json['bboxNorth'] as num?)?.toDouble(),
        bboxSouth: (json['bboxSouth'] as num?)?.toDouble(),
        bboxEast: (json['bboxEast'] as num?)?.toDouble(),
        bboxWest: (json['bboxWest'] as num?)?.toDouble(),
        imageQueries: (json['image_queries'] as List? ??
                json['imageQueries'] as List? ??
                const [])
            .cast<String>(),
        videoQueries: (json['video_queries'] as List? ??
                json['videoQueries'] as List? ??
                const [])
            .cast<String>(),
        confidence: (json['confidence'] as num?)?.toDouble() ?? 1.0,
      );
}

class MediaImage {
  const MediaImage({
    required this.url,
    required this.thumbnailUrl,
    this.title,
    this.source,
    this.license,
  });

  final String url;
  final String thumbnailUrl;
  final String? title;
  final String? source;
  final String? license;

  Map<String, dynamic> toJson() => {
        'url': url,
        'thumbnailUrl': thumbnailUrl,
        'title': title,
        'source': source,
        'license': license,
      };

  factory MediaImage.fromJson(Map<String, dynamic> json) => MediaImage(
        url: json['url'] as String,
        thumbnailUrl: json['thumbnailUrl'] as String? ?? json['url'] as String,
        title: json['title'] as String?,
        source: json['source'] as String?,
        license: json['license'] as String?,
      );
}

class MediaVideo {
  const MediaVideo({
    required this.videoId,
    required this.title,
    required this.thumbnailUrl,
    this.channel,
  });

  final String videoId;
  final String title;
  final String thumbnailUrl;
  final String? channel;

  String get watchUrl => 'https://www.youtube.com/watch?v=$videoId';

  Map<String, dynamic> toJson() => {
        'videoId': videoId,
        'title': title,
        'thumbnailUrl': thumbnailUrl,
        'channel': channel,
      };

  factory MediaVideo.fromJson(Map<String, dynamic> json) => MediaVideo(
        videoId: json['videoId'] as String,
        title: json['title'] as String? ?? '',
        thumbnailUrl: json['thumbnailUrl'] as String? ?? '',
        channel: json['channel'] as String?,
      );
}

/// Full bundle for the media reference dialog.
class MediaReferenceBundle {
  const MediaReferenceBundle({
    required this.entity,
    required this.selectionText,
    this.images = const [],
    this.videos = const [],
  });

  final ResolvedEntity entity;
  final String selectionText;
  final List<MediaImage> images;
  final List<MediaVideo> videos;

  Map<String, dynamic> toJson() => {
        'entity': entity.toJson(),
        'selectionText': selectionText,
        'images': images.map((i) => i.toJson()).toList(),
        'videos': videos.map((v) => v.toJson()).toList(),
      };

  factory MediaReferenceBundle.fromJson(Map<String, dynamic> json) =>
      MediaReferenceBundle(
        entity: ResolvedEntity.fromJson(
            json['entity'] as Map<String, dynamic>? ?? const {}),
        selectionText: json['selectionText'] as String? ?? '',
        images: (json['images'] as List? ?? const [])
            .cast<Map<String, dynamic>>()
            .map(MediaImage.fromJson)
            .toList(),
        videos: (json['videos'] as List? ?? const [])
            .cast<Map<String, dynamic>>()
            .map(MediaVideo.fromJson)
            .toList(),
      );

  String toJsonString() => jsonEncode(toJson());

  factory MediaReferenceBundle.fromJsonString(String raw) =>
      MediaReferenceBundle.fromJson(
          jsonDecode(raw) as Map<String, dynamic>);
}
