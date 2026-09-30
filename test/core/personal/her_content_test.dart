/// Her account's content: the word of the day, the book, the shadowing sentences and
/// the deck — four surfaces, one gate, one content file.
///
/// What is being pinned is the *content* (the word is 汉堡包 on every date, the book is
/// titled exactly `READ THIS :` and is readable before anything is downloaded, every
/// shadowing sentence is a love sentence addressed to her, the deck is `Love` with the
/// six words in the order asked for) and the *gate* (outside her account every one of
/// those surfaces is what it was before — the ordinary rotation word, an untouched
/// catalogue, the ordinary deck library).
///
/// The world is real where it matters: a real Hive box, so the deck seeding is exercised
/// as it runs, and the real `rootBundle`, so the bundled chapter file is validated the
/// way the reader validates it.
library;

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hanzi_master/core/hive_adapter_registry.dart';
import 'package:hanzi_master/core/personal/her_account.dart';
import 'package:hanzi_master/core/personal/her_content.dart';
import 'package:hanzi_master/core/personal/widgets/her_deck_library.dart';
import 'package:hanzi_master/core/presentation/widgets/zen_search_bar.dart';
import 'package:hanzi_master/core/providers.dart';
import 'package:hanzi_master/core/services/widget_service.dart';
import 'package:hanzi_master/features/auth/presentation/providers/auth_controller.dart';
import 'package:hanzi_master/features/course/presentation/screens/tome_manager_screen.dart';
import 'package:hanzi_master/features/flashcards/data/models/deck_model.dart';
import 'package:hanzi_master/features/flashcards/data/models/flashcard_model.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/domain/repositories/deck_repository.dart';
import 'package:hanzi_master/features/flashcards/domain/repositories/flashcard_repository.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/settings_controller.dart';
import 'package:hanzi_master/features/media/data/birthday_playlist.dart';
import 'package:hanzi_master/features/progression/presentation/widgets/today_insight_card.dart';
import 'package:hanzi_master/features/reading/data/services/book_download_service.dart';
import 'package:hanzi_master/features/reading/domain/entities/book_model.dart';
import 'package:hanzi_master/features/reading/domain/logic/sentence_script.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The signed-in account, without Firebase.
class _FakeUser extends Fake implements User {
  _FakeUser(this.email);

  @override
  final String? email;
}

/// The widget tests below are about *who sees what*, not about storage.
///
/// They use fakes rather than the real boxes on purpose: a Hive write started inside a
/// widget test's fake clock never completes, so the test **hangs** in teardown instead
/// of failing. The seeding itself is covered by the real-Hive test above, which runs
/// outside the fake clock.
class _FakeFlashcardBox extends Fake implements Box<FlashcardModel> {
  @override
  bool containsKey(dynamic key) => false;

  @override
  Future<void> putAll(Map<dynamic, FlashcardModel> entries) async {}
}

class _FakeFlashcardRepository extends Fake implements FlashcardRepository {
  @override
  Future<Either<String, List<Flashcard>>> getFlashcards() async =>
      const Right(<Flashcard>[]);
}

class _FakeDeckRepository extends Fake implements DeckRepository {
  @override
  Future<Either<String, List<Deck>>> getDecks() async =>
      const Right(<Deck>[]);

  @override
  Future<Either<String, Deck>> ensureThematicDeckExists(
    String id, {
    required String name,
    required String description,
  }) async =>
      Right(Deck(
        id: id,
        name: name,
        description: description,
        createdAt: DateTime.now(),
      ));
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory temporaryDirectory;
  late SharedPreferences prefs;

  setUp(() async {
    temporaryDirectory = await Directory.systemTemp.createTemp('her-content-');
    Hive.init(temporaryDirectory.path);
    registerHiveAdapters();
    await Hive.openBox<FlashcardModel>('flashcards');
    await Hive.openBox<DeckModel>('decks');
    SharedPreferences.setMockInitialValues(<String, Object>{});
    prefs = await SharedPreferences.getInstance();
  });

  tearDown(() async {
    await Hive.close();
    await temporaryDirectory.delete(recursive: true);
  });

