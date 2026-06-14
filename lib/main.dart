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

import 'package:hanzi_master/core/providers.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/core/services/monetization_service.dart';
import 'package:hanzi_master/features/reading/data/repositories/story_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

  // Initialize RevenueCat
  await MonetizationService.init();

  // 3. Create Container for pre-warming providers
  final container = ProviderContainer(
    overrides: [
      settingsProvider.overrideWith((ref) => SettingsController(prefs)),
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
    
    return MaterialApp(
      title: 'Hanzi Master',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A1A1B),
          surface: const Color(0xFFFDFCF0),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFFDFCF0),
        useMaterial3: true,
        fontFamily: 'NotoSansSC',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          titleTextStyle: TextStyle(
            color: Color(0xFF1A1A1B),
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
          iconTheme: IconThemeData(color: Color(0xFF1A1A1B)),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: const Color(0xFFFDFCF0),
          indicatorColor: const Color(0xFF1A1A1B).withValues(alpha: 0.1),
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFDFCF0),
          surface: const Color(0xFF1A1A1B),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF1A1A1B),
        useMaterial3: true,
        fontFamily: 'NotoSansSC',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          titleTextStyle: TextStyle(
            color: Color(0xFFFDFCF0),
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
          iconTheme: IconThemeData(color: Color(0xFFFDFCF0)),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: const Color(0xFF1A1A1B),
          indicatorColor: const Color(0xFFFDFCF0).withValues(alpha: 0.1),
        ),
      ),
      themeMode: settings.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const MainNavigationScreen(),
    );
  }
}