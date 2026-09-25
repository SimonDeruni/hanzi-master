import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Regression for "Simplification automatique" hanging forever.
///
/// Two defects combined to leave the AI progress overlay spinning with no
/// output and no error:
///
/// 1. `_injectHanziInterceptor()` (async, not awaited) defines
///    `window.makeChineseTextClickable`. Zen mode ran on an 800 ms timer and
///    called it unguarded, so it could throw a JS TypeError that aborted the
///    Zen script mid-way.
/// 2. `WebViewController.runJavaScriptReturningResult` never completes when the
///    evaluated script throws, so the `await` on it hung indefinitely and the
///    `finally` block that clears `_isProcessingAi` never ran.
void main() {
  late String source;

  setUpAll(() {
    source = File(
      'lib/features/media/presentation/screens/web_browser_screen.dart',
    ).readAsStringSync();
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

    // Both the simplify and the analyze paths read the page text.
    final timedReads =
        RegExp(r'\.timeout\(\s*_articleTextTimeout').allMatches(source).length;
    expect(timedReads, 2,
        reason: 'Both page-text reads must be guarded by the timeout');
  });

  test('the timeout is a real, finite duration', () {
    final match = RegExp(
      r'static const Duration _articleTextTimeout = Duration\(seconds: (\d+)\)',
    ).firstMatch(source);
    expect(match, isNotNull, reason: 'The timeout constant must be defined');
    final seconds = int.parse(match!.group(1)!);
    expect(seconds, greaterThan(0));
    expect(seconds, lessThanOrEqualTo(60),
        reason: 'A stuck overlay must clear within a reasonable time');
  });
}