  group('the gate', () {
    test('is her address, and only her address', () {
      expect(HerAccount.isHer('hanbaobao@love.com'), isTrue);
      expect(HerAccount.isHer('  HANBAOBAO@Love.COM  '), isTrue);
      for (final String other in <String>[
        'hanbaobao@love.com.evil.example',
        'hanbaobao@love.co',
        'hanbaobao@love.comm',
        'xhanbaobao@love.com',
        'hanbaobao+1@love.com',
        'someone@love.com',
        'someone@example.com',
        '',
        '   ',
      ]) {
        expect(HerAccount.isHer(other), isFalse, reason: other);
      }
      expect(HerAccount.isHer(null), isFalse);
    });

    test('the birthday shelf and the rest of her content agree who she is', () {
      expect(BirthdayPlaylist.recipientEmail, HerAccount.email);
      expect(BirthdayPlaylist.isFor(HerAccount.email), isTrue);
      expect(BirthdayPlaylist.isFor('nobody@example.com'), isFalse);
    });
  });

  group('the word of the day', () {
    test('is hanbaobao on every date, not a rotation', () {
      for (final DateTime date in <DateTime>[
        DateTime(2026, 1, 1),
        DateTime(2026, 9, 29),
        DateTime(2030, 12, 31),
      ]) {
        final WordOfTheDay word = HerContent.wordOfTheDayForAccount(
          email: HerAccount.email,
          date: date,
        );
        expect(word.hanzi, '汉堡包', reason: '$date');
        expect(word.pinyin, 'hàn bǎo bāo');
        expect(word.definition, contains('hanbaobao'));
      }
    });

    test('everybody else still gets the shared rotation', () {
      final DateTime date = DateTime(2026, 9, 29);
      final WordOfTheDay theirs = HerContent.wordOfTheDayForAccount(
        email: 'someone@example.com',
        date: date,
      );
      expect(theirs.hanzi, wordOfTheDayFor(date).hanzi);
      expect(theirs.hanzi, isNot('汉堡包'));
      // And her word can never arrive by accident on a later date: it is not in the
      // pool the rotation draws from.
      expect(
        wordOfTheDayVocabulary.map((WordOfTheDay w) => w.hanzi),
        isNot(contains('汉堡包')),
      );
    });

    test('signed out is not her', () {
      final DateTime date = DateTime(2026, 9, 29);
      expect(
        HerContent.wordOfTheDayForAccount(email: null, date: date).hanzi,
        wordOfTheDayFor(date).hanzi,
      );
    });
  });

