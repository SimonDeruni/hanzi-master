import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/services/analytics_service.dart';
import 'package:hanzi_master/core/services/api_key_pool.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/core/services/speech_service.dart';
import 'package:hanzi_master/features/live_translate/presentation/screens/travel_interpreter_screen.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

class _FakeSpeechService extends SpeechService {
  @override
  Future<bool> init() async => true;
}

class _FakeGeminiService extends GeminiService {
  _FakeGeminiService()
      : super(pool: ApiKeyPool(), analytics: AnalyticsService());

  List<Map<String, dynamic>>? capturedMessages;

  @override
  Future<String> makeOpenRouterCall({
    required String model,
    required List<Map<String, dynamic>> messages,
    bool jsonMode = false,
    Duration? timeout,
    int maxTokens = 2048,
    bool useCache = true,
  }) async {
    capturedMessages = messages;
    return 'Bonjour';
  }
}

Widget _buildInterpreter(Locale locale, {_FakeGeminiService? geminiService}) {
  return ProviderScope(
    overrides: [
      speechServiceProvider.overrideWithValue(_FakeSpeechService()),
      if (geminiService != null)
        geminiServiceProvider.overrideWithValue(geminiService),
    ],
    child: MaterialApp(
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const TravelInterpreterScreen(),
    ),
  );
}

void main() {
  testWidgets(
      'Interpreter uses and displays the app language and follows locale changes',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(430, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(_buildInterpreter(const Locale('fr')));
    await tester.pump();

    expect(find.text('Vous (Français)'), findsOneWidget);
    expect(find.text('Partenaire (Mandarin)'), findsOneWidget);
    expect(find.text('Prêt à interpréter'), findsOneWidget);
    expect(find.text('You (English)'), findsNothing);

    await tester.pumpWidget(_buildInterpreter(const Locale('th')));
    await tester.pump();

    expect(find.text('คุณ (ไทย)'), findsOneWidget);
    expect(find.text('คู่สนทนา (ภาษาจีนกลาง)'), findsOneWidget);
    expect(find.text('พร้อมสำหรับการแปลภาษา'), findsOneWidget);
    expect(find.text('Vous (Français)'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('partner Mandarin is translated into the app language',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(430, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final geminiService = _FakeGeminiService();

    await tester.pumpWidget(
      _buildInterpreter(const Locale('fr'), geminiService: geminiService),
    );
    await tester.pump();

    await tester.tap(find.byIcon(Icons.keyboard).first);
    await tester.pump();
    await tester.enterText(find.byType(TextField), '你好');
    final sendButton = tester.widget<ElevatedButton>(
      find.widgetWithText(ElevatedButton, 'Envoyer'),
    );
    sendButton.onPressed!();
    await tester.pump();

    expect(
      geminiService.capturedMessages?.first['content'],
      contains('from Mandarin to French'),
    );
    expect(tester.takeException(), isNull);
  });
}
