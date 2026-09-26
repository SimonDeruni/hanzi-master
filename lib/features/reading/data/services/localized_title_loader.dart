import 'dart:convert';

import 'package:flutter/services.dart';

const localizedContentLanguageCodes = <String>[
  'ar',
  'de',
  'es',
  'fr',
  'hi',
  'id',
  'it',
  'ja',
  'ko',
  'pt',
  'ru',
  'th',
  'vi',
];

Future<Map<String, Map<String, String>>> loadLocalizedTitlesById(
  String assetPrefix, {
  String field = 'title',
}) async {
  final titlesById = <String, Map<String, String>>{};
  await Future.wait(localizedContentLanguageCodes.map((languageCode) async {
    final jsonString = await rootBundle.loadString(
      'assets/data/l10n/${assetPrefix}_$languageCode.json',
    );
    final values = jsonDecode(jsonString) as Map<String, dynamic>;
    for (final entry in values.entries) {
      final value = entry.value;
      final title =
          value is Map ? value[field]?.toString() : value.toString();
      if (title != null && title.trim().isNotEmpty) {
        titlesById.putIfAbsent(entry.key, () => {})[languageCode] = title;
      }
    }
  }));
  return titlesById;
}
