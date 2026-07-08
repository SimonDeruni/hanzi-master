import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hanzi_master/features/explore/domain/entities/cultural_location.dart';

class LocationDatabase {
  static final LocationDatabase _instance = LocationDatabase._();
  factory LocationDatabase() => _instance;
  LocationDatabase._();

  final Map<String, GeoLocation> _locations = {};
  final Set<String> _lookupSet = {};
  final List<int> _sortedLengths = [];
  bool _loaded = false;

  bool get isLoaded => _loaded;

  /// Load the location database from the bundled JSON asset.
  Future<void> load() async {
    if (_loaded) return;

    final jsonStr = await rootBundle.loadString('assets/data/china_locations.json');
    final Map<String, dynamic> data = jsonDecode(jsonStr) as Map<String, dynamic>;

    for (final entry in data.entries) {
      final loc = GeoLocation.fromJson(entry.value as Map<String, dynamic>);

      // Index Chinese name
      _locations[entry.key] = loc;
      _lookupSet.add(entry.key.toLowerCase());

      // Index all English variants (case-insensitive)
      for (final en in loc.englishNames) {
        _lookupSet.add(en.toLowerCase());
      }
    }

    // Build sorted length buckets for reverse max match
    final lengths = <int>{};
    for (final name in _locations.keys) {
      lengths.add(name.length);
    }
    for (final en in _lookupSet) {
      if (en.codeUnits.every((c) => c <= 127)) {
        // Only count English names separately
        lengths.add(en.length);
      }
    }
    _sortedLengths.addAll(lengths);
    _sortedLengths.sort((a, b) => b.compareTo(a)); // longest first

    _loaded = true;
  }

  /// Scan [text] for any known location names (Chinese + English variants).
  /// Uses reverse maximum match: tries longest names first to avoid
  /// false positives (e.g. 中山公园 before 中山).
  List<LocationMatch> scan(String text) {
    if (!_loaded) return [];
    if (text.isEmpty) return [];

    final matches = <LocationMatch>[];
    int i = 0;

    while (i < text.length) {
      bool found = false;

      for (final len in _sortedLengths) {
        if (i + len > text.length) continue;

        final substring = text.substring(i, i + len);
        final lookupKey = substring.toLowerCase();

        if (_lookupSet.contains(lookupKey)) {
          // Find the corresponding GeoLocation
          GeoLocation? location;

          // Try Chinese name first
          for (final entry in _locations.entries) {
            if (entry.key == substring) {
              location = entry.value;
              break;
            }
          }

          // Then try English variants
          if (location == null) {
            for (final entry in _locations.entries) {
              if (entry.value.englishNames
                  .any((en) => en.toLowerCase() == lookupKey)) {
                location = entry.value;
                break;
              }
            }
          }

          if (location != null) {
            // Avoid overlapping matches: skip characters that are already
            // inside a previous match
            final overlaps = matches.any((m) =>
                (i >= m.startIndex && i < m.endIndex) ||
                (i + len > m.startIndex && i + len <= m.endIndex));

            if (!overlaps) {
              matches.add(LocationMatch(
                matchedText: substring,
                location: location,
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

      if (!found) {
        i++;
      }
    }

    // Sort by position
    matches.sort((a, b) => a.startIndex.compareTo(b.startIndex));
    return matches;
  }
}