import 'package:flutter/material.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/shared/widgets/quick_look_sheet.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

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
  String? _quickLookSelectedWordKey;

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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0);
    final textColor = isDark ? Colors.white : Colors.black87;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.simplifiedArticle,
            style: TextStyle(
                fontFamily: AppLocalizations.of(context)!.serif,
                fontWeight: FontWeight.bold,
                color: textColor)),
        backgroundColor: bg,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
        actions: [
          IconButton(
            icon: Icon(
              Icons.sort_by_alpha,
              color: _showPinyin
                  ? Colors.blue
                  : (isDark ? Colors.white54 : Colors.grey),
            ),
            tooltip: AppLocalizations.of(context)!.togglePinyin,
            onPressed: () {
              setState(() {
                _showPinyin = !_showPinyin;
              });
            },
          ),
          IconButton(
            icon: Icon(
              Icons.translate,
              color: _showTranslation
                  ? Colors.purple
                  : (isDark ? Colors.white54 : Colors.grey),
            ),
            tooltip: AppLocalizations.of(context)!.toggleTranslation,
            onPressed: () {
              setState(() {
                _showTranslation = !_showTranslation;
              });
            },
          ),
        ],
      ),
      backgroundColor: bg,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_hasTraditional)
              Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.orange.shade900.withValues(alpha: 0.3)
                      : Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.warning_amber_rounded,
                        color: Colors.orange),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context)!.thisArticleCharacters,
                        style: TextStyle(
                            color: isDark
                                ? Colors.orange.shade200
                                : Colors.orange.shade900,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ...widget.story.sentences.asMap().entries.map((sEntry) {
              final sIdx = sEntry.key;
              final sentence = sEntry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 4.0,
                      runSpacing: 12.0,
                      children: sentence.words.asMap().entries.map((wEntry) {
                        final wIdx = wEntry.key;
                        final word = wEntry.value;
                        final wordKey = '${sIdx}_${wIdx}_${word.hanzi}';
                        final isSelected = _quickLookSelectedWordKey == wordKey;
                        bool hasChineseChars =
                            RegExp(r'[\u4e00-\u9fa5]').hasMatch(word.hanzi);
                        bool hasChinesePunc =
                            RegExp(r'[\u3000-\u303f\uff00-\uffef]')
                                .hasMatch(word.hanzi);
                        bool isChineseStyle = hasChineseChars || hasChinesePunc;

                        // Avoid duplicating text if the parser blindly copied English into all fields
                        bool isValidPinyin =
                            word.pinyin.isNotEmpty && word.pinyin != word.hanzi;
                        bool isValidMeaning = word.meaning.isNotEmpty &&
                            word.meaning != word.hanzi;

                        bool showWordPinyin =
                            _showPinyin && hasChineseChars && isValidPinyin;
                        bool showWordMeaning = _showTranslation &&
                            hasChineseChars &&
                            isValidMeaning;

                        return GestureDetector(
                          onTapDown: (details) async {
                            setState(() {
                              _quickLookSelectedWordKey = wordKey;
                            });
                            await showQuickLook(
                              context,
                              word.hanzi,
                              contextText: sentence.chinese,
                              presentation: QuickLookPresentation.readingPopover,
                              anchorPosition: details.globalPosition,
                              onDismiss: () {
                                if (mounted) {
                                  setState(() {
                                    if (_quickLookSelectedWordKey == wordKey) {
                                      _quickLookSelectedWordKey = null;
                                    }
                                  });
                                }
                              },
                            );
                            if (mounted) {
                              setState(() {
                                if (_quickLookSelectedWordKey == wordKey) {
                                  _quickLookSelectedWordKey = null;
                                }
                              });
                            }
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 3, vertical: 2),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF4F46E5)
                                      .withValues(alpha: 0.18)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (showWordPinyin)
                                  Text(
                                    word.pinyin,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color:
                                          isDark ? Colors.white54 : Colors.grey,
                                    ),
                                  ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: isChineseStyle ? 0 : 8.0),
                                  child: Text(
                                    word.hanzi,
                                    style: TextStyle(
                                      fontSize: isChineseStyle ? 24 : 16,
                                      height: 1.2,
                                      fontFamily: isChineseStyle
                                          ? AppLocalizations.of(context)!.serif
                                          : null,
                                      color: isSelected
                                          ? const Color(0xFF4F46E5)
                                          : textColor,
                                    ),
                                  ),
                                ),
                                if (showWordMeaning)
                                  Text(
                                    word.meaning,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: isDark
                                          ? Colors.blue.shade200
                                          : Colors.blueGrey,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    if (_showTranslation) ...[
                      const SizedBox(height: 8),
                      Text(
                        sentence.english,
                        style: TextStyle(
                          fontSize: 16,
                          color: textColor,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ]
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