  group('the book', () {
    BookModel otherBook() => const BookModel(
          id: 'dao_de_jing',
          title: '道德经',
          titleEn: 'Tao Te Ching',
          author: '老子',
          authorEn: 'Laozi',
          category: 'Ancient Philosophy',
          description: '',
          descriptionEn: '',
          dynastyOrEra: '',
          hskLevel: 1,
          totalChapters: 1,
          coverEmoji: '📖',
          tags: <String>[],
        );

    test('leads her shelf, and leaves everyone else\'s catalogue alone', () {
      final List<BookModel> catalog = <BookModel>[otherBook()];

      final List<BookModel> hers = HerContent.withBookFor(
        email: HerAccount.email,
        catalog: catalog,
      );
      expect(hers, hasLength(2));
      expect(hers.first.id, HerContent.bookId);
      expect(hers.first.title, 'READ THIS :');
      expect(hers.first.titleEn, 'READ THIS :');

      // Idempotent: a catalogue that already carries it does not gain a second copy.
      expect(
        HerContent.withBookFor(email: HerAccount.email, catalog: hers),
        hasLength(2),
      );

      // Not her: the very same list, so nothing downstream can observe a change.
      expect(
        identical(
          HerContent.withBookFor(email: 'someone@example.com', catalog: catalog),
          catalog,
        ),
        isTrue,
      );
      expect(
        HerContent.withBookFor(email: null, catalog: catalog),
        hasLength(1),
      );
    });

    // The letter, line for line, exactly as it was written: its typos (`didnt`), its
    // `hahhaha` / `ahhaha` / `ahahh`, the curly apostrophes, and the three places the
    // original's line breaks were flattened by the paste (`Dear BaoBao,` / `...birthday.`
    // / `...love you !!!`). The account's book is this text and nothing else.
    const List<String> letterLines = <String>[
      'Dear BaoBao,',
      'I’m writing this text first because I want to wish you a very nice birthday, even though you’ll spend it most of the times studying.',
      'First I’m sorry I couldn’t be there on your birthday, we will celebrate it this winter !!!',
      'I really wanted to write something from my hearts, to tell you that I love you.',
      'I’m so happy to have met you and even though this GIGA programme thing was boring, it was definitely worth it.',
      'We have already talked about it but when I met you I really thought you didnt like me hahhaha',
      'and so I was surprised you gave me your phone number and that you started to tell me good morning and good evening every day on whatsapp.',
      'And as more and more messages were sent, I realized I was more and more interested and in love with you.',
      'That’s why I was very anxious when I went to Heidelberg to see you ahhaha,',
      'I was afraid of doing something that would make you not like me.',
      'Then during my time at Heidelberg we visited so many cities together and did many other things ahahh',
      'and I really enjoyed it.',
      'Actually, at this time I’m writing this I don’t even know whether you’ll be able to even read this text on the day of your birthday.',
      'Anyway, I really wish you a nice birthday and remember that I love you !!!',
      'With all my love,',
      'Simon',
    ];

    Future<BookChapter> chapter() async {
      final List<BookChapter> chapters =
          BookDownloadService.decodeAndValidateForTest(
        await rootBundle.loadString(HerContent.bookAsset),
        HerContent.bookId,
      );
      expect(chapters, isNotEmpty);
      expect(chapters.first.bookId, HerContent.bookId);
      return chapters.first;
    }

    test('the chapter file is the letter, word for word', () async {
      final BookChapter read = await chapter();

      expect(
        read.sentences.map((BookSentence s) => s.chinese).toList(),
        letterLines,
        reason: 'the book is the letter as written — not a version of it',
      );
      expect(read.titleEn, 'Dear BaoBao');
    });

    test('nothing was invented around the letter', () async {
      final BookChapter read = await chapter();

      for (final BookSentence sentence in read.sentences) {
        // No pinyin for English, and no translation: the line *is* the text, so the
        // reader prints it and never translates it (see `sentenceHasHanzi`).
        expect(sentenceHasHanzi(sentence.chinese), isFalse,
            reason: sentence.chinese);
        expect(sentence.pinyin, isEmpty, reason: sentence.chinese);
        expect(sentence.english, isEmpty, reason: sentence.chinese);
        expect(sentence.chinese.trim(), isNotEmpty);
      }
    });

    test('is bundled, so it opens before anything is ever downloaded', () async {
      expect(BookDownloadService.isBundled(HerContent.bookId), isTrue);
      expect(BookDownloadService.isBundled('dao_de_jing'), isFalse);
      // No file on disk and no path lookup: a bundled book answers before both.
      expect(await BookDownloadService().isDownloaded(HerContent.bookId), isTrue);
    });
  });

