import 'package:camera/camera.dart';
import 'package:flutter/services.dart' show DeviceOrientation;

/// The shape the `camera` plugin draws its preview in, so the scanner can hand it a box
/// of that shape instead of stretching it into the wrong one.
///
/// `CameraPreview` wraps the preview in an `AspectRatio` and flips the value when the
/// device is held in portrait:
///
/// ```dart
/// // camera/lib/src/camera_preview.dart
/// aspectRatio: _isLandscape()
///     ? controller.value.aspectRatio
///     : 1 / controller.value.aspectRatio,
/// ```
///
/// `CameraValue.aspectRatio` is `previewSize.width / previewSize.height`, i.e. the
/// **sensor** ratio — always landscape, commonly 16:9 — so the portrait flip is what
/// turns it into the shape actually on screen.
///
/// The scanner used to wrap the preview in a box of exactly `previewSize`, which never
/// flips. On a phone that is a contradiction the widget cannot resolve: `AspectRatio`
/// under tight constraints simply takes them, so the camera frame was drawn into a
/// landscape box and then scaled up again to cover a portrait screen — the smeared,
/// banded viewfinder in the report. On an iPad held in landscape the two agree, which is
/// why it only showed off the tablet.
///
/// [cameraPreviewOrientation] mirrors the plugin's own precedence rather than reading
/// `MediaQuery`, because that is what the plugin reads. On a phone
/// `UniversalScannerScreen._initializeCamera` locks capture to `portraitUp` unless the
/// window is a tablet's, and a capture lock outranks the device orientation in the
/// plugin's rule — which is why a phone reports portrait here even when the sensor, and
/// `value.aspectRatio` with it, says landscape.
DeviceOrientation cameraPreviewOrientation(CameraValue value) {
  if (value.isRecordingVideo && value.recordingOrientation != null) {
    return value.recordingOrientation!;
  }
  return value.previewPauseOrientation ??
      value.lockedCaptureOrientation ??
      value.deviceOrientation;
}

/// The aspect ratio the preview occupies on screen: `value.aspectRatio` held in
/// landscape, its reciprocal in portrait. See [cameraPreviewOrientation], and
/// `camera_preview_fit_test.dart`, which reads the ratio back out of the plugin's own
/// widget so the two cannot drift apart silently.
double cameraPreviewAspectRatio(CameraValue value) {
  final double sensor = value.aspectRatio;
  final DeviceOrientation orientation = cameraPreviewOrientation(value);
  final bool landscape = orientation == DeviceOrientation.landscapeLeft ||
      orientation == DeviceOrientation.landscapeRight;
  return landscape ? sensor : 1 / sensor;
}
