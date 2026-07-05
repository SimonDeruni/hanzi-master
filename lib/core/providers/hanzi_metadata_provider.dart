import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hanzi_metadata_provider.g.dart';

/// Lightweight map from hanzi character → English definition.
/// Loaded from hanzi_metadata.json which covers all ~20k Chinese characters.
@Riverpod(keepAlive: true)
Future<Map<String, String>> hanziCharDefinitions(HanziCharDefinitionsRef ref) async {
  final raw = await rootBundle.loadString('assets/data/hanzi_metadata.json');
  final data = json.decode(raw) as Map<String, dynamic>;
  final result = <String, String>{};
  for (final entry in data.entries) {
    final def = (entry.value as Map<String, dynamic>)['definition'];
    if (def != null && (def as String).isNotEmpty) {
      result[entry.key] = def;
    }
  }
  return result;
}
