import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database.dart';
import '../../../shared/widgets/markdown_editor.dart';
import '../../reader/providers/reader_providers.dart';
import '../providers/notebook_providers.dart';

/// Right-panel tab: document notebook for fichamentos and drafts
/// (docs/06_UI_UX.md §2.3 — Caderno tab). Autosaves with debounce.
class NotebookPanel extends ConsumerStatefulWidget {
  const NotebookPanel({super.key});

  @override
  ConsumerState<NotebookPanel> createState() => _NotebookPanelState();
}

class _NotebookPanelState extends ConsumerState<NotebookPanel> {
  final _controller = TextEditingController();
  NotebookRow? _notebook;
  Timer? _saveDebounce;
  bool _loading = true;
  String? _error;
  String? _loadedForDocument;

  @override
  void dispose() {
    _saveDebounce?.cancel();
    _flushSave();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _load(String documentId) async {
    setState(() => _loading = true);
    final documentTitle = 'Caderno';
    final result = await ref
        .read(notebookRepositoryProvider)
        .getOrCreateForDocument(documentId, documentTitle);
    if (!mounted) return;
    result.when(
      ok: (notebook) => setState(() {
        _notebook = notebook;
        _controller.text = notebook.content;
        _loading = false;
        _loadedForDocument = documentId;
      }),
      error: (failure) => setState(() {
        _error = failure.message;
        _loading = false;
      }),
    );
  }

  void _scheduleSave() {
    _saveDebounce?.cancel();
    _saveDebounce = Timer(const Duration(seconds: 1), _flushSave);
  }

  void _flushSave() {
    final notebook = _notebook;
    if (notebook == null) return;
    ref
        .read(notebookRepositoryProvider)
        .saveContent(notebook.id, _controller.text);
  }

  @override
  Widget build(BuildContext context) {
    final documentId = ref.watch(readerProvider.select((s) => s.documentId));
    if (documentId == null) {
      return const Center(child: Text('Nenhum documento aberto'));
    }
    if (_loadedForDocument != documentId) {
      _loadedForDocument = documentId;
      _flushSave();
      WidgetsBinding.instance.addPostFrameCallback((_) => _load(documentId));
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) return Center(child: Text(_error!));
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        child: MarkdownEditor(
          controller: _controller,
          minLines: 16,
          onChanged: (_) => _scheduleSave(),
        ),
      ),
    );
  }
}
