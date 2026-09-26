/// The deck screen's iPad treatment (F4 of `docs/IPAD_ADAPTIVE_PLAN.md`): at
/// ≥840dp the deck's numbers move *beside* the card list. The iPhone layout must
/// not change at all, and this pair of tests is what keeps both statements true.
@Tags(<String>['ipad-sweep'])
library;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/deck_detail_screen.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

class _FakeFlashcardController extends FlashcardController {
  _FakeFlashcardController(this.cards);

  final List<Flashcard> cards;

  @override
  Future<List<Flashcard>> build() async => cards;
}

Deck _deck() => Deck(
      id: 'hsk1',
      name: 'HSK 1',
      createdAt: DateTime(2026, 1, 1),
    );

Widget _host({required List<Flashcard> cards}) => ProviderScope(
      overrides: <Override>[
        flashcardControllerProvider
            .overrideWith(() => _FakeFlashcardController(cards)),
      ],
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
        home: DeckDetailScreen(deck: _deck()),
      ),
    );

Future<void> _pumpAt(WidgetTester tester, Size size) async {
  // The view API, not `binding.setSurfaceSize` (see locale_layout_harness.dart).
  tester.view.devicePixelRatio = 1.0;
  tester.view.physicalSize = size;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(
    _host(cards: const <Flashcard>[]),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('an iPad shows the deck insight rail beside the cards',
      (WidgetTester tester) async {
    await _pumpAt(tester, const Size(1024, 1366));

    // Rail-only labels: neither appears in the phone layout.
    expect(find.text('My Progress'), findsOneWidget);
    expect(find.text('Number of Cards'), findsOneWidget);

    // The card list is still there beside it (the screen's own scroll view).
    expect(find.byType(NestedScrollView), findsOneWidget);
  });

  testWidgets('an iPhone keeps the single-column layout, with no rail',
      (WidgetTester tester) async {
    await _pumpAt(tester, const Size(390, 844));

    expect(find.text('My Progress'), findsNothing);
    expect(find.text('Number of Cards'), findsNothing);
    expect(find.byType(NestedScrollView), findsOneWidget);
  });

  testWidgets('a Split View slice behaves like the phone, not the iPad',
      (WidgetTester tester) async {
    // 600-839dp is medium: a 320dp rail there would squeeze the cards, so the
    // wide branch must not fire just because the device is an iPad.
    await _pumpAt(tester, const Size(700, 1000));

    expect(find.text('My Progress'), findsNothing);
    expect(find.text('Number of Cards'), findsNothing);
  });
}
