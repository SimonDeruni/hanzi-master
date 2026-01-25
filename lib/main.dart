import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/flashcards/data/models/flashcard_model.dart';
import 'features/flashcards/presentation/screens/flashcard_list_screen.dart';
import 'features/flashcards/presentation/providers/settings_controller.dart';
import 'features/onboarding/presentation/screens/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 1. Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(FlashcardModelAdapter());
  await Hive.openBox<FlashcardModel>('flashcards');

  // 2. Load Preferences Synchronously
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        // Inject the pre-loaded preferences
        settingsProvider.overrideWith((ref) => SettingsController(prefs)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the settings
    final settings = ref.watch(settingsProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
    title: 'Hanzi Master',
      
      // THEME LOGIC
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      themeMode: settings.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      
      // ROUTING LOGIC: Show Onboarding if not completed
      home: settings.hasCompletedOnboarding 
          ? const FlashcardListScreen() 
          : const OnboardingScreen(),
    );
  }
}
