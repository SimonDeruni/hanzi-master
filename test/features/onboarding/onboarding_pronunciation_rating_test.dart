import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/services/analytics_service.dart';
import 'package:hanzi_master/core/services/api_key_pool.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/features/onboarding/presentation/screens/onboarding_mini_lesson_screen.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

class _FakeApiKeyPool extends ApiKeyPool {
  @override
  String get azureSpeechKey => 'fake-azure-key';
  @override
  String get azureSpeechRegion => 'eastus';
}

void main() {
  group('Azure Pronunciation Rating Alignment', () {
    test('gradeAudio maps Azure accuracy and calibrates tone divergence on mispronunciation',
        () async {
      final mockAzureResponse = {
        'RecognitionStatus': 'Success',
        'NBest': [
          {
            'PronunciationAssessment': {
              'PronScore': 81.0,
              'AccuracyScore': 81.0,
              'CompletenessScore': 100.0,
              'FluencyScore': 85.0,
            },
            'Words': [
              {
                'Word': '百',
                'PronunciationAssessment': {
                  'AccuracyScore': 95.0,
                  'ErrorType': 'None',
                },
                'Syllables': [
                  {
                    'Syllable': 'bai',
                    'AccuracyScore': 95.0,
                  }
                ],
              },
              {
                'Word': '战',
                'PronunciationAssessment': {
                  'AccuracyScore': 45.0,
                  'ErrorType': 'Mispronunciation',
                },
                'Syllables': [
                  {
                    'Syllable': 'zhan',
                    'AccuracyScore': 45.0,
                  }
                ],
              },
              {
                'Word': '不',
                'PronunciationAssessment': {
                  'AccuracyScore': 92.0,
                  'ErrorType': 'None',
                },
                'Syllables': [
                  {
                    'Syllable': 'bu',
                    'AccuracyScore': 92.0,
                  }
                ],
              },
              {
                'Word': '殆',
                'PronunciationAssessment': {
                  'AccuracyScore': 90.0,
                  'ErrorType': 'None',
                },
                'Syllables': [
                  {
                    'Syllable': 'dai',
                    'AccuracyScore': 90.0,
                  }
                ],
              },
            ],
          }
        ],
      };

      final service = GeminiService(
        pool: _FakeApiKeyPool(),
        analytics: AnalyticsService(),
        httpClient: MockClient((request) async {
          return http.Response.bytes(
            utf8.encode(jsonEncode(mockAzureResponse)),
            200,
            headers: {'content-type': 'application/json; charset=utf-8'},
          );
        }),
      );

      final dummyAudio = List<int>.filled(1200, 0);
      final grade = await service.gradeAudio(
        dummyAudio,
        '百战不殆',
        'bǎi zhàn bù dài',
      );

      expect(grade['score'], isNotNull);
      final words = grade['words'] as List<Map<String, dynamic>>;
      expect(words.length, 4);

      // '百': 3rd tone, accurate
      expect(words[0]['word'], '百');
      expect(words[0]['isCorrect'], isTrue);
      expect(words[0]['expectedTone'], 3);
      expect(words[0]['actualTone'], 3);

      // '战': 4th tone, mispronounced -> calibrated tone discrepancy (not 4)
      expect(words[1]['word'], '战');
      expect(words[1]['isCorrect'], isFalse);
      expect(words[1]['expectedTone'], 4);
      expect(words[1]['actualTone'], 2);

      // '不': 4th tone, accurate
      expect(words[2]['word'], '不');
      expect(words[2]['isCorrect'], isTrue);
      expect(words[2]['expectedTone'], 4);
      expect(words[2]['actualTone'], 4);

      // '殆': 4th tone, accurate
      expect(words[3]['word'], '殆');
      expect(words[3]['isCorrect'], isTrue);
      expect(words[3]['expectedTone'], 4);
      expect(words[3]['actualTone'], 4);
    });

    testWidgets(
        'Onboarding Step 3 displays Azure score banner and focuses weak character',
        (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: OnboardingMiniLessonScreen(
              disableExternalServicesForTesting: true,
              onComplete: () {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Step 0: Listen -> Step 1: Notice
      await tester.ensureVisible(find.text('Continue'));
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();

      // Step 1: Notice -> Step 2: Shadow
      await tester.ensureVisible(find.text('Shadow one sentence'));
      await tester.tap(find.text('Shadow one sentence'));
      await tester.pumpAndSettle();

      // Step 2: Shadow -> Skip via "I can't speak right now" (quiet path)
      await tester.ensureVisible(find.text('Continue'));
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text("I can't speak right now"));
      await tester.tap(find.text("I can't speak right now"));
      await tester.pumpAndSettle();

      // Step 3: Four Tones
      expect(find.text('Four tones'), findsOneWidget);

      // Verify Score Banner from Azure technique
      expect(find.byKey(const Key('onboarding_overall_score_banner')),
          findsOneWidget);
      expect(find.text('Score: 82/100'), findsOneWidget);
      expect(find.text('Great job! A few minor tone inaccuracies.'),
          findsOneWidget);

      // Verify focus is on '战' (needs tone polish)
      expect(find.text('You: tone 2 · rising  ·  Target: tone 4 · falling'),
          findsOneWidget);
      expect(find.text('Try Again'), findsOneWidget);

      // Tapping '百' switches selection to tone matched
      await tester.tap(find.byKey(const Key('tone_character_百')));
      await tester.pumpAndSettle();
      expect(find.text('Matched'), findsOneWidget);
      expect(find.text('You: tone 3 · dipping  ·  Target: tone 3 · dipping'),
          findsOneWidget);
    });
  });
}
