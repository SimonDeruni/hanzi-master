import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hanzi_master/features/auth/presentation/providers/auth_controller.dart';
import 'package:hanzi_master/features/auth/presentation/screens/auth_screen.dart';
import 'package:hanzi_master/features/premium/presentation/screens/custom_paywall_screen.dart';
import 'package:hanzi_master/core/services/monetization_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/settings_controller.dart';

class _FakeUser extends Fake implements User {
  @override
  final String email;
  @override
  String get displayName => '';

  _FakeUser({required this.email});
}

class _TestNavigatorObserver extends NavigatorObserver {
  final List<Route<dynamic>> pushedRoutes = [];

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    pushedRoutes.add(route);
    super.didPush(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (newRoute != null) pushedRoutes.add(newRoute);
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
}

Widget _buildAuthScreen({
  Locale locale = const Locale('en'),
  bool requireSubscription = false,
  User? currentUser,
  NavigatorObserver? navigatorObserver,
  SharedPreferences? sharedPreferences,
}) {
  return ProviderScope(
    overrides: [
      currentUserProvider.overrideWithValue(currentUser),
      if (sharedPreferences != null)
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
    ],
    child: MaterialApp(
      navigatorObservers: [
        if (navigatorObserver != null) navigatorObserver,
      ],
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: AuthScreen(requireSubscription: requireSubscription),
    ),
  );
}

void main() {
  group('AuthScreen Localization & Actions Tests', () {
    testWidgets('renders all auth fields, buttons and links localized in French',
        (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        _buildAuthScreen(
          locale: const Locale('fr'),
          requireSubscription: true,
        ),
      );
      await tester.pumpAndSettle();

      // Login screen elements in French
      expect(find.text('Ravi de vous revoir'), findsOneWidget);
      expect(find.text('E-mail'), findsOneWidget);
      expect(find.text('Mot de passe'), findsOneWidget);
      expect(find.text('Se connecter'), findsOneWidget);
      expect(find.text('Pas de compte ? Inscrivez-vous'), findsOneWidget);
      expect(find.text('Voir les forfaits'), findsOneWidget);
      expect(find.text('Restaurer'), findsOneWidget);

      // Tap toggle to switch to Sign Up mode
      await tester.tap(find.text('Pas de compte ? Inscrivez-vous'));
      await tester.pumpAndSettle();

      // Sign Up screen elements in French
      expect(find.text('Commencez votre voyage'), findsOneWidget);
      expect(find.text('Nom'), findsOneWidget);
      expect(find.text('Créer un compte'), findsOneWidget);
      expect(find.text('Déjà un compte ? Connectez-vous'), findsOneWidget);
    });

    testWidgets('renders all auth fields, buttons and links localized in English',
        (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        _buildAuthScreen(
          locale: const Locale('en'),
          requireSubscription: true,
        ),
      );
      await tester.pumpAndSettle();

      // Login screen elements in English
      expect(find.text('Welcome Back'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Sign In'), findsOneWidget);
      expect(find.text("Don't have an account? Sign up"), findsOneWidget);
      expect(find.text('View Plans'), findsOneWidget);
      expect(find.text('Restore'), findsOneWidget);

      // Tap toggle to switch to Sign Up mode
      await tester.tap(find.text("Don't have an account? Sign up"));
      await tester.pumpAndSettle();

      // Sign Up screen elements in English
      expect(find.text('Begin Your Journey'), findsOneWidget);
      expect(find.text('Name'), findsOneWidget);
      expect(find.text('Create Account'), findsOneWidget);
      expect(find.text('Already have an account? Sign in'), findsOneWidget);
    });

    testWidgets('renders Account Gatekeeper view when authenticated without subscription in French',
        (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final user = _FakeUser(email: 'simon@example.com');

      await tester.pumpWidget(
        _buildAuthScreen(
          locale: const Locale('fr'),
          requireSubscription: true,
          currentUser: user,
        ),
      );
      await tester.pumpAndSettle();

      // Gatekeeper elements in French
      expect(find.byKey(const Key('auth_gatekeeper_title')), findsOneWidget);
      expect(find.text('Abonnement requis'), findsOneWidget);
      expect(find.byKey(const Key('auth_gatekeeper_user_email')), findsOneWidget);
      expect(find.text('Connecté en tant que simon@example.com'), findsOneWidget);
      expect(find.byKey(const Key('auth_gatekeeper_status_badge')), findsOneWidget);
      expect(find.text('Aucun abonnement actif trouvé.'), findsOneWidget);
      expect(find.byKey(const Key('auth_gatekeeper_view_plans_button')), findsOneWidget);
      expect(find.text('Voir les forfaits'), findsOneWidget);
      expect(find.byKey(const Key('auth_gatekeeper_restore_button')), findsOneWidget);
      expect(find.text('Restaurer'), findsOneWidget);
      expect(find.byKey(const Key('auth_gatekeeper_sign_out_button')), findsOneWidget);
      expect(find.text('Se déconnecter'), findsAtLeast(1));
    });

    testWidgets('renders Account Gatekeeper view when authenticated without subscription in English',
        (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final user = _FakeUser(email: 'learner@sinospark.com');

      await tester.pumpWidget(
        _buildAuthScreen(
          locale: const Locale('en'),
          requireSubscription: true,
          currentUser: user,
        ),
      );
      await tester.pumpAndSettle();

      // Gatekeeper elements in English
      expect(find.byKey(const Key('auth_gatekeeper_title')), findsOneWidget);
      expect(find.text('Subscription Required'), findsOneWidget);
      expect(find.byKey(const Key('auth_gatekeeper_user_email')), findsOneWidget);
      expect(find.text('Signed in as learner@sinospark.com'), findsOneWidget);
      expect(find.byKey(const Key('auth_gatekeeper_status_badge')), findsOneWidget);
      expect(find.text('No active subscription found.'), findsOneWidget);
      expect(find.byKey(const Key('auth_gatekeeper_view_plans_button')), findsOneWidget);
      expect(find.text('View Plans'), findsOneWidget);
      expect(find.byKey(const Key('auth_gatekeeper_restore_button')), findsOneWidget);
      expect(find.text('Restore'), findsOneWidget);
      expect(find.byKey(const Key('auth_gatekeeper_sign_out_button')), findsOneWidget);
      expect(find.text('Sign Out'), findsAtLeast(1));
    });

    testWidgets('tapping View Plans in Gatekeeper navigates to CustomPaywallScreen',
        (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final user = _FakeUser(email: 'user@example.com');

      await tester.pumpWidget(
        _buildAuthScreen(
          locale: const Locale('fr'),
          requireSubscription: true,
          currentUser: user,
        ),
      );
      await tester.pumpAndSettle();

      // Tap Voir les forfaits from Gatekeeper
      await tester.tap(find.byKey(const Key('auth_gatekeeper_view_plans_button')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      // Should have navigated to CustomPaywallScreen
      expect(find.byType(CustomPaywallScreen), findsOneWidget);
    });

    testWidgets('verifies all required auth and gatekeeper keys exist in all 14 supported locales',
        (tester) async {
      const languages = [
        'en', 'fr', 'de', 'es', 'it', 'pt', 'ru',
        'ja', 'ko', 'vi', 'id', 'hi', 'th', 'ar',
      ];

      for (final lang in languages) {
        final loc = await AppLocalizations.delegate.load(Locale(lang));
        expect(loc.viewPlans.isNotEmpty, isTrue,
            reason: 'viewPlans must not be empty for $lang');
        expect(loc.restore.isNotEmpty, isTrue,
            reason: 'restore must not be empty for $lang');
        expect(loc.subscriptionRequired.isNotEmpty, isTrue,
            reason: 'subscriptionRequired must not be empty for $lang');
        expect(loc.subscriptionRequiredDesc.isNotEmpty, isTrue,
            reason: 'subscriptionRequiredDesc must not be empty for $lang');
        expect(loc.signedInAs('test@example.com').contains('test@example.com'), isTrue,
            reason: 'signedInAs must interpolate email for $lang');
        expect(loc.signOut.isNotEmpty, isTrue,
            reason: 'signOut must not be empty for $lang');
      }
    });

    testWidgets('reviewer demo account login unlocks premium access and navigates to MainNavigationScreen',
        (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();

      await MonetizationService.lockDeveloperBackdoor();
      expect(await MonetizationService.checkPremiumStatus(), isFalse);

      final navObserver = _TestNavigatorObserver();

      await tester.pumpWidget(
        _buildAuthScreen(
          locale: const Locale('en'),
          requireSubscription: true,
          navigatorObserver: navObserver,
          sharedPreferences: prefs,
        ),
      );
      await tester.pumpAndSettle();

      // Enter reviewer demo credentials
      await tester.enterText(
        find.byKey(const Key('auth_email_field')),
        'apple.review@sinospark.app',
      );
      await tester.enterText(
        find.byKey(const Key('auth_password_field')),
        'AppleReview2026!',
      );

      // Tap Sign In
      await tester.tap(find.byKey(const Key('auth_submit_button')));
      await tester.pump();

      // Check that demo backdoor is unlocked and persisted
      expect(await MonetizationService.checkPremiumStatus(), isTrue);
      expect(prefs.getBool('demo_account_unlocked'), isTrue);
      expect(prefs.getBool('has_seen_onboarding'), isTrue);

      // Navigated to a new route via pushAndRemoveUntil
      expect(navObserver.pushedRoutes.length, greaterThanOrEqualTo(2));
      expect(navObserver.pushedRoutes.last, isA<MaterialPageRoute>());

      // Verify sign out clears backdoor
      await MonetizationService.lockDeveloperBackdoor();
      expect(await MonetizationService.checkPremiumStatus(), isFalse);
      expect(prefs.getBool('demo_account_unlocked'), isNull);
    });

    testWidgets(
        'legal links adaptively wrap and center without overflow on mobile in French',
        (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        _buildAuthScreen(
          locale: const Locale('fr'),
          requireSubscription: true,
        ),
      );
      await tester.pumpAndSettle();

      final termsButton = find.byKey(const Key('auth_terms_button'));
      final privacyButton = find.byKey(const Key('auth_privacy_button'));

      expect(termsButton, findsOneWidget);
      expect(privacyButton, findsOneWidget);

      // Verify privacy button does not overflow to the right
      final privacyRect = tester.getRect(privacyButton);
      expect(privacyRect.right, lessThanOrEqualTo(390.0));
      expect(privacyRect.left, greaterThanOrEqualTo(0.0));

      // Verify terms button is also within bounds
      final termsRect = tester.getRect(termsButton);
      expect(termsRect.right, lessThanOrEqualTo(390.0));
      expect(termsRect.left, greaterThanOrEqualTo(0.0));

      // Since wrapped on mobile in French, terms is above privacy
      expect(termsRect.bottom, lessThanOrEqualTo(privacyRect.top));

      // Both are centered on screen (screen center is 195.0)
      expect((termsRect.center.dx - 195.0).abs(), lessThan(20.0));
      expect((privacyRect.center.dx - 195.0).abs(), lessThan(20.0));
    });

    testWidgets(
        'legal links render side-by-side with horizontal spacing on wide screens',
        (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        _buildAuthScreen(
          locale: const Locale('fr'),
          requireSubscription: true,
        ),
      );
      await tester.pumpAndSettle();

      final termsButton = find.byKey(const Key('auth_terms_button'));
      final privacyButton = find.byKey(const Key('auth_privacy_button'));

      expect(termsButton, findsOneWidget);
      expect(privacyButton, findsOneWidget);

      final termsRect = tester.getRect(termsButton);
      final privacyRect = tester.getRect(privacyButton);

      // On wide screen they fit on one line: vertical centers align
      expect((termsRect.center.dy - privacyRect.center.dy).abs(), lessThan(2.0));

      // Side-by-side with horizontal space
      expect(termsRect.right, lessThan(privacyRect.left));

      // Entire row is within bounds
      expect(termsRect.left, greaterThanOrEqualTo(0.0));
      expect(privacyRect.right, lessThanOrEqualTo(800.0));
    });
  });
}
