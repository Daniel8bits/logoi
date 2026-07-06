import 'dart:math';

import 'package:flutter/material.dart';

import '../../../core/database/database.dart';
import '../repositories/concept_repository.dart';

/// Interactive force-directed concept graph (docs/08_ROADMAP.md §3.5).
/// Layout is computed with Fruchterman-Reingold; pan/zoom via
/// InteractiveViewer; tapping a node opens its details.
class ConceptGraphView extends StatefulWidget {
  const ConceptGraphView({
    super.key,
    required this.data,
    this.onTapConcept,
  });

  final ConceptGraphData data;
  final void Function(ConceptRow concept)? onTapConcept;

  @override
  State<ConceptGraphView> createState() => _ConceptGraphViewState();
}

class _ConceptGraphViewState extends State<ConceptGraphView> {
  static const _canvasSize = Size(1400, 1000);
  late Map<String, Offset> _positions;

  @override
  void initState() {
    super.initState();
    _positions = _computeLayout();
  }

  @override
  void didUpdateWidget(ConceptGraphView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data != widget.data) {
      _positions = _computeLayout();
    }
  }

  /// Fruchterman-Reingold with simulated annealing.
  Map<String, Offset> _computeLayout() {
    final nodes = widget.data.concepts;
    if (nodes.isEmpty) return {};

    final random = Random(42);
    final width = _canvasSize.width, height = _canvasSize.height;
    final positions = {
      for (final node in nodes)
        node.id: Offset(
          width * (0.2 + 0.6 * random.nextDouble()),
          height * (0.2 + 0.6 * random.nextDouble()),
        ),
    };
    if (nodes.length == 1) return positions;

    final k = sqrt(width * height / nodes.length) * 0.6;
    var temperature = width / 8;

    for (var iteration = 0; iteration < 200; iteration++) {
      final displacement = {for (final n in nodes) n.id: Offset.zero};

      // Repulsion between every pair.
      for (var i = 0; i < nodes.length; i++) {
        for (var j = i + 1; j < nodes.length; j++) {
          final a = nodes[i].id, b = nodes[j].id;
          var delta = positions[a]! - positions[b]!;
          var distance = delta.distance;
          if (distance < 0.01) {
            delta = Offset(random.nextDouble() - 0.5, random.nextDouble() - 0.5);
            distance = delta.distance;
          }
          final force = k * k / distance;
          final push = delta / distance * force;
          displacement[a] = displacement[a]! + push;
          displacement[b] = displacement[b]! - push;
        }
      }

      // Attraction along edges.
      for (final edge in widget.data.relations) {
        final source = positions[edge.sourceId];
        final target = positions[edge.targetId];
        if (source == null || target == null) continue;
        final delta = source - target;
        final distance = max(delta.distance, 0.01);
        final pull = delta / distance * (distance * distance / k);
        displacement[edge.sourceId] = displacement[edge.sourceId]! - pull;
        displacement[edge.targetId] = displacement[edge.targetId]! + pull;
      }

      for (final node in nodes) {
        final move = displacement[node.id]!;
        final distance = max(move.distance, 0.01);
        final limited = move / distance * min(distance, temperature);
        final next = positions[node.id]! + limited;
        positions[node.id] = Offset(
          next.dx.clamp(60.0, width - 60.0),
          next.dy.clamp(40.0, height - 40.0),
        );
      }
      temperature *= 0.96;
    }
    return positions;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.concepts.isEmpty) {
      return const Center(child: Text('Nenhum conceito no projeto'));
    }
    return InteractiveViewer(
      constrained: false,
      minScale: 0.3,
      maxScale: 3,
      boundaryMargin: const EdgeInsets.all(200),
      child: GestureDetector(
        onTapUp: _handleTap,
        child: CustomPaint(
          size: _canvasSize,
          painter: _GraphPainter(
            data: widget.data,
            positions: _positions,
            theme: Theme.of(context),
          ),
        ),
      ),
    );
  }

  void _handleTap(TapUpDetails details) {
    final onTap = widget.onTapConcept;
    if (onTap == null) return;
    for (final concept in widget.data.concepts) {
      final position = _positions[concept.id];
      if (position != null &&
          (details.localPosition - position).distance <= 28) {
        onTap(concept);
        return;
      }
    }
  }
}

Color conceptTypeColor(String? type, ColorScheme scheme) => switch (type) {
      'theoretical' => Colors.indigo,
      'methodological' => Colors.teal,
      'empirical' => Colors.orange,
      'person' => Colors.pink,
      'event' => Colors.brown,
      'place' => Colors.green,
      _ => scheme.primary,
    };

class _GraphPainter extends CustomPainter {
  _GraphPainter({
    required this.data,
    required this.positions,
    required this.theme,
  });

  final ConceptGraphData data;
  final Map<String, Offset> positions;
  final ThemeData theme;

  @override
  void paint(Canvas canvas, Size size) {
    final edgePaint = Paint()
      ..color = theme.colorScheme.outlineVariant
      ..strokeWidth = 1.2;

    for (final edge in data.relations) {
      final source = positions[edge.sourceId];
      final target = positions[edge.targetId];
      if (source == null || target == null) continue;
      canvas.drawLine(source, target, edgePaint);
    }

    for (final concept in data.concepts) {
      final position = positions[concept.id];
      if (position == null) continue;
      final color = conceptTypeColor(concept.type, theme.colorScheme);

      canvas.drawCircle(
        position,
        16,
        Paint()..color = color.withValues(alpha: 0.85),
      );
      if (concept.source == 'ai') {
        canvas.drawCircle(
          position,
          16,
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2
            ..color = theme.colorScheme.surface,
        );
      }

      final label = TextPainter(
        text: TextSpan(
          text: concept.name,
          style: theme.textTheme.labelSmall,
        ),
        textDirection: TextDirection.ltr,
        maxLines: 2,
        ellipsis: '…',
      )..layout(maxWidth: 120);
      label.paint(
        canvas,
        position + Offset(-label.width / 2, 20),
      );
    }
  }

  @override
  bool shouldRepaint(_GraphPainter oldDelegate) =>
      oldDelegate.data != data || oldDelegate.positions != positions;
}
