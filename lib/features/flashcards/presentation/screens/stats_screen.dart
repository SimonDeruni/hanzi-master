import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/quick_look_sheet.dart';
import '../../domain/entities/study_mode.dart';
import '../providers/stats_controller.dart';
import '../providers/stats_state.dart';

/// The statistics of a deck (or of the whole library when [deckId] is null).
///
/// Two compositions share one dataset:
///
/// * [DeckStatsView] is **content only** — the deck screen's *Statistics* tab
///   renders it directly. The previous version rendered a whole `Scaffold` with
///   an `AppBar` inside that tab, which put a second back arrow (and a second
///   title bar) inside a screen that already had both.
/// * [StatsScreen] is the routed version, used by the profile entry.
///
/// The numbers also go past "how many cards do I have": per-mode retention, the
/// words that keep resisting, the words that graduated, this week's intake and
/// the seven-day workload all existed in the SRS records but were never shown,
/// so the screen could not tell a learner anything to act on.
class StatsScreen extends ConsumerWidget {
  final String? deckId;
  const StatsScreen({super.key, this.deckId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppTheme.surfaceOf(context),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.myProgress),
        backgroundColor: AppTheme.surfaceOf(context),
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
      ),
      body: DeckStatsView(deckId: deckId),
    );
  }
}

