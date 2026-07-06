import 'dart:convert';

import 'package:drift/drift.dart';

import '../database.dart';
import '../tables/media_tables.dart';

part 'media_dao.drift.dart';

@DriftAccessor(tables: [MediaReferenceCache])
class MediaDao extends DatabaseAccessor<LogoiDatabase> with _$MediaDaoMixin {
  MediaDao(super.db);

  Future<String?> getCached(String cacheKey) async {
    final row = await (select(mediaReferenceCache)
          ..where((t) => t.cacheKey.equals(cacheKey)))
        .getSingleOrNull();
    return row?.payload;
  }

  Future<void> store({
    required String id,
    required String projectId,
    required String cacheKey,
    required String payload,
  }) =>
      into(mediaReferenceCache).insert(
        MediaReferenceCacheCompanion(
          id: Value(id),
          projectId: Value(projectId),
          cacheKey: Value(cacheKey),
          payload: Value(payload),
          createdAt: Value(DateTime.now().millisecondsSinceEpoch),
        ),
        mode: InsertMode.insertOrReplace,
      );
}
