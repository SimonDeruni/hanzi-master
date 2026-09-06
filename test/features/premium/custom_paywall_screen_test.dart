import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/premium/presentation/screens/custom_paywall_screen.dart';
import 'package:hanzi_master/features/auth/presentation/screens/auth_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/main_navigation_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/core/services/monetization_service.dart';
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
  testWidgets('purchase offer close leads to subscription login gate',
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

    expect(find.byType(AuthScreen), findsOneWidget);
    expect(find.byKey(const Key('auth_restore_subscription')), findsOneWidget);
    expect(
        find.byKey(const Key('auth_view_subscription_plans')), findsOneWidget);
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

    expect(find.byType(CalligraphyBackground), findsOneWidget);
    expect(
      find.byKey(const Key('paywall_calligraphy_background')),
      findsOneWidget,
    );
    expect(find.text('Monthly'), findsOneWidget);
    expect(find.text('Yearly'), findsOneWidget);
    expect(find.text(r'$9.99 / month'), findsOneWidget);
    expect(find.text(r'$59.99 / year'), findsOneWidget);
    expect(find.text('SinoSpark Premium'), findsOneWidget);
    expect(find.text('Books and studio-quality audiobooks'), findsOneWidget);
    expect(
      find.text('AI conversations and live tone feedback'),
      findsOneWidget,
    );
    expect(find.text('Interactive video and web immersion'), findsOneWidget);
    expect(
      find.text('Character insights and handwriting practice'),
      findsOneWidget,
    );
    expect(
      find.text('HSK decks and smart spaced repetition'),
      findsOneWidget,
    );
    expect(find.text('Progress and streak tracking'), findsOneWidget);
    expect(find.text('Scanner and live translation'), findsOneWidget);
    expect(find.text('Master every stroke'), findsOneWidget);
    expect(find.text('Explore the Chinese web'), findsOneWidget);
    expect(
        find.text('Turn any book into a lesson & audiobook'), findsOneWidget);
    expect(find.text('Speak freely with AI & live tones'), findsOneWidget);
    expect(find.text('Understand Chinese around you'), findsNothing);
    expect(find.text('Scanner and translation screenshot'), findsNothing);
    const screenshotAssets = [
      'assets/images/paywall/paywall_read.png',
      'assets/images/paywall/paywall_speak.png',
      'assets/images/paywall/paywall_explore.png',
      'assets/images/paywall/paywall_watch.png',
      'assets/images/paywall/paywall_write.png',
      'assets/images/paywall/paywall_web.png',
    ];
    for (final asset in screenshotAssets) {
      final image = tester.widget<Image>(
        find.byWidgetPredicate(
          (widget) =>
              widget is Image &&
              widget.image is AssetImage &&
              (widget.image as AssetImage).assetName == asset,
        ),
      );
      expect(image.fit, BoxFit.contain);
    }
    for (var index = 0; index < screenshotAssets.length; index++) {
      final inset = tester.widget<Padding>(
        find.byKey(ValueKey('paywall_screenshot_inset_$index')),
      );
      expect(inset.padding, const EdgeInsets.all(10));
    }
    final characterStory = find.text('Understand every character');
    final videoStory = find.text('Learn through real videos');
    final handwritingStory = find.text('Master every stroke');
    expect(characterStory, findsOneWidget);
    expect(videoStory, findsOneWidget);
    expect(
      tester.getTopLeft(characterStory).dy,
      lessThan(tester.getTopLeft(videoStory).dy),
    );
    expect(
      tester.getTopLeft(videoStory).dy,
      lessThan(tester.getTopLeft(handwritingStory).dy),
    );
    expect(find.text('Terms of Use (EULA)'), findsOneWidget);
    expect(find.text('Privacy Policy'), findsOneWidget);
    expect(
      find.textContaining('Subscriptions renew automatically'),
      findsOneWidget,
    );
    expect(find.textContaining('Day 5'), findsNothing);
    expect(find.textContaining('Day 7'), findsNothing);
  });

  testWidgets('benefits lead the offer and legal actions need no scrolling',
      (tester) async {
    tester.view.physicalSize = const Size(390, 700);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      _testApp(
        home: const CustomPaywallScreen(
          useMockOfferingsForTesting: true,
        ),
      ),
    );
    await tester.pump();

    final benefits = find.text('Everything included');
    final monthlyPlan = find.text('Monthly');
    expect(benefits, findsOneWidget);
    expect(monthlyPlan, findsOneWidget);
    expect(
      tester.getTopLeft(benefits).dy,
      lessThan(tester.getTopLeft(monthlyPlan).dy),
    );

    for (final key in [
      'paywall_restore_button',
      'paywall_terms_button',
      'paywall_privacy_button',
    ]) {
      final action = find.byKey(Key(key));
      expect(action, findsOneWidget);
      expect(action.hitTestable(), findsOneWidget);
    }
  });

  testWidgets('unavailable subscriptions grant temporary premium access',
      (tester) async {
    await tester.pumpWidget(
      _testApp(
        home: const CustomPaywallScreen(
          simulateUnavailableOfferingsForTesting: true,
        ),
      ),
    );
    await tester.pump();

    expect(find.byKey(const Key('paywall_offerings_error')), findsOneWidget);
    final continueButton =
        find.byKey(const Key('paywall_temporary_premium_button'));
    expect(continueButton, findsOneWidget);
    expect(find.text('Continue with temporary Premium'), findsOneWidget);

    await tester.ensureVisible(continueButton);
    await tester.tap(continueButton);
    await tester.pump();

    expect(find.byType(MainNavigationScreen), findsOneWidget);
    expect(find.byType(CustomPaywallScreen), findsNothing);
    expect(await MonetizationService.checkPremiumStatus(), isTrue);
  });
}
