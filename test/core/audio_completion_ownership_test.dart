import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Who owns a finished sentence — the audiobook queue, or the caller that played
/// a single sentence (the reader, a voice preview)?
///
/// **The bug:** [`AudioService.playSentence`] clears `_audiobookActive` (it must:
/// the engine has to be able to take over from a background audiobook without
/// the shell losing it), and the completion handler branched on exactly that
/// cleared flag. So the *queue* path — the fullscreen player, the iPad desk, the
/// shell's Now Playing bar, none of which listen for the completion event —
/// never advanced past its first sentence, and any leftover queue state could
/// swallow the reader's own completion and leave it stuck on Phrase 1.
///
/// The routing decision cannot be driven from a widget test (it needs a real
/// `just_audio` engine to report a finished source), so — as with the desk and
/// toolbar sweeps — the wiring is pinned against source.
void main() {
  late String source;

  setUpAll(() {
    source = File('lib/core/services/audio_service.dart')
        .readAsStringSync()
        .replaceAll('\r\n', '\n');
  });

  /// The body of [signature]; `\n  }\n` is the method terminator, so a
  /// parameter list that ends in `}) async {` does not cut the body short.
  String function(String signature) {
    final int start = source.indexOf(signature);
    expect(start, greaterThan(-1), reason: '$signature not found');
    final int end = source.indexOf('\n  }\n', start);
    expect(end, greaterThan(start));
    return source.substring(start, end);
  }

  test('the completion handler branches on who asked for the sentence', () {
    final String body = function('void _handleEngineCompletion() {');
    expect(
      body,
      contains('if (_queueOwnsPlayback && _audiobookPlaying) {'),
      reason: 'The queue advances itself; everyone else is told',
    );
    expect(
      body,
      isNot(contains('if (_audiobookActive')),
      reason: '`playSentence` clears `_audiobookActive`, so branching on it '
          'routes every completion away from the queue',
    );
    expect(body, contains('_completeController.add(null)'),
        reason: 'A single-sentence caller waits for this event');
  });

  test('a single sentence is played through the same engine as a queue track',
      () {
    final String play = function('Future<bool> playSentence(');
    expect(play, contains('bool fromQueue = false,'),
        reason: 'Ownership is declared by the caller, not inferred');
    expect(play, contains('_queueOwnsPlayback = fromQueue;'));
    expect(play, contains('_audiobookActive = false;'),
        reason: 'Inline playback still takes the engine over from a background '
            'audiobook');
  });

  test('the queue marks its own sentences and lets go when it stops', () {
    expect(
      function('Future<bool> _playCurrentAudiobookTrack()')
          .contains('fromQueue: true'),
      isTrue,
      reason: 'The queue is the one caller that advances by itself',
    );
    expect(function('Future<void> stop()').contains('_queueOwnsPlayback = false'),
        isTrue);
  });
}
