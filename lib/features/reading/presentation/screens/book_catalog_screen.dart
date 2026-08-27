import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/reading/domain/entities/book_model.dart';
import 'package:hanzi_master/features/reading/presentation/providers/book_providers.dart';
import 'package:hanzi_master/features/reading/presentation/screens/book_detail_screen.dart';
import 'package:hanzi_master/features/reading/presentation/screens/book_reader_screen.dart';
import 'package:hanzi_master/features/reading/presentation/widgets/calligraphic_book_cover.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/shared/routes/swipe_back_route.dart';

class BookCatalogScreen extends ConsumerStatefulWidget {
  final bool showBackButton;
  const BookCatalogScreen({super.key, this.showBackButton = true});

  @override
  ConsumerState<BookCatalogScreen> createState() => _BookCatalogScreenState();
}

class _BookCatalogScreenState extends ConsumerState<BookCatalogScreen> {
  String _selectedCategory = 'All';
  final int _selectedHsk = -1; // -1 = All
  final TextEditingController _searchController = TextEditingController();

  final List<String> _categories = [
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
    final inProgressAsync = ref.watch(inProgressBooksProvider);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: widget.showBackButton
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Text(
                '经典藏书阁 · Grand Library',
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
      body: catalogAsync.when(
        data: (books) {
          final query = _searchController.text.trim().toLowerCase();
          final filtered = books.where((b) {
            final matchesCat = _selectedCategory == 'All' || b.category == _selectedCategory;
            final matchesHsk = _selectedHsk == -1 || b.hskLevel == _selectedHsk;
            final matchesSearch = query.isEmpty ||
                b.title.toLowerCase().contains(query) ||
                b.titleEn.toLowerCase().contains(query) ||
                b.author.toLowerCase().contains(query) ||
                b.authorEn.toLowerCase().contains(query);
            return matchesCat && matchesHsk && matchesSearch;
          }).toList();

          final inProgressItems = inProgressAsync.value ?? [];

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // In-Progress / Continue Reading Shelf
              if (inProgressItems.isNotEmpty && query.isEmpty && _selectedCategory == 'All')
                SliverToBoxAdapter(
                  child: _buildContinueReadingShelf(context, inProgressItems, isDark, cardBg, primaryText),
                ),

              // Search & Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Search Bar
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
                            hintText: 'Search 180+ books, authors, classics...',
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
                      const SizedBox(height: 14),

                      // Category Pills
                      SizedBox(
                        height: 38,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: _categories.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 8),
                          itemBuilder: (context, index) {
                            final cat = _categories[index];
                            final isSelected = _selectedCategory == cat;
                            return GestureDetector(
                              onTap: () {
                                HapticsManager.light();
                                setState(() => _selectedCategory = cat);
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? (isDark ? Colors.amber.shade700 : const Color(0xFF2C2C2E))
                                      : cardBg,
                                  borderRadius: BorderRadius.circular(20),
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
                                      fontSize: 12,
                                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Count indicator
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          '${filtered.length} Classical & World Masterpieces',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white38 : Colors.black45,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Books Grid
              if (filtered.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Text(
                      'No books found matching your filter.',
                      style: TextStyle(
                        color: isDark ? Colors.white38 : Colors.black38,
                        fontSize: 14,
                      ),
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
                        final book = filtered[index];
                        return _buildBookCard(context, book, isDark, cardBg, primaryText);
                      },
                      childCount: filtered.length,
                    ),
                  ),
                ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error loading library: $e')),
      ),
    );
  }

  Widget _buildContinueReadingShelf(
    BuildContext context,
    List<InProgressBookItem> items,
    bool isDark,
    Color cardBg,
    Color primaryText,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 12),
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
                          showBadge: false,
                        ),
                        const SizedBox(width: 12),
                        // Info & Progress
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                item.book.title,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: primaryText,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                item.book.titleEn,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isDark ? Colors.amber.shade200 : const Color(0xFF8B0000),
                                  fontStyle: FontStyle.italic,
                                  height: 1.2,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 6),
                              // Chapter Progress
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '第${item.progress.chapterIndex}回 / 共${item.book.totalChapters}回',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: isDark ? Colors.amber.shade300 : const Color(0xFF8B0000),
                                    ),
                                  ),
                                  Text(
                                    '$percentInt%',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: isDark ? Colors.white54 : Colors.black45,
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

  Widget _buildBookCard(
    BuildContext context,
    BookModel book,
    bool isDark,
    Color cardBg,
    Color primaryText,
  ) {
    return GestureDetector(
      onTap: () {
        HapticsManager.medium();
        Navigator.of(context).push(
          SwipeBackPageRoute(
            builder: (_) => BookDetailScreen(book: book),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.06),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Calligraphic Silk Book Cover
            Expanded(
              flex: 6,
              child: CalligraphicBookCover(book: book),
            ),

            // Book Details
            Expanded(
              flex: 5,
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
                          style: TextStyle(
                            fontSize: 15.5,
                            fontWeight: FontWeight.bold,
                            color: primaryText,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          book.titleEn,
                          style: TextStyle(
                            fontSize: 12.5,
                            color: isDark ? Colors.amber.shade200 : const Color(0xFF8B0000),
                            fontStyle: FontStyle.italic,
                            height: 1.25,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 4),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.06),
                            width: 0.8,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.edit_note,
                            size: 14,
                            color: isDark ? Colors.amber.shade400 : const Color(0xFF8B0000),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              '${book.author} · ${book.authorEn}',
                              style: TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white70 : const Color(0xFF2C2C2E),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 10,
                            color: isDark ? Colors.white38 : Colors.black38,
                          ),
                        ],
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
}
