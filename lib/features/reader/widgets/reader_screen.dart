import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_split_view/multi_split_view.dart';

import '../../../core/providers/core_providers.dart';
import '../../../core/providers/processing_providers.dart';
import '../../export/widgets/export_dialog.dart';
import '../../project/providers/project_providers.dart';
import '../../settings/widgets/settings_screen.dart';
import '../providers/reader_providers.dart';
import 'document_list_view.dart';
import 'left_panel.dart';
import 'pdf_view_panel.dart';
import 'right_panel.dart';

/// Main reader view: three resizable panels (docs/06_UI_UX.md §1.2).
class ReaderScreen extends ConsumerStatefulWidget {
  const ReaderScreen({super.key});

  @override
  ConsumerState<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends ConsumerState<ReaderScreen> {
  @override
  Widget build(BuildContext context) {
    final project = ref.watch(currentProjectProvider);
    final readerState = ref.watch(readerProvider);

    if (project == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final reader = ref.read(readerProvider.notifier);

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.keyB, control: true):
            reader.toggleLeftPanel,
        const SingleActivator(LogicalKeyboardKey.keyB,
            control: true, shift: true): reader.toggleRightPanel,
        const SingleActivator(LogicalKeyboardKey.keyF,
            control: true, shift: true): reader.toggleFocusMode,
      },
      child: Focus(
        autofocus: true,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              tooltip: 'Projetos',
              onPressed: () async {
                await reader.closeDocument();
                await ref.read(currentProjectProvider.notifier).close();
                if (context.mounted) Navigator.of(context).pop();
              },
            ),
            title: Row(
              children: [
                Text(project.project.name),
                if (readerState.documentId != null) ...[
                  const Text('  │  '),
                  Expanded(child: _DocumentTitle()),
                ],
              ],
            ),
            actions: [
              if (readerState.documentId != null) const _StatusIndicator(),
              IconButton(
                icon: const Icon(Icons.download_outlined),
                tooltip: 'Exportar',
                onPressed: () => showExportDialog(context),
              ),
              if (readerState.documentId != null)
                _ProcessingMenu(documentId: readerState.documentId!),
              IconButton(
                icon: const Icon(Icons.settings_outlined),
                tooltip: 'Configurações',
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                      builder: (_) => const SettingsScreen()),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
          body: readerState.documentId == null
              ? const DocumentListView()
              : _buildPanels(readerState),
        ),
      ),
    );
  }

  Widget _buildPanels(ReaderState readerState) {
    final children = <Widget>[
      if (readerState.leftPanelVisible) const LeftPanel(),
      const PdfViewPanel(),
      if (readerState.rightPanelVisible) const RightPanel(),
    ];
    if (children.length == 1) return children.single;

    final areas = <Area>[
      if (readerState.leftPanelVisible)
        Area(size: 260, min: 180),
      Area(flex: 1),
      if (readerState.rightPanelVisible)
        Area(size: 380, min: 260),
    ];

    return MultiSplitViewTheme(
      data: MultiSplitViewThemeData(
        dividerThickness: 6,
        dividerPainter: DividerPainters.grooved1(),
      ),
      child: MultiSplitView(
        initialAreas: areas,
        builder: (context, area) => children[area.index],
      ),
    );
  }
}

class _DocumentTitle extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documentId = ref.watch(readerProvider.select((s) => s.documentId));
    if (documentId == null) return const SizedBox.shrink();
    final doc = ref.watch(documentByIdProvider(documentId));
    return Text(
      doc.value?.title ?? doc.value?.fileName ?? '',
      style: Theme.of(context).textTheme.titleSmall,
      overflow: TextOverflow.ellipsis,
    );
  }
}

/// Background processing actions for the open document
/// (docs/05_PROCESSING.md §3 etapas 3-5).
class _ProcessingMenu extends ConsumerWidget {
  const _ProcessingMenu({required this.documentId});

  final String documentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.auto_awesome_outlined),
      tooltip: 'Processamento',
      itemBuilder: (_) => const [
        PopupMenuItem(
          value: 'index',
          child: Text('Indexar embeddings (Ollama)'),
        ),
        PopupMenuItem(
          value: 'summarize',
          child: Text('Gerar resumos (IA)'),
        ),
      ],
      onSelected: (action) async {
        final messenger = ScaffoldMessenger.of(context);
        switch (action) {
          case 'index':
            final started = await ref
                .read(indexingProgressProvider.notifier)
                .indexDocument(documentId);
            messenger.showSnackBar(SnackBar(
              content: Text(started
                  ? 'Indexação concluída'
                  : 'Ollama indisponível ou indexação já em andamento'),
            ));
          case 'summarize':
            final service = await ref.read(summaryServiceProvider.future);
            if (service == null) {
              messenger.showSnackBar(const SnackBar(
                content: Text('Configure um provider de IA nas configurações.'),
              ));
              return;
            }
            messenger.showSnackBar(
              const SnackBar(content: Text('Gerando resumos em background…')),
            );
            final result = await service.summarizeDocument(documentId);
            messenger.showSnackBar(SnackBar(
              content: Text(result.when(
                ok: (calls) => calls > 0
                    ? 'Resumos gerados ($calls chamadas de API)'
                    : 'Resumos já estavam gerados',
                error: (failure) => failure.message,
              )),
            ));
        }
      },
    );
  }
}

/// Document processing status indicator (docs/06_UI_UX.md §8.1).
class _StatusIndicator extends ConsumerWidget {
  const _StatusIndicator();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documentId = ref.watch(readerProvider.select((s) => s.documentId));
    final ollamaOn = ref.watch(ollamaStatusProvider).value ?? false;
    if (documentId == null) return const SizedBox.shrink();
    final doc = ref.watch(documentByIdProvider(documentId)).value;
    if (doc == null) return const SizedBox.shrink();

    final indexing = ref.watch(indexingProgressProvider)[documentId];
    if (indexing != null) {
      final (done, total) = indexing;
      final percent = total > 0 ? (done / total * 100).round() : 0;
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 14,
            height: 14,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          const SizedBox(width: 6),
          Text('indexando… $percent%',
              style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(width: 8),
        ],
      );
    }

    final (icon, label, color) = switch (doc.processingStatus) {
      'imported' => (Icons.description_outlined, 'Texto disponível', null),
      'segmented' => (Icons.segment, 'Segmentado', null),
      'indexed' => (Icons.blur_on, 'Indexado', Colors.blue),
      'summarized' => (Icons.summarize_outlined, 'Resumido', Colors.orange),
      'fully_processed' => (Icons.check_circle_outline, 'Pronto', Colors.green),
      _ => (Icons.hourglass_empty, doc.processingStatus, null),
    };

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Tooltip(
          message: label,
          child: Icon(icon, size: 18, color: color),
        ),
        if (!ollamaOn) ...[
          const SizedBox(width: 8),
          const Tooltip(
            message: 'Ollama indisponível — busca semântica offline',
            child: Icon(Icons.cloud_off_outlined, size: 18),
          ),
        ],
        const SizedBox(width: 8),
      ],
    );
  }
}