class DeckStatsView extends ConsumerWidget {
  final String? deckId;
  const DeckStatsView({super.key, this.deckId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final StatsState stats = ref.watch(userStatsProvider(deckId: deckId));
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final _Palette palette = _Palette.of(context);

    if (stats.total == 0) {
      return ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
        children: <Widget>[
          _StatsCard(
            palette: palette,
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.insights_rounded,
                  size: 40,
                  color: palette.accent.withValues(alpha: 0.5),
                ),
                const SizedBox(height: 14),
                Text(
                  l10n.noCardsYet,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: palette.ink,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
      children: <Widget>[
        _MasteryCard(stats: stats, l10n: l10n, palette: palette),
        const SizedBox(height: 16),
        _RetentionCard(stats: stats, l10n: l10n, palette: palette),
        const SizedBox(height: 16),
        _WorkloadCard(stats: stats, l10n: l10n, palette: palette),
        const SizedBox(height: 16),
        _MomentumTiles(stats: stats, l10n: l10n, palette: palette),
        if (stats.trickyWords.isNotEmpty) ...<Widget>[
          const SizedBox(height: 16),
          _WordListCard(
            title: l10n.trickyCharacters,
            icon: Icons.local_fire_department_rounded,
            words: stats.trickyWords,
            l10n: l10n,
            palette: palette,
            keyPrefix: 'tricky',
            trailing: (WordInsight word) => _Metric(
              value: '${(word.accuracy * 100).round()}%',
              // Not lower-cased: capitalisation is language-specific (German
              // "Versuche" must not become "versuche").
              caption: '${word.attempts} ${l10n.attempts}',
              tone: palette.modeTone(word.accuracy * 100),
              palette: palette,
            ),
          ),
        ],
        if (stats.strongestWords.isNotEmpty) ...<Widget>[
          const SizedBox(height: 16),
          _WordListCard(
            title: l10n.strongestCharacters,
            icon: Icons.workspace_premium_rounded,
            words: stats.strongestWords,
            l10n: l10n,
            palette: palette,
            keyPrefix: 'strongest',
            trailing: (WordInsight word) => _Metric(
              value: l10n.dayStreakCount(word.streak),
              caption: '${word.intervalDays} ${l10n.days}',
              tone: palette.jade,
              palette: palette,
            ),
          ),
        ],
      ],
    );
  }
}
// ── Shared vocabulary ─────────────────────────────────────────────────────────

/// The one place the screen's colours come from, so every card agrees.
class _Palette {
  const _Palette({
    required this.isDark,
    required this.accent,
    required this.card,
    required this.gold,
    required this.ink,
    required this.muted,
    required this.jade,
    required this.alert,
  });

  factory _Palette.of(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return _Palette(
      isDark: isDark,
      accent: AppTheme.accentOf(context),
      card: AppTheme.cardBgOf(context),
      gold: isDark ? Colors.amber.shade700 : const Color(0xFFD4AF37),
      ink: isDark ? Colors.white : const Color(0xFF1A1A1B),
      muted: isDark ? Colors.white60 : const Color(0xFF6B655B),
      jade: const Color(0xFF2E7D32),
      alert: isDark ? Colors.redAccent : const Color(0xFFC62828),
    );
  }

  final bool isDark;
  final Color accent;
  final Color card;
  final Color gold;
  final Color ink;
  final Color muted;
  final Color jade;
  final Color alert;

  /// Jade for solid recall, gold for shaky, Cinnabar for weak.
  Color modeTone(double percent) {
    if (percent >= 80) return jade;
    if (percent >= 60) return gold;
    return alert;
  }
}

/// The ink well every block on this screen sits in (the book screen's card).
class _StatsCard extends StatelessWidget {
  const _StatsCard({
    required this.child,
    required this.palette,
    this.title,
    this.icon,
  });

  final Widget child;
  final _Palette palette;
  final String? title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: palette.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: palette.gold.withValues(alpha: 0.28)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: palette.isDark ? 0.2 : 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (title != null) ...<Widget>[
            Row(
              children: <Widget>[
                if (icon != null) ...<Widget>[
                  Icon(icon, size: 18, color: palette.accent),
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: Text(
                    title!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NotoSerifSC',
                      color: palette.ink,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
          ],
          child,
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({
    required this.value,
    required this.caption,
    required this.tone,
    required this.palette,
  });

  final String value;
  final String caption;
  final Color tone;
  final _Palette palette;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      // The trailing metric must never push the word off its own row, so it is
      // capped and ellipsised; "7-Tage-Serie" at 2x is otherwise far too wide.
      constraints: const BoxConstraints(maxWidth: 116),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: tone,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            caption,
            style: TextStyle(fontSize: 10.5, color: palette.muted),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _LegendEntry {
  const _LegendEntry(this.label, this.value, this.color);
  final String label;
  final int value;
  final Color color;
}

/// How much of the deck has graduated: a ring with the mastered share in the
/// middle and the three buckets spelled out beside it.
class _MasteryCard extends StatelessWidget {
  const _MasteryCard({
    required this.stats,
    required this.l10n,
    required this.palette,
  });

  final StatsState stats;
  final AppLocalizations l10n;
  final _Palette palette;

  @override
  Widget build(BuildContext context) {
    final List<_LegendEntry> legend = <_LegendEntry>[
      _LegendEntry(l10n.masteredStatus, stats.mastered, palette.accent),
      _LegendEntry(l10n.learningStatus, stats.learning, palette.gold),
      _LegendEntry(
        l10n.newInk,
        stats.newCards,
        palette.muted.withValues(alpha: 0.5),
      ),
    ];

    return _StatsCard(
      palette: palette,
      title: l10n.libraryMastery,
      icon: Icons.donut_large_rounded,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // At 2x text on a small phone the ring and the legend cannot share a
          // row, so the legend drops underneath instead of squeezing.
          final double scale = MediaQuery.textScalerOf(context).scale(1);
          final bool sideBySide = constraints.maxWidth >= 300 && scale <= 1.6;
          // Tall scripts (Thai, Hindi) need a bigger ring at 2x text, and the
          // centre caption is shrink-wrapped so it can never overflow the ring.
          final double ringSize = scale > 1.6 ? 168 : 132;
          final Widget ring = SizedBox(
            width: ringSize,
            height: ringSize,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                PieChart(
                  PieChartData(
                    sectionsSpace: 2,
                    centerSpaceRadius: ringSize / 3,
                    startDegreeOffset: -90,
                    sections: <PieChartSectionData>[
                      for (final _LegendEntry entry in legend)
                        PieChartSectionData(
                          color: entry.color,
                          value: entry.value.toDouble(),
                          radius: ringSize / 6,
                          showTitle: false,
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(ringSize * 0.2),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          '${(stats.masteryRatio * 100).round()}%',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: palette.ink,
                          ),
                        ),
                        Text(
                          l10n.masteredStatus,
                          style: TextStyle(
                            fontSize: 10,
                            color: palette.muted,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
          final Widget legendColumn = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (final _LegendEntry entry in legend)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: entry.color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          entry.label,
                          style: TextStyle(fontSize: 12.5, color: palette.ink),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${entry.value}',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: palette.ink,
                        ),
                        maxLines: 1,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${(entry.value / stats.total * 100).round()}%',
                        style: TextStyle(fontSize: 11, color: palette.muted),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
            ],
          );

          if (sideBySide) {
            return Row(
              children: <Widget>[
                ring,
                const SizedBox(width: 16),
                Expanded(child: legendColumn),
              ],
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ring,
              const SizedBox(height: 16),
              legendColumn,
            ],
          );
        },
      ),
    );
  }
}

/// Where the deck actually stands: overall retention plus every practice mode,
/// so "I always fail speaking" becomes visible instead of guessed.
class _RetentionCard extends StatelessWidget {
  const _RetentionCard({
    required this.stats,
    required this.l10n,
    required this.palette,
  });

  final StatsState stats;
  final AppLocalizations l10n;
  final _Palette palette;

  @override
  Widget build(BuildContext context) {
    final bool hasHistory = stats.totalReviews > 0;
    return _StatsCard(
      palette: palette,
      title: l10n.accuracyByMode,
      icon: Icons.track_changes_rounded,
      child: Column(
        children: <Widget>[
          // The overall figure gets a row of its own: as a header trailing it
          // was the first thing to break in German at 2x text scale.
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: <Widget>[
                Icon(Icons.percent_rounded, size: 15, color: palette.muted),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l10n.accuracy,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: palette.ink,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  hasHistory ? '${stats.accuracy.round()}%' : '—',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: hasHistory
                        ? palette.modeTone(stats.accuracy)
                        : palette.muted,
                  ),
                  maxLines: 1,
                ),
              ],
            ),
          ),
          Divider(height: 1, color: palette.muted.withValues(alpha: 0.2)),
          const SizedBox(height: 12),
          for (final StudyMode mode in StudyMode.values)
            _buildModeRow(
              mode,
              stats.accuracyByMode[mode] ?? 0,
              stats.attemptsByMode[mode] ?? 0,
            ),
        ],
      ),
    );
  }

  Widget _buildModeRow(StudyMode mode, double accuracy, int attempts) {
    final bool practised = attempts > 0;
    final Color tone = practised ? palette.modeTone(accuracy) : palette.muted;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(_modeIcon(mode), size: 15, color: tone),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _modeLabel(mode),
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: practised ? palette.ink : palette.muted,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                practised ? '${accuracy.round()}%' : '—',
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  color: tone,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: practised ? (accuracy / 100).clamp(0.0, 1.0) : 0,
              minHeight: 6,
              backgroundColor: palette.muted.withValues(alpha: 0.18),
              valueColor: AlwaysStoppedAnimation<Color>(tone),
            ),
          ),
        ],
      ),
    );
  }

  String _modeLabel(StudyMode mode) {
    switch (mode) {
      case StudyMode.calligraphy:
        return l10n.calligraphy;
      case StudyMode.reading:
        return l10n.reading;
      case StudyMode.recall:
        return l10n.recall;
      case StudyMode.speaking:
        return l10n.speaking;
      case StudyMode.listening:
        return l10n.listening1;
    }
  }

  IconData _modeIcon(StudyMode mode) {
    switch (mode) {
      case StudyMode.calligraphy:
        return Icons.brush_rounded;
      case StudyMode.reading:
        return Icons.menu_book_rounded;
      case StudyMode.recall:
        return Icons.psychology_rounded;
      case StudyMode.speaking:
        return Icons.graphic_eq_rounded;
      case StudyMode.listening:
        return Icons.headphones_rounded;
    }
  }
}

