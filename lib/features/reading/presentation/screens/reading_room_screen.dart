import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/story_controller.dart';
import 'story_reader_screen.dart';
import '../widgets/custom_story_creator_sheet.dart';
import 'package:hanzi_master/core/presentation/widgets/hanzi_text_field.dart';
import '../../../../shared/widgets/info_bulb.dart';
import 'package:hanzi_master/shared/routes/swipe_back_route.dart';

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

  String _localizeCategory(BuildContext context, String category) {
    final l10n = AppLocalizations.of(context)!;
    switch (category) {
      case 'Myths & Legends': return l10n.mythsAndLegends;
      case 'History & Culture': return l10n.historyAndCulture;
      case 'Idioms (成语)': return l10n.idiomsTitle;
      default: return category;
    }
  }

  String _localizeTitle(BuildContext context, String title) {
    final l10n = AppLocalizations.of(context)!;
    switch (title) {
      case 'The Monkey King': return l10n.theMonkeyKing;
      case 'Hua Mulan': return l10n.huaMulan;
      case 'Confucius': return l10n.confuciusTitle;
      case 'The Great Wall': return l10n.theGreatWall;
      default: return title;
    }
  }

  String _localizeTopic(BuildContext context, String topic) {
    final l10n = AppLocalizations.of(context)!;
    switch (topic) {
      case 'Sun Wukong (Journey to the West)': return l10n.theMonkeyKingDesc;
      case 'Hua Mulan joining the army instead of her father': return l10n.huaMulanDesc;
      case 'The life and teachings of Confucius': return l10n.confuciusDesc;
      case 'Building the Great Wall of China': return l10n.theGreatWallDesc;
      default: return topic;
    }
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
        title: Text(AppLocalizations.of(context)!.culturalReadingRoom, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: const [InfoBulb(id: "reading_room", title: "Reading Room", message: "Explore culturally rich Chinese stories graded by HSK level. Each story helps you learn vocabulary in context.")],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: HanziTextField(
              controller: _searchController,
              hintText: AppLocalizations.of(context)!.searchStoriesHint,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.indigo),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        setState(() => _searchQuery = "");
                      },
                    )
                  : null,
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
                ? Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Text(
                        AppLocalizations.of(context)!.noStoriesFoundMatching,
                        style: TextStyle(color: Colors.black54, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 8, bottom: 24),
                    itemCount: groupedBlueprints.keys.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: InkWell(
                            onTap: () => _showCreatorSheet(context, ref),
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF3F51B5), Color(0xFF5C6BC0)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.indigo.withValues(alpha: 0.3),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  )
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.auto_awesome, color: Colors.white, size: 28),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!.creatorMode,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        const Text(
                                          "Generate a custom AI story based on your interests",
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                      
                      final category = groupedBlueprints.keys.elementAt(index - 1);
                      final stories = groupedBlueprints[category]!;
                      
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                            child: Text(
                              _localizeCategory(context, category),
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
              SwipeBackPageRoute(
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
                  headers: const {"User-Agent": "HanziMaster/1.0"},
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.indigo.shade300, Colors.deepPurple.shade400],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        blueprint.category == 'Myths & Legends' ? Icons.auto_awesome :
                        blueprint.category == 'History & Culture' ? Icons.account_balance :
                        blueprint.category == 'Idioms (成语)' ? Icons.menu_book : Icons.landscape,
                        color: Colors.white.withValues(alpha: 0.8),
                        size: 40,
                      ),
                    ),
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
                        _localizeTitle(context, blueprint.title), 
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15), 
                        maxLines: 1, 
                        overflow: TextOverflow.ellipsis
                      ),
                      SizedBox(height: 4),
                      Text(
                        _localizeTopic(context, blueprint.topic), 
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
