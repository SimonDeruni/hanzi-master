import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/character_detail_provider.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/settings_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/character_detail_screen.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/quick_look_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Opening CharacterDetailScreen must yield the *same* rich page no matter which
/// Quick Look card it was launched from.
///
/// The report (verbatim): *"there's a difference in what the dictionary main
/// page of a character look like depending on from which quicklook card we
/// actually open it (if it's the floating one we get the right big screen
/// dictionary, if it's the one from the bottom we get the wrong one)"*.
///
/// The three entry points reach `_FoundBody`'s "Open Card →" with different
/// inputs:
///   - the reading **floating** popover passes **no card**;
///   - the dictionary **"from the bottom"** sheet passes the bare `global_<id>`
///     search card it was built from (no strokes, HSK 0);
///   - the bottom-sheet fallback shares the dictionary shape.
///
/// All three must still open the reader's saved identity: the library id, the
/// animated stroke paths and the HSK badge — never the bare dictionary card.
class _LibraryController extends FlashcardController {
  _LibraryController([this.cards = const [_savedCard]]);

  final List<Flashcard> cards;

  @override
  Future<List<Flashcard>> build() async => cards;

  @override
  Future<Flashcard?> loadStrokesFor(Flashcard card) async => card;
}

/// The card the reader owns: real identity, strokes and an HSK level.
const _savedCard = Flashcard(
  id: 'hsk1_001',
  hanzi: '人',
  pinyin: 'rén',
  definition: 'person (saved)',
  hskLevel: 1,
  strokePaths: ['M 0 0 L 1 1', 'M 2 2 L 3 3'],
  modeStats: {},
  dictionaryWordId: 5,
);

/// The bare card a dictionary search result carries: a `global_` id, no strokes
/// and a zero HSK level — the shape that produced the "wrong" page.
const _dictionaryCard = Flashcard(
  id: 'global_5',
  hanzi: '人',
  pinyin: 'rén',
  definition: 'person',
  hskLevel: 0,
  strokePaths: [],
  modeStats: {},
  dictionaryWordId: 5,
);

class _Launcher extends StatelessWidget {
  const _Launcher({
    this.card,
    this.presentation = QuickLookPresentation.bottomSheet,
  });

  final Flashcard? card;
  final QuickLookPresentation presentation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (ctx) => Center(
          child: ElevatedButton(
            onPressed: () => showQuickLook(
              ctx,
              '人',
              card: card,
              presentation: presentation,
              anchorPosition:
                  presentation == QuickLookPresentation.readingPopover
                      ? const Offset(500, 400)
                      : null,
            ),
            child: const Text('launch'),
          ),
        ),
      ),
    );
  }
}

Future<void> _openQuickLookThenFullCard(
  WidgetTester tester, {
  required Flashcard? quickLookCard,
  QuickLookPresentation presentation = QuickLookPresentation.bottomSheet,
}) async {
  SharedPreferences.setMockInitialValues({'app_locale': 'en'});
  final prefs = await SharedPreferences.getInstance();

  await tester.binding.setSurfaceSize(const Size(1000, 1200));
  addTearDown(() => tester.binding.setSurfaceSize(null));

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        flashcardControllerProvider.overrideWith(_LibraryController.new),
        dictionaryWordProvider(5).overrideWith((ref) async => _dictionaryCard),
        quickLookProvider('人').overrideWith((ref) async => _dictionaryCard),
        commonWordsProvider.overrideWith((ref, character) async => const []),
        characterContextProvider.overrideWith((ref, card) async => null),
      ],
      child: MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: _Launcher(card: quickLookCard, presentation: presentation),
      ),
    ),
  );
  await tester.pump();

  await tester.tap(find.text('launch'));
  // The sheet resolves its lookup (async providers) then paints. The labelled
  // loader animates forever, so `pumpAndSettle` is not an option here.
  for (var frame = 0; frame < 8; frame++) {
    await tester.pump(const Duration(milliseconds: 200));
  }

  await tester.tap(find.text('Open Card →'));
  for (var frame = 0; frame < 8; frame++) {
    await tester.pump(const Duration(milliseconds: 200));
  }
}

void _expectSavedIdentity(WidgetTester tester) {
  final screen =
      tester.widget<CharacterDetailScreen>(find.byType(CharacterDetailScreen));
  expect(screen.card.id, 'hsk1_001',
      reason: 'The library id must survive the entry point.');
  expect(screen.card.hskLevel, 1,
      reason: 'The HSK badge must come from the saved card, not the bare one.');
  expect(screen.card.strokePaths, isNotEmpty,
      reason: 'Animated stroke paths must survive the entry point.');
}

void main() {
  testWidgets('reading (floating popover) opens the saved identity',
      (tester) async {
    await _openQuickLookThenFullCard(
      tester,
      quickLookCard: null,
      presentation: QuickLookPresentation.readingPopover,
    );
    _expectSavedIdentity(tester);
  });

  testWidgets('dictionary (from the bottom) opens the saved identity',
      (tester) async {
    await _openQuickLookThenFullCard(tester, quickLookCard: _dictionaryCard);
    _expectSavedIdentity(tester);
  });

  testWidgets('bottom-sheet fallback carried no card also opens it',
      (tester) async {
    await _openQuickLookThenFullCard(tester, quickLookCard: null);
    _expectSavedIdentity(tester);
  });
}

