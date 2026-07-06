import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';

import '../providers/settings_controller.dart';
import 'package:hanzi_master/core/services/audio_service.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFFDFCF0),
      appBar: AppBar(
        title: Text(l10n?.settingsTitle ?? "Settings", style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black87),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        children: [


          
          _buildSectionHeader(l10n?.audioAndHaptics ?? "Audio & Haptics", theme),
          _buildSettingsCard(
            context: context,
            children: [

              _buildSwitchTile(
                icon: Icons.vibration,
                iconColor: Colors.orange,
                title: l10n?.haptics ?? "Haptic Feedback",
                subtitle: l10n?.hapticsDesc ?? "Feel the brush strokes",
                value: settings.hapticsEnabled,
                onChanged: (val) => ref.read(settingsProvider.notifier).toggleHaptics(val),
              ),
              _buildDivider(),
              _buildSliderTile(
                icon: Icons.speed,
                iconColor: Colors.lightBlue,
                title: l10n?.voiceSpeed ?? "Voice Speed",
                subtitle: l10n?.speechRateMultiplier(settings.speechRate.toStringAsFixed(1)) ?? "${settings.speechRate.toStringAsFixed(1)}x",
                value: settings.speechRate,
                min: 0.1,
                max: 1.0,
                divisions: 9,
                onChanged: (val) {
                  ref.read(settingsProvider.notifier).setSpeechRate(val);
                  ref.read(audioServiceProvider).setSpeechRate(val);
                },
              ),
            ],
          ),
          const SizedBox(height: 24),

          _buildSectionHeader(l10n?.displayAndContent ?? "Display & Content", theme),
          _buildSettingsCard(
            context: context,
            children: [

              _buildSwitchTile(
                icon: Icons.dark_mode,
                iconColor: Colors.indigo,
                title: l10n?.darkMode ?? "Dark Mode",
                subtitle: l10n?.darkModeDesc ?? "Easy on the eyes",
                value: settings.isDarkMode,
                onChanged: (val) => ref.read(settingsProvider.notifier).toggleDarkMode(val),
              ),
              _buildDivider(),
              _buildSliderTile(
                icon: Icons.animation,
                iconColor: Colors.pink,
                title: l10n?.animationSpeed ?? "Stroke Animation Speed",
                subtitle: l10n?.animationSpeedMultiplier(settings.animationSpeed.toStringAsFixed(1)) ?? "${settings.animationSpeed.toStringAsFixed(1)}x",
                value: settings.animationSpeed,
                min: 0.5,
                max: 2.0,
                divisions: 15,
                onChanged: (val) => ref.read(settingsProvider.notifier).setAnimationSpeed(val),
              ),

            ],
          ),
          const SizedBox(height: 24),
          _buildSectionHeader("Notifications", theme, color: Colors.amber.shade700),
          _buildSettingsCard(
            context: context,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.amber.withOpacity(0.1),
                  child: const Icon(Icons.notifications_active, color: Colors.amber),
                ),
                title: const Text("Notification Settings", style: TextStyle(fontWeight: FontWeight.w600)),
                subtitle: const Text("Manage Daily Drops and Review Reminders"),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {
                  // TODO: Navigate to Notification Settings Screen
                },
              ),
            ],
          ),
          const SizedBox(height: 24),          // Danger Zone
          _buildSectionHeader(l10n?.dangerZone ?? "Danger Zone", theme, color: Colors.redAccent),
          _buildSettingsCard(
            context: context,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.red.withOpacity(0.1),
                  child: const Icon(Icons.delete_forever, color: Colors.red),
                ),
                title: Text(l10n?.resetAllData ?? "Reset All Data", style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                subtitle: Text(l10n?.resetDataDesc ?? "Deletes all progress permanently", style: TextStyle(color: Colors.red.shade300)),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(l10n?.areYouSure ?? "Are you sure?"),
                      content: Text(l10n?.cannotBeUndone ?? "This cannot be undone."),
                      actions: [
                        TextButton(
                          child: Text(l10n?.cancel ?? "Cancel"),
                          onPressed: () => Navigator.pop(context),
                        ),
                        TextButton(
                          child: Text(l10n?.deleteEverything ?? "DELETE EVERYTHING", style: const TextStyle(color: Colors.red)),
                          onPressed: () async {
                            await ref.read(flashcardControllerProvider.notifier).resetAllData();
                            if (context.mounted) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(AppLocalizations.of(context)!.allDataHasBeen))
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
          
          const SizedBox(height: 48),
          Center(
            child: Text(
              AppLocalizations.of(context)!.hanziMasterV100,
              style: TextStyle(color: Colors.grey.shade500, fontWeight: FontWeight.bold, letterSpacing: 1.2),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, ThemeData theme, {Color? color}) {
    final isDark = theme.brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 12.0),
      child: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontFamily: 'Serif',
          fontWeight: FontWeight.w800,
          color: color ?? (isDark ? Colors.white70 : Colors.black87),
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildSettingsCard({required BuildContext context, required List<Widget> children}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(children: children),
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle),
      secondary: CircleAvatar(
        backgroundColor: iconColor.withOpacity(0.1),
        child: Icon(icon, color: iconColor),
      ),
      activeColor: iconColor,
    );
  }

  Widget _buildSliderTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required Function(double) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: iconColor.withOpacity(0.1),
              child: Icon(icon, color: iconColor),
            ),
            title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text(subtitle),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Slider(
              value: value,
              min: min,
              max: max,
              divisions: divisions,
              activeColor: iconColor,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(height: 1, thickness: 1, indent: 56);
  }

  String _getLanguageName(String locale) {
    switch (locale) {
      case 'en': return 'English';
      case 'zh': return '中文';
      case 'es': return 'Español';
      case 'fr': return 'Français';
      case 'de': return 'Deutsch';
      case 'ja': return '日本語';
      case 'ko': return '한국어';
      case 'ru': return 'Русский';
      case 'ar': return 'العربية';
      case 'hi': return 'हिन्दी';
      case 'pt': return 'Português';
      case 'it': return 'Italiano';
      case 'tr': return 'Türkçe';
      case 'vi': return 'Tiếng Việt';
      case 'id': return 'Bahasa Indonesia';
      default: return 'English';
    }
  }

}
