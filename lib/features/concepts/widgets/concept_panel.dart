import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database.dart';
import '../providers/concept_providers.dart';
import 'concept_graph_view.dart';

const _conceptTypes = [
  'theoretical',
  'methodological',
  'empirical',
  'person',
  'event',
  'place',
];

String conceptTypeLabel(String? type) => switch (type) {
      'theoretical' => 'Teórico',
      'methodological' => 'Metodológico',
      'empirical' => 'Empírico',
      'person' => 'Pessoa',
      'event' => 'Evento',
      'place' => 'Lugar',
      _ => 'Sem tipo',
    };

/// Concepts tab of the left panel: filterable list, manual add and
/// access to the interactive graph (docs/08_ROADMAP.md §3.5).
class ConceptPanel extends ConsumerStatefulWidget {
  const ConceptPanel({super.key});

  @override
  ConsumerState<ConceptPanel> createState() => _ConceptPanelState();
}

class _ConceptPanelState extends ConsumerState<ConceptPanel> {
  String? _typeFilter;

  @override
  Widget build(BuildContext context) {
    final concepts = ref.watch(conceptListProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            children: [
              Expanded(
                child: Text('Conceitos',
                    style: Theme.of(context).textTheme.titleSmall),
              ),
              IconButton(
                icon: const Icon(Icons.hub_outlined, size: 18),
                tooltip: 'Ver grafo',
                onPressed: () => _showGraphDialog(context),
              ),
              IconButton(
                icon: const Icon(Icons.add, size: 18),
                tooltip: 'Adicionar conceito',
                onPressed: () => _showAddDialog(context),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            children: [
              for (final type in [null, ..._conceptTypes])
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: FilterChip(
                    label: Text(type == null ? 'Todos' : conceptTypeLabel(type)),
                    visualDensity: VisualDensity.compact,
                    selected: _typeFilter == type,
                    onSelected: (_) => setState(() => _typeFilter = type),
                  ),
                ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: concepts.when(
            data: (list) {
              final filtered = _typeFilter == null
                  ? list
                  : list.where((c) => c.type == _typeFilter).toList();
              if (filtered.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Nenhum conceito. Selecione um trecho no PDF e use '
                      '"Extrair conceitos", ou adicione manualmente.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
              return ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final concept = filtered[index];
                  return ListTile(
                    dense: true,
                    leading: Icon(
                      Icons.circle,
                      size: 12,
                      color: conceptTypeColor(
                          concept.type, Theme.of(context).colorScheme),
                    ),
                    title: Text(concept.name),
                    subtitle: concept.definition != null
                        ? Text(
                            concept.definition!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )
                        : null,
                    trailing: PopupMenuButton<String>(
                      iconSize: 16,
                      itemBuilder: (_) => const [
                        PopupMenuItem(value: 'delete', child: Text('Excluir')),
                      ],
                      onSelected: (_) async {
                        final repository = await ref
                            .read(conceptRepositoryProvider.future);
                        await repository?.deleteConcept(concept.id);
                      },
                    ),
                    onTap: () => showConceptDetails(context, concept),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Erro: $e')),
          ),
        ),
      ],
    );
  }

  Future<void> _showGraphDialog(BuildContext context) => showDialog<void>(
        context: context,
        builder: (dialogContext) => Dialog(
          child: SizedBox(
            width: 900,
            height: 640,
            child: Column(
              children: [
                AppBar(
                  title: const Text('Grafo de conceitos'),
                  automaticallyImplyLeading: false,
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(dialogContext).pop(),
                    ),
                  ],
                ),
                Expanded(child: _GraphDialogBody()),
              ],
            ),
          ),
        ),
      );

  Future<void> _showAddDialog(BuildContext context) async {
    final nameController = TextEditingController();
    final definitionController = TextEditingController();
    String? type;
    final saved = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Novo conceito'),
        content: SizedBox(
          width: 380,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                autofocus: true,
                decoration: const InputDecoration(labelText: 'Nome'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: definitionController,
                decoration: const InputDecoration(labelText: 'Definição'),
                maxLines: 3,
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                initialValue: type,
                decoration: const InputDecoration(labelText: 'Tipo'),
                items: [
                  for (final t in _conceptTypes)
                    DropdownMenuItem(
                        value: t, child: Text(conceptTypeLabel(t))),
                ],
                onChanged: (value) => type = value,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
    if (saved == true && nameController.text.trim().isNotEmpty) {
      final repository = await ref.read(conceptRepositoryProvider.future);
      await repository?.addManual(
        name: nameController.text,
        definition: definitionController.text.trim().isEmpty
            ? null
            : definitionController.text.trim(),
        type: type,
      );
    }
    nameController.dispose();
    definitionController.dispose();
  }
}

class _GraphDialogBody extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final graph = ref.watch(conceptGraphProvider);
    return graph.when(
      data: (data) => data == null
          ? const Center(child: Text('Nenhum projeto aberto'))
          : ConceptGraphView(
              data: data,
              onTapConcept: (concept) => showConceptDetails(context, concept),
            ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Erro: $e')),
    );
  }
}

void showConceptDetails(BuildContext context, ConceptRow concept) {
  showDialog<void>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(concept.name),
      content: SizedBox(
        width: 380,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 6,
              children: [
                Chip(
                  label: Text(conceptTypeLabel(concept.type)),
                  visualDensity: VisualDensity.compact,
                ),
                Chip(
                  label: Text(concept.source == 'ai' ? 'IA' : 'Manual'),
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(concept.definition ?? '(sem definição)'),
          ],
        ),
      ),
      actions: [
        FilledButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: const Text('Fechar'),
        ),
      ],
    ),
  );
}
