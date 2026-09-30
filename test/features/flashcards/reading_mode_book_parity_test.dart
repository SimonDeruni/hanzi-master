@Tags(<String>['locale-sweep'])
library;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/review_stats.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_mode.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/settings_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/modes/reading_mode.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/swipe_to_grade_hint.dart';
import 'package:hanzi_master/shared/widgets/swipeable_flashcard.dart';
import 'package:hanzi_master/shared/widgets/zen_flip_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../support/locale_layout_harness.dart';

/// Removes `//` comments so documenting an idiom is not mistaken for using it.
String _withoutLineComments(String source) =>
    source.split('\n').map((String line) {
      final int index = line.indexOf('//');
      return index == -1 ? line : line.substring(0, index);
    }).join('\n');

const String _modePath =
    'lib/features/flashcards/presentation/widgets/modes/reading_mode.dart';
const String _hintPath = 'lib/shared/widgets/swipe_to_grade_hint.dart';

late SharedPreferences _prefs;

/// A two-character word, the shape the deck falls back to Reading mode for.
Flashcard _card() => const Flashcard(
      id: 'card-aihao',
      deckId: 'deck-a',
      hanzi: '爱好',
      pinyin: 'ài hào',
      definition: 'to like; to take pleasure in; keen on; interest; hobby',
      hskLevel: 1,
      strokePaths: <String>[],
      modeStats: <StudyMode, ReviewStats>{},
    );

Widget _host(BuildContext context) => ProviderScope(
      overrides: <Override>[
        sharedPreferencesProvider.overrideWithValue(_prefs),
      ],
      child: ReadingModeWidget(
        card: _card(),
        dueCount: 3,
        newCount: 17,
        learningCount: 3,
      ),
    );

/// The same screen inside a chosen theme, so brightness can be asserted.
Widget _themedHost({
  required ThemeData theme,
  Locale locale = const Locale('en'),
}) {
  return ProviderScope(
    overrides: <Override>[
      sharedPreferencesProvider.overrideWithValue(_prefs),
    ],
    child: MaterialApp(
      theme: theme,
      locale: locale,
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: ReadingModeWidget(
        card: _card(),
        dueCount: 3,
        newCount: 17,
        learningCount: 3,
      ),
    ),
  );
}

/// The fill of every card face still using the study card's 32px corner.
Iterable<Color?> _cardFaces(WidgetTester tester) => tester
    .widgetList<Container>(find.byType(Container))
    .map((Container c) => c.decoration)
    .whereType<BoxDecoration>()
    .where((BoxDecoration d) => d.borderRadius == BorderRadius.circular(32))
    .map((BoxDecoration d) => d.color);

