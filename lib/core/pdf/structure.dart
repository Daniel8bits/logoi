import 'extractor.dart';

/// A flattened structural node ready for persistence in document_structure.
class StructureNode {
  const StructureNode({
    required this.title,
    required this.level,
    required this.pageStart,
    required this.pageEnd,
    required this.orderIndex,
    this.parentIndex,
  });

  final String title;

  /// 1=section, 2=chapter, 3=document (docs/03_DATABASE.md §3.6).
  final int level;
  final int pageStart;
  final int pageEnd;
  final int orderIndex;

  /// Index into the flattened list; null for roots.
  final int? parentIndex;
}

/// Builds the basic structural map from the TOC without AI
/// (docs/05_PROCESSING.md — Level 2 heuristics).
class StructureBuilder {
  const StructureBuilder();

  /// Flattens the TOC into structure nodes with computed page ranges.
  /// TOC depth 1 → chapter (level 2); depth 2+ → section (level 1).
  List<StructureNode> build(List<TocEntry> toc, int totalPages) {
    if (toc.isEmpty) {
      return [
        StructureNode(
          title: 'Documento',
          level: 3,
          pageStart: 1,
          pageEnd: totalPages,
          orderIndex: 0,
        ),
      ];
    }

    final nodes = <StructureNode>[];
    var order = 0;

    void visit(List<TocEntry> entries, int? parentIndex, int parentEnd) {
      for (var i = 0; i < entries.length; i++) {
        final entry = entries[i];
        final nextStart =
            i + 1 < entries.length ? entries[i + 1].pageNumber - 1 : parentEnd;
        final pageEnd = nextStart.clamp(entry.pageNumber, totalPages);
        final level = entry.level == 1 ? 2 : 1;
        final index = nodes.length;
        nodes.add(StructureNode(
          title: entry.title,
          level: level,
          pageStart: entry.pageNumber,
          pageEnd: pageEnd,
          orderIndex: order++,
          parentIndex: parentIndex,
        ));
        visit(entry.children, index, pageEnd);
      }
    }

    visit(toc, null, totalPages);
    return nodes;
  }
}
