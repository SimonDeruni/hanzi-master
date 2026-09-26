import 'package:flutter/material.dart';

import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/core/utils/pinyin_utils.dart';
import 'package:hanzi_master/features/echo_hall/presentation/widgets/tone_comparison_sheet.dart';
import 'package:hanzi_master/core/services/haptics_manager.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

/// The result of a spoken attempt, at the same depth the live call and the
/// shadowing studio already report.
///
/// The shared grader (`GeminiService.gradeAudio`) answers with more than the
/// deck used to show: an overall score, Azure's accuracy and fluency readings,
/// and — per character — the pinyin, the expected and the heard tone, the word
/// score and the error type. This panel reports all of it in the vocabulary the
/// rest of the app already speaks:
///
///  * **the rating** — the score, its band colour, and the same three readings
///    (`overallScore` / `toneAccuracy` / `fluency`) the live-call verdict
///    averages, so one utterance reads the same wherever it is graded;
///  * **the tone deep analysis** — one tappable row per character naming both
///    syllables (`Expected · nán` against `You said · nà`) and opening
///    [ToneComparisonSheet] for the pitch-contour graph, the per-tone audio and
///    the localized "tone 2 vs tone 4" diagnostic.
///
/// Standalone and public so it can be pumped directly with a canned grader
/// result; the speaking mode just hands it `_feedbackResult`.
class SpeakingFeedbackPanel extends StatelessWidget {
  const SpeakingFeedbackPanel({super.key, required this.result});

  /// The map returned by `GeminiService.gradeAudio`: `score`, `accuracy`,
  /// `completeness`, `fluency` and `words` (each with `word`, `pinyin`,
  /// `expectedTone`, `actualTone`, `wordScore`, `isCorrect`/`isPartial`/
  /// `isOmitted` and `feedback`).
  final Map<String, dynamic> result;

  /// Jade Green — the documented "this landed" colour (see the UI/UX standard).
  static const Color _jade = Color(0xFF2E7D32);

  /// The Cinnabar alert behind a character that did not land.
  static Color _alertColour(bool isDark) =>
      isDark ? Colors.redAccent : const Color(0xFFC62828);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final int score = (result['score'] as num?)?.toInt() ?? 0;
    final List<dynamic> words =
        (result['words'] as List<dynamic>?) ?? const <dynamic>[];

    final Color accent = AppTheme.accentOf(context);
    final Color gold = isDark ? Colors.amber.shade700 : const Color(0xFFD4AF37);
    final Color ink = isDark ? Colors.white : const Color(0xFF1A1A1B);
    final Color muted = isDark ? Colors.white60 : const Color(0xFF6B655B);

    return Container(
      key: const ValueKey<String>('speaking-feedback'),
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBgOf(context),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: gold.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // The rating opens with the same header the live-call verdict uses,
          // so a graded utterance is recognisable in both places.
          Row(
            children: <Widget>[
              Icon(Icons.graphic_eq, size: 16, color: accent),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  l10n.azurePronunciationAssessment,
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: accent,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              Text(
                '$score',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: _scoreTone(score, isDark),
                ),
              ),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  '/100',
                  style: TextStyle(fontSize: 13, color: muted),
                ),
              ),
              const Spacer(),
              Flexible(
                child: Wrap(
                  alignment: WrapAlignment.end,
                  spacing: 6,
                  runSpacing: 6,
                  children: <Widget>[
                    _buildMetricChip(l10n.overallScore, score, isDark),
                    _buildMetricChip(
                      l10n.toneAccuracy,
                      result['accuracy'],
                      isDark,
                    ),
                    _buildMetricChip(l10n.fluency, result['fluency'], isDark),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            _localizedVerdict(score, l10n),
            style: TextStyle(fontSize: 13.5, color: ink, height: 1.35),
          ),
          if (words.isNotEmpty) ...<Widget>[
            const SizedBox(height: 14),
            Divider(height: 1, color: gold.withValues(alpha: 0.2)),
            const SizedBox(height: 12),
            Row(
              children: <Widget>[
                Icon(Icons.equalizer_rounded, size: 16, color: accent),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l10n.toneAccuracy,
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.bold,
                      color: ink,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    l10n.tapToReview,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 10,
                      color: accent.withValues(alpha: 0.75),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            for (final dynamic word in words)
              _buildToneRow(
                context,
                Map<String, dynamic>.from(word as Map<dynamic, dynamic>),
                ink: ink,
                muted: muted,
                gold: gold,
              ),
          ],
        ],
      ),
    );
  }

  /// One character's tone verdict, tappable through to the tone graph.
  Widget _buildToneRow(
    BuildContext context,
    Map<String, dynamic> word, {
    required Color ink,
    required Color muted,
    required Color gold,
  }) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final String hanzi = (word['word'] ?? '').toString();
    final String pinyin = (word['pinyin'] ?? '').toString();
    final String feedback = (word['feedback'] ?? '').toString();
    final int wordScore = (word['wordScore'] as num?)?.toInt() ?? 0;
    final bool isCorrect = word['isCorrect'] == true;
    final bool isPartial = word['isPartial'] == true;
    final bool isOmitted = word['isOmitted'] == true;

    // Azure reports a tone per syllable. When it did not, there is nothing
    // honest to plot, so the row keeps its score and its verdict and drops the
    // comparison rather than inventing a tone the learner never said.
    final int? expectedTone = (word['expectedTone'] as num?)?.toInt();
    final int? actualTone = (word['actualTone'] as num?)?.toInt();
    final bool canCompareTones = !isOmitted &&
        expectedTone != null &&
        actualTone != null &&
        expectedTone > 0 &&
        actualTone > 0;
    final bool matches = canCompareTones && expectedTone == actualTone;

