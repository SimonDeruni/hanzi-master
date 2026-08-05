import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';

part 'cultural_context_provider.g.dart';

@Riverpod(keepAlive: true)
class CulturalContext extends _$CulturalContext {
  @override
  Future<String> build(String mediaTitle) async {
    // mediaTitle encodes both title and subtitle separated by "|||"
    final parts = mediaTitle.split('|||');
    final title = parts[0];
    final subtitle = parts.length > 1 ? parts[1] : '';
    
    final geminiService = ref.watch(geminiServiceProvider);
    
    final prompt = '''
You are a Chinese cultural expert and language educator. 
The user is about to watch a video or read an article with the following title and subtitle:
Title: "$title"
Subtitle: "$subtitle"

Your task is to provide a fascinating cultural explanation that relates DIRECTLY to the specific topic of this article/video. It should take about 1 minute to read (around 200-300 words).

CRITICAL RULES: 
1. DO NOT include any introductory conversational filler like "Here is a fascinating cultural explanation". Start immediately with the content.
2. ALWAYS structure your response with these mandatory sections, in this exact order:
   - ## Summary (required): A 2-3 sentence summary of what this news piece or video is actually about. What happened? What is the core story?
   - ## Context (include only if warranted): Briefly define any people, concepts, institutions, or culturally specific terms that are CENTRAL to the story AND likely unfamiliar to a non-Chinese reader. Use judgment — define Chinese figures (politicians, celebrities, academics, historical figures), culturally specific concepts (e.g., 两会, 户口, 双十一), or institutions. If it's an interview, explain the significance of the interviewer-interviewee dynamic. Do NOT define globally well-known figures (e.g., Elon Musk, Taylor Swift) or generic terms. Skip this section entirely if nothing needs defining.
   - Then pick 1-2 of: ## The Quote, ## Cultural Context, ## The Setting, ## Key Vocabulary, ## Historical Background — whichever are most relevant to this specific topic.
3. Within each section, use "- " bullet points for key takeaways and facts. Keep paragraphs under 3 sentences.
4. Bold key Chinese terms inline using **汉字** format (e.g., the concept of **得失**). Do NOT use markdown asterisks elsewhere. Do not include Pinyin.
5. Write primarily in English. Include individual Chinese words or short phrases (汉字) only where directly relevant. Do not write full sentences or paragraphs in Chinese.
6. Do not give a generic explanation. You MUST connect the specific subject matter of "$title" to Chinese culture, history, linguistic quirks, or societal context.
7. If the topic is an international event, focus on the Chinese perspective of THAT EXACT event.
''';

    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final todayString = "${now.year}-${now.month}-${now.day}";
    final cacheKeyDate = 'insight_date_$mediaTitle';
    final cacheKeyData = 'insight_data_$mediaTitle';

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
