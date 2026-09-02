import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/settings/presentation/screens/ai_data_privacy_screen.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

void main() {
  testWidgets('shows AI providers, data categories, controls, and policy link',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('en'),
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: AiDataPrivacyScreen(),
      ),
    );

    expect(find.text('AI Data & Privacy'), findsOneWidget);
    expect(find.text('When AI is used'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('AI service providers'),
      200,
    );
    expect(find.textContaining('Google Gemini'), findsOneWidget);
    expect(find.textContaining('OpenRouter'), findsOneWidget);
    expect(find.textContaining('DeepSeek'), findsOneWidget);
    expect(find.textContaining('Microsoft Azure AI Speech'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Read Full Privacy Policy'),
      300,
    );
    expect(find.text('Your choices'), findsOneWidget);
    expect(find.text('Storage and retention'), findsOneWidget);
    expect(find.text('Read Full Privacy Policy'), findsOneWidget);
  });
}
