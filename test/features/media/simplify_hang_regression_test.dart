import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Regression for "Simplification automatique" hanging forever.
///
/// Three defects combined to leave the AI progress overlay spinning with no
/// output and no error — and, because that overlay is opaque, covers the page
/// and disables the AI Tools chip, with no way to reach anything at all:
///
/// 1. `_injectHanziInterceptor()` (async, not awaited) defines
///    `window.makeChineseTextClickable`. Zen mode ran on an 800 ms timer and
///    called it unguarded, so it could throw a JS TypeError that aborted the
///    Zen script mid-way.
/// 2. `WebViewController.runJavaScriptReturningResult` never completes when the
///    evaluated script throws, so the `await` on it hung indefinitely and the
///    `finally` block that clears `_isProcessingAi` never ran.
/// 3. The model calls themselves had no ceiling, and the overlay had no exit:
///    a stalled connection left the learner with no page, no controls, and
///    nothing to tap — "sometimes it just gets stuck".
void main() {
  late String source;

  setUpAll(() {
    // Normalised: the guards below look for `\n  }\n` as a method terminator.
    source = File(
      'lib/features/media/presentation/screens/web_browser_screen.dart',
    ).readAsStringSync().replaceAll('\r\n', '\n');
  });

  test('page setup sequences the interceptor before Zen mode', () {
    expect(source, contains('Future<void> _preparePageForReading('),
        reason: 'Injections must be ordered, not fired concurrently');

    // onPageFinished must delegate to the sequencing helper rather than
    // calling the interceptor and Zen mode side by side.
    final onPageFinished = source.substring(source.indexOf('onPageFinished:'));
    expect(
      onPageFinished.substring(0, 700),
      contains('_preparePageForReading(url)'),
      reason: 'onPageFinished must await the ordered setup',
    );
    expect(onPageFinished.substring(0, 700),
        isNot(contains('_injectHanziInterceptor();')),
        reason: 'The interceptor must not be fired un-awaited from '
            'onPageFinished any more');
  });

  test('the interceptor is awaited before Zen mode is applied', () {
    final helper = source.substring(
      source.indexOf('Future<void> _preparePageForReading('),
      source.indexOf('Future<void> _stopTts'),
    );
    expect(helper, contains('await _injectHanziInterceptor()'),
        reason: 'Zen mode depends on makeChineseTextClickable existing');
    expect(helper, contains('await _toggleZenMode()'));
    expect(helper, contains('await _applyZenMode('));
  });

  test('only one place auto-triggers simplification, after Zen mode', () {
    final autoSimplifyCalls =
        RegExp(r'_runAutoSimplify\(3\)').allMatches(source).length;
    expect(autoSimplifyCalls, 1,
        reason: 'The old timer-based auto-trigger must be gone; only the '
            'sequenced path may start simplification');

    final helper = source.substring(
      source.indexOf('Future<void> _preparePageForReading('),
      source.indexOf('Future<void> _stopTts'),
    );
    expect(helper, contains('await _runAutoSimplify(3)'),
        reason: 'Simplification runs only once the page is ready');
  });

  test('the Zen script guards makeChineseTextClickable', () {
    // An unguarded call throws when the interceptor has not run yet.
    final guardCount = RegExp(
      r"typeof window\.makeChineseTextClickable === 'function'",
    ).allMatches(source).length;
    expect(guardCount, greaterThanOrEqualTo(2),
        reason: 'Both the apply and remove paths must guard the call');
  });

  test('the JS text read cannot hang the overlay forever', () {
    expect(source, contains('_articleTextTimeout'),
        reason: 'runJavaScriptReturningResult needs an upper bound');

    // Every read that gates the overlay is guarded: the analyze path reads the
    // body once, the word-extraction path reads body and title, the simplify
    // path reads the article text.
    final timedReads =
        RegExp(r'\.timeout\(\s*_articleTextTimeout').allMatches(source).length;
    expect(timedReads, 4,
        reason: 'Each page-text read that raises the overlay must be guarded');
  });

  test('every model call is bounded too', () {
    String statementAt(String call, int from) {
      final int end = source.indexOf(';', from);
      expect(end, greaterThan(from));
      return source.substring(from, end);
    }

    for (final String call in <String>[
      'generateArticleInsight(',
      'extractAllUnknownWords(',
      'simplifyTextToHsk(',
    ]) {
      int from = source.indexOf(call);
      var seen = 0;
      while (from != -1) {
        final String statement = statementAt(call, from);
        expect(
          RegExp(r'\.timeout\(\s*(_aiCallTimeout|_simplifyCallTimeout)')
              .hasMatch(statement),
          isTrue,
          reason: '$call has no ceiling: a stalled connection is a locked page',
        );
        seen++;
        from = source.indexOf(call, from + call.length);
      }
      expect(seen, greaterThan(0), reason: '$call is no longer called');
    }
  });

  test('the overlay offers a way out', () {
    // The overlay owns the page while a run is in flight, so a runner that never
    // answers must not be able to keep it: tapping retires the run, and the run
    // that was retired drops its own answer.
    expect(source, contains('onTap: _cancelAiRun'),
        reason: 'Tapping the blocking overlay must hand the page back');
    expect(source, contains('onPressed: _cancelAiRun'),
        reason: 'The gesture must be named, so nobody has to guess');

    final start = source.indexOf('void _cancelAiRun() {');
    expect(start, greaterThan(-1), reason: '_cancelAiRun not found');
    final end = source.indexOf('\n  }\n', start);
    expect(end, greaterThan(start));
    final String cancel = source.substring(start, end);
    expect(cancel, contains('_aiRunGeneration++'),
        reason: 'The in-flight answer must be retired, not merely hidden');
    expect(cancel, contains('_isProcessingAi = false'));
  });

  test('every run hands the overlay back to the screen', () {
    int count(String needle) =>
        RegExp(RegExp.escape(needle)).allMatches(source).length;

    final runs = count('_beginAiRun()') - 1; // minus the declaration
    expect(runs, greaterThan(0));
    expect(count('_endAiRun(generation)'), runs,
        reason: 'Each run must lower the overlay in its `finally`');
    expect(count('_aiRunIsStale(generation)'), runs,
        reason: 'Each run must drop its own late answer');
    expect(source, contains('generation == _aiRunGeneration'),
        reason: 'A retired run may not clear the run that replaced it');
  });

  test('the timeouts are real, finite durations', () {
    Duration parse(String name) {
      final match = RegExp('static const Duration $name = Duration\\(seconds: '
              r'(\d+)\)')
          .firstMatch(source);
      expect(match, isNotNull, reason: '$name must be defined');
      return Duration(seconds: int.parse(match!.group(1)!));
    }

    final text = parse('_articleTextTimeout');
    expect(text.inSeconds, greaterThan(0));
    expect(text.inSeconds, lessThanOrEqualTo(60),
        reason: 'A stuck overlay must clear within a reasonable time');

    final call = parse('_aiCallTimeout');
    expect(call.inSeconds, greaterThan(0));
    expect(call.inSeconds, lessThanOrEqualTo(120));

    // Simplification is the only call allowed to take longer, and it matches
    // the budget the service sets for itself.
    final simplify = parse('_simplifyCallTimeout');
    expect(simplify.inSeconds, greaterThanOrEqualTo(call.inSeconds));
    expect(simplify.inSeconds, lessThanOrEqualTo(180));
  });
}
