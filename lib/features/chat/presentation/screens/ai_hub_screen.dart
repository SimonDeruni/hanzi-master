import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/chat/presentation/screens/echo_hall_screen.dart'; // will rename later
import 'package:hanzi_master/features/reading/presentation/screens/reading_room_screen.dart';

class AiHubScreen extends ConsumerWidget {
  const AiHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const Color xuanPaper = Color(0xFFFDFCF0);
    const Color carbonInk = Color(0xFF1A1A1B);

    return Scaffold(
      backgroundColor: xuanPaper,
      appBar: AppBar(
        title: const Text(
          "AI HUB",
          style: TextStyle(
            color: carbonInk,
            fontWeight: FontWeight.w900,
            letterSpacing: 4.0,
            fontSize: 20,
          ),
        ),
        backgroundColor: xuanPaper,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Art & Intellect",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: carbonInk,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 3,
                  width: 60,
                  color: carbonInk,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              "Harness the power of the Digital Scholar to refine your brush and voice.",
              style: TextStyle(
                fontSize: 15,
                color: carbonInk.withAlpha(160),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 48),
            _buildAiFeatureCard(
              context,
              title: "THE ECHO HALL",
              description: "Conversational practice with distinct scholarly personas.",
              icon: Icons.chat_bubble_outline_rounded,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EchoHallScreen()),
                );
              },
            ),
            const SizedBox(height: 20),
            _buildAiFeatureCard(
              context,
              title: "CULTURAL READING ROOM",
              description: "Graded AI-generated stories on Chinese history and life.",
              icon: Icons.menu_book,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReadingRoomScreen()),
                );
              },
            ),
            const SizedBox(height: 20),
            _buildAiFeatureCard(
              context,
              title: "PRONUNCIATION",
              description: "Digital critique of your spoken tones and clarity.",
              icon: Icons.mic_none_rounded,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("The Scholar is still listening... coming soon!")),
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
    const Color carbonInk = Color(0xFF1A1A1B);
    const Color xuanPaper = Color(0xFFFDFCF0);

    return InkWell(
      onTap: isComingSoon ? null : onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: isComingSoon ? carbonInk.withAlpha(5) : xuanPaper,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isComingSoon ? carbonInk.withAlpha(20) : carbonInk.withAlpha(40),
            width: 1.5,
          ),
          boxShadow: isComingSoon ? null : [
            BoxShadow(
              color: carbonInk.withAlpha(20),
              blurRadius: 15,
              offset: const Offset(0, 8),
            )
          ],
        ),
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isComingSoon ? carbonInk.withAlpha(10) : carbonInk,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon, 
                color: isComingSoon ? carbonInk.withAlpha(60) : xuanPaper, 
                size: 24
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: isComingSoon ? carbonInk.withAlpha(100) : carbonInk,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 13,
                      color: isComingSoon ? carbonInk.withAlpha(60) : carbonInk.withAlpha(160),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            if (!isComingSoon)
              Icon(Icons.arrow_forward_ios_rounded, size: 16, color: carbonInk.withAlpha(100)),
          ],
        ),
      ),
    );
  }
}
