import 'package:drift/drift.dart';

import '../database.dart';
import '../tables/knowledge_tables.dart';

part 'concept_dao.drift.dart';

@DriftAccessor(tables: [Concepts, ConceptRelations, CrossReferences])
class ConceptDao extends DatabaseAccessor<LogoiDatabase> with _$ConceptDaoMixin {
  ConceptDao(super.db);

  // ── Concepts ──

  Stream<List<ConceptRow>> watchByProject(String projectId) =>
      (select(concepts)
            ..where((t) => t.projectId.equals(projectId))
            ..orderBy([(t) => OrderingTerm.asc(t.name)]))
          .watch();

  Future<List<ConceptRow>> getByProject(String projectId) =>
      (select(concepts)..where((t) => t.projectId.equals(projectId))).get();

  Future<void> insertConcept(ConceptsCompanion entry) =>
      into(concepts).insert(entry);

  Future<void> deleteConcept(String id) =>
      (delete(concepts)..where((t) => t.id.equals(id))).go();

  // ── Relations ──

  Future<List<ConceptRelationRow>> getRelations(String projectId) =>
      (select(conceptRelations)..where((t) => t.projectId.equals(projectId))).get();

  Future<void> insertRelation(ConceptRelationsCompanion entry) =>
      into(conceptRelations).insert(entry, mode: InsertMode.insertOrIgnore);

  Future<void> deleteRelation(String id) =>
      (delete(conceptRelations)..where((t) => t.id.equals(id))).go();

  // ── Cross references ──

  Future<List<CrossReferenceRow>> getCrossRefsForPage(
    String documentId,
    int pageNumber,
  ) =>
      (select(crossReferences)
            ..where((t) =>
                (t.sourceDocId.equals(documentId) & t.sourcePage.equals(pageNumber)) |
                (t.targetDocId.equals(documentId) & t.targetPage.equals(pageNumber))))
          .get();

  Future<void> insertCrossRef(CrossReferencesCompanion entry) =>
      into(crossReferences).insert(entry);

  Future<void> deleteCrossRef(String id) =>
      (delete(crossReferences)..where((t) => t.id.equals(id))).go();
}
