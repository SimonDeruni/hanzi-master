import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_mode.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/deck_detail_screen.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/dictionary_provider.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/deck_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/dictionary_screen.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

import 'package:hanzi_master/features/progression/presentation/widgets/today_insight_card.dart';
import 'package:hanzi_master/features/progression/presentation/widgets/daily_goal_review_ring.dart';
import 'package:hanzi_master/features/progression/presentation/widgets/streak_flame_badge.dart';
import 'package:hanzi_master/features/progression/data/study_progress_service.dart';
import 'package:hanzi_master/features/progression/domain/study_progress.dart';
import 'package:hanzi_master/shared/widgets/global_sliver_app_bar.dart';
import 'package:hanzi_master/shared/routes/swipe_back_route.dart';
import 'package:hanzi_master/features/premium/presentation/screens/universal_scanner_screen.dart';
import 'package:hanzi_master/features/live_translate/presentation/screens/travel_interpreter_screen.dart';
import 'package:hanzi_master/core/services/haptics_manager.dart';
import 'package:hanzi_master/shared/widgets/bouncing_button.dart';
import 'package:hanzi_master/shared/widgets/zen_loader.dart';
import 'package:hanzi_master/core/services/app_rating_service.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';
import 'package:hanzi_master/shared/widgets/zen_overlay.dart';

class DashboardScreen extends ConsumerWidget {
  final Function(int) onNavigate;

