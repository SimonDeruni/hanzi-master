/// `zenSidePanel` — the fourth overlay helper, next to `zenSheet` / `zenDialog`
/// / `zenPicker` in `lib/shared/widgets/zen_overlay.dart`.
///
/// The three existing helpers all put a surface *over* the content: a sheet on a
/// phone, a centred form sheet on a tablet. That is right for a form. It is wrong
/// for a "what do you want to do with this" chooser — a centred dialog hides the
/// thing you are choosing about, and a full-width sheet along the bottom of a
/// 1024dp iPad reads as a stretched phone (the exact complaint this kit exists to
/// answer). So the panel docks to the trailing edge instead, full height, leaving
/// the list it came from visible beside the choice.
///
/// The phone must not regress: below *expanded* (an iPad, or a Split View half at
/// ≥840dp) it delegates to `zenSheet`, so those call sites stay bottom sheets.
library;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/ai_deck_generator_sheet.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/zen_overlay.dart';

void main() {
  /// Sets the window size through the view API: `setSurfaceSize` no longer
  /// reaches `MediaQuery` on Flutter 3.38, so the window class would never
  /// change and every case below would silently test the phone path.
  void sizeWindow(WidgetTester tester, Size size) {
    tester.view.devicePixelRatio = 1.0;
    tester.view.physicalSize = size;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  }

  Future<void> openPanel(WidgetTester tester, Size size) async {
    sizeWindow(tester, size);
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (BuildContext context) => Scaffold(
            body: Center(
              child: TextButton(
                onPressed: () => zenSidePanel<void>(
                  context,
                  builder: (_) => const SizedBox(
                    key: Key('panel-body'),
                    width: 420,
                    height: 200,
                  ),
                ),
                child: const Text('open'),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
  }

  group('zenSidePanel', () {
    testWidgets('is the usual bottom sheet on a phone', (tester) async {
      await openPanel(tester, const Size(390, 844));

      final Rect body = tester.getRect(find.byKey(const Key('panel-body')));
      expect(body.left, lessThan(1),
          reason: 'A bottom sheet is full width on a phone');
      expect(body.right, 390,
          reason: 'The sheet spans the window, so the 420dp cap cannot bind');
      expect(body.bottom, 844, reason: 'and it is anchored to the bottom edge');
    });

    testWidgets('slides in from the trailing edge at expanded', (tester) async {
      await openPanel(tester, const Size(1024, 1366));

      final Rect body = tester.getRect(find.byKey(const Key('panel-body')));
      expect(body.width, 420, reason: 'The panel is width-capped, not full');
      expect(body.right, 1024, reason: 'It is flush with the trailing edge');
      expect(body.left, 604,
          reason: 'So the content behind it stays visible on the other side');
      expect(body.left, greaterThan(512),
          reason: 'A side panel, not a centred dialog');
    });

    testWidgets('a Split View half keeps the sheet', (tester) async {
      // 700dp is a large phone or a half-screen iPad: still sheet territory, and
      // the case a width-only rule would have mis-classified as a tablet. The
      // switch is at *expanded* (≥840dp) because of exactly this.
      await openPanel(tester, const Size(700, 1024));

      expect(find.byType(BottomSheet), findsOneWidget,
          reason: 'A Split View half gets the platform idiom, not the panel');

      final Rect body = tester.getRect(find.byKey(const Key('panel-body')));
      expect(body.bottom, 1024, reason: 'Anchored to the bottom, not the side');
      expect(body.right, lessThan(700),
          reason: 'Centred inside the sheet rather than flush with an edge');
    });
  });

  test('the roleplay launcher opens through the side-panel helper', () {
    // A centred `zenDialog` or a bare `showModalBottomSheet` would put the phone
    // component back on the iPad; the Echo Hall launcher has to stay on
    // `zenSidePanel` so the window class keeps deciding the form. Guarded here
    // rather than only behaviourally, because the regression is a one-word edit.
    final String screen = File(
      'lib/features/echo_hall/presentation/screens/scenario_selection_screen.dart',
    ).readAsStringSync();

    expect(screen, contains('zenSidePanel('));
    expect(screen, isNot(contains('showModalBottomSheet(')),
        reason: 'Every transient surface goes through the overlay helpers');
  });

  group('the deck generator', () {
    test('opens through the side-panel helper on a tablet only', () {
      final String sheet = File(
        'lib/features/flashcards/presentation/widgets/ai_deck_generator_sheet.dart',
      ).readAsStringSync();

      expect(sheet, contains('zenSidePanel<void>('));
      expect(sheet, contains('ZenWindow.of(context).isExpanded'),
          reason: 'The window class decides the form, not the call site');
      expect(sheet, contains('GlobalBlurredBottomSheet.show('),
          reason: 'A phone keeps the blurred sheet it already had');
    });

    testWidgets('wears its own chrome inside the panel',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: Scaffold(
              body: SizedBox(
                height: 900,
                child: AiDeckGeneratorSheet(embedded: true),
              ),
            ),
          ),
        ),
      );
      await tester.pump();

      // `zenSidePanel`'s barrier is transparent on purpose, so the pane has to be
      // its own surface — without this chrome the form renders on nothing at all,
      // which is exactly what happened the first time it was docked.
      expect(
        find.byWidgetPredicate(
          (Widget widget) =>
              widget is Container &&
              widget.decoration is BoxDecoration &&
              (widget.decoration! as BoxDecoration).borderRadius ==
                  const BorderRadius.horizontal(left: Radius.circular(28)),
        ),
        findsOneWidget,
        reason: 'The docked pane is rounded on the edge it is docked to',
      );
    });
  });
}
