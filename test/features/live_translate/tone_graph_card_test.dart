import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/live_translate/presentation/widgets/tone_graph_card.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

/// The shadowing graph's chrome — the parts that tell a learner what they are looking at.
///
/// The contour is the one graphic in the app whose meaning is not self-evident, and the
/// three things that make it readable are all chrome rather than paint: the lightbulb, the
/// legend naming the two strokes, and the empty state that distinguishes *"we measured
/// nothing"* from *"you got it wrong"*. Each has its own test because each was added for a
/// separate reason and each could be dropped without the graph looking broken.
Future<void> pumpCard(WidgetTester tester, Widget card) async {
  await tester.binding.setSurfaceSize(const Size(430, 900));
  addTearDown(() => tester.binding.setSurfaceSize(null));

  await tester.pumpWidget(
    ProviderScope(
      child: MaterialApp(
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
      // The shared explanation is still there underneath it.
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
}
