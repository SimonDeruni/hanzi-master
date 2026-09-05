import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/deck_settings_sheet.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

void main() {
  final deck = Deck(
    id: 'hunan-dialect',
    name: 'hunan dialect',
    createdAt: DateTime(2026),
  );
  late AppLocalizations englishLocalizations;

  setUpAll(() async {
    englishLocalizations =
        await AppLocalizations.delegate.load(const Locale('en'));
  });

  for (final locale in AppLocalizations.supportedLocales) {
    testWidgets(
      'deck settings framing is localized in ${locale.languageCode}',
      (tester) async {
        await tester.binding.setSurfaceSize(const Size(1000, 1600));
        addTearDown(() => tester.binding.setSurfaceSize(null));

        final localizations = await AppLocalizations.delegate.load(locale);

        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              locale: locale,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              home: Scaffold(body: DeckSettingsSheet(deck: deck)),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text(localizations.deckSettings), findsOneWidget);
        expect(find.text(localizations.tapTheValueToEnter), findsNWidgets(2));
        expect(find.text(localizations.saveSettings), findsOneWidget);

        if (locale.languageCode != 'en') {
          expect(localizations.deckSettings,
              isNot(englishLocalizations.deckSettings));
          expect(localizations.saveSettings,
              isNot(englishLocalizations.saveSettings));
          expect(
            localizations.tapTheValueToEnter,
            isNot(englishLocalizations.tapTheValueToEnter),
          );
        }
      },
    );
  }

  testWidgets('deck settings use the expected French copy', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1000, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          locale: const Locale('fr'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(body: DeckSettingsSheet(deck: deck)),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Paramètres du paquet'), findsOneWidget);
    expect(
      find.text('Appuyez sur la valeur pour saisir une limite exacte.'),
      findsNWidgets(2),
    );
    expect(find.text('Enregistrer les paramètres'), findsOneWidget);
    expect(find.text('Deck Settings'), findsNothing);
    expect(find.text('Tap the value to enter an exact limit.'), findsNothing);
    expect(find.text('Save Settings'), findsNothing);
  });
}
