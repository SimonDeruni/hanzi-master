import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hanzi_master/features/flashcards/data/models/flashcard_model.dart';
import 'package:hanzi_master/features/flashcards/data/models/review_stats_model.dart';
import 'package:hanzi_master/features/flashcards/data/models/deck_model.dart';
import 'package:hanzi_master/features/flashcards/data/models/daily_deck_activity_model.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/settings_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/main_navigation_screen.dart';
import 'package:hanzi_master/features/premium/presentation/screens/custom_paywall_screen.dart';
import 'package:hanzi_master/features/media/domain/models/saved_article.dart';
import 'package:hanzi_master/core/services/local_translation_service.dart';
import 'package:hanzi_master/core/services/widget_service.dart';
import 'package:hanzi_master/core/services/audio_service.dart';

import 'package:hanzi_master/core/providers.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:hanzi_master/core/services/analytics_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:hanzi_master/firebase_options.dart';
import 'package:hanzi_master/core/services/monetization_service.dart';
import 'package:hanzi_master/features/reading/data/repositories/story_repository.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/app_splash_screen.dart';
import 'package:hanzi_master/core/widgets/app_reload_boundary.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    debugPrint("No .env file found, relying on ApiKeyPool fallback");
  }

  // 0. Hardened Zen & Ink System UI
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
    systemNavigationBarColor: Color(0xFFFDFCF0),
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarDividerColor: Colors.transparent,
  ));

  // Force Portrait Mode globally
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // 1. Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();

  // 2. Initialize Hive & DB
  await Hive.initFlutter();
  Hive.registerAdapter(FlashcardModelAdapter());
  Hive.registerAdapter(ReviewStatsModelAdapter());
  Hive.registerAdapter(DeckModelAdapter());
  Hive.registerAdapter(DailyDeckActivityModelAdapter());
  Hive.registerAdapter(SavedArticleAdapter());

  await LocalTranslationService.init();

  // --- SECURITY: Hive Encryption ---
  // Key stored in SharedPreferences (NSUserDefaults on iOS) instead of Keychain.
  // Keychain requires keychain-access-groups entitlement which is unavailable
  // on sideloaded builds and causes a native SIGTRAP crash. NSUserDefaults
  // requires no entitlements and works on all iOS builds.
  HiveAesCipher? cipher;
  try {
    const String hiveKeyPref = 'hive_encryption_key';
    final keyString = prefs.getString(hiveKeyPref);
    late List<int> encryptionKey;
    if (keyString == null) {
      encryptionKey = Hive.generateSecureKey();
      await prefs.setString(hiveKeyPref, base64Url.encode(encryptionKey));
    } else {
      encryptionKey = base64Url.decode(keyString);
    }
    cipher = HiveAesCipher(encryptionKey);
  } catch (e) {
    debugPrint('Hive key generation failed, running unencrypted: $e');
    cipher = null;
  }

  Future<Box<T>> safeOpenBox<T>(String name, {HiveAesCipher? cipher}) async {
    try {
      return await Hive.openBox<T>(name, encryptionCipher: cipher);
    } catch (e) {
      debugPrint('Error opening Hive box \$name: \$e. Deleting and retrying.');
      await Hive.deleteBoxFromDisk(name);
      return await Hive.openBox<T>(name, encryptionCipher: cipher);
    }
  }

  final box = await safeOpenBox<FlashcardModel>('flashcards', cipher: cipher);
  await safeOpenBox<String>('ai_cache', cipher: cipher);
  await safeOpenBox<String>('graded_stories_v2', cipher: cipher);
  await safeOpenBox<String>('custom_blueprints_v2', cipher: cipher);
  final deckBox = await safeOpenBox<DeckModel>('decks', cipher: cipher);
  final studyActivityBox = await safeOpenBox<DailyDeckActivityModel>(
    'daily_deck_activity_v1',
    cipher: cipher,
  );
  await safeOpenBox<String>('curriculum_cache_box', cipher: cipher);
  await safeOpenBox<SavedArticle>('saved_articles', cipher: cipher);

  // 3. Create Container for pre-warming providers
  final container = ProviderContainer(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(prefs),
      hiveBoxProvider.overrideWithValue(box),
      deckBoxProvider.overrideWithValue(deckBox),
      studyActivityBoxProvider.overrideWithValue(studyActivityBox),
    ],
  );

  // Register the app-scoped audio engine as the system media handler once.
  final audioService = container.read(audioServiceProvider);
  await initializeBackgroundAudio(audioService);

  // 4. Pre-warm Repository (Heavy JSON parsing)
  await container.read(flashcardRepositoryProvider).init();
  await container.read(globalDictionaryRepositoryProvider).init();

  // Also initialize stories repository to populate defaults
  await container.read(storyRepositoryProvider).init();

  // 5. Ensure Library is populated
  await container.read(flashcardControllerProvider.notifier).init();

  final widgetService = container.read(widgetServiceProvider);
  await widgetService.updateWordOfTheDay();
  handleWidgetUri(await widgetService.initiallyLaunchedFromWidget());
  widgetService.widgetClicks.listen(handleWidgetUri);

  // 6. Initialize Analytics & Auth
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseAppCheck.instance.activate(
      providerAndroid: const AndroidPlayIntegrityProvider(),
      providerApple: const AppleAppAttestWithDeviceCheckFallbackProvider(),
    );
  } catch (e) {
    debugPrint('Firebase initialization failed: $e');
  }
  // RevenueCat is initialized after Firebase so authenticated identities can
  // safely be associated with subscriptions.
  await MonetizationService.init();
  await container.read(analyticsServiceProvider).init();

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const HanziMasterApp(),
    ),
  );
}

class HanziMasterApp extends ConsumerWidget {
  const HanziMasterApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 4. Watch settings to apply theme mode dynamically
    final settings = ref.watch(settingsProvider);

    return AppReloadBoundary(
      locale: settings.locale,
      child: GestureDetector(
        onTap: () {
          // Global Keyboard Dismissal Mandate
          final FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: MaterialApp(
          onGenerateTitle: (context) =>
              AppLocalizations.of(context)?.hanziMaster ?? 'Hanzi Master',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: settings.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          locale: Locale(settings.locale),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: const AppStartupFlow(),
        ),
      ),
    );
  }
}

class AppStartupFlow extends ConsumerStatefulWidget {
  const AppStartupFlow({super.key});

  @override
  ConsumerState<AppStartupFlow> createState() => _AppStartupFlowState();
}

class _AppStartupFlowState extends ConsumerState<AppStartupFlow> {
  bool _splashCompleted = false;

  @override
  Widget build(BuildContext context) {
    if (!_splashCompleted) {
      return AppSplashScreen(
        duration: const Duration(milliseconds: 1400),
        onFinished: () {
          if (mounted) {
            setState(() {
              _splashCompleted = true;
            });
          }
        },
      );
    }

    final prefs = ref.watch(sharedPreferencesProvider);
    final hasSeenOnboarding = prefs.getBool('has_seen_onboarding') ?? false;

    if (!hasSeenOnboarding) {
      return const OnboardingScreen();
    }

    return const _SubscriptionGate();
  }
}

class _SubscriptionGate extends StatefulWidget {
  const _SubscriptionGate();

  @override
  State<_SubscriptionGate> createState() => _SubscriptionGateState();
}

class _SubscriptionGateState extends State<_SubscriptionGate> {
  late final Future<bool> _premiumStatus =
      MonetizationService.checkPremiumStatus();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _premiumStatus,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const AppSplashScreen();
        }
        return snapshot.data == true
            ? const MainNavigationScreen()
            : const CustomPaywallScreen();
      },
    );
  }
}
