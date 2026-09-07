import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/live_translate/presentation/screens/shadowing_studio_screen.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

void main() {
  testWidgets('English subtitle uses a line break instead of visible slash-n',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(430, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          locale: Locale('en'),
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: ShadowingStudioScreen(),
        ),
      ),
    );

    expect(
      find.text(
        'Master your Mandarin pronunciation\nby mimicking native speech.',
      ),
      findsOneWidget,
    );
    expect(
      find.text(
        r'Master your Mandarin pronunciation\nby mimicking native speech.',
      ),
      findsNothing,
    );
  });

  testWidgets('Shadowing Studio configuration is localized in French',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(430, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          locale: Locale('fr'),
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: ShadowingStudioScreen(),
        ),
      ),
    );

    for (final text in <String>[
      'Studio de répétition',
      'Maîtrisez votre prononciation du mandarin\nen imitant des locuteurs natifs.',
      'Mode de pratique',
      'Flux libre',
      'Thématique',
      'Paquet (Cartes mémoire)',
      'Mot personnalisé',
      'COMMENCER LA SESSION',
    ]) {
      expect(find.text(text), findsOneWidget);
    }

    for (final text in <String>[
      'Shadowing Studio',
      'Master your Mandarin pronunciation by mimicking native speech.',
      'PRACTICE MODE',
      'Free Flow',
      'Thematic',
      'Deck (Flashcards)',
      'Custom Word',
      'START SESSION',
    ]) {
      expect(find.text(text), findsNothing);
    }

    expect(tester.takeException(), isNull);
  });

  for (final locale in AppLocalizations.supportedLocales) {
    testWidgets(
      'Shadowing Studio configuration renders in ${locale.languageCode}',
      (tester) async {
        await tester.binding.setSurfaceSize(const Size(430, 1200));
        addTearDown(() => tester.binding.setSurfaceSize(null));

        final l10n = await AppLocalizations.delegate.load(locale);
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
              home: const ShadowingStudioScreen(),
            ),
          ),
        );

        for (final text in <String>[
          l10n.shadowingStudio,
          l10n.masterYourMandarinPronunciationnbyM,
          l10n.practiceMode,
          l10n.freeFlow,
          l10n.thematic,
          l10n.deckFlashcards,
          l10n.customWord,
          l10n.startSession,
        ]) {
          expect(find.text(text), findsOneWidget);
        }

        expect(tester.takeException(), isNull);
      },
    );
  }
}
