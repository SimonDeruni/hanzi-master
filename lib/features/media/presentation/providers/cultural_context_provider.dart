import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';

part 'cultural_context_provider.g.dart';

@Riverpod(keepAlive: true)
class CulturalContext extends _$CulturalContext {
  @override
  Future<String> build(String mediaTitle) async {
    final geminiService = ref.watch(geminiServiceProvider);
    
    final prompt = '''
You are a Chinese cultural expert and language educator. 
The user is about to watch a video or read an article with the following title and summary:
Title: "$mediaTitle"

Your task is to provide a fascinating cultural explanation that relates DIRECTLY to the specific topic of this article/video. It should take about 1 minute to read (around 100-150 words).

CRITICAL RULES: 
1. DO NOT include any introductory conversational filler like "Here is a fascinating cultural explanation". Start immediately with the content.
2. DO NOT use markdown asterisks (* or **) or horizontal rules (---). Use plain text and simple newlines for paragraphs. If you need a list, use a standard bullet symbol (•).
3. DO NOT include any Pinyin at all. Provide only English and Chinese characters.
4. Do not give a generic explanation. You MUST connect the specific subject matter of "$mediaTitle" to Chinese culture, history, linguistic quirks, or societal context.
5. If the topic is an international event, focus on the Chinese perspective of THAT EXACT event (e.g., the specific Chinese vocabulary used for it, or historical Chinese parallels).
''';

    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final todayString = "\${now.year}-\${now.month}-\${now.day}";
    final cacheKeyDate = 'insight_date_\$mediaTitle';
    final cacheKeyData = 'insight_data_\$mediaTitle';

    if (prefs.getString(cacheKeyDate) == todayString) {
      final cached = prefs.getString(cacheKeyData);
      if (cached != null) return cached;
    }

    final result = await geminiService.generateText(prompt);
    await prefs.setString(cacheKeyDate, todayString);
    await prefs.setString(cacheKeyData, result);
    
    return result;
  }
}
