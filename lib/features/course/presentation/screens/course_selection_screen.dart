import 'package:flutter/material.dart';
import 'package:hanzi_master/features/course/presentation/screens/course_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';

class CourseSelectionScreen extends StatelessWidget {
  const CourseSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("COURSE LIBRARY", 
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 4, fontSize: 12, color: Colors.brown)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: CalligraphyBackground(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 120, 24, 40),
          children: [
            _CourseCard(
              title: "HSK 1: The Apprentice",
              subtitle: "Master the 150 Foundation Characters.",
              level: "Beginner",
              color: Colors.indigo,
              isLocked: false,
              onTap: () => Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => const CourseScreen()),
              ),
            ),
            const SizedBox(height: 20),
            _CourseCard(
              title: "HSK 2: The Disciple",
              subtitle: "Expand your vocabulary to 300 words.",
              level: "Elementary",
              color: Colors.teal,
              isLocked: true,
              onTap: () {},
            ),
            const SizedBox(height: 20),
            _CourseCard(
              title: "Chengyu Scrolls",
              subtitle: "Ancient Idioms and their stories.",
              level: "Advanced",
              color: Colors.deepOrange,
              isLocked: true,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _CourseCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String level;
  final Color color;
  final bool isLocked;
  final VoidCallback onTap;

  const _CourseCard({
    required this.title,
    required this.subtitle,
    required this.level,
    required this.color,
    required this.isLocked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isLocked ? null : onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 160,
          decoration: BoxDecoration(
            color: isLocked ? Colors.grey.withValues(alpha: 0.1) : Colors.white.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isLocked ? Colors.grey.withValues(alpha: 0.3) : color.withValues(alpha: 0.3),
              width: 1.5,
            ),
            boxShadow: [
              if (!isLocked)
                BoxShadow(
                  color: color.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                )
            ],
          ),
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isLocked ? Colors.grey : color,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        level.toUpperCase(),
                        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isLocked ? Colors.grey : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: isLocked ? Colors.grey : Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              if (isLocked)
                const Icon(Icons.lock, color: Colors.grey, size: 32)
              else
                Icon(Icons.arrow_forward_ios, color: color.withValues(alpha: 0.5), size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
