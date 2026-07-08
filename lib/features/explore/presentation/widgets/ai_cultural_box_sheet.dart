import 'package:flutter/material.dart';
import 'package:hanzi_master/core/services/amap_service.dart';

class AiCulturalBoxSheet extends StatelessWidget {
  final PlaceMatch match;
  const AiCulturalBoxSheet({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7, minChildSize: 0.3, maxChildSize: 0.95, expand: false,
      builder: (context, scrollController) => Container(padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(child: Container(width: 40, height: 4,
            decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)))),
          const SizedBox(height: 16),
          Text('${match.name} · 文化探索', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Expanded(child: ListView(controller: scrollController, children: const [
            _PlaceholderSection(title: '📖 文化背景', lines: 5),
            SizedBox(height: 16),
            _PlaceholderSection(title: '🗣️ 当地方言词汇', lines: 3),
            SizedBox(height: 16),
            _PlaceholderSection(title: '💬 实用短语', lines: 3),
          ])),
          const SizedBox(height: 12),
          SizedBox(width: double.infinity, child: ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('已保存到学习卡片库')));
              Navigator.pop(context);
            },
            icon: const Icon(Icons.save), label: const Text('保存到卡片库'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
          )),
        ])),
    );
  }
}

class _PlaceholderSection extends StatelessWidget {
  final String title;
  final int lines;
  const _PlaceholderSection({required this.title, required this.lines});

  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    const SizedBox(height: 8),
    ...List.generate(lines, (i) => Padding(padding: const EdgeInsets.only(bottom: 4),
      child: Container(height: 12, decoration: BoxDecoration(
        color: Colors.grey.shade200, borderRadius: BorderRadius.circular(4)), width: double.infinity))),
  ]);
}