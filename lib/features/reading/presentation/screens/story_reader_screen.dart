import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/story_controller.dart';
import '../../../../shared/widgets/clickable_chinese_text.dart';

class StoryReaderScreen extends ConsumerStatefulWidget {
  final StoryBlueprint blueprint;
  final int hskLevel;

  const StoryReaderScreen({
    super.key,
    required this.blueprint,
    required this.hskLevel,
  });

  @override
  ConsumerState<StoryReaderScreen> createState() => _StoryReaderScreenState();
}

class _StoryReaderScreenState extends ConsumerState<StoryReaderScreen> {
  bool _showTranslation = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(storyControllerProvider.notifier).loadOrGenerateStory(widget.blueprint, widget.hskLevel);
    });
  }

  @override
  void deactivate() {
    ref.read(storyControllerProvider.notifier).clearCurrentStory();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(storyControllerProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text('${widget.blueprint.title} (HSK ${widget.hskLevel})', style: const TextStyle(fontSize: 16)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.translate, color: _showTranslation ? Colors.indigo : Colors.grey),
            onPressed: () {
              setState(() {
                _showTranslation = !_showTranslation;
              });
            },
          )
        ],
      ),
      body: state.isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(color: Colors.indigo),
                  const SizedBox(height: 24),
                  const Text("Generating story via DeepSeek...", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 8),
                  Text("HSK ${widget.hskLevel} vocabulary", style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            )
          : state.error != null
              ? Center(child: Text("Error: ${state.error}", style: const TextStyle(color: Colors.red)))
              : state.currentStory == null
                  ? const Center(child: Text("Story not found."))
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Zen Typography style for the story
                          ClickableChineseText(
                            state.currentStory!.content,
                            style: const TextStyle(
                              fontSize: 24,
                              height: 1.8,
                              color: Color(0xFF1A1A1B), // Ink
                            ),
                          ),
                          const SizedBox(height: 48),
                          if (_showTranslation)
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.05),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(Icons.g_translate, size: 16, color: Colors.indigo),
                                      SizedBox(width: 8),
                                      Text("English Translation", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo)),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    state.currentStory!.englishTranslation,
                                    style: const TextStyle(fontSize: 16, height: 1.5, color: Colors.black87),
                                  ),
                                ],
                              ),
                            )
                        ],
                      ),
                    ),
    );
  }
}
