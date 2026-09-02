import 'package:flutter/material.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class AiDataPrivacyScreen extends StatelessWidget {
  const AiDataPrivacyScreen({super.key});

  static final Uri _privacyPolicyUri =
      Uri.parse('https://sinospark.app/privacy.html#ai-data');

  Future<void> _openPrivacyPolicy(BuildContext context) async {
    final launched = await launchUrl(
      _privacyPolicyUri,
      mode: LaunchMode.externalApplication,
    );
    if (!launched && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.linkOpenFailed)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final background =
        isDark ? const Color(0xFF121212) : const Color(0xFFFDFCF0);
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text(
          l10n.aiDataPrivacyTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        children: [
          _DisclosureCard(
            cardColor: cardColor,
            icon: Icons.auto_awesome_outlined,
            iconColor: Colors.deepPurple,
            title: l10n.aiDataPrivacyOverviewTitle,
            body: l10n.aiDataPrivacyOverviewBody,
          ),
          const SizedBox(height: 16),
          _DisclosureCard(
            cardColor: cardColor,
            icon: Icons.cloud_outlined,
            iconColor: Colors.blue,
            title: l10n.aiDataPrivacyProvidersTitle,
            body: l10n.aiDataPrivacyProvidersBody,
          ),
          const SizedBox(height: 16),
          _DisclosureCard(
            cardColor: cardColor,
            icon: Icons.data_object_outlined,
            iconColor: Colors.teal,
            title: l10n.aiDataPrivacySentTitle,
            body: l10n.aiDataPrivacySentBody,
          ),
          const SizedBox(height: 16),
          _DisclosureCard(
            cardColor: cardColor,
            icon: Icons.tune_outlined,
            iconColor: Colors.orange,
            title: l10n.aiDataPrivacyControlsTitle,
            body: l10n.aiDataPrivacyControlsBody,
          ),
          const SizedBox(height: 16),
          _DisclosureCard(
            cardColor: cardColor,
            icon: Icons.storage_outlined,
            iconColor: Colors.indigo,
            title: l10n.aiDataPrivacyRetentionTitle,
            body: l10n.aiDataPrivacyRetentionBody,
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () => _openPrivacyPolicy(context),
            icon: const Icon(Icons.open_in_new),
            label: Text(l10n.readFullPrivacyPolicy),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _DisclosureCard extends StatelessWidget {
  const _DisclosureCard({
    required this.cardColor,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.body,
  });

  final Color cardColor;
  final IconData icon;
  final Color iconColor;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: iconColor.withValues(alpha: 0.1),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  body,
                  style: TextStyle(
                    height: 1.45,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
