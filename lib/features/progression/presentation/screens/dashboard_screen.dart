import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_mode.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/review_screen.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/deck_detail_screen.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/dictionary_provider.dart';
class DashboardScreen extends ConsumerWidget {
  final Function(int) onNavigate;

  const DashboardScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    // 1. Fetch Flashcard Data
    final allCards = ref.watch(flashcardControllerProvider).valueOrNull ?? [];
    
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
    String rank = "HSK 1 Candidate";
    int nextMilestone = 150;
    
    if (knownCards >= 5000) { rank = "HSK 6 Master"; nextMilestone = knownCards; }
    else if (knownCards >= 2500) { rank = "HSK 6 Candidate"; nextMilestone = 5000; }
    else if (knownCards >= 1200) { rank = "HSK 5 Candidate"; nextMilestone = 2500; }
    else if (knownCards >= 600) { rank = "HSK 4 Candidate"; nextMilestone = 1200; }
    else if (knownCards >= 300) { rank = "HSK 3 Candidate"; nextMilestone = 600; }
    else if (knownCards >= 150) { rank = "HSK 2 Candidate"; nextMilestone = 300; }
    
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
      final stats = card.getStatsForMode(StudyMode.reading);
      final reviewDate = stats.nextReviewDate;
      
      if (reviewDate.isAfter(now) && reviewDate.isBefore(endOfNext7Days)) {
        dueNext7Days++;
        if (reviewDate.isBefore(endOfToday)) {
          dueLaterToday++;
        } else if (reviewDate.isBefore(endOfTomorrow)) {
          dueTomorrow++;
        }
      }
    }

    return Scaffold(
      body: CalligraphyBackground(
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              title: Text("GLOBAL MASTERY", style: TextStyle(letterSpacing: 2.0, fontSize: 14, fontWeight: FontWeight.bold)),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              surfaceTintColor: Colors.transparent,
              pinned: false,
              floating: false,
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            
            // --- TOP: SCHOLAR'S RANK ---
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.05)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "CURRENT RANK",
                                style: theme.textTheme.labelMedium?.copyWith(
                                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                                  letterSpacing: 2.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                rank,
                                style: theme.textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: -0.5,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.military_tech,
                              color: theme.colorScheme.primary,
                              size: 32,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 8,
                          backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
                          valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "$knownCards Mastered",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Next: $nextMilestone",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            const SliverToBoxAdapter(child: SizedBox(height: 40)),
            
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
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: isDark ? Colors.white12 : Colors.grey.withValues(alpha: 0.2)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: theme.colorScheme.onSurface.withValues(alpha: 0.5)),
                        const SizedBox(width: 12),
                        Text(
                          "Search Hanzi or Pinyin...",
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                          ),
                        ),
                        const Spacer(),
                        Icon(Icons.arrow_forward_ios, size: 14, color: theme.colorScheme.onSurface.withValues(alpha: 0.3)),
                      ],
                    ),
                  ),
                ),
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
                      "Upcoming Forecast",
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: isDark ? Colors.white12 : Colors.grey.withValues(alpha: 0.2)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _ForecastItem(title: "Later Today", count: dueLaterToday, theme: theme),
                          Container(width: 1, height: 40, color: theme.colorScheme.onSurface.withValues(alpha: 0.1)),
                          _ForecastItem(title: "Tomorrow", count: dueTomorrow, theme: theme),
                          Container(width: 1, height: 40, color: theme.colorScheme.onSurface.withValues(alpha: 0.1)),
                          _ForecastItem(title: "Next 7 Days", count: dueNext7Days, theme: theme),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
                      "Daily Review",
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w900,
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
                          border: Border.all(color: isDark ? Colors.white12 : Colors.grey.withValues(alpha: 0.2)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 15,
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
                                    "Your mind is clear.",
                                    style: theme.textTheme.titleMedium?.copyWith(
                                      color: theme.colorScheme.onSurface,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "No reviews due today.",
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
                              child: const Text("Done", style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      )
                    else
                      ...dueCardsByDeck.entries.map((entry) {
                        final deckId = entry.key;
                        final cards = entry.value;
                        String displayDeckName = deckId;
                        if (deckId.toLowerCase() == 'hsk1') displayDeckName = "HSK Level 1";
                        if (deckId.toLowerCase() == 'hsk2') displayDeckName = "HSK Level 2";
                        if (deckId.toLowerCase() == 'hsk3') displayDeckName = "HSK Level 3";
                        if (deckId.toLowerCase() == 'hsk4') displayDeckName = "HSK Level 4";
                        if (deckId.toLowerCase() == 'hsk5') displayDeckName = "HSK Level 5";
                        if (deckId.toLowerCase() == 'hsk6') displayDeckName = "HSK Level 6";
                        if (deckId.toLowerCase() == 'default') displayDeckName = "General Vocabulary";
                        
                        int readingDue = cards.where((c) => c.isDue(StudyMode.reading)).length;
                        int listeningDue = cards.where((c) => c.isDue(StudyMode.listening)).length;
                        int recallDue = cards.where((c) => c.isDue(StudyMode.recall)).length;
                        int speakingDue = cards.where((c) => c.isDue(StudyMode.speaking)).length;
                        int calligraphyDue = cards.where((c) => c.isDue(StudyMode.calligraphy)).length;
                        int totalDue = cards.length;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: theme.colorScheme.primary.withValues(alpha: 0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
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
                                              "$totalDue cards require attention.",
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
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                  ),
                                  child: const Text("Begin", style: TextStyle(fontWeight: FontWeight.bold)),
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
    return Column(
      children: [
        Text(
          count.toString(),
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w900,
            color: count > 0 ? theme.colorScheme.primary : theme.colorScheme.onSurface.withValues(alpha: 0.5),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
