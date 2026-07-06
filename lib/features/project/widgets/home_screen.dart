import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../reader/widgets/reader_screen.dart';
import '../../settings/widgets/settings_screen.dart';
import '../models/project_summary.dart';
import '../providers/project_providers.dart';
import '../../../core/providers/core_providers.dart';

/// Home: project list (docs/06_UI_UX.md §1.1).
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projects = ref.watch(projectListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Logoi'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Configurações',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (_) => const SettingsScreen()),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Seus Projetos',
                    style: Theme.of(context).textTheme.headlineSmall),
                FilledButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Novo Projeto'),
                  onPressed: () => _showCreateDialog(context, ref),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: projects.when(
                data: (list) => list.isEmpty
                    ? const _EmptyState()
                    : _ProjectGrid(projects: list),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Erro: $e')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showCreateDialog(BuildContext context, WidgetRef ref) async {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    String? area;

    final created = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Novo Projeto'),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                autofocus: true,
                decoration: const InputDecoration(labelText: 'Nome'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: descriptionController,
                decoration:
                    const InputDecoration(labelText: 'Descrição (opcional)'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Área de estudo'),
                items: const [
                  DropdownMenuItem(value: 'filosofia', child: Text('Filosofia')),
                  DropdownMenuItem(value: 'medicina', child: Text('Medicina')),
                  DropdownMenuItem(value: 'direito', child: Text('Direito')),
                  DropdownMenuItem(
                      value: 'computação', child: Text('Computação')),
                  DropdownMenuItem(value: 'outra', child: Text('Outra')),
                ],
                onChanged: (v) => area = v,
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
            child: const Text('Criar'),
          ),
        ],
      ),
    );

    if (created != true || nameController.text.trim().isEmpty) return;
    final result = await ref.read(projectRepositoryProvider).createProject(
          name: nameController.text.trim(),
          description: descriptionController.text.trim().isEmpty
              ? null
              : descriptionController.text.trim(),
          area: area,
        );
    result.when(
      ok: (_) => ref.invalidate(projectListProvider),
      error: (failure) {
        if (context.mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(failure.message)));
        }
      },
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.menu_book_outlined,
              size: 64, color: Theme.of(context).colorScheme.outline),
          const SizedBox(height: 16),
          const Text('Nenhum projeto ainda.'),
          const SizedBox(height: 4),
          Text(
            'Crie um projeto para importar PDFs e começar a estudar.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _ProjectGrid extends ConsumerWidget {
  const _ProjectGrid({required this.projects});

  final List<ProjectSummary> projects;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 320,
        mainAxisExtent: 200,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: projects.length,
      itemBuilder: (context, index) =>
          _ProjectCard(summary: projects[index]),
    );
  }
}

class _ProjectCard extends ConsumerWidget {
  const _ProjectCard({required this.summary});

  final ProjectSummary summary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _openProject(context, ref),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('📚 ', style: TextStyle(fontSize: 18)),
                  Expanded(
                    child: Text(
                      summary.name,
                      style: theme.textTheme.titleMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  PopupMenuButton<String>(
                    itemBuilder: (_) => const [
                      PopupMenuItem(value: 'rename', child: Text('Renomear')),
                      PopupMenuItem(value: 'delete', child: Text('Excluir')),
                    ],
                    onSelected: (action) => switch (action) {
                      'rename' => _rename(context, ref),
                      'delete' => _delete(context, ref),
                      _ => null,
                    },
                  ),
                ],
              ),
              if (summary.description != null) ...[
                const SizedBox(height: 4),
                Text(
                  summary.description!,
                  style: theme.textTheme.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              const Spacer(),
              Text('${summary.documentCount} documento(s)',
                  style: theme.textTheme.bodySmall),
              Text(
                '${(summary.readProgress * 100).toStringAsFixed(0)}% lido · '
                '${summary.annotationCount} anotações',
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(value: summary.readProgress),
              const SizedBox(height: 8),
              Text(
                summary.lastReadAt != null
                    ? 'Última leitura: ${_formatDate(summary.lastReadAt!)}'
                    : 'Nunca lido',
                style: theme.textTheme.labelSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(int millis) =>
      DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(millis));

  Future<void> _openProject(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(currentProjectProvider.notifier).open(summary.id);
      if (context.mounted) {
        await Navigator.of(context).push(
          MaterialPageRoute<void>(builder: (_) => const ReaderScreen()),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Erro ao abrir projeto: $e')));
      }
    } finally {
      ref.invalidate(projectListProvider);
    }
  }

  Future<void> _rename(BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController(text: summary.name);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Renomear Projeto'),
        content: TextField(controller: controller, autofocus: true),
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
    if (confirmed == true && controller.text.trim().isNotEmpty) {
      await ref
          .read(projectRepositoryProvider)
          .renameProject(summary.id, controller.text.trim());
      ref.invalidate(projectListProvider);
    }
  }

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Excluir Projeto'),
        content: Text(
          'Excluir "${summary.name}" e todos os seus dados? '
          'Esta ação não pode ser desfeita.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(dialogContext).colorScheme.error,
            ),
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(projectRepositoryProvider).deleteProject(summary.id);
      ref.invalidate(projectListProvider);
    }
  }
}
