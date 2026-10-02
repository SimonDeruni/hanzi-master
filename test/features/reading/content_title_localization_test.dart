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

      // Canonical 101 books in Grand Library catalog. Kept exact: this guards
      // against accidental asset loss, which a floor would not catch.
      expect(bookTitles, hasLength(101));
      // Complete, and pinned as such: the chapter-title sweep has now visited
      // every locale (`tooling/translate_poetry_chapters.py`), so a poem added
      // without a translated title must fail here rather than ship a Chinese
      // title to a reader who chose Indonesian.
      final storeIds = (jsonDecode(
        File('assets/data/famous_chinese_poetry.json').readAsStringSync(),
      ) as List<dynamic>)
          .map((entry) => (entry as Map)['link'].toString())
          .toSet();
      expect(storeIds.length, greaterThanOrEqualTo(600));
      expect(poemTitles.keys.toSet(), storeIds);
      expect(
        bookTitles['journey_to_the_west'],
        containsPair('fr', "Voyage vers l'Ouest"),
      );
      // The curated poems were translated wholesale, so each of them must be
      // complete in every content locale. The poems that arrived with the
      // anthology expansion are filled in locale by locale
      // (`tooling/translate_poetry_chapters.py`), so a partial entry is expected
      // for those until that sweep has visited every locale.
      final curatedIds = (jsonDecode(
        File('assets/data/famous_chinese_poetry.json').readAsStringSync(),
      ) as List<dynamic>)
          .where((entry) =>
              ((entry as Map)['title_en'] ?? '').toString().trim().isNotEmpty)
          .map((entry) => (entry as Map)['link'].toString())
          .toSet();
      expect(curatedIds.length, greaterThanOrEqualTo(100));

      for (final poemId in curatedIds) {
        final titles = poemTitles[poemId];
        expect(titles, isNotNull, reason: 'no translation at all: $poemId');
        expect(
          localizedContentLanguageCodes.every(titles!.containsKey),
          isTrue,
          reason: 'curated poem $poemId is missing a content locale',
        );
      }
    });

    test('every book has a nonblank title in every selectable language', () {
      final catalog = jsonDecode(
        File('assets/data/grand_library_catalog.json').readAsStringSync(),
      ) as List<dynamic>;
      final ids = catalog
          .map((entry) => (entry as Map<String, dynamic>)['id'] as String)
          .toSet();

      expect(ids, hasLength(101));
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

    test('every translated poem is nonblank in every selectable language', () {
      final poems = jsonDecode(
        File('assets/data/famous_chinese_poetry.json').readAsStringSync(),
      ) as List<dynamic>;
      final ids = poems
          .map((entry) => (entry as Map<String, dynamic>)['link'] as String)
          .toSet();

      // The store now holds every poet's collection rather than 100 poems, so
      // this can no longer demand a title for all of them: a poem without a
      // generated title falls back to its Chinese one through `localizedValue`.
      expect(ids.length, greaterThanOrEqualTo(600),
          reason: 'the anthology expansion should have grown the store');

      for (final languageCode in localizedContentLanguageCodes) {
        final entries = jsonDecode(
          File('assets/data/l10n/poetry_$languageCode.json').readAsStringSync(),
        ) as Map<String, dynamic>;

        // Complete and pinned: every poem is titled in every content locale, so
        // a new poem must arrive with its translations rather than silently
        // reading as Chinese in 13 languages.
        expect(entries.keys.toSet(), ids,
            reason: 'poem title coverage fell: $languageCode');
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

    test('no translated poem title is left in Chinese', () {
      // A completeness check cannot see this: `谢朓楼` as a German title is
      // non-blank, sits in the right file, and passes every other assertion,
      // while the reader sees Chinese in the middle of their own language. The
      // first sweep shipped 130 of these (proper nouns and 词 tune names the
      // model left alone, plus three Thai titles that were entirely Chinese), so
      // the check is measured rather than assumed.
      // Japanese is excluded on purpose: kanji *is* Japanese.
      final hanPattern = RegExp(r'[\u3400-\u9fff\uf900-\ufaff]');
      for (final languageCode in localizedContentLanguageCodes) {
        if (languageCode == 'ja') continue;
        final entries = jsonDecode(
          File('assets/data/l10n/poetry_$languageCode.json').readAsStringSync(),
        ) as Map<String, dynamic>;

        final leaked = <String, String>{};
        entries.forEach((id, entry) {
          final title = ((entry as Map<String, dynamic>)['title'] ?? '')
              .toString()
              .trim();
          if (hanPattern.hasMatch(title)) leaked[id] = title;
        });

        expect(leaked, isEmpty,
            reason: '$languageCode has titles still in Chinese');
      }
    });

    test('every poem has an English title for the base locale', () {
      final poems = jsonDecode(
        File('assets/data/famous_chinese_poetry.json').readAsStringSync(),
      ) as List<dynamic>;

      // English is the app's base locale rather than one of the 13 content
      // locales, so there is no `l10n/poetry_en.json` and there is not meant to
      // be one: a chapter's English title comes from the store's own `title_en`.
      // That makes a blank value worse than a missing one, because
      // `poem['title_en'] ?? 'Poem'` cannot catch `""` and the chapter renders
      // with no title at all. `tooling/build_poem_titles_en.py` fills these.
      final hanPattern = RegExp(r'[\u3400-\u9fff\uf900-\ufaff]');
      final untitled = <String>[];
      final untranslated = <String>[];
      for (final entry in poems) {
        final poem = entry as Map<String, dynamic>;
        final title = (poem['title_en'] as String? ?? '').trim();
        if (title.isEmpty) untitled.add(poem['title'].toString());
        if (hanPattern.hasMatch(title)) untranslated.add(poem['title'].toString());
      }

      expect(poems.length, greaterThanOrEqualTo(600));
      expect(untitled, isEmpty,
          reason: 'these would show a blank chapter title in English');
      expect(untranslated, isEmpty,
          reason: 'an English title still holds Chinese characters');
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
