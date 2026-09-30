import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/reading/data/repositories/book_repository.dart';
import 'package:hanzi_master/features/reading/data/services/localized_title_loader.dart';
import 'package:hanzi_master/features/reading/domain/entities/poetry_collection.dart';
import 'package:hanzi_master/features/reading/domain/entities/poetry_story_id.dart';

/// Guards the "one book = one poet's collection" shape.
///
/// A single poem averages ~85 characters, so one poem per book opened the whole
/// reader — table of contents, chapter counter, progress — for four lines of
/// verse. Collections are built by grouping the shipped `poetry` store by its
/// raw `sourceName`; the invariants below are what stop that regrouping from
/// silently losing or duplicating a poem.
void main() {
  // `rootBundle` (used by the repository group below) needs the binding even
  // outside `testWidgets`.
  TestWidgetsFlutterBinding.ensureInitialized();

  late List<Map<String, dynamic>> poems;

  setUpAll(() {
    poems =
        (jsonDecode(File(chinesePoetryAsset).readAsStringSync()) as List<dynamic>)
            .map((entry) => Map<String, dynamic>.from(entry as Map))
            .toList();
  });

  group('poetryAuthorBookId', () {
    test('is deterministic, prefixed and hex-shaped', () {
      final a = poetryAuthorBookId('李白');
      expect(a, poetryAuthorBookId('李白'), reason: 'must be stable');
      expect(a, startsWith(poetryAuthorBookPrefix));
      expect(RegExp(r'^poetry_author_[0-9a-f]{8}$').hasMatch(a), isTrue,
          reason: 'shaped like the existing poetry_<dynasty>_<hex> ids');
      expect(isPoetryAuthorBookId(a), isTrue);
      expect(isPoetryAuthorBookId('poetry_tang_fef789b0'), isFalse);
    });

    test('gives every poet a different book', () {
      final ids = <String>{
        for (final poet in const ['李白', '杜甫', '苏轼', '王维', '佚名'])
          poetryAuthorBookId(poet),
      };
      expect(ids.length, 5);
    });
  });

  group('buildPoetryCollections over the shipped store', () {
    test('loses no poem and duplicates none', () {
      final collections = buildPoetryCollections(poems);
      final regrouped = collections.expand((c) => c.poemIds).toList();

      expect(regrouped.length, poems.length,
          reason: 'every poem must land in exactly one collection');
      expect(regrouped.toSet().length, poems.length,
          reason: 'no poem may appear in two collections');
    });

    test('groups strictly by the raw author name', () {
      final collections = buildPoetryCollections(poems);
      final byAuthor = <String, int>{
        for (final c in collections) c.author: c.poemCount,
      };

      // One collection per poet, and not a poem unaccounted for. Counted from
      // the store rather than hard-coded so the expansion can grow the
      // collections without rewriting this test.
      final expected = <String, int>{};
      for (final poem in poems) {
        final author = (poem['sourceName'] ?? '').toString().trim();
        expected[author] = (expected[author] ?? 0) + 1;
      }
      expect(byAuthor, expected);
      expect(collections.length, expected.length);
    });

    test('collections are substantial, not re-labelled single poems', () {
      // This is the whole point of the regroup, and the reason the store was
      // expanded twice - first from 100 poems to 672, then to 4,237 poems across
      // 100 poets: a book is a poet's *collection*, so the number of poets
      // holding fewer than three poems is a ratchet that may only fall. It sat
      // at 24 of 37 before the first expansion, and at 1 of 100 after the second.
      final collections = buildPoetryCollections(poems);
      final thin = collections.where((c) => c.poemCount < 3).length;

      expect(collections.length, greaterThanOrEqualTo(100),
          reason: 'the shelf is meant to hold a collection per poet');
      expect(thin, lessThanOrEqualTo(5),
          reason: 'a regression here means the anthology expansion was lost or '
              'a source stopped being read');
      expect(collections.first.poemCount, greaterThanOrEqualTo(20),
          reason: 'the biggest collection should be a real book');
    });

    test('orders collections biggest-first and keeps poems in curated order',
        () {
      final collections = buildPoetryCollections(poems);

      for (var i = 1; i < collections.length; i++) {
        expect(collections[i - 1].poemCount >= collections[i].poemCount, isTrue,
            reason: 'collections are ordered by size');
      }

      // Chapter 1 of a collection is that author's first poem in the store, so
      // the best-known poem stays chapter 1.
      final first = collections.first;
      expect(first.poemIds.first, poetryEntryId(first.poems.first));
      expect(first.chapterIndexOf(first.poemIds.first), 1);
    });

    test('every poem resolves back to its own collection', () {
      final collections = buildPoetryCollections(poems);
      final owner = <String, String>{};
      for (final c in collections) {
        for (final id in c.poemIds) {
          owner[id] = c.id;
        }
      }

      for (final entry in poems) {
        final poemId = poetryEntryId(entry);
        final found = collectionForPoem(collections, poemId);
        expect(found, isNotNull, reason: '$poemId is unowned');
        expect(found!.id, owner[poemId]);
        expect(found.author, (entry['sourceName'] ?? '').toString().trim());
      }
    });

    test('an author book id is stable across a regroup', () {
      final a = buildPoetryCollections(poems);
      final b = buildPoetryCollections(poems.reversed.toList());

      expect(a.map((c) => c.id).toSet(), b.map((c) => c.id).toSet(),
          reason: 'book ids feed persisted progress: order must not matter');
    });
  });

  group('edge cases', () {
    Map<String, dynamic> poem(String author, String title, int hsk) =>
        <String, dynamic>{
          'id': 'poetry_tang_${title.hashCode.toRadixString(16)}',
          'title': title,
          'sourceName': author,
          'dynasty': 'Tang',
          'hskLevel': hsk,
        };

    test('an empty author name is bucketed, never dropped', () {
      final collections = buildPoetryCollections([
        poem('', 'Anonymous verse', 2),
        poem('李白', '静夜思', 3),
      ]);

      final bucket =
          collections.firstWhere((c) => c.author == poetryUnknownAuthor);
      expect(bucket.poemCount, 1);
      expect(collections.length, 2);
    });

    test('hskLevel is the median of the positive levels', () {
      final collections = buildPoetryCollections([
        poem('杜甫', 'A', 1),
        poem('杜甫', 'B', 3),
        poem('杜甫', 'C', 5),
      ]);

      expect(collections.single.hskLevel, 3);
    });

    test('a collection with no graded poem reads as level 0', () {
      final collections = buildPoetryCollections([
        poem('杜牧', 'A', 0),
        poem('杜牧', 'B', 0),
      ]);

      expect(collections.single.hskLevel, 0);
    });

    test('chapterIndexOf is 1-based and null for a stranger', () {
      final collections = buildPoetryCollections([
        poem('王维', 'A', 2),
        poem('王维', 'B', 2),
      ]);
      final collection = collections.single;

      expect(collection.chapterIndexOf(collection.poemIds[1]), 2);
      expect(collection.chapterIndexOf('poetry_tang_nope'), isNull);
      expect(collectionForPoem(collections, 'poetry_tang_nope'), isNull);
    });

    test('an empty store builds nothing rather than throwing', () {
      expect(buildPoetryCollections(const []), isEmpty);
    });
  });

  group('poetryCollectionToBook', () {
    test('names the book after the poet and counts poems as chapters', () {
      final collections = buildPoetryCollections(poems);
      final collection = collections.first;
      final book = poetryCollectionToBook(collection);

      expect(book.id, collection.id);
      expect(book.title, collection.author);
      expect(book.author, collection.author);
      expect(book.titleEn, isNotEmpty);
      expect(book.totalChapters, collection.poemCount,
          reason: 'the poem count is what the catalog card renders as chapters');
      expect(book.hskLevel, collection.hskLevel);
      expect(book.category, 'Chinese Poetry');
      expect(book.dynastyOrEra, collection.dynasty);
    });

    test('the id is one the cover and the reader both recognise', () {
      final book = poetryCollectionToBook(buildPoetryCollections(poems).first);

      expect(isPoetryAuthorBookId(book.id), isTrue);
      // `isPoetryStoryId` is the check the reader and the bookmark loader use,
      // so an author book has to pass it as well as its own predicate.
      expect(isPoetryStoryId(book.id), isTrue);
    });

    test('needs no translation: the title is the poet, a proper noun', () {
      final collections = buildPoetryCollections(poems);
      final collection = collections.firstWhere((c) => c.author == '李白');
      final book = poetryCollectionToBook(collection);

      // Chinese readers get the Chinese name, everyone else the same Latin
      // transliteration - so a collection needs no ARB key and no 13-file sweep.
      expect(book.localizedTitle('zh'), '李白');
      for (final locale in const ['fr', 'de', 'ar', 'th', 'vi']) {
        expect(book.localizedTitle(locale), book.titleEn, reason: locale);
      }
    });

    test('caps the synopsis preview so a big collection stays readable', () {
      final collections = buildPoetryCollections([
        for (var i = 0; i < 10; i++)
          <String, dynamic>{
            'id': 'poetry_tang_$i',
            'title': '诗$i',
            'title_en': 'Poem $i',
            'sourceName': '杜甫',
            'dynasty': 'Tang',
            'hskLevel': 3,
          },
      ]);
      final book = poetryCollectionToBook(collections.single);

      expect(book.description.split(' · ').length, 6);
      expect(book.description, endsWith('…'));
      expect(book.totalChapters, 10);
    });

    test('a small collection lists every title without an ellipsis', () {
      final collections = buildPoetryCollections([
        <String, dynamic>{
          'id': 'poetry_tang_a',
          'title': '静夜思',
          'title_en': 'Quiet Night Thoughts',
          'sourceName': '李白',
          'dynasty': 'Tang',
          'hskLevel': 3,
        },
        <String, dynamic>{
          'id': 'poetry_tang_b',
          'title': '望庐山瀑布',
          'title_en': 'Waterfall at Mount Lu',
          'sourceName': '李白',
          'dynasty': 'Tang',
          'hskLevel': 4,
        },
      ]);
      final book = poetryCollectionToBook(collections.single);

      expect(book.description, '静夜思 · 望庐山瀑布');
      expect(book.descriptionEn, 'Quiet Night Thoughts · Waterfall at Mount Lu');
      expect(book.totalChapters, 2);
    });
  });

  group('the poetry shelves are wired to collections', () {
    // Source guards, the same idiom the parity suites use. The wiring is a
    // one-line provider swap that a later refactor could quietly revert, and no
    // unit test above would notice — the grouping would stay perfect while the
    // app went back to one book per poem.
    String source(String path) => File(path).readAsStringSync();

    test('the catalog renders collections, not one book per poem', () {
      final catalog = source(
        'lib/features/reading/presentation/screens/book_catalog_screen.dart',
      );

      expect(catalog, contains('poetryCollectionsProvider'));
      expect(catalog, isNot(contains('chinesePoetryProvider')),
          reason: 'the per-poem list must not drive the poetry shelf');
      expect(catalog, isNot(contains('_poemToBook')),
          reason: 'a poem is no longer its own book');
    });

    test('the story library opens the poet that owns the tapped poem', () {
      final library = source(
        'lib/features/media/presentation/screens/story_library_screen.dart',
      );

      expect(library, contains('collectionForPoem('));
      expect(library, contains('poetryCollectionToBook('));
    });

    test('the story library lists poets, not 100 poem cards', () {
      final library = source(
        'lib/features/media/presentation/screens/story_library_screen.dart',
      );

      expect(library, contains('_collectionStory('),
          reason: 'a collection needs a card of its own');
      expect(library, contains('buildPoetryCollections(poetryEntries)'),
          reason: 'the list is grouped from the store');
      expect(library, contains('!isPoetryStoryId(s.link)'),
          reason: 'the per-poem cards it replaces must be removed, not left '
              'beside the collections');
    });

    test('micro-reads no longer doubles as a poetry shelf', () {
      final providers = source(
        'lib/features/reading/presentation/providers/book_providers.dart',
      );

      // Micro-reads used to exclude only Tang Poetry and Classical Literature,
      // so all 100 poems appeared there as well as in the poetry tier.
      expect(providers, contains('!isPoetryCategory(s.category)'));
      expect(providers, isNot(contains("s.category != 'Tang Poetry'")));
    });

    test('the bookmarks shelf knows the author books it migrated to', () {
      final providers = source(
        'lib/features/reading/presentation/providers/book_providers.dart',
      );

      // `init()` re-points stored bookmarks at author books; without these keys
      // the shelf would filter every migrated poetry bookmark away.
      expect(providers, contains('poetryCollectionsProvider'));
      expect(providers, contains('poetryCollectionToBook('));
    });
  });

  group('poet biographies', () {
    test('a collection carries the biography in the reader\'s language', () {
      final collections = buildPoetryCollections(
        poems,
        summaries: const {'李白': '李白是盛唐时期浪漫主义诗人。'},
        localizedSummaries: const {
          '李白': {
            'fr': 'Li Bai, poète romantique des Tang.',
            'en': 'Li Bai, a romantic poet of the Tang.',
          },
        },
      );
      final poet = collections.firstWhere((c) => c.author == '李白');

      expect(poet.summary, contains('盛唐'));
      expect(poet.localizedSummary('zh'), contains('盛唐'),
          reason: 'Chinese readers get the original');
      expect(poet.localizedSummary('fr'), 'Li Bai, poète romantique des Tang.');
      expect(poet.localizedSummary('fr-FR'),
          'Li Bai, poète romantique des Tang.',
          reason: 'a regional locale falls back to its language');
      expect(poet.summaryEn, 'Li Bai, a romantic poet of the Tang.');
    });

    test('a missing translation falls back to the Chinese biography', () {
      final collections = buildPoetryCollections(
        poems,
        summaries: const {'杜甫': '杜甫是唐代诗人。'},
      );
      final poet = collections.firstWhere((c) => c.author == '杜甫');

      expect(poet.localizedSummary('th'), '杜甫是唐代诗人。',
          reason: 'better the real biography in Chinese than none');
    });

    test('the book describes the poet, and falls back to the titles', () {
      final withBio = buildPoetryCollections(
        poems,
        summaries: const {'李白': '李白是盛唐诗人。'},
        localizedSummaries: const {
          '李白': {'en': 'Li Bai, a Tang poet.'},
        },
      );
      final book = poetryCollectionToBook(
        withBio.firstWhere((c) => c.author == '李白'),
        localeCode: 'zh',
      );
      expect(book.description, '李白是盛唐诗人。');
      expect(book.descriptionEn, 'Li Bai, a Tang poet.');

      final fallback = poetryCollectionToBook(
        buildPoetryCollections(poems).first,
        localeCode: 'zh',
      );
      expect(fallback.description, contains('·'),
          reason: 'with no biography the poem titles still describe the book');
    });

    test('a collective name is described as a collection, not a person', () {
      final bios = jsonDecode(
        File('assets/data/poet_bios.json').readAsStringSync(),
      ) as Map<String, dynamic>;

      // 佚名 means "anonymous". The collection gathers anonymous poems from
      // several anthologies, so it must not carry one "anonymous poet"'s
      // biography: an earlier pass condensed a single author-index entry and
      // claimed 月泉吟社 collected all fifty poems, when only some came from there.
      final anonymous = bios['佚名'] as Map<String, dynamic>;
      expect(anonymous['origin'], 'collective');
      expect(anonymous['summary'] as String, isNot(contains('月泉吟社')),
          reason: 'that society collected only some of the fifty poems');
      expect(anonymous['summary'] as String, contains('诗经'),
          reason: 'it should name the anthologies the collection draws from');
    });

    test('every published poet has exactly one biography on disk', () {
      final bios = jsonDecode(
        File('assets/data/poet_bios.json').readAsStringSync(),
      ) as Map<String, dynamic>;
      final authors = poems
          .map((poem) => (poem['sourceName'] ?? '').toString().trim())
          .toSet();

      // Every poet needs one, or their book falls back to a title list; and no
      // biography may belong to a poet the store does not publish.
      expect(bios.keys.toSet(), authors);
      for (final entry in bios.entries) {
        final value = entry.value as Map<String, dynamic>;
        expect((value['summary'] as String).trim(), isNotEmpty,
            reason: entry.key);
        // Provenance is recorded so a data-derived line is never passed off as
        // a corpus biography.
        expect(value['origin'], isNotNull, reason: entry.key);
        expect(value['source'], isNotNull, reason: entry.key);
      }
    });

    test('every biography is translated into every shipped locale', () {
      final bios = jsonDecode(
        File('assets/data/poet_bios.json').readAsStringSync(),
      ) as Map<String, dynamic>;

      // The 13 selectable content locales plus English, which is the base locale
      // and therefore not one of them.
      for (final code in [...localizedContentLanguageCodes, 'en']) {
        final file = File('assets/data/l10n/poet_bios_$code.json');
        expect(file.existsSync(), isTrue, reason: 'poet_bios_$code.json');
        final values = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
        expect(values.keys.toSet().difference(bios.keys.toSet()), isEmpty,
            reason: '$code translates a poet the store does not publish');
        for (final poet in bios.keys) {
          expect((values[poet] as String?)?.trim() ?? '', isNotEmpty,
              reason: '$code / $poet');
        }
      }
    });
  });

  group('the reader side', () {
    // Plain `test`, not `testWidgets`: the repository reads its store through
    // `rootBundle`, and `testWidgets` runs in a FakeAsync zone where a real I/O
    // future never completes — the test would hang rather than fail.
    test('an author book resolves one chapter per poem', () async {
      // Loaded through `rootBundle`, the same call the reader makes, so this
      // proves the store the app actually ships resolves into chapters.
      final repo = BookRepository();
      final collectionId = poetryAuthorBookId('李白');
      final chapters = await repo.getBookChapters(collectionId);

      expect(chapters.length, greaterThanOrEqualTo(20),
          reason: '李白 should be a real collection, not a one-poem book');
      expect(
        chapters.map((chapter) => chapter.chapterIndex).toList(),
        List<int>.generate(chapters.length, (index) => index + 1),
        reason: 'chapter numbers run 1..N with no gaps: the reader, the progress '
            'record and the bookmark migration all index on them',
      );
      expect(chapters.every((chapter) => chapter.bookId == collectionId), isTrue);
      // The chapter id *is* the poem id, which is what lets a migrated bookmark
      // be traced back to the verse it marks.
      expect(chapters.first.id, startsWith('poetry_'));
      expect(chapters.every((chapter) => chapter.sentences.isNotEmpty), isTrue,
          reason: 'every chapter must carry verse');
      expect(chapters.every((chapter) => chapter.title.trim().isNotEmpty), isTrue,
          reason: 'a chapter with no generated title falls back to its Chinese '
              'one rather than showing nothing');
    });

    test('a bare poem is still readable as a single chapter', () async {
      final repo = BookRepository();
      final chapters = await repo.getBookChapters('poetry_tang_fef789b0');

      expect(chapters, hasLength(1));
      expect(chapters.single.chapterIndex, 1);
    });
  });

  group('collection summaries', () {
    // What describes a collection on the shelf and inside its book: what is
    // gathered in these poems and what reading them together gives. The poet's
    // biography is a separate text for the author card, and until the collection
    // summary existed the card had nothing to show but a list of poem titles.
    late Map<String, dynamic> collections;
    late Map<String, dynamic> biographies;

    setUpAll(() {
      collections = jsonDecode(
        File(poetryCollectionsAsset).readAsStringSync(),
      ) as Map<String, dynamic>;
      biographies = jsonDecode(
        File(poetBiosAsset).readAsStringSync(),
      ) as Map<String, dynamic>;
    });

    test('every published poet has one collection summary on disk', () {
      final authors = poems
          .map((poem) => (poem['sourceName'] ?? '').toString().trim())
          .toSet();

      expect(collections.keys.toSet(), authors,
          reason: 'a missing summary puts the poem titles back on the card');
      for (final entry in collections.entries) {
        final value = entry.value as Map<String, dynamic>;
        expect((value['summary'] as String).trim().length, greaterThan(20),
            reason: '${entry.key} needs a real sentence');
        expect((value['summary_en'] as String).trim(), isNotEmpty,
            reason: entry.key);
        // Provenance, as with the biographies: a model-written summary must not
        // pass for a sourced one.
        expect(value['origin'], isNotNull, reason: entry.key);
        expect(value['source'], isNotNull, reason: entry.key);
      }
    });

    test('the summary describes the collection, not the poet', () {
      for (final author in collections.keys) {
        final summary = (collections[author]['summary'] as String).trim();
        final biography = (biographies[author]['summary'] as String).trim();
        expect(summary, isNot(biography),
            reason: '$author: the card would repeat the author card');
      }
    });

    test('every collection summary is translated into every shipped locale',
        () {
      for (final code in [...localizedContentLanguageCodes, 'en']) {
        final file = File('assets/data/l10n/poetry_collections_$code.json');
        expect(file.existsSync(), isTrue,
            reason: 'poetry_collections_$code.json');
        final values =
            jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
        expect(values.keys.toSet().difference(collections.keys.toSet()), isEmpty,
            reason: '$code translates a poet the store does not publish');
        for (final author in collections.keys) {
          expect((values[author] as String?)?.trim() ?? '', isNotEmpty,
              reason: '$code / $author');
        }
      }
    });

    test('the repository prefers the summary and keeps the bio as fallback',
        () {
      final repository = File(
        'lib/features/reading/data/repositories/book_repository.dart',
      ).readAsStringSync();

      expect(repository, contains('poetryCollectionsAsset'));
      expect(repository, contains('poetryCollectionsEnAsset'));
      expect(repository, contains('...biographies.\$1,'),
          reason: 'the biography still describes a poet with no summary');
      expect(repository, contains('...collections.\$1,'),
          reason: 'the collection summary must win when it exists');
    });

    test('the shelf card can no longer rebuild collections without them', () {
      final library = File(
        'lib/features/media/presentation/screens/story_library_screen.dart',
      ).readAsStringSync();

      expect(library, contains('poetryCollectionsProvider'));
      expect(library, contains('.localizedSummary('),
          reason: 'the card previews the collection summary');
    });
  });
}




