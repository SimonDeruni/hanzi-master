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
import 'package:hanzi_master/l10n/app_localizations.dart';

import 'package:hanzi_master/features/progression/presentation/widgets/today_insight_card.dart';
import 'package:hanzi_master/shared/widgets/global_sliver_app_bar.dart';
class DashboardScreen extends ConsumerWidget {
  final Function(int) onNavigate;

  const DashboardScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    
    // 1. Fetch Flashcard Data
    final allCards = ref.watch(flashcardControllerProvider).valueOrNull ?? [];
    final allDecks = ref.watch(deckControllerProvider).valueOrNull ?? [];
    
    // 2. Calculate Stats
    final knownCards = allCards.where((c) => c.getStatsForMode(StudyMode.reading).streak > 0).length;
    final dueCards = allCards.where((c) {
      return StudyMode.values.any((m) => c.isDue(m));
    }).toList();
    
    final Map<String, List<Flashcard>> dueCardsByDeck = {};
    for (var card in dueCards) {
      dueCardsByDeck.putIfAbsent(card.deckId, () => []).add(card);
    }
    
    // 3. Determine Rank and Progress
    String rank = l10n?.hsk1Candidate ?? "HSK 1 Candidate";
    int nextMilestone = 150;
    
    if (knownCards >= 5000) { rank = l10n?.hsk6Master ?? "HSK 6 Master"; nextMilestone = knownCards; }
    else if (knownCards >= 2500) { rank = l10n?.hsk6Candidate ?? "HSK 6 Candidate"; nextMilestone = 5000; }
    else if (knownCards >= 1200) { rank = l10n?.hsk5Candidate ?? "HSK 5 Candidate"; nextMilestone = 2500; }
    else if (knownCards >= 600) { rank = l10n?.hsk4Candidate ?? "HSK 4 Candidate"; nextMilestone = 1200; }
    else if (knownCards >= 300) { rank = l10n?.hsk3Candidate ?? "HSK 3 Candidate"; nextMilestone = 600; }
    else if (knownCards >= 150) { rank = l10n?.hsk2Candidate ?? "HSK 2 Candidate"; nextMilestone = 300; }
    
    double progress = nextMilestone == knownCards ? 1.0 : knownCards / nextMilestone;

    // 4. Calculate Upcoming Forecast
    int dueLaterToday = 0;
    int dueTomorrow = 0;
    int dueNext7Days = 0;

    final now = DateTime.now();
    final endOfToday = DateTime(now.year, now.month, now.day, 23, 59, 59);
    final endOfTomorrow = endOfToday.add(const Duration(days: 1));
    final endOfNext7Days = endOfToday.add(const Duration(days: 7));

