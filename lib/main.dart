import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hanzi_master/features/flashcards/data/models/flashcard_model.dart';
import 'package:hanzi_master/features/flashcards/data/models/review_stats_model.dart';
import 'package:hanzi_master/features/flashcards/data/models/deck_model.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/settings_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/main_navigation_screen.dart';
import 'package:hanzi_master/features/live_translate/domain/entities/translation_session.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';

import 'package:hanzi_master/core/providers.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:hanzi_master/core/services/analytics_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hanzi_master/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:hanzi_master/core/services/monetization_service.dart';
import 'package:hanzi_master/features/reading/data/repositories/story_repository.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  // 0. Hardened Zen & Ink System UI
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
    systemNavigationBarColor: Color(0xFFFDFCF0),
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarDividerColor: Colors.transparent,
  ));
  
  // 1. Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  
  // 2. Initialize Hive & DB
  await Hive.initFlutter();
  Hive.registerAdapter(FlashcardModelAdapter());
  Hive.registerAdapter(ReviewStatsModelAdapter());
  Hive.registerAdapter(DeckModelAdapter());
  Hive.registerAdapter(TranslationMessageAdapter());
  Hive.registerAdapter(TranslationSessionAdapter());

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

  final box = await Hive.openBox<FlashcardModel>(
    'flashcards',
    encryptionCipher: cipher,
  );
  await Hive.openBox<String>(
    'ai_cache',
    encryptionCipher: cipher,
  );
  await Hive.openBox<String>(
    'graded_stories_v2',
    encryptionCipher: cipher,
  );
  await Hive.openBox<String>(
    'custom_blueprints_v2',
    encryptionCipher: cipher,
  );
  final deckBox = await Hive.openBox<DeckModel>(
    'decks',
    encryptionCipher: cipher,
  );
  await Hive.openBox<String>(
    'curriculum_cache_box',
    encryptionCipher: cipher,
  );
  await Hive.openBox<TranslationSession>(
    'translation_sessions',
    encryptionCipher: cipher,
  );

  // Initialize RevenueCat
  await MonetizationService.init();

  // 3. Create Container for pre-warming providers
  final container = ProviderContainer(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(prefs),
      hiveBoxProvider.overrideWithValue(box),
      deckBoxProvider.overrideWithValue(deckBox),
    ],
  );

  // 4. Pre-warm Repository (Heavy JSON parsing)
  await container.read(flashcardRepositoryProvider).init();
  await container.read(globalDictionaryRepositoryProvider).init();
  
  // Also initialize stories repository to populate defaults
  await container.read(storyRepositoryProvider).init();
  
  // 5. Ensure Library is populated
  await container.read(flashcardControllerProvider.notifier).init();
  
  // 6. Initialize Analytics
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint('Firebase not configured yet: $e');
  }
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
    
    return GestureDetector(
      onTap: () {
        // Global Keyboard Dismissal Mandate
        final FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: MaterialApp(
        title: 'Hanzi Master',
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
        supportedLocales: const [
          Locale('en'), Locale('zh'), Locale('es'), Locale('fr'),
          Locale('de'), Locale('ja'), Locale('ko'), Locale('ru'),
          Locale('ar'), Locale('hi'), Locale('pt'), Locale('it'),
          Locale('tr'), Locale('vi'), Locale('id'),
        ],
        home: Consumer(
          builder: (context, ref, child) {
            final prefs = ref.watch(sharedPreferencesProvider);
            final hasSeenOnboarding = prefs.getBool('has_seen_onboarding') ?? false;
            
            if (!hasSeenOnboarding) {
              return const OnboardingScreen();
            }
            return const MainNavigationScreen();
          },
        ),
      ),
    );
  }
}
