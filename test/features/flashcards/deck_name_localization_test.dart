/// A deck's name is shown in the reader's language wherever it appears.
///
/// **The reported defect.** The deck library listed "Culture et vie
/// quotidienne", "Sports et arts martiaux" … — it calls
/// `LocalizedDeckService.deckTitle` itself — but the deck it opened was headed
/// **"Fitness & Modern Training"**. `Deck.localizedName` handled `default` and
/// HSK 1–3 and then returned the deck's raw English `name`, so every thematic
/// deck and every HSK level from 4 up was English in the header, the delete
/// dialog, the dashboard and the shadowing deck picker.
library;

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/services/localized_deck_service.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

/// The reader's language for a widget in a fully localized app.
Future<String> _nameIn(
  WidgetTester tester, {
  required String deckId,
  required String englishName,
}) async {
  late String localized;
  await tester.pumpWidget(
    MaterialApp(
      locale: const Locale('fr'),
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: Builder(
        builder: (BuildContext context) {
          localized = Deck(
            id: deckId,
            name: englishName,
            createdAt: DateTime(2026),
          ).localizedName(context);
          return const SizedBox.shrink();
        },
      ),
    ),
  );
  return localized;
}

void main() {
  setUpAll(() async {
    // The thematic titles are data (assets/data/l10n/deck_descriptions_fr.json).
    await LocalizedDeckService.ensureLoaded('fr');
  });

  testWidgets('a thematic deck is headed by its translated title',
      (WidgetTester tester) async {
    final String name = await _nameIn(
      tester,
      deckId: 'thematic_fitness',
      englishName: 'Fitness & Modern Training',
    );

    // Read the asset directly: this fails if the delegation breaks *or* if the
    // French copy drifts, rather than agreeing with the code under test.
    final File asset = File('assets/data/l10n/deck_descriptions_fr.json');
    final Map<String, dynamic> french =
        json.decode(asset.readAsStringSync()) as Map<String, dynamic>;
    expect(name, (french['thematic_fitness'] as Map<String, dynamic>)['title']);
    expect(name, isNot(contains('Fitness')));
  });

  testWidgets('every HSK level is localized, not just 1 to 3',
      (WidgetTester tester) async {
    for (final String level in <String>['1', '2', '3', '4', '5', '6']) {
      final String name = await _nameIn(
        tester,
        deckId: 'hsk$level',
        englishName: 'HSK $level',
      );
      expect(
        name,
        isNot(equals('HSK $level')),
        reason: 'HSK $level fell back to the raw deck name',
      );
      expect(name, contains('HSK'), reason: name);
    }
  });

  testWidgets('a deck the catalogue does not know still shows its own name',
      (WidgetTester tester) async {
    final String name = await _nameIn(
      tester,
      deckId: 'a-user-made-deck',
      englishName: 'My own deck',
    );
    expect(name, 'My own deck');
  });
}