    for (var card in allCards) {
      for (var mode in StudyMode.values) {
        final stats = card.getStatsForMode(mode);
        final reviewDate = stats.nextReviewDate;
        
        // Only count cards that have been studied (interval > 0 or not at epoch)
        // and are scheduled in the future.
        if (stats.interval > 0 && reviewDate.isAfter(now) && reviewDate.isBefore(endOfNext7Days)) {
          dueNext7Days++;
          if (reviewDate.isBefore(endOfToday)) {
            dueLaterToday++;
          } else if (reviewDate.isBefore(endOfTomorrow)) {
            dueTomorrow++;
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

            
            // --- NEW: TODAY'S WORD ---
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: SizedBox(
                  height: 220,
                  child: TodayInsightCard(),
                ),
              ),
            ),
            
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
            
            // --- MIDDLE: QUICK SEARCH ---
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: GestureDetector(
                  onTap: () {
                    ref.read(searchFocusRequestProvider.notifier).state = true;
                    onNavigate(3);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: theme.colorScheme.onSurface.withOpacity(0.4), size: 24),
                        const SizedBox(width: 16),
                        Text(
                          l10n?.searchHanziOrPinyin ?? "Search Hanzi or Pinyin...",
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.5),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        Icon(Icons.arrow_forward_ios, size: 16, color: theme.colorScheme.onSurface.withOpacity(0.3)),
                      ],
                    ),
                  ),
                ).animate(delay: 150.ms)
                 .fade(duration: 600.ms, curve: Curves.easeOutCubic)
                 .slideY(begin: 0.05, end: 0, duration: 600.ms, curve: Curves.easeOutCubic),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 40)),
            
            // --- MIDDLE: UPCOMING FORECAST ---
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n?.upcomingForecast ?? "Upcoming Forecast",
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                        fontFamily: 'NotoSerifSC',
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: _ForecastItem(title: l10n?.laterToday ?? "Later Today", count: dueLaterToday, theme: theme)),
                        const SizedBox(width: 12),
                        Expanded(child: _ForecastItem(title: l10n?.tomorrow ?? "Tomorrow", count: dueTomorrow, theme: theme)),
                        const SizedBox(width: 12),
                        Expanded(child: _ForecastItem(title: l10n?.next7Days ?? "Next 7 Days", count: dueNext7Days, theme: theme)),
                      ],
                    ),
                  ],
                ),
              ).animate(delay: 300.ms)
               .fade(duration: 600.ms, curve: Curves.easeOutCubic)
               .slideY(begin: 0.05, end: 0, duration: 600.ms, curve: Curves.easeOutCubic),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 40)),
            
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
                                    l10n?.yourMindIsClear ?? "Your mind is clear.",
                                    style: theme.textTheme.titleMedium?.copyWith(
                                      color: theme.colorScheme.onSurface,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    l10n?.noReviewsDueToday ?? "No reviews due today.",
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            ElevatedButton(
                              onPressed: null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
                                foregroundColor: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              ),
                              child: Text(l10n?.done ?? "Done", style: const TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      )
                    else
                      ...dueCardsByDeck.entries.map((entry) {
                        final deckId = entry.key;
                        final cards = entry.value;
                        String displayDeckName = deckId;
                        
                        final foundDeck = allDecks.where((d) => d.id == deckId).firstOrNull;
                        if (foundDeck != null) {
                          displayDeckName = foundDeck.name;
                        }

                        if (deckId.toLowerCase() == 'hsk1') displayDeckName = l10n?.hskLevel1 ?? "HSK Level 1";
                        if (deckId.toLowerCase() == 'hsk2') displayDeckName = l10n?.hskLevel2 ?? "HSK Level 2";
                        if (deckId.toLowerCase() == 'hsk3') displayDeckName = l10n?.hskLevel3 ?? "HSK Level 3";
                        if (deckId.toLowerCase() == 'hsk4') displayDeckName = l10n?.hskLevel4 ?? "HSK Level 4";
                        if (deckId.toLowerCase() == 'hsk5') displayDeckName = l10n?.hskLevel5 ?? "HSK Level 5";
                        if (deckId.toLowerCase() == 'hsk6') displayDeckName = l10n?.hskLevel6 ?? "HSK Level 6";
                        if (deckId.toLowerCase() == 'default') displayDeckName = l10n?.generalVocabulary ?? "General Vocabulary";
                        
                        int readingDue = cards.where((c) => c.isDue(StudyMode.reading)).length;
                        int listeningDue = cards.where((c) => c.isDue(StudyMode.listening)).length;
                        int recallDue = cards.where((c) => c.isDue(StudyMode.recall)).length;
                        int speakingDue = cards.where((c) => c.isDue(StudyMode.speaking)).length;
                        int calligraphyDue = cards.where((c) => c.isDue(StudyMode.calligraphy)).length;
                        int totalDue = cards.length;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF3F51B5), Color(0xFF1A237E)], // Indigo gradient
                              ),
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF1A237E).withOpacity(0.4),
                                  blurRadius: 20,
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
                                        displayDeckName,
                                        style: theme.textTheme.titleMedium?.copyWith(
                                          color: theme.colorScheme.onPrimary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Wrap(
                                        spacing: 12,
                                        runSpacing: 8,
                                        children: [
                                          if (calligraphyDue > 0) _buildMiniStat(Icons.brush, calligraphyDue, theme),
                                          if (readingDue > 0) _buildMiniStat(Icons.visibility, readingDue, theme),
                                          if (listeningDue > 0) _buildMiniStat(Icons.headset, listeningDue, theme),
                                          if (recallDue > 0) _buildMiniStat(Icons.memory, recallDue, theme),
                                          if (speakingDue > 0) _buildMiniStat(Icons.mic, speakingDue, theme),
                                          if (readingDue == 0 && listeningDue == 0 && recallDue == 0 && speakingDue == 0 && calligraphyDue == 0)
                                            Text(
                                              "$totalDue ${l10n?.cardsRequireAttention ?? 'cards require attention.'}",
                                              style: theme.textTheme.bodyMedium?.copyWith(
                                                color: theme.colorScheme.onPrimary.withValues(alpha: 0.8),
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
                                      MaterialPageRoute(
                                        builder: (context) => DeckDetailScreen(
                                          deck: Deck(id: deckId, name: displayDeckName, createdAt: DateTime.now()),
                                        ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: theme.colorScheme.onPrimary,
                                    foregroundColor: theme.colorScheme.primary,
                                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                    elevation: 4,
                                    shadowColor: Colors.black.withOpacity(0.3),
                                  ),
                                  child: Text(l10n?.begin ?? "Begin", style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
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

  Widget _buildMiniStat(IconData icon, int count, ThemeData theme) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: theme.colorScheme.onPrimary.withValues(alpha: 0.7)),
        const SizedBox(width: 4),
        Text(
          "$count",
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onPrimary.withValues(alpha: 0.9),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _ForecastItem extends StatelessWidget {
  final String title;
  final int count;
  final ThemeData theme;

  const _ForecastItem({required this.title, required this.count, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            count.toString(),
            style: theme.textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w900,
              color: const Color(0xFF2A2D34),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: theme.textTheme.bodySmall?.copyWith(
              color: const Color(0xFF2A2D34).withOpacity(0.6),
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
