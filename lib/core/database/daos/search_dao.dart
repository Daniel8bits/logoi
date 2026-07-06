import 'package:drift/drift.dart';

import '../database.dart';

part 'search_dao.drift.dart';

/// A single FTS5 search hit with highlighted snippet.
class FtsSearchHit {
  const FtsSearchHit({
    required this.documentId,
    required this.pageNumber,
    required this.snippet,
    required this.rank,
  });

  final String documentId;
  final int pageNumber;
  final String snippet;
  final double rank;
}

@DriftAccessor()
class SearchDao extends DatabaseAccessor<LogoiDatabase> with _$SearchDaoMixin {
  SearchDao(super.db);

  /// Full-text search over page contents (docs/05_PROCESSING.md — FTS5).
  Future<List<FtsSearchHit>> searchPages(
    String query, {
    String? documentId,
    int limit = 50,
  }) async {
    final sanitized = _sanitizeFtsQuery(query);
    if (sanitized.isEmpty) return const [];

    final docFilter = documentId != null ? 'AND pc.document_id = ?' : '';
    final rows = await customSelect(
      '''
      SELECT pc.document_id AS document_id,
             pc.page_number AS page_number,
             snippet(page_contents_fts, 0, '<b>', '</b>', '…', 12) AS snip,
             rank AS rank
      FROM page_contents_fts
      JOIN page_contents pc ON pc.rowid = page_contents_fts.rowid
      WHERE page_contents_fts MATCH ? $docFilter
      ORDER BY rank
      LIMIT ?
      ''',
      variables: [
        Variable.withString(sanitized),
        if (documentId != null) Variable.withString(documentId),
        Variable.withInt(limit),
      ],
      readsFrom: {db.pageContents},
    ).get();

    return rows
        .map((r) => FtsSearchHit(
              documentId: r.read<String>('document_id'),
              pageNumber: r.read<int>('page_number'),
              snippet: r.read<String>('snip'),
              rank: r.read<double>('rank'),
            ))
        .toList();
  }

  /// Escapes user input into a safe FTS5 prefix query.
  String _sanitizeFtsQuery(String raw) {
    final terms = raw
        .replaceAll(RegExp('["*()]'), ' ')
        .split(RegExp(r'\s+'))
        .where((t) => t.isNotEmpty)
        .map((t) => '"$t"*');
    return terms.join(' ');
  }
}
