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

  testWidgets('tapping sign in on paywall navigates to auth screen',
      (tester) async {
    await tester.pumpWidget(
      _testApp(
        home: const CustomPaywallScreen(
          useMockOfferingsForTesting: true,
        ),
      ),
    );
    await tester.pump();

    final signInButton = find.byKey(const Key('paywall_sign_in_button'));
    expect(signInButton, findsOneWidget);

    await tester.tap(signInButton);
    await tester.pumpAndSettle();

    expect(find.byType(AuthScreen), findsOneWidget);
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
    expect(find.text('86 Classical books and studio-quality audiobooks'),
        findsOneWidget);
    expect(
      find.text('Live AI voice calls and instant tone grading'),
      findsOneWidget,
    );
    expect(
      find.text('Shadowing studio and tone pitch analysis'),
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
    expect(find.text('Scanner and live translation'), findsOneWidget);
    expect(find.text('Progress and streak tracking'), findsNothing);
    expect(find.text('AI Call to improve fluency'), findsOneWidget);
    expect(find.text('Explore the Chinese web'), findsOneWidget);
    expect(
        find.text('Turn any book into a lesson & audiobook'), findsOneWidget);
    expect(find.text('Speak freely with AI & live tones'), findsOneWidget);
    expect(find.text('Decks with spaced repetition'), findsOneWidget);
    expect(find.text('86 Classical books and 100 poems'), findsOneWidget);
    expect(find.text('Scan images and add cards to deck'), findsOneWidget);
    expect(find.text('Smart dictionary with stroke order'), findsOneWidget);
    expect(find.text('Understand Chinese around you'), findsNothing);
    expect(find.text('Scanner and translation screenshot'), findsNothing);
    const screenshotAssets = [
      'assets/images/paywall/en/read.webp',
      'assets/images/paywall/en/call.webp',
      'assets/images/paywall/en/shadow.webp',
      'assets/images/paywall/en/watch.webp',
      'assets/images/paywall/en/web.webp',
      'assets/images/paywall/en/decks.webp',
      'assets/images/paywall/en/books.webp',
      'assets/images/paywall/en/scan.webp',
      'assets/images/paywall/en/dictionary.webp',
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
    final callStory = find.text('AI Call to improve fluency');
    final videoStory = find.text('Learn through real videos');
    final decksStory = find.text('Decks with spaced repetition');
    expect(callStory, findsOneWidget);
    expect(videoStory, findsOneWidget);
    expect(
      tester.getTopLeft(callStory).dy,
      lessThan(tester.getTopLeft(videoStory).dy),
    );
    expect(
      tester.getTopLeft(videoStory).dy,
      lessThan(tester.getTopLeft(decksStory).dy),
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

  testWidgets('plans lead the offer and legal actions need no scrolling',
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
      tester.getTopLeft(monthlyPlan).dy,
      lessThan(tester.getTopLeft(benefits).dy),
    );

    for (final key in [
      'paywall_restore_button',
      'paywall_terms_button',
      'paywall_privacy_button',
      'paywall_sign_in_button',
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

  testWidgets('paywall loads localized screenshot assets for French locale',
      (tester) async {
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
          home: CustomPaywallScreen(
            useMockOfferingsForTesting: true,
          ),
        ),
      ),
    );
    await tester.pump();

    const expectedFrenchAssets = [
      'assets/images/paywall/fr/read.webp',
      'assets/images/paywall/fr/call.webp',
      'assets/images/paywall/fr/shadow.webp',
      'assets/images/paywall/fr/watch.webp',
      'assets/images/paywall/fr/web.webp',
      'assets/images/paywall/fr/decks.webp',
      'assets/images/paywall/fr/books.webp',
      'assets/images/paywall/fr/scan.webp',
      'assets/images/paywall/fr/dictionary.webp',
    ];
    for (final asset in expectedFrenchAssets) {
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Image &&
              widget.image is AssetImage &&
              (widget.image as AssetImage).assetName == asset,
        ),
        findsOneWidget,
      );
    }
  });

  testWidgets(
      'tapping perk in everything included checklist scrolls to feature story',
      (tester) async {
    tester.view.physicalSize = const Size(390, 844);
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

    final perkCall = find.byKey(const Key('paywall_perk_1'));
    expect(perkCall, findsOneWidget);

    await tester.ensureVisible(perkCall);
    await tester.pumpAndSettle();

    final initialCallY =
        tester.getTopLeft(find.text('AI Call to improve fluency')).dy;

    await tester.tap(perkCall);
    await tester.pumpAndSettle();

    final scrolledCallY =
        tester.getTopLeft(find.text('AI Call to improve fluency')).dy;
    expect(scrolledCallY, lessThan(initialCallY));
  });

  test('14-language dictionary contains startMy7DaysFreeTrial and trialSubtextUnderCta', () {
    for (final locale in AppLocalizations.supportedLocales) {
      final l10n = lookupAppLocalizations(locale);
      expect(l10n.startMy7DaysFreeTrial, isNotEmpty);
      final subtext = l10n.trialSubtextUnderCta('CHF 50.00', '1 an');
      expect(subtext, contains('CHF 50.00'));
      expect(subtext, contains('1 an'));
    }
  });
}

