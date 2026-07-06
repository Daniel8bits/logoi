import 'package:pdfrx/pdfrx.dart';

/// A TOC entry extracted from the PDF outline.
class TocEntry {
  const TocEntry({
    required this.title,
    required this.pageNumber,
    required this.level,
    this.children = const [],
  });

  final String title;
  final int pageNumber;
  final int level;
  final List<TocEntry> children;
}

/// Extraction result for a whole document.
class ExtractedDocument {
  const ExtractedDocument({
    required this.pageTexts,
    required this.toc,
    required this.totalPages,
    this.title,
    this.authors,
    this.year,
  });

  /// 1-based page number → raw text.
  final Map<int, String> pageTexts;
  final List<TocEntry> toc;
  final int totalPages;
  final String? title;
  final List<String>? authors;
  final int? year;
}

/// Text/TOC/metadata extraction via pdfrx (docs/02_ARCHITECTURE.md).
class PdfExtractor {
  const PdfExtractor();

  Future<ExtractedDocument> extract(String filePath) async {
    final document = await PdfDocument.openFile(filePath);
    try {
      final pageTexts = <int, String>{};
      for (final page in document.pages) {
        final text = await page.loadStructuredText();
        pageTexts[page.pageNumber] = text.fullText;
      }

      final outline = await document.loadOutline();
      final toc = _toTocEntries(outline, 1);

      final firstPage = pageTexts[1] ?? '';
      return ExtractedDocument(
        pageTexts: pageTexts,
        toc: toc,
        totalPages: document.pages.length,
        title: _guessTitle(firstPage),
        year: _guessYear(firstPage),
      );
    } finally {
      await document.dispose();
    }
  }

  List<TocEntry> _toTocEntries(List<PdfOutlineNode> nodes, int level) {
    return nodes
        .where((n) => n.dest != null)
        .map((n) => TocEntry(
              title: n.title,
              pageNumber: n.dest!.pageNumber,
              level: level,
              children: _toTocEntries(n.children, level + 1),
            ))
        .toList();
  }

  /// Heuristic: first reasonably long line of page 1 is the title candidate.
  String? _guessTitle(String firstPageText) {
    for (final line in firstPageText.split('\n')) {
      final t = line.trim();
      if (t.length >= 8 && t.length <= 200 && !RegExp(r'^\d+$').hasMatch(t)) {
        return t;
      }
    }
    return null;
  }

  /// Heuristic: a plausible publication year on the first page.
  int? _guessYear(String firstPageText) {
    final match = RegExp(r'\b(19|20)\d{2}\b').firstMatch(firstPageText);
    if (match == null) return null;
    final year = int.parse(match.group(0)!);
    final now = DateTime.now().year;
    return (year >= 1900 && year <= now) ? year : null;
  }
}
