import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/media/domain/models/library_story.dart';
import 'package:hanzi_master/features/media/presentation/screens/story_summary_screen.dart';
import 'package:hanzi_master/features/reading/domain/entities/book_model.dart';
import 'package:hanzi_master/features/reading/domain/entities/poetry_collection.dart';
import 'package:hanzi_master/features/reading/presentation/providers/book_providers.dart';
import 'package:hanzi_master/features/reading/presentation/screens/book_detail_screen.dart';
import 'package:hanzi_master/features/reading/presentation/screens/book_reader_screen.dart';
import 'package:hanzi_master/features/reading/presentation/widgets/calligraphic_book_cover.dart';
import 'package:hanzi_master/core/services/haptics_manager.dart';
import 'package:hanzi_master/shared/routes/swipe_back_route.dart';
import 'package:hanzi_master/shared/widgets/bouncing_button.dart';
import 'package:hanzi_master/shared/utils/hero_transition.dart';
import 'package:hanzi_master/core/presentation/widgets/zen_search_bar.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/zen_loader.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';
import 'package:hanzi_master/core/layout/zen_layout.dart';

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

  /// The book shown in the trailing pane on an iPad, or `null` when nothing is
  /// selected. The phone never sets it: it pushes [BookDetailScreen] instead.
  BookModel? _previewBook;

  // Novel filters
  String _selectedNovelCategory = 'ALL';

  // Micro-read filters
  int _selectedHsk = -1; // -1 = All

  final TextEditingController _searchController = TextEditingController();

  static const List<String> _novelCategoryKeys = [
    'ALL',
    'Chinese Epics',
    'Ancient Philosophy',
    'Supernatural & Folklore',
    'Modern Chinese',
    'French Classics',
    'German Classics',
    'Spanish & World',
    'English & World',
  ];

  String _getNovelCategoryLabel(BuildContext context, String key) {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) return key;
    switch (key) {
      case 'ALL':
        return l10n.allLabel;
      case 'Chinese Epics':
        return l10n.chineseEpics;
      case 'Ancient Philosophy':
        return l10n.ancientPhilosophy;
      case 'Supernatural & Folklore':
        return l10n.supernaturalAndFolklore;
      case 'Modern Chinese':
        return l10n.modernChinese;
      case 'French Classics':
        return l10n.frenchClassics;
      case 'German Classics':
        return l10n.germanClassics;
      case 'Spanish & World':
        return l10n.spanishAndWorld;
      case 'English & World':
        return l10n.englishAndWorld;
      default:
        return key;
    }
  }

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
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF141416) : const Color(0xFFFDFCF0);
    final cardBg = isDark ? const Color(0xFF1E1E22) : Colors.white;
    final primaryText = isDark ? Colors.white : const Color(0xFF1A1A1B);

    final catalogAsync = ref.watch(bookCatalogProvider);
    final microReadsAsync = ref.watch(microReadsProvider);
    final poetryAsync = ref.watch(poetryCollectionsProvider);
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
      body: Row(
        children: <Widget>[
          Expanded(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // 1. Search Bar & Section Pill Switcher
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- SEARCH BAR ---
                        ZenSearchBar(
                          controller: _searchController,
                          hintText: _getSearchHint(l10n),
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
                                  title: l10n.novels961,
                                  section: ReadingRoomSection.novels,
                                  isDark: isDark,
                                  cardBg: cardBg,
                                ),
                              ),
                              const SizedBox(width: 4),
                              // Micro-Reads
                              Expanded(
                                child: _buildSectionTab(
                                  title: l10n.microreads,
                                  section: ReadingRoomSection.microReads,
                                  isDark: isDark,
                                  cardBg: cardBg,
                                ),
                              ),
                              const SizedBox(width: 4),
                              // Poetry
                              Expanded(
                                child: _buildSectionTab(
                                  title: l10n.poetry1,
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
          ),
          // iPad only: the shelf stays visible while a book's detail is open.
          // The pane hosts the very same screen the phone pushes, in `embedded`
          // mode so it carries no back button (there is no route to pop).
          if (context.zenWindow.isExpanded && _previewBook != null) ...<Widget>[
            const VerticalDivider(width: 1),
            SizedBox(
              width: 420,
              child: BookDetailScreen(
                book: _previewBook!,
                embedded: true,
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _getSearchHint(AppLocalizations l10n) {
    switch (_activeSection) {
      case ReadingRoomSection.novels:
        return l10n.search96FullNovelsAuthorsEpics;
      case ReadingRoomSection.microReads:
        return l10n.searchGradedMicroStories;
      case ReadingRoomSection.poetry:
        return l10n.searchClassicalPoems;
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
        duration: ZenMotion.of(context, ZenMotion.swap),
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
          itemCount: _novelCategoryKeys.length,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            final catKey = _novelCategoryKeys[index];
            final isSelected = _selectedNovelCategory == catKey;
            final label = _getNovelCategoryLabel(context, catKey);
            return GestureDetector(
              onTap: () {
                HapticsManager.light();
                setState(() => _selectedNovelCategory = catKey);
              },
              child: AnimatedContainer(
                duration: ZenMotion.of(context, ZenMotion.swap),
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
                    label,
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
      final l10n = AppLocalizations.of(context)!;
      final hskFilters = [
        {'label': l10n.allLevelsVal, 'val': -1},
        {'label': l10n.hsk1BeginnerVal, 'val': 1},
        {'label': l10n.hsk2ElementaryVal, 'val': 2},
        {'label': l10n.hsk3IntermediateVal, 'val': 3},
        {'label': l10n.hsk4UpperIntVal, 'val': 4},
        {'label': l10n.hsk5AdvancedVal, 'val': 5},
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
                duration: ZenMotion.of(context, ZenMotion.swap),
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
        final l10n = AppLocalizations.of(context)!;
        final localeCode = Localizations.localeOf(context).toLanguageTag();
        final query = _searchController.text.trim().toLowerCase();
        final filtered = books.where((b) {
          final matchesCat = _selectedNovelCategory == 'ALL' ||
              b.category == _selectedNovelCategory;
          final matchesSearch = query.isEmpty ||
              b.title.toLowerCase().contains(query) ||
              b.titleEn.toLowerCase().contains(query) ||
              b.localizedTitle(localeCode).toLowerCase().contains(query) ||
              b.author.toLowerCase().contains(query) ||
              b.authorEn.toLowerCase().contains(query) ||
              b.localizedAuthor(localeCode).toLowerCase().contains(query);
          return matchesCat && matchesSearch;
        }).toList();

        final inProgressItems = inProgressAsync.value ?? [];

        return [
          // Continue Reading Shelf
          if (inProgressItems.isNotEmpty &&
              query.isEmpty &&
              _selectedNovelCategory == 'ALL')
            SliverToBoxAdapter(
              child: _buildContinueReadingShelf(
                  context, inProgressItems, isDark, cardBg, primaryText),
            ),
// Count indicator
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: Text(
                l10n.booksAndAudiobooks(filtered.length),
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
                  l10n.noNovelsFoundMatchingYourFilter,
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
                gridDelegate: ZenGrid.covers(
                    maxCoverWidth: 179,
                    childAspectRatio: 0.58,
                    crossSpacing: 14,
                    mainSpacing: 16),
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
          child: Center(child: ZenLoader()),
        ),
      ],
      error: (e, _) => [
        SliverFillRemaining(
          child: Center(child: Text(AppLocalizations.of(context)!.errorE(e))),
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
        final l10n = AppLocalizations.of(context)!;
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
                l10n.gradedStoriesAndMicroReads(filtered.length),
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
                  l10n.noMicroreadsFoundMatchingYourFilter,
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
                gridDelegate: ZenGrid.covers(
                    maxCoverWidth: 179,
                    childAspectRatio: 0.58,
                    crossSpacing: 14,
                    mainSpacing: 16),
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
          child: Center(child: ZenLoader()),
        ),
      ],
      error: (e, _) => [
        SliverFillRemaining(
          child: Center(child: Text(AppLocalizations.of(context)!.errorE(e))),
        ),
      ],
    );
  }

  // ==========================================
  // 3. POETRY SLIVERS (300 TANG POEMS)
  // ==========================================
  List<Widget> _buildPoetrySlivers({
    required AsyncValue<List<PoetryCollection>> poetryAsync,
    required bool isDark,
    required Color cardBg,
    required Color primaryText,
  }) {
    return poetryAsync.when(
      data: (collections) {
        final l10n = AppLocalizations.of(context)!;
        final query = _searchController.text.trim().toLowerCase();
        // A collection matches on its poet **and** on any poem it holds, so
        // searching for one poem still finds the book that contains it.
        final matches = collections.where((c) {
          if (query.isEmpty) return true;
          if (c.author.toLowerCase().contains(query)) return true;
          return c.poems.any((p) {
            final title = (p['title'] ?? '').toString().toLowerCase();
            final titleEn = (p['title_en'] ?? '').toString().toLowerCase();
            return title.contains(query) || titleEn.contains(query);
          });
        }).toList();
        final localeCode = Localizations.localeOf(context).toLanguageTag();
        final filtered = matches
            .map((collection) =>
                poetryCollectionToBook(collection, localeCode: localeCode))
            .toList(growable: false);
        // Counts poems, not books, so the label stays truthful once one book
        // holds fifty of them.
        final poemCount = matches.fold<int>(0, (sum, c) => sum + c.poemCount);

        return [
          // Count indicator
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: Text(
                l10n.classicalPoemsAndVerse(poemCount),
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
                  l10n.noPoemsFoundMatchingYourFilter,
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
                gridDelegate: ZenGrid.covers(
                    maxCoverWidth: 179,
                    childAspectRatio: 0.58,
                    crossSpacing: 14,
                    mainSpacing: 16),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return _buildPoetryGridCard(
                        context, filtered[index], isDark, cardBg, primaryText);
                  },
                  childCount: filtered.length,
                ),
              ),
            ),
        ];
      },
      loading: () => [
        const SliverFillRemaining(
          child: Center(child: ZenLoader()),
        ),
      ],
      error: (e, _) => [
        SliverFillRemaining(
          child: Center(child: Text(AppLocalizations.of(context)!.errorE(e))),
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
    final l10n = AppLocalizations.of(context)!;
    final localeCode = Localizations.localeOf(context).toLanguageTag();
    return BouncingButton(
      scaleFactor: 0.96,
      onPressed: () {
        HapticsManager.light();
        // iPad (≥840dp): the detail opens *beside* the shelf instead of covering
        // it. Phones keep the pushed route, unchanged.
        if (context.zenWindow.isExpanded) {
          setState(() => _previewBook = book);
          return;
        }
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
                    HeroTransition.wrap(
                      context: context,
                      tag: HeroTransition.heroTag('book_catalog', book.id),
                      child: CalligraphicBookCover(
                        book: book,
                        width: double.infinity,
                        height: double.infinity,
                      ),
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
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.headphones,
                                size: 10, color: Colors.amber),
                            const SizedBox(width: 3),
                            Text(
                              l10n.audiobook,
                              style: const TextStyle(
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
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          book.localizedTitle(localeCode),
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
                                l10n.audio,
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
                          ),
                        ),
                        if (story.titleEn != null &&
                            story.titleEn!.isNotEmpty) ...[
                          const SizedBox(height: 2),
                          Text(
                            story.localizedTitle(
                              Localizations.localeOf(context).toLanguageTag(),
                            ),
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
    BookModel book,
    bool isDark,
    Color cardBg,
    Color primaryText,
  ) {
    const poetryAccent = Color(0xFF8B0000);
    final l10n = AppLocalizations.of(context)!;

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
                          book.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13.5,
                            color: primaryText,
                          ),
                        ),
                        if (book.titleEn.isNotEmpty) ...[
                          const SizedBox(height: 2),
                          Text(
                            book.localizedTitle(
                              Localizations.localeOf(context).toLanguageTag(),
                            ),
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
                            l10n.chapters(book.totalChapters),
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
                            l10n.poetry1,
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
    final l10n = AppLocalizations.of(context)!;
    final localeCode = Localizations.localeOf(context).toLanguageTag();
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
                  l10n.continueReading,
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
                    final repository = ref.read(bookRepositoryProvider);
                    final isDownloaded =
                        await repository.isBookDownloaded(item.book.id);
                    if (!isDownloaded) {
                      if (context.mounted) {
                        Navigator.of(context).push(
                          SwipeBackPageRoute(
                            builder: (_) => BookDetailScreen(book: item.book),
                          ),
                        );
                      }
                      return;
                    }
                    final chapters =
                        await repository.getBookChapters(item.book.id);
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
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                item.book.localizedTitle(localeCode),
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
                                    l10n.chAbbreviation(
                                      item.progress.chapterIndex,
                                    ),
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
