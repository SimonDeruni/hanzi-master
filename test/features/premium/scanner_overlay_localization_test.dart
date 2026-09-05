import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/premium/presentation/screens/universal_scanner_screen.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

void main() {
  testWidgets('scanner overlay instruction is localized in French',
      (tester) async {
    final semantics = tester.ensureSemantics();
    try {
      await tester.pumpWidget(
        const MaterialApp(
          locale: Locale('fr'),
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(body: ScannerOverlay()),
        ),
      );

      const frenchInstruction = 'Alignez le texte chinois dans le cadre';
      expect(find.bySemanticsLabel(frenchInstruction), findsOneWidget);
      expect(
        find.bySemanticsLabel('Align Chinese text within frame'),
        findsNothing,
      );

      final customPaint = tester.widget<CustomPaint>(
        find.descendant(
          of: find.byType(ScannerOverlay),
          matching: find.byType(CustomPaint),
        ),
      );
      final painter = customPaint.painter! as ScannerOverlayPainter;
      expect(painter.instruction, frenchInstruction);
      expect(painter.textDirection, TextDirection.ltr);
    } finally {
      semantics.dispose();
    }
  });
}