void main() {
  setUp(() async {
    // English definitions keep TranslatedDefinition off the translation
    // service, so the screen under test renders deterministically.
    SharedPreferences.setMockInitialValues(<String, Object>{
      'use_english_definitions': true,
    });
    _prefs = await SharedPreferences.getInstance();
  });

  group('the screen wears the book-screen surface', () {
    testWidgets('the scaffold background is the canonical surface',
        (WidgetTester tester) async {
      await pumpLocalizedScreen(tester, builder: _host, locale: 'en');

      final Scaffold scaffold =
          tester.widget<Scaffold>(find.byType(Scaffold).first);
      expect(scaffold.backgroundColor, AppTheme.surfaceLight);
    });

    testWidgets('the card fill follows the brightness, not Colors.white',
        (WidgetTester tester) async {
      // The old card was `isDark ? Colors.white.withAlpha(12) : Colors.white`,
      // so it stayed a milky wash in dark mode. Asserting the dark token can
      // only pass if the palette is actually consulted.
      await tester.pumpWidget(_themedHost(theme: AppTheme.darkTheme));
      await tester.pumpAndSettle();
      expect(_cardFaces(tester), contains(AppTheme.cardBgDark));

      await tester.pumpWidget(_themedHost(theme: AppTheme.lightTheme));
      await tester.pumpAndSettle();
      expect(_cardFaces(tester), contains(AppTheme.cardBgLight));
    });
  });

  group('the legend teaches the gesture instead of printing emoji', () {
    testWidgets('revealing the card shows the four grade chips',
        (WidgetTester tester) async {
      await pumpLocalizedScreen(tester, builder: _host, locale: 'en');

      // There is nothing to grade before the answer is revealed.
      expect(find.byType(SwipeToGradeHint), findsNothing);

      await tester.tap(find.byType(ZenFlipCard));
      await tester.pumpAndSettle();

      expect(find.byType(SwipeToGradeHint), findsOneWidget);
      for (final String label in <String>['Again', 'Good', 'Easy', 'Hard']) {
        expect(find.text(label), findsOneWidget, reason: label);
      }
    });

    testWidgets('no label is an emoji arrow', (WidgetTester tester) async {
      await pumpLocalizedScreen(tester, builder: _host, locale: 'en');
      await tester.tap(find.byType(ZenFlipCard));
      await tester.pumpAndSettle();

      // The old hint was one Text of `'⬅️ Again ➡️ Good ⬆️ Easy ⬇️ Hard'`,
      // which rendered as four tofu boxes wherever the emoji font was missing
      // — exactly what the report screenshotted.
      for (final String arrow in <String>[
        '\u2B05',
        '\u27A1',
        '\u2B06',
        '\u2B07'
      ]) {
        expect(
          find.textContaining(arrow),
          findsNothing,
          reason: 'U+${arrow.codeUnitAt(0).toRadixString(16)}',
        );
      }
    });

    testWidgets('the legend fits the tightest viewport in every locale',
        (WidgetTester tester) async {
      // Four localized grade names on a 320px screen at the largest system
      // text scale is the worst case this layout has to survive.
      for (final String locale in <String>['de', 'ru', 'th']) {
        for (final double scale in kTextScales) {
          await pumpLocalizedScreen(
            tester,
            builder: _host,
            locale: locale,
            size: const Size(320, 568),
            textScale: scale,
          );
          await tester.tap(find.byType(ZenFlipCard));
          await tester.pumpAndSettle();

          expectNoOverflow(
            tester,
            reason: '$locale at 320x568 and ${scale}x text scale',
          );
        }
      }
    });
    // Where the legend's cost lands, measured on the smallest supported screen.
    // The legend is a sibling of the card's `Expanded`, so every pixel of its
    // strip comes straight out of the surface the learner has to swipe on:
    //
    //   de 1.0x  surface 464 -> 347  (legend 101)
    //   ru 2.0x  surface 464 -> 308  (legend 140)
    //   de 2.0x  surface 464 -> 264  (legend 184)
    //
    // At 2x text the clamped chips stop fitting two to a row, so the legend is
    // 82% taller than at 1x even though its own text is clamped to 1.3x: the
    // row count, not the text scale, is what drives the strip. That residual is
    // the deliberate balance (`SwipeToGradeHint`'s clamp comment), so these two
    // tests pin it rather than forbid it — the card may not lose more than the
    // legend is worth, and it may not be squeezed below a usable swipe target.
    for (final String locale in <String>['de', 'ru', 'th']) {
      for (final double scale in kTextScales) {
        testWidgets('the strip costs the card the legend and nothing else',
            (WidgetTester tester) async {
          // A fresh test per combination: `_isRevealed` lives in the mode's
          // State, so re-pumping inside one test would measure a card that is
          // already revealed.
          await pumpLocalizedScreen(
            tester,
            builder: _host,
            locale: locale,
            size: const Size(320, 568),
            textScale: scale,
          );

          final double surface =
              tester.getRect(find.byType(SwipeableFlashcard)).height;
          await tester.tap(find.byType(ZenFlipCard));
          await tester.pumpAndSettle();

          final double spent =
              surface - tester.getRect(find.byType(SwipeableFlashcard)).height;
          final double legend =
              tester.getRect(find.byType(SwipeToGradeHint)).height;

          expect(
            spent,
            legend + SwipeToGradeHint.stripPadding.vertical,
            reason: '$locale at ${scale}x, 320x568: the card lost '
                '${spent}dp to a ${legend}dp legend, so something other than '
                'the legend strip is taking surface',
          );
          // The measured cost of the strip, per worst-case combination, with
          // 8dp of slack for font metrics. The numbers are the price of
          // teaching the gesture under the card, and they are pinned: an extra
          // 16dp of strip (the value four hosts used to carry) fails here.
          const Map<String, double> spentCap = <String, double>{
            'de@1.0': 117.0, // legend 101
            'de@2.0': 200.0, // legend 184 — the worst case measured
            'ru@1.0': 117.0,
            'ru@2.0': 156.0, // legend 140
            'th@1.0': 117.0,
            'th@2.0': 156.0,
          };
          expect(
            spent,
            lessThanOrEqualTo(
                spentCap['$locale@${scale.toStringAsFixed(1)}']! + 8),
            reason: '$locale at ${scale}x, 320x568: the legend strip took '
                '${spent}dp of the ${surface}dp swipe surface',
          );
        });
      }
    }
  });

  group('the mode dropped the old Material vocabulary', () {
    late String source;

    setUpAll(() {
      source = _withoutLineComments(File(_modePath).readAsStringSync());
    });

    test('no rainbow, no raw greys, no shade tints', () {
      // The card was `Colors.white` / `black12`, its text `black87`, `black45`
      // and `black54`, and the hint `white54` / `white70` — none of them from
      // the palette, and all of them unreadable in the other brightness.
      for (final String literal in <String>[
        'Colors.blue',
        'Colors.green',
        'Colors.orange',
        'Colors.red',
        'Colors.purple',
        'Colors.grey',
        'Colors.black12',
        'Colors.white12',
        'black45',
        'black54',
        'black87',
        'white54',
        'white70',
        'shade50',
        'shade200',
        'shade800',
        'shade900',
        'withAlpha',
      ]) {
        expect(source, isNot(contains(literal)), reason: literal);
      }
    });

    test('the surface, the card and the ink come from the palette', () {
      expect(source, contains('AppTheme.surfaceOf(context)'));
      expect(source, contains('AppTheme.cardBgOf(context)'));
      expect(source, contains('AppTheme.carbonInkLight'));
      expect(source, contains('AppTheme.carbonInkDark'));
      expect(source, contains('const Color(0xFFD4AF37)'),
          reason: "Emperor's Gold hairline");
    });

    test('the emoji hint is gone and the seal legend is used', () {
      expect(source, isNot(contains('\u2B05')));
      expect(source, isNot(contains('\u27A1')));
      expect(source, contains('SwipeToGradeHint'));
    });
  });

  group('the legend and the swipe stamps share one vocabulary', () {
    late String hint;

    setUpAll(() {
      hint = _withoutLineComments(File(_hintPath).readAsStringSync());
    });

    test('every chip takes its colour from the Hanko seal it explains', () {
      for (final String seal in <String>[
        'HankoSealData.again',
        'HankoSealData.good',
        'HankoSealData.easy',
        'HankoSealData.hard',
      ]) {
        expect(hint, contains(seal), reason: seal);
      }
    });

    test('it is built from the palette and can wrap', () {
      expect(hint, isNot(contains('Colors.')));
      expect(hint, contains('AppTheme.carbonInkLight'));
      expect(hint, contains('AppTheme.carbonInkDark'));
      // Four localized grade names cannot share one line at 320px and 2x text.
      expect(hint, contains('Wrap('));
      expect(hint, contains('WrapAlignment.center'));
    });
  });
}
