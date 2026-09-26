import 'package:flutter/material.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/shared/widgets/quick_look_sheet.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

/// Reads a simplified article as continuous prose.
///
/// Mirrors the Zen reading mode of the in-app browser (a centred, serif,
/// generously spaced column) but renders the *simplified* text instead of the
/// original page, so the output reads like the news page itself rather than a
/// list of word chips.
class SimplifiedArticleReaderScreen extends StatefulWidget {
  final AiStory story;

  const SimplifiedArticleReaderScreen({super.key, required this.story});

  @override
  State<SimplifiedArticleReaderScreen> createState() =>
      _SimplifiedArticleReaderScreenState();
}

class _SimplifiedArticleReaderScreenState
    extends State<SimplifiedArticleReaderScreen> {
  bool _showPinyin = false;
  bool _showTranslation = false;
  String? _selectedWordKey;

  bool get _hasTraditional {
    for (final s in widget.story.sentences) {
      for (final w in s.words) {
        if (ChineseHelper.isTraditionalChinese(w.hanzi)) return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // Same paper/ink pairing as the browser's Zen reading mode.
    final textColor =
        isDark ? const Color(0xFFDADADA) : const Color(0xFF1A1A1B);
    final accent = AppTheme.accentOf(context);

    return Scaffold(
      backgroundColor: AppTheme.surfaceOf(context),
      appBar: AppBar(
        title: Text(
          l10n.simplifiedArticle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        backgroundColor: AppTheme.surfaceOf(context),
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
        actions: [
          IconButton(
            icon: Icon(
              Icons.sort_by_alpha,
              color: _showPinyin
                  ? accent
                  : (isDark ? Colors.white54 : Colors.black38),
            ),
            tooltip: l10n.togglePinyin,
            onPressed: () => setState(() => _showPinyin = !_showPinyin),
          ),
          IconButton(
            icon: Icon(
              Icons.translate,
              color: _showTranslation
                  ? accent
                  : (isDark ? Colors.white54 : Colors.black38),
            ),
            tooltip: l10n.toggleTranslation,
            onPressed: () =>
                setState(() => _showTranslation = !_showTranslation),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          // Matches the browser reading column (max-width: 800px).
          constraints: const BoxConstraints(maxWidth: 800),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_hasTraditional) _buildTraditionalNotice(context, isDark),
                ...widget.story.sentences.asMap().entries.map(
                      (entry) => _buildParagraph(
                          context, entry.key, entry.value, isDark),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTraditionalNotice(BuildContext context, bool isDark) {
    final accent = AppTheme.accentOf(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: accent, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              AppLocalizations.of(context)!.thisArticleCharacters,
              style: TextStyle(
                color: accent,
                fontWeight: FontWeight.w500,
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Renders one sentence as flowing prose.
  ///
  /// Words become inline [WidgetSpan]s so the sentence wraps like a real
  /// paragraph instead of a grid of chips, while every word stays tappable.
  Widget _buildParagraph(
    BuildContext context,
    int sentenceIndex,
    AiSentence sentence,
    bool isDark,
  ) {
    final textColor =
        isDark ? const Color(0xFFDADADA) : const Color(0xFF1A1A1B);
    final accent = AppTheme.accentOf(context);

    final spans = <InlineSpan>[
      // A sentence can arrive without a word breakdown (a repaired or
      // differently-shaped AI answer): render its text rather than letting the
      // paragraph come out blank.
      if (sentence.words.isEmpty) TextSpan(text: sentence.chinese),
    ];
    for (var i = 0; i < sentence.words.length; i++) {
      final word = sentence.words[i];
      final wordKey = '${sentenceIndex}_$i';
      spans.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.baseline,
          baseline: TextBaseline.alphabetic,
          child: _TappableWord(
            word: word,
            isSelected: _selectedWordKey == wordKey,
            isDark: isDark,
            textColor: textColor,
            accent: accent,
            showPinyin: _showPinyin,
            showMeaning: _showTranslation,
            onTap: (position) => _openQuickLook(
              context,
              word: word,
              sentence: sentence.chinese,
              wordKey: wordKey,
              position: position,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // The prose itself: serif, 22px, line-height 1.8 — as in Zen mode.
          Text.rich(
            TextSpan(children: spans),
            style: TextStyle(
              fontSize: 22,
              height: 1.8,
              color: textColor,
            ),
          ),
          if (_showTranslation && sentence.english.trim().isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              sentence.english,
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                fontStyle: FontStyle.italic,
                color: isDark ? Colors.white60 : Colors.black54,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _openQuickLook(
    BuildContext context, {
    required AiWord word,
    required String sentence,
    required String wordKey,
    required Offset position,
  }) async {
    setState(() => _selectedWordKey = wordKey);
    await showQuickLook(
      context,
      word.hanzi,
      contextText: sentence,
      presentation: QuickLookPresentation.readingPopover,
      anchorPosition: position,
      onDismiss: () {
        if (mounted && _selectedWordKey == wordKey) {
          setState(() => _selectedWordKey = null);
        }
      },
    );
    if (mounted && _selectedWordKey == wordKey) {
      setState(() => _selectedWordKey = null);
    }
  }
}

/// A single word inside a paragraph.
///
/// Rendered inline (not as a chip) so the sentence reads as continuous prose,
/// matching the browser's Zen reading mode, while staying tappable for Quick
/// Look. A selected word is marked with an accent underline rather than a
/// background block, which would break the prose flow.
class _TappableWord extends StatelessWidget {
  final AiWord word;
  final bool isSelected;
  final bool isDark;
  final Color textColor;
  final Color accent;
  final bool showPinyin;
  final bool showMeaning;
  final void Function(Offset position) onTap;

  const _TappableWord({
    required this.word,
    required this.isSelected,
    required this.isDark,
    required this.textColor,
    required this.accent,
    required this.showPinyin,
    required this.showMeaning,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasChinese = RegExp(r'[\u4e00-\u9fa5]').hasMatch(word.hanzi);

    // Pinyin and meanings only apply to real Chinese words.
    final isValidPinyin =
        hasChinese && word.pinyin.isNotEmpty && word.pinyin != word.hanzi;
    final isValidMeaning =
        hasChinese && word.meaning.isNotEmpty && word.meaning != word.hanzi;

    return GestureDetector(
      onTapDown: (details) => onTap(details.globalPosition),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showPinyin && isValidPinyin)
            Text(
              PinyinHelper.getPinyinE(word.hanzi,
                  separator: ' ', defPinyin: word.pinyin),
              style: TextStyle(
                fontSize: 11,
                height: 1.2,
                color: isDark ? Colors.white54 : Colors.black45,
              ),
            ),
          Text(
            word.hanzi,
            style: TextStyle(
              fontSize: 22,
              height: 1.35,
              color: isSelected ? accent : textColor,
              decoration: isSelected ? TextDecoration.underline : null,
              decorationColor: accent,
              decorationThickness: 2,
            ),
          ),
          if (showMeaning && isValidMeaning)
            Text(
              word.meaning,
              style: TextStyle(
                fontSize: 10,
                height: 1.2,
                color: accent,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
    );
  }
}
