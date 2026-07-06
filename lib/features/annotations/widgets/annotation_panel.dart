import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdfrx/pdfrx.dart' show PdfViewerController;

import '../../../shared/theme/app_theme.dart';
import '../../../shared/widgets/markdown_preview.dart';
import '../../reader/providers/reader_providers.dart';
import '../../reader/widgets/pdf_view_panel.dart';
import '../models/annotation_type.dart';
import '../providers/annotation_providers.dart';
import '../repositories/annotation_repository.dart';
import 'annotation_editor.dart';

/// Right-panel tab: annotation list with filters (docs/06_UI_UX.md §2.3).
class AnnotationPanel extends ConsumerWidget {
  const AnnotationPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documentId = ref.watch(readerProvider.select((s) => s.documentId));
    if (documentId == null) {
      return const Center(child: Text('Nenhum documento aberto'));
    }

    final annotations = ref.watch(annotationListProvider(documentId));
    final filter = ref.watch(annotationFilterControllerProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: DropdownButton<AnnotationType?>(
                  isExpanded: true,
                  value: filter.type,
                  hint: const Text('Todos os tipos'),
                  items: [
                    const DropdownMenuItem(child: Text('Todos os tipos')),
                    for (final type in AnnotationType.values)
                      DropdownMenuItem(value: type, child: Text(type.label)),
                  ],
                  onChanged: (type) => ref
                      .read(annotationFilterControllerProvider.notifier)
                      .setType(type),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.filter_alt_off_outlined, size: 18),
                tooltip: 'Limpar filtros',
                onPressed: () => ref
                    .read(annotationFilterControllerProvider.notifier)
                    .clear(),
              ),
            ],
          ),
        ),
        Expanded(
          child: annotations.when(
            data: (list) {
              final filtered = list.where((a) {
                if (filter.type != null && a.type != filter.type!.name) {
                  return false;
                }
                if (filter.pageNumber != null &&
                    a.pageNumber != filter.pageNumber) {
                  return false;
                }
                if (filter.tag != null &&
                    !AnnotationRepository.parseTags(a.tags)
                        .contains(filter.tag)) {
                  return false;
                }
                return true;
              }).toList();

              if (filtered.isEmpty) {
                return const Center(child: Text('Sem anotações'));
              }
              return ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: filtered.length,
                separatorBuilder: (_, _) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final annotation = filtered[index];
                  final color = annotation.color != null
                      ? AppTheme.highlightColors[annotation.color]
                      : null;
                  return Card(
                    child: InkWell(
                      onTap: () => showAnnotationEditorForExisting(
                        context,
                        ref,
                        annotation: annotation,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                if (color != null)
                                  Container(
                                    width: 12,
                                    height: 12,
                                    margin: const EdgeInsets.only(right: 6),
                                    decoration: BoxDecoration(
                                      color: color,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                Text(
                                  AnnotationType.values
                                      .firstWhere(
                                        (t) => t.name == annotation.type,
                                        orElse: () => AnnotationType.note,
                                      )
                                      .label,
                                  style:
                                      Theme.of(context).textTheme.labelSmall,
                                ),
                                const Spacer(),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    visualDensity: VisualDensity.compact,
                                  ),
                                  onPressed: () => ref
                                      .read(pdfViewerControllerProvider)
                                      .goToPageIfReady(annotation.pageNumber),
                                  child: Text('p. ${annotation.pageNumber}'),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline,
                                      size: 16),
                                  visualDensity: VisualDensity.compact,
                                  onPressed: () => ref
                                      .read(annotationRepositoryProvider)
                                      .delete(annotation.id),
                                ),
                              ],
                            ),
                            if (annotation.selectedText != null &&
                                annotation.selectedText!.isNotEmpty)
                              Text(
                                '"${annotation.selectedText}"',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(fontStyle: FontStyle.italic),
                              ),
                            if (annotation.content != null &&
                                annotation.content!.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              MarkdownPreview(
                                data: annotation.content!,
                                selectable: false,
                              ),
                            ],
                            if (AnnotationRepository.parseTags(annotation.tags)
                                .isNotEmpty)
                              Wrap(
                                spacing: 4,
                                children: [
                                  for (final tag in AnnotationRepository
                                      .parseTags(annotation.tags))
                                    ActionChip(
                                      label: Text('#$tag'),
                                      visualDensity: VisualDensity.compact,
                                      onPressed: () => ref
                                          .read(
                                              annotationFilterControllerProvider
                                                  .notifier)
                                          .setTag(tag),
                                    ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Erro: $e')),
          ),
        ),
      ],
    );
  }
}

extension on PdfViewerController {
  void goToPageIfReady(int pageNumber) {
    if (isReady) goToPage(pageNumber: pageNumber);
  }
}
