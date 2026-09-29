import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/echo_hall/presentation/widgets/tone_comparison_sheet.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

void main() {
  testWidgets('recovers pinyin from Hanzi and localizes the comparison header',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(430, 1000));
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
          home: Scaffold(
            body: ToneComparisonSheet(
              character: '幕',
              pinyin: '5',
              expectedTone: 4,
              actualTone: 4,
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(
      find.text('Comparaison des 4 tons (Touchez pour écouter) :'),
      findsOneWidget,
    );
    for (final pinyin in ['mū', 'mú', 'mǔ', 'mù']) {
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Text &&
              (widget.data == pinyin ||
                  (widget.data?.startsWith('$pinyin  (') ?? false)),
        ),
        findsOneWidget,
      );
    }
    for (final invalidPinyin in ['51', '52', '53', '54']) {
      expect(find.text(invalidPinyin), findsNothing);
    }
    expect(find.text("N'existe pas en chinois"), findsNothing);
    expect(
      find.text("Ce ton n'existe pas en mandarin standard."),
      findsNothing,
    );
    expect(find.text('4-Tone Comparison (Tap to Listen):'), findsNothing);
  });

  testWidgets('does not name a tone when the grader measured none',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(430, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(_host(expectedTone: 3, actualTone: 0));
    await tester.pump();

    // 0 means "not measured": Azure assesses phonemes and never reports the tone
    // that was heard. Naming a tone here - or rendering the neutral tone, which
    // is what 0 used to fall through to - turns a missing measurement into a
    // wrong answer the learner never gave.
    expect(find.text('—'), findsOneWidget);
  });

  testWidgets('still reports a mismatch when a tone really was measured',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(430, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(_host(expectedTone: 3, actualTone: 2));
    await tester.pump();

    expect(find.text('—'), findsNothing);
  });

  testWidgets('the tone graph carries a lightbulb that explains how to read it',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(430, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      _host(expectedTone: 4, actualTone: 2, locale: const Locale('en')),
    );
    await tester.pump();

    // The contour is the one graphic in this sheet whose meaning is not
    // self-evident: a second stroke is drawn *only* on a mismatch, and
    // `actualTone == 0` means "not measured", so a lone stroke cannot be told
    // apart from a skipped measurement without being told the rule.
    final lightbulb = find.byTooltip('How to read this graph');
    expect(lightbulb, findsOneWidget);

    await tester.tap(lightbulb);
    await tester.pumpAndSettle();

    expect(find.text('How to read this graph'), findsOneWidget);
    expect(find.textContaining('not measured'), findsOneWidget);
  });
}

Widget _host({
  required int expectedTone,
  required int actualTone,
  Locale? locale,
}) {
  return ProviderScope(
    child: MaterialApp(
      locale: locale ?? const Locale('fr'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: ToneComparisonSheet(
          character: '马',
          pinyin: 'mǎ',
          expectedTone: expectedTone,
          actualTone: actualTone,
        ),
      ),
    ),
  );
}
