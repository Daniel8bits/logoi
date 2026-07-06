/// Deterministic pre-API text compression pipeline
/// (docs/05_PROCESSING.md §4). Never removes semantic content —
/// only structural noise and formatting redundancy.
class TextCompressor {
  const TextCompressor();

  /// Stage 1: structural cleanup.
  String removeBoilerplate(String text) {
    final lines = text.split('\n');
    final kept = lines.where((line) {
      final t = line.trim();
      if (t.isEmpty) return true;
      // Isolated page numbers.
      if (RegExp(r'^\d{1,4}$').hasMatch(t)) return false;
      // Visual separators (dashes/underscores only).
      if (RegExp(r'^[-_—–=*]{3,}$').hasMatch(t)) return false;
      // Isolated ISBN / DOI / copyright lines.
      if (RegExp(r'^(ISBN[\s:]|DOI[\s:]|doi\.org|©|Copyright\b)', caseSensitive: false)
          .hasMatch(t)) {
        return false;
      }
      return true;
    });
    return kept.join('\n');
  }

  /// Stage 2: inline bibliographic citation removal.
  /// Removes markers only; surrounding text is preserved.
  String removeInlineCitations(String text) {
    var result = text;
    // (Author, 2020) / (Author, 2020, p. 42) / (Author et al., 2020)
    result = result.replaceAll(
      RegExp(r'\((?:cf\.\s*)?[A-ZÀ-Ú][\wÀ-ú.\s&-]{1,40},\s*\d{4}[a-z]?(?:,\s*p{1,2}\.\s*[\d–-]+)?\)'),
      '',
    );
    // Numeric citations: [1], [12, 13]
    result = result.replaceAll(RegExp(r'\[\d{1,3}(?:[,;\s]+\d{1,3})*\]'), '');
    // Alphanumeric keys: [Autor20]
    result = result.replaceAll(RegExp(r'\[[A-Z][a-zA-Z]+\d{2}\]'), '');
    // ibid. / op. cit.
    result = result.replaceAll(
      RegExp(r'\b(ibid\.|op\.\s*cit\.)', caseSensitive: false),
      '',
    );
    return result;
  }

  /// Stage 3: typographic normalization.
  String normalizeTypography(String text) {
    var result = text;
    // De-hyphenate line breaks: "pala-\nvra" → "palavra".
    result = result.replaceAllMapped(
      RegExp(r'(\w)-\n(\w)'),
      (m) => '${m.group(1)}${m.group(2)}',
    );
    // Normalize quotes, dashes, ellipsis.
    result = result
        .replaceAll(RegExp('[“”„]'), '"')
        .replaceAll(RegExp('[‘’‚]'), "'")
        .replaceAll('…', '...')
        .replaceAll(RegExp('[–—]'), '-');
    // Collapse whitespace.
    result = result.replaceAll(RegExp(r'[ \t]{2,}'), ' ');
    result = result.replaceAll(RegExp(r'\n{3,}'), '\n\n');
    return result;
  }

  /// Stage 4: footnote removal (footnotes are flagged during the heuristic
  /// import stage; here we drop common note-line patterns).
  String removeFootnotes(String text) {
    final lines = text.split('\n');
    final kept = lines.where((line) {
      final t = line.trim();
      // "1. Note text" footnote lines at very short lengths are ambiguous —
      // only drop clear superscript-style markers.
      return !RegExp(r'^\d{1,2}\s+[A-ZÀ-Ú].{0,200}$').hasMatch(t) ||
          t.length > 120;
    });
    return kept.join('\n');
  }

  /// Stage 5: light semantic compression — removes empty transition phrases.
  String compressRedundancy(String text) {
    const patterns = [
      // pt-BR
      r'Como (dito|mencionado|visto) anteriormente,?\s*',
      r'Vale ressaltar que\s*',
      r'É importante (notar|ressaltar|destacar) que\s*',
      r'Conforme mencionado(?: anteriormente)?,?\s*',
      r'Cabe destacar que\s*',
      // en-US
      r'As (mentioned|stated|noted) (before|previously|above),?\s*',
      r'It is (important|worth) (to note|noting) that\s*',
      r'Needless to say,?\s*',
    ];
    var result = text;
    for (final p in patterns) {
      result = result.replaceAll(RegExp(p, caseSensitive: false), '');
    }
    return result;
  }

  /// Full pipeline (docs/05_PROCESSING.md §4.1).
  String compress(String text) {
    return compressRedundancy(
      removeFootnotes(
        normalizeTypography(
          removeInlineCitations(
            removeBoilerplate(text),
          ),
        ),
      ),
    ).trim();
  }
}
