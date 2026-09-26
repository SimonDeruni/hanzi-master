/// The iPad **listen-and-read desk** (`listen_and_read_screen.dart`), and the two
/// things that must stay true about it (Part 2b of `docs/IPAD_ADAPTIVE_PLAN.md`):
///
///  1. **The audio is the clock.** The text pane is re-keyed on a *chapter*
///     change (and on an explicit follow press) — never per sentence, because
///     re-keying per sentence would reset the reader's scroll while the learner
///     is reading.
///  2. **The iPhone path is unchanged.** `_switchToReadingMode` still stops
///     playback and `pushReplacement`s the plain reader when the window is not
///     expanded; the desk is reachable *only* from the expanded branch.
///
/// The desk and its two panes need Hive boxes, the book repository and an audio
/// service to render, so — like `book_reader_toolbar_density_test.dart` — these
/// invariants are pinned against source. A widget test here would need a fake for
/// each of those, and would then be testing the fakes.
@Tags(<String>['ipad-sweep'])
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

String _read(String path) =>
    File(path).readAsStringSync().replaceAll('\r\n', '\n');

const String _deskPath =
    'lib/features/reading/presentation/screens/listen_and_read_screen.dart';
const String _playerPath =
    'lib/features/reading/presentation/screens/audiobook_player_screen.dart';
const String _readerPath =
    'lib/features/reading/presentation/screens/book_reader_screen.dart';

void main() {
  late String desk;
  late String player;
  late String reader;

  setUpAll(() {
    desk = _read(_deskPath);
    player = _read(_playerPath);
    reader = _read(_readerPath);
  });

  group('Listen-and-read desk', () {
    test('composes the transport and the text as two real panes', () {
      expect(desk, contains('ZenTwoPaneScaffold('));
      expect(
        desk,
        contains('AudiobookPlayerScreen('),
        reason: 'The transport is the clock, so it must be its own pane',
      );
      expect(desk, contains('BookReaderScreen('));
      expect(
        RegExp(r'embedded: true').allMatches(desk).length,
        2,
        reason: 'Both hosts drop their own app bar / route in pane mode',
      );
    });

    test('re-keys the text on the chapter, never on the sentence', () {
      // The key is what remounts the reader pane. Sentence-level remounting
      // would yank the scroll while the learner is reading.
      expect(
        desk,
        contains(
            "key: ValueKey<String>('reader-\$_chapterIndex-\$_readerEpoch')"),
      );
      expect(
        desk,
        isNot(contains('reader-\$_audioSentenceIndex')),
        reason: 'The spoken sentence may move the reader only when the chapter '
            'changes or the learner asks to follow',
      );
      expect(
        desk,
        contains('_readerEpoch++'),
        reason: 'Both the chapter change and the follow press bump the epoch',
      );
    });

    test('never touches playback itself', () {
      // Starting or stopping audio from the desk would fight the transport pane
      // over a single audio service.
      expect(desk, isNot(contains('audioServiceProvider')));
      expect(desk, isNot(contains('.stop()')));
      expect(desk, isNot(contains('playAudiobookAt')));
    });

    test('adds no localization debt', () {
      // The desk's visible strings are the existing chapter counter and the
      // book's own title.
      expect(desk, contains('chapterXOfY('));
      expect(desk, contains('localizedTitle('));
      expect(
        RegExp(r"Text\(\s*'").hasMatch(desk),
        isFalse,
        reason: 'No hard-coded user-facing string may appear in the desk',
      );
    });
  });

  group('iPad entry point', () {
    test('the phone path still stops the audio and pushes the plain reader',
        () {
      final int fnStart = player.indexOf('Future<void> _switchToReadingMode()');
      expect(fnStart, greaterThan(-1),
          reason: '_switchToReadingMode not found');
      final int fnEnd = player.indexOf('\n  }', fnStart);
      expect(fnEnd, greaterThan(fnStart));
      final String body = player.substring(fnStart, fnEnd);

      final int branch = body.indexOf('if (context.zenWindow.isExpanded) {');
      final int stop =
          body.indexOf('await ref.read(audioServiceProvider).stop()');
      expect(branch, greaterThan(-1),
          reason: 'The iPad branch is the desk entry');
      expect(
        stop,
        greaterThan(branch),
        reason: 'The standalone path (stop + replace) must stay *below* the '
            'expanded branch: an iPad never stops the audiobook to show text',
      );
      expect(
        body.substring(branch, stop),
        contains('ListenAndReadScreen('),
        reason: 'The desk is reachable only from the expanded branch',
      );
      expect(
        body.substring(stop),
        isNot(contains('ListenAndReadScreen(')),
        reason: 'A phone must get the plain reader, exactly as before',
      );
      expect(body.substring(stop), contains('pushReplacement('));
    });

    test('the transport pane keeps playing: no stop on the desk path', () {
      final int fnStart = player.indexOf('Future<void> _switchToReadingMode()');
      final int branch = player.indexOf(
        'if (context.zenWindow.isExpanded) {',
        fnStart,
      );
      final int returnAfterPush = player.indexOf('return;', branch);
      final String deskBranch = player.substring(branch, returnAfterPush);
      expect(
        deskBranch,
        isNot(contains('.stop()')),
        reason:
            'The whole point of the desk is that the audiobook keeps playing',
      );
      expect(deskBranch, contains('_saveProgress()'));
    });

    test('the embedded reader drops its own chrome and its resume toast', () {
      expect(reader, contains('final bool embedded;'));
      expect(reader, contains('appBar: widget.embedded'));
      expect(
        reader,
        contains('if (widget.embedded) return;'),
        reason: 'A chapter-following remount must not announce "Resumed: Ch.x"',
      );
      expect(player, contains('final bool embedded;'));
      expect(player, contains('widget.onLocationChanged?.call('));
      // The reader pane's per-sentence listen button must not push a second
      // full-screen player over the pairing.
      final int openAt = reader.indexOf('_openAudiobookAtSentence(int sentenceIdx)');
      expect(openAt, greaterThan(-1));
      expect(
        reader.substring(openAt, reader.indexOf('\n  }', openAt)),
        contains('if (widget.embedded) return;'),
      );
    });
  });
}
