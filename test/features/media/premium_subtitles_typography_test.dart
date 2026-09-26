/// The video subtitle typography ramp (Phase 3, items #50 / #44 of
/// `docs/IPAD_ADAPTIVE_PLAN.md`): a tablet sits further from the eye than a
/// phone, so the three subtitle lines grow with the window class instead of
/// being fixed at 36 / 22 / 16pt at every viewing distance.
///
/// `PremiumSubtitlesOverlay` takes plain data (no providers, no plugins), so
/// unlike the heavy media screens this is a **behavioural** widget test: it
/// pumps the real overlay at a phone and at an iPad and reads the resolved
/// `TextStyle`s back out of the tree.
@Tags(<String>['ipad-sweep'])
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/media/domain/models/video_transcript.dart';
import 'package:hanzi_master/features/media/presentation/widgets/premium_subtitles_overlay.dart';

VideoTranscript _transcript() => VideoTranscript(
      videoId: 'v1',
      lines: <TranscriptLine>[
        TranscriptLine(
          text: '你好',
          pinyin: 'nǐ hǎo',
          start: Duration.zero,
          duration: const Duration(seconds: 2),
          translation: 'hello',
        ),
      ],
    );

Future<void> _pumpAt(WidgetTester tester, Size size) async {
  tester.view.devicePixelRatio = 1.0;
  tester.view.physicalSize = size;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: PremiumSubtitlesOverlay(
            transcript: _transcript(),
            currentIndex: 0,
            currentPosition: const Duration(milliseconds: 1500),
            onWordTapped: (String _) {},
            showHanzi: true,
            showPinyin: true,
            showEnglish: true,
          ),
        ),
      ),
    ),
  );
  await tester.pump();
}

/// The resolved size of the first `Text` whose data is [text].
double _fontSizeOf(WidgetTester tester, String text) {
  final Text widget = tester.widget<Text>(find.text(text).first);
  final TextStyle style = widget.style!;
  return style.fontSize!;
}

void main() {
  testWidgets('a phone keeps the original subtitle sizes',
      (WidgetTester tester) async {
    await _pumpAt(tester, const Size(390, 844));

    expect(_fontSizeOf(tester, '你'), 36);
    expect(_fontSizeOf(tester, 'nǐ hǎo'), 22);
    expect(_fontSizeOf(tester, 'hello'), 16);
  });

  testWidgets('an iPad scales all three lines up for viewing distance',
      (WidgetTester tester) async {
    await _pumpAt(tester, const Size(1024, 1366));

    expect(_fontSizeOf(tester, '你'), 44);
    expect(_fontSizeOf(tester, 'nǐ hǎo'), 26);
    expect(_fontSizeOf(tester, 'hello'), 18);
  });

  testWidgets('the ramp is monotonic across the breakpoints',
      (WidgetTester tester) async {
    final List<double> sizes = <double>[];
    for (final Size size in <Size>[
      const Size(390, 844), // compact
      const Size(744, 1133), // medium — a small tablet / split view
      const Size(1366, 1024), // large — 12.9" landscape
    ]) {
      await _pumpAt(tester, size);
      sizes.add(_fontSizeOf(tester, '你'));
    }

    expect(sizes, <double>[36, 40, 44],
        reason: 'Subtitle size must never shrink as the window grows');
  });
}
