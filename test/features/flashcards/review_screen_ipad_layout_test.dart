/// The calligraphy bench on a wide window — Part 2b of `docs/IPAD_ADAPTIVE_PLAN.md`,
/// *"Practice bench: a full-width canvas with the reference glyph beside it, not
/// above"*.
///
/// Reported from the iPad build (2026-09-29): **"Canvas should be bigger on iPad"**.
/// The square is bounded by the pane's *height*, and the stacked order spent ~218dp
/// of that on the glyph, its pinyin, the definition and the guide strip before the
/// canvas got any — a 1000x680 window showed a ~280dp writing surface in a 1000dp-wide
/// pane. Both halves of the fix are pinned here: the surface is *measured*, and the
/// phone layout the change must not disturb is measured too.
@Tags(<String>['ipad-sweep'])
library;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/review_stats.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_mode.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/settings_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/review_screen.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../support/locale_layout_harness.dart';

/// One stroke, so the canvas has something to draw. `loadStrokesFor` short-circuits
/// when `strokePaths` is not empty, so no repository is touched.
Flashcard _card(String hanzi) => Flashcard(
      id: 'card-$hanzi',
      deckId: 'hsk1',
      hanzi: hanzi,
      pinyin: 'ba',
      definition: 'written language',
      hskLevel: 2,
      strokePaths: const <String>['M 200 200 L 800 800'],
      medianPaths: const <List<Offset>>[
        <Offset>[Offset(200, 200), Offset(800, 800)],
      ],
      modeStats: const <StudyMode, ReviewStats>{},
    );

class _FakeFlashcardController extends FlashcardController {
  _FakeFlashcardController(this.cards);

  final List<Flashcard> cards;

  @override
  Future<List<Flashcard>> build() async => cards;
}

