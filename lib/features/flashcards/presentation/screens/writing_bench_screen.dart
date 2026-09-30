import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hanzi_master/core/layout/zen_layout.dart';
import 'package:hanzi_master/core/layout/zen_shortcuts.dart';
import 'package:hanzi_master/core/services/haptics_manager.dart';
import 'package:hanzi_master/core/stroke_matcher.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_mode.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/drawing_canvas.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

/// The iPad **writing bench** — Part 2b of `docs/IPAD_ADAPTIVE_PLAN.md`.
///
/// The phone already grades handwriting: `DrawingCanvas` runs the guide stroke,
/// the stroke-by-stroke loop and `StrokeMatcher`, and `review_screen` drives it
/// inside a card flow. What a phone cannot give you is *room* and a *Pencil*:
/// your finger covers the stroke you are drawing, and the canvas is thumb-sized.
///
/// So this screen is a composition, not a new engine:
///
/// * a large writing surface (capped at 560dp so it stays reachable) with a
///   guide that hides itself as the streak grows — exactly like review mode;
/// * a persistent panel beside it: the character with its stroke-order animation,
///   pinyin, definition, the per-stroke verdicts, and the session progress;
/// * a session, not a single card: previous / next / clear / skip a stroke, and
///   a replay of your own attempt (the canvas already supports `readOnly` +
///   `initialUserStrokes`).
///
/// Reachable from the deck screen's action block, beside Review / Story / Role
/// play (`Practice Writing`). Nothing here is iPad-only in the *logic* sense: on
/// a phone the same screen lays out as a single column.
class WritingBenchScreen extends StatefulWidget {
  const WritingBenchScreen({
    super.key,
    required this.cards,
    this.initialIndex = 0,
    this.deckName,
  });

  /// The practice session: usually every card of a deck.
  final List<Flashcard> cards;
  final int initialIndex;
  final String? deckName;

  @override
  State<WritingBenchScreen> createState() => _WritingBenchScreenState();
}

class _WritingBenchScreenState extends State<WritingBenchScreen> {
  late int _cardIndex = widget.initialIndex.clamp(
    0,
    widget.cards.isEmpty ? 0 : widget.cards.length - 1,
  );
  late final ValueNotifier<List<ui.Offset?>> _userPointsNotifier =
      ValueNotifier<List<ui.Offset?>>(<ui.Offset?>[]);

  int _strokeIndex = 0;
  final List<double> _strokeScores = <double>[];
  List<List<ui.Offset?>> _completedStrokes = <List<ui.Offset?>>[];
  bool _replaying = false;

  Flashcard get _card => widget.cards[_cardIndex];

  /// Strokes of the current card, separators excluded (a card can hold several
  /// characters, and `__CHAR_SEPARATOR__` is not a stroke).
  int get _totalStrokes => _card.strokePaths
      .where((String path) => path != '__CHAR_SEPARATOR__')
      .length;

  bool get _cardComplete => _strokeIndex >= _totalStrokes;

  @override
  void dispose() {
    _userPointsNotifier.dispose();
    super.dispose();
  }

  void _resetCard({bool keepScores = false}) {
    setState(() {
      _strokeIndex = 0;
      _replaying = false;
      _completedStrokes = <List<ui.Offset?>>[];
      if (!keepScores) _strokeScores.clear();
      _userPointsNotifier.value = <ui.Offset?>[];
    });
  }

  void _goToCard(int index) {
    if (index < 0 || index >= widget.cards.length) return;
    setState(() {
      _cardIndex = index;
      _strokeIndex = 0;
      _strokeScores.clear();
      _completedStrokes = <List<ui.Offset?>>[];
      _replaying = false;
      _userPointsNotifier.value = <ui.Offset?>[];
    });
  }

  /// Mirrors `review_screen._onStrokeComplete`: keep the finished stroke, grade
  /// it against the reference median, then advance the guide.
  void _onStrokeComplete(int strokeIndex, Size size) {
    if (strokeIndex != _strokeIndex) return;
    HapticsManager.light();
    final List<ui.Offset?> finished =
        List<ui.Offset?>.from(_userPointsNotifier.value);
    final double? score = _scoreStroke(finished, strokeIndex);
    setState(() {
      _completedStrokes.add(finished);
      if (score != null) _strokeScores.add(score);
      if (_strokeIndex + 1 < _totalStrokes) _strokeIndex++;
      _userPointsNotifier.value = <ui.Offset?>[];
    });
  }

