/// The study card's width cap — and the mastery seal that depends on it.
///
/// **The bug this guards.** `HankoSealStamp` is pinned 24dp from the card's
/// right edge (`SwipeableFlashcard`), and the whole card is rotated about its
/// *centre* while a swipe is in flight. With an uncapped card that corner is
/// ~450dp from the pivot on a 1024dp iPad but only ~150dp on a phone, so the
/// same tilt — up to 13.7° at the 120dp grade threshold — flung the seal clear
/// of the window on iPad, where the screen edge sliced it in half. The card now
/// uses `ZenContentWidth.study`, which was declared for exactly this surface and
/// had never been applied by anything.
///
/// `tester.getRect` reports each widget's *unrotated layout box*, so the
/// containment assertions below are a conservative proxy for what is painted —
/// they still fail on the uncapped card (the seal's layout box alone reached
/// x=1106 on a 1024dp window).
@Tags(<String>['ipad-sweep'])
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/layout/zen_layout.dart';
import 'package:hanzi_master/shared/widgets/hanko_seal_stamp.dart';
import 'package:hanzi_master/shared/widgets/swipeable_flashcard.dart';

/// The card's content, so its own width can be measured rather than the
/// gesture area's (which always fills the pane).
const Key _cardKey = Key('study-card-body');

Widget _host({required List<int> swiped}) => MaterialApp(
      home: Scaffold(
        body: SwipeableFlashcard(
          isSwipeEnabled: true,
          onSwiped: swiped.add,
          child: Container(key: _cardKey, color: const Color(0xFFFFFFFF)),
        ),
      ),
    );

Future<void> _pumpAt(
  WidgetTester tester,
  Size size, {
  List<int>? swiped,
}) async {
  tester.view.devicePixelRatio = 1.0;
  tester.view.physicalSize = size;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(_host(swiped: swiped ?? <int>[]));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('an iPad caps the study card and centres it', (tester) async {
    await _pumpAt(tester, const Size(1024, 1366));

    final Rect card = tester.getRect(find.byKey(_cardKey));
    expect(card.width, ZenContentWidth.study);
    expect(card.center.dx, closeTo(1024 / 2, 0.5));
    // Width only: the card still owns the pane's full height.
    expect(card.height, 1366);
  });

  testWidgets('a phone keeps the full width it always had', (tester) async {
    // The cap must be a no-op below it, or every phone layout would shift.
    await _pumpAt(tester, const Size(390, 844));

    expect(tester.getRect(find.byKey(_cardKey)).width, 390);
  });

  testWidgets('the Good seal stays inside the window at grading speed',
      (tester) async {
    const Size window = Size(1024, 1366);
    await _pumpAt(tester, window);

    // Held open mid-gesture: the seal is only on screen while the card is being
    // dragged, so the assertions have to happen before `up()`.
    final TestGesture gesture = await tester.startGesture(
      tester.getCenter(find.byKey(_cardKey)),
    );
    // Past the Good threshold (dx > 50) and into real grading territory
    // (dx > 120).
    await gesture.moveBy(const Offset(130, 0));
    await tester.pump();

    expect(
      find.byType(HankoSealStamp),
      findsOneWidget,
      reason: 'a right swipe past the threshold stamps GOOD',
    );

    final Rect seal = tester.getRect(find.byType(HankoSealStamp));
    expect(seal.left, greaterThanOrEqualTo(0.0),
        reason: 'the seal left the window on the left');
    expect(seal.right, lessThanOrEqualTo(window.width),
        reason: 'the seal was sliced by the right edge — the reported bug');
    expect(seal.top, greaterThanOrEqualTo(0.0),
        reason: 'the seal left the window at the top');

    await gesture.up();
    await tester.pumpAndSettle();
    // `_onPanEnd` awaits a 90ms "let the seal land" delay before sliding the
    // card off; without this the test ends with that timer pending. Same dance
    // as `deck_review_session_resume_test`.
    await tester.pump(const Duration(milliseconds: 120));
    await tester.pumpAndSettle();
  });
}
