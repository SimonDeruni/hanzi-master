import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/services/speech_service.dart';
import 'package:hanzi_master/features/live_translate/presentation/screens/travel_interpreter_screen.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

class _NoOpSpeechService extends SpeechService {
  @override
  Future<bool> init() async => true;
}

void main() {
  testWidgets('interpreter partner controls are localized in French',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(900, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          speechServiceProvider.overrideWithValue(_NoOpSpeechService()),
        ],
        child: const MaterialApp(
          locale: Locale('fr'),
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: TravelInterpreterScreen(),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Partenaire'), findsOneWidget);
    expect(find.text('Partenaire (Mandarin)'), findsOneWidget);
    expect(find.text('Vous'), findsOneWidget);
    expect(find.text('Prêt à interpréter'), findsOneWidget);
    expect(find.textContaining('Closure:'), findsNothing);
    expect(find.text('Partner'), findsNothing);
  });
}