/// What the next seven days cost: today's queue and the daily shape of the week.
class _WorkloadCard extends StatelessWidget {
  const _WorkloadCard({
    required this.stats,
    required this.l10n,
    required this.palette,
  });

  final StatsState stats;
  final AppLocalizations l10n;
  final _Palette palette;

  @override
  Widget build(BuildContext context) {
    final List<int> forecast = stats.upcomingReviews;
    final int busiest =
        forecast.isEmpty ? 0 : forecast.reduce((a, b) => a > b ? a : b);
    // Flutter lists narrow weekdays Monday-first; honour the locale's start day.
    final MaterialLocalizations material = MaterialLocalizations.of(context);
    final List<String> weekdays = material.narrowWeekdays;
    final int firstDay = material.firstDayOfWeekIndex;
    // The axis labels grow with the user's text scale and their line height
    // varies by script (Hindi and Thai are much taller than Latin), so the
    // space reserved for them is scaled generously rather than guessed at —
    // reserve too little and fl_chart's own axis column overflows.
    final double axisSpace = MediaQuery.textScalerOf(context).scale(30);

    return _StatsCard(
      palette: palette,
      title: l10n.upcomingReviews,
      icon: Icons.calendar_month_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                '${stats.dueToday}',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: palette.accent,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  l10n.dueToday,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: palette.ink,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 86 + axisSpace,
            child: BarChart(
              BarChartData(
                maxY: busiest == 0 ? 1 : (busiest * 1.25),
                alignment: BarChartAlignment.spaceAround,
                barTouchData: const BarTouchData(enabled: false),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: axisSpace,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        final int index = value.toInt();
                        if (index < 0 || index >= forecast.length) {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            weekdays[(firstDay + index) % 7],
                            style: TextStyle(
                              fontSize: 10.5,
                              color:
                                  index == 0 ? palette.accent : palette.muted,
                              fontWeight: index == 0
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                barGroups: <BarChartGroupData>[
                  for (int i = 0; i < forecast.length; i++)
                    BarChartGroupData(
                      x: i,
                      barRods: <BarChartRodData>[
                        BarChartRodData(
                          toY: forecast[i].toDouble(),
                          width: 14,
                          borderRadius: BorderRadius.circular(4),
                          color: i == 0
                              ? palette.accent
                              : palette.accent.withValues(alpha: 0.35),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '${stats.nextSevenDays} ${l10n.reviews}',
            style: TextStyle(fontSize: 11.5, color: palette.muted),
          ),
        ],
      ),
    );
  }
}

/// This week's intake, all-time effort, and how much work each word has taken.
class _MomentumTiles extends StatelessWidget {
  const _MomentumTiles({
    required this.stats,
    required this.l10n,
    required this.palette,
  });

  final StatsState stats;
  final AppLocalizations l10n;
  final _Palette palette;

  @override
  Widget build(BuildContext context) {
    final List<_Tile> tiles = <_Tile>[
      _Tile('${stats.introducedThisWeek}', l10n.newThisWeek, palette.accent),
      _Tile('${stats.totalReviews}', l10n.reviews, palette.jade),
      _Tile(
        stats.averageAttempts.toStringAsFixed(1),
        l10n.averageAttemptsPerWord,
        palette.gold,
      ),
    ];

    // IntrinsicHeight so the three ink wells share the tallest label's height
    // without asking for an unbounded one inside the scrolling list.
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (int i = 0; i < tiles.length; i++) ...<Widget>[
            if (i > 0) const SizedBox(width: 10),
            Expanded(
              child: _StatsCard(
                palette: palette,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      tiles[i].value,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: tiles[i].tone,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      tiles[i].label,
                      style: TextStyle(
                        fontSize: 10.5,
                        color: palette.muted,
                        height: 1.3,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _Tile {
  const _Tile(this.value, this.label, this.tone);
  final String value;
  final String label;
  final Color tone;
}

/// The words worth opening: the ones that keep resisting and the ones that
/// graduated. Tapping one opens the same quick look as the deck's card list.
class _WordListCard extends StatelessWidget {
  const _WordListCard({
    required this.title,
    required this.icon,
    required this.words,
    required this.l10n,
    required this.palette,
    required this.trailing,
    this.keyPrefix = 'words',
  });

  final String title;
  final IconData icon;
  final List<WordInsight> words;
  final AppLocalizations l10n;
  final _Palette palette;
  final Widget Function(WordInsight word) trailing;

  /// A word can graduate and stay tricky at the same time, so each list names
  /// its own rows.
  final String keyPrefix;

  @override
  Widget build(BuildContext context) {
    return _StatsCard(
      palette: palette,
      title: title,
      icon: icon,
      child: Column(
        children: <Widget>[
          for (int i = 0; i < words.length; i++)
            _buildRow(context, words[i], isLast: i == words.length - 1),
        ],
      ),
    );
  }

  Widget _buildRow(
    BuildContext context,
    WordInsight word, {
    required bool isLast,
  }) {
    return InkWell(
      key: ValueKey<String>('deck-stats-$keyPrefix-${word.hanzi}'),
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        HapticsManager.light();
        showQuickLook(context, word.hanzi);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: isLast ? 4 : 10),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 40,
              child: Text(
                word.hanzi,
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'NotoSerifSC',
                  color: palette.ink,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    word.pinyin,
                    style: TextStyle(fontSize: 12, color: palette.muted),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    word.definition,
                    style: TextStyle(
                      fontSize: 11.5,
                      fontStyle: FontStyle.italic,
                      color: palette.muted.withValues(alpha: 0.85),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            trailing(word),
          ],
        ),
      ),
    );
  }
}
