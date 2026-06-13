import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/story_controller.dart';
import 'story_reader_screen.dart';

class ReadingRoomScreen extends ConsumerStatefulWidget {
  const ReadingRoomScreen({super.key});

  @override
  ConsumerState<ReadingRoomScreen> createState() => _ReadingRoomScreenState();
}

class _ReadingRoomScreenState extends ConsumerState<ReadingRoomScreen> {
  int _selectedHskLevel = 2; // Default HSK 2

  @override
  Widget build(BuildContext context) {
    final blueprints = StoryController.blueprints;
    
    // Group by category
    final groupedBlueprints = <String, List<StoryBlueprint>>{};
    for (var b in blueprints) {
      if (!groupedBlueprints.containsKey(b.category)) {
        groupedBlueprints[b.category] = [];
      }
      groupedBlueprints[b.category]!.add(b);
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('文化书房 (Cultural Reading Room)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Level Selector
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black.withValues(alpha: 0.05))),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Select Your Reading Level", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(6, (index) {
                      final level = index + 1;
                      final isSelected = _selectedHskLevel == level;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          label: Text("HSK $level"),
                          selected: isSelected,
                          onSelected: (selected) {
                            if (selected) setState(() => _selectedHskLevel = level);
                          },
                          selectedColor: Colors.indigo,
                          labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black87),
                          backgroundColor: Colors.white,
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
          
          // Stories List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: groupedBlueprints.keys.length,
              itemBuilder: (context, index) {
                final category = groupedBlueprints.keys.elementAt(index);
                final stories = groupedBlueprints[category]!;
                
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 8),
                      child: Text(
                        category,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo),
                      ),
                    ),
                    ...stories.map((blueprint) => Card(
                      elevation: 0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black.withValues(alpha: 0.05)),
                        borderRadius: BorderRadius.circular(12)
                      ),
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        title: Text(blueprint.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(blueprint.topic, style: TextStyle(color: Colors.black.withValues(alpha: 0.6))),
                        ),
                        trailing: const Icon(Icons.menu_book, color: Colors.indigo),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StoryReaderScreen(
                                blueprint: blueprint,
                                hskLevel: _selectedHskLevel,
                              ),
                            ),
                          );
                        },
                      ),
                    )),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
