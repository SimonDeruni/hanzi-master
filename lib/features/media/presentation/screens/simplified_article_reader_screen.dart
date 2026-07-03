import 'package:flutter/material.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/shared/widgets/quick_look_sheet.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/word_detail_dialog.dart';

class SimplifiedArticleReaderScreen extends StatefulWidget {
  final AiStory story;

  const SimplifiedArticleReaderScreen({super.key, required this.story});

  @override
  State<SimplifiedArticleReaderScreen> createState() => _SimplifiedArticleReaderScreenState();
}

class _SimplifiedArticleReaderScreenState extends State<SimplifiedArticleReaderScreen> {
  bool _showPinyin = false;
  bool _showTranslation = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Simplified Article", style: TextStyle(fontFamily: 'Serif', fontWeight: FontWeight.bold, color: Colors.black87)),
        backgroundColor: const Color(0xFFFDFCF0),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        actions: [
          IconButton(
            icon: Icon(
              Icons.sort_by_alpha,
              color: _showPinyin ? Colors.blue : Colors.grey,
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
              color: _showTranslation ? Colors.purple : Colors.grey,
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
      backgroundColor: const Color(0xFFFDFCF0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              Text(
                                word.hanzi,
                                style: const TextStyle(
                                  fontSize: 24,
                                  height: 1.2,
                                  fontFamily: 'Serif',
                                ),
                              ),
                              if (_showTranslation)
                                Text(
                                  word.meaning,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.blueGrey,
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
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
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
