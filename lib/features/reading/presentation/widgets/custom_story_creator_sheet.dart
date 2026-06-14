import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/story_controller.dart';
import '../screens/story_reader_screen.dart';

class CustomStoryCreatorSheet extends ConsumerStatefulWidget {
  const CustomStoryCreatorSheet({super.key});

  @override
  ConsumerState<CustomStoryCreatorSheet> createState() => _CustomStoryCreatorSheetState();
}

class _CustomStoryCreatorSheetState extends ConsumerState<CustomStoryCreatorSheet> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _topicController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();
  final TextEditingController _textToSimplifyController = TextEditingController();
  int _selectedHskLevel = 2;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _topicController.dispose();
    _tagsController.dispose();
    _textToSimplifyController.dispose();
    super.dispose();
  }

  Future<void> _handleGenerate(BuildContext context) async {
    final controller = ref.read(storyControllerProvider.notifier);
    
    if (_tabController.index == 0) {
      // Generate Topic
      final topic = _topicController.text.trim();
      if (topic.isEmpty) return;
      
      final tags = _tagsController.text.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
      
      Navigator.pop(context); // Close sheet
      
      final blueprint = await controller.generateCustomStoryByTopic(topic, tags, _selectedHskLevel);
      if (context.mounted) {
        _openStoryImmediate(context, blueprint);
      }
    } else {
      // Simplify text
      final text = _textToSimplifyController.text.trim();
      if (text.isEmpty) return;
      
      Navigator.pop(context); // Close sheet
      
      final blueprint = await controller.generateSimplifiedStory(text, _selectedHskLevel);
      if (context.mounted) {
        _openStoryImmediate(context, blueprint);
      }
    }
  }

  void _openStoryImmediate(BuildContext context, StoryBlueprint blueprint) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => StoryReaderScreen(blueprint: blueprint, hskLevel: _selectedHskLevel),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TabBar(
            controller: _tabController,
            labelColor: Colors.indigo,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(text: "Generate Topic"),
              Tab(text: "Simplify Text"),
            ],
          ),
          const SizedBox(height: 16),
          // HSK Level Selector
          Text("Target HSK Level", style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(6, (index) {
                final level = index + 1;
                final isSelected = _selectedHskLevel == level;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FilterChip(
                    label: Text('HSK $level'),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) setState(() => _selectedHskLevel = level);
                    },
                    selectedColor: Colors.indigo.withOpacity(0.2),
                    checkmarkColor: Colors.indigo,
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: TabBarView(
              controller: _tabController,
              children: [
                // Tab 1
                Column(
                  children: [
                    TextField(
                      controller: _topicController,
                      decoration: const InputDecoration(
                        labelText: 'Topic (e.g. Aliens in Beijing)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _tagsController,
                      decoration: const InputDecoration(
                        labelText: 'Tags (comma separated, optional)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
                // Tab 2
                TextField(
                  controller: _textToSimplifyController,
                  maxLines: 6,
                  decoration: const InputDecoration(
                    labelText: 'Paste Chinese or English text to simplify',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => _handleGenerate(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Create Magic', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
