import 'package:latlong2/latlong.dart';

class GeoLocation {
  final String name;
  final String type; // 'province', 'city', 'district', 'landmark'
  final String? province;
  final String? city;
  final LatLng coordinates;
  final String? dialect;
  final String? context;
  final List<String> englishNames;

  const GeoLocation({
    required this.name,
    required this.type,
    this.province,
    this.city,
    required this.coordinates,
    this.dialect,
    this.context,
    this.englishNames = const [],
  });

  factory GeoLocation.fromJson(Map<String, dynamic> json) {
    return GeoLocation(
      name: json['name'] as String? ?? '',
      type: json['type'] as String? ?? 'landmark',
      province: json['province'] as String?,
      city: json['city'] as String?,
      coordinates: LatLng(
        (json['lat'] as num?)?.toDouble() ?? 0.0,
        (json['lng'] as num?)?.toDouble() ?? 0.0,
      ),
      dialect: json['dialect'] as String?,
      context: json['context'] as String?,
      englishNames: (json['englishNames'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'type': type,
        if (province != null) 'province': province,
        if (city != null) 'city': city,
        'lat': coordinates.latitude,
        'lng': coordinates.longitude,
        if (dialect != null) 'dialect': dialect,
        if (context != null) 'context': context,
        'englishNames': englishNames,
      };
}

class LocationMatch {
  final String matchedText;
  final GeoLocation location;
  final int startIndex;
  final int endIndex;

  const LocationMatch({
    required this.matchedText,
    required this.location,
    required this.startIndex,
    required this.endIndex,
  });
}

class CulturalInsight {
  final String locationName;
  final String culturalContext;
  final List<DialectWord> dialectWords;
  final List<DialectPhrase> phrases;

  const CulturalInsight({
    required this.locationName,
    required this.culturalContext,
    required this.dialectWords,
    required this.phrases,
  });

  factory CulturalInsight.fromJson(Map<String, dynamic> json) {
    return CulturalInsight(
      locationName: json['locationName'] as String? ?? '',
      culturalContext: json['culturalContext'] as String? ?? '',
      dialectWords: (json['dialectWords'] as List<dynamic>?)
              ?.map((e) => DialectWord.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      phrases: (json['phrases'] as List<dynamic>?)
              ?.map((e) => DialectPhrase.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class DialectWord {
  final String hanzi;
  final String pinyin;
  final String meaning;

  const DialectWord({
    required this.hanzi,
    required this.pinyin,
    required this.meaning,
  });

  factory DialectWord.fromJson(Map<String, dynamic> json) {
    return DialectWord(
      hanzi: json['hanzi'] as String? ?? '',
      pinyin: json['pinyin'] as String? ?? '',
      meaning: json['meaning'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'hanzi': hanzi,
        'pinyin': pinyin,
        'meaning': meaning,
      };
}

class DialectPhrase {
  final String chinese;
  final String pinyin;
  final String english;

  const DialectPhrase({
    required this.chinese,
    required this.pinyin,
    required this.english,
  });

  factory DialectPhrase.fromJson(Map<String, dynamic> json) {
    return DialectPhrase(
      chinese: json['chinese'] as String? ?? '',
      pinyin: json['pinyin'] as String? ?? '',
      english: json['english'] as String? ?? '',
    );
  }
}