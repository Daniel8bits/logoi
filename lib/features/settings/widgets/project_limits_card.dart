import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/ai_providers.dart';
import '../../project/models/project_settings.dart';
import '../../project/providers/project_providers.dart';

/// Project AI limits editor (docs/06_UI_UX.md §5.2).
class ProjectLimitsCard extends ConsumerStatefulWidget {
  const ProjectLimitsCard({super.key});

  @override
  ConsumerState<ProjectLimitsCard> createState() => _ProjectLimitsCardState();
}

class _ProjectLimitsCardState extends ConsumerState<ProjectLimitsCard> {
  ProjectSettings? _draft;

  @override
  Widget build(BuildContext context) {
    final project = ref.watch(currentProjectProvider);
    if (project == null) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text('Abra um projeto para configurar limites de IA.'),
        ),
      );
    }

    final settings = _draft ?? project.settings;
    final snapshot = ref.watch(aiUsageSnapshotProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Limites de IA — ${project.project.name}',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            snapshot.when(
              loading: () => const LinearProgressIndicator(),
              error: (e, _) => Text('Erro: $e'),
              data: (usage) {
                if (usage == null) return const SizedBox.shrink();
                return Column(
                  children: [
                    _QuotaBar(
                      label: 'Requisições/hora',
                      value: usage.requestsLastHour,
                      max: usage.limits.maxApiRequestsPerHour,
                    ),
                    _QuotaBar(
                      label: 'Tokens hoje',
                      value: usage.tokensToday,
                      max: usage.limits.maxTokensPerDay,
                    ),
                    _QuotaBar(
                      label: 'Custo mês (USD)',
                      value: (usage.costThisMonth * 100).round(),
                      max: (usage.limits.maxCostUsdPerMonth * 100).round(),
                      format: (v) => '\$${(v / 100).toStringAsFixed(2)}',
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            Text('Teto de requisições/hora: ${settings.maxApiRequestsPerHour}'),
            Slider(
              value: settings.maxApiRequestsPerHour.toDouble(),
              min: 5,
              max: 100,
              divisions: 19,
              label: '${settings.maxApiRequestsPerHour}',
              onChanged: (v) => setState(
                () => _draft = settings.copyWith(maxApiRequestsPerHour: v.round()),
              ),
            ),
            Text('Chamadas/min (anti-burst): ${settings.maxCallsPerMinute}'),
            Slider(
              value: settings.maxCallsPerMinute.toDouble(),
              min: 2,
              max: 20,
              divisions: 18,
              onChanged: (v) => setState(
                () => _draft = settings.copyWith(maxCallsPerMinute: v.round()),
              ),
            ),
            Text(
              'Intervalo mínimo: ${settings.minSecondsBetweenCalls.toStringAsFixed(1)}s',
            ),
            Slider(
              value: settings.minSecondsBetweenCalls,
              min: 0.5,
              max: 5,
              divisions: 9,
              onChanged: (v) => setState(
                () => _draft = settings.copyWith(minSecondsBetweenCalls: v),
              ),
            ),
            SwitchListTile(
              title: const Text('Circuit breaker anti-loop'),
              value: settings.circuitBreakerEnabled,
              onChanged: (v) => setState(
                () => _draft = settings.copyWith(circuitBreakerEnabled: v),
              ),
            ),
            SwitchListTile(
              title: const Text('Confirmar antes de batch IA'),
              value: settings.confirmBeforeBatchAi,
              onChanged: (v) => setState(
                () => _draft = settings.copyWith(confirmBeforeBatchAi: v),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton(
                onPressed: _draft == null
                    ? null
                    : () async {
                        await ref
                            .read(currentProjectProvider.notifier)
                            .updateSettings(_draft!);
                        setState(() => _draft = null);
                        ref.invalidate(aiUsageSnapshotProvider);
                      },
                child: const Text('Salvar limites'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuotaBar extends StatelessWidget {
  const _QuotaBar({
    required this.label,
    required this.value,
    required this.max,
    this.format,
  });

  final String label;
  final int value;
  final int max;
  final String Function(int)? format;

  @override
  Widget build(BuildContext context) {
    final ratio = max == 0 ? 0.0 : (value / max).clamp(0.0, 1.0);
    final color = ratio >= 1
        ? Colors.red
        : ratio >= 0.8
            ? Colors.orange
            : Theme.of(context).colorScheme.primary;
    final display = format?.call(value) ?? '$value / $max';
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.labelMedium),
          LinearProgressIndicator(value: ratio, color: color),
          Text(display, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
