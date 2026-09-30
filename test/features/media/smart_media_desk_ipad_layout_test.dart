/// The media desk's landscape split (#44 of `docs/IPAD_ADAPTIVE_PLAN.md`).
///
/// On a tablet in landscape the desk stops stacking the video above a scrolling
/// transcript: the video keeps the **left** pane together with its transport, and
/// the AI prep + transcript take the **right**, so tapping a transcript line can
/// seek the video that is still on screen.
///
/// Two invariants make it safe:
///
///  1. **The phone branch is the old layout, expressed once.** `if (!split)`
///     returns the original `Column(videoPane, Expanded(contentPane),
///     controlPane)`; the gate is `context.zenWindow.isExpanded`, so a phone or a
///     medium window never sees the split.
///  2. **There is still exactly one `YoutubePlayer`.** The video and the content
///     were extracted into `_buildVideoPane()` / `contentPane` for the split, and
///     a duplicated player is the obvious way this could rot — so the guard
///     counts them.
///  3. **The player never takes the screen, and the subtitles ride on it.** The
///     package fullscreens itself when the device rotates (`autoFullScreen`) and
///     on a vertical drag; on an iPad that replaced the whole desk with a bare
///     letterboxed video — transcript, transport and subtitles gone, with no
///     control left to get back out. The desk switches both off, pulls the
///     player back out if it ever slips in (see
///     `_guardAgainstPlayerFullscreen`), and burns the app's own subtitles onto
///     the picture so the line is readable without looking away from the video.
///
/// The desk embeds a YouTube iframe (a platform view), which a widget test cannot
/// render, so — like the reader and scanner guards — the layout decisions are
/// pinned in source. The *caption* the stage carries is not an iframe, though, so
/// the last group here pumps the real [PremiumSubtitlesOverlay] into a 16:9
/// picture at the pane widths the split produces and checks it stays inside it.
///
/// **Not part of this change:** picture-in-picture. It needs native work
/// (`AVPictureInPictureController` plus a player that supports it — an iframe
/// cannot), and the AirPlay route picker alongside it.
@Tags(<String>['ipad-sweep'])
library;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/layout/zen_layout.dart';
import 'package:hanzi_master/features/media/domain/models/video_transcript.dart';
import 'package:hanzi_master/features/media/presentation/screens/smart_media_desk_screen.dart';
import 'package:hanzi_master/features/media/presentation/widgets/premium_subtitles_overlay.dart';

const String _path =
    'lib/features/media/presentation/screens/smart_media_desk_screen.dart';

/// The split's left pane: three fifths of the window, less the divider. Below
/// the split gate the video is as wide as the window instead.
double _paneWidth(double windowWidth) => windowWidth >= ZenBreakpoints.mediumMax
    ? (windowWidth - 1) * 3 / 5
    : windowWidth;

void main() {
  late String source;

  setUpAll(() {
    source = File(_path).readAsStringSync().replaceAll('\r\n', '\n');
  });

  group('media desk landscape split', () {
    test('is gated on the window class, never a raw width', () {
      expect(source, contains('final bool split = context.zenWindow.isExpanded;'));
      expect(
        RegExp(r'(width|shortestSide)\s*[><]=?\s*\d{3}').hasMatch(source),
        isFalse,
      );
    });

    test('a phone keeps the original column', () {
      expect(source, contains('if (!split) {'));
      expect(source, contains('Expanded(child: contentPane),'));
      expect(source, contains('            controlPane,\n          ],'));
    });

    test('the split puts the video and its transport beside the content', () {
      final int row = source.indexOf('return Row(', source.indexOf('if (!split)'));
      expect(row, greaterThan(-1));
      final String expanded = source.substring(row, source.indexOf('\n  }\n', row));
      expect(expanded, contains('flex: 3,'));
      expect(expanded, contains('Expanded(child: videoPane),'));
      expect(expanded, contains('controlPane,'));
      expect(expanded, contains('Expanded(flex: 2, child: contentPane)'));
      expect(expanded, contains('VerticalDivider'));
    });

    test('the player is extracted, and appears exactly once', () {
      expect(source, contains('Widget _buildVideoPane() {'));
      expect(source, contains('final Widget contentPane ='));
      expect(
        RegExp(r'YoutubePlayer\(').allMatches(source).length,
        1,
        reason: 'A second player is the obvious way this split could rot',
      );
    });
  });

  group('the player cannot take the screen', () {
    test('the package fullscreen is switched off at the widget', () {
      // Both default to true, and both are how the desk lost its screen: a
      // rotated iPad hit `didChangeMetrics` -> `enterFullScreen()` and the video
      // covered the transcript, the transport and the subtitles.
      expect(source, contains('autoFullScreen: false'));
      expect(source, contains('enableFullScreenOnVerticalDrag: false'));
    });

    test('a player that slips into fullscreen is pulled back out', () {
      expect(source, contains('void _guardAgainstPlayerFullscreen() {'));
      expect(source, contains('value.fullScreenOption.enabled'));
      expect(source, contains('exitFullScreen(lock: false)'));
      expect(source, contains('_fullscreenGuard?.cancel();'),
          reason: 'the guard subscription must not outlive the screen');
    });

    test('the picture keeps 16:9 inside a stage that fills the pane', () {
      expect(source, contains('aspectRatio: 16 / 9'));
      expect(source, contains('Expanded(child: videoPane),'),
          reason: 'the stage owns the leftover height, so the picture is '
              'centred in the pane instead of pinned to its top');
    });
  });

  group('the subtitles ride on the picture', () {
    test('they are built from the live transcript, above the tap blocker', () {
      expect(source,
          contains('_buildSubtitleOverlay(_transcript!, picture.biggest)'));
      expect(source, contains('PremiumSubtitlesOverlay('));
      expect(source, contains('showHanzi: true'));

      final int blocker =
          source.indexOf('// BLOCK TOUCHES TO YOUTUBE NATIVE CONTROLS');
      final int subtitles =
          source.indexOf('_buildSubtitleOverlay(_transcript!, picture.biggest)');
      expect(blocker, greaterThan(-1));
      expect(subtitles, greaterThan(blocker),
          reason: 'Behind the blocker a tap on a character would pause the '
              'video instead of reaching the caption');
    });

    test('the caption is budgeted against the picture it sits on', () {
      // The clip this prevents: three lines at 36pt on a 219dp phone picture are
      // taller than the picture, and a Stack clips from the top — the line the
      // learner is reading is the first thing to go.
      expect(source, contains('picture.height * kSubtitleHeightFactor'));
      expect(source, contains('fit: BoxFit.scaleDown'));
      expect(source,
          contains('_showEnglish && context.zenWindow.isAtLeastMedium'),
          reason: 'A compact picture can only carry the subtitle proper; the '
              'reading aids live in the pane below it at a legible size');
      expect(source,
          contains('_showPinyin && context.zenWindow.isAtLeastMedium'));
    });

    testWidgets('a long line fits the picture at every desk width',
        (WidgetTester tester) async {
      // The phone column, an iPad mini portrait (below the split gate), an iPad
      // Air portrait and a 12.9" landscape — the widths where the split fires
      // and the ones where it does not.
      for (final Size viewport in <Size>[
        const Size(390, 844),
        const Size(744, 1133),
        const Size(1024, 1366),
        const Size(1366, 1024),
      ]) {
        final Rect picture = await _pumpStage(tester, viewport);
        final Rect caption = _captionRect(tester);

        expect(
          picture.inflate(0.5).contains(caption.topLeft) &&
              picture.inflate(0.5).contains(caption.bottomRight),
          isTrue,
          reason: 'At $viewport the caption $caption must stay inside the '
              'picture $picture — a caption taller than the picture is clipped '
              'from the top, which is exactly the line being read',
        );
        expect(caption.height,
            lessThanOrEqualTo(picture.height * kSubtitleHeightFactor + 0.5),
            reason: 'At $viewport the caption may not cover the frame');
        expect(caption.center.dy, greaterThan(picture.center.dy),
            reason: 'The caption belongs to the bottom of the picture');
      }
    });
  });
}

