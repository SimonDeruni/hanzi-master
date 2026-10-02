import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/services/audio_quota_service.dart';
import 'package:hanzi_master/core/services/audio_service.dart';
import 'package:hanzi_master/core/services/local_translation_service.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/settings_controller.dart';
import 'package:hanzi_master/features/reading/domain/entities/book_model.dart';
import 'package:hanzi_master/features/reading/presentation/screens/book_reader_screen.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Records what the reader asks the narrator to say, and lets a test declare
/// that a sentence ended.
class _FakeAudioService extends Fake implements AudioService {
  final List<String> spoken = <String>[];
  int stops = 0;
  final StreamController<void> _complete = StreamController<void>.broadcast();
  final StreamController<String> _errors =
      StreamController<String>.broadcast();

  @override
  Stream<void> get onPlayerComplete => _complete.stream;

  @override
  Stream<String> get onPlaybackError => _errors.stream;

  @override
  bool get isAudiobookLoaded => false;

  @override
  Future<bool> playSentence(
    String sentence, {
    String voiceName = 'Fenrir',
    double? speechRate,
    double? playbackRate,
    bool fromQueue = false,
  }) async {
    spoken.add(sentence);
    return true;
  }

  @override
  Future<void> prefetchSentence(String sentence,
      {String voiceName = 'Kore'}) async {}

  @override
  Future<void> stop() async {
    stops++;
  }

  @override
  void setAudiobookVoice(String voiceName) {}

  @override
  void setStopAtChapterEnd(bool enabled) {}

  /// The engine finished the sentence it was given.
  void finishSentence() => _complete.add(null);

  Future<void> close() async {
    await _complete.close();
    await _errors.close();
  }
}

class _FakeQuotaService extends Fake implements AudioQuotaService {
  @override
  bool get hasQuotaRemaining => true;

  @override
  double get remainingHours => 4.0;
}

class _FakeTranslationService extends Fake implements LocalTranslationService {
  @override
  Future<String> translate(String text) async => text;

  @override
  Future<String> translateEnglishDefinition(String definition,
          {String? hanzi}) async =>
      definition;
}

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
  totalChapters: 1,
  coverEmoji: '📕',
  tags: <String>[],
);

final List<BookChapter> _chapters = <BookChapter>[
  const BookChapter(
    id: 'c1',
    bookId: 'sanguo',
    chapterIndex: 1,
    title: '第一回',
    titleEn: 'Chapter 1',
    sentences: <BookSentence>[
      BookSentence(chinese: '汉', pinyin: 'hàn', english: 'Han'),
      BookSentence(chinese: '字', pinyin: 'zì', english: 'character'),
    ],
  ),
];

/// The inline audiobook in the book reader.
///
/// **What this pins:** each sentence is its own playback request, so "the audio
/// advances by itself" is a *reader* responsibility — the reader has to hear the
/// engine finish and start the next sentence. A transport that plays the
/// sentence it was given and then sits there is the bug this guards.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<_FakeAudioService> pumpReader(WidgetTester tester) async {
    SharedPreferences.setMockInitialValues(<String, Object>{
      'app_locale': 'fr',
      'translation_target_language': 'French',
    });
    final prefs = await SharedPreferences.getInstance();
    final audio = _FakeAudioService();
    addTearDown(audio.close);

    await tester.pumpWidget(ProviderScope(
      overrides: <Override>[
        sharedPreferencesProvider.overrideWithValue(prefs),
        audioServiceProvider.overrideWithValue(audio),
        audioQuotaServiceProvider.overrideWithValue(_FakeQuotaService()),
        localTranslationServiceProvider
            .overrideWithValue(_FakeTranslationService()),
      ],
      child: MaterialApp(
        locale: const Locale('fr'),
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: BookReaderScreen(
          book: _book,
          chapters: _chapters,
          initialChapterIndex: 0,
          autoStartAudiobook: true,
        ),
      ),
    ));
    // First frame: the reader's post-frame callback starts the audiobook.
    await tester.pump();
    await tester.pump();
    return audio;
  }

  testWidgets('plays the next sentence when the engine reports that one ended',
      (WidgetTester tester) async {
    // The reader at the size in the report: iPad Pro 11" landscape.
    await tester.binding.setSurfaceSize(const Size(1194, 834));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final audio = await pumpReader(tester);
    expect(audio.spoken, <String>['汉'],
        reason: 'the reader starts on the sentence it was opened at');

    audio.finishSentence();
    // The reader holds a short gap between sentences before starting the next.
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump();

    expect(
      audio.spoken,
      <String>['汉', '字'],
      reason: 'a finished sentence must be followed by the next one, or the '
          'transport is a one-sentence player',
    );
    expect(find.textContaining('Phrase 2 sur 2'), findsWidgets,
        reason: 'the transport reports the sentence it is actually playing');

    // Leaving the book must tear the reader down cleanly. `ref` is unusable by
    // the time `dispose` runs, so teardown may not read it — when it did, the
    // first `ref.read` threw and everything after it (stopping the inline
    // audio, cancelling the subscriptions) never ran.
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
    expect(tester.takeException(), isNull,
        reason: 'reader teardown must not throw');
    expect(audio.stops, greaterThan(0),
        reason: 'leaving the reader stops the audio it owns');
  });
}

