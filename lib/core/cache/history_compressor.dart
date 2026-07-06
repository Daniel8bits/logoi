import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../ai/models.dart';
import '../ai/prompts/prompts.dart';
import '../ai/router.dart';
import '../database/daos/chat_dao.dart';
import '../database/database.dart';

/// Compresses chat history after 6 turns (12 messages), keeping the last
/// 3 turns intact (docs/05_PROCESSING.md §7). Already-compressed blocks are
/// never recompressed.
class ChatHistoryCompressor {
  ChatHistoryCompressor({required ChatDao chatDao, required AIRouter router})
      : _chatDao = chatDao,
        _router = router;

  final ChatDao _chatDao;
  final AIRouter _router;
  static const _uuid = Uuid();

  static const int turnThreshold = 6;
  static const int keepTurns = 3;

  Future<void> compressIfNeeded(String sessionId) async {
    final messages = await _chatDao.getMessages(sessionId);
    final uncompressed = messages
        .where((m) => !m.isCompressed && m.role != 'system')
        .toList();
    if (uncompressed.length < turnThreshold * 2) return;

    final toCompress =
        uncompressed.sublist(0, uncompressed.length - keepTurns * 2);
    if (toCompress.isEmpty) return;

    final transcript = toCompress
        .map((m) => '${m.role}: ${m.content}')
        .join('\n');

    final result = await _router.complete(
      task: AITask.historyCompression,
      messages: [
        AIChatMessage(
          role: AIChatRole.system,
          content: Prompts.historyCompression.template,
        ),
        AIChatMessage(role: AIChatRole.user, content: transcript),
      ],
      maxTokens: 300,
    );

    final summary = result.valueOrNull;
    if (summary == null || summary.isEmpty) return;

    await _chatDao.insertMessage(ChatMessagesCompanion(
      id: Value(_uuid.v4()),
      sessionId: Value(sessionId),
      role: const Value('system'),
      content: Value(summary),
      isCompressed: const Value(true),
      createdAt: Value(toCompress.last.createdAt),
    ));
    await _chatDao.deleteMessages(toCompress.map((m) => m.id).toList());
  }
}
