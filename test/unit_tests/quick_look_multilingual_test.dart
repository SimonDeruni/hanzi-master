import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/character_detail_provider.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/settings_controller.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/quick_look_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _InMemoryFlashcardController extends FlashcardController {
  @override
  Future<List<Flashcard>> build() async => const [];
}

Widget _buildTestApp({
  required Widget child,
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
      home: Scaffold(body: child),
    ),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  for (final langCase in <({
    String locale,
    String language,
    String pinyin,
    String definition,
    String alsoSeenIn,
    String addToDeck,
  })>[
    (
      locale: 'fr',
      language: 'French',
      pinyin: 'lì',
      definition: 'force; puissance',
      alsoSeenIn: 'Également vu dans',
      addToDeck: '+ Dans le deck',
    ),
    (
      locale: 'de',
      language: 'German',
      pinyin: 'lì',
      definition: 'Kraft; Stärke',
      alsoSeenIn: 'Auch zu sehen in',
      addToDeck: '+ Zu Deck',
    ),
    (
      locale: 'es',
      language: 'Spanish',
      pinyin: 'lì',
      definition: 'fuerza; poder',
      alsoSeenIn: 'También visto en',
      addToDeck: '+ Al mazo',
    ),
  ]) {
    testWidgets(
        'Quick Look renders ${langCase.language} definition and localized labels immediately',
        (tester) async {
      SharedPreferences.setMockInitialValues({
        'app_locale': langCase.locale,
        'translation_target_language': langCase.language,
      });
      final prefs = await SharedPreferences.getInstance();

      final mockCard = Flashcard(
        id: 'global_15039',
        hanzi: '力',
        pinyin: langCase.pinyin,
        definition: langCase.definition,
        definitionLanguage: langCase.language,
        dictionaryWordId: 15039,
        englishDefinition: 'power; force; strength',
        hskLevel: 1,
        strokePaths: const [],
        modeStats: const {},
      );

      final container = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          quickLookProvider('力').overrideWith((ref) => Future.value(mockCard)),
          commonWordsProvider('力')
              .overrideWith((ref) => Future.value(const [])),
          flashcardControllerProvider
              .overrideWith(() => _InMemoryFlashcardController()),
        ],
      );
      addTearDown(container.dispose);

      await tester.pumpWidget(
        _buildTestApp(
          child: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => showQuickLook(context, '力', card: mockCard),
              child: const Text('Open Quick Look'),
            ),
          ),
          container: container,
          locale: Locale(langCase.locale),
        ),
      );

      await tester.tap(find.text('Open Quick Look'));
      await tester.pumpAndSettle();

      // Verify character and pinyin
      expect(find.text('力'), findsWidgets);
      expect(find.text(langCase.pinyin), findsOneWidget);

      // Verify definition is visible IMMEDIATELY in the target language (NOT hidden by SizedBox)
      expect(find.text(langCase.definition), findsOneWidget);
    });
  }
}
