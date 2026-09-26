/// The writing bench (Part 2b of `docs/IPAD_ADAPTIVE_PLAN.md`): an iPad gets the
/// surface and the context side by side, a phone gets the same screen in one
/// column, and the session actually advances.
@Tags(<String>['ipad-sweep'])
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/review_stats.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_mode.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/writing_bench_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/drawing_canvas.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

import '../../support/locale_layout_harness.dart';

ReviewStats _calligraphyStats() => ReviewStats(
      nextReviewDate: DateTime(2026, 1, 1),
      interval: 3,
      easeFactor: 2.5,
      streak: 2,
      attempts: 4,
      successCount: 3,
      lastAttemptDate: DateTime(2026, 1, 1),
      introducedAt: DateTime(2025, 12, 1),
    );

Flashcard _card(String hanzi) => Flashcard(
      id: 'card-$hanzi',
      deckId: 'hsk1',
      hanzi: hanzi,
      pinyin: 'nán',
      definition: 'difficult',
      hskLevel: 2,
      // A real SVG path, so the canvas runs its normal drawing path.
      strokePaths: const <String>['M 200 200 L 800 800'],
      medianPaths: const <List<Offset>>[
        <Offset>[Offset(200, 200), Offset(800, 800)],
      ],
      modeStats: <StudyMode, ReviewStats>{
        StudyMode.calligraphy: _calligraphyStats(),
      },
    );

Widget _host(List<Flashcard> cards) => MaterialApp(
      theme: AppTheme.lightTheme,
      locale: const Locale('en'),
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: WritingBenchScreen(cards: cards, deckName: 'HSK 1'),
    );

Future<void> _pumpAt(
    WidgetTester tester, Size size, List<Flashcard> cards) async {
  tester.view.devicePixelRatio = 1.0;
  tester.view.physicalSize = size;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(_host(cards));
  await tester.pumpAndSettle();
}

/// The panel's stroke-order animation restarts itself four times a second
/// (`drawing_canvas`'s `_DelayedAnimationWidget` schedules a 2s `Future.delayed`
/// when each pass completes). A `Future.delayed` cannot be cancelled, so the tree
/// is disposed first and the orphaned timer is then *fired*: its callback checks
/// `mounted` and therefore schedules nothing new, which leaves the test with no
/// pending timers when the framework asserts `!timersPending`.
Future<void> _disposeBench(WidgetTester tester) async {
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pump(const Duration(seconds: 3));
}

void main() {
  testWidgets('an iPad shows the surface and the context pane together',
      (WidgetTester tester) async {
    await _pumpAt(
      tester,
      const Size(1024, 1366),
      <Flashcard>[_card('难'), _card('易')],
    );

    // The panel and the app bar both carry the title.
    expect(find.text('Practice Writing'), findsWidgets);
    // Session progress, straight from the panel.
    expect(find.text('1 / 2'), findsOneWidget);
    // Two canvases: the writing surface and the stroke-order panel character.
    expect(find.byType(DrawingCanvas), findsNWidgets(2));
    expectNoOverflow(tester, reason: 'iPad writing bench');

    await _disposeBench(tester);
  });

  testWidgets('a phone lays the same screen out in one column',
      (WidgetTester tester) async {
    await _pumpAt(
      tester,
      const Size(390, 844),
      <Flashcard>[_card('难'), _card('易')],
    );

    expect(find.text('Practice Writing'), findsWidgets);
    expect(find.text('1 / 2'), findsOneWidget);
    expect(find.byType(DrawingCanvas), findsNWidgets(2));
    expectNoOverflow(tester, reason: 'phone writing bench');

    await _disposeBench(tester);
  });

  testWidgets('the session advances and steps back',
      (WidgetTester tester) async {
    await _pumpAt(
      tester,
      const Size(1024, 1366),
      <Flashcard>[_card('难'), _card('易')],
    );

    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(find.text('2 / 2'), findsOneWidget);

    await tester.tap(find.text('Previous'));
    await tester.pumpAndSettle();
    expect(find.text('1 / 2'), findsOneWidget);

    await _disposeBench(tester);
  });

  testWidgets('a hardware keyboard drives the session',
      (WidgetTester tester) async {
    await _pumpAt(
      tester,
      const Size(1024, 1366),
      <Flashcard>[_card('难'), _card('易')],
    );
    expect(find.text('1 / 2'), findsOneWidget);

    // ⌘→ next card (Ctrl+→ carries the same binding for an Android tablet).
    await tester.sendKeyDownEvent(LogicalKeyboardKey.metaLeft);
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.metaLeft);
    await tester.pumpAndSettle();
    expect(find.text('2 / 2'), findsOneWidget);

    await tester.sendKeyDownEvent(LogicalKeyboardKey.metaLeft);
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowLeft);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.metaLeft);
    await tester.pumpAndSettle();
    expect(find.text('1 / 2'), findsOneWidget);

    await _disposeBench(tester);
  });

  testWidgets('the writing surface announces itself to screen readers',
      (WidgetTester tester) async {
    // The painters draw pixels, not text: without an explicit label the whole
    // surface would be invisible to VoiceOver and Switch Control.
    final SemanticsHandle handle = tester.ensureSemantics();
    await _pumpAt(
      tester,
      const Size(1024, 1366),
      <Flashcard>[_card('难')],
    );

    expect(find.bySemanticsLabel(RegExp('Practice Writing')), findsWidgets);
    expect(find.bySemanticsLabel(RegExp('难')), findsWidgets);
    expect(
      tester.getSemantics(find.byType(DrawingCanvas).first).value,
      // The number is locale-independent; the trailing word ("Strokes") is not.
      contains('0 / 1'),
      reason: 'the live stroke progress is announced, not just the label',
    );

    handle.dispose();
    await _disposeBench(tester);
  });

  testWidgets('an empty deck says so instead of showing an empty bench',
      (WidgetTester tester) async {
    await _pumpAt(tester, const Size(1024, 1366), <Flashcard>[]);

    expect(find.byType(DrawingCanvas), findsNothing);
    expect(find.text('Add some cards to this deck first!'), findsWidgets);
  });
}
