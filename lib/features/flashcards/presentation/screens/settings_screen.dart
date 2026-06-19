import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import '../../../course/presentation/screens/tome_manager_screen.dart' as hanzi_tome;
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
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text(l10n?.settingsTitle ?? "Settings", style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        children: [
          _buildSectionHeader(l10n?.learningPreferences ?? "Learning Preferences", theme),
          _buildSettingsCard(
            context: context,
            children: [
              _buildSwitchTile(
                icon: Icons.visibility_off,
                iconColor: Colors.deepPurple,
                title: l10n?.hardMode ?? "Hard Mode (Hide Pinyin)",
                subtitle: l10n?.hardModeDesc ?? "Blur Pinyin for a tougher challenge",
                value: settings.isHardMode,
                onChanged: (val) => ref.read(settingsProvider.notifier).toggleHardMode(val),
              ),
              _buildDivider(),
              _buildSliderTile(
                icon: Icons.school,
                iconColor: Colors.blue,
                title: l10n?.adaptiveGuidance ?? "Adaptive Guidance",
                subtitle: "Hide stroke guide at streak: ${settings.guideDisappearanceStreak}",
                value: settings.guideDisappearanceStreak.toDouble(),
                min: 1.0,
                max: 5.0,
                divisions: 4,
                onChanged: (val) => ref.read(settingsProvider.notifier).setGuideDisappearanceStreak(val.toInt()),
              ),
              _buildDivider(),
              _buildSliderTile(
                icon: Icons.flag,
                iconColor: Colors.green,
                title: l10n?.dailyGoal ?? "Daily Ink Goal",
                subtitle: "${settings.dailyGoal} Ink Points",
                value: settings.dailyGoal.toDouble(),
                min: 10.0,
                max: 200.0,
                divisions: 19,
                onChanged: (val) => ref.read(settingsProvider.notifier).setDailyGoal(val.toInt()),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          _buildSectionHeader(l10n?.audioAndHaptics ?? "Audio & Haptics", theme),
          _buildSettingsCard(
            context: context,
            children: [
              _buildSwitchTile(
                icon: Icons.volume_up,
                iconColor: Colors.teal,
                title: l10n?.autoPlayAudio ?? "Auto-Play Pronunciation",
                subtitle: l10n?.autoPlayDesc ?? "Hear audio when revealing cards",
                value: settings.autoPlayAudio,
                onChanged: (val) => ref.read(settingsProvider.notifier).toggleAutoPlayAudio(val),
              ),
              _buildDivider(),
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
                subtitle: "${settings.speechRate.toStringAsFixed(1)}x",
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
              ListTile(
                leading: const Icon(Icons.language, color: Colors.blueAccent),
                title: Text(l10n?.appLanguage ?? "App Language"),
                subtitle: Text(_getLanguageName(settings.locale)),
                trailing: DropdownButton<String>(
                  value: settings.locale,
                  underline: const SizedBox(),
                  items: const [
                    DropdownMenuItem(value: 'en', child: Text('English')),
                    DropdownMenuItem(value: 'zh', child: Text('中文')),
                    DropdownMenuItem(value: 'es', child: Text('Español')),
                    DropdownMenuItem(value: 'fr', child: Text('Français')),
                    DropdownMenuItem(value: 'de', child: Text('Deutsch')),
                    DropdownMenuItem(value: 'ja', child: Text('日本語')),
                    DropdownMenuItem(value: 'ko', child: Text('한국어')),
                    DropdownMenuItem(value: 'ru', child: Text('Русский')),
                    DropdownMenuItem(value: 'ar', child: Text('العربية')),
                    DropdownMenuItem(value: 'hi', child: Text('हिन्दी')),
                    DropdownMenuItem(value: 'pt', child: Text('Português')),
                    DropdownMenuItem(value: 'it', child: Text('Italiano')),
                    DropdownMenuItem(value: 'tr', child: Text('Türkçe')),
                    DropdownMenuItem(value: 'vi', child: Text('Tiếng Việt')),
                    DropdownMenuItem(value: 'id', child: Text('Bahasa Indonesia')),
                  ],
                  onChanged: (String? newLocale) {
                    if (newLocale != null) {
                      ref.read(settingsProvider.notifier).setLocale(newLocale);
                    }
                  },
                ),
              ),
              _buildDivider(),
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
                subtitle: "${settings.animationSpeed.toStringAsFixed(1)}x",
                value: settings.animationSpeed,
                min: 0.5,
                max: 2.0,
                divisions: 15,
                onChanged: (val) => ref.read(settingsProvider.notifier).setAnimationSpeed(val),
              ),
              _buildDivider(),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFFE8EAF6),
                  child: Icon(Icons.library_books, color: Colors.indigo),
                ),
                title: Text(l10n?.manageTomes ?? "Manage Tomes", style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text(l10n?.manageTomesDesc ?? "Download HSK expansions"),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const hanzi_tome.TomeManagerScreen()));
                },
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Danger Zone
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
          
          const SizedBox(height: 48),
          Center(
            child: Text(
              "Hanzi Master v1.0.0",
              style: TextStyle(color: Colors.grey.shade500, fontWeight: FontWeight.bold, letterSpacing: 1.2),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, ThemeData theme, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
          color: color ?? theme.colorScheme.primary,
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
