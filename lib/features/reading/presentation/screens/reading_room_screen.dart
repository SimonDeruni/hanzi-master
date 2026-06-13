import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/story_controller.dart';
import 'story_reader_screen.dart';
import '../widgets/custom_story_creator_sheet.dart';

class ReadingRoomScreen extends ConsumerStatefulWidget {
  const ReadingRoomScreen({super.key});

  @override
  ConsumerState<ReadingRoomScreen> createState() => _ReadingRoomScreenState();
}

class _ReadingRoomScreenState extends ConsumerState<ReadingRoomScreen> {
  int _selectedHskLevel = 2; // Default HSK 2
  String _searchQuery = "";
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showCreatorSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const CustomStoryCreatorSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final storyState = ref.watch(storyControllerProvider);
    final blueprints = storyState.blueprints;

    // Filter blueprints based on search query
    final filteredBlueprints = blueprints.where((b) {
      if (_searchQuery.isEmpty) return true;
      final query = _searchQuery.toLowerCase();
      if (b.title.toLowerCase().contains(query)) return true;
      if (b.topic.toLowerCase().contains(query)) return true;
      if (b.tags.any((tag) => tag.toLowerCase().contains(query))) return true;
      return false;
    }).toList();

    // Group by category
    final groupedBlueprints = <String, List<StoryBlueprint>>{};
    for (var b in filteredBlueprints) {
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showCreatorSheet(context, ref);
        },
        icon: const Icon(Icons.auto_awesome),
        label: const Text("Creator Mode"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search stories by title or tags (e.g. mythology, travel)',
                prefixIcon: const Icon(Icons.search, color: Colors.indigo),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = "");
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),

          // Level Selector
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
            child: groupedBlueprints.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Text(
                        "No stories found matching your search.",
                        style: TextStyle(color: Colors.black54, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 8, bottom: 24),
                    itemCount: groupedBlueprints.keys.length,
                    itemBuilder: (context, index) {
                      final category = groupedBlueprints.keys.elementAt(index);
                      final stories = groupedBlueprints[category]!;
                      
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                            child: Text(
                              category,
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo),
                            ),
                          ),
                          SizedBox(
                            height: 240,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              itemCount: stories.length,
                              itemBuilder: (context, storyIndex) {
                                final blueprint = stories[storyIndex];
                                return _buildStoryCard(context, blueprint);
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoryCard(BuildContext context, StoryBlueprint blueprint) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 16, bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ]
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              SizedBox(
                height: 110,
                width: double.infinity,
                child: Image.network(
                  blueprint.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[200], 
                    child: const Icon(Icons.image_not_supported, color: Colors.grey)
                  ),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: Colors.grey[100],
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.indigo.withValues(alpha: 0.5),
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        blueprint.title, 
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15), 
                        maxLines: 1, 
                        overflow: TextOverflow.ellipsis
                      ),
                      const SizedBox(height: 4),
                      Text(
                        blueprint.topic, 
                        style: TextStyle(color: Colors.black.withValues(alpha: 0.6), fontSize: 12), 
                        maxLines: 2, 
                        overflow: TextOverflow.ellipsis
                      ),
                      const Spacer(),
                      // Tags
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: blueprint.tags.take(3).map((tag) => Container(
                            margin: const EdgeInsets.only(right: 6),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.indigo.withValues(alpha: 0.08), 
                              borderRadius: BorderRadius.circular(6)
                            ),
                            child: Text(
                              '#$tag', 
                              style: const TextStyle(fontSize: 10, color: Colors.indigo, fontWeight: FontWeight.bold)
                            ),
                          )).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
