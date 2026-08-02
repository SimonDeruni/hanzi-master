import 'package:flutter/material.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/shared/widgets/quick_look_sheet.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/word_detail_dialog.dart';
import 'package:lpinyin/lpinyin.dart';

class SimplifiedArticleReaderScreen extends StatefulWidget {
  final AiStory story;

  const SimplifiedArticleReaderScreen({super.key, required this.story});

  @override
  State<SimplifiedArticleReaderScreen> createState() => _SimplifiedArticleReaderScreenState();
}

class _SimplifiedArticleReaderScreenState extends State<SimplifiedArticleReaderScreen> {
  bool _showPinyin = false;
  bool _showTranslation = false;

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
        title: Text("Simplified Article", style: TextStyle(fontFamily: 'Serif', fontWeight: FontWeight.bold, color: textColor)),
        backgroundColor: bg,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
        actions: [
          IconButton(
            icon: Icon(
              Icons.sort_by_alpha,
              color: _showPinyin ? Colors.blue : (isDark ? Colors.white54 : Colors.grey),
            ),
            tooltip: "Toggle Pinyin",
            onPressed: () {
              setState(() {
                _showPinyin = !_showPinyin;
              });
            },
          ),
          IconButton(
            icon: Icon(
              Icons.translate,
              color: _showTranslation ? Colors.purple : (isDark ? Colors.white54 : Colors.grey),
            ),
            tooltip: "Toggle Translation",
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
                  color: isDark ? Colors.orange.shade900.withValues(alpha: 0.3) : Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.warning_amber_rounded, color: Colors.orange),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "This article contains Traditional Chinese characters.",
                        style: TextStyle(
                          color: isDark ? Colors.orange.shade200 : Colors.orange.shade900, 
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ...widget.story.sentences.map((sentence) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 4.0,
                      runSpacing: 12.0,
                      children: sentence.words.map((word) {
                        return GestureDetector(
                          onTap: () => WordDetailDialog.show(context, word, sentence),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (_showPinyin)
                                Text(
                                  word.pinyin,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDark ? Colors.white54 : Colors.grey,
                                  ),
                                ),
                              Text(
                                word.hanzi,
                                style: TextStyle(
                                  fontSize: 24,
                                  height: 1.2,
                                  fontFamily: 'Serif',
                                  color: textColor,
                                ),
                              ),
                              if (_showTranslation)
                                Text(
                                  word.meaning,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: isDark ? Colors.blue.shade200 : Colors.blueGrey,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                            ],
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
            }).toList(),
          ],
        ),
      ),
    );
  }
}
