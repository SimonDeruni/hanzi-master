import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/ai_deck_generator_sheet.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

void main() {
  for (final locale in AppLocalizations.supportedLocales) {
    testWidgets(
      'AI deck generator controls are localized in ${locale.languageCode}',
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
              home: const Scaffold(body: AiDeckGeneratorSheet()),
            ),
          ),
        );
        await tester.pumpAndSettle();

        for (final label in [
          localizations.beginner,
          localizations.intermediate,
          localizations.advanced,
          localizations.mixed,
          localizations.nounsOnly,
          localizations.verbsOnly,
          localizations.idiomsChengyu,
          localizations.fullSentences,
          localizations.generateDeck,
        ]) {
          expect(
            find.text(label),
            findsWidgets,
            reason: 'Missing "$label" for ${locale.languageCode}',
          );
        }

        expect(
          localizations.generateAdd.trim(),
          isNotEmpty,
          reason: 'Missing generateAdd for ${locale.languageCode}',
        );

        for (final label in [
          localizations.mixed,
          localizations.nounsOnly,
          localizations.verbsOnly,
          localizations.idiomsChengyu,
          localizations.fullSentences,
        ]) {
          expect(
            find.widgetWithText(ChoiceChip, label),
            findsOneWidget,
            reason: 'Missing focus chip "$label" for ${locale.languageCode}',
          );
        }
      },
    );
  }

  testWidgets('French labels use the expected copy and retain chip selection',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1000, 1600));
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
          home: Scaffold(body: AiDeckGeneratorSheet()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    for (final label in [
      'Débutant',
      'Intermédiaire',
      'Avancé',
      'Mixte',
      'Noms uniquement',
      'Verbes uniquement',
      'Idiomes (Chengyu)',
      'Phrases complètes',
      'Générer le deck',
    ]) {
      expect(find.text(label), findsOneWidget);
    }

    expect(
      tester
          .widget<ChoiceChip>(find.widgetWithText(ChoiceChip, 'Mixte'))
          .selected,
      isTrue,
    );
    final nounsChip = find.widgetWithText(ChoiceChip, 'Noms uniquement');
    await tester.ensureVisible(nounsChip);
    await tester.tap(nounsChip);
    await tester.pump();
    expect(tester.widget<ChoiceChip>(nounsChip).selected, isTrue);
  });
}
