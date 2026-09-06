import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/stats_screen.dart';
import 'package:hanzi_master/features/settings/presentation/screens/contact_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/settings_screen.dart';
import 'package:hanzi_master/features/settings/presentation/screens/ai_data_privacy_screen.dart';
import 'package:hanzi_master/features/settings/presentation/screens/qa_screen.dart';
import 'package:hanzi_master/features/auth/presentation/providers/auth_controller.dart';
import 'package:hanzi_master/features/auth/presentation/screens/auth_screen.dart';
import 'package:hanzi_master/features/auth/presentation/screens/delete_account_screen.dart';
import 'package:hanzi_master/shared/routes/swipe_back_route.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final user = ref.watch(currentUserProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
      appBar: AppBar(
        title: Text(l10n.account),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black87),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
        children: [
          _buildIdentityCard(context, ref, theme, isDark),
          const SizedBox(height: 24),
          _buildSectionHeader(l10n.account, theme),
          _buildSettingsCard(
            context: context,
            children: [
              _buildAccountTile(
                context: context,
                icon: Icons.bar_chart_rounded,
                title: l10n.learning_stats,
                subtitle: l10n.view_your_learning_history_and_streaks,
                onTap: () => Navigator.push(
                  context,
                  SwipeBackPageRoute(builder: (context) => const StatsScreen()),
                ),
              ),
              _buildDivider(),
              _buildAccountTile(
                context: context,
                icon: Icons.workspace_premium_outlined,
                title: l10n.sinospark_premium,
                subtitle: l10n.youAreAPremiumMember,
                accentColor: const Color(0xFFB7791F),
                trailing: const Icon(
                  Icons.check_circle_outline_rounded,
                  color: Color(0xFFB7791F),
                  size: 20,
                ),
                onTap: () {},
              ),
              _buildDivider(),
              _buildAccountTile(
                context: context,
                icon: Icons.settings_outlined,
                title: l10n.settingsTitle,
                subtitle: l10n.preferences_audio_and_display,
                onTap: () => Navigator.push(
                  context,
                  SwipeBackPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                ),
              ),
              _buildDivider(),
              _buildAccountTile(
                context: context,
                icon: Icons.support_agent_outlined,
                title: l10n.helpAndSupport,
                subtitle: l10n.contact_us_and_report_issues,
                onTap: () => Navigator.push(
                  context,
                  SwipeBackPageRoute(
                    builder: (context) => const ContactScreen(),
                  ),
                ),
              ),
              _buildDivider(),
              _buildAccountTile(
                context: context,
                icon: Icons.forum_outlined,
                title: l10n.qaFaq,
                subtitle: l10n.audioPrivacyAndHowThingsWork,
                onTap: () => Navigator.push(
                  context,
                  SwipeBackPageRoute(builder: (context) => const QAScreen()),
                ),
              ),
              _buildDivider(),
              _buildAccountTile(
                key: const Key('ai-data-privacy-tile'),
                context: context,
                icon: Icons.policy_outlined,
                title: l10n.aiDataPrivacyTitle,
                subtitle: l10n.aiDataPrivacySettingsSubtitle,
                onTap: () => Navigator.push(
                  context,
                  SwipeBackPageRoute(
                    builder: (context) => const AiDataPrivacyScreen(),
                  ),
                ),
              ),
              if (user != null) ...[
                _buildDivider(),
                _buildAccountTile(
                  key: const Key('delete-account-tile'),
                  context: context,
                  icon: Icons.delete_forever_outlined,
                  title: l10n.deleteAccount,
                  subtitle: l10n.deleteAccountSubtitle,
                  accentColor: const Color(0xFFC62828),
                  onTap: () async {
                    final controller = ref.read(authControllerProvider);
                    final deleted = await Navigator.push<bool>(
                      context,
                      SwipeBackPageRoute(
                        builder: (context) => DeleteAccountScreen(
                          usesPassword: controller.currentUserUsesPassword,
                        ),
                      ),
                    );
                    if (deleted == true && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(AppLocalizations.of(context)!
                              .accountDeletedSuccessfully),
                        ),
                      );
                    }
                  },
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, ThemeData theme, {Color? color}) {
    final isDark = theme.brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        title,
        style: theme.textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w700,
          color: color ?? (isDark ? Colors.white60 : Colors.black54),
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  Widget _buildAccountTile({
    Key? key,
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? accentColor,
    Widget? trailing,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color =
        accentColor ?? (isDark ? Colors.white70 : const Color(0xFF3F51B5));

    return ListTile(
      key: key,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: color, size: 22),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: accentColor,
              fontWeight: FontWeight.w600,
            ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: isDark ? Colors.white54 : Colors.black54,
            ),
      ),
      trailing: trailing ??
          Icon(
            Icons.chevron_right_rounded,
            color: accentColor ?? (isDark ? Colors.white38 : Colors.black38),
          ),
      onTap: onTap,
    );
  }

  Widget _buildSettingsCard(
      {required BuildContext context, required List<Widget> children}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF252526) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : const Color(0xFF1A1A1B).withValues(alpha: 0.08),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(children: children),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(height: 1, thickness: 1, indent: 72, endIndent: 16);
  }

  Widget _buildIdentityCard(
      BuildContext context, WidgetRef ref, ThemeData theme, bool isDark) {
    final user = ref.watch(currentUserProvider);
    final l10n = AppLocalizations.of(context)!;
    final borderColor = isDark
        ? Colors.white.withValues(alpha: 0.08)
        : const Color(0xFF1A1A1B).withValues(alpha: 0.08);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF252526) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: const Color(0xFF3F51B5).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: user?.photoURL != null
                    ? Image.network(
                        user!.photoURL!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.person_outline_rounded,
                          color: Color(0xFF3F51B5),
                          size: 28,
                        ),
                      )
                    : const Icon(
                        Icons.person_outline_rounded,
                        color: Color(0xFF3F51B5),
                        size: 28,
                      ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.displayName ?? l10n.guestScholar,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : const Color(0xFF1A1A1B),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user?.email ?? l10n.localAccount,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: isDark ? Colors.white54 : Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (user == null)
            SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  SwipeBackPageRoute(builder: (context) => const AuthScreen()),
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF3F51B5),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                icon: const Icon(Icons.login_rounded, size: 20),
                label: Text(
                  l10n.createAccountToSyncProgress,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            )
          else
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton.icon(
                onPressed: () => ref.read(authControllerProvider).signOut(),
                style: OutlinedButton.styleFrom(
                  foregroundColor:
                      isDark ? Colors.white70 : const Color(0xFF1A1A1B),
                  side: BorderSide(color: borderColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                icon: const Icon(Icons.logout_rounded, size: 20),
                label: Text(
                  l10n.signOut,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
