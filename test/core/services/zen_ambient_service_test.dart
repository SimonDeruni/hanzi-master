import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hanzi_master/core/services/zen_ambient_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('ZenAmbientService', () {
    test('initializes with default state when SharedPreferences is empty', () async {
      final prefs = await SharedPreferences.getInstance();
      final service = ZenAmbientService.instance;
      await service.init(prefs: prefs);

      expect(service.state.track, equals(SoundscapeTrack.off));
      expect(service.state.isPlaying, isFalse);
      expect(service.state.volume, closeTo(0.15, 0.01));
    });

    test('updates track and persists to SharedPreferences', () async {
      final prefs = await SharedPreferences.getInstance();
      final service = ZenAmbientService.instance;
      await service.init(prefs: prefs);

      await service.setTrack(SoundscapeTrack.courtyardRain);
      expect(service.state.track, equals(SoundscapeTrack.courtyardRain));
      expect(service.state.isPlaying, isTrue);
      expect(prefs.getString('zen_soundscape_track'), equals('courtyardRain'));

      await service.setTrack(SoundscapeTrack.guqinWind);
      expect(service.state.track, equals(SoundscapeTrack.guqinWind));
      expect(prefs.getString('zen_soundscape_track'), equals('guqinWind'));

      await service.setTrack(SoundscapeTrack.off);
      expect(service.state.track, equals(SoundscapeTrack.off));
      expect(service.state.isPlaying, isFalse);
      expect(prefs.getString('zen_soundscape_track'), equals('off'));
    });

    test('toggles play/pause correctly', () async {
      final prefs = await SharedPreferences.getInstance();
      final service = ZenAmbientService.instance;
      await service.init(prefs: prefs);

      // When track is off, togglePlayPause starts default track (courtyardRain)
      await service.setTrack(SoundscapeTrack.off);
      await service.togglePlayPause();
      expect(service.state.track, equals(SoundscapeTrack.courtyardRain));
      expect(service.state.isPlaying, isTrue);

      // Toggling again pauses it
      await service.togglePlayPause();
      expect(service.state.isPlaying, isFalse);

      // Toggling again resumes it
      await service.togglePlayPause();
      expect(service.state.isPlaying, isTrue);

      // Clean up
      await service.stop();
    });

    test('clamps volume within 0.0 and 1.0 and persists', () async {
      final prefs = await SharedPreferences.getInstance();
      final service = ZenAmbientService.instance;
      await service.init(prefs: prefs);

      await service.setVolume(0.35);
      expect(service.state.volume, closeTo(0.35, 0.001));
      expect(prefs.getDouble('zen_soundscape_volume'), closeTo(0.35, 0.001));

      // Clamping upper
      await service.setVolume(1.5);
      expect(service.state.volume, equals(1.0));

      // Clamping lower
      await service.setVolume(-0.2);
      expect(service.state.volume, equals(0.0));
    });

    test('SoundscapeTrack fromString handles invalid and valid strings', () {
      expect(SoundscapeTrack.fromString('courtyardRain'),
          equals(SoundscapeTrack.courtyardRain));
      expect(SoundscapeTrack.fromString('guqinWind'),
          equals(SoundscapeTrack.guqinWind));
      expect(SoundscapeTrack.fromString('midnightZen'),
          equals(SoundscapeTrack.midnightZen));
      expect(SoundscapeTrack.fromString('invalid'), equals(SoundscapeTrack.off));
      expect(SoundscapeTrack.fromString(null), equals(SoundscapeTrack.off));
    });

    test('SoundscapeTrack returns correct asset paths', () {
      expect(SoundscapeTrack.courtyardRain.assetPath,
          equals('audio/ambient_courtyard_rain.wav'));
      expect(SoundscapeTrack.guqinWind.assetPath,
          equals('audio/ambient_guqin_wind.wav'));
      expect(SoundscapeTrack.midnightZen.assetPath,
          equals('audio/ambient_midnight_zen.wav'));
      expect(SoundscapeTrack.off.assetPath, isEmpty);
    });
  });
}
