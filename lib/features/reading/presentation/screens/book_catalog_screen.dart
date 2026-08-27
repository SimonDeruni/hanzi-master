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
  late ReadingRoomSection _activeSection;

  // Novel filters
  String _selectedNovelCategory = 'All';
  
  // Micro-read filters
  int _selectedHsk = -1; // -1 = All

  // Poetry filters
  String _selectedPoet = 'All';

  final TextEditingController _searchController = TextEditingController();

  final List<String> _novelCategories = [
    'All',
    'Chinese Epics',
    'Ancient Philosophy',
    'Supernatural & Folklore',
    'Modern Chinese',
    'French Classics',
    'German Classics',
    'Spanish & World',
    'English & World',
  ];

  final List<String> _poets = [
    'All',
    '李白 (Li Bai)',
    '杜甫 (Du Fu)',
    '王维 (Wang Wei)',
    '白居易 (Bai Juyi)',
    '孟浩然 (Meng Haoran)',
    '李商隐 (Li Shangyin)',
    '杜牧 (Du Mu)',
  ];

  @override
  void initState() {
    super.initState();
    _activeSection = widget.initialSection;
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
    final poetryAsync = ref.watch(tangPoetryProvider);
    final inProgressAsync = ref.watch(inProgressBooksProvider);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: widget.showBackButton
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Text(
                '藏书阁 · Reading Room',
                style: TextStyle(
                  color: primaryText,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: 0.8,
                ),
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_new, size: 20, color: primaryText),
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
                  Container(
                    decoration: BoxDecoration(
                      color: cardBg,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.06),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (_) => setState(() {}),
                      style: TextStyle(color: primaryText, fontSize: 15),
                      decoration: InputDecoration(
                        hintText: _getSearchHint(),
                        hintStyle: TextStyle(
                          color: isDark ? Colors.white38 : Colors.black38,
                          fontSize: 14,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: isDark ? Colors.white54 : Colors.black45,
                          size: 22,
                        ),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear, size: 18),
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() {});
                                },
                              )
                            : null,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // --- 3-TIER READING ROOM SWITCHER ---
                  Container(
                    height: 44,
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF2C2C2E) : Colors.black.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Row(
                      children: [
                        // Full Novels
                        Expanded(
                          child: _buildSectionTab(
                            title: '📚 Novels (96)',
                            section: ReadingRoomSection.novels,
                            isDark: isDark,
                            cardBg: cardBg,
                          ),
                        ),
                        const SizedBox(width: 4),
                        // Micro-Reads
                        Expanded(
                          child: _buildSectionTab(
                            title: '⚡ Micro-Reads',
                            section: ReadingRoomSection.microReads,
                            isDark: isDark,
                            cardBg: cardBg,
                          ),
                        ),
                        const SizedBox(width: 4),
                        // Poetry
                        Expanded(
                          child: _buildSectionTab(
                            title: '🏮 Poetry',
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
        return 'Search Tang poems, Li Bai, Du Fu...';
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
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected
                      ? (isDark ? Colors.amber.shade700 : const Color(0xFF2C2C2E))
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
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
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
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected
                      ? (isDark ? Colors.orange.shade700 : const Color(0xFFFF7A00))
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
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    } else {
      // Poetry Filters
      return SizedBox(
        height: 34,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: _poets.length,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            final poet = _poets[index];
            final isSelected = _selectedPoet == poet;
            return GestureDetector(
              onTap: () {
                HapticsManager.light();
                setState(() => _selectedPoet = poet);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected
                      ? (isDark ? const Color(0xFF8B0000) : const Color(0xFF8B0000))
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
                    poet,
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : (isDark ? Colors.white70 : Colors.black87),
                      fontSize: 11,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
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
          final matchesCat = _selectedNovelCategory == 'All' || b.category == _selectedNovelCategory;
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
          if (inProgressItems.isNotEmpty && query.isEmpty && _selectedNovelCategory == 'All')
            SliverToBoxAdapter(
              child: _buildContinueReadingShelf(context, inProgressItems, isDark, cardBg, primaryText),
            ),

          // Count indicator
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: Text(
                '${filtered.length} Unabridged World Masterpieces',
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
                  style: TextStyle(color: isDark ? Colors.white38 : Colors.black38, fontSize: 14),
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
                  (context, index) => _buildBookCard(context, filtered[index], isDark, cardBg, primaryText),
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
          child: Center(child: Text('Error loading novels: $e')),
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
              (_selectedHsk == 5 ? s.hskLevel >= 5 : s.hskLevel == _selectedHsk);
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
                  style: TextStyle(color: isDark ? Colors.white38 : Colors.black38, fontSize: 14),
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final story = filtered[index];
                    return _buildMicroReadCard(context, story, isDark, cardBg, primaryText);
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
          child: Center(child: Text('Error loading micro-reads: $e')),
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
          final matchesPoet = _selectedPoet == 'All' ||
              p.sourceName.toLowerCase().contains(_selectedPoet.split(' ').first.toLowerCase());
          final matchesSearch = query.isEmpty ||
              p.title.toLowerCase().contains(query) ||
              (p.titleEn?.toLowerCase().contains(query) ?? false) ||
              p.sourceName.toLowerCase().contains(query) ||
              p.summary.toLowerCase().contains(query);
          return matchesPoet && matchesSearch;
        }).toList();

        return [
          // Count indicator
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: Text(
                '${filtered.length} Classical Tang Poems & Verse',
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
                  style: TextStyle(color: isDark ? Colors.white38 : Colors.black38, fontSize: 14),
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final poem = filtered[index];
                    return _buildPoetryCard(context, poem, isDark, cardBg, primaryText);
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
          child: Center(child: Text('Error loading poetry: $e')),
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
            color: isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.06),
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
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                child: CalligraphicBookCover(
                  book: book,
                  width: double.infinity,
                  height: double.infinity,
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
                            '✍️ ${book.author}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.amber.shade400 : const Color(0xFF8B0000),
                            ),
                          ),
                        ),
                        if (book.audioStreamUrl != null && book.audioStreamUrl!.isNotEmpty) ...[
                          const SizedBox(width: 4),
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: (isDark ? Colors.amber : const Color(0xFF8B0000)).withValues(alpha: 0.15),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.volume_up,
                              size: 11,
                              color: isDark ? Colors.amber.shade300 : const Color(0xFF8B0000),
                            ),
                          ),
                        ],
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
    final hskBadgeColor = _getHskColor(story.hskLevel);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: BouncingButton(
        scaleFactor: 0.98,
        onPressed: () {
          HapticsManager.light();
          Navigator.of(context).push(
            SwipeBackPageRoute(
              builder: (_) => StorySummaryScreen(story: story),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.06),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Badge Icon Box
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: hskBadgeColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(
                    story.hskLevel > 0 ? 'HSK\n${story.hskLevel}' : '短篇',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 11,
                      color: hskBadgeColor,
                      height: 1.1,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),

              // Title & Excerpt
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            story.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: primaryText,
                              fontFamily: 'NotoSerifSC',
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.bolt, size: 12, color: Colors.orange.shade700),
                              const SizedBox(width: 2),
                              Text(
                                '1-2 min',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: isDark ? Colors.white70 : Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (story.titleEn != null && story.titleEn!.isNotEmpty) ...[
                      const SizedBox(height: 3),
                      Text(
                        story.titleEn!,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: primaryText.withValues(alpha: 0.65),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: 6),
                    Text(
                      story.summary,
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryText.withValues(alpha: 0.5),
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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

  Widget _buildPoetryCard(
    BuildContext context,
    LibraryStory poem,
    bool isDark,
    Color cardBg,
    Color primaryText,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: BouncingButton(
        scaleFactor: 0.98,
        onPressed: () {
          HapticsManager.light();
          Navigator.of(context).push(
            SwipeBackPageRoute(
              builder: (_) => StorySummaryScreen(story: poem),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isDark ? Colors.white12 : const Color(0xFF8B0000).withValues(alpha: 0.15),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Poet Seal & Title
              Row(
                children: [
                  // Traditional Cinnabar Seal Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF8B0000).withValues(alpha: isDark ? 0.25 : 0.1),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: const Color(0xFF8B0000).withValues(alpha: 0.4),
                      ),
                    ),
                    child: Text(
                      poem.sourceName.split('(').first.trim(),
                      style: const TextStyle(
                        fontFamily: 'NotoSerifSC',
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        color: Color(0xFF8B0000),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          poem.title,
                          style: TextStyle(
                            fontFamily: 'NotoSerifSC',
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: primaryText,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (poem.titleEn != null && poem.titleEn!.isNotEmpty) ...[
                          Text(
                            poem.titleEn!,
                            style: TextStyle(
                              fontSize: 11,
                              color: primaryText.withValues(alpha: 0.6),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.black26),
                ],
              ),

              const SizedBox(height: 10),

              // Verse Preview with Calligraphic Xuan Paper Look
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF141416) : const Color(0xFFFBF8E6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  poem.summary,
                  style: TextStyle(
                    fontFamily: 'NotoSerifSC',
                    fontSize: 13,
                    height: 1.5,
                    color: isDark ? Colors.amber.shade200 : const Color(0xFF2C2C2E),
                    letterSpacing: 0.8,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
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
                  color: isDark ? Colors.amber.shade400 : const Color(0xFF8B0000),
                ),
                const SizedBox(width: 6),
                Text(
                  '正在阅读 · Continue Reading',
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
                final progressFraction = item.book.totalChapters > 0
                    ? (item.progress.chapterIndex / item.book.totalChapters).clamp(0.0, 1.0)
                    : 0.1;
                final percentInt = (progressFraction * 100).toInt();

                return GestureDetector(
                  onTap: () async {
                    HapticsManager.medium();
                    final chapters = await ref.read(bookRepositoryProvider).getBookChapters(item.book.id);
                    if (context.mounted && chapters.isNotEmpty) {
                      final targetIdx = (item.progress.chapterIndex - 1).clamp(0, chapters.length - 1);
                      Navigator.of(context).push(
                        SwipeBackPageRoute(
                          builder: (_) => BookReaderScreen(
                            book: item.book,
                            chapters: chapters,
                            initialChapterIndex: targetIdx,
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
                        color: isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.08),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.05),
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
                                      color: isDark ? Colors.amber.shade400 : const Color(0xFF8B0000),
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
                                  backgroundColor: isDark ? Colors.white12 : Colors.black12,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    isDark ? Colors.amber.shade400 : const Color(0xFF8B0000),
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
