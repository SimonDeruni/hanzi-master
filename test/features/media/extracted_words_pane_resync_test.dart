/// The card list that reviews extracted words beside the page (iPad, #48).
///
/// **The bug:** `_ExtractedWordsReviewSheetState` seeds `_selected` once, in
/// `initState`, from `widget.words.length` — the ticks are addressed by index.
/// The modal sheet is always a fresh route, so that never mattered there, but
/// the iPad pane keeps the same `State` alive when a second "Extract to Deck"
/// run beside the page hands it a different word list. The ticks then still
/// belong to the previous list:
///
///   * a longer new list indexes past the end of `_selected` (RangeError), and
///   * a shorter one counts the old ticks, so the header reads "4 sur 3 mots
///     sélectionnés" — and a single card can render unselected while the header
///     claims every word is selected. "Ajouter…" then saves the words the stale
///     ticks point at, not what the cards show.
///
/// The cards, the counter and the words that get saved must agree with the list
/// they are showing. These tests pump the real sheet — Hive boxes are only
/// needed by its buttons, and the definition lookup is stubbed — and swap the
/// word list under the pane exactly as a second extraction does.
@Tags(<String>['ipad-sweep'])
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/core/services/local_translation_service.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/settings_controller.dart';
import 'package:hanzi_master/features/media/presentation/screens/web_browser_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../support/locale_layout_harness.dart';

/// Answered in the app language, so a card never reaches for the network.
/// Records what each card asked for, which is how the deck refresh card's
/// dictionary resolution is pinned.
class _StubTranslationService extends LocalTranslationService {
  _StubTranslationService() : super(targetLanguage: 'French');

  final List<String?> requestedHanzi = <String?>[];
  final List<String> requestedDefinitions = <String>[];

  @override
  Future<String> translateEnglishDefinition(String definition,
      {String? hanzi}) async {
    requestedDefinitions.add(definition);
    requestedHanzi.add(hanzi);
    return 'Définition localisée';
  }
}

AiWord _word(String hanzi) => AiWord(
      hanzi: hanzi,
      pinyin: 'pīnyīn',
      meaning: 'Définition du modèle',
    );

/// Hosts the sheet the way the browser pane does: a stable child of a stable
/// parent, so swapping the words reuses the same `State`.
class _PaneHost extends StatefulWidget {
  const _PaneHost({required this.first, required this.second});

  final List<AiWord> first;
  final List<AiWord> second;

  @override
  State<_PaneHost> createState() => _PaneHostState();
}

class _PaneHostState extends State<_PaneHost> {
  late List<AiWord> _words = widget.first;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextButton(
          key: const Key('nextExtraction'),
          onPressed: () => setState(() => _words = widget.second),
          child: const Text('next extraction'),
        ),
        ExtractedWordsReviewSheet(deckName: 'Article: 测试', words: _words),
      ],
    );
  }
}

late SharedPreferences _prefs;
late _StubTranslationService _translations;

Future<void> _pumpPane(
  WidgetTester tester, {
  required List<AiWord> first,
  required List<AiWord> second,
}) async {
  _translations = _StubTranslationService();
  await pumpLocalizedScreen(
    tester,
    locale: 'fr',
    size: const Size(1366, 1024), // iPad Pro 12.9" landscape, the pane's home.
    builder: (BuildContext context) => ProviderScope(
      overrides: <Override>[
        sharedPreferencesProvider.overrideWithValue(_prefs),
        localTranslationServiceProvider.overrideWithValue(_translations),
      ],
      child: _PaneHost(first: first, second: second),
    ),
  );
}

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues(<String, Object>{'app_locale': 'fr'});
    _prefs = await SharedPreferences.getInstance();
    await _prefs.setBool('use_english_definitions', false);
  });

  testWidgets('a longer second extraction does not index past the old ticks',
      (WidgetTester tester) async {
    await _pumpPane(
      tester,
      first: <AiWord>[_word('总理'), _word('澳洲'), _word('平衡')],
      second: <AiWord>[
        _word('总理'),
        _word('澳洲'),
        _word('平衡'),
        _word('陆军'),
        _word('会晤'),
      ],
    );

    await tester.tap(find.byKey(const Key('nextExtraction')));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull,
        reason: 'The pane must survive a second extraction');
    expect(find.byIcon(Icons.check_circle_rounded), findsNWidgets(5),
        reason: 'Every card of the new list starts selected');
    expect(find.text('5 sur 5 mots sélectionnés'), findsOneWidget);
  });

  testWidgets('a shorter second extraction re-counts against its own cards',
      (WidgetTester tester) async {
    await _pumpPane(
      tester,
      first: <AiWord>[
        _word('总理'),
        _word('澳洲'),
        _word('平衡'),
        _word('陆军'),
        _word('会晤'),
      ],
      second: <AiWord>[_word('总理'), _word('澳洲'), _word('平衡')],
    );

    // The learner turns one card off before the next run lands.
    await tester.tap(find.text('平衡'));
    await tester.pumpAndSettle();
    expect(find.text('4 sur 5 mots sélectionnés'), findsOneWidget);

    await tester.tap(find.byKey(const Key('nextExtraction')));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('3 sur 3 mots sélectionnés'), findsOneWidget,
        reason: 'The counter must describe the cards on screen');
    expect(find.byIcon(Icons.check_circle_rounded), findsNWidgets(3),
        reason: 'The new list carries no ticks from the previous one');
    expect(find.byIcon(Icons.radio_button_unchecked_rounded), findsNothing);
  });

  testWidgets('an unchanged word list keeps the learner\'s ticks',
      (WidgetTester tester) async {
    final List<AiWord> words = <AiWord>[
      _word('总理'),
      _word('澳洲'),
      _word('平衡'),
    ];

    await _pumpPane(tester, first: words, second: List<AiWord>.from(words));
    await tester.tap(find.text('澳洲'));
    await tester.pumpAndSettle();
    expect(find.text('2 sur 3 mots sélectionnés'), findsOneWidget);

    await tester.tap(find.byKey(const Key('nextExtraction')));
    await tester.pumpAndSettle();

    // A rebuild that carries the same words must not silently re-select what
    // the learner turned off.
    expect(find.text('2 sur 3 mots sélectionnés'), findsOneWidget);
  });

  testWidgets('each card names its word, so its definition is resolved per word',
      (WidgetTester tester) async {
    await _pumpPane(
      tester,
      first: <AiWord>[_word('总理'), _word('澳洲')],
      second: <AiWord>[_word('总理'), _word('澳洲')],
    );

    // Handing the resolver the word is what lets it read that word's dictionary
    // row and its `definition_<language>` cell. Without it the gloss is treated
    // as an untagged English string: the card is sent for machine translation
    // and shows the English source when that fails, which is how a French card
    // came to read "Prime Minister" while the dictionary held French for 总理.
    expect(_translations.requestedHanzi, <String?>['总理', '澳洲']);
    expect(_translations.requestedDefinitions.length, 2,
        reason: 'One lookup per card, not one per rebuild');
  });
}
