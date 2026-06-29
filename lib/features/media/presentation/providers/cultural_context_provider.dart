import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';

part 'cultural_context_provider.g.dart';

@riverpod
class CulturalContext extends _$CulturalContext {
  @override
  Future<String> build(String mediaTitle) async {
    final geminiService = ref.watch(geminiServiceProvider);
    
    final prompt = '''
You are a Chinese cultural expert and language educator. 
The user is about to watch a video or read an article with the following title and summary:
Title: "$mediaTitle"

Your task is to provide a fascinating cultural explanation that relates DIRECTLY to the specific topic of this article/video. It should take about 2 minutes to read (around 250-400 words).

CRITICAL RULES: 
1. Do not give a generic explanation. You MUST connect the specific subject matter of "$mediaTitle" to Chinese culture, history, linguistic quirks, or societal context.
2. If the topic is an international event (like US politics or European sports), focus on the Chinese perspective of THAT EXACT event (e.g., the specific Chinese vocabulary used for it, or historical Chinese parallels).
3. Format your response in Markdown, using nice headers and bullet points where appropriate. Include Pinyin for any Chinese words you use. Make it highly engaging and educational.
''';

    return await geminiService.generateText(prompt);
  }
}
