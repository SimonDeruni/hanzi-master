import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Guards the reader's transient notices.
///
/// **The bug:** the "Resumed: Ch.4/120, Sent.1/228" banner was a Material
/// `SnackBar` — dark, hardcoded English, and owned by the **root**
/// `ScaffoldMessenger` rather than the reader route. Leaving the reader inside
/// its dwell left the banner on screen, re-parented onto the next Scaffold,
/// which reads as "a background service is still managing state".
void main() {
  late String source;

  setUpAll(() {
    source = File(
      'lib/features/reading/presentation/screens/book_reader_screen.dart',
    ).readAsStringSync().replaceAll('\r\n', '\n');
  });

  test('the reader raises no SnackBar of its own', () {
    expect(source, isNot(contains('showSnackBar')),
        reason: 'A root-messenger SnackBar outlives this route');
    expect(source, isNot(contains('SnackBar(')));
  });

  test('every reader notice goes through ZenToast', () {
    expect(RegExp(r'ZenToast\.').allMatches(source).length,
        greaterThanOrEqualTo(4),
        reason:
            'Resume, playback failure, bookmark added and bookmark removed');
    expect(
        source,
        contains(
            "import 'package:hanzi_master/shared/widgets/zen_toast.dart';"));
  });

  test('the resume notice is localized, not English', () {
    // It used to print 'Resumed: Ch.$n/$total, Sent.$n/$total'.
    expect(source, isNot(contains("'Resumed: Ch.")));
    expect(source, contains('chapterXOfY('));
    expect(source, contains('sentenceXOfY('));
  });

  test('the deferred notice uses a motion token, not a magic timeout', () {
    expect(source, contains('Future<void>.delayed(ZenMotion.quick, () {'));
    expect(source, isNot(contains('Duration(milliseconds: 600)')));
  });

  test('dispose clears notices and stops the audio engines', () {
    expect(source, contains('_scaffoldMessenger?.clearSnackBars()'),
        reason: 'Nothing the reader raised may follow the user out');
    expect(source, contains('ScaffoldMessenger.maybeOf(context)'),
        reason: 'Captured before dispose, where context is defunct');
    expect(source, contains('!audio.isAudiobookLoaded'),
        reason: 'Inline playback is tied to this screen; a loaded background '
            'audiobook belongs to the shell\'s Now Playing bar');
    expect(source, contains('unawaited(audio.stop())'),
        reason: 'Audio engines are tied to this screen\'s lifecycle');
    expect(source, contains('unawaited(ambient.pause())'),
        reason: 'The ambient soundscape is reader-owned too');
    expect(source, contains('_persistProgress(repository: repository'),
        reason: 'The last position is written through the captured repository');
  });

  test('teardown never reads `ref`, which Riverpod has already revoked', () {
    // The bug: dispose's first `ref.read` threw ("Cannot use \"ref\" after the
    // widget was disposed"), so everything below it never ran — the inline
    // audio kept playing after the book was closed, the completion subscription
    // leaked and the scroll controller was never disposed.
    final int start = source.indexOf('void dispose() {');
    expect(start, greaterThan(-1), reason: 'dispose() not found');
    final int end = source.indexOf('\n  }\n', start);
    expect(end, greaterThan(start));
    final String body = source.substring(start, end);

    expect(body, isNot(contains('ref.')),
        reason: 'Dispose runs after `ref` is unusable; dependencies must be '
            'captured in didChangeDependencies');
    for (final captured in <String>['_bookRepository', '_audioService',
      '_zenAmbient']) {
      expect(source, contains('$captured = ref.read('),
          reason: '$captured must be captured while ref is alive');
      expect(body, contains(captured));
    }
    expect(source, contains('_scaffoldMessenger = ScaffoldMessenger.maybeOf('));
    expect(body, contains('_scaffoldMessenger'));
  });
}
