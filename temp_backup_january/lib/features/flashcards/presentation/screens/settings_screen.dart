import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import '../providers/settings_controller.dart';
import '../utils/tts_manager.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        children: [
          // 1. DARK MODE TOGGLE 🌙
          SwitchListTile(
            title: const Text("Dark Mode"),
            subtitle: const Text("Easy on the eyes"),
            value: settings.isDarkMode,
            onChanged: (val) {
              ref.read(settingsProvider.notifier).toggleDarkMode(val);
            },
            secondary: const Icon(Icons.dark_mode),
          ),
          
          const Divider(),

          // 2. AUDIO SPEED SLIDER 🐢
          ListTile(
            leading: const Icon(Icons.speed),
            title: const Text("Voice Speed"),
            subtitle: Text("Rate: ${settings.speechRate.toStringAsFixed(1)}x"),
          ),
          Slider(
            value: settings.speechRate,
            min: 0.1,
            max: 1.0,
            divisions: 9,
            label: settings.speechRate.toString(),
            onChanged: (val) {
              ref.read(settingsProvider.notifier).setSpeechRate(val);
              // Update the actual TTS engine immediately
              TtsManager().setRate(val);
            },
          ),
          const Divider(),

          // 🆕 IMPORT HSK 1 BUTTON
          ListTile(
            leading: const Icon(Icons.download_rounded, color: Colors.blue),
            title: const Text("Import HSK 1 Foundation"),
            subtitle: const Text("Load 150 standard words"),
            onTap: () async {
              // 1. Show a loading indicator
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => const Center(child: CircularProgressIndicator()),
              );

              // 2. Trigger the import via the Controller
              await ref.read(flashcardControllerProvider.notifier).importHsk1();

              // 3. Close loading & Show Success
              if (context.mounted) {
                Navigator.pop(context); // Close the spinner
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("HSK 1 Foundation Imported! 🇨🇳")),
                );
              }
            },
          ),

          const Divider(),
          // 🎬 ANIMATION CONTROLS
          ListTile(
            leading: const Icon(Icons.animation, color: Colors.orange),
            title: const Text("Stroke Animation Speed"),
            subtitle: Text("Speed: ${settings.animationSpeed.toStringAsFixed(1)}x"),
          ),
          Slider(
            value: settings.animationSpeed,
            min: 0.5,
            max: 2.0,
            divisions: 15,
            label: settings.animationSpeed.toStringAsFixed(1),
            onChanged: (val) {
              ref.read(settingsProvider.notifier).setAnimationSpeed(val);
            },
          ),
          const Divider(),

          // 3. DANGER ZONE ☢️
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            title: const Text("Reset All Data", style: TextStyle(color: Colors.red)),
            subtitle: const Text("Deletes all cards and progress"),
            onTap: () {
              // Show Confirmation Dialog
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Are you sure?"),
                  content: const Text("This cannot be undone."),
                  actions: [
                    TextButton(
                      child: const Text("Cancel"),
                      onPressed: () => Navigator.pop(context),
                    ),
                    TextButton(
                      child: const Text("DELETE EVERYTHING", style: TextStyle(color: Colors.red)),
                      onPressed: () async {
                        // 1. Call the Nuclear Option ☢️
                        await ref.read(flashcardControllerProvider.notifier).resetAllData();
                        
                        if (context.mounted) {
                          // 2. Close the dialog
                          Navigator.pop(context);

                          // 3. Show confirmation
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("All data has been wiped."))
                          );
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}