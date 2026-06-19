import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../domain/entities/study_mode.dart';
import '../providers/stats_controller.dart';
import '../providers/stats_state.dart';

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final StatsState stats = ref.watch(userStatsProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = isDark ? Colors.grey[900]! : Colors.grey.shade100;
    final cardColor = isDark ? Colors.grey[850]! : Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Progress"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Overview", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            
            Row(
              children: [
                _StatCard(title: "Total Words", value: "${stats.total}", color: Colors.blue, icon: Icons.style, cardColor: cardColor),
                const SizedBox(width: 16),
                _StatCard(title: "New Ink", value: "${stats.newCards}", color: Colors.orange, icon: Icons.auto_awesome, cardColor: cardColor),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _StatCard(title: "Learning", value: "${stats.learning}", color: Colors.green, icon: Icons.brush, cardColor: cardColor),
                const SizedBox(width: 16),
                _StatCard(title: "Mastered", value: "${stats.mastered}", color: Colors.purple, icon: Icons.emoji_events, cardColor: cardColor),
              ],
            ),
            const SizedBox(height: 24),

            // Library Mastery Donut Chart
            _ChartCard(
              title: "Library Mastery",
              cardColor: cardColor,
              child: SizedBox(
                height: 200,
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 2,
                    centerSpaceRadius: 40,
                    sections: [
                      PieChartSectionData(
                        color: Colors.purple,
                        value: stats.mastered.toDouble(),
                        title: stats.mastered > 0 ? '${stats.mastered}' : '',
                        radius: 50,
                        titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      PieChartSectionData(
                        color: Colors.green,
                        value: stats.learning.toDouble(),
                        title: stats.learning > 0 ? '${stats.learning}' : '',
                        radius: 50,
                        titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      PieChartSectionData(
                        color: Colors.orange,
                        value: stats.newCards.toDouble(),
                        title: stats.newCards > 0 ? '${stats.newCards}' : '',
                        radius: 50,
                        titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Accuracy By Mode
            _ChartCard(
              title: "Accuracy by Mode",
              cardColor: cardColor,
              child: Column(
                children: StudyMode.values.map((mode) {
                  final accuracy = stats.accuracyByMode[mode] ?? 0.0;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(mode.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                            Text("${accuracy.toStringAsFixed(1)}%", style: const TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 6),
                        LinearProgressIndicator(
                          value: accuracy / 100,
                          backgroundColor: isDark ? Colors.grey[700] : Colors.grey.shade200,
                          color: accuracy > 80 ? Colors.green : (accuracy > 50 ? Colors.orange : Colors.red),
                          minHeight: 8,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),

            // Upcoming Reviews Bar Chart
            _ChartCard(
              title: "Upcoming Reviews (Next 7 Days)",
              cardColor: cardColor,
              child: SizedBox(
                height: 200,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: (stats.upcomingReviews.reduce((a, b) => a > b ? a : b).toDouble() * 1.2).clamp(10.0, double.infinity),
                    barTouchData: BarTouchData(enabled: false),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            final days = ['Today', '1d', '2d', '3d', '4d', '5d', '6d'];
                            if (value.toInt() >= 0 && value.toInt() < days.length) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(days[value.toInt()], style: const TextStyle(fontSize: 10)),
                              );
                            }
                            return const Text('');
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    gridData: FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    barGroups: List.generate(
                      7,
                      (index) => BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            toY: stats.upcomingReviews[index].toDouble(),
                            color: Colors.blue,
                            width: 16,
                            borderRadius: BorderRadius.circular(4),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;
  final Color cardColor;

  const _StatCard({
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
    required this.cardColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: cardColor,
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
            Text(title, style: TextStyle(color: Colors.grey, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class _ChartCard extends StatelessWidget {
  final String title;
  final Widget child;
  final Color cardColor;

  const _ChartCard({required this.title, required this.child, required this.cardColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }
}
