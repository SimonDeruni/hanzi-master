import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/shared/widgets/quick_look_positioning.dart';
import 'package:hanzi_master/shared/widgets/tappable_hanzi_text.dart';

void main() {
  test('positions below an anchor in the upper half', () {
    final layout = calculateQuickLookPopoverLayout(
      viewportSize: const Size(800, 900),
      safePadding: EdgeInsets.zero,
      anchorRect: const Rect.fromLTWH(380, 100, 40, 30),
    );

    expect(layout, isNotNull);
    expect(layout!.isAboveAnchor, isFalse);
    expect(layout.top, 138);
  });

  test('positions above an anchor near the bottom', () {
    final layout = calculateQuickLookPopoverLayout(
      viewportSize: const Size(800, 900),
      safePadding: EdgeInsets.zero,
      anchorRect: const Rect.fromLTWH(380, 760, 40, 30),
    );

    expect(layout, isNotNull);
    expect(layout!.isAboveAnchor, isTrue);
    expect(layout.top, isNull);
    expect(layout.bottom, 148);
    expect(900 - layout.bottom!, 752);
  });

  test('clamps the popover inside horizontal safe margins', () {
    final layout = calculateQuickLookPopoverLayout(
      viewportSize: const Size(600, 900),
      safePadding: const EdgeInsets.only(left: 20, right: 10),
      anchorRect: const Rect.fromLTWH(0, 100, 20, 20),
    );

    expect(layout, isNotNull);
    expect(layout!.left, 32);
    expect(layout.left + layout.width, lessThanOrEqualTo(578));
  });

  test('falls back for large accessibility text', () {
    final layout = calculateQuickLookPopoverLayout(
      viewportSize: const Size(800, 900),
      safePadding: EdgeInsets.zero,
      anchorRect: const Rect.fromLTWH(380, 100, 40, 30),
      textScaleFactor: 1.5,
    );

    expect(layout, isNull);
  });

  test('falls back when neither side has enough vertical room', () {
    final layout = calculateQuickLookPopoverLayout(
      viewportSize: const Size(800, 500),
      safePadding: EdgeInsets.zero,
      anchorRect: const Rect.fromLTWH(380, 235, 40, 30),
    );

    expect(layout, isNull);
  });

  test('respects top safe area inset and margin when positioning above anchor', () {
    final layout = calculateQuickLookPopoverLayout(
      viewportSize: const Size(400, 844),
      safePadding: const EdgeInsets.only(top: 47, bottom: 34),
      anchorRect: const Rect.fromLTWH(180, 500, 40, 30),
    );

    expect(layout, isNotNull);
    expect(layout!.isAboveAnchor, isTrue);
    // Highest point the card could reach if expanded to maxHeight:
    final topEdge = (500 - 8) - layout.maxHeight;
    // Must be at or below safePadding.top + 16.0 (47 + 16 = 63)
    expect(topEdge, greaterThanOrEqualTo(63.0));
  });

  test('dynamically flips below when tapped in upper 45% of viewport', () {
    final layout = calculateQuickLookPopoverLayout(
      viewportSize: const Size(800, 900),
      safePadding: const EdgeInsets.only(top: 47, bottom: 34),
      anchorRect: const Rect.fromLTWH(380, 350, 40, 30),
    );

    expect(layout, isNotNull);
    expect(layout!.isAboveAnchor, isFalse);
    expect(layout.top, 388); // 380 + 8
    expect(layout.bottom, isNull);
  });

  testWidgets('TappableHanziText creates recognizers for CJK characters',
      (tester) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: TappableHanziText('Hello 功 test'),
      ),
    );

    final richTextFinder = find.byType(RichText);
    expect(richTextFinder, findsOneWidget);

    final richText = tester.widget<RichText>(richTextFinder);
    final spans = (richText.text as TextSpan).children!;
    expect(spans.length, 3);

    final charSpan = spans[1] as TextSpan;
    expect(charSpan.text, '功');
    expect(charSpan.recognizer, isNotNull);
  });

  testWidgets('TappableMarkdownHanziText creates recognizers for CJK characters in markdown',
      (tester) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: TappableMarkdownHanziText('**重点** 功 `code`'),
      ),
    );

    final richTextFinder = find.byType(RichText);
    expect(richTextFinder, findsOneWidget);

    final richText = tester.widget<RichText>(richTextFinder);
    final spans = (richText.text as TextSpan).children!;
    expect(spans.isNotEmpty, isTrue);

    final hanziSpans = spans.whereType<TextSpan>().where((s) => s.text == '功');
    expect(hanziSpans, isNotEmpty);
    expect(hanziSpans.first.recognizer, isNotNull);
  });
}