  const DashboardScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    // Check streak milestones (e.g. 3-day or 7-day streak) for gentle rating evaluation
    ref.listen<AsyncValue<StudyProgress>>(studyProgressProvider, (prev, next) {
      final streak = next.valueOrNull?.currentStreak ?? 0;
      if (streak >= 3) {
        final milestone = streak >= 7 ? 'streak_7' : 'streak_3';
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) {
            ref.read(appRatingServiceProvider).triggerSentimentPromptIfEligible(
                  context,
                  trigger: milestone,
                );
          }
        });
      }
    });

    // 1. Fetch Flashcard Data
    final rawCards = ref.watch(flashcardControllerProvider).valueOrNull ?? [];
    final allDecks = ref.watch(deckControllerProvider).valueOrNull ?? [];

    // Filter out cards that belong to deleted decks to prevent ghost reviews and raw UUID displays
    final validDeckIds = allDecks.map((d) => d.id).toSet();
    final allCards = rawCards.where((c) {
      final deckId = c.deckId;
      return deckId.isEmpty ||
          deckId == 'default' ||
          validDeckIds.contains(deckId);
    }).toList();

    // 2. Calculate Stats
    final dueCards = allCards.where((c) {
      return StudyMode.values.any((m) => c.isDue(m));
    }).toList();

    final Map<String, List<Flashcard>> dueCardsByDeck = {};
    for (var card in dueCards) {
      dueCardsByDeck.putIfAbsent(card.deckId, () => []).add(card);
    }

    // 4. Calculate Upcoming Forecast
    int dueLaterToday = 0;
    int dueTomorrow = 0;
    int dueNext7Days = 0;
    final laterTodayByDeck = <String, int>{};
    final tomorrowByDeck = <String, int>{};
    final next7DaysByDeck = <String, int>{};

    final now = DateTime.now();
    final endOfToday = DateTime(now.year, now.month, now.day, 23, 59, 59);
    final endOfTomorrow = endOfToday.add(const Duration(days: 1));
    final endOfNext7Days = endOfToday.add(const Duration(days: 7));

    for (var card in allCards) {
      final deckName = _deckDisplayName(card.deckId, allDecks, l10n);
      for (var mode in StudyMode.values) {
        final stats = card.getStatsForMode(mode);
        final reviewDate = stats.nextReviewDate;

        if (stats.interval > 0 &&
            reviewDate.isAfter(now) &&
            reviewDate.isBefore(endOfNext7Days)) {
          dueNext7Days++;
          next7DaysByDeck[deckName] = (next7DaysByDeck[deckName] ?? 0) + 1;
          if (reviewDate.isBefore(endOfToday)) {
            dueLaterToday++;
            laterTodayByDeck[deckName] = (laterTodayByDeck[deckName] ?? 0) + 1;
          } else if (reviewDate.isBefore(endOfTomorrow)) {
            dueTomorrow++;
            tomorrowByDeck[deckName] = (tomorrowByDeck[deckName] ?? 0) + 1;
          }
        }
      }
    }

    return Scaffold(
      body: CalligraphyBackground(
        child: CustomScrollView(
          slivers: [
            // --- STANDARD HEADER ---
            GlobalSliverAppBar(
              title: l10n?.dashboardTitle ?? "Dashboard",
            ),

            // --- TODAY'S WORD (CROPPED & COMPACT) ---
            const SliverToBoxAdapter(
              child: Padding(
                key: Key('dashboard_word_of_the_day'),
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: TodayInsightCard(),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 18)),

            // --- PRIMARY ACTIONS: SCANNER & INTERPRETER ---
            SliverToBoxAdapter(
              child: Padding(
                key: const Key('dashboard_quick_actions'),
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: [
                    // Universal Scanner
                    Expanded(
                      child: _buildActionRectangle(
                        context: context,
                        icon: Icons.document_scanner_rounded,
                        title:
                            AppLocalizations.of(context)?.scanner ?? "Scanner",
                        accentColor: const Color(0xFFFF7A00), // Vibrant Amber
                        onTap: () {
                          Navigator.push(
                            context,
                            SwipeBackPageRoute(
                              builder: (_) => const UniversalScannerScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 14),
                    // Travel Interpreter
                    Expanded(
                      child: _buildActionRectangle(
                        context: context,
                        icon: Icons.translate_rounded,
                        title: AppLocalizations.of(context)?.interpreter ??
                            "Interpreter",
                        accentColor: const Color(0xFF3F51B5), // Deep Indigo
                        onTap: () {
                          Navigator.push(
                            context,
                            SwipeBackPageRoute(
                              builder: (_) => const TravelInterpreterScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )
                    .animate(delay: 150.ms)
                    .fade(
                        duration: ZenMotion.of(context, ZenMotion.page),
                        curve: ZenMotion.enter)
                    .slideY(
                        begin: 0.05,
                        end: 0,
                        duration: ZenMotion.page,
                        curve: ZenMotion.enter),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 22)),

            SliverToBoxAdapter(
              child: Padding(
                key: const Key('dashboard_practice_progress'),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ref.watch(studyProgressProvider).when(
                      loading: () => const SizedBox(
                        height: 120,
                        child: Center(child: ZenLoader()),
                      ),
                      error: (_, __) => const SizedBox.shrink(),
                      data: (progress) => ZenFadeIn(
                          child: HabitProgressCards(progress: progress)),
                    ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 22)),

            // --- QUICK SEARCH BAR ---
            SliverToBoxAdapter(
              child: Padding(
                key: const Key('dashboard_search'),
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Hero(
                  tag: 'dashboard_search_bar',
                  child: Material(
                    color: Colors.transparent,
                    child: GestureDetector(
                      onTap: () {
                        ref.read(searchFocusRequestProvider.notifier).state =
                            true;
                        Navigator.of(context).push(
                          SwipeBackPageRoute(
                            builder: (_) => const DictionaryScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? const Color(0xFF1A1A1B).withValues(alpha: 0.8)
                              : Colors.white.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white.withValues(alpha: 0.1)
                                    : Colors.black.withValues(alpha: 0.04),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(
                                  alpha: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? 0.3
                                      : 0.04),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.search,
                                color: theme.colorScheme.onSurface
                                    .withValues(alpha: 0.4),
                                size: 22),
                            const SizedBox(width: 14),
                            Text(
                              l10n?.searchHanziOrPinyin ??
                                  "Search Hanzi or Pinyin...",
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: theme.colorScheme.onSurface
                                    .withValues(alpha: 0.5),
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                            const Spacer(),
                            Icon(Icons.arrow_forward_ios,
                                size: 14,
                                color: theme.colorScheme.onSurface
                                    .withValues(alpha: 0.3)),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                    .animate(delay: 150.ms)
                    .fade(
                        duration: ZenMotion.of(context, ZenMotion.page),
                        curve: ZenMotion.enter)
                    .slideY(
                        begin: 0.05,
                        end: 0,
                        duration: ZenMotion.page,
                        curve: ZenMotion.enter),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            // --- UPCOMING FORECAST (COMPACT) ---
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n?.upcomingForecast ?? "Upcoming Forecast",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                        fontFamily: 'NotoSerifSC',
                        letterSpacing: 0.3,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: _ForecastItem(
                                title: l10n?.laterToday ?? "Later Today",
                                count: dueLaterToday,
                                theme: theme,
                                onTap: () => _showForecastDetail(
                                    context,
                                    l10n?.laterToday ?? "Later Today",
                                    laterTodayByDeck,
                                    allDecks,
                                    l10n,
                                    theme))),
                        const SizedBox(width: 10),
                        Expanded(
                            child: _ForecastItem(
                                title: l10n?.tomorrow ?? "Tomorrow",
                                count: dueTomorrow,
                                theme: theme,
                                onTap: () => _showForecastDetail(
                                    context,
                                    l10n?.tomorrow ?? "Tomorrow",
                                    tomorrowByDeck,
                                    allDecks,
                                    l10n,
                                    theme))),
                        const SizedBox(width: 10),
                        Expanded(
                            child: _ForecastItem(
                                title: l10n?.next7Days ?? "Next 7 Days",
                                count: dueNext7Days,
                                theme: theme,
                                onTap: () => _showForecastDetail(
                                    context,
                                    l10n?.next7Days ?? "Next 7 Days",
                                    next7DaysByDeck,
                                    allDecks,
                                    l10n,
                                    theme))),
                      ],
                    ),
                  ],
                ),
              )
                  .animate(delay: 300.ms)
                  .fade(
                      duration: ZenMotion.of(context, ZenMotion.page),
                      curve: ZenMotion.enter)
                  .slideY(
                      begin: 0.05,
                      end: 0,
                      duration: ZenMotion.page,
                      curve: ZenMotion.enter),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            // --- BOTTOM: DAILY REVIEW ---
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n?.dailyReview ?? "Daily Review",
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                        fontFamily: 'NotoSerifSC',
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (dueCards.isEmpty)
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.03),
                              blurRadius: 30,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    l10n?.yourMindIsClear ??
                                        "Your mind is clear.",
                                    style:
                                        theme.textTheme.titleMedium?.copyWith(
                                      color: theme.colorScheme.onSurface,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    l10n?.noReviewsDueToday ??
                                        "No reviews due today.",
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: theme.colorScheme.onSurface
                                          .withValues(alpha: 0.6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            ElevatedButton(
                              onPressed: null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.colorScheme.primary
                                    .withValues(alpha: 0.1),
                                foregroundColor: theme.colorScheme.onSurface
                                    .withValues(alpha: 0.3),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                              ),
                              child: Text(
                                  l10n?.done ??
                                      AppLocalizations.of(context)!.done,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      )
                    else
                      ...dueCardsByDeck.entries.map((entry) {
                        final deckId = entry.key;
                        final cards = entry.value;
                        String displayDeckName = deckId;

                        final foundDeck =
                            allDecks.where((d) => d.id == deckId).firstOrNull;
                        if (foundDeck != null) {
                          displayDeckName = foundDeck.name;
                        }

                        if (deckId.toLowerCase() == 'hsk1') {
                          displayDeckName = l10n?.hskLevel1 ?? "HSK Level 1";
                        }
                        if (deckId.toLowerCase() == 'hsk2') {
                          displayDeckName = l10n?.hskLevel2 ?? "HSK Level 2";
                        }
                        if (deckId.toLowerCase() == 'hsk3') {
                          displayDeckName = l10n?.hskLevel3 ?? "HSK Level 3";
                        }
                        if (deckId.toLowerCase() == 'hsk4') {
                          displayDeckName = l10n?.hskLevel4 ?? "HSK Level 4";
                        }
                        if (deckId.toLowerCase() == 'hsk5') {
                          displayDeckName = l10n?.hskLevel5 ?? "HSK Level 5";
                        }
                        if (deckId.toLowerCase() == 'hsk6') {
                          displayDeckName = l10n?.hskLevel6 ?? "HSK Level 6";
                        }
                        if (deckId.toLowerCase() == 'default') {
                          displayDeckName =
                              l10n?.generalVocabulary ?? "General Vocabulary";
                        }

                        int readingDue = cards
                            .where((c) => c.isDue(StudyMode.reading))
                            .length;
                        int listeningDue = cards
                            .where((c) => c.isDue(StudyMode.listening))
                            .length;
                        int recallDue = cards
                            .where((c) => c.isDue(StudyMode.recall))
                            .length;
                        int speakingDue = cards
                            .where((c) => c.isDue(StudyMode.speaking))
                            .length;
                        int calligraphyDue = cards
                            .where((c) => c.isDue(StudyMode.calligraphy))
                            .length;
                        int totalDue = cards.length;

                        // Always use white foreground on the dark indigo gradient for high contrast
                        const onCardColor = Colors.white;
                        const cardGradientDark = Color(0xFF1A237E);

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFF3F51B5),
                                  Color(0xFF1A237E)
                                ], // Indigo gradient
                              ),
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF1A237E)
                                      .withValues(alpha: 0.4),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        displayDeckName,
                                        style: theme.textTheme.titleMedium
                                            ?.copyWith(
                                          color: onCardColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Wrap(
                                        spacing: 12,
                                        runSpacing: 8,
                                        children: [
                                          if (calligraphyDue > 0)
                                            _buildMiniStat(Icons.brush,
                                                calligraphyDue, onCardColor),
                                          if (readingDue > 0)
                                            _buildMiniStat(Icons.visibility,
                                                readingDue, onCardColor),
                                          if (listeningDue > 0)
                                            _buildMiniStat(Icons.headset,
                                                listeningDue, onCardColor),
                                          if (recallDue > 0)
                                            _buildMiniStat(Icons.memory,
                                                recallDue, onCardColor),
                                          if (speakingDue > 0)
                                            _buildMiniStat(Icons.mic,
                                                speakingDue, onCardColor),
                                          if (readingDue == 0 &&
                                              listeningDue == 0 &&
                                              recallDue == 0 &&
                                              speakingDue == 0 &&
                                              calligraphyDue == 0)
                                            Text(
                                              "$totalDue ${l10n?.cardsRequireAttention ?? 'cards require attention.'}",
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(
                                                color: onCardColor.withValues(
                                                    alpha: 0.8),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      SwipeBackPageRoute(
                                        builder: (context) => DeckDetailScreen(
                                          deck: Deck(
                                              id: deckId,
                                              name: displayDeckName,
                                              createdAt: DateTime.now()),
                                        ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: cardGradientDark,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 14),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    elevation: 4,
                                    shadowColor:
                                        Colors.black.withValues(alpha: 0.3),
                                  ),
                                  child: Text(
                                      l10n?.begin ??
                                          AppLocalizations.of(context)!.begin,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 16)),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 40)),
          ],
        ),
      ),
    );
  }

  Widget _buildActionRectangle({
    required BuildContext context,
    required IconData icon,
    required String title,
    required Color accentColor,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? const Color(0xFF1E1E22) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF1A1A1B);

    return BouncingButton(
      scaleFactor: 0.96,
      onPressed: () {
        HapticsManager.light();
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.08)
                : Colors.black.withValues(alpha: 0.04),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.04),
              blurRadius: 14,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: isDark ? 0.2 : 0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: accentColor, size: 24),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  letterSpacing: 0.2,
                  color: textColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniStat(IconData icon, int count, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color.withValues(alpha: 0.7)),
        const SizedBox(width: 4),
        Text(
          "$count",
          style: TextStyle(
            color: color.withValues(alpha: 0.9),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  String _deckDisplayName(
      String deckId, List<Deck> allDecks, AppLocalizations? l10n) {
    if (deckId.toLowerCase() == 'hsk1') return l10n?.hskLevel1 ?? 'HSK Level 1';
    if (deckId.toLowerCase() == 'hsk2') return l10n?.hskLevel2 ?? 'HSK Level 2';
    if (deckId.toLowerCase() == 'hsk3') return l10n?.hskLevel3 ?? 'HSK Level 3';
    if (deckId.toLowerCase() == 'hsk4') return l10n?.hskLevel4 ?? 'HSK Level 4';
    if (deckId.toLowerCase() == 'hsk5') return l10n?.hskLevel5 ?? 'HSK Level 5';
    if (deckId.toLowerCase() == 'hsk6') return l10n?.hskLevel6 ?? 'HSK Level 6';
    if (deckId.toLowerCase() == 'default') {
      return l10n?.generalVocabulary ?? 'General Vocabulary';
    }
    final foundDeck = allDecks.where((d) => d.id == deckId).firstOrNull;
    return foundDeck?.name ?? deckId;
  }

  void _showForecastDetail(
      BuildContext context,
      String title,
      Map<String, int> deckCounts,
      List<Deck> allDecks,
      AppLocalizations? l10n,
      ThemeData theme) {
    if (deckCounts.isEmpty) return;
    final sorted = deckCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    zenSheet(
      context,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      fontFamily: 'NotoSerifSC')),
              const SizedBox(height: 4),
              Text(
                  '${sorted.fold<int>(0, (sum, e) => sum + e.value)} cards total',
                  style: theme.textTheme.bodyMedium?.copyWith(
                      color:
                          theme.colorScheme.onSurface.withValues(alpha: 0.6))),
              const SizedBox(height: 20),
              ...sorted.map((entry) {
                final deckId = allDecks
                        .where((d) =>
                            _deckDisplayName(d.id, allDecks, l10n) == entry.key)
                        .firstOrNull
                        ?.id ??
                    entry.key;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      Navigator.pop(ctx);
                      Navigator.push(
                          context,
                          SwipeBackPageRoute(
                              builder: (_) => DeckDetailScreen(
                                  deck: Deck(
                                      id: deckId,
                                      name: entry.key,
                                      createdAt: DateTime.now()))));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 16),
                      decoration: BoxDecoration(
                          color:
                              theme.colorScheme.primary.withValues(alpha: 0.06),
                          borderRadius: BorderRadius.circular(16)),
                      child: Row(children: [
                        Expanded(
                            child: Text(entry.key,
                                style: theme.textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w600))),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                              color: theme.colorScheme.primary
                                  .withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(12)),
                          child: Text('${entry.value} cards',
                              style: TextStyle(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                      ]),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 8),
              SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      style: TextButton.styleFrom(
                          foregroundColor: theme.colorScheme.onSurface
                              .withValues(alpha: 0.5)),
                      child: Text(AppLocalizations.of(context)!.done,
                          style:
                              const TextStyle(fontWeight: FontWeight.bold)))),
            ],
          ),
        );
      },
    );
  }
}

class _ForecastItem extends StatelessWidget {
  final String title;
  final int count;
  final ThemeData theme;
  final VoidCallback? onTap;

  const _ForecastItem(
      {required this.title,
      required this.count,
      required this.theme,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fgColor = isDark ? Colors.white : const Color(0xFF2A2D34);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: isDark
              ? const Color(0xFF1A1A1B).withValues(alpha: 0.8)
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.08)
                : Colors.transparent,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.03),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              count.toString(),
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 22,
                color: fgColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                color: fgColor.withValues(alpha: 0.6),
                fontWeight: FontWeight.w600,
                fontSize: 11,
                letterSpacing: 0.1,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class HabitProgressCards extends StatelessWidget {
  const HabitProgressCards({super.key, required this.progress});

  final StudyProgress progress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final week = progress.thisWeek;
    final minutes = week.duration.inMinutes;
    final comparison = progress.cardsChangePercent;
    final comparisonText = comparison == null
        ? l10n.yourFirstWeekOfTracked
        : comparison == 0
            ? l10n.sameNumberOfCardsAs
            : l10n.cardsComparedWithLastWeek(
                '${comparison > 0 ? '+' : ''}$comparison%',
              );

    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.eco_outlined, color: theme.colorScheme.primary),
                    const SizedBox(width: 10),
                    Text(
                      l10n.todaySPractice,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Text(
                      '${progress.todayCards} / '
                      '${l10n.cardsCount(progress.dailyCardGoal)}',
                      style: theme.textTheme.labelLarge,
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    DailyGoalReviewRing(
                      progress: progress.dailyGoalProgress,
                      todayCards: progress.todayCards,
                      goalCards: progress.dailyCardGoal,
                      size: 72,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            progress.todayCards >= progress.dailyCardGoal
                                ? l10n.goalCompleteAnythingMoreIs
                                : l10n.aSmallAchievableTargetNo,
                            style: theme.textTheme.bodySmall
                                ?.copyWith(height: 1.35),
                          ),
                          const SizedBox(height: 10),
                          LinearProgressIndicator(
                            value: progress.dailyGoalProgress,
                            minHeight: 7,
                            borderRadius: BorderRadius.circular(8),
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
        const SizedBox(height: 10),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.calendar_view_week_outlined,
                        color: theme.colorScheme.primary),
                    const SizedBox(width: 10),
                    Text(
                      l10n.thisWeek,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    if (progress.currentStreak > 0)
                      StreakFlameBadge(
                        streak: progress.currentStreak,
                        label: l10n.dayStreakCount(progress.currentStreak),
                      ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    _WeeklyMetric(
                        l10n.uniqueCardsStudied, '${week.cardsStudied}'),
                    _WeeklyMetric(
                        l10n.accuracy, '${(week.accuracy * 100).round()}%'),
                    _WeeklyMetric(l10n.minutes, '$minutes'),
                    _WeeklyMetric(l10n.activeDays, '${week.activeDays}'),
                  ],
                ),
                const SizedBox(height: 12),
                Text(comparisonText, style: theme.textTheme.bodySmall),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _WeeklyMetric extends StatelessWidget {
  const _WeeklyMetric(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Expanded(
        child: Column(
          children: [
            Text(
              value,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      );
}
