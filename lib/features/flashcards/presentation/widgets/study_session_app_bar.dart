import 'package:flutter/material.dart';

class StudySessionAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final int dueCount;
  final int newCount;
  final int learningCount;
  final VoidCallback? onBack;

  const StudySessionAppBar({
    super.key,
    required this.title,
    required this.dueCount,
    required this.newCount,
    this.learningCount = 0,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: onBack ?? () => Navigator.pop(context),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildStatPill(newCount, Colors.blue),
              const SizedBox(width: 8),
              _buildStatPill(learningCount, Colors.red),
              const SizedBox(width: 8),
              _buildStatPill(dueCount, Colors.green),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatPill(int count, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: count > 0 ? color.withAlpha(30) : Colors.grey.withAlpha(30),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: count > 0 ? color.withAlpha(100) : Colors.grey.withAlpha(100),
          width: 1,
        ),
      ),
      child: Text(
        count.toString(),
        style: TextStyle(
          color: count > 0 ? color : Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
