import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_mode.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/deck_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/features/echo_hall/presentation/screens/scenario_selection_screen.dart';
import 'package:hanzi_master/shared/routes/swipe_back_route.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/deck_review_session_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/daily_study_dashboard_screen.dart';
import 'package:hanzi_master/shared/widgets/quick_look_sheet.dart';
import 'package:hanzi_master/shared/widgets/bouncing_button.dart';
import 'package:hanzi_master/core/services/analytics_service.dart';
import 'package:hanzi_master/shared/widgets/staggered_list_item.dart';

import 'package:hanzi_master/features/flashcards/presentation/widgets/deck_settings_sheet.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/story_mode_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/study_mode_selection_sheet.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/deck_card_picker_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/stats_screen.dart';
import 'package:hanzi_master/core/presentation/widgets/zen_search_bar.dart';
import 'package:hanzi_master/core/widgets/translated_definition.dart';

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  final Color backgroundColor;

  _SliverTabBarDelegate(this.tabBar, this.backgroundColor);

  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: backgroundColor,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return false;
  }
}

class _DailyGoal extends StatelessWidget {
  const _DailyGoal({
    required this.label,
    required this.available,
    required this.limit,
    required this.color,
  });

  final String label;
  final int available;
  final int limit;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final goal = limit < 0 ? 'Unlimited' : limit.toString();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$available / $goal',
          style: TextStyle(fontWeight: FontWeight.bold, color: color),
        ),
        const SizedBox(height: 2),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}

class DeckDetailScreen extends ConsumerStatefulWidget {
  final Deck deck;

  const DeckDetailScreen({super.key, required this.deck});

  @override
  ConsumerState<DeckDetailScreen> createState() => _DeckDetailScreenState();
}

