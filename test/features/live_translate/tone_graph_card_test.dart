import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/live_translate/presentation/widgets/tone_graph_card.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/tone_graph_help.dart';

import '../../support/locale_layout_harness.dart';

/// The shadowing graph's chrome — the parts that tell a learner what they are looking at.
///
/// The contour is the one graphic in the app whose meaning is not self-evident, and the
/// three things that make it readable are all chrome rather than paint: the lightbulb, the
/// legend naming the two strokes, and the empty state that distinguishes *"we measured
/// nothing"* from *"you got it wrong"*. Each has its own test because each was added for a
/// separate reason and each could be dropped without the graph looking broken.
///
/// The **lightbulb's panel** is the exception that needed two more: on the iPad it arrived
/// in English with an English legend (the seven `toneGraph*` keys existed only in
/// `app_en.arb`), and it arrived as one 590-character paragraph — 880 with the shadowing
/// studio's phrase note — behind a button tapped mid-drill.
Future<void> pumpCard(
  WidgetTester tester,
  Widget card, {
  Locale locale = const Locale('en'),
}) async {
  await tester.binding.setSurfaceSize(const Size(430, 900));
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
        home: Scaffold(
          body: SingleChildScrollView(child: card),
        ),
      ),
    ),
  );
  await tester.pump();
}

/// A take with a real contour: tone 2, rising.
const List<double?> measured = [150, 165, 180, 195];
const List<double?> target = [150, 170, 190, 210];

