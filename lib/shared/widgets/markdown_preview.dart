import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:markdown/markdown.dart' as m;
import 'package:markdown_widget/markdown_widget.dart';

/// Markdown renderer with LaTeX support (docs/06_UI_UX.md §3.1):
/// inline `$...$` and block `$$...$$` via flutter_math_fork.
class MarkdownPreview extends StatelessWidget {
  const MarkdownPreview({
    super.key,
    required this.data,
    this.shrinkWrap = true,
    this.selectable = true,
  });

  final String data;
  final bool shrinkWrap;
  final bool selectable;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final config =
        isDark ? MarkdownConfig.darkConfig : MarkdownConfig.defaultConfig;
    return MarkdownWidget(
      data: data.isEmpty ? '*Sem conteúdo*' : data,
      shrinkWrap: shrinkWrap,
      selectable: selectable,
      config: config,
      markdownGenerator: MarkdownGenerator(
        inlineSyntaxList: [_LatexSyntax()],
        generators: [_latexGenerator],
      ),
    );
  }
}

const _latexTag = 'latex';

final SpanNodeGeneratorWithTag _latexGenerator = SpanNodeGeneratorWithTag(
  tag: _latexTag,
  generator: (e, config, visitor) =>
      _LatexNode(e.attributes, e.textContent, config),
);

class _LatexSyntax extends m.InlineSyntax {
  _LatexSyntax() : super(r'(\$\$[\s\S]+?\$\$)|(\$.+?\$)');

  @override
  bool onMatch(m.InlineParser parser, Match match) {
    final matchValue = match.input.substring(match.start, match.end);
    var content = '';
    var isInline = true;
    if (matchValue.startsWith(r'$$') &&
        matchValue.endsWith(r'$$') &&
        matchValue.length > 4) {
      content = matchValue.substring(2, matchValue.length - 2);
      isInline = false;
    } else if (matchValue.startsWith(r'$') &&
        matchValue.endsWith(r'$') &&
        matchValue.length > 2) {
      content = matchValue.substring(1, matchValue.length - 1);
    }
    final element = m.Element.text(_latexTag, matchValue);
    element.attributes['content'] = content;
    element.attributes['isInline'] = '$isInline';
    parser.addNode(element);
    return true;
  }
}

class _LatexNode extends SpanNode {
  _LatexNode(this.attributes, this.textContent, this.config);

  final Map<String, String> attributes;
  final String textContent;
  final MarkdownConfig config;

  @override
  InlineSpan build() {
    final content = attributes['content'] ?? '';
    final isInline = attributes['isInline'] == 'true';
    final style = parentStyle ?? config.p.textStyle;
    if (content.isEmpty) return TextSpan(style: style, text: textContent);
    final latex = Math.tex(
      content,
      mathStyle: isInline ? MathStyle.text : MathStyle.display,
      textStyle: style,
      onErrorFallback: (_) =>
          Text(textContent, style: style.copyWith(color: Colors.red)),
    );
    return WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      child: isInline
          ? latex
          : Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 12),
              child: Center(child: latex),
            ),
    );
  }
}
