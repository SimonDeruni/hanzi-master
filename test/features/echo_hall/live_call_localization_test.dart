import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/chat/domain/entities/chat_message.dart';
import 'package:hanzi_master/features/echo_hall/presentation/screens/live_call_screen.dart';
import 'package:hanzi_master/features/echo_hall/presentation/widgets/live_call_summary_screen.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

void main() {
  Widget createSummaryWidget(Locale locale) {
    return MaterialApp(
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: LiveCallSummaryScreen(
        transcript: [
          LiveCallMessage(
            text: '你好',
            pinyin: 'nǐ hǎo',
            translation: 'Bonjour',
            role: ChatRole.user,
            grade: {
              'score': 96,
              'accuracy': 96,
              'fluency': 100,
              'words': [
                {
                  'word': '你',
                  'pinyin': 'nǐ',
                  'expectedTone': 3,
                  'actualTone': 3,
                  'isCorrect': true,
                },
                {
                  'word': '好',
                  'pinyin': 'hǎo',
                  'expectedTone': 3,
                  'actualTone': 3,
                  'isCorrect': true,
                }
              ]
            },
          ),
          LiveCallMessage(
            text: '你好，请坐。',
            pinyin: 'nǐ hǎo, qǐng zuò.',
            translation: 'Bonjour, asseyez-vous.',
            role: ChatRole.scholar,
          ),
        ],
        scholarVerdict: 'Analyse linguistique testée.',
      ),
    );
  }

  testWidgets('LiveCallSummaryScreen is fully localized in French', (tester) async {
    await tester.binding.setSurfaceSize(const Size(430, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(createSummaryWidget(const Locale('fr')));
    await tester.pumpAndSettle();

    // 1. Header & Acoustic card in French
    expect(find.text('ÉVALUATION DE LA PRONONCIATION AZURE'), findsOneWidget);
    expect(find.text('Score global'), findsOneWidget);
    expect(find.text('Précision des tons'), findsOneWidget);
    expect(find.text('Fluidité'), findsOneWidget);

    // 2. Transcript tags & review in French
    expect(find.text('VOUS'), findsOneWidget);
    expect(find.text('ÉRUDIT'), findsOneWidget);
    expect(find.text('Appuyez pour réviser'), findsOneWidget);

    // 3. Ensure English defaults are NOT present
    expect(find.text('AZURE PRONUNCIATION ASSESSMENT'), findsNothing);
    expect(find.text('Overall Score'), findsNothing);
    expect(find.text('Tone Accuracy'), findsNothing);
    expect(find.text('Fluency'), findsNothing);
    expect(find.text('Tap to review'), findsNothing);
    expect(find.text('YOU'), findsNothing);
    expect(find.text('SCHOLAR'), findsNothing);
  });

  testWidgets('LiveCallSummaryScreen is fully localized in German', (tester) async {
    await tester.binding.setSurfaceSize(const Size(430, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(createSummaryWidget(const Locale('de')));
    await tester.pumpAndSettle();

    // 1. Header & Acoustic card in German
    expect(find.text('AZURE-AUSSPRACHEBEWERTUNG'), findsOneWidget);
    expect(find.text('Gesamtpunktzahl'), findsOneWidget);
    expect(find.text('Ton-Genauigkeit'), findsOneWidget);
    expect(find.text('Flüssigkeit'), findsOneWidget);

    // 2. Transcript tags & review in German
    expect(find.text('DU'), findsOneWidget);
    expect(find.text('GELEHRTER'), findsOneWidget);
    expect(find.text('Zum Überprüfen tippen'), findsOneWidget);
  });

  testWidgets('LiveCallSummaryScreen is fully localized in Spanish', (tester) async {
    await tester.binding.setSurfaceSize(const Size(430, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(createSummaryWidget(const Locale('es')));
    await tester.pumpAndSettle();

    expect(find.text('EVALUACIÓN DE PRONUNCIACIÓN DE AZURE'), findsOneWidget);
    expect(find.text('Puntuación general'), findsOneWidget);
    expect(find.text('Precisión tonal'), findsOneWidget);
    expect(find.text('Fluidez'), findsOneWidget);
    expect(find.text('TÚ'), findsOneWidget);
    expect(find.text('ERUDITO'), findsOneWidget);
    expect(find.text('Toca para revisar'), findsOneWidget);
  });

  testWidgets('LiveCallSummaryScreen is fully localized in Russian', (tester) async {
    await tester.binding.setSurfaceSize(const Size(430, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(createSummaryWidget(const Locale('ru')));
    await tester.pumpAndSettle();

    expect(find.text('ОЦЕНКА ПРОИЗНОШЕНИЯ AZURE'), findsOneWidget);
    expect(find.text('Общий балл'), findsOneWidget);
    expect(find.text('Точность тонов'), findsOneWidget);
    expect(find.text('Беглость речи'), findsOneWidget);
    expect(find.text('ВЫ'), findsOneWidget);
    expect(find.text('УЧЕНЫЙ'), findsOneWidget);
    expect(find.text('Нажмите для разбора'), findsOneWidget);
  });
}
