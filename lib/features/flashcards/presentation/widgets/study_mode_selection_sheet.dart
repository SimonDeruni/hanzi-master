import 'package:flutter/material.dart';

import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/review_stats.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_mode.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/global_blurred_bottom_sheet.dart';

/// The "How would you like to study?" chooser for a deck.
///
/// It used to be five Material rows in five different hues — `Colors.blue`,
/// `.green`, `.orange`, `.red`, `.purple`, each with a `shade50`/`shade900` fill
/// and a `shade200`/`shade700` border at radius 16 — so the step *before* a
/// session looked like a different app from the session, the deck and the book
/// screen. Its labels also came from `StudyMode.title` / `.description`, which
/// are hardcoded English in the domain entity.
///
/// Now each mode is the app's ink well: card background, Emperor's Gold hairline,
/// 18px radius, the accent glyph tile, and the localized name and description
/// from the 14-locale catalogue. Two chips make the choice informed — how many
/// cards of that mode are waiting now, and the retention the learner has in it —
/// both derived from the deck's own cards and both hidden when there is nothing
/// to say.
class StudyModeSelectionSheet extends StatelessWidget {
  const StudyModeSelectionSheet({
    super.key,
    required this.onModeSelected,
    this.cards = const <Flashcard>[],
  });

  final ValueChanged<StudyMode> onModeSelected;

  /// The deck's cards, used for the per-mode chips. Optional: without them the
  /// sheet still works, it just has nothing to report.
  final List<Flashcard> cards;

  static Future<void> show(
    BuildContext context, {
    required ValueChanged<StudyMode> onModeSelected,
    List<Flashcard> cards = const <Flashcard>[],
  }) {
    return GlobalBlurredBottomSheet.show(
      context,
      child: StudyModeSelectionSheet(
        onModeSelected: onModeSelected,
        cards: cards,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color accent = AppTheme.accentOf(context);
    final Color gold = isDark ? Colors.amber.shade700 : const Color(0xFFD4AF37);
    final Color ink = isDark ? Colors.white : const Color(0xFF1A1A1B);
    final Color muted = isDark ? Colors.white60 : const Color(0xFF6B655B);

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.8,
      ),
      child: ListView(
        key: const ValueKey<String>('study-mode-sheet'),
        shrinkWrap: true,
        padding: const EdgeInsets.only(bottom: 24),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 2, 24, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  l10n.howWouldYouLikeToStudy,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: ink,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.practiceModes,
                  style: TextStyle(fontSize: 12.5, color: muted, height: 1.35),
                ),
              ],
            ),
          ),
          Container(height: 1, color: gold.withValues(alpha: 0.3)),
          const SizedBox(height: 14),
          for (final StudyMode mode in StudyMode.values)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
              child: _buildModeRow(
                context: context,
                mode: mode,
                l10n: l10n,
                isDark: isDark,
                accent: accent,
                gold: gold,
                ink: ink,
                muted: muted,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildModeRow({
    required BuildContext context,
    required StudyMode mode,
    required AppLocalizations l10n,
    required bool isDark,
    required Color accent,
    required Color gold,
    required Color ink,
    required Color muted,
  }) {
    final _ModeStats stats = _modeStats(mode);

    return Material(
      color: AppTheme.cardBgOf(context),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        key: ValueKey<String>('study-mode-${mode.name}'),
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          HapticsManager.selection();
          Navigator.of(context).pop();
          onModeSelected(mode);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: gold.withValues(alpha: 0.3)),
          ),
          padding: const EdgeInsets.fromLTRB(12, 12, 14, 12),
          child: Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(_modeIcon(mode), size: 20, color: accent),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _modeLabel(mode, l10n),
                      style: TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w600,
                        color: ink,
                        height: 1.25,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      _modeDescription(mode, l10n),
                      style: TextStyle(
                        fontSize: 12.5,
                        color: muted,
                        height: 1.35,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (stats.hasSomethingToSay) ...<Widget>[
                      const SizedBox(height: 7),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: <Widget>[
                          if (stats.due > 0)
                            _buildChip(
                              '${stats.due} · ${l10n.dueNow}',
                              accent,
                              isDark,
                            ),
                          if (stats.attempts > 0)
                            _buildChip(
                              '${l10n.accuracy} ${stats.accuracyPercent}%',
                              _retentionTone(stats.accuracyPercent, isDark),
                              isDark,
                            ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.play_arrow_rounded, size: 20, color: accent),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String label, Color color, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: isDark ? 0.16 : 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10.5,
          fontWeight: FontWeight.w600,
          color: color,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  /// Jade Green for solid recall, gold for shaky, Cinnabar alert for weak — the
  /// same reading as the deck's statistics tab.
  Color _retentionTone(int percent, bool isDark) {
    if (percent >= 80) return const Color(0xFF2E7D32);
    if (percent >= 60) {
      return isDark ? Colors.amber.shade700 : const Color(0xFFD4AF37);
    }
    return isDark ? Colors.redAccent : const Color(0xFFC62828);
  }

  /// What the deck says about this mode: how many cards are due in it now, and
  /// how the learner has done in it so far.
  _ModeStats _modeStats(StudyMode mode) {
    int due = 0;
    int attempts = 0;
    int successes = 0;
    for (final Flashcard card in cards) {
      final ReviewStats stats = card.getStatsForMode(mode);
      if (stats.attempts == 0) continue;
      attempts += stats.attempts;
      successes += stats.successCount;
      if (stats.isDue) due++;
    }
    return _ModeStats(due: due, attempts: attempts, successes: successes);
  }

  String _modeLabel(StudyMode mode, AppLocalizations l10n) {
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

  String _modeDescription(StudyMode mode, AppLocalizations l10n) {
    switch (mode) {
      case StudyMode.calligraphy:
        return l10n.practiceStrokeOrderWithVisualGuides;
      case StudyMode.reading:
        return l10n.seeTheCharacterRecallThePinyinAndMe;
      case StudyMode.recall:
        return l10n.seeTheMeaningDrawTheCharacterFromMe;
      case StudyMode.speaking:
        return l10n.readOutLoudToTestYourPronunciationT;
      case StudyMode.listening:
        return l10n.listenToTheAudioAndIdentifyTheChara;
    }
  }

  /// The same icons the statistics tab uses for the same five modes.
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

class _ModeStats {
  const _ModeStats({
    required this.due,
    required this.attempts,
    required this.successes,
  });

  final int due;
  final int attempts;
  final int successes;

  bool get hasSomethingToSay => due > 0 || attempts > 0;

  int get accuracyPercent =>
      attempts == 0 ? 0 : (successes / attempts * 100).round();
}
