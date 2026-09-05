class LocalTtsVoice {
  final String name;
  final String locale;
  final String quality;
  final String? identifier;

  const LocalTtsVoice({
    required this.name,
    required this.locale,
    required this.quality,
    this.identifier,
  });

  String get qualityLabel {
    switch (quality.toLowerCase()) {
      case 'premium':
        return 'Premium';
      case 'enhanced':
        return 'Enhanced';
      default:
        return 'Standard';
    }
  }

  Map<String, String> get platformArguments {
    final voice = <String, String>{'name': name, 'locale': locale};
    if (identifier case final value?) voice['identifier'] = value;
    return voice;
  }
}

LocalTtsVoice? selectBestLocalMandarinVoice(Iterable<dynamic> rawVoices) {
  final candidates = rawVoices
      .whereType<Map>()
      .map(_parseVoice)
      .whereType<_RankedLocalVoice>()
      .toList()
    ..sort((a, b) => b.score.compareTo(a.score));
  return candidates.isEmpty ? null : candidates.first.voice;
}

_RankedLocalVoice? _parseVoice(Map<dynamic, dynamic> raw) {
  final name = raw['name']?.toString();
  final locale = raw['locale']?.toString();
  if (name == null || name.isEmpty || locale == null || locale.isEmpty) {
    return null;
  }

  final normalizedLocale = locale.replaceAll('_', '-').toLowerCase();
  final isMainlandMandarin = normalizedLocale == 'zh-cn' ||
      normalizedLocale == 'cmn-cn' ||
      normalizedLocale.startsWith('zh-hans');
  if (!isMainlandMandarin || _isNetworkVoice(raw['network_required'])) {
    return null;
  }

  final quality = raw['quality']?.toString() ?? 'default';
  final qualityScore = _qualityScore(quality);
  final localeScore = normalizedLocale == 'zh-cn' ? 10000 : 9000;
  return _RankedLocalVoice(
    LocalTtsVoice(
      name: name,
      locale: locale,
      quality: quality,
      identifier: raw['identifier']?.toString(),
    ),
    localeScore + qualityScore,
  );
}

bool _isNetworkVoice(dynamic value) =>
    value == true || value?.toString().toLowerCase() == 'true';

int _qualityScore(String quality) {
  switch (quality.toLowerCase()) {
    case 'premium':
      return 3000;
    case 'enhanced':
      return 2000;
    case 'default':
      return 1000;
    default:
      return int.tryParse(quality) ?? 0;
  }
}

class _RankedLocalVoice {
  final LocalTtsVoice voice;
  final int score;

  const _RankedLocalVoice(this.voice, this.score);
}
