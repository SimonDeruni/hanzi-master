import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/media/domain/models/media_briefing.dart';
import 'package:hanzi_master/features/media/presentation/widgets/premium_ai_prep_card.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

void main() {
  group('MediaBriefing localized title', () {
    test('parses and displays a generated localized title', () {
      final briefing = MediaBriefing.fromJson({
        'localizedTitle': 'Comment faire sauter le chou',
        'summary': 'Résumé en français',
        'hardWords': <String>['白菜'],
      });

      expect(briefing.displayTitle('How to Stir-Fry Cabbage'),
          'Comment faire sauter le chou');
    });

    test('falls back to the source title for an older API response', () {
      final briefing = MediaBriefing.fromJson({
        'summary': 'Résumé en français',
        'hardWords': <String>[],
      });

      expect(briefing.displayTitle('How to Stir-Fry Cabbage'),
          'How to Stir-Fry Cabbage');
    });
  });

  testWidgets('AI prep card displays a French generated summary',
      (tester) async {
    const frenchSummary =
        'Cette vidéo présente une recette maison détaillée de chou sauté.';

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
        home: Scaffold(
          body: PremiumAiPrepCard(
            briefing: MediaBriefing(
              summary: frenchSummary,
              hardWords: const ['白菜', '粉丝'],
            ),
            onWordTapped: (_) {},
          ),
        ),
      ),
    );

    await tester.tap(find.text('Salle de préparation IA'));
    await tester.pumpAndSettle();

    expect(find.text('RÉSUMÉ DE LA LEÇON'), findsOneWidget);
    expect(find.text(frenchSummary), findsOneWidget);
  });
}
