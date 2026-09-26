import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/review_stats.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_mode.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/settings_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/deck_card_picker_screen.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/zen_flight.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Hosts [child] with the platform "Reduce Motion" flag controllable.
///
/// The override goes through `MaterialApp.builder` rather than wrapping the app:
/// `MaterialApp` installs its own `MediaQuery`, so an outer one would be
/// discarded and the flag would silently read as false.
Widget _host(Widget child, {bool reduceMotion = false}) => MaterialApp(
      builder: (BuildContext context, Widget? inner) => MediaQuery(
        data: MediaQuery.of(context).copyWith(disableAnimations: reduceMotion),
        child: inner!,
      ),
      home: Scaffold(body: child),
    );

/// Two anchors to fly between: the "add" button of a low row, and the deck name
/// up in the app bar.
class _Anchors {
  final GlobalKey from = GlobalKey();
  final GlobalKey to = GlobalKey();

  Widget build() => Stack(
        children: <Widget>[
          Positioned(
            left: 24,
            top: 40,
            child: SizedBox(key: to, width: 40, height: 40),
          ),
          Positioned(
            left: 32,
            top: 520,
            child: SizedBox(key: from, width: 44, height: 44),
          ),
        ],
      );
}

/// A card sitting in a *different* deck, so the picker offers it.
const Flashcard _card = Flashcard(
  id: 'card-1',
  deckId: 'other-deck',
  hanzi: '學',
  pinyin: 'xué',
  definition: 'to learn',
  hskLevel: 1,
  strokePaths: <String>[],
  modeStats: <StudyMode, ReviewStats>{},
);

/// A controller that records the write instead of touching the repository, so
/// the add path can be asserted without Hive: the commit itself is the picker's
/// existing behaviour and is not what this file is about.
class _CountingFlashcardController extends FlashcardController {
  int saves = 0;
  Flashcard? saved;

  @override
  Future<List<Flashcard>> build() async => <Flashcard>[_card];

  @override
  Future<void> updateFlashcard(Flashcard card) async {
    saves++;
    saved = card;
    // Stands in for the provider update: the card now lives in the deck it was
    // added to, so the picker drops its row.
    state = AsyncValue.data(<Flashcard>[card]);
  }
}