void main() {
  group('ToneGraphCard', () {
    testWidgets('names both strokes, because a contour has no meaning without a key',
        (tester) async {
      await pumpCard(
        tester,
        const ToneGraphCard(userPitch: measured, idealPitch: target),
      );

      expect(find.text('Your voice'), findsOneWidget);
      expect(find.text('Target'), findsOneWidget);
    });

    testWidgets('carries a lightbulb that explains how to read it', (tester) async {
      await pumpCard(
        tester,
        const ToneGraphCard(userPitch: measured, idealPitch: target),
      );

      expect(find.byIcon(Icons.lightbulb_outline), findsOneWidget);
    });

    testWidgets('the lightbulb opens the explanation, including its own note',
        (tester) async {
      // The phrase graph's two strokes are not time-aligned, and that difference is
      // exactly what a caller passes in — it must reach the panel, not be swallowed.
      await pumpCard(
        tester,
        const ToneGraphCard(
          userPitch: measured,
          idealPitch: target,
          helpNote: 'NOT-ALIGNED-NOTE',
        ),
      );

      await tester.tap(find.byIcon(Icons.lightbulb_outline));
      await tester.pumpAndSettle();

      expect(find.text('NOT-ALIGNED-NOTE'), findsOneWidget);
      // The shared explanation is still there underneath it, as bullets of its own.
      final AppLocalizations l10n =
          await AppLocalizations.delegate.load(const Locale('en'));
      expect(find.text('•'), findsNWidgets(l10n.toneGraphHowToReadBody.split('\n').length + 1));
      expect(find.textContaining('Left to right is time'), findsOneWidget);
    });

    testWidgets('silence says so instead of drawing an empty box', (tester) async {
      // `ToneGraphPainter` skips a series with no voiced frame, so this renders as an
      // empty box — which reads as a failure rather than as an absence of measurement.
      await pumpCard(
        tester,
        const ToneGraphCard(
          userPitch: [null, null, null, null],
          idealPitch: target,
        ),
      );

      expect(find.textContaining('No pitch was measured'), findsOneWidget);
    });

    testWidgets('a measured take carries no apology', (tester) async {
      await pumpCard(
        tester,
        const ToneGraphCard(userPitch: measured, idealPitch: target),
      );

      expect(find.textContaining('No pitch was measured'), findsNothing);
    });

    testWidgets('a single point is not drawn, because it cannot be', (tester) async {
      // `ToneGraphPainter` divides by `length - 1`; one point is a division by zero.
      await pumpCard(
        tester,
        const ToneGraphCard(userPitch: [150], idealPitch: target),
      );

      expect(tester.takeException(), isNull);
      expect(find.textContaining('No pitch was measured'), findsOneWidget);
    });
  });

  group('the explanation is a card, not an essay', () {
    testWidgets('the body arrives as one bullet per line, not as a paragraph',
        (tester) async {
      // The iPad build this came from showed a wall of text: 590 characters in one
      // block, 880 with the shadowing studio's phrase note. A `textContaining`
      // check would still pass if that regressed, so this pins the *shape* — as
      // many bullets as the ARB value has lines.
      await pumpCard(
        tester,
        const ToneGraphCard(userPitch: measured, idealPitch: target),
      );
      await tester.tap(find.byIcon(Icons.lightbulb_outline));
      await tester.pumpAndSettle();

      final AppLocalizations l10n =
          await AppLocalizations.delegate.load(const Locale('en'));
      final List<String> lines = l10n.toneGraphHowToReadBody.split('\n');
      expect(lines.length, 4, reason: 'four ideas, four bullets');
      expect(find.text('•'), findsNWidgets(lines.length));
      for (final String line in lines) {
        expect(find.text(line), findsOneWidget, reason: 'line not its own bullet: $line');
      }
      expect(
        find.text(l10n.toneGraphHowToReadBody),
        findsNothing,
        reason: 'the value is laid out line by line, not as one block of prose',
      );
    });

    testWidgets('the sentence the panel exists for survives the cut', (tester) async {
      // A single stroke is ambiguous by convention, not by accident: "you matched
      // the target" and "nothing was measured" draw the same picture (audit 39's
      // rule, docs/LOCAL_TONE_PLAN.md stage 6). Copy that dropped this line in the
      // name of brevity would look tidier and teach the learner the opposite.
      await pumpCard(
        tester,
        const ToneGraphCard(userPitch: measured, idealPitch: target),
      );
      await tester.tap(find.byIcon(Icons.lightbulb_outline));
      await tester.pumpAndSettle();

      expect(find.textContaining('never that you were wrong'), findsOneWidget);
      expect(
        find.textContaining('drawn only when a different tone was heard'),
        findsOneWidget,
      );
    });
  });

  group('the chrome is localized', () {
    testWidgets('French names both strokes and explains the graph in French',
        (tester) async {
      // What the screenshot showed: the legend read "Your voice"/"Target" and the
      // panel was English while the rest of the screen was French, because the
      // seven `toneGraph*` keys existed only in `app_en.arb` and `gen-l10n` copies
      // the template into every locale that lacks them, silently.
      await pumpCard(
        tester,
        const ToneGraphCard(userPitch: measured, idealPitch: target),
        locale: const Locale('fr'),
      );
      final AppLocalizations fr =
          await AppLocalizations.delegate.load(const Locale('fr'));

      expect(find.text(fr.toneGraphYourVoice), findsOneWidget);
      expect(find.text(fr.toneGraphTarget), findsOneWidget);

      await tester.tap(find.byIcon(Icons.lightbulb_outline));
      await tester.pumpAndSettle();

      expect(find.text(fr.toneGraphHowToReadTitle), findsOneWidget);
      expect(find.text(fr.toneGraphHowToReadBody.split('\n').first), findsOneWidget);
      for (final String english in <String>[
        'Your voice',
        'Target',
        'How to read this graph',
      ]) {
        expect(find.text(english), findsNothing,
            reason: 'the panel still carries the English text "$english"');
      }
    });

    testWidgets('an Arabic bullet sits at the start of its line, on the right',
        (tester) async {
      // The marker is a `Row` child, so `Directionality` decides which edge it
      // hugs. A hard-coded left edge would put it at the end of every Arabic line,
      // where it reads as a stray glyph rather than as a bullet.
      await pumpCard(
        tester,
        const ToneGraphCard(userPitch: measured, idealPitch: target),
        locale: const Locale('ar'),
      );
      final AppLocalizations ar =
          await AppLocalizations.delegate.load(const Locale('ar'));

      await tester.tap(find.byIcon(Icons.lightbulb_outline));
      await tester.pumpAndSettle();

      expect(
        tester.getTopRight(find.text('•').first).dx,
        greaterThan(
          tester
              .getTopRight(find.text(ar.toneGraphHowToReadBody.split('\n').first))
              .dx,
        ),
        reason: 'the bullet is laid out by Directionality, not by a fixed edge',
      );
    });
  });

  group('the panel survives every locale and text scale', () {
    testWidgets('it scrolls rather than overflowing, phone and iPad alike',
        (tester) async {
      // Six short lines at 2.0x text scale are taller than an iPhone SE (320x568)
      // and taller than the tablet dialog's 85%-of-the-window cap on an iPad in
      // landscape (1366x1024) — this is the form the feedback came from. The panel
      // used to be a minimum-sized `Column` inside a sheet that does not scroll by
      // itself; it owns a scroll view now, in both forms (`zenSheet` switches the
      // form at 840dp).
      for (final Size viewport in <Size>[
        const Size(320, 568),
        const Size(1366, 1024),
      ]) {
        for (final String locale in <String>['ru', 'vi', 'th', 'ar']) {
          // `pumpWidget` reuses the tree when the root widget's type is unchanged,
          // so the *route stack* of the previous iteration would survive into this
          // one and its open sheet would make the lightbulb ambiguous. Clear it.
          await tester.pumpWidget(const SizedBox.shrink());
          await tester.pumpAndSettle();

          await pumpLocalizedScreen(
            tester,
            builder: (BuildContext context) =>
                const Scaffold(body: Center(child: ToneGraphHelpButton())),
            locale: locale,
            size: viewport,
            textScale: 2.0,
          );

          await tester.tap(find.byIcon(Icons.lightbulb_outline));
          await tester.pumpAndSettle();

          expectNoOverflow(
            tester,
            reason: '$locale at 2.0x on '
                '${viewport.width.toInt()}x${viewport.height.toInt()}',
          );
        }
      }
    });
  });
}
