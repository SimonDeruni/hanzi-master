import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/providers.dart';
import 'package:hanzi_master/core/services/analytics_service.dart';
import 'package:hanzi_master/core/services/api_key_pool.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/features/flashcards/data/repositories/global_dictionary_repository.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/character_detail_provider.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/settings_controller.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/quick_look_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A library with no saved cards, so Quick Look has nothing to fall back on.
class _InMemoryFlashcardController extends FlashcardController {
  @override
  Future<List<Flashcard>> build() async => const [];
}

/// Answers nothing, ever: the shape of an AI fallback that never lands.
class _HangingGeminiService extends GeminiService {
  _HangingGeminiService()
      : super(pool: ApiKeyPool(), analytics: AnalyticsService());

  @override
  Future<Map<String, String>> defineWord(String word) =>
      Completer<Map<String, String>>().future;
}

/// A dictionary that can never be read, and counts the repair attempts.
///
/// `isReady` is false because the base class never opened a database, which is
/// the state a reader is in when the local copy cannot be read. `init` is
/// replaced so the retry under test does not load the 250 MB asset — that part
/// is covered by the repository's own tests.
class _UnreadableDictionary extends GlobalDictionaryRepository {
  int repairAttempts = 0;

  @override
  Future<void> init({bool forceRepair = false}) async {
    repairAttempts++;
  }
}

// ---------------------------------------------------------------------------
// Quick Look when the dictionary has nothing to say
//
// The reported card was an empty panel: the character, an unlabelled spinner
// where the definition belongs, and no reading — for a character the shipped
// dictionary does contain. These tests pin what the panel must say now that a
// lookup can fail *and* be read as a failure: the reading the app can derive on
// its own, a localized line explaining what happened, and a retry.
// ---------------------------------------------------------------------------

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget buildApp({
    required ProviderContainer container,
    required Locale locale,
  }) {
    return UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        locale: locale,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => showQuickLook(
                context,
                '而',
                contextText: '人不知而不愠，不亦君子乎？',
                presentation: QuickLookPresentation.readingPopover,
                anchorPosition: const Offset(400, 200),
              ),
              child: const Text('Open Quick Look'),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pumpQuickLook(
    WidgetTester tester, {
    required Map<String, Object> preferences,
    GeminiService? gemini,
    GlobalDictionaryRepository? dictionary,
  }) async {
    SharedPreferences.setMockInitialValues(preferences);
    final prefs = await SharedPreferences.getInstance();
    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        // An unopened repository: what a reader sees when the local dictionary
        // copy could not be read.
        globalDictionaryRepositoryProvider
            .overrideWithValue(dictionary ?? GlobalDictionaryRepository()),
        quickLookProvider('而')
            .overrideWith((ref) => Future<Flashcard?>.value(null)),
        commonWordsProvider('而').overrideWith((ref) => Future.value(const [])),
        flashcardControllerProvider
            .overrideWith(() => _InMemoryFlashcardController()),
        if (gemini != null) geminiServiceProvider.overrideWithValue(gemini),
      ],
    );
    addTearDown(container.dispose);
    await tester.pumpWidget(
      buildApp(container: container, locale: const Locale('fr')),
    );
    await tester.tap(find.text('Open Quick Look'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    // The sheet resolves the lookup, then reads the AI consent preference; the
    // second frame is the one that renders what it decided. (Not
    // `pumpAndSettle`: the labelled loader animates forever by design.)
    await tester.pump();
  }

  testWidgets('a character with no entry still shows its reading',
      (tester) async {
    await pumpQuickLook(tester, preferences: {
      'app_locale': 'fr',
      'translation_target_language': 'French',
    });

    // Derived from the character itself, not from the dictionary.
    expect(find.text('ér'), findsOneWidget);
    // The reason is stated in the reader's language (French here), instead of
    // the empty definition slot the report showed.
    expect(find.text('Informations non disponibles.'), findsOneWidget);
    expect(find.text('Réessayer'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('retrying a card whose dictionary is unreadable repairs it',
      (tester) async {
    final dictionary = _UnreadableDictionary();
    await pumpQuickLook(
      tester,
      preferences: {
        'app_locale': 'fr',
        'translation_target_language': 'French',
      },
      dictionary: dictionary,
    );

    await tester.tap(find.text('Réessayer'));
    // The retry re-asks the sheet's provider and the AI preference; each step
    // needs a frame, and the labelled loader animates so `pumpAndSettle` is out.
    for (var frame = 0; frame < 8; frame++) {
      await tester.pump(const Duration(milliseconds: 100));
    }

    // The card is the reader's only way to repair a dictionary that could not
    // be read, because the copy is otherwise rebuilt only while the app starts.
    expect(dictionary.repairAttempts, 1);
    expect(tester.takeException(), isNull);
    // The repair did not work here, and the card says so instead of going blank.
    expect(find.text('ér'), findsOneWidget);
    expect(find.text('Informations non disponibles.'), findsOneWidget);
  });

  testWidgets('an AI answer that never arrives stops waiting and says so',
      (tester) async {
    await pumpQuickLook(
      tester,
      preferences: {
        'app_locale': 'fr',
        'translation_target_language': 'French',
        // Consent given, so the card is allowed to ask the AI.
        'has_agreed_to_ai_privacy': true,
      },
      gemini: _HangingGeminiService(),
    );

    // The wait is visible and named — this is the frame that used to be an
    // unlabelled arc nobody could read.
    expect(find.text('Chargement…'), findsOneWidget);

    // The wait is bounded: once it is over, the card admits it failed.
    await tester.pump(const Duration(seconds: 16));
    await tester.pump();
    expect(find.text("Erreur de chargement depuis l'IA."), findsOneWidget);
    expect(find.text('Réessayer'), findsOneWidget);
  });
}
