import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../models/media_reference.dart';

/// Integrated map tab (OpenStreetMap tiles, optional Mapbox key later).
class MapTab extends StatelessWidget {
  const MapTab({super.key, required this.entity});

  final ResolvedEntity entity;

  @override
  Widget build(BuildContext context) {
    if (!entity.hasCoordinates &&
        entity.bboxNorth == null) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Sem coordenadas geográficas para este termo.\n'
            'Tente selecionar um lugar ou região.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    final center = entity.hasCoordinates
        ? LatLng(entity.latitude!, entity.longitude!)
        : LatLng(
            ((entity.bboxNorth! + entity.bboxSouth!) / 2),
            ((entity.bboxEast! + entity.bboxWest!) / 2),
          );

    final markers = <Marker>[
      if (entity.hasCoordinates)
        Marker(
          point: center,
          width: 40,
          height: 40,
          child: const Icon(Icons.place, color: Colors.red, size: 36),
        ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(entity.entity, style: Theme.of(context).textTheme.titleMedium),
              if (entity.modernEquivalent != null)
                Text(
                  '→ ${entity.modernEquivalent}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
            ],
          ),
        ),
        Expanded(
          child: FlutterMap(
            options: MapOptions(
              initialCenter: center,
              initialZoom: entity.hasCoordinates ? 6 : 4,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'dev.logoi.logoi',
              ),
              if (entity.bboxNorth != null)
                PolygonLayer(
                  polygons: [
                    Polygon(
                      points: [
                        LatLng(entity.bboxNorth!, entity.bboxWest!),
                        LatLng(entity.bboxNorth!, entity.bboxEast!),
                        LatLng(entity.bboxSouth!, entity.bboxEast!),
                        LatLng(entity.bboxSouth!, entity.bboxWest!),
                      ],
                      color: Colors.blue.withValues(alpha: 0.2),
                      borderColor: Colors.blue,
                      borderStrokeWidth: 2,
                    ),
                  ],
                ),
              MarkerLayer(markers: markers),
            ],
          ),
        ),
      ],
    );
  }
}
