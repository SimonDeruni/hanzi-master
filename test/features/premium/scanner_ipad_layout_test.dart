/// The scanner's iPad layout (#71 of `docs/IPAD_ADAPTIVE_PLAN.md`):
///
///  1. **The camera preview is full-screen across all viewports.**
///     `Positioned.fill(child: _buildCameraPreview())` ensures that on an iPad
///     (in both portrait and landscape) as well as a phone, the camera covers the
///     entire screen for an immersive viewfinder rather than being squeezed into
///     an awkward side pane.
///  2. **The camera is extracted into `_buildCameraPreview()`** so its aspect-fit
///     math uses `BoxFit.cover` against its constraints without letterboxing or
///     distorting.
///  3. **Controls are centered and ergonomically constrained.**
///     `_buildBottomControls` and `_buildZoomSlider` are centered with
///     `ConstrainedBox(maxWidth: 480)` so they remain comfortable to use
///     on large iPad screens without stretching or drifting off to the side.
///  4. **The framing guide sits over the full camera preview.**
///     `ScannerOverlay` draws its framing brackets centered over the camera.
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

  group('scanner iPad full-screen layout', () {
    test('camera preview fills the entire screen across all viewports', () {
      final String build = body('Widget build(BuildContext context) {');
      expect(build, contains('Positioned.fill(child: _buildCameraPreview())'));
      expect(build, isNot(contains('widthFactor: 0.45')),
          reason: 'The live camera preview must never be squeezed into a narrow side pane');
      expect(build, isNot(contains('widthFactor: wideSplit')),
          reason: 'Controls must not be offset into a split column');
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

    test('bottom controls and zoom slider are centered with max constraints on iPad', () {
      final String controls = body('Widget _buildBottomControls(');
      expect(controls, contains('Center('));
      expect(controls, contains('ConstrainedBox('));
      expect(controls, contains('maxWidth: 480'));

      final String zoom = body('Widget _buildZoomSlider() {');
      expect(zoom, contains('Center('));
      expect(zoom, contains('ConstrainedBox('));
      expect(zoom, contains('maxWidth: 480'));
    });

    test('the framing guide is drawn over the camera and guarded by aiming state', () {
      expect(source, contains('_framingThePreview'));
      expect(
        source,
        contains('return (showFramingGuide && _framingThePreview)'),
        reason: 'The framing guide is drawn when the user is aiming the camera',
      );
    });

    test('results view is ergonomically constrained on wide screens', () {
      final String build = body('Widget _buildMainContent(');
      expect(build, contains('maxWidth: 720'));
      expect(build, contains('_buildResultsList('));
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
