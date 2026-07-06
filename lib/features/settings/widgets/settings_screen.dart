import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/ai_providers.dart';
import '../../../core/providers/core_providers.dart';
import '../../../shared/theme/app_theme.dart';
import '../providers/media_settings_providers.dart';
import '../providers/settings_providers.dart';
import '../repositories/ai_settings_repository.dart';
import '../repositories/media_settings_repository.dart';
import 'project_limits_card.dart';

/// Settings: AI providers, theme, cost dashboard (docs/06_UI_UX.md §5).
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text('Providers de IA',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          for (final providerId in KnownProviders.all) ...[
            _ProviderCard(providerId: providerId),
            const SizedBox(height: 12),
          ],
          const Divider(height: 32),
          Text('Limites de IA', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          const ProjectLimitsCard(),
          const Divider(height: 32),
          Text('APIs de Mídia', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          const _MediaApiKeysCard(),
          const Divider(height: 32),
          Text('Aparência', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          const _ThemeSelector(),
          const Divider(height: 32),
          Text('Dashboard de Custo',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          const _UsageDashboard(),
        ],
      ),
    );
  }
}

class _ProviderCard extends ConsumerWidget {
  const _ProviderCard({required this.providerId});

  final String providerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasKey = ref.watch(providerHasKeyProvider(providerId));
    final ollamaStatus = ref.watch(ollamaStatusProvider);
    final isOllama = providerId == KnownProviders.ollama;

    final bool configured;
    if (isOllama) {
      configured = ollamaStatus.value ?? false;
    } else {
      configured = hasKey.value ?? false;
    }

    return Card(
      child: ListTile(
        leading: Icon(
          configured ? Icons.check_circle : Icons.circle_outlined,
          color: configured ? Colors.green : null,
        ),
        title: Text(KnownProviders.displayName(providerId)),
        subtitle: Text(
          isOllama
              ? (configured
                  ? 'Rodando (localhost:11434)'
                  : 'Não detectado — instale e rode o Ollama')
              : (configured ? 'Configurado' : 'Não configurado'),
        ),
        trailing: isOllama
            ? IconButton(
                icon: const Icon(Icons.refresh),
                tooltip: 'Verificar novamente',
                onPressed: () =>
                    ref.read(ollamaStatusProvider.notifier).refresh(),
              )
            : TextButton(
                onPressed: () => _configure(context, ref),
                child: Text(configured ? 'Alterar' : 'Configurar'),
              ),
      ),
    );
  }

  Future<void> _configure(BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController();
    final saved = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('API Key — ${KnownProviders.displayName(providerId)}'),
        content: SizedBox(
          width: 420,
          child: TextField(
            controller: controller,
            autofocus: true,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'API Key',
              helperText: 'Armazenada com segurança no keychain do sistema',
            ),
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
    if (saved == true && controller.text.trim().isNotEmpty) {
      final repository = await ref.read(aiSettingsRepositoryProvider.future);
      await repository.configureProvider(
        providerId: providerId,
        apiKey: controller.text.trim(),
      );
      ref.invalidate(providerHasKeyProvider(providerId));
    }
  }
}

class _ThemeSelector extends ConsumerWidget {
  const _ThemeSelector();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeControllerProvider);
    return SegmentedButton<LogoiThemeMode>(
      segments: const [
        ButtonSegment(
          value: LogoiThemeMode.light,
          label: Text('Claro'),
          icon: Icon(Icons.light_mode_outlined),
        ),
        ButtonSegment(
          value: LogoiThemeMode.dark,
          label: Text('Escuro'),
          icon: Icon(Icons.dark_mode_outlined),
        ),
        ButtonSegment(
          value: LogoiThemeMode.sepia,
          label: Text('Sépia'),
          icon: Icon(Icons.auto_stories_outlined),
        ),
      ],
      selected: {mode},
      onSelectionChanged: (selection) =>
          ref.read(themeControllerProvider.notifier).setMode(selection.first),
    );
  }
}

class _MediaApiKeysCard extends ConsumerWidget {
  const _MediaApiKeysCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: const Text('YouTube Data API'),
            subtitle: const Text('Busca e embed de vídeos in-app'),
            trailing: TextButton(
              onPressed: () => _editKey(
                context,
                ref,
                title: 'YouTube Data API Key',
                onSave: (v) => ref
                    .read(mediaSettingsRepositoryProvider)
                    .setYoutubeApiKey(v),
              ),
              child: const Text('Configurar'),
            ),
          ),
          ListTile(
            title: const Text('Google Maps / Mapbox'),
            subtitle: const Text('Tiles premium (fallback: OpenStreetMap)'),
            trailing: TextButton(
              onPressed: () => _editKey(
                context,
                ref,
                title: 'Maps API Key',
                onSave: (v) =>
                    ref.read(mediaSettingsRepositoryProvider).setMapsApiKey(v),
              ),
              child: const Text('Configurar'),
            ),
          ),
          ListTile(
            title: const Text('Google Custom Search'),
            subtitle: const Text('Busca de imagens além de Wikimedia'),
            trailing: TextButton(
              onPressed: () => _editCse(context, ref),
              child: const Text('Configurar'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _editKey(
    BuildContext context,
    WidgetRef ref, {
    required String title,
    required Future<void> Function(String) onSave,
  }) async {
    final controller = TextEditingController();
    final saved = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          obscureText: true,
          decoration: const InputDecoration(labelText: 'API Key'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
    if (saved == true && controller.text.trim().isNotEmpty) {
      await onSave(controller.text.trim());
      ref.invalidate(hasYoutubeApiKeyProvider);
    }
  }

  Future<void> _editCse(BuildContext context, WidgetRef ref) async {
    final keyCtrl = TextEditingController();
    final idCtrl = TextEditingController();
    final saved = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Google Custom Search'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: keyCtrl,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'API Key'),
            ),
            TextField(
              controller: idCtrl,
              decoration: const InputDecoration(labelText: 'Search Engine ID'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
    if (saved == true) {
      final repo = ref.read(mediaSettingsRepositoryProvider);
      if (keyCtrl.text.trim().isNotEmpty) {
        await repo.setGoogleCseKey(keyCtrl.text.trim());
      }
      if (idCtrl.text.trim().isNotEmpty) {
        await repo.setGoogleCseId(idCtrl.text.trim());
      }
    }
  }
}

class _UsageDashboard extends ConsumerWidget {
  const _UsageDashboard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(usageStatsProvider);
    return stats.when(
      loading: () => const LinearProgressIndicator(),
      error: (e, _) => Text('Erro ao carregar uso: $e'),
      data: (usage) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tokens usados (este mês): '
                '${usage.inputTokens} in / ${usage.outputTokens} out',
              ),
              const SizedBox(height: 4),
              Text(
                'Custo estimado: US\$ ${usage.estimatedCostUsd.toStringAsFixed(2)}',
              ),
              const SizedBox(height: 4),
              Text(
                'Cache hits: ${(usage.cacheHitRate * 100).toStringAsFixed(0)}%',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
