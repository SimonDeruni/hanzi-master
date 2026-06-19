import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  Future<void> _sendEmail(String type) async {
    final String subject = Uri.encodeComponent("Hanzi Master: $type");
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'support@hanzimaster.com',
      query: 'subject=$subject',
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      debugPrint("Could not launch $emailLaunchUri");
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: isDark ? Colors.grey[900] : Colors.grey.shade50,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "We'd love to hear from you!",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Whether you've found a bug, have a feature request, or just want to say hi, your feedback helps us improve Hanzi Master.",
              style: TextStyle(
                fontSize: 16,
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 40),
            
            _ContactCard(
              title: "Report a Bug",
              description: "Found something broken? Let us know so we can fix it.",
              icon: Icons.bug_report_rounded,
              color: Colors.redAccent,
              onTap: () => _sendEmail("Bug Report"),
            ),
            const SizedBox(height: 16),
            
            _ContactCard(
              title: "Suggest a Feature",
              description: "Have an idea to make Hanzi Master better? We're all ears.",
              icon: Icons.lightbulb_rounded,
              color: Colors.amber.shade600,
              onTap: () => _sendEmail("Feature Request"),
            ),
            const SizedBox(height: 16),
            
            _ContactCard(
              title: "General Feedback",
              description: "Share your thoughts or just say hello!",
              icon: Icons.chat_bubble_rounded,
              color: Colors.blueAccent,
              onTap: () => _sendEmail("General Feedback"),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ContactCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[850] : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: isDark ? Colors.grey.shade600 : Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}
