import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hanzi_master/features/media/data/story_fetcher_service.dart';
import 'package:hanzi_master/features/media/domain/models/library_story.dart';
import 'package:hanzi_master/features/reading/data/repositories/story_repository.dart';
import 'package:hanzi_master/features/media/presentation/screens/story_cultural_insight_screen.dart';
import 'package:hanzi_master/features/media/presentation/screens/story_summary_screen.dart';
import 'package:hanzi_master/features/reading/presentation/widgets/custom_story_creator_sheet.dart';
import 'package:hanzi_master/core/presentation/widgets/hanzi_text_field.dart';

class CategoryStyle {
  final List<Color> gradient;
  final String watermark;
  CategoryStyle(this.gradient, this.watermark);
}

class StoryLibraryScreen extends ConsumerStatefulWidget {
  const StoryLibraryScreen({super.key});

  @override
  ConsumerState<StoryLibraryScreen> createState() => _StoryLibraryScreenState();
}

class _StoryLibraryScreenState extends ConsumerState<StoryLibraryScreen> {
  List<LibraryStory> _allStories = [];
  bool _isLoading = true;
  List<String> _bookmarkedUrls = [];
  final TextEditingController _searchController = TextEditingController();
  
  String _selectedCategory = 'All';
  int _selectedHskLevel = -1; // -1 = All

  List<String> get _categories => ['All', 'Tang Poetry', 'Contemporary', 'AI Stories', 'Bookmarks'];
  List<int> get _hskLevels => [-1, 0, 1, 2, 3, 4, 5, 6];

  @override
  void initState() {
    super.initState();
    _loadStories();
    _searchController.addListener(() {
      setState(() {}); // Re-render when typing
    });
  }
  
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadStories() async {
    setState(() => _isLoading = true);
    final fetcher = ref.read(storyFetcherServiceProvider);
    final storyRepo = ref.read(storyRepositoryProvider);

    final results = await Future.wait([
      fetcher.fetchLocalStories(),
      fetcher.fetchFirebaseStories(),
      storyRepo.getAllStories(),
    ]);
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = prefs.getStringList('bookmarked_story_urls') ?? [];

    final localStories = results[0] as List<LibraryStory>;
    final firebaseStories = results[1] as List<LibraryStory>;
    final customStories = results[2] as List;

    final customLibraryStories = customStories.map((story) {
      final summaryText = story.sentences.isNotEmpty
          ? story.sentences.first.chinese
          : 'Custom AI generated story.';

      return LibraryStory(
        title: story.title,
        sourceName: 'AI Generated',
        link: story.id,
        imageUrl: null,
        summary: summaryText,
        category: story.category,
        sourceType: StorySourceType.json,
        hskLevel: story.hskLevel,
      );
    }).toList();

    if (mounted) {
      setState(() {
        _allStories = [...localStories, ...firebaseStories, ...customLibraryStories];
        final uniqueTitles = <String>{};
        _allStories.retainWhere((s) => uniqueTitles.add(s.title));

        _bookmarkedUrls = bookmarks;
        _isLoading = false;
      });
    }
  }

