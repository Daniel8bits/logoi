/// Heuristic segmentation into paragraphs and sentences
/// (docs/05_PROCESSING.md — Level 2).
class TextSegmenter {
  const TextSegmenter();

  /// Splits a page's raw text into paragraphs.
  ///
  /// Uses blank lines as hard boundaries and merges wrapped lines that do
  /// not end a sentence (approximation of vertical-spacing analysis on
  /// already-linearized text).
  List<String> segmentParagraphs(String pageText) {
    final paragraphs = <String>[];
    final buffer = StringBuffer();

    void flush() {
      final text = buffer.toString().trim();
      if (text.isNotEmpty) paragraphs.add(text);
      buffer.clear();
    }

    for (final rawLine in pageText.split('\n')) {
      final line = rawLine.trimRight();
      if (line.trim().isEmpty) {
        flush();
        continue;
      }
      if (buffer.isNotEmpty) {
        final previous = buffer.toString();
        // A sentence-ending previous line followed by a capitalized/indented
        // line starts a new paragraph.
        final endsSentence = RegExp(r'[.!?:]["\u201d\u2019]?$').hasMatch(previous.trimRight());
        final startsNew = RegExp(r'^(\s{2,}|[A-ZÀ-Ú•\-\d])').hasMatch(rawLine) &&
            rawLine.startsWith(RegExp(r'\s'));
        if (endsSentence && startsNew) {
          flush();
        } else {
          buffer.write(' ');
        }
      }
      buffer.write(line.trim());
    }
    flush();
    return paragraphs;
  }

  /// Splits a paragraph into sentences using punctuation rules.
  ///
  /// Avoids splitting on common abbreviations (pt-BR and en-US).
  List<String> segmentSentences(String paragraph) {
    const abbreviations = {
      'dr', 'dra', 'sr', 'sra', 'prof', 'profa', 'etc', 'ex', 'cf', 'p',
      'pp', 'vol', 'ed', 'org', 'trad', 'mr', 'mrs', 'ms', 'st', 'no',
      'vs', 'fig', 'cap', 'art', 'inc', 'jr',
    };

    final sentences = <String>[];
    final buffer = StringBuffer();
    final chars = paragraph.trim();

    for (var i = 0; i < chars.length; i++) {
      buffer.write(chars[i]);
      if ('.!?'.contains(chars[i])) {
        final soFar = buffer.toString();
        final lastWord = RegExp(r'(\w+)\.$').firstMatch(soFar)?.group(1);
        final isAbbreviation =
            lastWord != null && abbreviations.contains(lastWord.toLowerCase());
        final isDecimal = lastWord != null && RegExp(r'^\d+$').hasMatch(lastWord);
        final nextIsUpperOrEnd = i + 2 >= chars.length ||
            RegExp(r'^\s+["\u201c]?[A-ZÀ-Ú0-9]').hasMatch(chars.substring(i + 1));
        if (!isAbbreviation && !isDecimal && nextIsUpperOrEnd) {
          final sentence = soFar.trim();
          if (sentence.isNotEmpty) sentences.add(sentence);
          buffer.clear();
        }
      }
    }
    final rest = buffer.toString().trim();
    if (rest.isNotEmpty) sentences.add(rest);
    return sentences;
  }
}
