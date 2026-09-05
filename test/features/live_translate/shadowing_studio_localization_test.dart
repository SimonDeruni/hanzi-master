import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/live_translate/presentation/screens/shadowing_studio_screen.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

void main() {
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
      'Studio de Répétition',
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
  });
}