  /// Grades one stroke with the same matcher the canvas uses, so the panel's
  /// numbers and the canvas's own feedback cannot disagree.
  double? _scoreStroke(List<ui.Offset?> points, int strokeIndex) {
    final List<ui.Offset> stroke = points
        .where((ui.Offset? point) => point != null)
        .map((ui.Offset? point) => point!)
        .toList();
    if (stroke.length < 2) return null;
    final List<List<ui.Offset>> medians = _card.medianPaths;
    final int realIndex = _realMedianIndex(strokeIndex);
    if (realIndex < 0 || realIndex >= medians.length) return null;
    final StrokeMatchResult result = StrokeMatcher.matchStroke(
      stroke,
      medians[realIndex],
      masteryLevel: _card.masteryLevel(StudyMode.calligraphy),
    );
    return result.score * 100.0;
  }

  /// Stroke position ignoring `__CHAR_SEPARATOR__` entries, which the median list
  /// does not contain.
  int _realMedianIndex(int validIndex) {
    int valid = 0;
    for (int i = 0; i < _card.strokePaths.length; i++) {
      if (_card.strokePaths[i] == '__CHAR_SEPARATOR__') continue;
      if (valid == validIndex) return i;
      valid++;
    }
    return -1;
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final ZenWindow window = ZenWindow.of(context);

    if (widget.cards.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.practiceWriting)),
        body: Center(child: Text(l10n.addCardsFirst)),
      );
    }

    final Widget surface = _WritingSurface(
      card: _card,
      strokeIndex: _strokeIndex,
      strokeScores: _strokeScores,
      userPointsNotifier: _userPointsNotifier,
      onStrokeComplete: _onStrokeComplete,
      replayStrokes: _replaying ? _completedStrokes : null,
      // VoiceOver/Switch Control get the same information the panel shows.
      semanticsLabel: '${l10n.practiceWriting}: ${_card.hanzi}',
      semanticsValue: '${_strokeIndex.clamp(0, _totalStrokes)} / '
          '$_totalStrokes ${l10n.strokes}',
    );

    final Widget controls = _BenchControls(
      l10n: l10n,
      onClear: _resetCard,
      onSkipStroke: _strokeIndex < _totalStrokes
          ? () => setState(() {
                _strokeIndex++;
                _userPointsNotifier.value = <ui.Offset?>[];
              })
          : null,
      onPrevious: _cardIndex > 0 ? () => _goToCard(_cardIndex - 1) : null,
      onNext: _cardIndex + 1 < widget.cards.length
          ? () => _goToCard(_cardIndex + 1)
          : null,
      onReplayToggle: _completedStrokes.isEmpty
          ? null
          : () => setState(() {
                _replaying = !_replaying;
                _userPointsNotifier.value = <ui.Offset?>[];
              }),
      replaying: _replaying,
    );

    final Widget panel = _BenchPanel(
      l10n: l10n,
      card: _card,
      strokeScores: _strokeScores,
      totalStrokes: _totalStrokes,
      cardIndex: _cardIndex,
      cardCount: widget.cards.length,
      complete: _cardComplete,
    );

    return ZenShortcuts(
      // With a keyboard the session is driven from the keys: ⌘← / ⌘→ between
      // cards (Ctrl+← / Ctrl+→ on an Android tablet), ⌘R to clear.
      shortcuts: <ShortcutActivator, VoidCallback>{
        ...ZenShortcuts.primary(
            LogicalKeyboardKey.arrowLeft, () => _goToCard(_cardIndex - 1)),
        ...ZenShortcuts.primary(
            LogicalKeyboardKey.arrowRight, () => _goToCard(_cardIndex + 1)),
        ...ZenShortcuts.primary(LogicalKeyboardKey.keyR, _resetCard),
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.deckName == null
                ? l10n.practiceWriting
                : '${l10n.practiceWriting} · ${widget.deckName}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: window.isExpanded
            // iPad: the writing surface keeps the middle, and the context lives
            // beside it, so nothing has to be scrolled to between strokes.
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(window.gutter),
                      child: Column(
                        children: <Widget>[
                          Expanded(child: surface),
                          const SizedBox(height: 12),
                          controls,
                        ],
                      ),
                    ),
                  ),
                  const VerticalDivider(width: 1, thickness: 1),
                  SizedBox(
                    width: 340,
                    child: SingleChildScrollView(child: panel),
                  ),
                ],
              )
            // Phones: the same screen in one column. The canvas keeps the height,
            // the panel scrolls in a fixed strip.
            : Column(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(window.gutter),
                      child: surface,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: window.gutter),
                    child: controls,
                  ),
                  SizedBox(
                    height: 190,
                    child: SingleChildScrollView(child: panel),
                  ),
                ],
              ),
      ),
    );
  }
}

