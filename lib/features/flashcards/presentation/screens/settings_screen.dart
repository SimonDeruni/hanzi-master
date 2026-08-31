import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';

import '../providers/settings_controller.dart';
import 'package:hanzi_master/core/services/audio_service.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/core/services/notification_service.dart';
import 'package:hanzi_master/core/providers/translation_language_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF121212) : const Color(0xFFFDFCF0),
      appBar: AppBar(
        title: Text(
            l10n?.settingsTitle ?? AppLocalizations.of(context)!.settingsTitle,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black87),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        children: [
          _buildSectionHeader(
              l10n?.audioAndHaptics ??
                  AppLocalizations.of(context)!.audio_haptics,
              theme),
          _buildSettingsCard(
            context: context,
            children: [
              _buildSliderTile(
                icon: Icons.speed,
                iconColor: Colors.lightBlue,
                title: l10n?.voiceSpeed ??
                    AppLocalizations.of(context)!.voiceSpeed,
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
              _buildDivider(),
              _buildSwitchTile(
                icon: Icons.vibration,
                iconColor: Colors.orange,
                title: AppLocalizations.of(context)!.hapticFeedback,
                subtitle:
                    AppLocalizations.of(context)!.vibrationsForInteractions,
                value: settings.enableHaptics,
                onChanged: (val) {
                  ref.read(settingsProvider.notifier).toggleHaptics(val);
                },
              ),
              _buildDivider(),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.purple.withValues(alpha: 0.1),
                  child: const Icon(Icons.record_voice_over,
                      color: Colors.purple, size: 20),
                ),
                title: Text(AppLocalizations.of(context)!.audiobookVoice,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text(_voiceDisplayName(settings.audiobookVoice)),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () => _showVoicePickerDialog(context, ref),
              ),
            ],
          ),
          const SizedBox(height: 24),

          _buildSectionHeader(
              l10n?.displayAndContent ??
                  AppLocalizations.of(context)!.display_content,
              theme),
          _buildSettingsCard(
            context: context,
            children: [
              _buildSwitchTile(
                icon: Icons.dark_mode,
                iconColor: Colors.indigo,
                title: l10n?.darkMode ?? "Dark Mode",
                subtitle: l10n?.darkModeDesc ?? "Easy on the eyes",
                value: settings.isDarkMode,
                onChanged: (val) =>
                    ref.read(settingsProvider.notifier).toggleDarkMode(val),
              ),
              _buildDivider(),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.teal.withValues(alpha: 0.1),
                  child: const Icon(Icons.language, color: Colors.teal),
                ),
                title: Text(l10n?.appLanguage ?? "App Language",
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text(_appLanguageName(settings.locale)),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () => _showAppLanguagePicker(context, ref),
              ),
              _buildDivider(),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue.withValues(alpha: 0.1),
                  child: const Icon(Icons.translate, color: Colors.blue),
                ),
                title: Text(
                    l10n?.translationLanguage ??
                        AppLocalizations.of(context)!.translationLanguage,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text(ref.watch(translationLanguageProvider)),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () => _showTranslationLanguagePicker(context, ref),
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
                onChanged: (val) =>
                    ref.read(settingsProvider.notifier).setAnimationSpeed(val),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSectionHeader(l10n?.notifications ?? AppLocalizations.of(context)!.notifications, theme,color: Colors.amber.shade700),
          _buildSettingsCard(
            context: context,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.amber.withValues(alpha: 0.1),
                  child: const Icon(Icons.notifications_active,
                      color: Colors.amber),
                ),
                title: Text(AppLocalizations.of(context)!.notification_settings,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text(AppLocalizations.of(context)!
                    .manageDailyDropsAndReviewReminders),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () => _showNotificationSettings(context, ref),
              ),
            ],
          ),
          const SizedBox(height: 24), // Danger Zone
          _buildSectionHeader(l10n?.dangerZone ?? "Danger Zone", theme,
              color: Colors.redAccent),
          _buildSettingsCard(
            context: context,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.red.withValues(alpha: 0.1),
                  child: const Icon(Icons.delete_forever, color: Colors.red),
                ),
                title: Text(
                    l10n?.resetAllData ??
                        AppLocalizations.of(context)!.resetAllData,
                    style: const TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold)),
                subtitle: Text(
                    l10n?.resetDataDesc ??
                        AppLocalizations.of(context)!
                            .deletesAllProgressPermanently,
                    style: TextStyle(color: Colors.red.shade300)),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(l10n?.areYouSure ??
                          AppLocalizations.of(context)!.areYouSure),
                      content: Text(l10n?.cannotBeUndone ??
                          AppLocalizations.of(context)!.this_cannot_be_undone),
                      actions: [
                        TextButton(
                          child: Text(l10n?.cancel ??
                              AppLocalizations.of(context)!.cancelAction),
                          onPressed: () => Navigator.pop(context),
                        ),
                        TextButton(
                          child: Text(
                              l10n?.deleteEverything ??
                                  AppLocalizations.of(context)!
                                      .deleteEverything,
                              style: const TextStyle(color: Colors.red)),
                          onPressed: () async {
                            await ref
                                .read(flashcardControllerProvider.notifier)
                                .resetAllData();
                            if (context.mounted) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          AppLocalizations.of(context)!
                                              .allDataHasBeen)));
                            }
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              _buildDivider(),
              _buildSwitchTile(
                icon: Icons.menu_book_outlined,
                iconColor: Colors.indigo,
                title: l10n?.useEnglishDefinitions ?? "Use English definitions",
                subtitle: l10n?.useEnglishDefinitionsDesc ??
                    "English definitions are generally more accurate and detailed",
                value: settings.useEnglishDefinitions,
                onChanged: (val) {
                  ref
                      .read(settingsProvider.notifier)
                      .toggleUseEnglishDefinitions(val);
                },
              ),
            ],
          ),

          const SizedBox(height: 48),
          Center(
            child: Text(
              AppLocalizations.of(context)!.hanziMasterV100,
              style: TextStyle(
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2),
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

  Widget _buildSettingsCard(
      {required BuildContext context, required List<Widget> children}) {
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
      activeThumbColor: iconColor,
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
            title: Text(title,
                style: const TextStyle(fontWeight: FontWeight.w600)),
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

  static String _voiceDisplayName(String voice) {
    switch (voice) {
      case 'Kore':
        return 'Kore — Female, warm (Azure)';
      case 'Aoede':
        return 'Aoede — Female, cheerful (Azure)';
      case 'Fenrir':
        return 'Fenrir — Male, upbeat (Azure)';
      case 'Charon':
        return 'Charon — Male, news-style (Azure)';
      case 'Puck':
        return 'Puck — Male, sporty (Azure)';
      case 'local':
        return 'Local — On-device TTS';
      default:
        return voice;
    }
  }

  static const _appLanguages = <(String, String)>[
    ('en', 'English'),
    ('ar', 'العربية'),
    ('de', 'Deutsch'),
    ('es', 'Español'),
    ('fr', 'Français'),
    ('hi', 'हिन्दी'),
    ('id', 'Bahasa Indonesia'),
    ('it', 'Italiano'),
    ('ja', '日本語'),
    ('ko', '한국어'),
    ('pt', 'Português'),
    ('ru', 'Русский'),
    ('vi', 'Tiếng Việt'),
  ];

  static String _appLanguageName(String locale) {
    return _appLanguages
        .firstWhere((language) => language.$1 == locale,
            orElse: () => _appLanguages.first)
        .$2;
  }

  static void _showAppLanguagePicker(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.read(settingsProvider).locale;
    showDialog<void>(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        title: const Text('App Language'),
        children: [
          RadioGroup<String>(
            groupValue: currentLocale,
            onChanged: (locale) async {
              if (locale == null) return;
              await ref.read(settingsProvider.notifier).setLocale(locale);
              if (dialogContext.mounted) Navigator.pop(dialogContext);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: _appLanguages
                  .map((language) => RadioListTile<String>(
                        value: language.$1,
                        title: Text(language.$2),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  static void _showTranslationLanguagePicker(
      BuildContext context, WidgetRef ref) {
    final currentLanguage = ref.read(translationLanguageProvider);
    showDialog<void>(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        title: Text(AppLocalizations.of(context)!.translationLanguage),
        children: [
          RadioGroup<String>(
            groupValue: currentLanguage,
            onChanged: (selectedLanguage) async {
              if (selectedLanguage == null) return;
              await ref
                  .read(translationLanguageProvider.notifier)
                  .setLanguage(selectedLanguage);
              if (dialogContext.mounted) Navigator.pop(dialogContext);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: supportedTranslationLanguages
                  .map((language) => RadioListTile<String>(
                        value: language,
                        title: Text(language),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  static void _showVoicePickerDialog(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentVoice = ref.read(settingsProvider).audiobookVoice;
    final accent = isDark ? Colors.amber.shade400 : const Color(0xFF8B0000);
    final cardBg = isDark ? const Color(0xFF1C1C1E) : const Color(0xFFFDFCF0);

    const voiceOptions = [
      ('Kore', 'Kore — Female, warm', 'zh-CN-XiaoxiaoNeural'),
      ('Aoede', 'Aoede — Female, cheerful', 'zh-CN-XiaoyiNeural'),
      ('Fenrir', 'Fenrir — Male, upbeat', 'zh-CN-YunxiNeural'),
      ('Charon', 'Charon — Male, news-style', 'zh-CN-YunyangNeural'),
      ('Puck', 'Puck — Male, sporty', 'zh-CN-YunjianNeural'),
      ('local', 'Local — On-device TTS', 'System voice'),
    ];

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: cardBg,
          title: Text(AppLocalizations.of(context)!.chooseAudiobookVoice,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: voiceOptions.map((opt) {
              final isSelected = currentVoice == opt.$1;
              return ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  isSelected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  color: isSelected ? accent : Colors.grey,
                ),
                title: Text(opt.$2,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal)),
                subtitle: Text(opt.$3, style: const TextStyle(fontSize: 11)),
                onTap: () {
                  ref.read(settingsProvider.notifier).setAudiobookVoice(opt.$1);
                  Navigator.of(ctx).pop();
                },
              );
            }).toList(),
          ),
        );
      },
    );
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
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(28)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Drag handle
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context)!.notification_settings,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  AppLocalizations.of(context)!
                      .manageDailyDropsAndReviewReminders,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.white54 : Colors.black54,
                  ),
                ),
                const SizedBox(height: 24),

                // Daily Drops toggle
                _buildNotifToggle(
                  context: context,
                  isDark: isDark,
                  icon: Icons.wb_sunny_outlined,
                  title: "Daily Drops",
                  subtitle: "Word of the Day & news",
                  value: dailyDropsEnabled,
                  time: dailyDropTime,
                  onChanged: (val) {
                    setSheetState(() => dailyDropsEnabled = val);
                    if (val) {
                      notificationService.scheduleDailyDrop(
                          dailyDropTime.hour, dailyDropTime.minute);
                    } else {
                      notificationService.cancel(1);
                      if (reviewRemindersEnabled) {
                        final dueCount = ref.read(dueFlashcardsCountProvider);
                        notificationService.scheduleSpacedRepetition(
                            reviewTime.hour, reviewTime.minute, dueCount);
                      }
                    }
                  },
                  onTimePicked: (time) {
                    setSheetState(() => dailyDropTime = time);
                    if (dailyDropsEnabled) {
                      notificationService.scheduleDailyDrop(
                          time.hour, time.minute);
                    }
                  },
                ),
                const Divider(height: 32),

                // Review Reminders toggle
                _buildNotifToggle(
                  context: context,
                  isDark: isDark,
                  icon: Icons.menu_book_outlined,
                  title: "Review Reminders",
                  subtitle: "Flashcards due for review",
                  value: reviewRemindersEnabled,
                  time: reviewTime,
                  onChanged: (val) {
                    setSheetState(() => reviewRemindersEnabled = val);
                    if (val) {
                      final dueCount = ref.read(dueFlashcardsCountProvider);
                      notificationService.scheduleSpacedRepetition(
                          reviewTime.hour, reviewTime.minute, dueCount);
                    } else {
                      notificationService.cancel(2);
                      if (dailyDropsEnabled) {
                        notificationService.scheduleDailyDrop(
                            dailyDropTime.hour, dailyDropTime.minute);
                      }
                    }
                  },
                  onTimePicked: (time) {
                    setSheetState(() => reviewTime = time);
                    if (reviewRemindersEnabled) {
                      final dueCount = ref.read(dueFlashcardsCountProvider);
                      notificationService.scheduleSpacedRepetition(
                          time.hour, time.minute, dueCount);
                    }
                  },
                ),
                const SizedBox(height: 24),

                OutlinedButton.icon(
                  onPressed: () => notificationService.requestPermissions(),
                  icon: const Icon(Icons.notifications_active, size: 18),
                  label: Text(AppLocalizations.of(context)!.requestPermissions),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Text(AppLocalizations.of(context)!.done),
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
            Text(title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black87,
                )),
            const SizedBox(height: 2),
            Text(subtitle,
                style: TextStyle(
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
        activeThumbColor: Colors.amber,
      ),
    ],
  );
}
