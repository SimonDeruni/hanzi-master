import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/media/domain/models/library_story.dart';
import 'package:hanzi_master/features/reading/data/services/localized_title_loader.dart';
import 'package:hanzi_master/features/reading/domain/entities/book_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Book and poetry title localization', () {
    test('bundled title assets load into locale maps by canonical ID',
        () async {
      final bookTitles = await loadLocalizedTitlesById('book_titles');
      final poemTitles = await loadLocalizedTitlesById('poetry');

      expect(bookTitles, hasLength(86));
      expect(poemTitles, hasLength(100));
      expect(
        bookTitles['journey_to_the_west'],
        containsPair('fr', "Voyage vers l'Ouest"),
      );
      expect(
        poemTitles.values.every(
          (titles) => localizedContentLanguageCodes.every(titles.containsKey),
        ),
        isTrue,
      );
    });

    test('every book has a nonblank title in every selectable language', () {
      final catalog = jsonDecode(
        File('assets/data/grand_library_catalog.json').readAsStringSync(),
      ) as List<dynamic>;
      final ids = catalog
          .map((entry) => (entry as Map<String, dynamic>)['id'] as String)
          .toSet();

      expect(ids, hasLength(86));
      for (final languageCode in localizedContentLanguageCodes) {
        final titles = jsonDecode(
          File('assets/data/l10n/book_titles_$languageCode.json')
              .readAsStringSync(),
        ) as Map<String, dynamic>;
        expect(titles.keys.toSet(), ids, reason: 'book titles: $languageCode');
        expect(
          titles.values
              .every((title) => title is String && title.trim().isNotEmpty),
          isTrue,
          reason: 'book titles: $languageCode',
        );
      }
    });

    test('every poem has a nonblank title in every selectable language', () {
      final poems = jsonDecode(
        File('assets/data/famous_chinese_poetry.json').readAsStringSync(),
      ) as List<dynamic>;
      final ids = poems
          .map((entry) => (entry as Map<String, dynamic>)['link'] as String)
          .toSet();

      expect(ids, hasLength(100));
      expect(
        poems.every((entry) {
          final title = (entry as Map<String, dynamic>)['title_en'];
          return title is String && title.trim().isNotEmpty;
        }),
        isTrue,
        reason: 'English poem titles come from the canonical poetry corpus',
      );
      for (final languageCode in localizedContentLanguageCodes) {
        final entries = jsonDecode(
          File('assets/data/l10n/poetry_$languageCode.json').readAsStringSync(),
        ) as Map<String, dynamic>;
        expect(entries.keys.toSet(), ids, reason: 'poem titles: $languageCode');
        expect(
          entries.values.every((entry) {
            final title = (entry as Map<String, dynamic>)['title'];
            return title is String && title.trim().isNotEmpty;
          }),
          isTrue,
          reason: 'poem titles: $languageCode',
        );
      }
    });

    test('models resolve regional, English, Chinese, and unknown locales', () {
      const titles = {'fr': 'Titre français', 'de': 'Deutscher Titel'};
      const story = LibraryStory(
        title: '中文标题',
        titleEn: 'English title',
        localizedTitles: titles,
        sourceName: 'Author',
        link: 'story',
        summary: 'Summary',
        category: 'Chinese Poetry',
        sourceType: StorySourceType.json,
      );
      const book = BookModel(
        id: 'book',
        title: '中文标题',
        titleEn: 'English title',
        localizedTitles: titles,
        author: '作者',
        authorEn: 'Author',
        category: 'Category',
        description: '简介',
        descriptionEn: 'Description',
        dynastyOrEra: 'Era',
        hskLevel: 1,
        totalChapters: 1,
        coverEmoji: '书',
        tags: [],
      );

      for (final resolver in [story.localizedTitle, book.localizedTitle]) {
        expect(resolver('fr-FR'), 'Titre français');
        expect(resolver('de'), 'Deutscher Titel');
        expect(resolver('en'), 'English title');
        expect(resolver('zh-CN'), '中文标题');
        expect(resolver('xx'), 'English title');
      }
    });
  });
}
