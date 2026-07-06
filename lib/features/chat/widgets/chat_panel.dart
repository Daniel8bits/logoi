import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/markdown_preview.dart';
import '../../project/providers/project_providers.dart';
import '../../reader/providers/reader_providers.dart';
import '../../visual_context/widgets/media_card.dart';
import '../../visual_context/widgets/media_reference_dialog.dart';
import '../models/quick_mode.dart';
import '../providers/chat_providers.dart';

/// AI chat with streaming responses (docs/06_UI_UX.md §2.3 — Chat tab).
class ChatPanel extends ConsumerStatefulWidget {
  const ChatPanel({super.key});

  @override
  ConsumerState<ChatPanel> createState() => _ChatPanelState();
}

class _ChatPanelState extends ConsumerState<ChatPanel> {
  final _inputController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final activeChat = ref.watch(activeChatProvider);
    final project = ref.watch(currentProjectProvider);
    final readerState = ref.watch(readerProvider);
    final selection = readerState.selection;

    return Column(
      children: [
        _SessionSelector(activeSessionId: activeChat.sessionId),
        if (project != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Icon(Icons.smart_toy_outlined,
                    size: 14, color: Theme.of(context).colorScheme.outline),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    '${project.settings.defaultProvider} → '
                    '${project.settings.defaultModel}',
                    style: Theme.of(context).textTheme.labelSmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        const Divider(),
        Expanded(child: _MessageList(scrollController: _scrollController)),
        if (activeChat.error != null)
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              activeChat.error!,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Quick mode buttons (docs/06_UI_UX.md §2.3).
              Wrap(
                spacing: 4,
                children: [
                  for (final mode in const [
                    QuickMode.explain,
                    QuickMode.summarize,
                    QuickMode.socratic,
                  ])
                    ActionChip(
                      label: Text(mode.label),
                      visualDensity: VisualDensity.compact,
                      onPressed:
                          activeChat.isStreaming ? null : () => _sendQuick(mode),
                    ),
                  if (selection != null)
                    ActionChip(
                      avatar: const Icon(Icons.map_outlined, size: 16),
                      label: const Text('Referências visuais'),
                      visualDensity: VisualDensity.compact,
                      onPressed: activeChat.isStreaming
                          ? null
                          : () => showMediaReferenceDialog(
                                context,
                                ref,
                                selectionText: selection.text,
                                pageNumber: selection.pageNumber,
                                initialTab: MediaReferenceTab.all,
                              ),
                    ),
                ],
              ),
              if (selection != null) ...[
                const SizedBox(height: 8),
                MediaCard(
                  selectionText: selection.text,
                  pageNumber: selection.pageNumber,
                ),
              ],
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _inputController,
                      minLines: 1,
                      maxLines: 5,
                      enabled: !activeChat.isStreaming,
                      decoration: const InputDecoration(
                        hintText: 'Pergunte sobre o documento…',
                      ),
                      onSubmitted: (_) => _send(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    icon: activeChat.isStreaming
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.send),
                    onPressed: activeChat.isStreaming ? null : _send,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _send() async {
    final text = _inputController.text.trim();
    if (text.isEmpty) return;
    _inputController.clear();
    await ref.read(activeChatProvider.notifier).send(text);
  }

  Future<void> _sendQuick(QuickMode mode) async {
    final selection = ref.read(readerProvider).selection?.text;
    if (selection == null || selection.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecione um trecho do PDF primeiro')),
      );
      return;
    }
    await ref.read(activeChatProvider.notifier).send(
          '[${mode.label}] "$selection"',
          quickMode: mode,
        );
  }
}

class _SessionSelector extends ConsumerWidget {
  const _SessionSelector({required this.activeSessionId});

  final String? activeSessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessions = ref.watch(chatSessionsProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: sessions.when(
              data: (list) => DropdownButton<String?>(
                isExpanded: true,
                value: activeSessionId,
                hint: const Text('Nova conversa'),
                items: [
                  const DropdownMenuItem(child: Text('Nova conversa')),
                  for (final session in list)
                    DropdownMenuItem(
                      value: session.id,
                      child: Text(
                        session.title ?? 'Conversa',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
                onChanged: (sessionId) => ref
                    .read(activeChatProvider.notifier)
                    .selectSession(sessionId),
              ),
              loading: () => const LinearProgressIndicator(),
              error: (_, _) => const SizedBox.shrink(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add_comment_outlined, size: 18),
            tooltip: 'Nova conversa',
            onPressed: () =>
                ref.read(activeChatProvider.notifier).selectSession(null),
          ),
        ],
      ),
    );
  }
}

class _MessageList extends ConsumerWidget {
  const _MessageList({required this.scrollController});

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeChat = ref.watch(activeChatProvider);
    final sessionId = activeChat.sessionId;

    if (sessionId == null && !activeChat.isStreaming) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Converse com a IA sobre o documento aberto. '
            'Selecione texto no PDF e use os modos rápidos.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    final messages = sessionId != null
        ? ref.watch(chatMessagesProvider(sessionId))
        : const AsyncValue.data([]);

    return messages.when(
      data: (list) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (scrollController.hasClients) {
            scrollController
                .jumpTo(scrollController.position.maxScrollExtent);
          }
        });
        return ListView(
          controller: scrollController,
          padding: const EdgeInsets.all(8),
          children: [
            for (final message in list)
              if (message.role != 'system' || message.isCompressed)
                _MessageBubble(
                  role: message.isCompressed ? 'context' : message.role,
                  content: message.content,
                ),
            if (activeChat.isStreaming)
              _MessageBubble(
                role: 'assistant',
                content: activeChat.streamingText!.isEmpty
                    ? '…'
                    : activeChat.streamingText!,
              ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Erro: $e')),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.role, required this.content});

  final String role;
  final String content;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isUser = role == 'user';
    final isContext = role == 'context';

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(10),
        constraints: const BoxConstraints(maxWidth: 320),
        decoration: BoxDecoration(
          color: isUser
              ? scheme.primaryContainer
              : isContext
                  ? scheme.surfaceContainerHighest.withValues(alpha: 0.5)
                  : scheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(10),
        ),
        child: isContext
            ? Text(
                content,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontStyle: FontStyle.italic),
              )
            : isUser
                ? Text(content)
                : MarkdownPreview(data: content, selectable: false),
      ),
    );
  }
}
