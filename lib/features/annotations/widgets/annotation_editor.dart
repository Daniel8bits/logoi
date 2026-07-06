import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../shared/widgets/markdown_editor.dart';
import '../../reader/models/selection.dart';
import '../models/annotation_type.dart';
import '../providers/annotation_providers.dart';
import '../repositories/annotation_repository.dart';

/// Opens the annotation editor for a new annotation on [selection].
Future<void> showAnnotationEditor(
  BuildContext context,
  WidgetRef ref, {
  required String documentId,
  required ReaderSelection selection,
}) =>
    showDialog<void>(
      context: context,
      builder: (_) => _AnnotationEditorDialog(
        documentId: documentId,
        selection: selection,
      ),
    );

/// Opens the editor for an existing annotation.
Future<void> showAnnotationEditorForExisting(
  BuildContext context,
  WidgetRef ref, {
  required AnnotationRow annotation,
}) =>
    showDialog<void>(
      context: context,
      builder: (_) => _AnnotationEditorDialog(existing: annotation),
    );

class _AnnotationEditorDialog extends ConsumerStatefulWidget {
  const _AnnotationEditorDialog({
    this.documentId,
    this.selection,
    this.existing,
  });

  final String? documentId;
  final ReaderSelection? selection;
  final AnnotationRow? existing;

  @override
  ConsumerState<_AnnotationEditorDialog> createState() =>
      _AnnotationEditorDialogState();
}

class _AnnotationEditorDialogState
    extends ConsumerState<_AnnotationEditorDialog> {
  late final TextEditingController _contentController;
  late final TextEditingController _tagsController;
  late AnnotationType _type;
  late String _color;

  @override
  void initState() {
    super.initState();
    final existing = widget.existing;
    _contentController =
        TextEditingController(text: existing?.content ?? '');
    _tagsController = TextEditingController(
      text: existing != null
          ? AnnotationRepository.parseTags(existing.tags).join(', ')
          : '',
    );
    _type = existing != null
        ? AnnotationType.values.firstWhere(
            (t) => t.name == existing.type,
            orElse: () => AnnotationType.note,
          )
        : AnnotationType.highlight;
    _color = existing?.color ?? AppTheme.highlightColors.keys.first;
  }

  @override
  void dispose() {
    _contentController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedText =
        widget.existing?.selectedText ?? widget.selection?.text;

    return AlertDialog(
      title: Text(widget.existing == null ? 'Nova Anotação' : 'Editar Anotação'),
      content: SizedBox(
        width: 560,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (selectedText != null && selectedText.isNotEmpty) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '"$selectedText"',
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                const SizedBox(height: 12),
              ],
              Row(
                children: [
                  DropdownButton<AnnotationType>(
                    value: _type,
                    items: [
                      for (final type in AnnotationType.values)
                        DropdownMenuItem(value: type, child: Text(type.label)),
                    ],
                    onChanged: (type) =>
                        setState(() => _type = type ?? AnnotationType.note),
                  ),
                  const SizedBox(width: 16),
                  for (final entry in AppTheme.highlightColors.entries)
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: InkWell(
                        onTap: () => setState(() => _color = entry.key),
                        child: Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            color: entry.value,
                            shape: BoxShape.circle,
                            border: _color == entry.key
                                ? Border.all(width: 2)
                                : null,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              MarkdownEditor(
                controller: _contentController,
                autofocus: true,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _tagsController,
                decoration: const InputDecoration(
                  labelText: 'Tags (separadas por vírgula)',
                  prefixIcon: Icon(Icons.tag, size: 18),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: _save,
          child: const Text('Salvar'),
        ),
      ],
    );
  }

  Future<void> _save() async {
    final repository = ref.read(annotationRepositoryProvider);
    final tags = _tagsController.text
        .split(',')
        .map((t) => t.trim())
        .where((t) => t.isNotEmpty)
        .toList();

    if (widget.existing != null) {
      await repository.updateContent(
        widget.existing!.id,
        content: _contentController.text,
        tags: tags,
        color: _color,
      );
    } else {
      await repository.create(
        documentId: widget.documentId!,
        pageNumber: widget.selection!.pageNumber,
        type: _type,
        position: widget.selection!.position,
        color: _color,
        selectedText: widget.selection!.text,
        content: _contentController.text,
        tags: tags,
      );
    }
    if (mounted) Navigator.of(context).pop();
  }
}
