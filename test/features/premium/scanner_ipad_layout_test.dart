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
///  3. **Nothing in the scanner measures the window.** The painter trap is
///     closed: the AR overlay and its tap map measure the box they are given (a
///     `LayoutBuilder`), and `TranslationOverlayPainter` uses the `size` the
///     canvas hands it instead of a `screenSize` field fed from `MediaQuery`.
///     Before this a split drew the OCR boxes and the translated blocks at window
///     coordinates over the results column, and mis-mapped every tap by the width
///     of that column.
///  4. **The preview covers its pane, and the framing guide sits on the camera.**
///     A hand-rolled `Transform.scale` letterboxed the preview: it scaled an
///     already aspect-fitted child, so one axis was clipped at its limit while the
///     other stayed short, leaving the scaffold visible behind white-on-camera
///     chrome. The guide was painted in the content pane, so on an iPad it was
///     drawn over the results column rather than over the viewfinder.
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

  /// The text of a whole class, up to the next class declaration.
  String classBody(String name) {
    final int start = source.indexOf('class $name');
    expect(start, greaterThan(-1), reason: '$name not found');
    final int end = source.indexOf('\nclass ', start + 1);
    return source.substring(start, end == -1 ? source.length : end);
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

    test('does not split a tablet held in portrait', () {
      // A 1024dp-wide iPad in portrait cleared `isExpanded` on its own, so the
      // split fired and gave the camera a 460dp column beside a 560dp one on a
      // window 1366dp tall — less room for both than the stacked arrangement.
      expect(source, contains('context.isLandscapeWindow'),
          reason: 'Hosting the split on the camera means the window shape has to '
              'gate it, not only the width');
      final String build = body('Widget build(BuildContext context) {');
      final int widthGate = build.indexOf('context.zenWindow.isExpanded');
      final int landscapeGate = build.indexOf('context.isLandscapeWindow');
      expect(widthGate, greaterThan(-1));
      expect(landscapeGate, greaterThan(widthGate),
          reason: 'Both conditions belong to `wideSplit`');
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

    test('the camera preview covers its pane instead of letterboxing it', () {
      final String camera = body('Widget _buildCameraPreview() {');
      expect(camera, contains('CameraPreview('));
      expect(camera, contains('FittedBox('));
      expect(camera, contains('BoxFit.cover'),
          reason: 'A fit that keeps the ratio but leaves the pane short is what '
              'put the scaffold behind the white-on-camera chrome and made the '
              'preview read as a small square adrift in its pane');
      expect(camera, isNot(contains('Transform.scale(')),
          reason: 'Scaling an already aspect-fitted preview clips one axis at its '
              'limit while the other stays short');
      expect(camera, contains('previewSize'));
    });

    test('the framing guide is drawn over the camera, not the content pane', () {
      final String build = body('Widget build(BuildContext context) {');
      final int cameraPane = build.indexOf('widthFactor: 0.45');
      final int guide = build.indexOf('if (_framingThePreview) const ScannerOverlay()');
      expect(guide, greaterThan(cameraPane),
          reason: 'The guide has to live inside the camera pane, or an iPad user '
              'is told to align text inside a frame over the results column');
      // ...and the content pane must not draw a second one.
      expect(source, contains('showFramingGuide: !wideSplit'));
      expect(
        source,
        contains('return showFramingGuide ? const ScannerOverlay() : '
            'const SizedBox.shrink();'),
        reason: 'Exactly one arrangement may draw the guide',
      );
    });
  });

  group('no overlay measures the window', () {
    test('the painter trap is closed, not merely excluded', () {
      expect(source, isNot(contains('MediaQuery.sizeOf(context)')),
          reason: 'A window-sized measurement inside a pane draws the OCR boxes '
              'over the results column and mis-maps every tap by the same factor');
      expect(source, isNot(contains('screenSize')),
          reason: 'The canvas already knows its own size');
    });

    test('the AR overlay measures the box it was given', () {
      final String content = body('Widget _buildMainContent(');
      expect(content, contains('LayoutBuilder('));
      expect(content, contains('constraints.biggest'));
      expect(content, contains('_handleArTap('));
      expect(content, isNot(contains('MediaQuery')));
    });

    test('the tap map uses the same size the boxes are painted with', () {
      final String tap = body('void _handleArTap(');
      expect(tap, contains('overlaySize.width / imageWidth'));
      expect(tap, contains('widgetSize: overlaySize'),
          reason: 'A tap measured against a different size than the boxes were '
              'scaled with lands off by the difference');
    });

    test('the translated-block painter uses the canvas size', () {
      final String painter = classBody('TranslationOverlayPainter');
      expect(painter, contains('void paint(Canvas canvas, Size size)'));
      expect(painter, contains('size.width / imageSize.width'));
      expect(painter, isNot(contains('screenSize')));
    });
  });

  group('the framing guide itself', () {
    test('the frame is sized from its box, not a fixed 280dp square', () {
      final String painter = classBody('ScannerOverlayPainter');
      expect(painter, contains('math.min(size.width, size.height)'));
      expect(painter, isNot(contains('width: 280')),
          reason: 'A fixed square neither fits the camera pane nor leaves room '
              'beneath it for the instruction');
      expect(painter, contains('frameSize'));
    });

    test('the instruction is kept inside the box', () {
      final String painter = classBody('ScannerOverlayPainter');
      expect(painter, isNot(contains('rect.bottom + 32')),
          reason: 'A fixed offset below the frame falls off a short pane and is '
              'clipped mid-word');
      expect(painter, contains('size.height - textPainter.height'));
      expect(painter, contains('clamp'),
          reason: 'The label must be clamped into the pane horizontally too');
    });
  });
}
