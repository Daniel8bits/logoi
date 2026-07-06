import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../annotations/widgets/annotation_panel.dart';
import '../../chat/widgets/chat_panel.dart';
import '../../concepts/widgets/cross_ref_panel.dart';
import '../../notebook/widgets/notebook_panel.dart';

/// Tabs of the right panel (docs/06_UI_UX.md §2.3).
enum RightPanelTab { annotations, chat, notebook, references }

final rightPanelTabProvider =
    StateProvider<RightPanelTab>((ref) => RightPanelTab.annotations);

/// Right panel: annotations, AI chat and notebook.
class RightPanel extends ConsumerWidget {
  const RightPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tab = ref.watch(rightPanelTabProvider);

    return Column(
      children: [
        SegmentedButton<RightPanelTab>(
          showSelectedIcon: false,
          style: const ButtonStyle(visualDensity: VisualDensity.compact),
          segments: const [
            ButtonSegment(
              value: RightPanelTab.annotations,
              icon: Icon(Icons.edit_note, size: 18),
              tooltip: 'Anotações',
            ),
            ButtonSegment(
              value: RightPanelTab.chat,
              icon: Icon(Icons.chat_outlined, size: 18),
              tooltip: 'Chat IA',
            ),
            ButtonSegment(
              value: RightPanelTab.notebook,
              icon: Icon(Icons.book_outlined, size: 18),
              tooltip: 'Caderno',
            ),
            ButtonSegment(
              value: RightPanelTab.references,
              icon: Icon(Icons.link, size: 18),
              tooltip: 'Referências cruzadas',
            ),
          ],
          selected: {tab},
          onSelectionChanged: (selection) =>
              ref.read(rightPanelTabProvider.notifier).state = selection.first,
        ),
        const Divider(),
        Expanded(
          child: switch (tab) {
            RightPanelTab.annotations => const AnnotationPanel(),
            RightPanelTab.chat => const ChatPanel(),
            RightPanelTab.notebook => const NotebookPanel(),
            RightPanelTab.references => const CrossRefPanel(),
          },
        ),
      ],
    );
  }
}
