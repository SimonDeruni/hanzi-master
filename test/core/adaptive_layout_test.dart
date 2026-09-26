/// Behavioural tests for the adaptive layout kit (F3-F5 of
/// `docs/IPAD_ADAPTIVE_PLAN.md`).
///
/// These pin the contract every screen will rely on: the phone layout must stay
/// exactly as it is, and the tablet layout must actually appear above 600dp.
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/layout/zen_adaptive_scaffold.dart';
import 'package:hanzi_master/core/layout/zen_layout.dart';
import 'package:hanzi_master/core/layout/zen_two_pane.dart';
import 'package:hanzi_master/shared/widgets/zen_overlay.dart';

Future<void> _pumpAt(WidgetTester tester, Size size, Widget child) async {
  // The view API, not `binding.setSurfaceSize` (see locale_layout_harness.dart:
  // setSurfaceSize no longer reaches MediaQuery on Flutter 3.38).
  tester.view.devicePixelRatio = 1.0;
  tester.view.physicalSize = size;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(MaterialApp(home: child));
  await tester.pumpAndSettle();
}

void main() {
  group('ZenWindow', () {
    testWidgets('resolves the class from the real window', (tester) async {
      late ZenWindow phone;
      late ZenWindow tablet;
      await _pumpAt(
        tester,
        const Size(390, 844),
        Builder(builder: (BuildContext context) {
          phone = ZenWindow.of(context);
          return const SizedBox.shrink();
        }),
      );
      await _pumpAt(
        tester,
        const Size(1024, 1366),
        Builder(builder: (BuildContext context) {
          tablet = ZenWindow.of(context);
          return const SizedBox.shrink();
        }),
      );

      expect(phone.windowClass, ZenWindowClass.compact);
      expect(phone.useNavigationRail, isFalse,
          reason: 'phones keep the tab bar');
      expect(phone.isTablet, isFalse);

      expect(tablet.windowClass, ZenWindowClass.expanded);
      expect(tablet.useNavigationRail, isTrue);
      expect(tablet.useTwoPane, isTrue);
      expect(tablet.isTablet, isTrue);
      expect(tablet.isLandscape, isFalse);
    });

    testWidgets('landscape is decided by the window, not the device',
        (tester) async {
      late ZenWindow wide;
      await _pumpAt(
        tester,
        const Size(1366, 1024),
        Builder(builder: (BuildContext context) {
          wide = ZenWindow.of(context);
          return const SizedBox.shrink();
        }),
      );
      expect(wide.isLandscape, isTrue);
      expect(wide.windowClass, ZenWindowClass.large);
      expect(wide.gutter, 32);
    });

    test('the breakpoints sit on the documented boundaries', () {
      expect(ZenBreakpoints.classify(320), ZenWindowClass.compact);
      expect(ZenBreakpoints.classify(839.9), ZenWindowClass.medium);
      expect(ZenBreakpoints.classify(840), ZenWindowClass.expanded);
      expect(ZenBreakpoints.classify(1199.9), ZenWindowClass.expanded);
      expect(ZenBreakpoints.classify(1200), ZenWindowClass.large);
    });
  });

  group('ZenContentPane', () {
    testWidgets('caps the measure and applies the window gutter',
        (tester) async {
      late BoxConstraints inner;
      await _pumpAt(
        tester,
        const Size(1366, 1024),
        Scaffold(
          body: ZenContentPane(
            maxWidth: 300,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                inner = constraints;
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );

      // 300dp cap minus the large-window gutter (32) on both sides.
      expect(inner.maxWidth, 300 - 64);
    });

    testWidgets('an uncapped pane keeps the full width', (tester) async {
      late BoxConstraints inner;
      await _pumpAt(
        tester,
        const Size(1024, 1366),
        Scaffold(
          body: ZenContentPane(
            maxWidth: null,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                inner = constraints;
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );
      expect(inner.maxWidth, 1024 - 48);
    });
  });

  group('ZenTwoPaneScaffold', () {
    Widget twoPane({double? listWidth}) => Scaffold(
          body: ZenTwoPaneScaffold(
            listPane: const Text('list'),
            detailPane: const Text('detail'),
            emptyDetail: const Text('nothing selected'),
            listPaneWidth: listWidth,
          ),
        );

    testWidgets('is a single pane on a phone', (tester) async {
      await _pumpAt(tester, const Size(390, 844), twoPane());
      expect(find.text('list'), findsOneWidget);
      expect(find.text('detail'), findsNothing);
    });

    testWidgets('shows both panes on an iPad', (tester) async {
      await _pumpAt(tester, const Size(1024, 1366), twoPane());
      expect(find.text('list'), findsOneWidget);
      expect(find.text('detail'), findsOneWidget);
    });

    testWidgets('shows the empty state when nothing is selected',
        (tester) async {
      await _pumpAt(
        tester,
        const Size(1024, 1366),
        const Scaffold(
          body: ZenTwoPaneScaffold(
            listPane: Text('list'),
            emptyDetail: Text('nothing selected'),
          ),
        ),
      );
      expect(find.text('nothing selected'), findsOneWidget);
    });

    testWidgets('degrades to one pane when the detail would be squeezed',
        (tester) async {
      // Medium window, but the list asks for 300 of the 600 → the detail would
      // get 300, below ZenTwoPaneScaffold.detailMinWidth (320). A Split View
      // slice must not produce two unreadable columns.
      await _pumpAt(tester, const Size(600, 900), twoPane(listWidth: 300));
      expect(find.text('list'), findsOneWidget);
      expect(find.text('detail'), findsNothing);
    });
  });

  group('ZenNavigationRail', () {
    Widget rail({
      required ValueChanged<int> onSelected,
      Widget? footer,
    }) =>
        Scaffold(
          body: ZenNavigationRail(
            destinations: const <ZenDestination>[
              ZenDestination(
                icon: Icons.home_outlined,
                selectedIcon: Icons.home,
                label: 'Tableau de bord',
              ),
              ZenDestination(
                icon: Icons.menu_book_outlined,
                selectedIcon: Icons.menu_book,
                label: 'Bibliothèque',
              ),
            ],
            selectedIndex: 0,
            onDestinationSelected: onSelected,
            footer: footer,
          ),
        );

    testWidgets('renders localized destinations and a footer', (tester) async {
      await _pumpAt(
        tester,
        const Size(1024, 1366),
        rail(onSelected: (_) {}, footer: const Text('transport')),
      );
      expect(find.byType(NavigationRail), findsOneWidget);
      expect(find.text('Tableau de bord'), findsOneWidget);
      expect(find.text('Bibliothèque'), findsOneWidget);
      expect(find.text('transport'), findsOneWidget);
    });

    testWidgets('a tap reports the destination index', (tester) async {
      int? tapped;
      await _pumpAt(
        tester,
        const Size(1024, 1366),
        rail(onSelected: (int index) => tapped = index),
      );
      await tester.tap(find.text('Bibliothèque'));
      await tester.pumpAndSettle();
      expect(tapped, 1);
    });
  });

  group('zenSheet / zenDialog', () {
    Widget host() => Scaffold(
          body: Builder(
            builder: (BuildContext context) => TextButton(
              onPressed: () =>
                  zenSheet<void>(context, builder: (_) => const Text('body')),
              child: const Text('open'),
            ),
          ),
        );

    testWidgets('stays a bottom sheet on a phone', (tester) async {
      await _pumpAt(tester, const Size(390, 844), host());
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();
      expect(find.byType(BottomSheet), findsOneWidget);
      expect(find.byType(Dialog), findsNothing);
    });

    testWidgets('becomes a capped dialog on an iPad', (tester) async {
      await _pumpAt(tester, const Size(1024, 1366), host());
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();
      expect(find.byType(Dialog), findsOneWidget);
      expect(find.byType(BottomSheet), findsNothing);
    });

    testWidgets('a dialog body taller than the window is constrained',
        (tester) async {
      const Size window = Size(744, 1133);
      await _pumpAt(
        tester,
        window,
        Scaffold(
          body: Builder(
            builder: (BuildContext context) => TextButton(
              onPressed: () => zenDialog<void>(
                context,
                builder: (_) => const SizedBox(height: 4000),
              ),
              child: const Text('open'),
            ),
          ),
        ),
      );
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();
      expect(
        tester.getSize(find.byType(Dialog)).height,
        lessThanOrEqualTo(window.height),
        reason: 'A 4000dp body must be constrained to the window',
      );
    });
  });
}
