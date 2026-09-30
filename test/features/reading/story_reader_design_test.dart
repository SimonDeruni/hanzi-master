/// The story reader's reading surface, brought in line with the book reader.
///
/// **What went wrong.** `StoryReaderScreen` printed `word.pinyin` verbatim, but
/// `GeminiService._deriveWords` builds words with `pinyin: ''` on purpose
/// ("the reader derives pinyin from the hanzi itself"), so a deck story showed
/// no pinyin at all. Translations were the mirror image: opt-in per sentence
/// behind a grey icon, so a freshly opened story showed none either.
@Tags(<String>['ipad-sweep'])
library;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/core/services/local_translation_service.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/core/widgets/translated_text.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/settings_controller.dart';
import 'package:hanzi_master/features/reading/data/repositories/story_repository.dart';
import 'package:hanzi_master/features/reading/domain/entities/graded_story.dart';
import 'package:hanzi_master/features/reading/presentation/providers/story_controller.dart';
import 'package:hanzi_master/features/reading/presentation/screens/story_reader_screen.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The controller's constructor loads custom blueprints; nothing else is
/// reached, and every network path is neutralised below.
class _FakeGeminiService extends Fake implements GeminiService {}

class _FakeStoryRepository extends Fake implements StoryRepository {
  @override
  Future<List<StoryBlueprint>> getCustomBlueprints() async =>
      <StoryBlueprint>[];
}

class _FakeStoryController extends StoryController {
  _FakeStoryController(this.story)
      : super(
          geminiService: _FakeGeminiService(),
          repository: _FakeStoryRepository(),
        ) {
    state = state.copyWith(currentStory: story);
  }

  final GradedStory story;

  @override
  Future<void> fetchAndParseFirebaseStory(
      StoryBlueprint blueprint, int hskLevel) async {}
  @override
  Future<void> fetchAndParseLocalStory(
      StoryBlueprint blueprint, int hskLevel) async {}
  @override
  Future<void> loadOrGenerateStory(
      StoryBlueprint blueprint, int hskLevel) async {}
}

class _FakeFlashcardController extends FlashcardController {
  @override
  Future<List<Flashcard>> build() async => <Flashcard>[];
}

/// Returns the input, which is all this layout test needs.
class _FakeTranslationService extends LocalTranslationService {
  _FakeTranslationService() : super(targetLanguage: 'English');

  @override
  Future<String> translate(String text) async => text;
}

StoryBlueprint _blueprint() => const StoryBlueprint(
      id: 'deck_story_test',
      title: 'Culture & Daily Life',
      topic: 'Culture & Daily Life',
      category: 'Deck Story',
      imageUrl: '',
      tags: <String>[],
    );

/// A deck story exactly as `GeminiService._deriveWords` produces it: one word
/// per character, with `pinyin` and `meaning` deliberately empty.
GradedStory _deckStory() => GradedStory(
      id: 'deck_story_test_hsk0',
      title: 'Culture & Daily Life',
      category: 'Deck Story',
      hskLevel: 0,
      generatedAt: DateTime(2026, 9, 29),
      sentences: <AiSentence>[
        AiSentence(
          chinese: '文化',
          english: 'civilization',
          words: <AiWord>[
            AiWord(hanzi: '文', pinyin: '', meaning: ''),
            AiWord(hanzi: '化', pinyin: '', meaning: ''),
          ],
        ),
      ],
    );

/// One container for the whole file.
///
/// `audioServiceProvider` and `zenAmbientServiceProvider` hand back **app
/// singletons** (`ZenAmbientService.instance`), and Riverpod disposes a notifier
/// when its provider's container goes away. A container per test therefore
/// killed them for every test after the first, with `Bad state: Tried to use
/// ZenAmbientService after 'dispose' was called`. One long-lived container keeps
/// them alive, which is what the app itself does.
late ProviderContainer _container;

Future<void> _pump(WidgetTester tester,
    {Size size = const Size(390, 844)}) async {
  tester.view.devicePixelRatio = 1.0;
  tester.view.physicalSize = size;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: _container,
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        locale: const Locale('en'),
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: StoryReaderScreen(blueprint: _blueprint(), hskLevel: 0),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues(<String, Object>{'app_locale': 'en'});
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    _container = ProviderContainer(
      overrides: <Override>[
        storyControllerProvider
            .overrideWith((Ref ref) => _FakeStoryController(_deckStory())),
        flashcardControllerProvider.overrideWith(_FakeFlashcardController.new),
        sharedPreferencesProvider.overrideWithValue(preferences),
        localTranslationServiceProvider
            .overrideWithValue(_FakeTranslationService()),
      ],
    );
  });

  tearDownAll(() => _container.dispose());

  testWidgets('a derived-word story shows pinyin above the characters',
      (WidgetTester tester) async {
    await _pump(tester);

    // The bug: `word.pinyin` is empty for every derived word, so neither of
    // these rendered at all before.
    expect(find.text('wén'), findsOneWidget);
    expect(find.text('huà'), findsOneWidget);
  });

  testWidgets('translations are on by default', (WidgetTester tester) async {
    await _pump(tester);

    // The book reader's contract (`_showAllTranslations = true`). This used to
    // take a tap on an unlabelled grey icon per sentence.
    expect(find.byType(TranslatedText), findsOneWidget);
    expect(find.byTooltip('Hide Translation'), findsOneWidget);
  });

  testWidgets('the pinyin toggle cycles and actually hides pinyin',
      (WidgetTester tester) async {
    await _pump(tester);
    final Finder toggle = find.byTooltip('Toggle Pinyin');

    // ghost — still rendered, so the state is no longer a no-op.
    await tester.tap(toggle);
    await tester.pumpAndSettle();
    expect(find.text('wén'), findsOneWidget);

    // none — gone.
    await tester.tap(toggle);
    await tester.pumpAndSettle();
    expect(find.text('wén'), findsNothing);
    expect(find.text('huà'), findsNothing);

    // all — back.
    await tester.tap(toggle);
    await tester.pumpAndSettle();
    expect(find.text('wén'), findsOneWidget);
  });

  testWidgets('the translation toggle hides every translation again',
      (WidgetTester tester) async {
    await _pump(tester);

    await tester.tap(find.byTooltip('Hide Translation'));
    await tester.pumpAndSettle();

    expect(find.byType(TranslatedText), findsNothing);
    expect(find.byTooltip('Show Translation'), findsOneWidget);
  });
}
