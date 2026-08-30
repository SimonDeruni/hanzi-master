import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';
import '../providers/story_controller.dart';
import '../providers/book_providers.dart';
import 'story_reader_screen.dart';
import 'book_reader_screen.dart';
import '../widgets/custom_story_creator_sheet.dart';
import '../widgets/continue_reading_card.dart';
import 'package:hanzi_master/core/presentation/widgets/zen_search_bar.dart';
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
    if (category == l10n.mythsAndLegends) return l10n.mythsAndLegends;
    if (category == l10n.historyAndCulture) return l10n.historyAndCulture;
    if (category == l10n.idiomsTitle) return l10n.idiomsTitle;
    return category;
  }

  String _localizeTitle(BuildContext context, String title) {
    final l10n = AppLocalizations.of(context)!;
    if (title == l10n.theMonkeyKing) return l10n.theMonkeyKing;
    if (title == l10n.huaMulan) return l10n.huaMulan;
    if (title == l10n.confuciusTitle) return l10n.confuciusTitle;
    if (title == l10n.theGreatWall) return l10n.theGreatWall;
    return title;
  }

  String _localizeTopic(BuildContext context, String topic) {
    final l10n = AppLocalizations.of(context)!;
    if (topic == l10n.theMonkeyKingDesc) return l10n.theMonkeyKingDesc;
    if (topic == l10n.huaMulanDesc) return l10n.huaMulanDesc;
    if (topic == l10n.confuciusDesc) return l10n.confuciusDesc;
    if (topic == l10n.theGreatWallDesc) return l10n.theGreatWallDesc;
    return topic;
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
        title: Text(AppLocalizations.of(context)!.culturalReadingRoom,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: const [],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Continue Reading Hero ──
          _buildContinueReadingSection(ref),

          const SizedBox(height: 8),

          // ── Recent Bookmarks Shelf ──
          _buildRecentBookmarks(ref),

          // Search Bar
          ZenSearchBar(
            controller: _searchController,
            hintText: AppLocalizations.of(context)!.searchStoriesHint,
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),

          // Level Selector
          Builder(builder: (context) {
            final isDark = Theme.of(context).brightness == Brightness.dark;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SingleChildScrollView(
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
                          if (selected) {
                            setState(() => _selectedHskLevel = level);
                          }
                        },
                        selectedColor: Colors.indigo,
                        labelStyle: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : (isDark ? Colors.white70 : Colors.black87),
                        ),
                        backgroundColor:
                            isDark ? const Color(0xFF2A2A2B) : Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    );
                  }),
                ),
              ),
            );
          }),

          // Stories List
          Expanded(
            child: groupedBlueprints.isEmpty
                ? Builder(builder: (context) {
                    final isDark =
                        Theme.of(context).brightness == Brightness.dark;
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Text(
                          AppLocalizations.of(context)!.noStoriesFoundMatching,
                          style: TextStyle(
                            color: isDark ? Colors.white38 : Colors.black54,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  })
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 8, bottom: 24),
                    itemCount: groupedBlueprints.keys.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: InkWell(
                            onTap: () => _showCreatorSheet(context, ref),
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF3F51B5),
                                    Color(0xFF5C6BC0)
                                  ],
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
                                      color:
                                          Colors.white.withValues(alpha: 0.2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.auto_awesome,
                                        color: Colors.white, size: 28),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .creatorMode,
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

                      final category =
                          groupedBlueprints.keys.elementAt(index - 1);
                      final stories = groupedBlueprints[category]!;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 12.0),
                            child: Text(
                              _localizeCategory(context, category),
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo),
                            ),
                          ),
                          SizedBox(
                            height: 240,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
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

  // ─── Continue Reading Hero ─────────────────────
  Widget _buildContinueReadingSection(WidgetRef ref) {
    final sessionAsync = ref.watch(lastSessionProvider);
    final session = sessionAsync;

    if (session == null) return const SizedBox.shrink();

    final inProgressAsync = ref.watch(inProgressBooksProvider);
    return inProgressAsync.when(
      data: (items) {
        final item =
            items.where((it) => it.book.id == session.bookId).firstOrNull;
        if (item == null) return const SizedBox.shrink();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ContinueReadingCard(
            item: item,
            session: session,
            onTap: () async {
              final chapters = await ref
                  .read(bookRepositoryProvider)
                  .getBookChapters(item.book.id);
              if (!context.mounted) return;
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => BookReaderScreen(
                    book: item.book,
                    chapters: chapters,
                    initialChapterIndex: item.progress.chapterIndex,
                    initialSentenceIndex: item.progress.sentenceIndex,
                  ),
                  transitionsBuilder: (_, animation, __, child) =>
                      FadeTransition(opacity: animation, child: child),
                ),
              );
            },
          ),
        );
      },
      error: (_, __) => const SizedBox.shrink(),
      loading: () => const SizedBox.shrink(),
    );
  }

  // ─── Recent Bookmarks Shelf ─────────────────────
  Widget _buildRecentBookmarks(WidgetRef ref) {
    final allAsync = ref.watch(allBookmarksProvider);
    return allAsync.when(
      data: (items) {
        if (items.isEmpty) return const SizedBox.shrink();
        final recent = items.take(5).toList();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  // TODO: localize
                  Text(AppLocalizations.of(context)!.recentBookmarks,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600)),
                  const Spacer(),
                  if (items.length > 5)
                    TextButton(
                      onPressed: () {
                        // TODO: full bookmarks page
                      },
                      child: Text(AppLocalizations.of(context)!.seeAll,
                          style: const TextStyle(fontSize: 12)),
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 72,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: recent.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (_, i) {
                  final entry = recent[i];
                  return GestureDetector(
                    onTap: () async {
                      final chapters = await ref
                          .read(bookRepositoryProvider)
                          .getBookChapters(entry.book.id);
                      if (!context.mounted) return;
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => BookReaderScreen(
                            book: entry.book,
                            chapters: chapters,
                            initialChapterIndex: entry.bookmark.chapterIndex,
                            initialSentenceIndex: entry.bookmark.sentenceIndex,
                          ),
                          transitionsBuilder: (_, animation, __, child) =>
                              FadeTransition(opacity: animation, child: child),
                        ),
                      );
                    },
                    child: Container(
                      width: 140,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest
                            .withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            entry.book.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Ch ${entry.bookmark.chapterIndex} · Sent ${entry.bookmark.sentenceIndex}',
                            style: TextStyle(
                                fontSize: 11,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withValues(alpha: 0.5)),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
      error: (_, __) => const SizedBox.shrink(),
      loading: () => const SizedBox.shrink(),
    );
  }

  Widget _buildStoryCard(BuildContext context, StoryBlueprint blueprint) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 16, bottom: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isDark ? const Color(0xFF2A2A2B) : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ]),
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
                        colors: [
                          Colors.indigo.shade300,
                          Colors.deepPurple.shade400
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        blueprint.category ==
                                AppLocalizations.of(context)!.mythsAndLegends
                            ? Icons.auto_awesome
                            : blueprint.category ==
                                    AppLocalizations.of(context)!
                                        .historyAndCulture
                                ? Icons.account_balance
                                : blueprint.category ==
                                        AppLocalizations.of(context)!
                                            .idiomsTitle
                                    ? Icons.menu_book
                                    : Icons.landscape,
                        color: Colors.white.withValues(alpha: 0.8),
                        size: 40,
                      ),
                    ),
                  ),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color:
                          isDark ? const Color(0xFF1A1A1B) : Colors.grey[100],
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
                      Text(_localizeTitle(context, blueprint.title),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color:
                                isDark ? Colors.white : const Color(0xFF1A1A1B),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 4),
                      Text(_localizeTopic(context, blueprint.topic),
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withValues(alpha: 0.5)
                                : Colors.black.withValues(alpha: 0.6),
                            fontSize: 12,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                      const Spacer(),
                      // Tags
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: blueprint.tags
                              .take(3)
                              .map((tag) => Container(
                                    margin: const EdgeInsets.only(right: 6),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                        color: Colors.indigo.withValues(
                                            alpha: isDark ? 0.2 : 0.08),
                                        borderRadius: BorderRadius.circular(6)),
                                    child: Text('#$tag',
                                        style: const TextStyle(
                                            fontSize: 10,
                                            color: Colors.indigo,
                                            fontWeight: FontWeight.bold)),
                                  ))
                              .toList(),
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
