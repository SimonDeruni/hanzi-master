import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import '../providers/story_controller.dart';
import '../screens/story_reader_screen.dart';
import 'package:hanzi_master/features/premium/presentation/screens/universal_scanner_screen.dart';

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
  int _selectedHskLevel = 0; // Default to Adaptive (Flow State)

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

  Future<void> _scanText() async {
    final extractedText = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => const UniversalScannerScreen(intent: CameraIntent.textExtraction)),
    );

    if (extractedText != null && extractedText.isNotEmpty && mounted) {
      setState(() {
        _textToSimplifyController.text = extractedText;
      });
      _handleGenerate(context);
    }
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
            tabs: [
              Tab(text: AppLocalizations.of(context)!.generateTopic),
              Tab(text: AppLocalizations.of(context)!.simplifyText),
            ],
          ),
          const SizedBox(height: 16),
          // HSK Level Selector
          Row(
            children: [
              Text(AppLocalizations.of(context)!.targetHskLevel, style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      title: Row(
                        children: [
                          Icon(Icons.psychology, color: Colors.amber[800]),
                          const SizedBox(width: 8),
                          const Text('Dynamic Flow State'),
                        ],
                      ),
                      content: const Text(
                        'Instead of a fixed HSK level, the Flow State Engine analyzes your Flashcard Library.\n\n'
                        'It builds the story primarily using words you have already mastered (to enable rapid, effortless reading) '
                        'while strategically embedding words you are currently struggling with so you can learn them in context.',
                        style: TextStyle(height: 1.5),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Got it'),
                        ),
                      ],
                    ),
                  );
                },
                child: Icon(Icons.info_outline, size: 18, color: Colors.grey[600]),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                // Adaptive Option
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FilterChip(
                    label: const Text('Dynamic (Flow State)', style: TextStyle(fontWeight: FontWeight.bold)),
                    selected: _selectedHskLevel == 0,
                    onSelected: (selected) {
                      if (selected) setState(() => _selectedHskLevel = 0);
                    },
                    selectedColor: Colors.amber.withValues(alpha: 0.3),
                    checkmarkColor: Colors.amber[800],
                    avatar: Icon(Icons.psychology, size: 18, color: _selectedHskLevel == 0 ? Colors.amber[800] : Colors.grey),
                  ),
                ),
                // HSK 1-6
                ...List.generate(6, (index) {
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
                      selectedColor: Colors.indigo.withValues(alpha: 0.2),
                      checkmarkColor: Colors.indigo,
                    ),
                  );
                }),
              ],
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
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.topicHint,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _tagsController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.tagsHint,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
                // Tab 2
                Stack(
                  children: [
                    TextField(
                      controller: _textToSimplifyController,
                      maxLines: 6,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.pasteScanToSimplify,
                        border: const OutlineInputBorder(),
                        alignLabelWithHint: true,
                      ),
                    ),
                    Positioned(
                      right: 8,
                      bottom: 8,
                      child: IconButton(
                        icon: const Icon(Icons.document_scanner, color: Colors.indigo),
                        onPressed: _scanText,
                        tooltip: 'Scan Text',
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.indigo.withValues(alpha: 0.1),
                        ),
                      ),
                    ),
                  ],
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
            child: Text(AppLocalizations.of(context)!.createMagic, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
