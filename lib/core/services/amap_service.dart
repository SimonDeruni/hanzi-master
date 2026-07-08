import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;

/// AMap (高德地图) service combining static name database, WGS-84 ↔ GCJ-02
/// coordinate conversion, and optional AMap API geocoding.
class AmapService {
  static final AmapService _instance = AmapService._();
  factory AmapService() => _instance;
  AmapService._();

  final Map<String, _PlaceEntry> _places = {};
  final Set<String> _lookupSet = {};
  final List<int> _sortedLengths = [];
  bool _loaded = false;

  bool get isLoaded => _loaded;

  // ---------------------------------------------------------------------------
  // Load lightweight name database
  // ---------------------------------------------------------------------------

  Future<void> load() async {
    if (_loaded) return;

    final jsonStr =
        await rootBundle.loadString('assets/data/place_names.json');
    final List<dynamic> data = jsonDecode(jsonStr) as List<dynamic>;

    for (final entry in data) {
      final e = entry as Map<String, dynamic>;
      final place = _PlaceEntry(
        name: e['name'] as String,
        type: e['type'] as String? ?? 'landmark',
        province: e['province'] as String?,
        city: e['city'] as String?,
        dialect: e['dialect'] as String?,
        lat: (e['lat'] as num?)?.toDouble(),
        lng: (e['lng'] as num?)?.toDouble(),
        english: (e['english'] as List<dynamic>?)
                ?.map((x) => x.toString())
                .toList() ?? const [],
      );

      _places[place.name] = place;
      _lookupSet.add(place.name);

      for (final en in place.english) {
        _lookupSet.add(en.toLowerCase());
        _places[en] = place;
      }
    }

    // Build sorted length buckets (longest first) for reverse max-match
    final lengths = <int>{};
    for (final name in _places.keys) {
      lengths.add(name.length);
    }
    _sortedLengths.addAll(lengths);
    _sortedLengths.sort((a, b) => b.compareTo(a));

    _loaded = true;
  }  // ---------------------------------------------------------------------------
  // Scanning (reverse max-match)
  // ---------------------------------------------------------------------------

  List<PlaceMatch> scan(String text) {
    if (!_loaded || text.isEmpty) return [];

    final matches = <PlaceMatch>[];
    int i = 0;

    while (i < text.length) {
      bool found = false;
      for (final len in _sortedLengths) {
        if (i + len > text.length) continue;
        final substring = text.substring(i, i + len);

        if (_lookupSet.contains(substring)) {
          final place = _places[substring];
          if (place != null) {
            final overlaps = matches.any((m) =>
                (i >= m.startIndex && i < m.endIndex) ||
                (i + len > m.startIndex && i + len <= m.endIndex));
            if (!overlaps) {
              matches.add(PlaceMatch(
                matchedText: substring,
                name: place.name,
                type: place.type,
                province: place.province,
                city: place.city,
                dialect: place.dialect,
                lat: place.lat,
                lng: place.lng,
                startIndex: i,
                endIndex: i + len,
              ));
              i += len;
              found = true;
              break;
            }
          }
        }
      }
      if (!found) i++;
    }

    matches.sort((a, b) => a.startIndex.compareTo(b.startIndex));
    return matches;
  }

  // ---------------------------------------------------------------------------
  // WGS-84 -> GCJ-02 coordinate conversion
  // ---------------------------------------------------------------------------

  static const double _pi = 3.141592653589793;
  static const double _a = 6378245.0;
  static const double _ee = 0.00669342162296594323;

  static List<double> wgs84ToGcj02(double lat, double lng) {
    if (_outOfChina(lat, lng)) return [lat, lng];
    double dLat = _transformLat(lng - 105.0, lat - 35.0);
    double dLng = _transformLng(lng - 105.0, lat - 35.0);
    double radLat = lat / 180.0 * _pi;
    double magic = sin(radLat);
    magic = 1 - _ee * magic * magic;
    double sqrtMagic = sqrt(magic);
    dLat = (dLat * 180.0) / ((_a * (1 - _ee)) / (magic * sqrtMagic) * _pi);
    dLng = (dLng * 180.0) / (_a / sqrtMagic * cos(radLat) * _pi);
    return [lat + dLat, lng + dLng];
  }

  static bool _outOfChina(double lat, double lng) =>
      lng < 72.004 || lng > 137.8347 || lat < 0.8293 || lat > 55.8271;

  static double _transformLat(double x, double y) {
    double ret = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * sqrt(x.abs());
    ret += (20.0 * sin(6.0 * x * _pi) + 20.0 * sin(2.0 * x * _pi)) * 2.0 / 3.0;
    ret += (20.0 * sin(y * _pi) + 40.0 * sin(y / 3.0 * _pi)) * 2.0 / 3.0;
    ret += (160.0 * sin(y / 12.0 * _pi) + 320.0 * sin(y * _pi / 30.0)) * 2.0 / 3.0;
    return ret;
  }

  static double _transformLng(double x, double y) {
    double ret = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * sqrt(x.abs());
    ret += (20.0 * sin(6.0 * x * _pi) + 20.0 * sin(2.0 * x * _pi)) * 2.0 / 3.0;
    ret += (20.0 * sin(x * _pi) + 40.0 * sin(x / 3.0 * _pi)) * 2.0 / 3.0;
    ret += (150.0 * sin(x / 12.0 * _pi) + 300.0 * sin(x / 30.0 * _pi)) * 2.0 / 3.0;
    return ret;
  }

  // ---------------------------------------------------------------------------
  // Geocoding lookup
  // ---------------------------------------------------------------------------

  Future<Map<String, double>?> geocode(String name, {String? city}) async {
    final place = _places[name];
    if (place != null && place.lat != null && place.lng != null) {
      final gcj = wgs84ToGcj02(place.lat!, place.lng!);
      return {'lat': gcj[0], 'lng': gcj[1]};
    }
    return null;
  }
}

class _PlaceEntry {
  final String name;
  final String type;
  final String? province;
  final String? city;
  final String? dialect;
  final double? lat;
  final double? lng;
  final List<String> english;
  const _PlaceEntry({required this.name, required this.type, this.province, this.city, this.dialect, this.lat, this.lng, this.english = const []});
}

class PlaceMatch {
  final String matchedText;
  final String name;
  final String type;
  final String? province;
  final String? city;
  final String? dialect;
  final double? lat;
  final double? lng;
  final int startIndex;
  final int endIndex;
  const PlaceMatch({required this.matchedText, required this.name, required this.type, this.province, this.city, this.dialect, this.lat, this.lng, required this.startIndex, required this.endIndex});
}
