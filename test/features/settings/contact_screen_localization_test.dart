import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/settings/presentation/screens/contact_screen.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

void main() {
  testWidgets('contact screen title is localized in French', (tester) async {
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
        home: ContactScreen(),
      ),
    );

    expect(
      find.text('Nous aimerions\nsavoir ce que vous pensez.'),
      findsOneWidget,
    );
    expect(find.text("We'd love to\nhear from you."), findsNothing);
  });
}
