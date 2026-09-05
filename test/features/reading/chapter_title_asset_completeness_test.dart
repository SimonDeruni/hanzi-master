import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  const locales = <String>[
    'ar',
    'de',
    'en',
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
  final hanPattern = RegExp(r'[\u3400-\u9fff\uf900-\ufaff]');

  test('every chapter has a complete generated title in every app locale', () {
    final chapterIds = <String>{};
    for (final file in Directory('assets/data/books')
        .listSync()
        .whereType<File>()
        .where((file) => file.path.endsWith('.json'))) {
      final chapters = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      chapterIds.addAll(chapters
          .cast<Map<String, dynamic>>()
          .map((chapter) => chapter['id'] as String));
    }

    expect(chapterIds, hasLength(5356));
    for (final locale in locales) {
      final file = File(
        'assets/data/l10n/chapter_titles_by_id_$locale.json',
      );
      expect(file.existsSync(), isTrue, reason: 'Missing ${file.path}');
      final titles =
          (jsonDecode(file.readAsStringSync()) as Map<String, dynamic>)
              .map((key, value) => MapEntry(key, value.toString().trim()));
      expect(titles.keys.toSet(), chapterIds, reason: locale);
      for (final chapterId in chapterIds) {
        final title = titles[chapterId] ?? '';
        expect(title, isNotEmpty, reason: '$locale:$chapterId');
        if (locale != 'ja') {
          expect(hanPattern.hasMatch(title), isFalse,
              reason: '$locale:$chapterId retained Chinese: $title');
        }
      }
    }
  });
}
