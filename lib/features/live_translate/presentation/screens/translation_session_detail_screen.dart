import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/live_translate/domain/entities/translation_session.dart';
import 'package:hanzi_master/shared/widgets/tappable_hanzi_text.dart';

class TranslationSessionDetailScreen extends ConsumerStatefulWidget {
  final TranslationSession session;

  const TranslationSessionDetailScreen({super.key, required this.session});

  @override
  ConsumerState<TranslationSessionDetailScreen> createState() => _TranslationSessionDetailScreenState();
}

class _TranslationSessionDetailScreenState extends ConsumerState<TranslationSessionDetailScreen> {
  final Map<int, String> _breakdowns = {};
  final Map<int, bool> _isLoading = {};

  Future<void> _fetchBreakdown(int index, String sentence) async {
    setState(() {
      _isLoading[index] = true;
    });

    try {
      final gemini = ref.read(geminiServiceProvider);
      
      final prompt = '''
Analyze this Mandarin sentence grammatically and return a JSON array where each element is an object with:
- "word": the Chinese word
- "pinyin": the pinyin
- "english": the English meaning
- "grammar_role": its grammatical role in the sentence

Return strictly ONLY valid JSON, no markdown formatting.

Sentence: "$sentence"
''';

      final response = await gemini.makeOpenRouterCall(
        model: 'google/gemini-2.5-flash',
        messages: [{'role': 'user', 'content': prompt}],
      );

      final cleanJson = response.replaceAll('```json', '').replaceAll('```', '').trim();
      final parsed = jsonDecode(cleanJson) as List<dynamic>;

      // Format it nicely
      final buffer = StringBuffer();
      for (var item in parsed) {
        buffer.writeln("• ${item['word']} (${item['pinyin']}): ${item['english']} - *${item['grammar_role']}*");
      }

      setState(() {
        _breakdowns[index] = buffer.toString().trim();
      });
    } catch (e) {
      setState(() {
        _breakdowns[index] = "Error generating breakdown: $e";
      });
    } finally {
      setState(() {
        _isLoading[index] = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Session Details"),
      ),
      body: CalligraphyBackground(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: widget.session.messages.length,
          itemBuilder: (context, index) {
            final msg = widget.session.messages[index];
            final isMandarin = !msg.isUser; 

            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              color: msg.isUser ? Colors.white : Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          msg.isUser ? Icons.person : Icons.record_voice_over,
                          color: msg.isUser ? Colors.grey : Colors.blueAccent,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          msg.isUser ? "You" : "Partner",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Text(
                          "${msg.timestamp.hour}:${msg.timestamp.minute.toString().padLeft(2, '0')}",
                          style: const TextStyle(color: Colors.black54, fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    
                    if (isMandarin)
                      TappableMarkdownHanziText(
                        msg.text,
                        style: const TextStyle(fontSize: 22, color: Colors.black87),
                      )
                    else
                      Text(
                        msg.text,
                        style: const TextStyle(fontSize: 18, color: Colors.black87),
                      ),

                    if (isMandarin) ...[
                      const Divider(height: 24),
                      if (_isLoading[index] == true)
                        const Center(child: CircularProgressIndicator())
                      else if (_breakdowns.containsKey(index))
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.blue.shade100),
                          ),
                          child: Text(_breakdowns[index]!),
                        )
                      else
                        OutlinedButton.icon(
                          icon: const Icon(Icons.auto_awesome, size: 16),
                          label: const Text("AI Breakdown"),
                          onPressed: () => _fetchBreakdown(index, msg.text),
                        ),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
