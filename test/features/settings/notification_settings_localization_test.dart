import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

void main() {
  testWidgets('notification settings content is localized in French',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) {
            final l10n = AppLocalizations.of(context)!;
            return Scaffold(
              body: Column(
                children: [
                  Text(l10n.chooseOneOptionalDailyPractice),
                  Text(l10n.practiceReminder),
                  Text(l10n.oneGentleReminderADay),
                  Text(
                    '${l10n.finishingPracticeSilencesTodayS} '
                    '${l10n.reEngagementAlertsAreCombined}',
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );

    expect(
      find.text("Choisissez un rappel d'entraînement quotidien optionnel."),
      findsOneWidget,
    );
    expect(find.text("Rappel d'entraînement"), findsOneWidget);
    expect(
      find.text('Un doux rappel par jour, uniquement si nécessaire'),
      findsOneWidget,
    );
    expect(
      find.text(
        "Terminer l'entraînement désactive le rappel du jour. Les alertes "
        'de révision et de relance sont combinées pour ne pas se cumuler.',
      ),
      findsOneWidget,
    );

    expect(
      find.text('Choose one optional daily practice reminder.'),
      findsNothing,
    );
    expect(find.text('Practice reminder'), findsNothing);
  });
}
