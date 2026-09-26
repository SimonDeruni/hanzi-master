import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/shared/widgets/zen_assembly.dart';

/// A real decomposition from `assets/data/hanzi_metadata.json`, which stores
/// `明` as `⿰日月`: the radical `日` plus the component `月`.
const List<String> _parts = <String>['日', '月'];
const String _composed = '明';

/// Hosts [child] with the platform "Reduce Motion" flag controllable.
///
/// The override goes through `MaterialApp.builder` rather than wrapping the
/// whole app: `MaterialApp` installs its own `MediaQuery`, so an outer one would
/// be discarded and the flag would silently read as false.
Widget _host(Widget child, {bool reduceMotion = false}) => MaterialApp(
      builder: (BuildContext context, Widget? inner) => MediaQuery(
        data: MediaQuery.of(context).copyWith(disableAnimations: reduceMotion),
        child: inner!,
      ),
      home: Scaffold(body: Center(child: child)),
    );

Widget _assembly() => const ZenAssembly(parts: _parts, composed: _composed);

/// Opacity of the [Opacity] that wraps [glyph] - its nearest ancestor.
double _inkOf(WidgetTester tester, String glyph) => tester
    .widget<Opacity>(find
        .ancestor(of: find.text(glyph), matching: find.byType(Opacity))
        .first)
    .opacity;

void main() {
  testWidgets('(a) the parts lay out, fly to their slots, then the composed '
      'glyph appears', (WidgetTester tester) async {
    await tester.pumpWidget(_host(_assembly()));

    // Frame one: both parts are laid out, each at its own starting offset, and
    // the composed glyph is not visible yet.
    expect(find.text('日'), findsOneWidget);
    expect(find.text('月'), findsOneWidget);
    expect(tester.getSize(find.text('日')).width, greaterThan(0),
        reason: 'the part must be laid out, not just present');
    expect(tester.getSize(find.text('月')).width, greaterThan(0));
    expect(_inkOf(tester, _composed), 0.0,
        reason: 'the answer must not be on screen before the parts land');

    final Offset startFirst = tester.getCenter(find.text('日'));
    final Offset startSecond = tester.getCenter(find.text('月'));
    expect(startFirst, isNot(startSecond),
        reason: 'each part flies in from its own offset');

    await tester.pumpAndSettle();

    // The parts have settled side by side, in reading order, and have travelled
    // to get there.
    final Offset endFirst = tester.getCenter(find.text('日'));
    final Offset endSecond = tester.getCenter(find.text('月'));
    expect(endFirst.dx, lessThan(endSecond.dx),
        reason: 'the parts read left to right');
    expect(endSecond.dx - endFirst.dx, greaterThan(40),
        reason: 'each part holds its own slot');
    expect((endFirst - startFirst).distance, greaterThan(20));
    expect((endSecond - startSecond).distance, greaterThan(20));

    // ...and only then has the composed glyph arrived.
    expect(_inkOf(tester, _composed), 1.0);
  });

  testWidgets('(b) a ticker runs on mount and is 0 once it has settled',
      (WidgetTester tester) async {
    await tester.pumpWidget(_host(_assembly()));

    expect(tester.binding.transientCallbackCount, greaterThan(0),
        reason: 'the assembly is running right after mount');

    await tester.pumpAndSettle();

    expect(tester.binding.transientCallbackCount, 0);
    expect(_inkOf(tester, _composed), 1.0);

    // It plays once and stops: no replay, no residue.
    await tester.pumpAndSettle();
    expect(_inkOf(tester, _composed), 1.0);
    expect(tester.binding.transientCallbackCount, 0);
  });

  testWidgets('(c) no painted frame throws while the parts fly',
      (WidgetTester tester) async {
    await tester.pumpWidget(_host(_assembly()));
    expect(tester.takeException(), isNull, reason: 'first frame');

    for (int frame = 0; frame < 20; frame++) {
      await tester.pump(const Duration(milliseconds: 50));
      expect(tester.takeException(), isNull, reason: 'frame $frame');
    }

    expect(_inkOf(tester, _composed), 1.0);
    expect(tester.binding.transientCallbackCount, 0);
  });

  testWidgets('(d) reduce motion paints the composed glyph on the first frame '
      'with no ticker', (WidgetTester tester) async {
    await tester.pumpWidget(_host(_assembly(), reduceMotion: true));

    // Present, laid out and painted by the very first frame - before any
    // further pump.
    expect(find.text(_composed), findsOneWidget);
    expect(tester.getSize(find.text(_composed)).width, greaterThan(0),
        reason: 'the composed glyph must be laid out on frame one');
    expect(tester.binding.transientCallbackCount, 0,
        reason: 'reduce motion must not start a ticker');
    expect(find.text('日'), findsNothing,
        reason: 'the parts are already merged into the end state');

    // And nothing is deferred to a later frame.
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.text(_composed), findsOneWidget);
    expect(tester.binding.transientCallbackCount, 0);
  });

  testWidgets('the layout holds for any part count',
      (WidgetTester tester) async {
    for (final List<String> parts in <List<String>>[
      <String>['日'],
      <String>['日', '月'],
      <String>['日', '月', '木'],
      <String>['日', '月', '木', '水'],
    ]) {
      await tester.pumpWidget(_host(ZenAssembly(parts: parts, composed: _composed)));
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull, reason: '$parts threw');
      expect(_inkOf(tester, _composed), 1.0, reason: '$parts never composed');
      for (final String part in parts) {
        expect(find.text(part), findsOneWidget, reason: '$part went missing');
      }
    }
  });
}