  void _openStory(LibraryStory story) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StorySummaryScreen(story: story),
      ),
    );
  }

  List<LibraryStory> get _filteredStories {
    final query = _searchController.text.toLowerCase();
    return _allStories.where((story) {
      final matchesSearch = story.title.toLowerCase().contains(query) || 
             story.summary.toLowerCase().contains(query) ||
             (story.titleEn?.toLowerCase().contains(query) ?? false) ||
             (story.summaryEn?.toLowerCase().contains(query) ?? false) ||
             story.category.toLowerCase().contains(query) ||
             story.keywords.any((k) => k.contains(query));
             
      final matchesCategory = _selectedCategory == 'All' || 
          (_selectedCategory == 'Tang Poetry' && story.category.contains('Classic')) ||
          (_selectedCategory == 'Contemporary' && story.category.contains('Contemporary')) ||
          (_selectedCategory == 'AI Stories' && story.sourceName == 'AI Generated') ||
          (_selectedCategory == 'Bookmarks' && _bookmarkedUrls.contains(story.link));
          
      final matchesHsk = _selectedHskLevel == -1 || story.hskLevel == _selectedHskLevel;
      
      return matchesSearch && matchesCategory && matchesHsk;
    }).toList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFCF0), // Zen Paper
      appBar: AppBar(
        title: const Text('文化书房 Library', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: const Color(0xFF1A1A1B),
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: _isLoading && _allStories.isEmpty
              ? const Center(child: CircularProgressIndicator(color: Color(0xFF8B0000)))
              : RefreshIndicator(
                  onRefresh: _loadStories,
                  child: _buildLibraryContent(),
                ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => const CustomStoryCreatorSheet(),
          );
        },
        backgroundColor: const Color(0xFF8B0000), // Crimson/Deep Red
        icon: const Icon(Icons.auto_awesome, color: Colors.white),
        label: const Text('Create Story', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: HanziTextField(
          controller: _searchController,
          hintText: 'Search stories, idioms, news...',
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
          ),
          suffixIcon: _searchController.text.isNotEmpty 
            ? IconButton(
                icon: const Icon(Icons.clear, color: Colors.grey),
                onPressed: () {
                  _searchController.clear();
                  FocusScope.of(context).unfocus();
                },
              )
            : null,
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _categories.map((cat) => Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ChoiceChip(
                label: Text(cat),
                selected: _selectedCategory == cat,
                onSelected: (selected) {
                  if (selected) setState(() => _selectedCategory = cat);
                },
                selectedColor: const Color(0xFF1A1A1B),
                labelStyle: TextStyle(
                  color: _selectedCategory == cat ? Colors.white : const Color(0xFF1A1A1B),
                ),
              ),
            )).toList(),
          ),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _hskLevels.map((level) => Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ChoiceChip(
                label: Text(level == -1 ? 'All HSK' : (level == 0 ? 'Native' : 'HSK $level')),
                selected: _selectedHskLevel == level,
                onSelected: (selected) {
                  if (selected) setState(() => _selectedHskLevel = level);
                },
                selectedColor: const Color(0xFF1A1A1B),
                labelStyle: TextStyle(
                  color: _selectedHskLevel == level ? Colors.white : const Color(0xFF1A1A1B),
                ),
              ),
            )).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildLibraryContent() {
    final isDefaultState = _searchController.text.isEmpty && _selectedCategory == 'All' && _selectedHskLevel == -1;
    final results = _filteredStories;

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(), // Required for RefreshIndicator
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilters(),
            if (isDefaultState) ...[
              const SizedBox(height: 16),
              _buildStoryOfTheDay(),
            ],
            const SizedBox(height: 24),
            Text(
              isDefaultState ? 'All Stories' : 'Results (${results.length})',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: Color(0xFF1A1A1B),
              ),
            ),
            const SizedBox(height: 16),
            if (results.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Text('No stories found.', style: TextStyle(color: Colors.grey, fontSize: 16)),
                ),
              )
            else
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: results.length,
                itemBuilder: (context, index) {
                  return _buildStoryCard(results[index]);
                },
              ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildStoryOfTheDay() {
    LibraryStory? dailyStory;
    if (_allStories.isNotEmpty) {
      // Find all eligible daily stories
      final eligibleStories = _allStories.where((s) => s.category.contains('Poem') || s.category.contains('Classic')).toList();
      if (eligibleStories.isEmpty) {
        eligibleStories.addAll(_allStories);
      }
      
      // Pick one based on the current day of the year so it changes exactly once per day
      final now = DateTime.now();
      final dayOfYear = now.difference(DateTime(now.year, 1, 1)).inDays;
      final dailyIndex = dayOfYear % eligibleStories.length;
      
      dailyStory = eligibleStories[dailyIndex];
    }
    
    if (dailyStory == null) return const SizedBox();
    
    final theme = Theme.of(context);
    final hasImage = dailyStory.imageUrl != null && dailyStory.imageUrl!.isNotEmpty;
    // Use an asset that was already loaded in memory
    final displayImageUrl = hasImage 
        ? dailyStory.imageUrl! 
        : 'assets/images/ai_hub_ink_mountains.png';
        
    final isNetworkImage = displayImageUrl.startsWith('http');
    
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => StoryCulturalInsightScreen(
              story: dailyStory!,
              heroTag: 'daily_story_${dailyStory.hashCode}',
            ),
          ),
        );
      },
      child: Container(
        height: 280, // Taller widget
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: theme.colorScheme.surfaceContainerHighest,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 16,
              offset: const Offset(0, 8),
            )
          ],
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              tag: 'daily_story_${dailyStory.hashCode}',
              child: isNetworkImage
                  ? Image.network(
                      displayImageUrl,
                      fit: BoxFit.cover,
                      color: Colors.black.withValues(alpha: 0.6), // Dark overlay
                      colorBlendMode: BlendMode.darken,
                      errorBuilder: (_, __, ___) => _buildFallbackGradient(),
                    )
                  : Image.asset(
                      displayImageUrl,
                      fit: BoxFit.cover,
                      color: Colors.black.withValues(alpha: 0.6), // Dark overlay
                      colorBlendMode: BlendMode.darken,
                      errorBuilder: (_, __, ___) => _buildFallbackGradient(),
                    ),
            ),
              
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white, // Pure white background
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'STORY OF THE DAY',
                      style: TextStyle(
                        color: Color(0xFF1A1A1B), 
                        fontSize: 10, 
                        fontWeight: FontWeight.w700, 
                        fontFamily: 'NotoSerifSC',
                        letterSpacing: 1.2
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    dailyStory.titleEn ?? dailyStory.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white, 
                      fontSize: 32, // Larger title
                      fontWeight: FontWeight.w600, 
                      fontFamily: 'NotoSerifSC',
                      height: 1.1
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    dailyStory.summaryEn ?? dailyStory.summary,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFallbackGradient() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2C3E50), // Slate Blue/Charcoal
            Color(0xFF1A1A1B), // Deep Carbon Ink
          ],
        ),
      ),
    );
  }

  Widget _buildStoryCard(LibraryStory story) {
    return StoryCardWidget(story: story, openStory: (s) => _openStory(s));
  }
}


