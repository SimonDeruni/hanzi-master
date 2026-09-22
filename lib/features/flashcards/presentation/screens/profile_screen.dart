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
import 'package:hanzi_master/core/theme/app_theme.dart';
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
      backgroundColor: AppTheme.surfaceOf(context),
      appBar: AppBar(
        title: Text(l10n.account),
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppTheme.surfaceOf(context),
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
                accentColor: AppTheme.accentOf(context),
                // Status row: no destination, so it renders without a chevron or
                // press ripple instead of looking like a dead button.
                trailing: Icon(
                  Icons.check_circle_outline_rounded,
                  color: AppTheme.accentOf(context),
                  size: 20,
                ),
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
    VoidCallback? onTap,
    Color? accentColor,
    Widget? trailing,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // Only the ICON is tinted. The label always uses the on-surface ink colour so
    // gold/red rows keep readable titles.
    final iconColor = accentColor ?? AppTheme.accentOf(context);
    final titleColor = isDark ? Colors.white : const Color(0xFF1A1A1B);
    final isInteractive = onTap != null;

    return ListTile(
      key: key,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.12),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: 22),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: titleColor,
              fontWeight: FontWeight.w600,
            ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: isDark ? Colors.white70 : const Color(0xFF2C2C2E),
            ),
      ),
      // A row without a destination is a status row: no chevron, no ripple, so
      // it never reads as a broken button.
      trailing: trailing ??
          (isInteractive
              ? Icon(
                  Icons.chevron_right_rounded,
                  color: isDark ? Colors.white38 : Colors.black38,
                )
              : null),
      onTap: onTap,
    );
  }

  Widget _buildSettingsCard(
      {required BuildContext context, required List<Widget> children}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        // Book-screen card vocabulary.
        color: AppTheme.cardBgOf(context),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark
              ? Colors.white10
              : Colors.black.withValues(alpha: 0.06),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
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

  Widget _buildDivider() {
    return const Divider(height: 1, thickness: 1, indent: 72, endIndent: 16);
  }

  Widget _buildIdentityCard(
      BuildContext context, WidgetRef ref, ThemeData theme, bool isDark) {
    final user = ref.watch(currentUserProvider);
    final l10n = AppLocalizations.of(context)!;
    final borderColor = isDark
        ? Colors.white10
        : Colors.black.withValues(alpha: 0.06);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardBgOf(context),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
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
                  color: AppTheme.accentOf(context).withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: user?.photoURL != null
                    ? Image.network(
                        user!.photoURL!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Icon(
                          Icons.person_outline_rounded,
                          color: AppTheme.accentOf(context),
                          size: 28,
                        ),
                      )
                    : Icon(
                        Icons.person_outline_rounded,
                        color: AppTheme.accentOf(context),
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
              height: 52,
              child: ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  SwipeBackPageRoute(builder: (context) => const AuthScreen()),
                ),
                style: ElevatedButton.styleFrom(
                  // Book-screen primary button vocabulary.
                  backgroundColor:
                      isDark ? Colors.amber.shade700 : const Color(0xFF1A1A1B),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.login_rounded, size: 20),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        l10n.createAccountToSyncProgress,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton(
                onPressed: () => ref.read(authControllerProvider).signOut(),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.accentOf(context),
                  side: BorderSide(
                    color: isDark
                        ? AppTheme.accentDark
                        : AppTheme.accentLight,
                    width: 1.3,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.logout_rounded, size: 20),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        l10n.signOut,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
