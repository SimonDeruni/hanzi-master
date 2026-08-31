import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/premium/presentation/screens/custom_paywall_screen.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

Widget _testApp({required Widget home}) {
  return ProviderScope(
    child: MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: home,
    ),
  );
}

void main() {
  testWidgets('purchase offer has a visible exit that dismisses it',
      (tester) async {
    await tester.pumpWidget(
      _testApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const CustomPaywallScreen(
                    useMockOfferingsForTesting: true,
                  ),
                ),
              ),
              child: const Text('Open offer'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open offer'));
    await tester.pumpAndSettle();

    final closeButton = find.byKey(const Key('paywall_close_button'));
    expect(closeButton, findsOneWidget);
    expect(find.byTooltip('Close purchase offer'), findsOneWidget);

    await tester.tap(closeButton);
    await tester.pumpAndSettle();

    expect(find.text('Open offer'), findsOneWidget);
    expect(closeButton, findsNothing);
  });

  testWidgets('purchase offer contains subscription and legal disclosures',
      (tester) async {
    await tester.pumpWidget(
      _testApp(
        home: const CustomPaywallScreen(
          useMockOfferingsForTesting: true,
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Monthly'), findsOneWidget);
    expect(find.text('Yearly'), findsOneWidget);
    expect(find.text(r'$9.99 / month'), findsOneWidget);
    expect(find.text(r'$59.99 / year'), findsOneWidget);
    expect(find.text('SinoSpark Premium'), findsOneWidget);
    expect(find.text('Terms of Use (EULA)'), findsOneWidget);
    expect(find.text('Privacy Policy'), findsOneWidget);
    expect(
      find.textContaining('Subscriptions renew automatically'),
      findsOneWidget,
    );
  });
}
