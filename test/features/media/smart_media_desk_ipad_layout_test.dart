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
///
/// The desk embeds a YouTube iframe (a platform view), which a widget test cannot
/// render, so — like the reader and scanner guards — the layout decisions are
/// pinned in source.
///
/// **Not part of this change:** picture-in-picture. It needs native work
/// (`AVPictureInPictureController` plus a player that supports it — an iframe
/// cannot), and the AirPlay route picker alongside it.
@Tags(<String>['ipad-sweep'])
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

const String _path =
    'lib/features/media/presentation/screens/smart_media_desk_screen.dart';

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
      expect(expanded, contains('children: <Widget>[videoPane, controlPane]'));
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
}
