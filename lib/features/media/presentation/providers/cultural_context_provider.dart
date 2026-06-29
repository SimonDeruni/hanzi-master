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
The user is about to watch a video or read an article titled: '\$mediaTitle'.

Provide a fascinating cultural explanation that takes about 2 minutes to read (around 250-400 words).
CRITICAL RULE: The explanation MUST focus deeply on Chinese culture, history, linguistic quirks, or societal context. 
If the topic is international (like US politics or European sports), explain how Chinese media covers it, or the interesting history of the Chinese vocabulary used to describe it.

Format your response in Markdown, using nice headers and bullet points where appropriate. Include Pinyin for any Chinese words you use. Make it highly engaging and educational.
''';

    return await geminiService.generateText(prompt);
  }
}
