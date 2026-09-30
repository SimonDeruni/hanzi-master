/// The scanner's viewfinder shape, and the distortion report behind it.
///
/// The report: *"distorted … issue with the scanner photo when not on iPad"*. The cause
/// is a shape mismatch, not a camera problem. `CameraValue.previewSize` is the **sensor**
/// size — always landscape, 1920×1080 here — while the plugin's `CameraPreview` flips its
/// `AspectRatio` for portrait (`camera/lib/src/camera_preview.dart`). The scanner wrapped
/// the preview in a box of exactly `previewSize`, so on a phone the preview was handed a
/// landscape box, `AspectRatio` took the tight constraints, and the camera frame was
/// stretched into that box and then scaled again to cover a portrait screen. A landscape
/// iPad is the one case where the two shapes agree, which is why it survived the iPad
/// pass.
///
/// These tests read the ratio back out of the plugin's **own widget**, so our rule and the
/// plugin's cannot drift apart silently: the numbers below are the plugin's, not ours.
library;

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/premium/presentation/widgets/camera_preview_fit.dart';

/// A 1080p sensor: landscape, and the shape `previewSize` always reports.
const double _sensorRatio = 1920 / 1080;

CameraValue _value({
  DeviceOrientation deviceOrientation = DeviceOrientation.portraitUp,
  DeviceOrientation? lockedCaptureOrientation,
  DeviceOrientation? recordingOrientation,
  DeviceOrientation? previewPauseOrientation,
  bool isRecordingVideo = false,
}) =>
    CameraValue(
      isInitialized: true,
      previewSize: const Size(1920, 1080),
      isRecordingVideo: isRecordingVideo,
      isTakingPicture: false,
      isStreamingImages: false,
      isRecordingPaused: false,
      flashMode: FlashMode.auto,
      exposureMode: ExposureMode.auto,
      focusMode: FocusMode.auto,
      exposurePointSupported: false,
      focusPointSupported: false,
      deviceOrientation: deviceOrientation,
      description: const CameraDescription(
        name: 'back',
        lensDirection: CameraLensDirection.back,
        sensorOrientation: 90,
      ),
      lockedCaptureOrientation: lockedCaptureOrientation,
      recordingOrientation: recordingOrientation,
      previewPauseOrientation: previewPauseOrientation,
    );

/// A `CameraController` that reports [value] and paints flat colour instead of a texture:
/// the geometry is what is under test, not the pixels.
class _FakeCameraController extends ValueNotifier<CameraValue>
    implements CameraController {
  _FakeCameraController(super.value);

  @override
  Widget buildPreview() => const ColoredBox(color: Color(0xFF123456));

  @override
  Future<void> dispose() async => super.dispose();

  // Everything else the controller can do is deliberately unimplemented: reaching one
  // means the test asked for something it never set up.
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// Pumps the preview the way the scanner builds it — `ClipRect` → `FittedBox(cover)` →
/// box → `CameraPreview` — in a phone- or tablet-shaped frame, and returns
/// `(the ratio the plugin drew in, the ratio of the box it was handed)`.
Future<(double, double)> _pumpPreview(
  WidgetTester tester,
  CameraValue value, {
  required Size frame,
  required double boxAspect,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Center(
        child: SizedBox(
          width: frame.width,
          height: frame.height,
          child: ClipRect(
            child: FittedBox(
              fit: BoxFit.cover,
              clipBehavior: Clip.hardEdge,
              child: SizedBox(
                width: boxAspect,
                height: 1,
                child: CameraPreview(_FakeCameraController(value)),
              ),
            ),
          ),
        ),
      ),
    ),
  );

  final AspectRatio plugin =
      tester.widget<AspectRatio>(find.byType(AspectRatio));
  return (
    plugin.aspectRatio,
    tester.getSize(find.byType(AspectRatio)).aspectRatio,
  );
}

