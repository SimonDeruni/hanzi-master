import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;
import 'package:hanzi_master/core/services/amap_service.dart';
import 'package:hanzi_master/features/explore/presentation/widgets/ai_cultural_box_sheet.dart';

/// Full-screen location map with info card + AI cultural exploration.
/// Uses OpenStreetMap tiles in-app; "Open in Maps" launches native maps app.
class ExploreMapScreen extends StatefulWidget {
  final PlaceMatch match;

  const ExploreMapScreen({super.key, required this.match});

  @override
  State<ExploreMapScreen> createState() => _ExploreMapScreenState();
}

class _ExploreMapScreenState extends State<ExploreMapScreen> {
  LatLng? _displayCenter;
  bool _loadingCoords = true;

  @override
  void initState() {
    super.initState();
    _resolveCoordinates();
  }

  Future<void> _resolveCoordinates() async {
    final service = AmapService();
    final result = await service.geocode(widget.match.name,
        city: widget.match.city ?? widget.match.province);

    if (result != null && mounted) {
      setState(() {
        _displayCenter = LatLng(result['lat']!, result['lng']!);
        _loadingCoords = false;
      });
    } else if (widget.match.lat != null && widget.match.lng != null && mounted) {
      setState(() {
        _displayCenter = LatLng(widget.match.lat!, widget.match.lng!);
        _loadingCoords = false;
      });
    } else if (mounted) {
      setState(() => _loadingCoords = false);
    }
  }

  void _openInMaps() {
    if (_displayCenter == null) return;
    final lat = _displayCenter!.latitude;
    final lng = _displayCenter!.longitude;
    final name = Uri.encodeComponent(widget.match.name);
    final url = Platform.isIOS
        ? 'https://maps.apple.com/?q=$name&ll=$lat,$lng'
        : 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.match.name),
        backgroundColor: const Color(0xFF1A1A2E),
        foregroundColor: Colors.white,
        actions: [
          if (_displayCenter != null)
            IconButton(
              icon: const Icon(Icons.open_in_new),
              tooltip: 'Open in Maps',
              onPressed: _openInMaps,
            ),
        ],
      ),
      body: _loadingCoords
          ? const Center(child: CircularProgressIndicator())
          : _displayCenter == null
              ? _LocationInfoCard(match: widget.match, fullScreen: true)
              : Stack(
                  children: [
                    FlutterMap(
                      options: MapOptions(
                        initialCenter: _displayCenter!,
                        initialZoom: 13.0,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.hanzimaster.app',
                        ),
                        MarkerLayer(markers: [
                          Marker(
                            point: _displayCenter!,
                            width: 200,
                            height: 80,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.location_on,
                                    color: Colors.red, size: 36),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 4,
                                          offset: Offset(0, 2)),
                                    ],
                                  ),
                                  child: Text(
                                    widget.match.name,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: _LocationInfoCard(match: widget.match),
                    ),
                  ],
                ),
    );
  }
}

class _LocationInfoCard extends StatelessWidget {
  final PlaceMatch match;
  final bool fullScreen;

  const _LocationInfoCard({required this.match, this.fullScreen = false});

  @override
  Widget build(BuildContext context) {
    final typeLabel = switch (match.type) {
      'province' => '省',
      'city' => '城市',
      'district' => '区/县',
      'landmark' => '景点',
      _ => match.type,
    };

    final card = Container(
      margin: fullScreen
          ? const EdgeInsets.all(24)
          : const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 4))
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Text(match.name,
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(typeLabel,
                  style: TextStyle(
                      fontSize: 12, color: Colors.blue.shade800)),
            ),
          ]),
          if (match.province != null) ...[
            const SizedBox(height: 4),
            Text(
              '${match.province}${match.city != null ? ' · ${match.city}' : ''}',
              style:
                  TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
          ],
          if (match.dialect != null) ...[
            const SizedBox(height: 4),
            Text('方言: ${match.dialect}',
                style: TextStyle(
                    color: Colors.orange.shade700, fontSize: 13)),
          ],
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20))),
                builder: (ctx) => AiCulturalBoxSheet(match: match),
              ),
              icon: const Icon(Icons.auto_awesome),
              label: const Text('AI 文化探索'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A1A2E),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ],
      ),
    );

    if (fullScreen) {
      return Center(
          child: SingleChildScrollView(child: card));
    }
    return card;
  }
}