void main() {
  testWidgets('a flight inserts one OverlayEntry, paints, and clears itself',
      (WidgetTester tester) async {
    final _Anchors anchors = _Anchors();
    await tester.pumpWidget(_host(anchors.build()));

    int arrivals = 0;
    expect(ZenFlight.activeFlights, 0);

    unawaited(ZenFlight.to(
      context: tester.element(find.byKey(anchors.from)),
      from: anchors.from,
      to: anchors.to,
      onArrived: () => arrivals++,
      child: const Text('FLYING'),
    ));

    // (a) the entry is inserted synchronously, before any frame is pumped.
    expect(ZenFlight.activeFlights, 1, reason: 'an OverlayEntry was inserted');

    await tester.pump();
    expect(find.text('FLYING'), findsOneWidget, reason: 'the card is on screen');

    // It actually travels: from the low anchor towards the deck up top.
    final Offset takeOff = tester.getCenter(find.text('FLYING'));
    await tester.pump(ZenMotion.quick ~/ 2);
    final Offset midFlight = tester.getCenter(find.text('FLYING'));
    expect(midFlight.dy, lessThan(takeOff.dy),
        reason: 'the card moves towards the target');

    // (b) every one of those frames painted without throwing.
    expect(tester.takeException(), isNull);

    await tester.pumpAndSettle();
    expect(find.text('FLYING'), findsNothing);
    expect(ZenFlight.activeFlights, 0, reason: 'the entry was removed again');
    expect(arrivals, 1, reason: 'the caller is told exactly once');
    expect(tester.takeException(), isNull);
  });

  testWidgets('(d) the returned future completes once the card has landed',
      (WidgetTester tester) async {
    final _Anchors anchors = _Anchors();
    await tester.pumpWidget(_host(anchors.build()));

    bool done = false;
    unawaited(ZenFlight.to(
      context: tester.element(find.byKey(anchors.from)),
      from: anchors.from,
      to: anchors.to,
      child: const Text('FLYING'),
    ).then((_) => done = true));

    await tester.pump();
    await tester.pump(ZenMotion.quick ~/ 2);
    expect(done, isFalse, reason: 'still in the air');

    await tester.pumpAndSettle();
    expect(done, isTrue);
  });

  testWidgets(
      '(c) reduce motion: no travelling overlay, the caller is still told',
      (WidgetTester tester) async {
    final _Anchors anchors = _Anchors();
    await tester.pumpWidget(_host(anchors.build(), reduceMotion: true));

    int arrivals = 0;
    bool done = false;
    unawaited(ZenFlight.to(
      context: tester.element(find.byKey(anchors.from)),
      from: anchors.from,
      to: anchors.to,
      onArrived: () => arrivals++,
      child: const Text('FLYING'),
    ).then((_) => done = true));

    // The documented contract: nothing travels, so there is no entry at all -
    // and therefore no ticker either.
    expect(ZenFlight.activeFlights, 0);
    expect(tester.binding.transientCallbackCount, 0);

    await tester.pump();
    await tester.pump();

    expect(find.text('FLYING'), findsNothing, reason: 'no overlay was drawn');
    expect(ZenFlight.activeFlights, 0);
    expect(tester.binding.transientCallbackCount, 0,
        reason: 'a reduced-motion flight must not tick');
    expect(arrivals, 1, reason: 'the behaviour survives even when motion does not');
    expect(done, isTrue);
    expect(tester.takeException(), isNull);
  });

  testWidgets('an anchor that is off screen settles instead of throwing',
      (WidgetTester tester) async {
    final _Anchors anchors = _Anchors();
    await tester.pumpWidget(_host(anchors.build()));

    int arrivals = 0;
    bool done = false;
    unawaited(ZenFlight.to(
      context: tester.element(find.byKey(anchors.from)),
      from: GlobalKey(), // never mounted
      to: anchors.to,
      onArrived: () => arrivals++,
      child: const Text('FLYING'),
    ).then((_) => done = true));

    expect(ZenFlight.activeFlights, 0);
    await tester.pump();
    await tester.pump();

    expect(find.text('FLYING'), findsNothing);
    expect(arrivals, 1);
    expect(done, isTrue);
    expect(tester.takeException(), isNull);
  });

  // --- The real site: a word added from the deck picker ----------------------

  testWidgets('adding from the picker flies the card and still saves once',
      (WidgetTester tester) async {
    // The picker's rows read the app settings (through `TranslatedDefinition`),
    // which need real preferences - the app itself overrides this at bootstrap.
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    final ProviderContainer container = ProviderContainer(
      overrides: <Override>[
        sharedPreferencesProvider.overrideWithValue(preferences),
        flashcardControllerProvider.overrideWith(_CountingFlashcardController.new),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          localizationsDelegates: <LocalizationsDelegate<dynamic>>[
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: DeckCardPickerScreen(deckId: 'deck-id', deckName: 'Favoris'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // The picker lists the word once, and no flight is in the air yet.
    expect(find.text('學'), findsOneWidget);
    expect(ZenFlight.activeFlights, 0);

    await tester.tap(find.byIcon(Icons.add_circle_outline));
    await tester.pump();

    // The row is still there (ZenExit has not finished) and the card that is
    // flying is a second copy of the word, on the overlay.
    expect(ZenFlight.activeFlights, 1, reason: 'the card took off');
    expect(find.text('學'), findsNWidgets(2), reason: 'the flying copy is drawn');

    // The row leaves, the add is committed, the card lands: exactly one save,
    // one flight, and no trace of either left on screen.
    await tester.pumpAndSettle();

    final _CountingFlashcardController controller = container
        .read(flashcardControllerProvider.notifier) as _CountingFlashcardController;
    expect(ZenFlight.activeFlights, 0, reason: 'the card landed');
    expect(find.text('學'), findsNothing, reason: 'the row left the picker');
    expect(controller.saves, 1, reason: 'the word is saved exactly once');
    expect(controller.saved!.deckId, 'deck-id');
    expect(tester.takeException(), isNull);

    // The ZenToast that confirms the add holds a dwell timer; let it run out so
    // the test does not end with a pending timer.
    await tester.pump(ZenMotion.toast);
    await tester.pumpAndSettle();
  });
}
