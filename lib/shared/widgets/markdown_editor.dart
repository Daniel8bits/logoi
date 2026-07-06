import 'package:flutter/material.dart';

import 'markdown_preview.dart';

/// Markdown editor with formatting toolbar, undo/redo and live preview
/// toggle. Implementation choice per docs/06_UI_UX.md §3.2: custom
/// TextField + markdown_widget rendering.
class MarkdownEditor extends StatefulWidget {
  const MarkdownEditor({
    super.key,
    required this.controller,
    this.minLines = 6,
    this.autofocus = false,
    this.onChanged,
  });

  final TextEditingController controller;
  final int minLines;
  final bool autofocus;
  final ValueChanged<String>? onChanged;

  @override
  State<MarkdownEditor> createState() => _MarkdownEditorState();
}

class _MarkdownEditorState extends State<MarkdownEditor> {
  final _undoController = UndoHistoryController();
  bool _preview = false;

  @override
  void dispose() {
    _undoController.dispose();
    super.dispose();
  }

  void _wrapSelection(String prefix, [String? suffix]) {
    final controller = widget.controller;
    final selection = controller.selection;
    final text = controller.text;
    final effectiveSuffix = suffix ?? prefix;
    if (!selection.isValid) {
      controller.text = '$text$prefix$effectiveSuffix';
      return;
    }
    final selected = selection.textInside(text);
    final replaced = '$prefix$selected$effectiveSuffix';
    controller.value = controller.value.replaced(
      TextRange(start: selection.start, end: selection.end),
      replaced,
    );
    widget.onChanged?.call(controller.text);
  }

  void _insertLinePrefix(String prefix) {
    final controller = widget.controller;
    final selection = controller.selection;
    final text = controller.text;
    final offset = selection.isValid ? selection.start : text.length;
    final lineStart = text.lastIndexOf('\n', offset - 1) + 1;
    controller.value = controller.value.replaced(
      TextRange(start: lineStart, end: lineStart),
      prefix,
    );
    widget.onChanged?.call(controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 2,
          children: [
            IconButton(
              icon: const Icon(Icons.format_bold, size: 18),
              tooltip: 'Negrito',
              onPressed: () => _wrapSelection('**'),
            ),
            IconButton(
              icon: const Icon(Icons.format_italic, size: 18),
              tooltip: 'Itálico',
              onPressed: () => _wrapSelection('*'),
            ),
            IconButton(
              icon: const Icon(Icons.format_strikethrough, size: 18),
              tooltip: 'Tachado',
              onPressed: () => _wrapSelection('~~'),
            ),
            IconButton(
              icon: const Icon(Icons.title, size: 18),
              tooltip: 'Heading',
              onPressed: () => _insertLinePrefix('## '),
            ),
            IconButton(
              icon: const Icon(Icons.format_list_bulleted, size: 18),
              tooltip: 'Lista',
              onPressed: () => _insertLinePrefix('- '),
            ),
            IconButton(
              icon: const Icon(Icons.checklist, size: 18),
              tooltip: 'Checklist',
              onPressed: () => _insertLinePrefix('- [ ] '),
            ),
            IconButton(
              icon: const Icon(Icons.format_quote, size: 18),
              tooltip: 'Citação',
              onPressed: () => _insertLinePrefix('> '),
            ),
            IconButton(
              icon: const Icon(Icons.code, size: 18),
              tooltip: 'Código',
              onPressed: () => _wrapSelection('`'),
            ),
            IconButton(
              icon: const Icon(Icons.functions, size: 18),
              tooltip: 'LaTeX',
              onPressed: () => _wrapSelection(r'$'),
            ),
            IconButton(
              icon: const Icon(Icons.table_chart_outlined, size: 18),
              tooltip: 'Tabela',
              onPressed: () => _wrapSelection(
                '\n| Coluna 1 | Coluna 2 |\n|---|---|\n| ',
                ' |  |\n',
              ),
            ),
            const SizedBox(width: 8),
            ValueListenableBuilder(
              valueListenable: _undoController,
              builder: (context, value, _) => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.undo, size: 18),
                    tooltip: 'Desfazer (Ctrl+Z)',
                    onPressed: value.canUndo ? _undoController.undo : null,
                  ),
                  IconButton(
                    icon: const Icon(Icons.redo, size: 18),
                    tooltip: 'Refazer (Ctrl+Shift+Z)',
                    onPressed: value.canRedo ? _undoController.redo : null,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            SegmentedButton<bool>(
              showSelectedIcon: false,
              style: const ButtonStyle(
                visualDensity: VisualDensity.compact,
              ),
              segments: const [
                ButtonSegment(value: false, label: Text('Editar')),
                ButtonSegment(value: true, label: Text('Preview')),
              ],
              selected: {_preview},
              onSelectionChanged: (selection) =>
                  setState(() => _preview = selection.first),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (_preview)
          Container(
            constraints: const BoxConstraints(minHeight: 120, maxHeight: 400),
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.outline),
              borderRadius: BorderRadius.circular(4),
            ),
            child: SingleChildScrollView(
              child: MarkdownPreview(data: widget.controller.text),
            ),
          )
        else
          TextField(
            controller: widget.controller,
            undoController: _undoController,
            autofocus: widget.autofocus,
            minLines: widget.minLines,
            maxLines: 20,
            onChanged: widget.onChanged,
            style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
            decoration: const InputDecoration(
              hintText: 'Escreva em Markdown… (suporta **negrito**, '
                  r'listas, tabelas, `código` e LaTeX com $..$)',
            ),
          ),
      ],
    );
  }
}
