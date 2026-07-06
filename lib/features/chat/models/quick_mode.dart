import '../../../core/ai/models.dart';

/// Quick prompt modes reachable from the selection context menu
/// (docs/06_UI_UX.md §2.2).
enum QuickMode {
  explain,
  summarize,
  socratic,
  argueAgainst,
  historicalContext,
  flashcards,
  argumentMap,
  biasDetection;

  AITask get task => switch (this) {
        QuickMode.explain => AITask.explain,
        QuickMode.summarize => AITask.summarize,
        QuickMode.socratic => AITask.socratic,
        QuickMode.argueAgainst => AITask.argueAgainst,
        QuickMode.historicalContext => AITask.historicalContext,
        QuickMode.flashcards => AITask.flashcards,
        QuickMode.argumentMap => AITask.argumentMap,
        QuickMode.biasDetection => AITask.biasDetection,
      };

  String get label => switch (this) {
        QuickMode.explain => 'Explicar',
        QuickMode.summarize => 'Resumir',
        QuickMode.socratic => 'Questionar (Socrático)',
        QuickMode.argueAgainst => 'Contra-argumentar',
        QuickMode.historicalContext => 'Contextualizar',
        QuickMode.flashcards => 'Gerar Flashcards',
        QuickMode.argumentMap => 'Mapear Argumento',
        QuickMode.biasDetection => 'Detectar Viés',
      };

  /// Modes whose responses are structured JSON.
  bool get returnsJson => switch (this) {
        QuickMode.flashcards ||
        QuickMode.argumentMap ||
        QuickMode.biasDetection =>
          true,
        _ => false,
      };
}
