import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:hanzi_master/core/services/amap_service.dart';
import 'package:hanzi_master/features/explore/presentation/widgets/ai_cultural_box_sheet.dart';

/// Full-screen location deep-dive with AMap coordinates + AI cultural sheet.
class ExploreMapScreen extends StatefulWidget {
  final PlaceMatch match;

  const ExploreMapScreen({super.key, required this.match});

  @override
  State<ExploreMapScreen> createState() => _ExploreMapScreenState();
}

class _ExploreMapScreenState extends State<ExploreMapScreen> {
  LatLng? _gcjCenter;
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
        _gcjCenter = LatLng(result['lat']!, result['lng']!);
        _loadingCoords = false;
      });
    } else if (widget.match.lat != null && widget.match.lng != null && mounted) {
      final gcj = AmapService.wgs84ToGcj02(
          widget.match.lat!, widget.match.lng!);
      setState(() {
        _gcjCenter = LatLng(gcj[0], gcj[1]);
        _loadingCoords = false;
      });
    } else if (mounted) {
      setState(() => _loadingCoords = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.match.name),
        backgroundColor: const Color(0xFF1A1A2E),
        foregroundColor: Colors.white,
      ),
      body: _loadingCoords
          ? const Center(child: CircularProgressIndicator())
          : _gcjCenter == null
              ? _LocationInfoCard(match: widget.match, fullScreen: true)
              : Stack(
                  children: [
                    _buildMapPlaceholder(),
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

  Widget _buildMapPlaceholder() {
    return Container(
      color: const Color(0xFFE8E8E8),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.map, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(widget.match.name,
                style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333))),
            if (_gcjCenter != null) ...[
              const SizedBox(height: 8),
              Text(
                '${_gcjCenter!.latitude.toStringAsFixed(4)}, ${_gcjCenter!.longitude.toStringAsFixed(4)}',
                style:
                    TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ],
            const SizedBox(height: 16),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: const Text(
                'AMap SDK — configure API key in .env',
                style: TextStyle(fontSize: 12, color: Colors.orange),
              ),
            ),
          ],
        ),
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