void main() {
  group('the shape the plugin will draw the preview in', () {
    test('is portrait on a phone, which this screen locks to portrait', () {
      // `_initializeCamera` locks capture to portraitUp when not on a tablet, and the
      // plugin reads that lock before the device orientation.
      final CameraValue phone = _value(
        lockedCaptureOrientation: DeviceOrientation.portraitUp,
      );
      expect(cameraPreviewAspectRatio(phone), closeTo(1 / _sensorRatio, 1e-9));
      expect(cameraPreviewAspectRatio(phone), lessThan(1));
      // The sensor ratio says the opposite, which is the whole bug.
      expect(phone.aspectRatio, greaterThan(1));
    });

    test('is landscape on a tablet, which keeps its orientation', () {
      final CameraValue tablet = _value(
        deviceOrientation: DeviceOrientation.landscapeLeft,
      );
      expect(cameraPreviewAspectRatio(tablet), closeTo(_sensorRatio, 1e-9));
      expect(cameraPreviewAspectRatio(tablet), greaterThan(1));
    });

    test('follows the plugin precedence: recording, pause, lock, device', () {
      expect(
        cameraPreviewOrientation(_value(
          isRecordingVideo: true,
          recordingOrientation: DeviceOrientation.landscapeRight,
          lockedCaptureOrientation: DeviceOrientation.portraitUp,
        )),
        DeviceOrientation.landscapeRight,
      );
      expect(
        cameraPreviewOrientation(_value(
          previewPauseOrientation: DeviceOrientation.landscapeLeft,
          lockedCaptureOrientation: DeviceOrientation.portraitUp,
        )),
        DeviceOrientation.landscapeLeft,
      );
      expect(
        cameraPreviewOrientation(_value(
          deviceOrientation: DeviceOrientation.landscapeRight,
          lockedCaptureOrientation: DeviceOrientation.portraitUp,
        )),
        DeviceOrientation.portraitUp,
      );
      expect(
        cameraPreviewOrientation(_value(
          deviceOrientation: DeviceOrientation.landscapeRight,
        )),
        DeviceOrientation.landscapeRight,
      );
    });
  });

  group('the box the scanner hands the preview', () {
    const Size phoneScreen = Size(390, 844);
    const Size padPane = Size(460, 768);

    testWidgets('matches the plugin on a portrait phone',
        (WidgetTester tester) async {
      final CameraValue phone = _value(
        lockedCaptureOrientation: DeviceOrientation.portraitUp,
      );
      final (double drawn, double boxed) = await _pumpPreview(
        tester,
        phone,
        frame: phoneScreen,
        boxAspect: cameraPreviewAspectRatio(phone),
      );

      expect(drawn, closeTo(cameraPreviewAspectRatio(phone), 1e-9));
      // Same shape, so the frame is scaled evenly: nothing is stretched.
      expect(boxed, closeTo(drawn, 1e-3));
    });

    testWidgets('matches the plugin on a landscape tablet',
        (WidgetTester tester) async {
      final CameraValue tablet = _value(
        deviceOrientation: DeviceOrientation.landscapeLeft,
      );
      final (double drawn, double boxed) = await _pumpPreview(
        tester,
        tablet,
        frame: padPane,
        boxAspect: cameraPreviewAspectRatio(tablet),
      );

      expect(drawn, closeTo(cameraPreviewAspectRatio(tablet), 1e-9));
      expect(boxed, closeTo(drawn, 1e-3));
    });

    testWidgets('the sensor-shaped box it used to use could only stretch it',
        (WidgetTester tester) async {
      final CameraValue phone = _value(
        lockedCaptureOrientation: DeviceOrientation.portraitUp,
      );
      // What shipped: `SizedBox(width: preview.width, height: preview.height)`.
      final (double drawn, double boxed) = await _pumpPreview(
        tester,
        phone,
        frame: phoneScreen,
        boxAspect: _sensorRatio,
      );

      expect(drawn, lessThan(1), reason: 'the plugin draws portrait on a phone');
      expect(boxed, closeTo(_sensorRatio, 1e-3), reason: 'the box it was given');
      // A portrait frame in a landscape box: stretched by more than three times, and
      // then magnified again to cover the screen. That is the smeared viewfinder.
      expect(boxed / drawn, greaterThan(3));
    });

    test('the scanner builds that box from the fit helper, not from previewSize',
        () {
      final String source = File(
        'lib/features/premium/presentation/screens/universal_scanner_screen.dart',
      ).readAsStringSync();

      expect(source, contains('cameraPreviewAspectRatio(value)'));
      expect(
        RegExp(r'width:\s*preview\.width').hasMatch(source),
        isFalse,
        reason: 'the sensor-sized box is exactly what stretched the frame',
      );
    });
  });
}
