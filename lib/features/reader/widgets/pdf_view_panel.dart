import 'package:flutter/material.dart';
import 'package:flutter/services.dart' hide SelectionRect;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdfrx/pdfrx.dart';

import '../../annotations/widgets/annotation_editor.dart';
import '../../chat/models/quick_mode.dart';
import '../../chat/providers/chat_providers.dart';
import '../../chat/widgets/json_mode_result_dialog.dart';
import '../../concepts/providers/concept_providers.dart';
import '../../concepts/widgets/cross_ref_panel.dart';
import '../../visual_context/widgets/media_reference_dialog.dart';
import '../models/selection.dart';
import '../providers/reader_providers.dart';
import 'right_panel.dart';

/// Shared controller so TOC/search can navigate the viewer.
final pdfViewerControllerProvider =
    Provider<PdfViewerController>((ref) => PdfViewerController());

/// Central PDF viewer panel (docs/06_UI_UX.md §2.2).
class PdfViewPanel extends ConsumerStatefulWidget {
  const PdfViewPanel({super.key});

  @override
  ConsumerState<PdfViewPanel> createState() => _PdfViewPanelState();
}

class _PdfViewPanelState extends ConsumerState<PdfViewPanel> {
  @override
  Widget build(BuildContext context) {
    final documentId = ref.watch(readerProvider.select((s) => s.documentId));
    if (documentId == null) return const SizedBox.shrink();

    final doc = ref.watch(documentByIdProvider(documentId)).value;
    if (doc == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final controller = ref.watch(pdfViewerControllerProvider);

    return Column(
      children: [
        Expanded(
          child: PdfViewer.file(
            doc.filePath,
            controller: controller,
            initialPageNumber: doc.lastReadPage > 0 ? doc.lastReadPage : 1,
            params: PdfViewerParams(
              onPageChanged: (pageNumber) {
                if (pageNumber != null) {
                  ref.read(readerProvider.notifier).setPage(
                        pageNumber,
                        totalPages: doc.totalPages,
                      );
                }
              },
              textSelectionParams: PdfTextSelectionParams(
                onTextSelectionChange: _onSelectionChange,
              ),
              customizeContextMenuItems: _customizeContextMenu,
            ),
          ),
        ),
        _PageBar(controller: controller),
      ],
    );
  }

  Future<void> _onSelectionChange(PdfTextSelection selection) async {
    final text = await selection.getSelectedText();
    if (!mounted) return;
    if (text.isEmpty) {
      ref.read(readerProvider.notifier).setSelection(null);
      return;
    }
    final ranges = await selection.getSelectedTextRanges();
    if (!mounted || ranges.isEmpty) return;
    final first = ranges.first;
    final rects = <SelectionRect>[
      for (final range in ranges)
        SelectionRect(
          x: range.bounds.left,
          y: range.bounds.top,
          width: range.bounds.width,
          height: range.bounds.height,
        ),
    ];
    ref.read(readerProvider.notifier).setSelection(ReaderSelection(
          text: text,
          pageNumber: first.pageNumber,
          position: SelectionPosition(
            startOffset: first.start,
            endOffset: ranges.last.end,
            rects: rects,
          ),
        ));
  }

  /// Selection context menu (docs/06_UI_UX.md §2.2).
  void _customizeContextMenu(
    PdfViewerContextMenuBuilderParams params,
    List<ContextMenuButtonItem> items,
  ) {
    if (params.contextMenuFor != PdfViewerPart.selectedText) return;

    void run(void Function() action) {
      params.dismissContextMenu();
      action();
    }

    final pendingCrossRef = ref.read(pendingCrossRefProvider);

    items.addAll([
      ContextMenuButtonItem(
        label: '📝 Anotar',
        onPressed: () => run(_annotateSelection),
      ),
      ContextMenuButtonItem(
        label: '📋 Copiar citação',
        onPressed: () => run(_copyCitation),
      ),
      ContextMenuButtonItem(
        label: '🧠 Extrair conceitos',
        onPressed: () => run(_extractConcepts),
      ),
      ContextMenuButtonItem(
        label: pendingCrossRef == null
            ? '🔗 Vincular trecho'
            : '🔗 Concluir vínculo aqui',
        onPressed: () => run(_handleCrossRefLink),
      ),
      ContextMenuButtonItem(
        label: '🗺️ Mostrar no mapa',
        onPressed: () => run(() => _showMedia(MediaReferenceTab.map)),
      ),
      ContextMenuButtonItem(
        label: '🖼️ Mostrar imagens',
        onPressed: () => run(() => _showMedia(MediaReferenceTab.images)),
      ),
      ContextMenuButtonItem(
        label: '🎬 Buscar vídeos',
        onPressed: () => run(() => _showMedia(MediaReferenceTab.videos)),
      ),
      ContextMenuButtonItem(
        label: '📚 Referências visuais',
        onPressed: () => run(() => _showMedia(MediaReferenceTab.all)),
      ),
      for (final mode in QuickMode.values)
        ContextMenuButtonItem(
          label: mode.label,
          onPressed: () => run(() => _runQuickMode(mode)),
        ),
    ]);
  }

  Future<void> _showMedia(MediaReferenceTab tab) async {
    final selection = ref.read(readerProvider).selection;
    if (selection == null) return;
    final documentId = ref.read(readerProvider).documentId;
    final doc = documentId != null
        ? await ref.read(documentByIdProvider(documentId).future)
        : null;
    if (!mounted) return;
    await showMediaReferenceDialog(
      context,
      ref,
      selectionText: selection.text,
      documentTitle: doc?.title ?? doc?.fileName,
      pageNumber: selection.pageNumber,
      initialTab: tab,
    );
  }

  /// AI concept extraction from the selection (docs/08_ROADMAP.md §3.5).
  Future<void> _extractConcepts() async {
    final selection = ref.read(readerProvider).selection;
    final documentId = ref.read(readerProvider).documentId;
    if (selection == null) return;

    final messenger = ScaffoldMessenger.of(context);
    messenger.showSnackBar(
      const SnackBar(content: Text('Extraindo conceitos…')),
    );
    final repository = await ref.read(conceptRepositoryProvider.future);
    if (repository == null) return;
    final result = await repository.extractFromText(
      selection.text,
      documentId: documentId,
    );
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(SnackBar(
      content: Text(result.when(
        ok: (added) => added > 0
            ? '$added conceito(s) adicionado(s) ao grafo'
            : 'Nenhum conceito novo identificado',
        error: (failure) => failure.message,
      )),
    ));
  }

  /// Manual cross-reference flow (docs/08_ROADMAP.md §3.6): the first
  /// selection marks the source, the second completes the link.
  Future<void> _handleCrossRefLink() async {
    final selection = ref.read(readerProvider).selection;
    final documentId = ref.read(readerProvider).documentId;
    if (selection == null || documentId == null) return;

    final pending = ref.read(pendingCrossRefProvider);
    if (pending == null) {
      ref.read(pendingCrossRefProvider.notifier).state = PendingCrossRefSource(
        documentId: documentId,
        pageNumber: selection.pageNumber,
        text: _truncate(selection.text, 300),
      );
      ref.read(rightPanelTabProvider.notifier).state =
          RightPanelTab.references;
      return;
    }

    final relationType = await _pickRelationType();
    if (relationType == null) return;
    final repository = await ref.read(conceptRepositoryProvider.future);
    if (repository == null) return;
    await repository.addCrossReference(
      sourceDocId: pending.documentId,
      sourcePage: pending.pageNumber,
      sourceText: pending.text,
      targetDocId: documentId,
      targetPage: selection.pageNumber,
      targetText: _truncate(selection.text, 300),
      relationType: relationType,
    );
    ref.read(pendingCrossRefProvider.notifier).state = null;
    ref.invalidate(crossRefsForPageProvider);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Referência cruzada criada')),
      );
    }
  }

  Future<String?> _pickRelationType() => showDialog<String>(
        context: context,
        builder: (dialogContext) => SimpleDialog(
          title: const Text('Tipo de relação'),
          children: [
            for (final type in const [
              'corroborates',
              'contradicts',
              'extends',
              'cites',
              'exemplifies',
            ])
              SimpleDialogOption(
                onPressed: () => Navigator.of(dialogContext).pop(type),
                child: Text(crossRefRelationLabel(type)),
              ),
          ],
        ),
      );

  Future<void> _annotateSelection() async {
    final selection = ref.read(readerProvider).selection;
    final documentId = ref.read(readerProvider).documentId;
    if (selection == null || documentId == null) return;
    await showAnnotationEditor(
      context,
      ref,
      documentId: documentId,
      selection: selection,
    );
  }

  Future<void> _copyCitation() async {
    final selection = ref.read(readerProvider).selection;
    final documentId = ref.read(readerProvider).documentId;
    if (selection == null || documentId == null) return;
    final doc =
        await ref.read(documentByIdProvider(documentId).future);
    final author = doc?.authors ?? 'AUTOR';
    final year = doc?.year?.toString() ?? 's.d.';
    final citation =
        '"${selection.text}" ($author, $year, p. ${selection.pageNumber})';
    await Clipboard.setData(ClipboardData(text: citation));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Citação copiada')),
      );
    }
  }

  Future<void> _runQuickMode(QuickMode mode) async {
    final selection = ref.read(readerProvider).selection;
    if (selection == null) return;

    if (mode.returnsJson) {
      await showJsonModeResultDialog(context, ref, mode: mode);
      return;
    }

    // Conversational modes stream into the chat panel.
    ref.read(rightPanelTabProvider.notifier).state = RightPanelTab.chat;
    await ref.read(activeChatProvider.notifier).send(
          '[${mode.label}] "${_truncate(selection.text, 500)}"',
          quickMode: mode,
        );
  }

  static String _truncate(String text, int max) =>
      text.length <= max ? text : '${text.substring(0, max)}…';
}

class _PageBar extends ConsumerWidget {
  const _PageBar({required this.controller});

  final PdfViewerController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(readerProvider);
    return Material(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left),
              tooltip: 'Página anterior',
              onPressed: state.currentPage > 1
                  ? () => controller.goToPage(pageNumber: state.currentPage - 1)
                  : null,
            ),
            Text('pág ${state.currentPage} / ${state.totalPages}'),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              tooltip: 'Próxima página',
              onPressed: state.totalPages == 0 ||
                      state.currentPage < state.totalPages
                  ? () => controller.goToPage(pageNumber: state.currentPage + 1)
                  : null,
            ),
            const SizedBox(width: 16),
            IconButton(
              icon: const Icon(Icons.zoom_in),
              tooltip: 'Zoom in',
              onPressed: () => controller.zoomUp(),
            ),
            IconButton(
              icon: const Icon(Icons.zoom_out),
              tooltip: 'Zoom out',
              onPressed: () => controller.zoomDown(),
            ),
          ],
        ),
      ),
    );
  }
}
