/// The chat motion kit — the entrance and the typing dots now shared by the
/// Bureau du savant and the Echo Hall roleplay transcripts.
///
/// Two rules matter more than the animation itself:
///
///  1. **An entrance plays exactly once per bubble.** A `SliverList` recycles the
///     elements it scrolls past, so `animate: false` has to rest at the end state
///     — otherwise every message fades in again on the way back up a transcript.
///     The same flag is what makes a delayed entrance safe: the wait is a
///     cancellable timer, so a bubble disposed mid-stagger leaves nothing behind.
///  2. **Reduced motion means no travel and no pulse.** The platform flag parks
///     the entrance at its end state and holds every dot visible, instead of
///     running a perpetual cycle.
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';
import 'package:hanzi_master/shared/widgets/chat_motion.dart';

/// [child] in the minimum app scaffold, with the platform "Reduce Motion" flag
/// controllable — the same harness `motion_accessibility_test.dart` uses.
Widget _host(Widget child, {bool reduceMotion = false}) {
  return MediaQuery(
    data: MediaQueryData(disableAnimations: reduceMotion),
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: MaterialApp(home: Scaffold(body: Center(child: child))),
    ),
  );
}

/// The entrance's own fade. Scoped to the widget because the route transition is
/// a `FadeTransition`/`SlideTransition` pair as well.
Finder _inside() => find.descendant(
      of: find.byType(ChatMessageEntrance),
      matching: find.byType(FadeTransition),
    );

double _fade(WidgetTester tester) =>
    tester.widget<FadeTransition>(_inside()).opacity.value;

double _lift(WidgetTester tester) => tester
    .widget<SlideTransition>(find.descendant(
      of: find.byType(ChatMessageEntrance),
      matching: find.byType(SlideTransition),
    ))
    .position
    .value
    .dy;

/// Every dot's alpha, read off its decoration.
List<double> _dotAlphas(WidgetTester tester) => tester
    .widgetList<Container>(find.descendant(
      of: find.byType(ChatTypingDots),
      matching: find.byType(Container),
    ))
    .map((Container c) => (c.decoration! as BoxDecoration).color!.a)
    .toList();

void main() {
  group('ChatMessageEntrance', () {
    testWidgets('rises a bubble into place and reports it once', (tester) async {
      int entered = 0;
      await tester.pumpWidget(_host(ChatMessageEntrance(
        onEntered: () => entered++,
        child: const Text('你好'),
      )));

      // Frame zero: transparent and lifted, i.e. the entrance is under way.
      expect(_fade(tester), 0.0);
      expect(_lift(tester), greaterThan(0));

      await tester.pump(ZenMotion.entrance);
      expect(_fade(tester), 1.0);
      expect(_lift(tester), 0.0);
      expect(entered, 1, reason: 'This is where the caller memoises the id');
    });

    testWidgets('rests at the end state when it has already played',
        (tester) async {
      // What a recycled transcript row does: it must not fade in a second time.
      await tester.pumpWidget(_host(const ChatMessageEntrance(
        animate: false,
        child: Text('你好'),
      )));

      expect(_fade(tester), 1.0);
      expect(_lift(tester), 0.0);
    });

    testWidgets('a delayed entrance still arrives', (tester) async {
      await tester.pumpWidget(_host(const ChatMessageEntrance(
        delay: ZenMotion.beat,
        child: Text('你好'),
      )));
      expect(_fade(tester), 0.0, reason: 'Still waiting out its stagger');

      await tester.pump(ZenMotion.beat);
      await tester.pump(ZenMotion.entrance);
      expect(_fade(tester), 1.0);
    });

    testWidgets('reduced motion parks it at the end state', (tester) async {
      await tester.pumpWidget(_host(
        const ChatMessageEntrance(child: Text('你好')),
        reduceMotion: true,
      ));

      expect(_fade(tester), 1.0, reason: 'No travel under Reduce Motion');
      expect(_lift(tester), 0.0);
    });
  });

  group('ChatTypingDots', () {
    testWidgets('breathes three dots out of phase', (tester) async {
      await tester.pumpWidget(_host(const ChatTypingDots()));
      await tester.pump(const Duration(milliseconds: 120));

      final List<double> alphas = _dotAlphas(tester);
      expect(alphas.length, 3);
      expect(alphas.toSet().length, greaterThan(1),
          reason: 'The stagger is what makes it read as writing, not as a '
              'row of three identical dots');

      // Tear the ticker down before the test ends.
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
    });

    testWidgets('reduced motion holds every dot visible', (tester) async {
      await tester.pumpWidget(
          _host(const ChatTypingDots(), reduceMotion: true));
      await tester.pump(const Duration(milliseconds: 600));

      expect(_dotAlphas(tester).every((double a) => a == 1.0), isTrue);
    });
  });
}