/// Pumps the desk's stage at [viewport]: a 16:9 picture in the left pane, with
/// the real caption pinned to its bottom exactly the way
/// `_buildSubtitleOverlay` pins it — same paddings, same height budget, same
/// translation rule. Returns the picture's rect.
Future<Rect> _pumpStage(WidgetTester tester, Size viewport) async {
  tester.view.devicePixelRatio = 1.0;
  tester.view.physicalSize = viewport;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  final double pane = _paneWidth(viewport.width);
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
            key: const ValueKey<String>('picture'),
            width: pane,
            height: pane * 9 / 16,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints picture) => Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  const ColoredBox(color: Colors.black),
                  _caption(context, picture.biggest, pane),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pump();

  return tester.getRect(find.byKey(const ValueKey<String>('picture')));
}

/// The caption as `_buildSubtitleOverlay` builds it, for a picture of [size] in
/// a pane [pane] wide.
Widget _caption(BuildContext context, Size size, double pane) {
  final double captionWidth =
      (pane - 32).clamp(0.0, kSubtitleMaxWidth).toDouble();
  return Positioned(
    left: 0,
    right: 0,
    bottom: 0,
    child: Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom:
            zenValue<double>(context, compact: 10, medium: 14, expanded: 18),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: captionWidth,
            maxHeight: size.height * kSubtitleHeightFactor,
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.bottomCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: captionWidth),
              child: PremiumSubtitlesOverlay(
                transcript: _longLineTranscript(),
                currentIndex: 0,
                currentPosition: const Duration(milliseconds: 900),
                onWordTapped: (String _) {},
                showHanzi: true,
                showPinyin: ZenWindow.of(context).isAtLeastMedium,
                showEnglish: ZenWindow.of(context).isAtLeastMedium,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

/// A realistic long subtitle: it wraps, which is where a caption that does not
/// fit the picture shows up.
VideoTranscript _longLineTranscript() => VideoTranscript(
      videoId: 'v1',
      lines: <TranscriptLine>[
        TranscriptLine(
          text: '这是我最喜欢的地方，北京的胡同',
          pinyin: _pinyin,
          start: Duration.zero,
          duration: const Duration(seconds: 4),
          translation: _translation,
        ),
      ],
    );

/// The caption's own box, as the union of the lines it draws. A compact window
/// carries the hanzi line only — the pinyin and the translation are in the pane
/// below it — so those two are optional here.
Rect _captionRect(WidgetTester tester) => <Rect>[
      tester.getRect(find.text('是').first), // a character of the hanzi line
      if (find.text(_pinyin).evaluate().isNotEmpty)
        tester.getRect(find.text(_pinyin)),
      if (find.text(_translation).evaluate().isNotEmpty)
        tester.getRect(find.text(_translation)),
    ].reduce((Rect a, Rect b) => a.expandToInclude(b));

const String _pinyin =
    'zhè shì wǒ zuì xǐ huan de dì fang, běi jīng de hú tòng';
const String _translation =
    'This is my favourite place, the hutongs of Beijing';
