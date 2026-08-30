import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/media/domain/models/library_story.dart';
import 'package:hanzi_master/features/media/presentation/screens/story_summary_screen.dart';
import 'package:hanzi_master/features/reading/domain/entities/book_model.dart';
import 'package:hanzi_master/features/reading/presentation/providers/book_providers.dart';
import 'package:hanzi_master/features/reading/presentation/screens/book_detail_screen.dart';
import 'package:hanzi_master/features/reading/presentation/screens/book_reader_screen.dart';
import 'package:hanzi_master/features/reading/presentation/widgets/calligraphic_book_cover.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/shared/routes/swipe_back_route.dart';
import 'package:hanzi_master/shared/widgets/bouncing_button.dart';
import 'package:hanzi_master/core/presentation/widgets/zen_search_bar.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

enum ReadingRoomSection {
  novels,
  microReads,
  poetry,
}

class BookCatalogScreen extends ConsumerStatefulWidget {
  final bool showBackButton;
  final ReadingRoomSection initialSection;

  const BookCatalogScreen({
    super.key,
    this.showBackButton = true,
    this.initialSection = ReadingRoomSection.novels,
  });

  @override
  ConsumerState<BookCatalogScreen> createState() => _BookCatalogScreenState();
}

class _BookCatalogScreenState extends ConsumerState<BookCatalogScreen> {
  ReadingRoomSection _activeSection = ReadingRoomSection.novels;

  // Novel filters
  String _selectedNovelCategory = 'All';

  // Micro-read filters
  int _selectedHsk = -1; // -1 = All

  final TextEditingController _searchController = TextEditingController();

  List<String> _novelCategories = const ['All'];