    // Verdicts in the documented palette: Jade for a character that landed,
    // gold for a near miss, Cinnabar for a miss and muted ink for one the
    // grader never heard at all.
    final Color verdictColour = isOmitted
        ? muted
        : isCorrect
            ? _jade
            : isPartial
                ? gold
                : _alertColour(isDark);
    final String verdictLabel = isOmitted
        ? l10n.omitted
        : isCorrect
            ? l10n.correct
            : isPartial
                ? l10n.partial
                : l10n.mispronounced;
    final Color accent = AppTheme.accentOf(context);

    return InkWell(
      key: ValueKey<String>('speaking-tone-$hanzi'),
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        // The graph needs two tones to compare; without them the row is just
        // the score and the verdict.
        if (!canCompareTones) return;
        HapticsManager.light();
        ToneComparisonSheet.show<void>(
          context,
          character: hanzi,
          pinyin: pinyin,
          expectedTone: expectedTone,
          actualTone: actualTone,
          feedback: feedback.isEmpty ? null : feedback,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                  width: 34,
                  child: Text(
                    hanzi,
                    style: TextStyle(
                      fontSize: 21,
                      color: ink,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    pinyin,
                    style: TextStyle(fontSize: 12.5, color: muted),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (wordScore > 0) ...[
                  const SizedBox(width: 4),
                  Text(
                    '$wordScore',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.bold,
                      color: verdictColour,
                    ),
                  ),
                ],
                const SizedBox(width: 4),
                Icon(
                  canCompareTones
                      ? Icons.show_chart_rounded
                      : Icons.remove_rounded,
                  size: 16,
                  color: canCompareTones ? accent : muted,
                ),
              ],
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: <Widget>[
                _buildVerdictPill(verdictLabel, verdictColour, isDark),
                if (canCompareTones) ...[
                  _buildTonePill(
                    context,
                    label: l10n.toneExpected,
                    pinyin: pinyin,
                    tone: expectedTone,
                    fallbackColour: gold,
                  ),
                  _buildTonePill(
                    context,
                    label: l10n.toneYouSaid,
                    pinyin: pinyin,
                    tone: actualTone,
                    fallbackColour: matches ? _jade : _alertColour(isDark),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// A tone pill: the syllable written in the tone the grader heard (or the one
  /// it expected), tinted with the app's canonical tone colour. Showing the
  /// *marked syllable* rather than a bare digit is what makes the comparison
  /// readable — `nán` against `nà`, not "2 against 4".
  Widget _buildTonePill(
    BuildContext context, {
    required String label,
    required String pinyin,
    required int tone,
    required Color fallbackColour,
  }) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final String marked = _syllableInTone(pinyin, tone);
    final Color colour = marked.isEmpty
        ? fallbackColour
        : PinyinUtils.toneColors[tone] ?? fallbackColour;
    // The neutral tone's ink is unreadable on a dark surface.
    final Color textColour =
        isDark && colour == const Color(0xFF1A1A1B) ? Colors.white70 : colour;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: textColour.withValues(alpha: isDark ? 0.16 : 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: textColour.withValues(alpha: 0.3)),
      ),
      child: Text(
        marked.isEmpty ? '$label · $tone' : '$label · $marked',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: textColour,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  /// The same syllable rewritten in [tone] (`nán` + 4 → `nà`), or '' when the
  /// syllable cannot be inflected.
  String _syllableInTone(String pinyin, int tone) {
    if (pinyin.trim().isEmpty) return '';
    return PinyinUtils.getAllTonesForSyllable(pinyin)[tone] ?? '';
  }

  /// The verdict badge the shadowing studio and the live call both print
  /// (`Correct` / `Partial` / `Mispronounced` / `Omitted`), tinted to match.
  Widget _buildVerdictPill(String label, Color colour, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: colour.withValues(alpha: isDark ? 0.16 : 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colour.withValues(alpha: 0.25)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10.5,
          fontWeight: FontWeight.w600,
          color: colour,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  /// A metric pill (`Accuracy 86`), Jade for a strong score down to Cinnabar.
  Widget _buildMetricChip(String label, dynamic value, bool isDark) {
    final int score = (value as num?)?.toInt() ?? 0;
    final Color colour = _scoreTone(score, isDark);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: colour.withValues(alpha: isDark ? 0.16 : 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colour.withValues(alpha: 0.25)),
      ),
      child: Text(
        '$label $score',
        style: TextStyle(
          fontSize: 10.5,
          fontWeight: FontWeight.w600,
          color: colour,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  /// Jade Green for 80+, gold for 60+, Cinnabar below — the same reading as the
  /// deck's statistics tab.
  Color _scoreTone(int score, bool isDark) {
    if (score >= 80) return _jade;
    if (score >= 60) {
      return isDark ? Colors.amber.shade700 : const Color(0xFFD4AF37);
    }
    return isDark ? Colors.redAccent : const Color(0xFFC62828);
  }

  /// The band verdict, from the 14-locale catalogue rather than the English
  /// sentence the grader returns in `overallFeedback`.
  String _localizedVerdict(int score, AppLocalizations l10n) {
    if (score >= 90) return l10n.perfectPronunciationSoundsLikeANati;
    if (score >= 80) return l10n.greatJobAFewMinorToneInaccuracies;
    if (score >= 60) return l10n.notBadButYourTonesNeedSomeWork;
    if (score > 0) return l10n.keepPracticingListenToTheNativeAudi;
    return l10n.goodEffortKeepPracticing;
  }
}
