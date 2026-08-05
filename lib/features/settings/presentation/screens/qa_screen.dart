import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QAScreen extends ConsumerWidget {
  const QAScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    // Zen & Ink Mandate Colors
    final bgColor = isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0);
    final textColor = isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B);
    final cardColor = isDark ? const Color(0xFF2A2A2B) : Colors.white;
    final accentColor = isDark ? Colors.blueGrey.shade300 : Colors.blueGrey.shade700;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(
          "Knowledge Base",
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: textColor),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        physics: const BouncingScrollPhysics(),
        children: [
          _buildHeader(textColor, accentColor),
          const SizedBox(height: 32),
          
          _buildCategory(
            title: "Privacy & Audio",
            icon: Icons.security_outlined,
            cardColor: cardColor,
            textColor: textColor,
            accentColor: accentColor,
            items: [
              _FaqItem(
                question: "Do you keep or store my voice recordings?",
                answer: "No. When you use Echo Hall, Scholar's Verdict, or Shadowing Studio, your audio is securely evaluated in real-time to generate a pronunciation score and then immediately discarded. We only store your numerical ratings to track your progress.",
              ),
              _FaqItem(
                question: "What happens to my chat history?",
                answer: "Your Echo Hall conversations are stored locally on your device so you can review them anytime. We do not use your personal conversations to train our AI models.",
              ),
            ],
          ),
          
          _buildCategory(
            title: "Speaking & Pronunciation",
            icon: Icons.mic_none_outlined,
            cardColor: cardColor,
            textColor: textColor,
            accentColor: accentColor,
            items: [
              _FaqItem(
                question: "How is my pronunciation scored?",
                answer: "The AI evaluates your speech across three dimensions:\n• Accuracy: Did you articulate the correct syllables?\n• Completeness: Did you skip or miss any words?\n• Fluency: Did you pause naturally and use the correct tones?\nIt compares your audio against native models to generate a score out of 100.",
              ),
              _FaqItem(
                question: "What if the AI mishears what I meant to say?",
                answer: "If the AI detects a mismatch, it will ask 'Did you mean to say...?'. You can tap the 'Yes, Re-Grade Me!' button to instantly re-evaluate your original audio against your true intention without having to speak again.",
              ),
              _FaqItem(
                question: "What is Shadowing Studio?",
                answer: "Shadowing Studio is a dedicated space to practice mimicking native speakers. You listen to a phrase, record yourself repeating it, and compare the waveforms and pronunciation scores to refine your accent.",
              ),
              _FaqItem(
                question: "Who are the voices speaking in the app?",
                answer: "The voices in AI Stories and Echo Hall are powered by advanced Neural Text-to-Speech models. They are specifically tuned to provide authentic native Chinese accents, appropriate emotional inflection, and natural pacing.",
              ),
            ],
          ),

          _buildCategory(
            title: "Reading & Vocabulary",
            icon: Icons.menu_book_outlined,
            cardColor: cardColor,
            textColor: textColor,
            accentColor: accentColor,
            items: [
              _FaqItem(
                question: "How does the Web Explorer work?",
                answer: "The Web Explorer allows you to browse any Chinese website. When you encounter a difficult word, simply tap it to open the Quick Look card, which provides instant pinyin, translation, and HSK level.",
              ),
              _FaqItem(
                question: "What is Zen Mode?",
                answer: "Zen Mode strips away distracting web elements, ads, and complex layouts from articles, presenting you with a clean, calligraphic reading environment focused purely on the text.",
              ),
              _FaqItem(
                question: "How does the Flashcard spaced-repetition work?",
                answer: "We use an intelligent algorithm that predicts when you are about to forget a word. Words you struggle with will appear more frequently, while words you know well will be scheduled further into the future.",
              ),
            ],
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildHeader(Color textColor, Color accentColor) {
    return Column(
      children: [
        Icon(
          Icons.auto_stories_outlined,
          size: 48,
          color: accentColor.withValues(alpha: 0.5),
        ),
        const SizedBox(height: 16),
        Text(
          "How can we help you?",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: textColor,
            letterSpacing: -0.5,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          "Everything you need to know about Hanzi Master, its features, and your privacy.",
          style: TextStyle(
            fontSize: 14,
            color: textColor.withValues(alpha: 0.6),
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildCategory({
    required String title,
    required IconData icon,
    required Color cardColor,
    required Color textColor,
    required Color accentColor,
    required List<_FaqItem> items,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 12),
            child: Row(
              children: [
                Icon(icon, size: 20, color: accentColor),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: items.asMap().entries.map((entry) {
                final isLast = entry.key == items.length - 1;
                return Column(
                  children: [
                    Theme(
                      data: ThemeData(
                        dividerColor: Colors.transparent,
                        splashColor: accentColor.withValues(alpha: 0.1),
                        highlightColor: accentColor.withValues(alpha: 0.05),
                      ),
                      child: ExpansionTile(
                        tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                        title: Text(
                          entry.value.question,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: textColor.withValues(alpha: 0.9),
                            height: 1.3,
                          ),
                        ),
                        iconColor: accentColor,
                        collapsedIconColor: textColor.withValues(alpha: 0.4),
                        childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.value.answer,
                            style: TextStyle(
                              height: 1.6,
                              fontSize: 14,
                              color: textColor.withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!isLast)
                      Divider(
                        height: 1,
                        indent: 20,
                        endIndent: 20,
                        color: textColor.withValues(alpha: 0.08),
                      ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _FaqItem {
  final String question;
  final String answer;

  _FaqItem({required this.question, required this.answer});
}
