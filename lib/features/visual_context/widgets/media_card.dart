import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'media_reference_dialog.dart';

/// Inline card to open visual references from chat.
class MediaCard extends ConsumerWidget {
  const MediaCard({
    super.key,
    required this.selectionText,
    this.documentTitle,
    this.pageNumber,
  });

  final String selectionText;
  final String? documentTitle;
  final int? pageNumber;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.map_outlined),
        title: Text('Ver referências: "${_truncate(selectionText, 30)}"'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => showMediaReferenceDialog(
          context,
          ref,
          selectionText: selectionText,
          documentTitle: documentTitle,
          pageNumber: pageNumber,
        ),
      ),
    );
  }

  static String _truncate(String text, int max) =>
      text.length <= max ? text : '${text.substring(0, max)}…';
}
