import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hanzi_master/features/flashcards/data/models/flashcard_model.dart';
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
import 'package:hanzi_master/core/widgets/app_reload_boundary.dart';
import 'package:hanzi_master/core/hive_adapter_registry.dart';
import 'package:hanzi_master/core/localization/app_locale_policy.dart';

void main() {
  final binding = WidgetsFlutterBinding.ensureInitialized();
  binding.deferFirstFrame();

  // 0. Hardened Zen & Ink System UI (Synchronous)
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
    systemNavigationBarColor: Color(0xFFFDFCF0),
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarDividerColor: Colors.transparent,
  ));

  // Force Portrait Mode globally
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(HanziMasterBootstrapApp(onFirstFrameReady: binding.allowFirstFrame));
}

/// Runs startup initialization while the native launch screen remains visible.
class HanziMasterBootstrapApp extends StatefulWidget {
  const HanziMasterBootstrapApp({
    super.key,
    this.initializeServices,
    this.bootstrapTimeout = const Duration(seconds: 20),
    this.appBuilder,
    this.onFirstFrameReady,
  });

  final Future<ProviderContainer> Function()? initializeServices;
  final Duration bootstrapTimeout;
  final Widget Function(ProviderContainer container)? appBuilder;
  final VoidCallback? onFirstFrameReady;

  @override
  State<HanziMasterBootstrapApp> createState() =>
      _HanziMasterBootstrapAppState();
}

class _HanziMasterBootstrapAppState extends State<HanziMasterBootstrapApp> {
  late Future<ProviderContainer> _bootstrapFuture;
  Timer? _bootstrapTimeoutTimer;
  bool _bootstrapTimedOut = false;
  bool _firstFrameReleased = false;

  @override
  void initState() {
    super.initState();
    _startBootstrap();
  }

  void _startBootstrap() {
    _bootstrapTimeoutTimer?.cancel();
    _bootstrapTimedOut = false;
    _bootstrapFuture = (widget.initializeServices ?? _initializeServices)();

    _bootstrapTimeoutTimer = Timer(widget.bootstrapTimeout, () {
      if (mounted) setState(() => _bootstrapTimedOut = true);
    });
  }

  void _releaseFirstFrame() {
    if (_firstFrameReleased) return;
    _firstFrameReleased = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onFirstFrameReady?.call();
    });
  }

  void _retryBootstrap({required bool startNewAttempt}) {
    setState(() {
      if (startNewAttempt) {
        _startBootstrap();
      } else {
        _bootstrapTimedOut = false;
        _bootstrapTimeoutTimer?.cancel();
        _bootstrapTimeoutTimer = Timer(widget.bootstrapTimeout, () {
          if (mounted) setState(() => _bootstrapTimedOut = true);
        });
      }
    });
  }

  Future<ProviderContainer> _initializeServices() async {
    try {
      await dotenv.load(fileName: ".env");
    } catch (e) {
      debugPrint("No .env file found, relying on ApiKeyPool fallback");
    }

    // 1. Initialize SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await initializeAppLocale(
      preferences: prefs,
      preferredLocales: WidgetsBinding.instance.platformDispatcher.locales,
    );

    // 2. Initialize Hive & DB
    await Hive.initFlutter();
    registerHiveAdapters();

    await LocalTranslationService.init();

    // Hive Encryption Key
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
        debugPrint('Error opening Hive box $name: $e. Deleting and retrying.');
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

    // Register audio engine once
    final audioService = container.read(audioServiceProvider);
    await initializeBackgroundAudio(audioService);

    // 4. Pre-warm Repository (Heavy JSON parsing)
    await container.read(flashcardRepositoryProvider).init();
    await container.read(globalDictionaryRepositoryProvider).init();
    await container.read(storyRepositoryProvider).init();

    // 5. Ensure Library is populated
    await container.read(flashcardControllerProvider.notifier).init();

    final widgetService = container.read(widgetServiceProvider);
    await widgetService.updateWordOfTheDay();
    handleWidgetUri(await widgetService.initiallyLaunchedFromWidget());
    widgetService.widgetClicks.listen(handleWidgetUri);

    // 6. Initialize Analytics, Auth, RevenueCat
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

    await MonetizationService.init();
    await container.read(analyticsServiceProvider).init();

    return container;
  }

  @override
  void dispose() {
    _bootstrapTimeoutTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ProviderContainer>(
      future: _bootstrapFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _bootstrapTimeoutTimer?.cancel();
          _releaseFirstFrame();
          final container = snapshot.data!;
          return UncontrolledProviderScope(
            container: container,
            child: widget.appBuilder?.call(container) ?? const HanziMasterApp(),
          );
        }

        final hasFailed = snapshot.hasError;
        if (hasFailed || _bootstrapTimedOut) {
          _releaseFirstFrame();
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            home: StartupErrorScreen(
              timedOut: !hasFailed,
              onRetry: () => _retryBootstrap(startNewAttempt: hasFailed),
            ),
          );
        }

        // The initial frame is deferred in production, so the native launch
        // screen remains visible. Once released (for example after retrying a
        // timeout), native launch UI cannot be restored; show neutral progress.
        if (_firstFrameReleased) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class StartupErrorScreen extends StatelessWidget {
  const StartupErrorScreen({
    super.key,
    required this.timedOut,
    required this.onRetry,
  });

  final bool timedOut;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCBC03),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/mascot_android12_splash.png',
                  width: 150,
                ),
                const SizedBox(height: 24),
                Text(
                  timedOut
                      ? 'SinoSpark is taking longer than expected to start.'
                      : 'SinoSpark could not finish starting.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: const Color(0xFF5A4300),
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Check your connection, then try again.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF5A4300)),
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  key: const Key('startupRetryButton'),
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Try again'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HanziMasterApp extends ConsumerWidget {
  const HanziMasterApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          supportedLocales: activeSupportedLocales,
          home: const AppStartupFlow(),
        ),
      ),
    );
  }
}

class AppStartupFlow extends ConsumerWidget {
  const AppStartupFlow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
  late Future<bool> _premiumStatus;

  @override
  void initState() {
    super.initState();
    _loadPremiumStatus();
  }

  void _loadPremiumStatus() {
    _premiumStatus = MonetizationService.checkPremiumStatus(
      rethrowErrors: true,
    ).timeout(
      const Duration(seconds: 10),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _premiumStatus,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'We could not check your subscription. Please try again.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: () => setState(_loadPremiumStatus),
                      child: const Text('Try again'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return snapshot.data == true
            ? const MainNavigationScreen()
            : const CustomPaywallScreen();
      },
    );
  }
}
