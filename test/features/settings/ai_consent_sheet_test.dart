import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/ai_consent_sheet.dart';
import 'package:hanzi_master/core/utils/pinyin_utils.dart';

Widget _buildApp({required Widget child, Locale locale = const Locale('en')}) {
  return MaterialApp(
    locale: locale,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(body: child),
  );
}

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('AiConsentSheet UI and Flow', () {
    testWidgets('renders all disclosure sections and providers in English',
        (tester) async {
      await tester.pumpWidget(
        _buildApp(child: const AiConsentSheet()),
      );
      await tester.pumpAndSettle();

      expect(find.text('AI Practice & Privacy'), findsOneWidget);
      expect(find.text('Data Transmitted'), findsOneWidget);
      expect(find.text('Third-Party AI Services'), findsOneWidget);
      expect(find.text('Privacy Guarantees'), findsOneWidget);
      expect(find.text('Agree to Use AI'), findsOneWidget);
      expect(find.text('Learn More'), findsOneWidget);

      // Verify third-party disclosure mentions Azure, Gemini, and DeepSeek
      expect(find.textContaining('Microsoft Azure'), findsOneWidget);
      expect(find.textContaining('Google Gemini'), findsOneWidget);
      expect(find.textContaining('DeepSeek'), findsOneWidget);
    });

    testWidgets('renders localized content in French', (tester) async {
      await tester.pumpWidget(
        _buildApp(
          locale: const Locale('fr'),
          child: const AiConsentSheet(),
        ),
      );
      await tester.pumpAndSettle();

      expect(
          find.text('Fonctionnalités IA et Confidentialité'), findsOneWidget);
      expect(find.text('Données transmises'), findsOneWidget);
      expect(find.text("Services d'IA tiers"), findsOneWidget);
      expect(find.text('Garanties de confidentialité'), findsOneWidget);
      expect(find.text("Accepter et utiliser l'IA"), findsOneWidget);
      expect(find.text('En savoir plus'), findsOneWidget);
    });

    testWidgets('ensureConsent displays sheet and persists preference on agree',
        (tester) async {
      SharedPreferences.setMockInitialValues({});
      bool? consentResult;

      await tester.pumpWidget(
        _buildApp(
          child: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () async {
                consentResult = await AiConsentSheet.ensureConsent(context);
              },
              child: const Text('Open Consent'),
            ),
          ),
        ),
      );

      // Tap to request consent
      await tester.tap(find.text('Open Consent'));
      await tester.pumpAndSettle();

      // Modal should be visible
      expect(find.byType(AiConsentSheet), findsOneWidget);
      expect(find.text('Agree to Use AI'), findsOneWidget);

      // Tap Agree to Use AI
      await tester.tap(find.text('Agree to Use AI'));
      await tester.pumpAndSettle();

      // Sheet should be dismissed and result true
      expect(find.byType(AiConsentSheet), findsNothing);
      expect(consentResult, isTrue);

      // Verify SharedPreferences persistence
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool(AiConsentSheet.prefKey), isTrue);

      // Calling ensureConsent again should return true immediately with NO sheet
      consentResult = null;
      await tester.tap(find.text('Open Consent'));
      await tester.pump();

      expect(find.byType(AiConsentSheet), findsNothing);
      expect(consentResult, isTrue);
    });

    testWidgets('ensureConsent returns false when dismissed without agreement',
        (tester) async {
      SharedPreferences.setMockInitialValues({});
      bool? consentResult;

      await tester.pumpWidget(
        _buildApp(
          child: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () async {
                consentResult = await AiConsentSheet.ensureConsent(context);
              },
              child: const Text('Open Consent'),
            ),
          ),
        ),
      );

      // Open sheet
      await tester.tap(find.text('Open Consent'));
      await tester.pumpAndSettle();
      expect(find.byType(AiConsentSheet), findsOneWidget);

      // Dismiss without tapping Agree (tap barrier)
      await tester.tapAt(const Offset(20, 20));
      await tester.pumpAndSettle();

      expect(find.byType(AiConsentSheet), findsNothing);
      expect(consentResult, isFalse);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool(AiConsentSheet.prefKey), isNull);
    });
  });

  group('PinyinUtils and French Encoding Regression', () {
    test('convertNumericToMarks does not corrupt French words containing v', () {
      const frenchSentence =
          'Par exemple, vous pouvez voir la différence au niveau 1.';
      final result = PinyinUtils.convertNumericToMarks(frenchSentence);
      expect(result, equals(frenchSentence));
      expect(result.contains('üous'), isFalse);
      expect(result.contains('pouüez'), isFalse);
      expect(result.contains('üoir'), isFalse);
      expect(result.contains('niüeau'), isFalse);
    });

    test('convertNumericToMarks correctly converts pinyin syllables with v or u:',
        () {
      expect(PinyinUtils.convertNumericToMarks('lv4'), equals('lǜ'));
      expect(PinyinUtils.convertNumericToMarks('nv3'), equals('nǚ'));
      expect(PinyinUtils.convertNumericToMarks('lu:4'), equals('lǜ'));
      expect(PinyinUtils.convertNumericToMarks('nu:3'), equals('nǚ'));
      expect(PinyinUtils.convertNumericToMarks('lve4'), equals('lüè'));
      expect(PinyinUtils.convertNumericToMarks('nve4'), equals('nüè'));
      expect(PinyinUtils.convertNumericToMarks('ni3 hao3'), equals('nǐ hǎo'));
    });
  });
}