class StoryCardWidget extends StatelessWidget {
  final LibraryStory story;
  final Function(LibraryStory) openStory;

  const StoryCardWidget({super.key, required this.story, required this.openStory});

  Color _getCategoryColor() {
    final cat = story.category.toLowerCase();
    if (cat.contains('idiom')) return const Color(0xFF8B0000); // Deep Red
    if (cat.contains('classic') || story.title.toLowerCase().contains('poem')) return const Color(0xFF2C3E50); // Slate Blue
    if (cat.contains('contemporary')) return const Color(0xFF2E8B57); // Forest Green
    return const Color(0xFFD35400); // Orange for Graded Readers / Others
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasImage = story.imageUrl != null && story.imageUrl!.isNotEmpty;
    // Use an asset that was already loaded in memory
    final displayImageUrl = hasImage 
        ? story.imageUrl! 
        : 'assets/images/ai_hub_ink_mountains.png';
        
    final isNetworkImage = displayImageUrl.startsWith('http');
    final cardColor = _getCategoryColor();

    return GestureDetector(
      onTap: () => openStory(story),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: theme.colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image header (fixed height for grid)
            SizedBox(
              height: 100,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (isNetworkImage)
                    Image.network(
                      displayImageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _buildFallbackGradient(cardColor),
                    )
                  else
                    Image.asset(
                      displayImageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _buildFallbackGradient(cardColor),
                    ),
                  // Tint overlay for category color
                  Container(
                    decoration: BoxDecoration(
                      color: cardColor.withValues(alpha: 0.4),
                    ),
                  ),
                  // Dark gradient at top for badge visibility
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.6),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        story.hskLevel == 0 ? 'Native' : 'HSK ${story.hskLevel}',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: cardColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      story.titleEn ?? story.title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'NotoSerifSC',
                        color: Color(0xFF1A1A1B),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Expanded(
                      child: Text(
                        story.summaryEn ?? story.summary,
                        style: TextStyle(
                          fontSize: 12,
                          color: const Color(0xFF1A1A1B).withValues(alpha: 0.6),
                          height: 1.4,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFallbackGradient(Color baseColor) {
    return Container(
      decoration: BoxDecoration(
        color: baseColor,
      ),
    );
  }
}
