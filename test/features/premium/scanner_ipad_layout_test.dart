/// The scanner's landscape split (#71 of `docs/IPAD_ADAPTIVE_PLAN.md`) — and the
/// two things that make it safe to have on an iPad at all:
///
///  1. **The gate is the window class, and a phone gets `widthFactor: 1.0`.**
///     The content pane's factor is `wideSplit ? 0.55 : 1.0`, so every phone and
///     medium window lays out exactly as before.
///  2. **The camera is extracted into `_buildCameraPreview()`** so its aspect-fit
///     math runs against the *pane's* constraints rather than the window's. That
///     is the whole reason the preview fits its half instead of being scaled for
///     the full screen.
///
/// The interactive-image step is deliberately **excluded** from the split, and
/// this file says so: `ScannerOverlay`/`ScannerOverlayPainter` still paint from
/// `screenSize: MediaQuery.sizeOf(context)`, so a split there would draw the OCR
/// boxes at window coordinates over a pane. Scoping that painter is the
/// follow-up, and asserting its presence here is what keeps the exclusion
/// honest.
///
/// A camera plugin cannot run in a widget test, so — like
/// `book_reader_toolbar_density_test.dart` for the reader — the layout decisions
/// are pinned in source.
@Tags(<String>['ipad-sweep'])
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

const String _path =
    'lib/features/premium/presentation/screens/universal_scanner_screen.dart';

void main() {
  late String source;

  setUpAll(() {
    source = File(_path).readAsStringSync().replaceAll('\r\n', '\n');
  });

  String body(String signature) {
    final int start = source.indexOf(signature);
    expect(start, greaterThan(-1), reason: '$signature not found');
    final int end = source.indexOf('\n  }\n', start);
    expect(end, greaterThan(start), reason: 'could not bound $signature');
    return source.substring(start, end);
  }

  group('scanner landscape split', () {
    test('is gated on the window class, never a raw width', () {
      expect(source, contains('final bool wideSplit ='));
      expect(source, contains('context.zenWindow.isExpanded'));
      expect(
        RegExp(r'(width|shortestSide)\s*[><]=?\s*\d{3}').hasMatch(source),
        isFalse,
        reason: 'A Split View slice must not be handed the landscape layout by '
            'a magic number',
      );
    });

    test('the live preview keeps the left pane', () {
      final String build = body('Widget build(BuildContext context) {');
      expect(build, contains('widthFactor: 0.45'));
      expect(build, contains('Alignment.centerLeft'));
      expect(build, contains('_buildCameraPreview()'));
    });

    test('the content takes the right pane, and a phone is unchanged', () {
      final String build = body('Widget build(BuildContext context) {');
      expect(build, contains('widthFactor: wideSplit ? 0.55 : 1.0'));
      expect(build, contains('Alignment.centerRight'));
    });

    test('the camera is extracted so its fit math uses the pane', () {
      final String camera = body('Widget _buildCameraPreview() {');
      expect(camera, contains('LayoutBuilder('));
      expect(camera, contains('constraints.maxWidth / constraints.maxHeight'));
      expect(camera, contains('CameraPreview('));
    });

    test('the interactive-image step stays out of the split', () {
      // The exclusion, its reason, and the painter that still needs scoping.
      expect(
        source,
        contains('context.zenWindow.isExpanded && !_showingInteractiveImage'),
      );
      expect(source, contains('screenSize: MediaQuery.sizeOf(context)'),
          reason: 'Documents the trap: the markup painter measures the window, '
              'so it must not be split until it is scoped');
    });
  });
}