  group('the shadowing sentences', () {
    test('every one of them is a love sentence, addressed to her', () {
      expect(HerContent.shadowingSentences, isNotEmpty);

      final Set<String> seen = <String>{};
      for (final Map<String, String> sentence in HerContent.shadowingSentences) {
        expect(
          sentence.keys,
          containsAll(<String>['hanzi', 'pinyin', 'english']),
        );
        expect(sentence['hanzi']!.trim(), isNotEmpty);
        expect(sentence['pinyin']!.trim(), isNotEmpty);
        expect(sentence['english']!.trim(), isNotEmpty);
        // It addresses her (你) or names love (爱), and it says so in English too.
        // That *is* the requirement, and a sentence doing neither is not one she asked
        // for — which is exactly what a themed model prompt cannot promise.
        expect(RegExp('[你爱]').hasMatch(sentence['hanzi']!), isTrue,
            reason: sentence['hanzi']);
        expect(
          RegExp('love|you', caseSensitive: false)
              .hasMatch(sentence['english']!),
          isTrue,
          reason: sentence['english'],
        );
        // A duplicate would let "never repeat" repeat.
        expect(seen.add(sentence['hanzi']!), isTrue,
            reason: 'duplicated: ${sentence['hanzi']}');
      }
    });

    test('the bank covers the themed modes and leaves her own words alone', () {
      // The six modes the studio offers (`ShadowingMode` in the studio screen), and
      // which of them a bank answers. `customWord` / `customSentence` are her own
      // input, so they keep going to the model for their pinyin and translation, and
      // `ourDates` has a bank of its own — which mode gets which bank is pinned in
      // `test/features/live_translate/shadowing_studio_practice_mode_test.dart`.
      for (final String mode in <String>[
        'ShadowingMode.freeFlow',
        'ShadowingMode.theme',
        'ShadowingMode.deck',
        'ShadowingMode.ourDates',
      ]) {
        expect(HerContent.shadowingBankAppliesTo(mode), isTrue, reason: mode);
      }
      for (final String mode in <String>[
        'ShadowingMode.customWord',
        'ShadowingMode.customSentence',
      ]) {
        expect(HerContent.shadowingBankAppliesTo(mode), isFalse, reason: mode);
      }
    });

    test('she hears each one before any of them twice, then starts again', () {
      expect(
        HerContent.shadowingSentenceAfter(<String>[])['hanzi'],
        HerContent.shadowingSentences.first['hanzi'],
      );

      final List<String> heard = <String>[];
      for (int i = 0; i < HerContent.shadowingSentences.length; i++) {
        final Map<String, String> next =
            HerContent.shadowingSentenceAfter(heard);
        expect(heard, isNot(contains(next['hanzi'])), reason: next['hanzi']);
        heard.add(next['hanzi']!);
      }

      // The bank never runs dry: once everything has been said, it starts over.
      expect(
        HerContent.shadowingSentenceAfter(heard)['hanzi'],
        HerContent.shadowingSentences.first['hanzi'],
      );
    });

    test('her three days are the same date in Chinese and in English', () {
      // Each of the four is written twice over — once to be read out loud and once to
      // be understood — so the two have to agree, or she practises one day and reads
      // another. The Chinese dates are in numerals, the way a date is written on a
      // card, and the English is his.
      const Map<String, String> dayInChinese = <String, String>{
        '16 October 2025': '二零二五年十月十六日',
        '18 October 2025': '二零二五年十月十八日',
        '14.07.26': '二零二六年七月十四日',
      };

      expect(HerContent.shadowingDateSentences, hasLength(4));
      expect(HerContent.shadowingDateSentences.first['english'], 'I love you.');

      for (final MapEntry<String, String> day in dayInChinese.entries) {
        final Map<String, String> sentence =
            HerContent.shadowingDateSentences.firstWhere(
          (Map<String, String> s) => s['english']!.contains(day.key),
          orElse: () => <String, String>{},
        );
        expect(sentence, isNotEmpty, reason: 'no sentence for ${day.key}');
        expect(sentence['hanzi'], contains(day.value), reason: day.key);
        expect(sentence['english'], contains(day.key), reason: day.key);
      }

      // The card under the mode row lists the same three days.
      expect(HerContent.shadowingDateLabels, hasLength(dayInChinese.length));
    });
  });

  group('the deck', () {
    test('is called Love and holds the six words, in the order asked for', () {
      expect(HerContent.deckId, 'love');
      expect(HerContent.deckName, 'Love');
      expect(HerContent.deckVocabulary, hasLength(6));
      expect(
        HerContent.deckVocabulary.map((Map<String, String> w) => w['hanzi']),
        <String>['汉堡包', '蓝色柠檬水', '爱', '汉', '宝宝', '我爱你'],
      );

      // Each card is the word that was asked for, plus the Chinese for it: the label
      // she used, and the sounds it is actually pronounced with.
      const List<String> asked = <String>[
        'hanbaobao',
        'blue lemonade',
        'love',
        'Han',
        'baobao',
        'wo ai ni',
      ];
      final RegExp tone = RegExp(r'[āáǎàēéěèīíǐìōóǒòūúǔùǖǘǚǜ]');
      for (int i = 0; i < asked.length; i++) {
        expect(
          HerContent.deckVocabulary[i]['definition']!.toLowerCase(),
          contains(asked[i].toLowerCase()),
          reason: asked[i],
        );
        expect(
          tone.hasMatch(HerContent.deckVocabulary[i]['pinyin']!),
          isTrue,
          reason: '${asked[i]} needs a tone: '
              '${HerContent.deckVocabulary[i]['pinyin']}',
        );
      }
    });

    test('is seeded into her library exactly once, and keeps her progress',
        () async {
      final ProviderContainer container = ProviderContainer();
      addTearDown(container.dispose);
      await container.read(flashcardControllerProvider.future);
      final FlashcardController controller =
          container.read(flashcardControllerProvider.notifier);

      await controller.ensureLoveDeck();

      final Box<FlashcardModel> cards = Hive.box<FlashcardModel>('flashcards');
      expect(
        cards.keys.toList()..sort(),
        <String>[
          'love_001',
          'love_002',
          'love_003',
          'love_004',
          'love_005',
          'love_006',
        ],
      );
      expect(cards.values.every((FlashcardModel c) => c.deckId == 'love'),
          isTrue);
      expect(
        cards.values.map((FlashcardModel c) => c.hanzi).toSet(),
        HerContent.deckVocabulary
            .map((Map<String, String> w) => w['hanzi'])
            .toSet(),
      );
      expect(Hive.box<DeckModel>('decks').get('love')?.name, 'Love');

      // Re-opening the library must not duplicate a card, and must not throw away the
      // review progress she has already earned on one: the installer only writes a card
      // that is missing, so a reviewed card is left exactly as she left it.
      final FlashcardModel seeded = cards.get('love_001')!;
      await controller.reviewFlashcard(seeded.toEntity(), 5);
      final FlashcardModel reviewed = cards.get('love_001')!;
      expect(reviewed.nextReviewDate, isNot(seeded.nextReviewDate),
          reason: 'the review should have moved the due date');

      await controller.ensureLoveDeck();

      expect(cards, hasLength(6));
      expect(cards.get('love_001')!.nextReviewDate, reviewed.nextReviewDate);
      expect(cards.get('love_001')!.easeFactor, reviewed.easeFactor);
      expect(cards.get('love_001')!.streak, reviewed.streak);
    });
  });

