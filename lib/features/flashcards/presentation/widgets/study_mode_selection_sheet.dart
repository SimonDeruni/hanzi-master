import 'package:flutter/material.dart';
import '../../domain/entities/study_mode.dart';
import 'package:hanzi_master/shared/widgets/global_blurred_bottom_sheet.dart';

class StudyModeSelectionSheet extends StatelessWidget {
  final Function(StudyMode) onModeSelected;

  const StudyModeSelectionSheet({super.key, required this.onModeSelected});

  static Future<void> show(BuildContext context, {required Function(StudyMode) onModeSelected}) {
    return GlobalBlurredBottomSheet.show(
      context,
      child: StudyModeSelectionSheet(onModeSelected: onModeSelected),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'How would you like to study?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          _buildModeButton(context, StudyMode.calligraphy, Icons.brush, Colors.blue),
          const SizedBox(height: 12),
          _buildModeButton(context, StudyMode.reading, Icons.menu_book, Colors.green),
          const SizedBox(height: 12),
          _buildModeButton(context, StudyMode.recall, Icons.psychology, Colors.orange),
          const SizedBox(height: 12),
          _buildModeButton(context, StudyMode.speaking, Icons.mic, Colors.red),
          const SizedBox(height: 12),
          _buildModeButton(context, StudyMode.listening, Icons.headphones, Colors.purple),
        ],
      ),
    );
  }

  Widget _buildModeButton(BuildContext context, StudyMode mode, IconData icon, MaterialColor color) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        onModeSelected(mode);
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? color.shade900.withValues(alpha: 0.3) : color.shade50,
          border: Border.all(
            color: isDark ? color.shade700 : color.shade200,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark ? color.shade800 : color.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: isDark ? Colors.white : color.shade700),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mode.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    mode.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? Colors.white70 : Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: isDark ? Colors.white38 : Colors.black26,
            ),
          ],
        ),
      ),
    );
  }
}
