/// The roleplay launcher — what you get after tapping a scenario card, where you
/// choose between a voice call and a text chat.
///
/// Two rules are pinned here:
///
///  1. **The choice is legible.** Each mode is a full-width card carrying a
///     one-line description, so "Voice Call" and "Text Chat" no longer read as two
///     interchangeable pills with no explanation of the difference.
///  2. **On an iPad it is a side desk, not a stretched phone sheet.** At expanded
///     the launcher slides in from the trailing edge — the reason `zenSidePanel`
///     exists next to `zenSheet`/`zenDialog`/`zenPicker`. A phone keeps the bottom
///     sheet, an iPad keeps the catalogue visible beside the choice.
library;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';
import 'package:hanzi_master/features/echo_hall/presentation/screens/scenario_selection_screen.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

void main() {
  Future<void> openLauncher(WidgetTester tester, Size size) async {
    // The view API, not `binding.setSurfaceSize`: the latter no longer reaches
    // MediaQuery on Flutter 3.38 — and this whole test turns on the window class.
    tester.view.devicePixelRatio = 1.0;
    tester.view.physicalSize = size;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: AppTheme.lightTheme,
          locale: const Locale('en'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: const ScenarioSelectionScreen(showBackButton: false),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final Finder card = find.text('Tap to roleplay').first;
    await tester.ensureVisible(card);
    await tester.pumpAndSettle();
    await tester.tap(card);

    // Deliberately not `pumpAndSettle`: the launcher's persona halo breathes
    // forever, so the tree never settles. Step the sheet/panel transition and the
    // content entrance by hand instead.
    await tester.pump();
    await tester.pump(ZenMotion.page);
    await tester.pump(ZenMotion.entrance);
  }

  /// Tears the tree down so the halo's ticker is disposed before the test ends.
  Future<void> dismiss(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  }

  /// The "Voice Call" choice card: the innermost `Container` around its title.
  Rect voiceCard(WidgetTester tester) => tester.getRect(
        find
            .ancestor(
              of: find.text('Voice Call'),
              matching: find.byType(Container),
            )
            .first,
      );

  testWidgets('both modes are offered as described cards', (tester) async {
    await openLauncher(tester, const Size(390, 844));

    expect(find.text('Voice Call'), findsOneWidget);
    expect(find.text('Text Chat'), findsOneWidget);
    expect(find.text('Immersive roleplay with AI avatars'), findsOneWidget,
        reason: 'Each mode states what it is, not just its name');
    expect(find.text('Practice in Roleplay'), findsOneWidget);

    await dismiss(tester);
  });

  testWidgets('a phone keeps the bottom sheet', (tester) async {
    await openLauncher(tester, const Size(390, 844));

    expect(find.byType(BottomSheet), findsOneWidget);
    expect(voiceCard(tester).left, lessThan(100),
        reason: 'A sheet spans the window, so the card starts at the gutter');

    await dismiss(tester);
  });

  testWidgets('an iPad opens the launcher as a trailing-edge panel',
      (tester) async {
    await openLauncher(tester, const Size(1024, 1366));

    expect(find.byType(BottomSheet), findsNothing,
        reason: 'A full-width sheet along the bottom of a 1024dp iPad reads as a '
            'stretched phone');
    expect(find.byType(Dialog), findsNothing,
        reason: 'Not a centred form sheet either — it sits beside the content');

    final Rect rect = voiceCard(tester);
    expect(rect.left, greaterThan(500),
        reason: 'The panel is anchored to the trailing edge');
    expect(rect.right, lessThanOrEqualTo(1024));
    expect(rect.width, lessThan(420),
        reason: 'Width-capped, so the two choices keep a readable measure');

    await dismiss(tester);
  });
}