  group('the surfaces', () {
    Future<void> pump(
      WidgetTester tester,
      Widget child, {
      String? email = HerAccount.email,
    }) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: <Override>[
            sharedPreferencesProvider.overrideWithValue(prefs),
            currentUserProvider.overrideWithValue(_FakeUser(email)),
            hiveBoxProvider.overrideWithValue(_FakeFlashcardBox()),
            flashcardRepositoryProvider
                .overrideWithValue(_FakeFlashcardRepository()),
            deckRepositoryProvider.overrideWithValue(_FakeDeckRepository()),
          ],
          child: MaterialApp(
            locale: const Locale('en'),
            localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            home: child,
          ),
        ),
      );
      // Bounded pumps rather than `pumpAndSettle`: these screens keep art and shimmer
      // animating, so "settled" never arrives. Nothing asserted below waits on the
      // deck list either — the gate decides the whole screen, and it decides it in
      // `build`.
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      // Artwork on the way to these screens is fetched over the network; a test client
      // answers 400 and the ordinary screens log it. That noise is not this test's
      // subject, so it is drained rather than asserted on.
      while (tester.takeException() != null) {}
    }

    testWidgets('her deck library is her deck, with the six words on it',
        (WidgetTester tester) async {
      await pump(tester, const TomeManagerScreen());

      expect(find.byType(HerDeckLibrary), findsOneWidget);
      expect(find.text('Love'), findsOneWidget);
      for (final Map<String, String> word in HerContent.deckVocabulary) {
        expect(find.text(word['hanzi']!), findsOneWidget,
            reason: word['hanzi']);
      }
    });

    testWidgets('everyone else still gets the ordinary deck library',
        (WidgetTester tester) async {
      await pump(
        tester,
        const TomeManagerScreen(),
        email: 'someone@example.com',
      );

      // The whole personal screen is gone, not hidden inside the catalogue, and the
      // catalogue itself is the one that was always there.
      expect(find.byType(HerDeckLibrary), findsNothing);
      expect(find.text('Love'), findsNothing);
      expect(find.byType(ZenSearchBar), findsOneWidget);
    });

    testWidgets('her home card leads with hanbaobao', (WidgetTester tester) async {
      await pump(tester, const Scaffold(body: TodayInsightCard()));

      // Twice: once as the watermark behind the card, once as the word itself.
      expect(find.text('汉堡包'), findsWidgets);
    });

    testWidgets('everyone else, and nobody signed in, still get the rotation',
        (WidgetTester tester) async {
      final String today = wordOfTheDayFor(DateTime.now()).hanzi;

      for (final String? account in <String?>[null, 'someone@example.com']) {
        await pump(
          tester,
          const Scaffold(body: TodayInsightCard()),
          email: account,
        );
        expect(find.text('汉堡包'), findsNothing, reason: '$account');
        expect(find.text(today), findsWidgets, reason: '$account');
      }
    });
  });
}
