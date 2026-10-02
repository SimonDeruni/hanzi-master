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
import 'package:hanzi_master/core/personal/her_content.dart';
import 'package:hanzi_master/features/auth/presentation/providers/auth_controller.dart';

import 'package:hanzi_master/core/services/zen_ambient_service.dart';

import 'package:hanzi_master/core/providers.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:hanzi_master/core/services/analytics_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:hanzi_master/firebase_options.dart';
import 'package:hanzi_master/core/services/monetization_service.dart';
import 'package:hanzi_master/features/reading/data/repositories/story_repository.dart';
import 'package:hanzi_master/features/reading/presentation/widgets/now_playing_host.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/core/widgets/app_reload_boundary.dart';
import 'package:hanzi_master/core/hive_adapter_registry.dart';
import 'package:hanzi_master/core/localization/app_locale_policy.dart';
import 'package:hanzi_master/core/layout/zen_device.dart';
import 'package:hanzi_master/core/legal/third_party_notices.dart';
import 'package:hanzi_master/shared/widgets/zen_loader.dart';

void main() {
  final binding = WidgetsFlutterBinding.ensureInitialized();
  binding.deferFirstFrame();

  // Register the licences of bundled *data* (not pub packages) so the licences
  // screen can show them. CC-CEDICT is CC BY-SA 4.0 and requires attribution;
  // without this the dictionary shipped with no credit anywhere in the app.
  registerThirdPartyNotices();

  // 0. Hardened Zen & Ink System UI (Synchronous)
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
    systemNavigationBarColor: Color(0xFFFDFCF0),
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarDividerColor: Colors.transparent,
  ));

  // Orientation policy by device class (F2 of docs/IPAD_ADAPTIVE_PLAN.md):
  // phones stay portrait; tablets may rotate, so landscape reading, video and
  // Split View work. Screens that genuinely need a fixed orientation (camera
  // capture, calligraphy) ask through ZenOrientationLock and release it on pop.
  unawaited(ZenDevice.applyStartupOrientation());

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

    // 0. Initialize Firebase & App Check first so all service constructors can access Firebase safely
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

    // 1. Initialize SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await ZenAmbientService.instance.init(prefs: prefs);
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
    // Resolved through the account, so her word reaches the home screen's widget as
    // well as the card inside the app — one resolver, both surfaces.
    await widgetService.updateWordOfTheDay(
      word: HerContent.wordOfTheDayForAccount(
        email: container.read(currentUserProvider)?.email,
        date: DateTime.now(),
      ),
    );
    handleWidgetUri(await widgetService.initiallyLaunchedFromWidget());
    widgetService.widgetClicks.listen(handleWidgetUri);

    // 6. Initialize Monetization & Analytics
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
              error: snapshot.error,
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
            home: Scaffold(body: Center(child: ZenLoader())),
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
    this.error,
  });

  final bool timedOut;
  final VoidCallback onRetry;

  /// The exception that stopped initialisation, when there was one.
  ///
  /// Shown on the screen on purpose: a TestFlight build swallows `debugPrint`,
  /// so without this the only report a tester can give is "it did not start".
  final Object? error;

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
                if (error != null) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SelectableText(
                      '$error',
                      key: const Key('startupErrorDetail'),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF5A4300),
                      ),
                    ),
                  ),
                ],
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

/// The app's one [NavigatorObserver], feeding the global audiobook transport host
/// with "is the shell buried?".
///
/// Module scope rather than a `State` field because `HanziMasterApp` is a
/// `ConsumerWidget`: the same instance has to reach both `navigatorObservers` and
/// the host that listens to it, and it must outlive rebuilds.
final AudioRouteObserver _audioRouteObserver = AudioRouteObserver();

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
              AppLocalizations.of(context)?.hanziMaster ?? 'SinoSpark',
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
          navigatorObservers: <NavigatorObserver>[_audioRouteObserver],
          // The audiobook transport is mounted *above* the Navigator, so no
          // pushed route can bury it - leaving a playing audiobook used to land
          // on a route that covered the shell's own bar, stranding playback with
          // no in-app control (see NowPlayingHost).
          builder: (BuildContext context, Widget? child) => Column(
            children: <Widget>[
              Expanded(child: child ?? const SizedBox.shrink()),
              NowPlayingHost(shellBuried: _audioRouteObserver.shellBuried),
            ],
          ),
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
      rethrowErrors: false,
    ).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        debugPrint(
          'MonetizationService: subscription check timed out, falling back to paywall',
        );
        return false;
      },
    ).catchError((Object error) {
      debugPrint(
        'MonetizationService: subscription check error ($error), falling back to paywall',
      );
      return false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _premiumStatus,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: ZenLoader()),
          );
        }
        return snapshot.data == true
            ? const MainNavigationScreen()
            : const CustomPaywallScreen();
      },
    );
  }
}