class _DeckDetailScreenState extends ConsumerState<DeckDetailScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  late Deck _currentDeck = widget.deck;
  late int _dailyNewCardsLimit = widget.deck.dailyNewCardsLimit;
  late int _dailyReviewLimit = widget.deck.dailyReviewLimit;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncFlashcards = ref.watch(flashcardControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor:
            isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
        floatingActionButton: widget.deck.id != 'default'
            ? FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                    context,
                    SwipeBackPageRoute(
                      builder: (context) => DeckCardPickerScreen(
                          deckId: widget.deck.id,
                          deckName: widget.deck.localizedName(context)),
                    ),
                  );
                },
                icon: const Icon(Icons.add),
                label: Text(AppLocalizations.of(context)!.addCards),
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              )
            : null,
        body: asyncFlashcards.when(
          data: (allCards) {
            final deckCards = allCards
                .where((c) =>
                    c.deckId == widget.deck.id ||
                    (widget.deck.id == 'default' && c.deckId.isEmpty))
                .toList();
            final now = DateTime.now();
            final endOfToday = DateTime(now.year, now.month, now.day + 1);
            final dueToday = deckCards.where((card) {
              final stats = card.getStatsForMode(StudyMode.reading);
              return !stats.isNew && stats.nextReviewDate.isBefore(endOfToday);
            }).length;
            final newAvailable = deckCards
                .where((card) => card.getStatsForMode(StudyMode.reading).isNew)
                .length;

            final filteredCards = deckCards.where((c) {
              if (_searchQuery.isEmpty) return true;
              return c.hanzi.contains(_searchQuery) ||
                  c.pinyin.toLowerCase().contains(_searchQuery) ||
                  c.definition.toLowerCase().contains(_searchQuery);
            }).toList();

            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  // Premium Header
                  SliverAppBar(
                    expandedHeight: 140.0,
                    floating: false,
                    pinned: true,
                    backgroundColor: isDark
                        ? const Color(0xFF1A1A1B)
                        : const Color(0xFFFDFCF0),
                    elevation: 0,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      titlePadding:
                          const EdgeInsets.only(bottom: 8, left: 60, right: 60),
                      title: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.deck.localizedName(context),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: isDark
                                  ? Colors.white
                                  : const Color(0xFF2C2C2C),
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: (isDark ? Colors.white : Colors.black)
                                  .withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.cardsCount(deckCards.length),
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark ? Colors.white70 : Colors.black54,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      background: Opacity(
                        opacity: isDark ? 0.3 : 0.1,
                        child: const CalligraphyBackground(
                            child: SizedBox.expand()),
                      ),
                    ),
                    actions: [
                      IconButton(
                        icon: Icon(Icons.settings_outlined,
                            color: isDark ? Colors.white70 : Colors.black87),
                        onPressed: () async {
                          final updatedDeck = await showModalBottomSheet<Deck>(
                            context: context,
                            isScrollControlled: true,
                            useRootNavigator: true,
                            backgroundColor: Colors.transparent,
                            builder: (ctx) =>
                                DeckSettingsSheet(deck: _currentDeck),
                          );
                          if (updatedDeck != null && mounted) {
                            setState(() {
                              _currentDeck = updatedDeck;
                              _dailyNewCardsLimit =
                                  updatedDeck.dailyNewCardsLimit;
                              _dailyReviewLimit = updatedDeck.dailyReviewLimit;
                            });
                          }
                        },
                      ),
                      if (widget.deck.id != 'default')
                        IconButton(
                          icon: const Icon(Icons.delete_outline,
                              color: Colors.redAccent),
                          onPressed: () async {
                            final bool? confirm = await showDialog<bool>(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                backgroundColor: isDark
                                    ? const Color(0xFF2A2A2C)
                                    : const Color(0xFFFDFCF0),
                                title: Text(
                                    AppLocalizations.of(context)!
                                        .eraseDeckQuestion,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black)),
                                content: Text(
                                    AppLocalizations.of(context)!
                                        .are_you_sure_you_want_to(
                                            widget.deck.name),
                                    style: TextStyle(
                                        color: isDark
                                            ? Colors.white70
                                            : Colors.black87)),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(ctx, false),
                                    child: Text(
                                        AppLocalizations.of(context)!
                                            .cancelAction,
                                        style: TextStyle(
                                            color: isDark
                                                ? Colors.white60
                                                : Colors.grey)),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.pop(ctx, true),
                                    child: Text(
                                        AppLocalizations.of(context)!.erase,
                                        style: const TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                            );

                            if (confirm == true) {
                              await ref
                                  .read(deckControllerProvider.notifier)
                                  .deleteDeck(widget.deck.id);
                              if (context.mounted) {
                                Navigator.pop(context);
                              }
                            }
                          },
                        ),
                    ],
                  ),

                  // Action Row (Compact & Premium)
                  if (deckCards.isNotEmpty)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 10),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? Colors.white.withValues(alpha: 0.06)
                                    : Colors.indigo.withValues(alpha: 0.06),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: _DailyGoal(
                                      label: AppLocalizations.of(context)!.dueToday,
                                      available: dueToday,
                                      limit: _dailyReviewLimit,
                                      color: Colors.indigo,
                                    ),
                                  ),
                                  Container(
                                    width: 1,
                                    height: 32,
                                    color: Colors.grey.withValues(alpha: 0.25),
                                  ),
                                  Expanded(
                                    child: _DailyGoal(
                                      label: AppLocalizations.of(context)!.newAvailable,
                                      available: newAvailable,
                                      limit: _dailyNewCardsLimit,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                onPressed: () => Navigator.push(
                                  context,
                                  SwipeBackPageRoute(
                                    builder: (_) => DailyStudyDashboardScreen(
                                      deck: widget.deck.copyWith(
                                        dailyNewCardsLimit: _dailyNewCardsLimit,
                                        dailyReviewLimit: _dailyReviewLimit,
                                      ),
                                    ),
                                  ),
                                ),
                                icon: const Icon(Icons.today_outlined),
                                label: Text(AppLocalizations.of(context)!
                                    .todayDashboard),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    height: 56,
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF8E2DE2),
                                          Color(0xFF4A00E0)
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF4A00E0)
                                              .withValues(alpha: 0.3),
                                          blurRadius: 12,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        StudyModeSelectionSheet.show(
                                          context,
                                          onModeSelected: (mode) {
                                            ref
                                                .read(analyticsServiceProvider)
                                                .logStudySession(
                                                  action: 'started',
                                                  mode: mode.name,
                                                  deckId: widget.deck.id,
                                                  cardCount: deckCards.length,
                                                );
                                            Navigator.push(
                                                context,
                                                SwipeBackPageRoute(
                                                  builder: (context) =>
                                                      DeckReviewSessionScreen(
                                                          deckId:
                                                              widget.deck.id,
                                                          mode: mode),
                                                ));
                                          },
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.play_arrow_rounded,
                                              size: 24, color: Colors.white),
                                          const SizedBox(width: 8),
                                          Text(
                                              AppLocalizations.of(context)!
                                                  .review,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  flex: 2,
                                  child: SizedBox(
                                    height: 56,
                                    child: OutlinedButton(
                                      onPressed: () {
                                        if (deckCards.isEmpty) return;
                                        ref
                                            .read(analyticsServiceProvider)
                                            .logStoryAction(
                                              action: 'started',
                                              storyId: 'custom_deck_story',
                                              storyLevel: widget.deck.id,
                                            );
                                        Navigator.push(
                                            context,
                                            SwipeBackPageRoute(
                                              builder: (context) =>
                                                  StoryModeScreen(
                                                      deck: widget.deck,
                                                      cards: deckCards),
                                            ));
                                      },
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: isDark
                                            ? Colors.purple[300]
                                            : Colors.purple[700],
                                        backgroundColor: isDark
                                            ? Colors.white
                                                .withValues(alpha: 0.05)
                                            : Colors.purple
                                                .withValues(alpha: 0.05),
                                        side: BorderSide(
                                            color: isDark
                                                ? Colors.purple[300]!
                                                    .withValues(alpha: 0.5)
                                                : Colors.purple[200]!,
                                            width: 1.5),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.auto_awesome,
                                              size: 18),
                                          const SizedBox(width: 6),
                                          Text(
                                              AppLocalizations.of(context)!
                                                  .story,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 56,
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      SwipeBackPageRoute(
                                        builder: (context) =>
                                            ScenarioSelectionScreen(
                                                deck: widget.deck),
                                      ));
                                },
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: isDark
                                      ? Colors.tealAccent[400]
                                      : Colors.teal[700],
                                  backgroundColor: isDark
                                      ? Colors.tealAccent[400]!
                                          .withValues(alpha: 0.05)
                                      : Colors.teal[700]!
                                          .withValues(alpha: 0.05),
                                  side: BorderSide(
                                      color: isDark
                                          ? Colors.tealAccent[400]!
                                              .withValues(alpha: 0.5)
                                          : Colors.teal[700]!
                                              .withValues(alpha: 0.5),
                                      width: 1.5),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.record_voice_over,
                                        size: 18),
                                    const SizedBox(width: 6),
                                    Text(
                                        AppLocalizations.of(context)!
                                            .practiceInRoleplay,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  // Tab Bar
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _SliverTabBarDelegate(
                      TabBar(
                        labelColor:
                            isDark ? Colors.purple[300] : Colors.purple[700],
                        unselectedLabelColor: Colors.grey,
                        indicatorColor:
                            isDark ? Colors.purple[300] : Colors.purple[700],
                        indicatorWeight: 3,
                        tabs: [
                          Tab(text: AppLocalizations.of(context)!.cardsTitle),
                          Tab(text: AppLocalizations.of(context)!.statistics),
                        ],
                      ),
                      isDark
                          ? const Color(0xFF1A1A1B)
                          : const Color(0xFFFDFCF0),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                children: [
                  // Tab 1: Cards
                  Column(
                    children: [
                      if (deckCards.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                          child: ZenSearchBar(
                            controller: _searchController,
                            hintText:
                                AppLocalizations.of(context)!.searchDeckHint,
                            onChanged: (val) => setState(
                                () => _searchQuery = val.toLowerCase()),
                          ),
                        ),
                      Expanded(
                        child: deckCards.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.inbox_outlined,
                                        size: 80,
                                        color:
                                            Colors.grey.withValues(alpha: 0.3)),
                                    const SizedBox(height: 16),
                                    Text(
                                      AppLocalizations.of(context)!
                                          .thisDeckIsEmpty,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: isDark
                                            ? Colors.white54
                                            : Colors.black54,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      AppLocalizations.of(context)!
                                          .tapTheAddCards,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.purple
                                            .withValues(alpha: 0.8),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : filteredCards.isEmpty
                                ? Center(
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .noCardsFound,
                                      style: TextStyle(
                                          color: isDark
                                              ? Colors.white54
                                              : Colors.black54),
                                    ),
                                  )
                                : ListView.builder(
                                    padding: const EdgeInsets.only(
                                        top: 16,
                                        left: 16,
                                        right: 16,
                                        bottom: 80),
                                    itemCount: filteredCards.length,
                                    itemBuilder: (context, index) {
                                      final card = filteredCards[index];
                                      return StaggeredListItem(
                                        index: index,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 12.0),
                                          child: widget.deck.id == 'default'
                                              ? _buildCardContent(
                                                  context, card, isDark)
                                              : Dismissible(
                                                  key:
                                                      Key('dismiss_${card.id}'),
                                                  direction: DismissDirection
                                                      .endToStart,
                                                  background: Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 24),
                                                    decoration: BoxDecoration(
                                                      color: Colors.redAccent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                    ),
                                                    child: const Icon(
                                                        Icons.delete_sweep,
                                                        color: Colors.white,
                                                        size: 32),
                                                  ),
                                                  confirmDismiss:
                                                      (direction) async {
                                                    return await showDialog<
                                                        bool>(
                                                      context: context,
                                                      builder: (context) {
                                                        final dialogIsDark =
                                                            Theme.of(context)
                                                                    .brightness ==
                                                                Brightness.dark;
                                                        return AlertDialog(
                                                          backgroundColor:
                                                              dialogIsDark
                                                                  ? const Color(
                                                                      0xFF2A2A2C)
                                                                  : const Color(
                                                                      0xFFFDFCF0),
                                                          title: Text(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .removeCard,
                                                              style: TextStyle(
                                                                  color: dialogIsDark
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black)),
                                                          content: Text(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .remove_from_this_deck(
                                                                      card
                                                                          .hanzi),
                                                              style: TextStyle(
                                                                  color: dialogIsDark
                                                                      ? Colors
                                                                          .white70
                                                                      : Colors
                                                                          .black87)),
                                                          actions: [
                                                            TextButton(
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        context,
                                                                        false),
                                                                child: Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .cancel,
                                                                    style: TextStyle(
                                                                        color: dialogIsDark
                                                                            ? Colors.white60
                                                                            : Colors.grey))),
                                                            TextButton(
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        context,
                                                                        true),
                                                                child: Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .remove,
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .red))),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                  onDismissed: (direction) {
                                                    final updatedCard =
                                                        card.copyWith(
                                                            deckId: 'default');
                                                    ref
                                                        .read(
                                                            flashcardControllerProvider
                                                                .notifier)
                                                        .updateFlashcard(
                                                            updatedCard);
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                            '${card.hanzi} ${AppLocalizations.of(context)?.removedFromDeck ?? "removed from deck"}'),
                                                        backgroundColor:
                                                            Colors.redAccent,
                                                        duration:
                                                            const Duration(
                                                                seconds: 2),
                                                        action: SnackBarAction(
                                                          label: AppLocalizations
                                                                  .of(context)!
                                                              .undo,
                                                          textColor:
                                                              Colors.white,
                                                          onPressed: () {
                                                            ref
                                                                .read(flashcardControllerProvider
                                                                    .notifier)
                                                                .updateFlashcard(
                                                                    card);
                                                          },
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: _buildCardContent(
                                                      context, card, isDark),
                                                ),
                                        ),
                                      );
                                    },
                                  ),
                      ),
                    ],
                  ),

                  // Tab 2: Statistics (unified polished view)
                  StatsScreen(deckId: widget.deck.id),
                ],
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text("Error: $err")),
        ),
      ),
    );
  }

  Widget _buildCardContent(BuildContext context, dynamic card, bool isDark) {
    return BouncingButton(
      onPressed: () {
        HapticsManager.light();
        showQuickLook(context, card.hanzi);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2A2A2C) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isDark
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
          border: Border.all(
              color: isDark ? Colors.white12 : Colors.transparent, width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.05)
                    : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.center,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  card.hanzi,
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.9)
                        : const Color(0xFF2C2C2C),
                    height: 1.1,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    card.pinyin,
                    style: TextStyle(
                      fontSize: 15,
                      color: isDark ? Colors.white60 : Colors.black54,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 6),
                  TranslatedDefinition(
                    definition: card.definition,
                    hanzi: card.hanzi,
                    definitionLanguage: card.definitionLanguage,
                    originalStyle: TextStyle(
                      fontSize: 16,
                      color: isDark ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  _buildStatusBadge(context, card, isDark),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context, Flashcard card, bool isDark) {
    final stats = card.getStatsForMode(StudyMode.reading);
    String statusText;
    Color color;
    IconData icon;

    if (stats.isNew) {
      return const SizedBox.shrink();
    } else if (card.isDue(StudyMode.reading)) {
      statusText = AppLocalizations.of(context)!.to_be_reviewed;
      color = Colors.orange;
      icon = Icons.access_time;
    } else if (stats.isMastered) {
      statusText = AppLocalizations.of(context)!.masteredStatus;
      color = Colors.green;
      icon = Icons.workspace_premium;
    } else {
      final days = stats.nextReviewDate.difference(DateTime.now()).inDays;
      statusText = days <= 1
          ? AppLocalizations.of(context)!.review_tomorrow
          : "Review in $days days";
      color = Colors.indigo;
      icon = Icons.calendar_today;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            statusText,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
