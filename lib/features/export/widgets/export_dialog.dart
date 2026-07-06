import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/result.dart';
import '../../reader/providers/reader_providers.dart';
import '../providers/export_providers.dart';
import '../services/export_service.dart';

/// Export dialog (docs/08_ROADMAP.md §4.2): fichamento, Zettelkasten,
/// bibliography and concept graph.
Future<void> showExportDialog(BuildContext context) => showDialog<void>(
      context: context,
      builder: (_) => const _ExportDialog(),
    );

class _ExportDialog extends ConsumerStatefulWidget {
  const _ExportDialog();

  @override
  ConsumerState<_ExportDialog> createState() => _ExportDialogState();
}

class _ExportDialogState extends ConsumerState<_ExportDialog> {
  bool _fichamento = true;
  bool _zettelkasten = false;
  bool _bibliography = false;
  bool _conceptGraph = false;
  CitationStyle _style = CitationStyle.abnt;
  bool _running = false;
  final _log = <String>[];

  @override
  Widget build(BuildContext context) {
    final documentId = ref.watch(readerProvider.select((s) => s.documentId));
    final hasDocument = documentId != null;

    return AlertDialog(
      title: const Text('Exportar'),
      content: SizedBox(
        width: 440,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CheckboxListTile(
              dense: true,
              title: const Text('Fichamento (Markdown, via IA)'),
              subtitle:
                  hasDocument ? null : const Text('Requer documento aberto'),
              value: _fichamento && hasDocument,
              onChanged: hasDocument
                  ? (v) => setState(() => _fichamento = v ?? false)
                  : null,
            ),
            CheckboxListTile(
              dense: true,
              title: const Text('Notas Zettelkasten (Obsidian/Logseq)'),
              subtitle:
                  hasDocument ? null : const Text('Requer documento aberto'),
              value: _zettelkasten && hasDocument,
              onChanged: hasDocument
                  ? (v) => setState(() => _zettelkasten = v ?? false)
                  : null,
            ),
            CheckboxListTile(
              dense: true,
              title: const Text('Referências bibliográficas'),
              value: _bibliography,
              onChanged: (v) => setState(() => _bibliography = v ?? false),
            ),
            CheckboxListTile(
              dense: true,
              title: const Text('Grafo de conceitos (JSON)'),
              value: _conceptGraph,
              onChanged: (v) => setState(() => _conceptGraph = v ?? false),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<CitationStyle>(
              initialValue: _style,
              decoration:
                  const InputDecoration(labelText: 'Estilo de citação'),
              items: [
                for (final style in CitationStyle.values)
                  DropdownMenuItem(value: style, child: Text(style.label)),
              ],
              onChanged: (value) =>
                  setState(() => _style = value ?? CitationStyle.abnt),
            ),
            if (_log.isNotEmpty) ...[
              const SizedBox(height: 12),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 140),
                child: SingleChildScrollView(
                  child: Text(
                    _log.join('\n'),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed:
              _running ? null : () => Navigator.of(context).pop(),
          child: const Text('Fechar'),
        ),
        FilledButton.icon(
          icon: _running
              ? const SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.download),
          label: const Text('Exportar'),
          onPressed: _running ? null : _run,
        ),
      ],
    );
  }

  Future<void> _run() async {
    final dirPath = await FilePicker.platform.getDirectoryPath();
    if (dirPath == null || !mounted) return;

    final service = await ref.read(exportServiceProvider.future);
    if (service == null) return;

    setState(() {
      _running = true;
      _log.clear();
    });

    void report(String label, Result<Object?, Failure> result) {
      setState(() => _log.add(result.when(
            ok: (_) => '✓ $label',
            error: (failure) => '✗ $label: ${failure.message}',
          )));
    }

    final documentId = ref.read(readerProvider).documentId;
    final doc = documentId != null
        ? await ref.read(documentByIdProvider(documentId).future)
        : null;

    if (_fichamento && doc != null) {
      report('Fichamento',
          await service.exportFichamento(doc, dirPath, style: _style));
    }
    if (_zettelkasten && doc != null) {
      report('Zettelkasten', await service.exportZettelkasten(doc, dirPath));
    }
    if (_bibliography) {
      final docs = await ref.read(documentListProvider.future);
      report('Referências',
          await service.exportBibliography(docs, _style, dirPath));
    }
    if (_conceptGraph) {
      report('Grafo de conceitos',
          await service.exportConceptGraphJson(dirPath));
    }

    if (mounted) {
      setState(() {
        _running = false;
        _log.add('Concluído em $dirPath');
      });
    }
  }
}