Future<void> _pumpBench(
  WidgetTester tester,
  Size size, {
  Locale locale = const Locale('en'),
  double textScale = 1.0,
}) async {
  SharedPreferences.setMockInitialValues(<String, Object>{});
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  final Flashcard card = _card('吧');

  tester.view.devicePixelRatio = 1.0;
  tester.view.physicalSize = size;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(
    ProviderScope(
      overrides: <Override>[
        flashcardControllerProvider
            .overrideWith(() => _FakeFlashcardController(<Flashcard>[card])),
        sharedPreferencesProvider.overrideWithValue(preferences),
      ],
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        locale: locale,
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        // min == max pins the scale, exactly as the locale sweep does.
        builder: (BuildContext context, Widget? child) =>
            MediaQuery.withClampedTextScaling(
          minScaleFactor: textScale,
          maxScaleFactor: textScale,
          child: child!,
        ),
        home: ReviewScreen(card: card),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

/// The writing surface itself, not the whole pane it is centred in.
Finder get _canvas => find.byKey(const ValueKey('practiceCanvas'));

void main() {
  group('the bench on a wide window', () {
    testWidgets('the reference moves beside the surface, and the surface gets the room',
        (WidgetTester tester) async {
      await _pumpBench(tester, const Size(1366, 1024));

      final AppLocalizations l10n =
          await AppLocalizations.delegate.load(const Locale('en'));
      final Rect reference = tester.getRect(find.text(l10n.drawThisCharacter));
      final Rect canvas = tester.getRect(_canvas);

      expect(canvas.left, greaterThan(reference.right),
          reason: 'the glyph is beside the surface, not stacked above it');
      expect(canvas.width, greaterThan(600),
          reason: 'measured 832dp on this window, against 591dp stacked; on the '
              '1000x680 window it was reported from, 488dp against 247dp');
      expect((canvas.width - canvas.height).abs(), lessThan(1.0),
          reason: 'the surface stays square');
      expectNoOverflow(tester, reason: 'iPad landscape bench in en');
    });

    testWidgets('a portrait tablet keeps the stacked order', (WidgetTester tester) async {
      // 1024x1366 is the same device rotated, and there the *width* is the tighter
      // side: a 300dp reference column would leave a smaller square than stacking.
      await _pumpBench(tester, const Size(1024, 1366));

      final AppLocalizations l10n =
          await AppLocalizations.delegate.load(const Locale('en'));
      expect(
        tester.getRect(_canvas).top,
        greaterThan(tester.getRect(find.text(l10n.drawThisCharacter)).bottom),
      );
      expectNoOverflow(tester, reason: 'iPad portrait bench in en');
    });
  });

  group('the phone bench is untouched', () {
    testWidgets('a phone stacks the same parts at the width the window allows',
        (WidgetTester tester) async {
      await _pumpBench(tester, const Size(390, 844));

      final AppLocalizations l10n =
          await AppLocalizations.delegate.load(const Locale('en'));
      final Rect canvas = tester.getRect(_canvas);

      expect(canvas.top, greaterThan(tester.getRect(find.text(l10n.drawThisCharacter)).bottom),
          reason: 'the reference stays above the surface');
      expect(canvas.width, closeTo(390 - 40, 0.5),
          reason: 'the surface is still the pane width minus its 20dp padding');
    });

    testWidgets('a portrait Split View half is not treated as a wide window',
        (WidgetTester tester) async {
      // 700dp is `medium` — a tablet, but a tall one, and the iPad treatment is gated
      // on the window being wider than it is tall. This must behave like the phone.
      await _pumpBench(tester, const Size(700, 1000));

      final AppLocalizations l10n =
          await AppLocalizations.delegate.load(const Locale('en'));
      expect(
        tester.getRect(_canvas).top,
        greaterThan(tester.getRect(find.text(l10n.drawThisCharacter)).bottom),
      );
    });
  });

  group('a landscape phone is rescued rather than crushed', () {
    testWidgets('it gets a surface at all', (WidgetTester tester) async {
      // Not the reported bug, but the same arithmetic: the stacked order needs ~241dp
      // of chrome above the canvas and 96dp of action below it inside a 390dp-high
      // window, and it lost — 3px of `RenderFlex` overflow and a canvas measuring 0x0.
      // Side by side there is no such sum to lose.
      await _pumpBench(tester, const Size(844, 390));

      final Rect canvas = tester.getRect(_canvas);
      expect(canvas.width, greaterThanOrEqualTo(190),
          reason: 'measured 198dp side by side; the stacked order gave 0x0');
      expectNoOverflow(tester, reason: 'landscape phone bench in en');
    });
  });

  group("the strip and the score are in the reader's language", () {
    // Both were hardcoded in English — the strip beside the canvas in
    // `review_screen.dart` and the score line inside `drawing_canvas.dart` ("Score:
    // N/A") — so the French iPad build showed them in the middle of a French screen,
    // next to "Dessinez ce caractère :" and "Passer le trait actuel".
    testWidgets('French', (WidgetTester tester) async {
      await _pumpBench(tester, const Size(1366, 1024), locale: const Locale('fr'));
      final AppLocalizations fr =
          await AppLocalizations.delegate.load(const Locale('fr'));

      expect(find.text(fr.followTheGuideStroke), findsOneWidget);
      // The ungraded line: `scoreValue` with the dash `_scoreLine` passes.
      expect(find.text(fr.scoreValue('—')), findsOneWidget);

      for (final String english in <String>['Follow the guide stroke', 'Score: N/A']) {
        expect(find.text(english), findsNothing,
            reason: '"$english" is untranslated on this screen');
      }
    });
  });

  group('the side-by-side column survives the longest translations', () {
    testWidgets('at 2.0x text scale on the narrowest landscape window',
        (WidgetTester tester) async {
      // The reference column is bounded by the window now instead of by its own
      // content, which is what its scroll view is for; 844x390 is the tightest window
      // that still takes the side-by-side form.
      for (final String locale in <String>['ru', 'vi', 'th', 'ar']) {
        await _pumpBench(
          tester,
          const Size(844, 390),
          locale: Locale(locale),
          textScale: 2.0,
        );
        expectNoOverflow(tester, reason: '$locale at 2.0x on 844x390');
      }
    });
  });
}
