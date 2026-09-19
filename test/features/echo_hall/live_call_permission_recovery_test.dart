import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/echo_hall/domain/entities/scenario.dart';
import 'package:hanzi_master/features/echo_hall/presentation/screens/live_call_screen.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({
      'has_agreed_to_ai_privacy': true,
    });
  });

  ConversationScenario createDummyScenario() {
    return ConversationScenario(
      id: 'doctor_1',
      title: 'Arztpraxis',
      description: 'At the doctor',
      initialAiMessage: '你好，哪里不舒服？',
      systemPrompt: 'Doctor persona',
      targetHskLevel: 2,
      avatarAssetPath: 'none',
      personaName: 'Zhāng yīshēng (张医生)',
    );
  }

  Widget createLiveCallWidget(Locale locale) {
    return ProviderScope(
      child: MaterialApp(
        locale: locale,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: LiveCallScreen(
          scenario: createDummyScenario(),
          disableExternalServicesForTesting: true,
          simulatePermissionDeniedForTesting: true,
        ),
      ),
    );
  }

  testWidgets('LiveCallScreen renders permission recovery UI in German when mic permission denied',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(430, 932));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(createLiveCallWidget(const Locale('de')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    // 1. Check title & localized initialization error in German
    expect(find.text('Arztpraxis'), findsOneWidget);
    expect(find.text('Initialisierungsfehler. Bitte Berechtigungen prüfen.'),
        findsOneWidget);

    // 2. Check helpful explanation message in German
    expect(
        find.text(
            'Mikrofonzugriff wurde nicht gewährt. Du kannst ihn in den Einstellungen aktivieren.'),
        findsOneWidget);

    // 3. Check recovery action buttons
    expect(find.byKey(const Key('live_call_open_settings_button')),
        findsOneWidget);
    expect(find.text('Einstellungen'), findsOneWidget);
    expect(find.byIcon(Icons.settings), findsOneWidget);

    expect(find.byKey(const Key('live_call_retry_button')), findsOneWidget);
    expect(find.text('Erneut versuchen'), findsOneWidget);
    expect(find.byIcon(Icons.refresh), findsOneWidget);

    expect(find.byKey(const Key('live_call_return_menu_button')),
        findsOneWidget);
    expect(find.text('Zurück zum Menü'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
  });

  testWidgets('LiveCallScreen renders permission recovery UI in English when mic permission denied',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(430, 932));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(createLiveCallWidget(const Locale('en')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    // 1. Check title & localized initialization error in English
    expect(find.text('Arztpraxis'), findsOneWidget);
    expect(find.text('Initialization error. Check permissions.'),
        findsOneWidget);

    // 2. Check helpful explanation message in English
    expect(
        find.text(
            'Microphone access was not granted. You can enable it in Settings.'),
        findsOneWidget);

    // 3. Check recovery action buttons
    expect(find.byKey(const Key('live_call_open_settings_button')),
        findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);

    expect(find.byKey(const Key('live_call_retry_button')), findsOneWidget);
    expect(find.text('Try Again'), findsOneWidget);

    expect(find.byKey(const Key('live_call_return_menu_button')),
        findsOneWidget);
    expect(find.text('Return to menu'), findsOneWidget);
  });
}