/// The writing surface: the existing grading canvas, 1:1 and **capped** so it
/// stays reachable on a 12.9" iPad (a 1000dp square is unwritable), plus the
/// replay mode that redraws the learner's own attempt from `initialUserStrokes`.
class _WritingSurface extends StatelessWidget {
  const _WritingSurface({
    required this.card,
    required this.strokeIndex,
    required this.strokeScores,
    required this.userPointsNotifier,
    required this.onStrokeComplete,
    this.replayStrokes,
    this.semanticsLabel,
    this.semanticsValue,
  });

  final Flashcard card;
  final int strokeIndex;
  final List<double> strokeScores;
  final ValueNotifier<List<ui.Offset?>> userPointsNotifier;
  final void Function(int, Size) onStrokeComplete;
  final List<List<ui.Offset?>>? replayStrokes;
  final String? semanticsLabel;
  final String? semanticsValue;

  static const double maxSide = 560;

  @override
  Widget build(BuildContext context) {
    final bool replaying = replayStrokes != null;
    return Center(
      child: ConstrainedBox(
        constraints:
            const BoxConstraints(maxWidth: maxSide, maxHeight: maxSide),
        child: AspectRatio(
          aspectRatio: 1,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(24),
              boxShadow: const <BoxShadow>[
                BoxShadow(color: Colors.black12, blurRadius: 20),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: DrawingCanvas(
                // A new key per mode, so the canvas rebuilds its own state when
                // the learner switches between writing and replaying.
                key: ValueKey<String>('bench-${card.id}-$replaying'),
                strokePaths: card.strokePaths,
                medianPaths: card.medianPaths,
                isFlipped: card.isFlipped,
                strokeByStrokeMode: true,
                currentStrokeIndex: strokeIndex,
                onStrokeComplete: onStrokeComplete,
                userPointsNotifier: userPointsNotifier,
                masteryLevel: card.masteryLevel(StudyMode.calligraphy),
                showGrade: !replaying,
                strokeScores: strokeScores.isEmpty
                    ? null
                    : List<double>.from(strokeScores),
                showHeatmap: !replaying && strokeScores.isNotEmpty,
                showReference: true,
                showAnimation: replaying,
                showControls: false,
                readOnly: replaying,
                initialUserStrokes: replayStrokes,
                autoCenter: false,
                semanticsLabel: semanticsLabel,
                semanticsValue: semanticsValue,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// The bench's actions. A `Wrap`, so a longer translation in one language moves
/// to the next line instead of pushing the row out of its box.
class _BenchControls extends StatelessWidget {
  const _BenchControls({
    required this.l10n,
    required this.onClear,
    required this.replaying,
    this.onSkipStroke,
    this.onPrevious,
    this.onNext,
    this.onReplayToggle,
  });

  final AppLocalizations l10n;
  final VoidCallback onClear;
  final bool replaying;
  final VoidCallback? onSkipStroke;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;
  final VoidCallback? onReplayToggle;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        OutlinedButton.icon(
          onPressed: onPrevious,
          icon: const Icon(Icons.chevron_left, size: 18),
          label:
              Text(l10n.previous, maxLines: 1, overflow: TextOverflow.ellipsis),
        ),
        OutlinedButton.icon(
          onPressed: onClear,
          icon: const Icon(Icons.refresh, size: 18),
          label: Text(l10n.clear, maxLines: 1, overflow: TextOverflow.ellipsis),
        ),
        if (onSkipStroke != null)
          OutlinedButton.icon(
            onPressed: onSkipStroke,
            icon: const Icon(Icons.skip_next, size: 18),
            label: Text(
              l10n.skipCurrentStroke,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        if (onReplayToggle != null)
          OutlinedButton.icon(
            onPressed: onReplayToggle,
            icon: Icon(replaying ? Icons.edit : Icons.replay, size: 18),
            label: Text(
              replaying ? l10n.practiceWriting : l10n.retry,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        FilledButton.icon(
          onPressed: onNext,
          icon: const Icon(Icons.chevron_right, size: 18),
          label: Text(l10n.next, maxLines: 1, overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }
}

/// The context panel: everything a phone makes you scroll between strokes.
/// The character with its stroke-order animation, pinyin, definition, the
/// session progress, and the per-stroke verdicts from [StrokeMatcher].
class _BenchPanel extends StatelessWidget {
  const _BenchPanel({
    required this.l10n,
    required this.card,
    required this.strokeScores,
    required this.totalStrokes,
    required this.cardIndex,
    required this.cardCount,
    required this.complete,
  });

  final AppLocalizations l10n;
  final Flashcard card;
  final List<double> strokeScores;
  final int totalStrokes;
  final int cardIndex;
  final int cardCount;
  final bool complete;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final double average = strokeScores.isEmpty
        ? 0
        : strokeScores.reduce((double a, double b) => a + b) /
            strokeScores.length;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  l10n.practiceWriting,
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w800),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${cardIndex + 1} / $cardCount',
                style: theme.textTheme.labelLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: cardCount == 0 ? 0 : (cardIndex + 1) / cardCount,
          ),
          const SizedBox(height: 16),
          Center(
            child: SizedBox(
              width: 160,
              height: 160,
              child: DrawingCanvas(
                key: ValueKey<String>('panel-${card.id}'),
                strokePaths: card.strokePaths,
                medianPaths: card.medianPaths,
                isFlipped: card.isFlipped,
                showAnimation: true,
                showControls: false,
                showGrade: false,
                showGuideLines: false,
                readOnly: true,
                autoCenter: false,
                semanticsLabel: '${l10n.strokeOrderChip}: ${card.hanzi}',
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            card.pinyin,
            style: theme.textTheme.titleSmall,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            card.definition,
            style: theme.textTheme.bodyMedium,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  l10n.strokes,
                  style: theme.textTheme.bodyMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${strokeScores.length} / $totalStrokes',
                style: theme.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          if (strokeScores.isNotEmpty) ...<Widget>[
            const SizedBox(height: 6),
            Text(
              '${l10n.scoreText}: ${average.toStringAsFixed(0)}',
              style: theme.textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.strokeAnalysis,
              style: theme.textTheme.labelLarge,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            _ScoreBars(scores: strokeScores),
          ],
          if (complete) ...<Widget>[
            const SizedBox(height: 14),
            Row(
              children: <Widget>[
                const Icon(Icons.check_circle, size: 18, color: Colors.green),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    l10n.practiceStrokeOrderWithVisualGuides,
                    style: theme.textTheme.bodySmall,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

/// One bar per stroke, coloured with the same thresholds the canvas heatmap
/// uses, so the panel and the writing surface cannot disagree.
class _ScoreBars extends StatelessWidget {
  const _ScoreBars({required this.scores});

  final List<double> scores;

  static Color _color(double score) {
    if (score >= 85) return Colors.green;
    if (score >= 60) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      children: <Widget>[
        for (int i = 0; i < scores.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 24,
                  child: Text(
                    '${i + 1}',
                    style: theme.textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: LinearProgressIndicator(
                      value: (scores[i] / 100).clamp(0.0, 1.0),
                      minHeight: 6,
                      color: _color(scores[i]),
                      backgroundColor: Colors.black12,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  scores[i].toStringAsFixed(0),
                  style: theme.textTheme.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