  @override
  void initState() {
    super.initState();
    _activeSection = widget.initialSection;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final l10n = AppLocalizations.of(context);
    if (l10n != null) {
      final all = l10n.allLabel;
      if (_selectedNovelCategory == 'All') {
        _selectedNovelCategory = all;
      }
      _novelCategories = [
        all,
        l10n.chineseEpics,
        l10n.ancientPhilosophy,
        l10n.supernaturalAndFolklore,
        l10n.modernChinese,
        l10n.frenchClassics,
        l10n.germanClassics,
        l10n.spanishAndWorld,
        l10n.englishAndWorld,
      ];
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF141416) : const Color(0xFFFDFCF0);
    final cardBg = isDark ? const Color(0xFF1E1E22) : Colors.white;
    final primaryText = isDark ? Colors.white : const Color(0xFF1A1A1B);

    final catalogAsync = ref.watch(bookCatalogProvider);
    final microReadsAsync = ref.watch(microReadsProvider);
    final poetryAsync = ref.watch(chinesePoetryProvider);
    final inProgressAsync = ref.watch(inProgressBooksProvider);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: widget.showBackButton
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Text(
                AppLocalizations.of(context)!.readingRoom,
                style: TextStyle(
                  color: primaryText,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: 0.8,
                ),
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_new,
                    size: 20, color: primaryText),
                onPressed: () => Navigator.of(context).pop(),
              ),
            )
          : null,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // 1. Search Bar & Section Pill Switcher
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- SEARCH BAR ---
                  ZenSearchBar(
                    controller: _searchController,
                    hintText: _getSearchHint(),
                    onChanged: (_) => setState(() {}),
                  ),

                  const SizedBox(height: 12),

                  // --- 3-TIER READING ROOM SWITCHER ---
                  Container(
                    height: 44,
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF2C2C2E)
                          : Colors.black.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Row(
                      children: [
                        // Full Novels
                        Expanded(
                          child: _buildSectionTab(
                            title: AppLocalizations.of(context)?.novels961 ?? 'Novels (96)',
                            section: ReadingRoomSection.novels,
                            isDark: isDark,
                            cardBg: cardBg,
                          ),
                        ),
                        const SizedBox(width: 4),
                        // Micro-Reads
                        Expanded(
                          child: _buildSectionTab(
                            title: AppLocalizations.of(context)?.microreads ?? 'Micro-Reads',
                            section: ReadingRoomSection.microReads,
                            isDark: isDark,
                            cardBg: cardBg,
                          ),
                        ),
                        const SizedBox(width: 4),
                        // Poetry
                        Expanded(
                          child: _buildSectionTab(
                            title: AppLocalizations.of(context)?.poetry1 ?? 'Poetry',
                            section: ReadingRoomSection.poetry,
                            isDark: isDark,
                            cardBg: cardBg,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // --- SUB-FILTERS PER ACTIVE SECTION ---
                  _buildSubFilters(isDark, cardBg),
                ],
              ),
            ),
          ),

          // 2. Main Content based on Active Section
          if (_activeSection == ReadingRoomSection.novels)
            ..._buildNovelsSlivers(
              catalogAsync: catalogAsync,
              inProgressAsync: inProgressAsync,
              isDark: isDark,
              cardBg: cardBg,
              primaryText: primaryText,
            )
          else if (_activeSection == ReadingRoomSection.microReads)
            ..._buildMicroReadsSlivers(
              microReadsAsync: microReadsAsync,
              isDark: isDark,
              cardBg: cardBg,
              primaryText: primaryText,
            )
          else
            ..._buildPoetrySlivers(
              poetryAsync: poetryAsync,
              isDark: isDark,
              cardBg: cardBg,
              primaryText: primaryText,
            ),
        ],
      ),
    );
  }

  String _getSearchHint() {
    switch (_activeSection) {
      case ReadingRoomSection.novels:
        return 'Search 96 full novels, authors, epics...';
      case ReadingRoomSection.microReads:
        return 'Search graded micro-stories & fables...';
      case ReadingRoomSection.poetry:
        return 'Search classical poems, authors, verses...';
    }
  }

  Widget _buildSectionTab({
    required String title,
    required ReadingRoomSection section,
    required bool isDark,
    required Color cardBg,
  }) {
    final isSelected = _activeSection == section;
    return GestureDetector(
      onTap: () {
        if (_activeSection != section) {
          HapticsManager.selection();
          setState(() {
            _activeSection = section;
          });
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? const Color(0xFF3A3A3C) : Colors.white)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.12),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
            color: isSelected
                ? (isDark ? Colors.white : const Color(0xFF1A1A1B))
                : (isDark ? Colors.white60 : Colors.black54),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildSubFilters(bool isDark, Color cardBg) {
    if (_activeSection == ReadingRoomSection.novels) {
      return SizedBox(
        height: 34,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: _novelCategories.length,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            final cat = _novelCategories[index];
            final isSelected = _selectedNovelCategory == cat;
            return GestureDetector(
              onTap: () {
                HapticsManager.light();
                setState(() => _selectedNovelCategory = cat);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected
                      ? (isDark
                          ? Colors.amber.shade700
                          : const Color(0xFF2C2C2E))
                      : cardBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected
                        ? Colors.transparent
                        : (isDark ? Colors.white12 : Colors.black12),
                  ),
                ),
                child: Center(
                  child: Text(
                    cat,
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : (isDark ? Colors.white70 : Colors.black87),
                      fontSize: 11,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    } else if (_activeSection == ReadingRoomSection.microReads) {
      final hskFilters = [
        {'label': 'All Levels', 'val': -1},
        {'label': 'HSK 1 (Beginner)', 'val': 1},
        {'label': 'HSK 2 (Elementary)', 'val': 2},
        {'label': 'HSK 3 (Intermediate)', 'val': 3},
        {'label': 'HSK 4 (Upper Int)', 'val': 4},
        {'label': 'HSK 5+ (Advanced)', 'val': 5},
      ];
      return SizedBox(
        height: 34,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: hskFilters.length,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            final item = hskFilters[index];
            final val = item['val'] as int;
            final isSelected = _selectedHsk == val;
            return GestureDetector(
              onTap: () {
                HapticsManager.light();
                setState(() => _selectedHsk = val);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected
                      ? (isDark
                          ? Colors.orange.shade700
                          : const Color(0xFFFF7A00))
                      : cardBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected
                        ? Colors.transparent
                        : (isDark ? Colors.white12 : Colors.black12),
                  ),
                ),
                child: Center(
                  child: Text(
                    item['label'] as String,
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : (isDark ? Colors.white70 : Colors.black87),
                      fontSize: 11,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
    return const SizedBox.shrink();
  }

  // ==========================================
  // 1. NOVELS SLIVERS (96 MASTERPIECES)
  // ==========================================
  List<Widget> _buildNovelsSlivers({
    required AsyncValue<List<BookModel>> catalogAsync,
    required AsyncValue<List<InProgressBookItem>> inProgressAsync,
    required bool isDark,
    required Color cardBg,
    required Color primaryText,
  }) {
    return catalogAsync.when(
      data: (books) {
        final query = _searchController.text.trim().toLowerCase();
        final filtered = books.where((b) {
          final matchesCat = _selectedNovelCategory ==
                  AppLocalizations.of(context)!.allLabel ||
              b.category == _selectedNovelCategory;
          final matchesSearch = query.isEmpty ||
              b.title.toLowerCase().contains(query) ||
              b.titleEn.toLowerCase().contains(query) ||
              b.author.toLowerCase().contains(query) ||
              b.authorEn.toLowerCase().contains(query);
          return matchesCat && matchesSearch;
        }).toList();

        final inProgressItems = inProgressAsync.value ?? [];

        return [
          // Continue Reading Shelf
          if (inProgressItems.isNotEmpty &&
              query.isEmpty &&
              _selectedNovelCategory == AppLocalizations.of(context)!.allLabel)
            SliverToBoxAdapter(
              child: _buildContinueReadingShelf(
                  context, inProgressItems, isDark, cardBg, primaryText),
            ),

          // Count indicator
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: Text(
                '${filtered.length} Books & Audiobooks',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white38 : Colors.black45,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),

          // Grid
          if (filtered.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Text(
                  'No novels found matching your filter.',
                  style: TextStyle(
                      color: isDark ? Colors.white38 : Colors.black38,
                      fontSize: 14),
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.58,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 16,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _buildBookCard(
                      context, filtered[index], isDark, cardBg, primaryText),
                  childCount: filtered.length,
                ),
              ),
            ),
        ];
      },
      loading: () => [
        const SliverFillRemaining(
          child: Center(child: CircularProgressIndicator()),
        ),
      ],
      error: (e, _) => [
        SliverFillRemaining(
          child: Center(
              child: Text("Error: $e")),
        ),
      ],
    );
  }

  // ==========================================
  // 2. MICRO-READS SLIVERS (GRADED SHORT STORIES)
  // ==========================================
  List<Widget> _buildMicroReadsSlivers({
    required AsyncValue<List<LibraryStory>> microReadsAsync,
    required bool isDark,
    required Color cardBg,
    required Color primaryText,
  }) {
    return microReadsAsync.when(
      data: (stories) {
        final query = _searchController.text.trim().toLowerCase();
        final filtered = stories.where((s) {
          final matchesHsk = _selectedHsk == -1 ||
              (_selectedHsk == 5
                  ? s.hskLevel >= 5
                  : s.hskLevel == _selectedHsk);
          final matchesSearch = query.isEmpty ||
              s.title.toLowerCase().contains(query) ||
              (s.titleEn?.toLowerCase().contains(query) ?? false) ||
              s.summary.toLowerCase().contains(query);
          return matchesHsk && matchesSearch;
        }).toList();

        return [
          // Count indicator
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: Text(
                '${filtered.length} Graded Stories & Daily Micro-Reads',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white38 : Colors.black45,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),

          if (filtered.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Text(
                  'No micro-reads found matching your filter.',
                  style: TextStyle(
                      color: isDark ? Colors.white38 : Colors.black38,
                      fontSize: 14),
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.58,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 16,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _buildMicroReadCard(
                      context, filtered[index], isDark, cardBg, primaryText),
                  childCount: filtered.length,
                ),
              ),
            ),
        ];
      },
      loading: () => [
        const SliverFillRemaining(
          child: Center(child: CircularProgressIndicator()),
        ),
      ],
      error: (e, _) => [
        SliverFillRemaining(
          child: Center(
              child: Text("Error: $e")),
        ),
      ],
    );
  }

  // ==========================================
  // 3. POETRY SLIVERS (300 TANG POEMS)
  // ==========================================
  List<Widget> _buildPoetrySlivers({
    required AsyncValue<List<LibraryStory>> poetryAsync,
    required bool isDark,
    required Color cardBg,
    required Color primaryText,
  }) {
    return poetryAsync.when(
      data: (poems) {
        final query = _searchController.text.trim().toLowerCase();
        final filtered = poems.where((p) {
          final matchesSearch = query.isEmpty ||
              p.title.toLowerCase().contains(query) ||
              (p.titleEn?.toLowerCase().contains(query) ?? false) ||
              p.sourceName.toLowerCase().contains(query) ||
              p.summary.toLowerCase().contains(query);
          return matchesSearch;
        }).toList();

        return [
          // Count indicator
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: Text(
                '${filtered.length} Classical Poems & Verse',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white38 : Colors.black45,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),

          if (filtered.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Text(
                  'No poems found matching your filter.',
                  style: TextStyle(
                      color: isDark ? Colors.white38 : Colors.black38,
                      fontSize: 14),
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.58,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 16,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final poem = filtered[index];
                    return _buildPoetryGridCard(
                        context, poem, isDark, cardBg, primaryText);
                  },
                  childCount: filtered.length,
                ),
              ),
            ),
        ];
      },
      loading: () => [
        const SliverFillRemaining(
          child: Center(child: CircularProgressIndicator()),
        ),
      ],
      error: (e, _) => [
        SliverFillRemaining(
          child: Center(
              child: Text("Error: $e")),
        ),
      ],
    );
  }

  // ==========================================
  // CARD BUILDERS
  // ==========================================

  Widget _buildBookCard(
    BuildContext context,
    BookModel book,
    bool isDark,
    Color cardBg,
    Color primaryText,
  ) {
    return BouncingButton(
      scaleFactor: 0.96,
      onPressed: () {
        HapticsManager.light();
        Navigator.of(context).push(
          SwipeBackPageRoute(
            builder: (_) => BookDetailScreen(book: book),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color:
                isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.06),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.04),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 11,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(15)),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CalligraphicBookCover(
                      book: book,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.65),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.amber.withValues(alpha: 0.4),
                            width: 0.8,
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.headphones,
                                size: 10, color: Colors.amber),
                            SizedBox(width: 3),
                            Text(
                              'Audiobook',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 0.3,
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
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: primaryText,
                            fontFamily: 'NotoSerifSC',
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          book.titleEn,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 11,
                            color: primaryText.withValues(alpha: 0.7),
                            height: 1.15,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            book.author,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: isDark
                                  ? Colors.amber.shade400
                                  : const Color(0xFF8B0000),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 2),
                          decoration: BoxDecoration(
                            color: (isDark
                                    ? Colors.amber
                                    : const Color(0xFF8B0000))
                                .withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.graphic_eq,
                                size: 10,
                                color: isDark
                                    ? Colors.amber.shade300
                                    : const Color(0xFF8B0000),
                              ),
                              const SizedBox(width: 2),
                              Text(
                                'Audio',
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                  color: isDark
                                      ? Colors.amber.shade300
                                      : const Color(0xFF8B0000),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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

  Widget _buildMicroReadCard(
    BuildContext context,
    LibraryStory story,
    bool isDark,
    Color cardBg,
    Color primaryText,
  ) {
    final hskColor = _getHskColor(story.hskLevel);
    // Terracotta/amber gradient accent for micro-reads (fallback when no photo)
    const coverTop = Color(0xFFB85C1A);
    const coverMid = Color(0xFF8C3A0A);
    const coverBot = Color(0xFF5C1F00);

    // Derive local asset path from the story URL slug
    // e.g. https://mandarinbean.com/confucius/ → assets/images/mandarin_bean/confucius.jpg
    String? localImagePath;
    if (story.link.isNotEmpty) {
      final uri = Uri.tryParse(story.link);
      if (uri != null) {
        final slug =
            uri.pathSegments.where((s) => s.isNotEmpty).lastOrNull ?? '';
        if (slug.isNotEmpty) {
          localImagePath = 'assets/images/mandarin_bean/$slug.jpg';
        }
      }
    }

    return BouncingButton(
      scaleFactor: 0.96,
      onPressed: () {
        HapticsManager.light();
        Navigator.of(context).push(
          SwipeBackPageRoute(
            builder: (_) => StorySummaryScreen(story: story),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color:
                isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.06),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Calligraphic cover (top 64%) ────────────────────
            Expanded(
              flex: 11,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(15)),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // ── Background: local photo or gradient fallback ─────
                    if (localImagePath != null)
                      Image.asset(
                        localImagePath,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        errorBuilder: (_, __, ___) => Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [coverTop, coverMid, coverBot],
                            ),
                          ),
                        ),
                      )
                    else
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [coverTop, coverMid, coverBot],
                          ),
                        ),
                      ),
                    // Dark scrim for legibility over photo
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.18),
                            Colors.black.withValues(alpha: 0.55),
                          ],
                        ),
                      ),
                    ),
                    // Chinese title — centred, vertical feel
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 14, 14, 14),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              story.title,
                              textAlign: TextAlign.center,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: 'NotoSerifSC',
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Colors.white,
                                height: 1.35,
                                letterSpacing: 2,
                              ),
                            ),
                            const SizedBox(height: 10),
                            // Decorative divider
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    width: 18,
                                    height: 0.8,
                                    color: Colors.white38),
                                const SizedBox(width: 4),
                                const Text('·',
                                    style: TextStyle(
                                        color: Colors.white54, fontSize: 12)),
                                const SizedBox(width: 4),
                                Container(
                                    width: 18,
                                    height: 0.8,
                                    color: Colors.white38),
                              ],
                            ),
                            if (story.sourceName.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Text(
                                story.sourceName,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.white60,
                                  fontStyle: FontStyle.italic,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    // HSK badge — top right
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color: hskColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          story.hskLevel > 0 ? 'HSK ${story.hskLevel}' : '短篇',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // ── Text info (bottom 36%) ───────────────────────────
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          story.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: primaryText,
                            fontFamily: 'NotoSerifSC',
                          ),
                        ),
                        if (story.titleEn != null &&
                            story.titleEn!.isNotEmpty) ...[
                          const SizedBox(height: 2),
                          Text(
                            story.titleEn!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                              color: primaryText.withValues(alpha: 0.65),
                              height: 1.15,
                            ),
                          ),
                        ],
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.bolt,
                            size: 11, color: Colors.orange.shade700),
                        const SizedBox(width: 2),
                        Text(
                          AppLocalizations.of(context)!.duration12Min,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.amber.shade400 : coverTop,
                          ),
                        ),
                      ],
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

  Widget _buildPoetryGridCard(
    BuildContext context,
    LibraryStory poem,
    bool isDark,
    Color cardBg,
    Color primaryText,
  ) {
    const poetryAccent = Color(0xFF8B0000);
    final book = _poemToBook(poem);

    return BouncingButton(
      scaleFactor: 0.96,
      onPressed: () {
        HapticsManager.light();
        Navigator.of(context).push(
          SwipeBackPageRoute(
            builder: (_) => BookDetailScreen(book: book),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color:
                isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.06),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Calligraphic Cover Artwork Plate (top 64%) ────────────────────
            Expanded(
              flex: 11,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(15)),
                child: CalligraphicBookCover(
                  book: book,
                  width: double.infinity,
                  height: double.infinity,
                  showBadge: false,
                ),
              ),
            ),
            // ── Text Info (bottom 36%) ───────────────────────────
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          poem.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13.5,
                            color: primaryText,
                            fontFamily: 'NotoSerifSC',
                          ),
                        ),
                        if (poem.titleEn != null &&
                            poem.titleEn!.isNotEmpty) ...[
                          const SizedBox(height: 2),
                          Text(
                            poem.titleEn!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 10.5,
                              color: primaryText.withValues(alpha: 0.65),
                              height: 1.15,
                            ),
                          ),
                        ],
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            poem.sourceName.split('(').first.trim(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color:
                                  isDark ? Colors.amber.shade400 : poetryAccent,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 1.5),
                          decoration: BoxDecoration(
                            color: (isDark
                                    ? Colors.amber
                                    : const Color(0xFF8B0000))
                                .withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Poetry',
                            style: TextStyle(
                              fontSize: 8.5,
                              fontWeight: FontWeight.bold,
                              color: isDark
                                  ? Colors.amber.shade300
                                  : const Color(0xFF8B0000),
                            ),
                          ),
                        ),
                      ],
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

  BookModel _poemToBook(LibraryStory poem) {
    return BookModel(
      id: poem.link,
      title: poem.title,
      titleEn: poem.titleEn ?? poem.title,
      author: poem.sourceName,
      authorEn: poem.sourceName,
      category: poem.category.isNotEmpty ? poem.category : 'Chinese Poetry',
      description: poem.summary,
      descriptionEn: poem.summaryEn ?? poem.summary,
      dynastyOrEra: 'Tang Dynasty',
      hskLevel: poem.hskLevel,
      totalChapters: 1,
      coverEmoji: '📜',
      tags: poem.keywords.isNotEmpty
          ? poem.keywords
          : const ['Poetry', 'Classical', 'Verse'],
    );
  }

  Color _getHskColor(int level) {
    switch (level) {
      case 1:
        return const Color(0xFF4CAF50); // Green
      case 2:
        return const Color(0xFF009688); // Teal
      case 3:
        return const Color(0xFF2196F3); // Blue
      case 4:
        return const Color(0xFFFF9800); // Orange
      case 5:
      case 6:
        return const Color(0xFFE91E63); // Crimson
      default:
        return const Color(0xFFFF7A00);
    }
  }

  Widget _buildContinueReadingShelf(
    BuildContext context,
    List<InProgressBookItem> items,
    bool isDark,
    Color cardBg,
    Color primaryText,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(
                  Icons.auto_stories,
                  size: 16,
                  color:
                      isDark ? Colors.amber.shade400 : const Color(0xFF8B0000),
                ),
                const SizedBox(width: 6),
                Text(
                  'Continue Reading',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryText,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 125,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final item = items[index];
                final progressFraction =
                    item.progress.percentage.clamp(0.0, 1.0);
                final percentInt = (progressFraction * 100).toInt();

                return GestureDetector(
                  onTap: () async {
                    HapticsManager.medium();
                    final chapters = await ref
                        .read(bookRepositoryProvider)
                        .getBookChapters(item.book.id);
                    if (context.mounted && chapters.isNotEmpty) {
                      final targetIdx = (item.progress.chapterIndex - 1)
                          .clamp(0, chapters.length - 1);
                      Navigator.of(context).push(
                        SwipeBackPageRoute(
                          builder: (_) => BookReaderScreen(
                            book: item.book,
                            chapters: chapters,
                            initialChapterIndex: targetIdx,
                            initialSentenceIndex: item.progress.sentenceIndex,
                          ),
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: 270,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: cardBg,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDark
                            ? Colors.white12
                            : Colors.black.withValues(alpha: 0.08),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withValues(alpha: isDark ? 0.25 : 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Cover Card
                        CalligraphicBookCover(
                          book: item.book,
                          width: 65,
                          height: 95,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                item.book.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: primaryText,
                                  fontFamily: 'NotoSerifSC',
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                item.book.titleEn,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: primaryText.withValues(alpha: 0.6),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Text(
                                    'Ch. ${item.progress.chapterIndex}',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: isDark
                                          ? Colors.amber.shade400
                                          : const Color(0xFF8B0000),
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '$percentInt%',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: primaryText.withValues(alpha: 0.5),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: progressFraction,
                                  minHeight: 4,
                                  backgroundColor:
                                      isDark ? Colors.white12 : Colors.black12,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    isDark
                                        ? Colors.amber.shade400
                                        : const Color(0xFF8B0000),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
