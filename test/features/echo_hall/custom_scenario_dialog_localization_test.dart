import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/echo_hall/presentation/widgets/custom_scenario_dialog.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

void main() {
  for (final locale in AppLocalizations.supportedLocales) {
    testWidgets(
      'custom scenario form is localized for ${locale.languageCode}',
      (tester) async {
        await tester.binding.setSurfaceSize(const Size(430, 1000));
        addTearDown(() => tester.binding.setSurfaceSize(null));

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
              home: const Scaffold(body: CustomScenarioDialog()),
            ),
          ),
        );
        await tester.pump();

        final l10n = lookupAppLocalizations(locale);
        final expectedStrings = <String>[
          l10n.createYourScenario,
          l10n.designCustomAiRoleplay,
          l10n.random,
          l10n.scenarioTopic,
          l10n.surpriseMe2,
          l10n.targetDifficulty,
          l10n.beginner,
          l10n.intermediate,
          l10n.advanced,
          l10n.native,
          l10n.master,
          l10n.contextSettingOptional,
          l10n.roleplayCreatorContextPlaceholder,
          l10n.aiCharacterPersonaOptional,
          l10n.rollCharacter2,
          l10n.roleplayCreatorPersonaPlaceholder,
          l10n.createScenario,
        ];

        for (final value in expectedStrings) {
          expect(
            find.text(value),
            findsOneWidget,
            reason: '${locale.languageCode} should render "$value"',
          );
        }
        expect(tester.takeException(), isNull);
      },
    );
  }

  test('creator strings are complete and localized in every locale', () {
    final english = _creatorStrings(lookupAppLocalizations(const Locale('en')));

    for (final locale in AppLocalizations.supportedLocales) {
      final values = _creatorStrings(lookupAppLocalizations(locale));
      expect(values.every((value) => value.trim().isNotEmpty), isTrue);
      if (locale.languageCode != 'en') {
        expect(
          values,
          isNot(equals(english)),
          reason: '${locale.languageCode} should not fall back to English',
        );
      }
    }
  });
}

List<String> _creatorStrings(AppLocalizations l10n) => <String>[
      l10n.designCustomAiRoleplay,
      l10n.random,
      l10n.scenarioTopic,
      l10n.surpriseMe2,
      l10n.targetDifficulty,
      l10n.beginner,
      l10n.intermediate,
      l10n.advanced,
      l10n.native,
      l10n.master,
      l10n.contextSettingOptional,
      l10n.roleplayCreatorContextPlaceholder,
      l10n.aiCharacterPersonaOptional,
      l10n.rollCharacter2,
      l10n.roleplayCreatorPersonaPlaceholder,
    ];
