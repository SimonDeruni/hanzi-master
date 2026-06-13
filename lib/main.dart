import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hanzi_master/features/flashcards/data/models/flashcard_model.dart';
import 'package:hanzi_master/features/flashcards/data/models/deck_model.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/settings_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/main_navigation_screen.dart';

import 'package:hanzi_master/core/providers.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/core/services/monetization_service.dart';

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
  Hive.registerAdapter(DeckModelAdapter());

  // --- SECURITY: Hive Encryption ---
  const secureStorage = FlutterSecureStorage();
  final encryptionKeyString = await secureStorage.read(key: 'hive_encryption_key');
  late List<int> encryptionKey;

  if (encryptionKeyString == null) {
    encryptionKey = Hive.generateSecureKey();
    await secureStorage.write(
      key: 'hive_encryption_key',
      value: base64Url.encode(encryptionKey),
    );
  } else {
    encryptionKey = base64Url.decode(encryptionKeyString);
  }

  // Open the box with encryption
  // Note: If you have existing unencrypted data, you would need a migration step.
  // For this audit fix, we are enforcing encryption from now on.
  final box = await Hive.openBox<FlashcardModel>(
    'flashcards',
    encryptionCipher: HiveAesCipher(encryptionKey),
  );

  // Open the AI response cache
  await Hive.openBox<String>(
    'ai_cache',
    encryptionCipher: HiveAesCipher(encryptionKey),
  );

  // Open the graded stories box
  await Hive.openBox<String>(
    'graded_stories',
    encryptionCipher: HiveAesCipher(encryptionKey),
  );

  // Open the custom blueprints box
  await Hive.openBox<String>(
    'custom_blueprints',
    encryptionCipher: HiveAesCipher(encryptionKey),
  );

  // Open the decks box
  final deckBox = await Hive.openBox<DeckModel>(
    'decks',
    encryptionCipher: HiveAesCipher(encryptionKey),
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