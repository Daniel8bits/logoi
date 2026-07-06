import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/ai/response_parser.dart';
import '../../export/services/export_service.dart';
import '../models/quick_mode.dart';
import '../providers/chat_providers.dart';

/// Runs a JSON quick mode (flashcards / argument map / bias detection) and
/// shows the structured result (docs/08_ROADMAP.md §2.4).
Future<void> showJsonModeResultDialog(
  BuildContext context,
  WidgetRef ref, {
  required QuickMode mode,
}) =>
    showDialog<void>(
      context: context,
      builder: (_) => _JsonModeDialog(mode: mode),
    );

class _JsonModeDialog extends ConsumerStatefulWidget {
  const _JsonModeDialog({required this.mode});

  final QuickMode mode;

  @override
  ConsumerState<_JsonModeDialog> createState() => _JsonModeDialogState();
}

class _JsonModeDialogState extends ConsumerState<_JsonModeDialog> {
  Map<String, dynamic>? _result;
  String? _error;
  String? _raw;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _run();
  }

  Future<void> _run({bool force = false}) async {
    setState(() {
      _loading = true;
      _error = null;
    });
    final repository = await ref.read(chatRepositoryProvider.future);
    final context = await ref.read(chatContextProvider.future);
    if (repository == null || context == null) {
      setState(() {
        _loading = false;
        _error = 'Configure um provider de IA nas configurações.';
      });
      return;
    }
    final result = await repository.runJsonMode(
      mode: widget.mode,
      context: context,
      forceRegenerate: force,
    );
    if (!mounted) return;
    result.when(
      ok: (response) {
        _raw = response;
        const JSONResponseParser().parse(response).when(
              ok: (json) => setState(() {
                _result = json;
                _loading = false;
              }),
              error: (failure) => setState(() {
                _error = '${failure.message}\n\nResposta bruta:\n$response';
                _loading = false;
              }),
            );
      },
      error: (failure) => setState(() {
        _error = failure.message;
        _loading = false;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.mode.label),
      content: SizedBox(
        width: 560,
        height: 420,
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : _error != null
                ? SingleChildScrollView(child: Text(_error!))
                : _buildResult(),
      ),
      actions: [
        if (!_loading && _raw != null)
          TextButton(
            onPressed: () => _run(force: true),
            child: const Text('Re-gerar'),
          ),
        if (!_loading &&
            widget.mode == QuickMode.flashcards &&
            _result != null)
          TextButton(
            onPressed: _exportAnkiCsv,
            child: const Text('Exportar CSV (Anki)'),
          ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Fechar'),
        ),
      ],
    );
  }

  /// Anki-importable CSV (docs/08_ROADMAP.md §4.2).
  Future<void> _exportAnkiCsv() async {
    final cards = (_result!['cards'] as List<dynamic>? ?? const [])
        .cast<Map<String, dynamic>>();
    if (cards.isEmpty) return;
    final dirPath = await FilePicker.platform.getDirectoryPath();
    if (dirPath == null || !mounted) return;
    final file = File(
        '$dirPath/flashcards_${DateTime.now().millisecondsSinceEpoch}.csv')
      ..writeAsStringSync(ExportService.ankiCsv(cards));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Flashcards exportados: ${file.path}')),
    );
  }

  Widget _buildResult() {
    final json = _result!;
    return switch (widget.mode) {
      QuickMode.flashcards => _FlashcardsView(json: json),
      _ => SingleChildScrollView(
          child: SelectableText(
            const JsonEncoder.withIndent('  ').convert(json),
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
          ),
        ),
    };
  }
}

class _FlashcardsView extends StatelessWidget {
  const _FlashcardsView({required this.json});

  final Map<String, dynamic> json;

  @override
  Widget build(BuildContext context) {
    final cards = (json['cards'] as List<dynamic>? ?? const [])
        .cast<Map<String, dynamic>>();
    if (cards.isEmpty) return const Text('Nenhum flashcard gerado.');
    return ListView.separated(
      itemCount: cards.length,
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final card = cards[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Chip(
                      label: Text(card['type'] as String? ?? ''),
                      visualDensity: VisualDensity.compact,
                    ),
                    const SizedBox(width: 8),
                    Chip(
                      label: Text(card['difficulty'] as String? ?? ''),
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  card['front'] as String? ?? '',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const Divider(),
                Text(card['back'] as String? ?? ''),
              ],
            ),
          ),
        );
      },
    );
  }
}
