import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/features/reading/domain/entities/book_model.dart';
import 'package:hanzi_master/features/reading/presentation/providers/now_playing_provider.dart';
import 'package:hanzi_master/features/reading/presentation/widgets/now_playing_bar.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

/// Guards the in-app transport for background audiobook playback.
///
/// **The gap it closes:** with `audio_service` playing in the background, leaving
/// the reader/player left the OS media notification as the *only* control — no
/// in-app surface showed what was playing or offered play/pause.
const BookModel _book = BookModel(
  id: 'sanguo',
  title: '三国演义',
  titleEn: 'Three Kingdoms',
  author: '罗贯中',
  authorEn: 'Luo Guanzhong',
  category: 'Novel',
  description: '',
  descriptionEn: '',
  dynastyOrEra: 'Ming',
  hskLevel: 6,
  totalChapters: 5,
  coverEmoji: '📕',
  tags: <String>[],
);

/// Five chapters of two sentences, numbered as the data numbers them (1-based
/// [BookChapter.chapterIndex]); the engine addresses them by list index.
final List<BookChapter> _chapters = <BookChapter>[
  for (int i = 0; i < 5; i++)
    BookChapter(
      id: 'c${i + 1}',
      bookId: 'sanguo',
      chapterIndex: i + 1,
      title: '第${i + 1}回',
      titleEn: 'Chapter ${i + 1}',
      sentences: const <BookSentence>[
        BookSentence(chinese: '汉', pinyin: 'hàn', english: 'Han'),
        BookSentence(chinese: '字', pinyin: 'zì', english: 'character'),
      ],
    ),
];

const NowPlayingInfo _playing = NowPlayingInfo(
  playing: true,
  bookTitle: '三国演义',
  chapterTitle: '第五回',
  chapterIndex: 4,
  sentenceIndex: 0,
);

Future<void> _pump(WidgetTester tester, {required NowPlayingInfo? info}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        nowPlayingProvider
            .overrideWith((ref) => Stream<NowPlayingInfo?>.value(info)),
        nowPlayingBookProvider.overrideWith(
          (ref) => NowPlayingBook(book: _book, chapters: _chapters),
        ),
      ],
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        locale: const Locale('fr'),
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: const Scaffold(bottomNavigationBar: NowPlayingBar()),
      ),
    ),
  );
  await tester.pump();
}

void main() {
  group('NowPlayingBar rendering', () {
    testWidgets('shows the book, its position and a pause while playing',
        (WidgetTester tester) async {
      await _pump(tester, info: _playing);

      expect(find.text('三国演义'), findsWidgets);
      expect(find.textContaining('Chapitre 5 sur 5'), findsOneWidget,
          reason: 'The position mirrors the reader header, localized');
      expect(find.textContaining('Phrase 1 sur 2'), findsOneWidget);
      expect(find.byIcon(Icons.pause_rounded), findsOneWidget);
    });

    testWidgets('offers play while paused', (WidgetTester tester) async {
      await _pump(
        tester,
        info: const NowPlayingInfo(
          playing: false,
          bookTitle: '三国演义',
          chapterTitle: '第四回',
          chapterIndex: 0,
          sentenceIndex: 1,
        ),
      );

      expect(find.byIcon(Icons.play_arrow_rounded), findsOneWidget);
      expect(find.textContaining('Phrase 2 sur 2'), findsOneWidget);
    });

    testWidgets('collapses to nothing when the engine is idle',
        (WidgetTester tester) async {
      await _pump(tester, info: null);

      expect(tester.getSize(find.byType(NowPlayingBar)).height, 0,
          reason: 'No dead bar over the tab bar when nothing is loaded');
    });
  });

  group('NowPlayingBar wiring', () {
    late String bar;
    late String shell;
    late String player;
    late String reader;
    late String service;

    setUpAll(() {
      String read(String path) =>
          File(path).readAsStringSync().replaceAll('\r\n', '\n');

      bar = read(
          'lib/features/reading/presentation/widgets/now_playing_bar.dart');
      shell = read(
          'lib/features/flashcards/presentation/screens/main_navigation_screen.dart');
      player = read(
          'lib/features/reading/presentation/screens/audiobook_player_screen.dart');
      reader = read(
          'lib/features/reading/presentation/screens/book_reader_screen.dart');
      service = read('lib/core/services/audio_service.dart');
    });

    test('the shell stacks the bar above the tab bar', () {
      expect(shell, contains('bottomNavigationBar: Column('));
      expect(shell, contains('const NowPlayingBar(),'));
      expect(shell.indexOf('const NowPlayingBar(),'),
          lessThan(shell.indexOf('child: BottomNavigationBar(')),
          reason: 'The transport sits above the tabs, not inside them');
    });

    test('tapping the bar reopens the player through SwipeBackRoute', () {
      expect(bar, contains('SwipeBackRoute('));
      expect(bar, isNot(contains('MaterialPageRoute')),
          reason: 'Bare MaterialPageRoute is a shrink-only ratchet');
    });

    test('leaving the player while playing hands control to the shell', () {
      expect(player, contains('if (!audio.isAudiobookPlaying)'));
      expect(player, contains('nowPlayingBookProvider.notifier).state'));
    });

    test('the reader stops only its own inline playback', () {
      expect(reader, contains('!audio.isAudiobookLoaded'));
      expect(reader, contains('audio.stop()'));
    });

    test('the engine can tell the two playback owners apart', () {
      expect(
          service, contains('bool get isAudiobookLoaded => _audiobookActive;'));
      expect(service,
          contains('bool get isAudiobookPlaying => _audiobookPlaying;'));
      expect(service, contains('AudiobookTrack? get currentTrack'));
      expect(service, contains('_audiobookActive = false;'),
          reason:
              'Inline reading-aloud takes the engine over from the audiobook');
    });
  });
}
