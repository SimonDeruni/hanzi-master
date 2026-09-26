import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hanzi_master/features/media/data/story_fetcher_service.dart';
import 'package:hanzi_master/features/media/domain/models/library_story.dart';
import 'package:hanzi_master/features/reading/data/repositories/story_repository.dart';
import 'package:hanzi_master/features/media/presentation/screens/story_cultural_insight_screen.dart';
import 'package:hanzi_master/features/media/presentation/screens/story_summary_screen.dart';
import 'package:hanzi_master/features/media/presentation/widgets/story_cover_art.dart';
import 'package:hanzi_master/features/reading/presentation/widgets/custom_story_creator_sheet.dart';
import 'package:hanzi_master/core/presentation/widgets/hanzi_text_field.dart';
import 'package:hanzi_master/shared/routes/swipe_back_route.dart';
import 'package:hanzi_master/features/reading/domain/entities/book_model.dart';
import 'package:hanzi_master/features/reading/presentation/screens/book_detail_screen.dart';
import 'package:hanzi_master/features/reading/presentation/screens/book_catalog_screen.dart';
import 'package:hanzi_master/features/reading/domain/entities/poetry_story_id.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/zen_filter_pill.dart';
import 'package:hanzi_master/shared/widgets/zen_loader.dart';
import 'package:hanzi_master/shared/utils/hero_transition.dart';
import 'package:hanzi_master/shared/widgets/zen_overlay.dart';
import 'package:hanzi_master/core/layout/zen_layout.dart';
import 'package:hanzi_master/core/localization/story_category_labels.dart';


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

  late String _selectedCategory;
  bool _categoryInitialized = false;
  int _selectedHskLevel = -1; // -1 = All

  List<String> get _categories => [
        AppLocalizations.of(context)!.allLabel,
        AppLocalizations.of(context)!.chinesePoetry,
        AppLocalizations.of(context)!.contemporary,
        AppLocalizations.of(context)!.ai_stories,
        AppLocalizations.of(context)!.bookmarks
      ];
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_categoryInitialized) return;
    _selectedCategory = AppLocalizations.of(context)!.allLabel;
    _categoryInitialized = true;
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
    List<Map<String, dynamic>> poetryEntries = [];
    try {
      final poetryJson = await rootBundle.loadString(chinesePoetryAsset);
      poetryEntries = (jsonDecode(poetryJson) as List<dynamic>)
          .map((entry) => Map<String, dynamic>.from(entry as Map))
          .toList();
    } catch (_) {}

    final localStories = results[0] as List<LibraryStory>;
    final firebaseStories = results[1] as List<LibraryStory>;
    final customStories = results[2] as List;

    final customLibraryStories = customStories.map((story) {
      final summaryText = story.sentences.isNotEmpty
          ? story.sentences.first.chinese
          : AppLocalizations.of(context)!.custom_ai_generated_story;

      return LibraryStory(
        title: story.title,
        sourceName: AppLocalizations.of(context)!.aiGenerated,
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
        _allStories = [
          ...localStories,
          ...firebaseStories,
          ...customLibraryStories
        ];
        final uniqueTitles = <String>{};
        _allStories.retainWhere((s) => uniqueTitles.add(s.title));

        _bookmarkedUrls = bookmarks
            .map((id) => canonicalPoetryId(poetryEntries, id) ?? id)
            .toSet()
            .toList();
        _isLoading = false;
      });
    }
  }

  void _openStory(LibraryStory story) {
    if (isPoetryStoryId(story.link) || isPoetryCategory(story.category)) {
      final book = BookModel(
        id: story.link,
        title: story.title,
        titleEn: story.titleEn ?? story.title,
        localizedTitles: story.localizedTitles,
        author: story.sourceName,
        authorEn: story.sourceName,
        category: story.category.isNotEmpty
            ? AppLocalizations.of(context)!.storyCategoryLabel(story.category)
            : AppLocalizations.of(context)!.chinesePoetry,
        description: story.summary,
        descriptionEn: story.summaryEn ?? story.summary,
        dynastyOrEra: 'Tang Dynasty',
        hskLevel: story.hskLevel,
        totalChapters: 1,
        coverEmoji: '📜',
        tags: story.keywords.isNotEmpty
            ? story.keywords
            : const ['Poetry', 'Classical', 'Verse'],
      );
      Navigator.push(
        context,
        SwipeBackPageRoute(
          builder: (context) => BookDetailScreen(book: book),
        ),
      );
      return;
    }
    Navigator.push(
      context,
      SwipeBackPageRoute(
        builder: (context) => StorySummaryScreen(story: story),
      ),
    );
  }

  List<LibraryStory> get _filteredStories {
    final query = _searchController.text.toLowerCase();
    return _allStories.where((story) {
      final matchesSearch = story.title.toLowerCase().contains(query) ||
          story.localizedTitles.values
              .any((title) => title.toLowerCase().contains(query)) ||
          story.summary.toLowerCase().contains(query) ||
          (story.titleEn?.toLowerCase().contains(query) ?? false) ||
          (story.summaryEn?.toLowerCase().contains(query) ?? false) ||
          story.category.toLowerCase().contains(query) ||
          story.keywords.any((k) => k.contains(query));

      final matchesCategory = _selectedCategory ==
              AppLocalizations.of(context)!.allLabel ||
          (_selectedCategory == AppLocalizations.of(context)!.chinesePoetry &&
              (story.category == AppLocalizations.of(context)!.chinesePoetry ||
                  isPoetryCategory(story.category))) ||
          (_selectedCategory == AppLocalizations.of(context)!.contemporary &&
              story.category
                  .contains(AppLocalizations.of(context)!.contemporary)) ||
          (_selectedCategory == AppLocalizations.of(context)!.ai_stories &&
              story.sourceName == AppLocalizations.of(context)!.aiGenerated) ||
          (_selectedCategory == AppLocalizations.of(context)!.bookmarks &&
              _bookmarkedUrls.contains(story.link));

      final matchesHsk =
          _selectedHskLevel == -1 || story.hskLevel == _selectedHskLevel;

      return matchesSearch && matchesCategory && matchesHsk;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF1A1A1B)
          : const Color(0xFFFDFCF0), // Zen Paper
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.culturalReadingRoom,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor:
            isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B),
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  SwipeBackPageRoute(builder: (_) => const BookCatalogScreen()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isDark
                        ? [const Color(0xFF321A1A), const Color(0xFF1E1E24)]
                        : [const Color(0xFF8B0000), const Color(0xFF5C0000)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF8B0000).withValues(alpha: 0.25),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Text('🏛️', style: TextStyle(fontSize: 28)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.theMainLibrary,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)!
                                .k80CompleteClassicNovelsWorldEpics,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.85),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios,
                        color: Colors.white, size: 16),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _isLoading && _allStories.isEmpty
                ? const Center(child: ZenLoader(color: Color(0xFF8B0000)))
                : RefreshIndicator(
                    onRefresh: _loadStories,
                    child: _buildLibraryContent(),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          zenSheet(
            context,
            useRootNavigator: true,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => const CustomStoryCreatorSheet(),
          );
        },
        backgroundColor: const Color(0xFF8B0000), // Crimson/Deep Red
        icon: const Icon(Icons.auto_awesome, color: Colors.white),
        label: Text(AppLocalizations.of(context)!.createStory,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
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
          hintText: AppLocalizations.of(context)!.searchStoriesIdiomsNews,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search, color: Colors.grey),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 16),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _categories
                .map((cat) => Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ZenFilterPill(
                        label: cat,
                        isSelected: _selectedCategory == cat,
                        isDark: isDark,
                        onTap: () => setState(() => _selectedCategory = cat),
                      ),
                    ))
                .toList(),
          ),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _hskLevels
                .map((level) => Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ZenFilterPill(
                        label: level == -1
                            ? 'All HSK'
                            : (level == 0
                                ? AppLocalizations.of(context)!.native
                                : 'HSK $level'),
                        isSelected: _selectedHskLevel == level,
                        isDark: isDark,
                        onTap: () => setState(() => _selectedHskLevel = level),
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildLibraryContent() {
    final isDefaultState = _searchController.text.isEmpty &&
        _selectedCategory == AppLocalizations.of(context)!.allLabel &&
        _selectedHskLevel == -1;
    final results = _filteredStories;

    return SingleChildScrollView(
      physics:
          const AlwaysScrollableScrollPhysics(), // Required for RefreshIndicator
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
            Builder(builder: (context) {
              final isDarkSection =
                  Theme.of(context).brightness == Brightness.dark;
              return Text(
                isDefaultState ? 'All Stories' : 'Results (${results.length})',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: isDarkSection
                      ? const Color(0xFFFDFCF0)
                      : const Color(0xFF1A1A1B),
                ),
              );
            }),
            const SizedBox(height: 16),
            if (results.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Text(AppLocalizations.of(context)!.noStoriesFound,
                      style: const TextStyle(color: Colors.grey, fontSize: 16)),
                ),
              )
            else
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: ZenGrid.covers(
                    maxCoverWidth: 175,
                    childAspectRatio: 0.7,
                    crossSpacing: 16,
                    mainSpacing: 16),
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
      final eligibleStories =
          _allStories.where((s) => isPoetryCategory(s.category)).toList();
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
    // The daily story gets its real Mandarin Bean cover too.
    final coverProvider = StoryCoverArt.resolveProvider(dailyStory);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          SwipeBackPageRoute(
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
            // The tag used to be `'daily_story_${dailyStory.hashCode}'`, which can
            // never match the destination: an identity hashCode is not stable
            // across runs, and the object on the summary route is a different
            // instance. Naming the pair by the story's own link makes the flight
            // deterministic, and uses the frozen namespaced tag scheme.
            HeroTransition.wrap(
              context: context,
              tag: HeroTransition.heroTag('story_library', dailyStory.link),
              child: coverProvider == null
                  ? _buildFallbackGradient()
                  : Image(
                      image: coverProvider,
                      fit: BoxFit.cover,
                      // Keep the darkening so the overlaid title stays legible.
                      color: Colors.black.withValues(alpha: 0.6),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white, // Pure white background
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.storyOfTheDay,
                      style: const TextStyle(
                          color: Color(0xFF1A1A1B),
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    dailyStory.localizedTitle(
                      Localizations.localeOf(context).toLanguageTag(),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32, // Larger title
                        fontWeight: FontWeight.w600,
                        height: 1.1),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    dailyStory.summary.isNotEmpty
                        ? dailyStory.summary
                        : (dailyStory.summaryEn ?? ''),
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

  const StoryCardWidget(
      {super.key, required this.story, required this.openStory});

  Color _getCategoryColor() {
    final cat = story.category.toLowerCase();
    if (cat.contains('idiom')) return const Color(0xFF8B0000); // Deep Red
    if (isPoetryCategory(story.category)) {
      return const Color(0xFF2C3E50); // Slate Blue
    }
    if (cat.contains('contemporary')) {
      return const Color(0xFF2E8B57); // Forest Green
    }
    return const Color(0xFFD35400); // Orange for Graded Readers / Others
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // The story's own artwork: its URL, or the Mandarin Bean cover bundled with
    // the app. No more generic landscape on every card.
    final coverProvider = StoryCoverArt.resolveProvider(story);

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
                  if (coverProvider == null)
                    _buildFallbackGradient(cardColor)
                  else
                    Image(
                      image: coverProvider,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          _buildFallbackGradient(cardColor),
                    ),
                  // A light category wash keeps the colour-coding without
                  // drowning the illustration (it used to sit at 0.4).
                  Container(
                    decoration: BoxDecoration(
                      color: cardColor.withValues(alpha: 0.18),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        story.hskLevel == 0
                            ? AppLocalizations.of(context)!.native
                            : 'HSK ${story.hskLevel}',
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
                      story.localizedTitle(
                        Localizations.localeOf(context).toLanguageTag(),
                      ),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: theme.brightness == Brightness.dark
                            ? const Color(0xFFFDFCF0)
                            : const Color(0xFF1A1A1B),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Expanded(
                      child: Text(
                        story.summary.isNotEmpty
                            ? story.summary
                            : (story.summaryEn ?? ''),
                        style: TextStyle(
                          fontSize: 12,
                          color: (theme.brightness == Brightness.dark
                                  ? const Color(0xFFFDFCF0)
                                  : const Color(0xFF1A1A1B))
                              .withValues(alpha: 0.6),
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
