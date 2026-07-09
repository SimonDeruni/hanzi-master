import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/stats_screen.dart';
import 'package:hanzi_master/features/premium/presentation/screens/paywall_sheet.dart';
import 'package:hanzi_master/core/providers/premium_controller.dart';
import 'package:hanzi_master/features/settings/presentation/screens/contact_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/settings_screen.dart';
import 'package:hanzi_master/features/auth/presentation/providers/auth_controller.dart';
import 'package:hanzi_master/features/auth/presentation/screens/auth_screen.dart';
import 'package:hanzi_master/shared/routes/swipe_back_route.dart';
import 'package:hanzi_master/shared/widgets/info_bulb.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isPremium = ref.watch(premiumControllerProvider).valueOrNull ?? false;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFFDFCF0),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black87),
        actions: const [InfoBulb(id: "profile", title: "Your Profile", message: "Track your learning progress, view saved characters, and customize your study settings here.")],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: [
          _buildIdentityCard(context, ref, theme, isDark),
          const SizedBox(height: 32),
          _buildSectionHeader("Account", theme),
          _buildSettingsCard(
            context: context,
            children: [
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.blue.withValues(alpha: 0.1), shape: BoxShape.circle),
                  child: const Icon(Icons.bar_chart, color: Colors.blue),
                ),
                title: const Text("Learning Stats", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                subtitle: const Text("View your learning history and streaks", style: TextStyle(fontSize: 12, color: Colors.grey)),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () => Navigator.push(context, SwipeBackPageRoute(builder: (context) => const StatsScreen())),
              ),
              _buildDivider(),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.amber.withValues(alpha: 0.1), shape: BoxShape.circle),
                  child: const Icon(Icons.workspace_premium, color: Colors.amber),
                ),
                title: const Text("SinoSpark Premium", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                subtitle: const Text(
                  "You are a Premium member",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                trailing: const Icon(Icons.check_circle, color: Colors.amber),
                onTap: () {},
              ),
              _buildDivider(),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.grey.withValues(alpha: 0.1), shape: BoxShape.circle),
                  child: const Icon(Icons.settings, color: Colors.grey),
                ),
                title: const Text("Settings", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                subtitle: const Text("Preferences, Audio, and Display", style: TextStyle(fontSize: 12, color: Colors.grey)),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () => Navigator.push(context, SwipeBackPageRoute(builder: (context) => const SettingsScreen())),
              ),
              _buildDivider(),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.green.withValues(alpha: 0.1), shape: BoxShape.circle),
                  child: const Icon(Icons.help_outline, color: Colors.green),
                ),
                title: const Text("Help & Support", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                subtitle: const Text("Contact us and report issues", style: TextStyle(fontSize: 12, color: Colors.grey)),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () => Navigator.push(context, SwipeBackPageRoute(builder: (context) => const ContactScreen())),
              ),
            ],
          ),
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

  Widget _buildDivider() {
    return const Divider(height: 1, thickness: 1, indent: 64);
  }

  Widget _buildIdentityCard(BuildContext context, WidgetRef ref, ThemeData theme, bool isDark) {
    final user = ref.watch(currentUserProvider);
    final isPremium = ref.watch(premiumControllerProvider).valueOrNull ?? false;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: isDark ? Colors.grey.shade800 : Colors.white,
            backgroundImage: user?.photoURL != null ? NetworkImage(user!.photoURL!) : null,
            child: user?.photoURL == null 
                ? Icon(
                    Icons.person_outline,
                    size: 40,
                    color: isDark ? Colors.white : Colors.black87,
                  )
                : null,
          ),
          const SizedBox(height: 16),
          Text(
            user?.displayName ?? "Guest Scholar",
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w900,
              fontFamily: 'Serif',
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            user?.email ?? "Local Account",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isDark ? Colors.white54 : Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 24),
          if (user == null)
            SizedBox(
              width: double.infinity,
              height: 54,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.deepPurple, Colors.indigo],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurple.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AuthScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Create Account to Sync Progress",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            )
          else
            SizedBox(
              width: double.infinity,
              height: 54,
              child: OutlinedButton(
                onPressed: () {
                  ref.read(authControllerProvider).signOut();
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: isDark ? Colors.grey.shade800 : Colors.grey.shade300),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  "Sign Out",
                  style: TextStyle(
                    color: isDark ? Colors.white70 : Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

