/// Shared value objects for the AI layer (docs/04_AI_LAYER.md).
library;

/// Chat message exchanged with any provider.
class AIChatMessage {
  const AIChatMessage({required this.role, required this.content});

  final AIChatRole role;
  final String content;

  Map<String, dynamic> toOpenAIJson() => {
        'role': role.name,
        'content': content,
      };
}

enum AIChatRole { system, user, assistant }

/// A model available on a provider.
class AIModel {
  const AIModel({required this.id, required this.name, this.contextLength});

  final String id;
  final String name;
  final int? contextLength;
}

/// Tasks routable by the AIRouter (docs/02_ARCHITECTURE.md §4.1).
enum AITask {
  chat,
  explain,
  summarize,
  socratic,
  argueAgainst,
  historicalContext,
  flashcards,
  argumentMap,
  biasDetection,
  conceptExtraction,
  crossReference,
  documentMap,
  sectionSummary,
  chapterSummary,
  documentSummary,
  historyCompression,
  readingSummary,
  entityResolution,
}

/// Selection granularity (docs/04_AI_LAYER.md §1.3).
enum SelectionLevel { word, sentence, paragraph, section }

/// Retrieved RAG chunk.
class RAGChunk {
  const RAGChunk({
    required this.text,
    required this.pageNumber,
    required this.similarity,
    this.isCurrentPage = false,
  });

  final String text;
  final int pageNumber;
  final double similarity;
  final bool isCurrentPage;
}

/// Context assembled for every AI request (docs/04_AI_LAYER.md §1.3).
class AIRequestContext {
  const AIRequestContext({
    required this.projectName,
    required this.documentTitle,
    required this.currentPage,
    required this.totalPages,
    required this.userLanguage,
    this.projectArea,
    this.documentAuthors,
    this.documentYear,
    this.selectedText,
    this.selectionLevel,
    this.retrievedChunks,
    this.sectionSummary,
    this.chapterSummary,
    this.relatedAnnotations,
    this.activeConceptMap,
  });

  final String projectName;
  final String? projectArea;
  final String documentTitle;
  final String? documentAuthors;
  final int? documentYear;
  final int currentPage;
  final int totalPages;
  final String? selectedText;
  final SelectionLevel? selectionLevel;
  final List<RAGChunk>? retrievedChunks;
  final String? sectionSummary;
  final String? chapterSummary;
  final List<String>? relatedAnnotations;
  final String? activeConceptMap;
  final String userLanguage;

  String ragContextBlock() {
    final chunks = retrievedChunks;
    if (chunks == null || chunks.isEmpty) return '(no retrieved context)';
    return chunks
        .map((c) => '[p.${c.pageNumber}] ${c.text}')
        .join('\n\n');
  }
}
