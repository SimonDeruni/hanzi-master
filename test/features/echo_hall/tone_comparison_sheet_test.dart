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
}
