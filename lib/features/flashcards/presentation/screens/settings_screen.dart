import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';

import '../providers/settings_controller.dart';
import 'package:hanzi_master/core/services/audio_service.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/core/services/notification_service.dart';

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
                  backgroundColor: Colors.amber.withValues(alpha: 0.1),
                  child: const Icon(Icons.notifications_active, color: Colors.amber),
                ),
                title: const Text("Notification Settings", style: TextStyle(fontWeight: FontWeight.w600)),
                subtitle: const Text("Manage Daily Drops and Review Reminders"),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () => _showNotificationSettings(context, ref),
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
                  backgroundColor: Colors.red.withValues(alpha: 0.1),
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
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
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
        backgroundColor: iconColor.withValues(alpha: 0.1),
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
              backgroundColor: iconColor.withValues(alpha: 0.1),
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

void _showNotificationSettings(BuildContext context, WidgetRef ref) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  final notificationService = ref.read(notificationServiceProvider);
  bool dailyDropsEnabled = false;
  bool reviewRemindersEnabled = false;
  TimeOfDay dailyDropTime = const TimeOfDay(hour: 8, minute: 0);
  TimeOfDay reviewTime = const TimeOfDay(hour: 18, minute: 0);

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (ctx) {
      return StatefulBuilder(
        builder: (context, setSheetState) {
          return Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1C1C1E) : const Color(0xFFFDFCF0),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Drag handle
                Center(
                  child: Container(
                    width: 40, height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Notification Settings",
                  style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Manage Daily Drops and Review Reminders",
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.white54 : Colors.black54,
                  ),
                ),
                const SizedBox(height: 24),

                // Daily Drops toggle
                _buildNotifToggle(
                  context: context, isDark: isDark,
                  icon: Icons.wb_sunny_outlined,
                  title: "Daily Drops",
                  subtitle: "Word of the Day & news",
                  value: dailyDropsEnabled,
                  time: dailyDropTime,
                  onChanged: (val) {
                    setSheetState(() => dailyDropsEnabled = val);
                    if (val) {
                      notificationService.scheduleDailyDrop(dailyDropTime.hour, dailyDropTime.minute);
                    } else {
                      notificationService.cancel(1);
                      if (reviewRemindersEnabled) {
                        final dueCount = ref.read(dueFlashcardsCountProvider);
                        notificationService.scheduleSpacedRepetition(reviewTime.hour, reviewTime.minute, dueCount);
                      }
                    }
                  },
                  onTimePicked: (time) {
                    setSheetState(() => dailyDropTime = time);
                    if (dailyDropsEnabled) {
                      notificationService.scheduleDailyDrop(time.hour, time.minute);
                    }
                  },
                ),
                const Divider(height: 32),

                // Review Reminders toggle
                _buildNotifToggle(
                  context: context, isDark: isDark,
                  icon: Icons.menu_book_outlined,
                  title: "Review Reminders",
                  subtitle: "Flashcards due for review",
                  value: reviewRemindersEnabled,
                  time: reviewTime,
                  onChanged: (val) {
                    setSheetState(() => reviewRemindersEnabled = val);
                    if (val) {
                      final dueCount = ref.read(dueFlashcardsCountProvider);
                      notificationService.scheduleSpacedRepetition(reviewTime.hour, reviewTime.minute, dueCount);
                    } else {
                      notificationService.cancel(2);
                      if (dailyDropsEnabled) {
                        notificationService.scheduleDailyDrop(dailyDropTime.hour, dailyDropTime.minute);
                      }
                    }
                  },
                  onTimePicked: (time) {
                    setSheetState(() => reviewTime = time);
                    if (reviewRemindersEnabled) {
                      final dueCount = ref.read(dueFlashcardsCountProvider);
                      notificationService.scheduleSpacedRepetition(time.hour, time.minute, dueCount);
                    }
                  },
                ),
                const SizedBox(height: 24),

                OutlinedButton.icon(
                  onPressed: () => notificationService.requestPermissions(),
                  icon: const Icon(Icons.notifications_active, size: 18),
                  label: const Text("Request Permissions"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Text("Done"),
                ),
                const SizedBox(height: 8),
              ],
            ),
          );
        },
      );
    },
  );
}

Widget _buildNotifToggle({
  required bool isDark,
  required BuildContext context,
  required IconData icon,
  required String title,
  required String subtitle,
  required bool value,
  required TimeOfDay time,
  required Function(bool) onChanged,
  required Function(TimeOfDay) onTimePicked,
}) {
  return Row(
    children: [
      CircleAvatar(
        backgroundColor: Colors.amber.withValues(alpha: 0.1),
        child: Icon(icon, color: Colors.amber, size: 20),
      ),
      const SizedBox(width: 14),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black87,
            )),
            const SizedBox(height: 2),
            Text(subtitle, style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.white54 : Colors.black54,
            )),
          ],
        ),
      ),
      TextButton(
        onPressed: () async {
          final picked = await showTimePicker(
            context: context,
            initialTime: time,
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  timePickerTheme: TimePickerThemeData(
                    hourMinuteTextStyle: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w300,
                    ),
                    hourMinuteShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hourMinuteColor: WidgetStateColor.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) {
                        return Colors.amber.withValues(alpha: 0.2);
                      }
                      return Colors.transparent;
                    }),
                    dayPeriodTextStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                child: child!,
              );
            },
          );
          if (picked != null) onTimePicked(picked);
        },
        child: Text(
          time.format(context),
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.amber.shade700,
          ),
        ),
      ),
      Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.amber,
      ),
    ],
  );
}
