/// Annotation types (docs/03_DATABASE.md §3.8).
enum AnnotationType {
  highlight,
  note,
  bookmark,
  question;

  String get label => switch (this) {
        AnnotationType.highlight => 'Destaque',
        AnnotationType.note => 'Nota',
        AnnotationType.bookmark => 'Marcador',
        AnnotationType.question => 'Questão',
      };
}
