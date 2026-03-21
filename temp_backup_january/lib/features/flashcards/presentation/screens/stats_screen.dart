import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/stats_controller.dart';

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncStats = ref.watch(statsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("My Progress")),
      backgroundColor: Colors.grey.shade100,
      body: asyncStats.when(
        data: (stats) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Overview", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              
              // TOP ROW: Total & Due
              Row(
                children: [
                  _StatCard(
                    title: "Total Cards",
                    value: "${stats.totalCards}",
                    color: Colors.blue,
                    icon: Icons.style,
                  ),
                  const SizedBox(width: 16),
                  _StatCard(
                    title: "Due Now",
                    value: "${stats.dueToday}",
                    color: Colors.orange,
                    icon: Icons.notifications_active,
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // MIDDLE ROW: Mastery
              Row(
                children: [
                  _StatCard(
                    title: "Learned",
                    value: "${stats.learnedCards}",
                    color: Colors.green,
                    icon: Icons.school,
                  ),
                  const SizedBox(width: 16),
                  _StatCard(
                    title: "Mastered",
                    value: "${stats.masteredCards}",
                    color: Colors.purple,
                    icon: Icons.emoji_events,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // BOTTOM: Retention Bar
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Retention Health", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${stats.retentionRate.toStringAsFixed(1)}%", style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.indigo)),
                        const Text("Target: 90%", style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: stats.retentionRate / 100,
                      backgroundColor: Colors.grey.shade200,
                      color: stats.retentionRate > 80 ? Colors.green : Colors.orange,
                      minHeight: 10,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Error: $err")),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;

  const _StatCard({
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 28),
                const Spacer(),
                Text(value, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: color)),
              ],
            ),
            const SizedBox(height: 8),
            Text(title, style: TextStyle(color: Colors.grey.shade600, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}