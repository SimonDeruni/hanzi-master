import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/services/audio_service.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/settings_controller.dart';
import 'package:hanzi_master/features/live_translate/presentation/screens/shadowing_studio_screen.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _MockAudioService extends Fake implements AudioService {
  String? lastPlayedSentence;
  String? lastVoiceName;
  double? lastSpeechRate;
  double? lastPlaybackRate;

  @override
  Future<bool> playSentence(
    String sentence, {
    String voiceName = 'Fenrir',
    double? speechRate,
    double? playbackRate,
    bool fromQueue = false,
  }) async {
    lastPlayedSentence = sentence;
    lastVoiceName = voiceName;
    lastSpeechRate = speechRate;
    lastPlaybackRate = playbackRate;
    return true;
  }
}

void main() {
  group('Shadowing Studio Voice Speed and Session Mode', () {
    testWidgets('Session screen renders speed toggle defaulting to 0.8x and toggles to 1.0x',
        (tester) async {
      await tester.binding.setSurfaceSize(const Size(430, 932));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final mockAudioService = _MockAudioService();
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            audioServiceProvider.overrideWithValue(mockAudioService),
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: const MaterialApp(
            locale: Locale('en'),
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            home: ShadowingStudioScreen(
              showBackButton: true,
              startSessionImmediately: true,
              initialPhrase: {
                'hanzi': '你好世界',
                'pinyin': 'nǐ hǎo shì jiè',
                'english': 'Hello world',
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Find the speed toggle button
      final toggleFinder = find.byKey(const Key('shadowing_speed_toggle'));
      expect(toggleFinder, findsOneWidget);
      expect(find.text('0.8x'), findsOneWidget);

      // Tap play button and verify measured speed rate (0.40) and Kore voice
      final playButtonFinder = find.byIcon(Icons.play_circle_fill);
      expect(playButtonFinder, findsOneWidget);
      await tester.tap(playButtonFinder);
      await tester.pump();

      expect(mockAudioService.lastPlayedSentence, equals('你好世界'));
      expect(mockAudioService.lastVoiceName, equals('Kore'));
      expect(mockAudioService.lastSpeechRate, equals(0.40));
      expect(mockAudioService.lastPlaybackRate, equals(1.0));

      // Tap speed toggle to switch to 1.0x
      await tester.tap(toggleFinder);
      await tester.pump();
      expect(find.text('1.0x'), findsOneWidget);

      // Tap play button again and verify normal speed rate (0.50)
      await tester.tap(playButtonFinder);
      await tester.pump();

      expect(mockAudioService.lastSpeechRate, equals(0.50));
      expect(mockAudioService.lastVoiceName, equals('Kore'));
      expect(mockAudioService.lastPlaybackRate, equals(1.0));
    });

    testWidgets('Session top bar has down arrow to exit session full screen',
        (tester) async {
      await tester.binding.setSurfaceSize(const Size(430, 932));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: const MaterialApp(
            locale: Locale('en'),
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            home: ShadowingStudioScreen(
              showBackButton: true,
              startSessionImmediately: true,
              initialPhrase: {
                'hanzi': '早上好',
                'pinyin': 'zǎo shang hǎo',
                'english': 'Good morning',
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.keyboard_arrow_down), findsOneWidget);
      expect(find.text('Shadowing Studio'), findsOneWidget);
    });
  });
}
