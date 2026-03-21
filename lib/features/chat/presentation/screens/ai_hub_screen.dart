import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/chat/presentation/screens/echo_hall_screen.dart'; // will rename later

class AiHubScreen extends ConsumerWidget {
  const AiHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFCF0), // Xuan Paper
      appBar: AppBar(
        title: const Text(
          "AI Hub",
          style: TextStyle(
            color: Color(0xFF1A1A1B),
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        backgroundColor: const Color(0xFFFDFCF0),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Intelligence & Art",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1A1B),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Explore AI-powered tools designed to accompany your path to mastery.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 32),
            _buildAiFeatureCard(
              context,
              title: "AI Chatbot",
              description: "Converse with distinct personas to practice conversational flow.",
              icon: Icons.chat_bubble_outline,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EchoHallScreen()),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildAiFeatureCard(
              context,
              title: "AI Pronunciation",
              description: "Coming soon: Grade your spoken tones automatically.",
              icon: Icons.mic_none,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Pronunciation analysis coming soon!")),
                );
              },
              isComingSoon: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAiFeatureCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
    bool isComingSoon = false,
  }) {
    return InkWell(
      onTap: isComingSoon ? null : onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(10),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFDFCF0),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: isComingSoon ? Colors.grey : const Color(0xFF1A1A1B), size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isComingSoon ? Colors.grey : const Color(0xFF1A1A1B),
                        ),
                      ),
                      if (isComingSoon) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text("Coming Soon", style: TextStyle(fontSize: 10, color: Colors.grey)),
                        )
                      ]
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 13,
                      color: isComingSoon ? Colors.grey : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            if (!isComingSoon)
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
