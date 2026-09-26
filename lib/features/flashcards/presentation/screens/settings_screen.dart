import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';

import '../providers/settings_controller.dart';
import 'package:hanzi_master/core/services/audio_service.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/core/services/notification_service.dart';
import 'package:hanzi_master/shared/widgets/global_blurred_bottom_sheet.dart';
import 'package:hanzi_master/core/providers/app_language_controller.dart';

import '../widgets/app_language_picker_sheet.dart';
import 'package:hanzi_master/core/services/app_rating_service.dart';
import 'package:hanzi_master/core/services/audio_quota_service.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/core/layout/zen_layout.dart';
import 'package:hanzi_master/features/settings/presentation/screens/contact_screen.dart';
import 'package:hanzi_master/core/services/haptics_manager.dart';
import 'package:hanzi_master/shared/routes/swipe_back_route.dart';
import 'package:hanzi_master/shared/widgets/audiobook_voice_sheet.dart';
import 'package:hanzi_master/shared/widgets/zen_toast.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Scaffold(
      // The same Xuan paper / carbon ground as every other surface.
      backgroundColor: isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight,
      appBar: AppBar(
        title: Text(
            l10n?.settingsTitle ?? AppLocalizations.of(context)!.settingsTitle,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: _ink(context)),
      ),
      // An iPad gets a capped, centred column: a 1366dp-wide settings form is
      // wrong. The cap is a no-op on a phone (760 > any phone width), which is
      // why this wrapper is unconditional rather than a second layout branch.
      body: ZenContentPane(
        maxWidth: 760,
        padding: EdgeInsets.zero,
        child: ListView(
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
                  iconColor: _accent(context),
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
                _buildDivider(context),
                _buildSwitchTile(
                  icon: Icons.vibration,
                  iconColor: _accent(context),
                  title: AppLocalizations.of(context)!.hapticFeedback,
                  subtitle:
                      AppLocalizations.of(context)!.vibrationsForInteractions,
                  value: settings.enableHaptics,
                  onChanged: (val) {
                    ref.read(settingsProvider.notifier).toggleHaptics(val);
                  },
                ),
                _buildDivider(context),
                _buildSwitchTile(
                  icon: Icons.music_note,
                  iconColor: _accent(context),
                  title: AppLocalizations.of(context)!.soundEffects,
                  subtitle: AppLocalizations.of(context)!.soundEffectsDesc,
                  value: settings.enableSoundEffects,
                  onChanged: (val) {
                    ref.read(settingsProvider.notifier).toggleSoundEffects(val);
                  },
                ),
                _buildDivider(context),
                ListTile(
                  leading: _rowIcon(context, Icons.record_voice_over),
                  title: Text(AppLocalizations.of(context)!.audiobookVoice,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle:
                      Text(_voiceDisplayName(context, settings.audiobookVoice)),
                  trailing: Icon(Icons.chevron_right, color: _muted(context)),
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
                  iconColor: _accent(context),
                  title: l10n?.darkMode ?? "Dark Mode",
                  subtitle: l10n?.darkModeDesc ?? "Easy on the eyes",
                  value: settings.isDarkMode,
                  onChanged: (val) =>
                      ref.read(settingsProvider.notifier).toggleDarkMode(val),
                ),
                _buildDivider(context),
                ListTile(
                  leading: _rowIcon(context, Icons.language),
                  title: Text(l10n?.appLanguage ?? "App Language",
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text(appLanguageName(settings.locale)),
                  trailing: Icon(Icons.chevron_right, color: _muted(context)),
                  onTap: () => _showAppLanguagePicker(context, ref),
                ),
                _buildDivider(context),
                _buildSwitchTile(
                  icon: Icons.menu_book_outlined,
                  iconColor: _accent(context),
                  title:
                      l10n?.useEnglishDefinitions ?? "Use English definitions",
                  subtitle: l10n?.useEnglishDefinitionsDesc ??
                      "English definitions are generally more accurate and detailed",
                  value: settings.useEnglishDefinitions,
                  onChanged: (val) {
                    ref
                        .read(settingsProvider.notifier)
                        .toggleUseEnglishDefinitions(val);
                  },
                ),
                _buildDivider(context),
                _buildSliderTile(
                  icon: Icons.animation,
                  iconColor: _accent(context),
                  title: l10n?.animationSpeed ?? "Stroke Animation Speed",
                  subtitle: "${settings.animationSpeed.toStringAsFixed(1)}x",
                  value: settings.animationSpeed,
                  min: 0.5,
                  max: 2.0,
                  divisions: 15,
                  onChanged: (val) => ref
                      .read(settingsProvider.notifier)
                      .setAnimationSpeed(val),
                ),
              ],
            ),
_buildSectionHeader(
                l10n?.notifications ??
                    AppLocalizations.of(context)!.notifications,
                theme),
            _buildSettingsCard(
              context: context,
              children: [
                ListTile(
                  leading: _rowIcon(context, Icons.notifications_active,
                      tone: _gold(context)),
                  title: Text(
                      AppLocalizations.of(context)!.notification_settings,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text(AppLocalizations.of(context)!
                      .oneOptionalDailyPracticeReminder),
                  trailing: Icon(Icons.chevron_right, color: _muted(context)),
                  onTap: () => _showNotificationSettings(context, ref),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSectionHeader(
              l10n?.supportAndFeedback ??
                  AppLocalizations.of(context)!.supportAndFeedback,
              theme,
            ),
            _buildSettingsCard(
              context: context,
              children: [
                ListTile(
                  leading: _rowIcon(context, Icons.star_rounded),
                  title: Text(
                    l10n?.rateSinoSpark ??
                        AppLocalizations.of(context)!.rateSinoSpark,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    l10n?.rateSinoSparkDesc ??
                        AppLocalizations.of(context)!.rateSinoSparkDesc,
                  ),
                  trailing: Icon(Icons.open_in_new_rounded,
                      size: 18, color: _muted(context)),
                  onTap: () async {
                    HapticsManager.light();
                    await ref.read(appRatingServiceProvider).openStoreListing();
                  },
                ),
                _buildDivider(context),
                ListTile(
                  leading: _rowIcon(context, Icons.mail_outline_rounded),
                  title: Text(
                    l10n?.sendFeedback ??
                        AppLocalizations.of(context)!.sendFeedback,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    l10n?.sendFeedbackDesc ??
                        AppLocalizations.of(context)!.sendFeedbackDesc,
                  ),
                  trailing: Icon(Icons.chevron_right, color: _muted(context)),
                  onTap: () {
                    HapticsManager.light();
                    Navigator.of(context).push(
                      SwipeBackRoute<void>(
                        builder: (_) => const ContactScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 24), // Danger Zone
            _buildSectionHeader(l10n?.dangerZone ?? "Danger Zone", theme,
                color: _alert(context)),
            _buildSettingsCard(
              context: context,
              children: [
                ListTile(
                  leading: _rowIcon(context, Icons.delete_forever,
                      tone: _alert(context)),
                  title: Text(
                      l10n?.resetAllData ??
                          AppLocalizations.of(context)!.resetAllData,
                      style: TextStyle(
                          color: _alert(context), fontWeight: FontWeight.bold)),
                  subtitle: Text(
                      l10n?.resetDataDesc ??
                          AppLocalizations.of(context)!
                              .deletesAllProgressPermanently,
                      style: TextStyle(
                          color: _alert(context).withValues(alpha: 0.75))),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(l10n?.areYouSure ??
                            AppLocalizations.of(context)!.areYouSure),
                        content: Text(l10n?.cannotBeUndone ??
                            AppLocalizations.of(context)!
                                .this_cannot_be_undone),
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
                                style: TextStyle(color: _alert(context))),
                            onPressed: () async {
                              await ref
                                  .read(flashcardControllerProvider.notifier)
                                  .resetAllData();
                              if (context.mounted) {
                                Navigator.pop(context);
                                ZenToast.info(
                                    context,
                                    AppLocalizations.of(context)!
                                        .allDataHasBeen);
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
                style: TextStyle(
                    color: _muted(context),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
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
          // The app's calligraphic family, not the platform's generic 'Serif'.
          fontWeight: FontWeight.w800,
          color: color ?? (isDark ? Colors.white70 : const Color(0xFF1A1A1B)),
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildSettingsCard(
      {required BuildContext context, required List<Widget> children}) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        // One ink well for the whole app: Xuan paper/carbon with a gold hairline,
        // exactly like the deck, book and shadowing surfaces.
        color: _card(context),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _gold(context).withValues(alpha: 0.28)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
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
      onChanged: (bool next) {
        // Let the switch settle first, so turning haptics *off* is silent while
        // turning it back on ticks - which is also how a user finds out that the
        // switch really does what it says.
        onChanged(next);
        HapticsManager.selection();
      },
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
              // A divided slider moves in detents, so one impact per detent is
              // exactly the platform convention and cannot degenerate into a
              // continuous buzz the way a continuous slider would.
              onChanged: (double next) {
                HapticsManager.selection();
                onChanged(next);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 56,
      color: _gold(context).withValues(alpha: 0.18),
    );
  }

  // ── Settings palette ────────────────────────────────────────────────────────
  // Sourced from [AppTheme] so a settings row, its sheet and the screen behind
  // them share the vocabulary the reader and the decks already speak. The rows
  // used to carry one ad-hoc Material colour each (lightBlue, orange, purple,
  // indigo, teal, pink, amber, blue), which made the screen read as a legend
  // rather than a set of settings.
  static Color _accent(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? AppTheme.accentDark
          : AppTheme.accentLight;

  static Color _card(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? AppTheme.cardBgDark
          : AppTheme.cardBgLight;

  static Color _gold(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.amber.shade700
          : const Color(0xFFD4AF37);

  static Color _ink(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : const Color(0xFF1A1A1B);

  static Color _muted(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.white60
          : const Color(0xFF6B655B);

  /// Destructive actions keep the documented Cinnabar alert red.
  static Color _alert(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.redAccent
          : const Color(0xFFC62828);

  /// The leading tile of a settings row: accent tint, accent glyph.
  static Widget _rowIcon(BuildContext context, IconData icon, {Color? tone}) {
    final Color color = tone ?? _accent(context);
    return CircleAvatar(
      backgroundColor: color.withValues(alpha: 0.12),
      child: Icon(icon, color: color, size: 20),
    );
  }

  static String _voiceDisplayName(BuildContext context, String voice) {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) return voice;
    // One catalogue for the whole app: the row, the sheet and the player all
    // name a voice the same way, and the engine's own identifiers never surface.
    return audiobookVoiceLabel(l10n, voice);
  }

  static void _showAppLanguagePicker(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.read(settingsProvider).locale;
    final title = AppLocalizations.of(context)?.appLanguage ?? 'App Language';
    GlobalBlurredBottomSheet.show<void>(
      context,
      child: AppLanguagePickerSheet(
        title: title,
        selectedLocale: currentLocale,
        onSelected: ref.read(appLanguageControllerProvider).setLanguage,
      ),
    );
  }

  static void _showVoicePickerDialog(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) return;
    final quota = ref.read(audioQuotaServiceProvider);
    final currentVoice = ref.read(settingsProvider).audiobookVoice;

    // The same sheet the reader and the player open, so there is one voice
    // picker in the app instead of three. The weekly studio allowance decides
    // which rows are locked; the on-device voice is always available.
    GlobalBlurredBottomSheet.show<void>(
      context,
      child: AudiobookVoiceSheet(
        title: l10n.chooseAudiobookVoice,
        options: audiobookVoiceOptions(
          l10n,
          hasStudioQuota: quota.hasQuotaRemaining,
        ),
        selectedVoiceId: currentVoice,
        onSelected: (option) {
          ref.read(settingsProvider.notifier).setAudiobookVoice(option.id);
          ref.read(audioServiceProvider).setAudiobookVoice(option.id);
          Navigator.of(context, rootNavigator: true).pop();
        },
      ),
    );
  }
}

Future<void> _showNotificationSettings(
    BuildContext context, WidgetRef ref) async {
  final notificationService = ref.read(notificationServiceProvider);
  var reminderEnabled = await notificationService.isPracticeReminderEnabled();
  final savedTime = await notificationService.practiceReminderTime();
  var reminderTime = TimeOfDay(hour: savedTime.hour, minute: savedTime.minute);
  if (!context.mounted) return;
  final isDark = Theme.of(context).brightness == Brightness.dark;

  // The app's sheet chrome (glass veil + handle), not a hand-rolled container.
  await GlobalBlurredBottomSheet.show<void>(
    context,
    child: StatefulBuilder(
      builder: (context, setSheetState) {
        final l10n = AppLocalizations.of(context)!;
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 2, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.notification_settings,
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: SettingsScreen._ink(context),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                l10n.chooseOneOptionalDailyPractice,
                style: TextStyle(
                  fontSize: 12.5,
                  color: SettingsScreen._muted(context),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                height: 1,
                color: SettingsScreen._gold(context).withValues(alpha: 0.3),
              ),
              const SizedBox(height: 20),
              _buildNotifToggle(
                context: context,
                isDark: isDark,
                icon: Icons.self_improvement_outlined,
                title: l10n.practiceReminder,
                subtitle: l10n.oneGentleReminderADay,
                value: reminderEnabled,
                time: reminderTime,
                onChanged: (enabled) async {
                  if (enabled) {
                    final granted =
                        await notificationService.requestPermissions();
                    if (!context.mounted) return;
                    if (!granted) {
                      setSheetState(() => reminderEnabled = false);
                      return;
                    }
                  }
                  await notificationService.setPracticeReminder(
                    enabled: enabled,
                    hour: reminderTime.hour,
                    minute: reminderTime.minute,
                  );
                  if (context.mounted) {
                    setSheetState(() => reminderEnabled = enabled);
                  }
                },
                onTimePicked: (time) async {
                  setSheetState(() => reminderTime = time);
                  if (reminderEnabled) {
                    await notificationService.setPracticeReminder(
                      enabled: true,
                      hour: time.hour,
                      minute: time.minute,
                    );
                  }
                },
              ),
              const SizedBox(height: 12),
              Text(
                '${l10n.finishingPracticeSilencesTodayS} '
                '${l10n.reEngagementAlertsAreCombined}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  // Book-screen primary: ink in light mode, gold in dark.
                  backgroundColor: SettingsScreen._accent(context),
                  foregroundColor:
                      isDark ? const Color(0xFF1A1A1B) : Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(l10n.done),
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    ),
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
  final Color tone = SettingsScreen._gold(context);
  return Row(
    children: [
      CircleAvatar(
        backgroundColor: tone.withValues(alpha: 0.12),
        child: Icon(icon, color: tone, size: 20),
      ),
      const SizedBox(width: 14),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: SettingsScreen._ink(context),
                )),
            const SizedBox(height: 2),
            Text(subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: SettingsScreen._muted(context),
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
            color: tone,
          ),
        ),
      ),
      Switch(
        value: value,
        onChanged: onChanged,
        activeThumbColor: tone,
      ),
    ],
  );
}
