import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class StoryBlueprint {
  final String id;
  final String title;
  final String topic;
  final String category;
  final String imageUrl;
  final List<String> tags;

  const StoryBlueprint({
    required this.id,
    required this.title,
    required this.topic,
    required this.category,
    required this.imageUrl,
    required this.tags,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'topic': topic,
      'category': category,
      'imageUrl': imageUrl,
      'tags': tags,
    };
  }
}

// Duplicated from StoryController for the script
const List<StoryBlueprint> defaultBlueprints = [
  // Myths & Legends
  StoryBlueprint(
    id: 'myth_monkey', 
    title: 'The Monkey King', 
    topic: 'Sun Wukong (Journey to the West)', 
    category: 'Myths & Legends',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/Sun_Wukong_and_Jade_Emperor.jpg/800px-Sun_Wukong_and_Jade_Emperor.jpg',
    tags: ['mythology', 'adventure', 'magic', 'animals'],
  ),
  StoryBlueprint(
    id: 'myth_mulan', 
    title: 'Hua Mulan', 
    topic: 'The legend of Hua Mulan joining the army', 
    category: 'Myths & Legends',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c8/Hua_Mulan.jpg/800px-Hua_Mulan.jpg',
    tags: ['mythology', 'history', 'warrior'],
  ),
  StoryBlueprint(
    id: 'myth_nuwa', 
    title: 'Nüwa Mends the Heavens', 
    topic: 'The creation goddess Nüwa repairing the sky', 
    category: 'Myths & Legends',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1a/N%C3%BCwa_Mends_the_Heavens.jpg/800px-N%C3%BCwa_Mends_the_Heavens.jpg',
    tags: ['mythology', 'creation', 'magic'],
  ),

  // History & Culture
  StoryBlueprint(
    id: 'hist_confucius', 
    title: 'Confucius', 
    topic: 'The life and teachings of Confucius', 
    category: 'History & Culture',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/94/Confucius_Tang_Dynasty.jpg/800px-Confucius_Tang_Dynasty.jpg',
    tags: ['history', 'philosophy', 'education'],
  ),
  StoryBlueprint(
    id: 'hist_greatwall', 
    title: 'The Great Wall', 
    topic: 'Building the Great Wall of China', 
    category: 'History & Culture',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/23/The_Great_Wall_of_China_at_Jinshanling-edit.jpg/800px-The_Great_Wall_of_China_at_Jinshanling-edit.jpg',
    tags: ['history', 'architecture', 'travel'],
  ),
  StoryBlueprint(
    id: 'hist_terracotta', 
    title: 'Terracotta Army', 
    topic: 'Emperor Qin Shi Huang and the Terracotta Army', 
    category: 'History & Culture',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/69/Terracotta_Army%2C_Pit_1.jpg/800px-Terracotta_Army%2C_Pit_1.jpg',
    tags: ['history', 'archaeology', 'military'],
  ),
  StoryBlueprint(
    id: 'hist_forbidden', 
    title: 'Forbidden City', 
    topic: 'Life inside the Forbidden City', 
    category: 'History & Culture',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Forbidden_City_Beijing_Shenwumen_Gate.JPG/800px-Forbidden_City_Beijing_Shenwumen_Gate.JPG',
    tags: ['history', 'architecture', 'emperor'],
  ),

  // Idioms (成语)
  StoryBlueprint(
    id: 'idiom_horse', 
    title: 'Sai Weng Lost His Horse', 
    topic: 'A blessing in disguise (塞翁失马, 焉知非福)', 
    category: 'Idioms (成语)',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/74/Zhao_Mengfu-_A_Man_and_His_Horse.jpg/800px-Zhao_Mengfu-_A_Man_and_His_Horse.jpg',
    tags: ['idiom', 'philosophy', 'story'],
  ),
  StoryBlueprint(
    id: 'idiom_snake', 
    title: 'Drawing a Snake', 
    topic: 'Drawing a snake and adding legs (画蛇添足)', 
    category: 'Idioms (成语)',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/91/Snakes_on_a_tree.jpg/800px-Snakes_on_a_tree.jpg',
    tags: ['idiom', 'funny', 'lesson'],
  ),
  StoryBlueprint(
    id: 'idiom_frog', 
    title: 'Frog in the Well', 
    topic: 'The frog in the well knows nothing of the great ocean (井底之蛙)', 
    category: 'Idioms (成语)',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7d/Green_Frog.jpg/800px-Green_Frog.jpg',
    tags: ['idiom', 'animals', 'lesson'],
  ),

  // Daily Life
  StoryBlueprint(
    id: 'life_train', 
    title: 'Taking the Bullet Train', 
    topic: 'Buying a ticket and taking the high speed train in China', 
    category: 'Daily Life',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/77/CR400AF-A-2042_%40_Wuhan_%2820190516140645%29.jpg/800px-CR400AF-A-2042_%40_Wuhan_%2820190516140645%29.jpg',
    tags: ['travel', 'modern', 'transportation', 'practical'],
  ),
  StoryBlueprint(
    id: 'life_doctor', 
    title: 'Visiting the Doctor', 
    topic: 'Going to the hospital for a cold and seeing a doctor', 
    category: 'Daily Life',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b3/Peking_Union_Medical_College_Hospital_-_East_Gate_%2820200827170138%29.jpg/800px-Peking_Union_Medical_College_Hospital_-_East_Gate_%2820200827170138%29.jpg',
    tags: ['health', 'practical', 'modern', 'hospital'],
  ),
  StoryBlueprint(
    id: 'life_food', 
    title: 'Ordering Dumplings', 
    topic: 'Going to a local restaurant to order Jiaozi (dumplings)', 
    category: 'Daily Life',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/80/Jiaozi_at_a_restaurant_in_Beijing.jpg/800px-Jiaozi_at_a_restaurant_in_Beijing.jpg',
    tags: ['food', 'restaurant', 'practical', 'culture'],
  ),

  // Arts & Traditions
  StoryBlueprint(
    id: 'art_tea', 
    title: 'The Tea Ceremony', 
    topic: 'The traditional Gongfu tea ceremony', 
    category: 'Arts & Traditions',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a2/Gongfu_tea_ceremony.jpg/800px-Gongfu_tea_ceremony.jpg',
    tags: ['culture', 'tea', 'tradition', 'relax'],
  ),
  StoryBlueprint(
    id: 'art_calligraphy', 
    title: 'Chinese Calligraphy', 
    topic: 'The art of writing Chinese characters with a brush', 
    category: 'Arts & Traditions',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Chinese_calligraphy_at_the_British_Museum.jpg/800px-Chinese_calligraphy_at_the_British_Museum.jpg',
    tags: ['culture', 'art', 'writing', 'tradition'],
  ),
  StoryBlueprint(
    id: 'art_panda', 
    title: 'The Giant Panda', 
    topic: 'The life and conservation of Giant Pandas', 
    category: 'Arts & Traditions',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0f/Grosser_Panda.JPG/800px-Grosser_Panda.JPG',
    tags: ['animals', 'nature', 'culture', 'cute'],
  ),
  StoryBlueprint(
    id: 'tech_hsr', 
    title: 'High-Speed Rail', 
    topic: 'The incredible network of high-speed trains in China', 
    category: 'Tech & Science',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/CR400AF-A-2042_%40_BJN_%2820180721151610%29.jpg/800px-CR400AF-A-2042_%40_BJN_%2820180721151610%29.jpg',
    tags: ['transportation', 'tech', 'travel', 'modern'],
  ),
  StoryBlueprint(
    id: 'biz_ecommerce', 
    title: 'E-Commerce Boom', 
    topic: 'Online shopping, Taobao, and the delivery network', 
    category: 'Business & Economy',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ad/Alibaba_Group_logo.svg/800px-Alibaba_Group_logo.svg.png',
    tags: ['business', 'shopping', 'internet', 'economy'],
  ),
  StoryBlueprint(
    id: 'culture_cny', 
    title: 'Chinese New Year', 
    topic: 'Traditions, red envelopes, and family reunions during the Spring Festival', 
    category: 'Culture & Traditions',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/77/Chinese_New_Year_decorations_in_Hong_Kong.jpg/800px-Chinese_New_Year_decorations_in_Hong_Kong.jpg',
    tags: ['festival', 'family', 'tradition', 'holiday'],
  ),
  StoryBlueprint(
    id: 'culture_kungfu', 
    title: 'Martial Arts', 
    topic: 'The philosophy and practice of Chinese Kung Fu and Tai Chi', 
    category: 'Culture & Traditions',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cd/Taijiquan_in_the_park.jpg/800px-Taijiquan_in_the_park.jpg',
    tags: ['sports', 'health', 'culture', 'martial arts'],
  ),
  StoryBlueprint(
    id: 'hist_silkroad', 
    title: 'The Silk Road', 
    topic: 'The ancient trade routes that connected China with the West', 
    category: 'History',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1d/Silk_route.jpg/800px-Silk_route.jpg',
    tags: ['history', 'trade', 'geography', 'ancient'],
  ),
  StoryBlueprint(
    id: 'contemp_smartphone', 
    title: 'Smartphone Life', 
    topic: 'How smartphones have changed daily life in modern cities', 
    category: 'Contemporary Stories',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d3/People_using_smartphones_in_subway.jpg/800px-People_using_smartphones_in_subway.jpg',
    tags: ['technology', 'modern', 'society', 'internet'],
  ),
  StoryBlueprint(
    id: 'tech_mobilepay', 
    title: 'Mobile Payments', 
    topic: 'The rise of WeChat Pay and Alipay creating a cashless society', 
    category: 'Tech & Science',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/68/WeChat_Pay_and_Alipay.jpg/800px-WeChat_Pay_and_Alipay.jpg',
    tags: ['money', 'tech', 'convenience', 'business'],
  ),
  StoryBlueprint(
    id: 'contemp_gaokao', 
    title: 'The Gaokao Exam', 
    topic: 'The pressure and preparation for China\'s national college entrance exam', 
    category: 'Contemporary Stories',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/61/Gaokao_candidates_in_China.jpg/800px-Gaokao_candidates_in_China.jpg',
    tags: ['education', 'school', 'youth', 'society'],
  ),
  StoryBlueprint(
    id: 'art_cinema', 
    title: 'Modern Cinema', 
    topic: 'The evolution of the Chinese film industry and going to the movies', 
    category: 'Arts & Traditions',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c2/Cinema_seating.jpg/800px-Cinema_seating.jpg',
    tags: ['movies', 'entertainment', 'art', 'culture'],
  ),
];

Future<Map<String, dynamic>> _callGemini(String topic, String category, int hskLevel, String apiKey) async {
  final prompt = '''
You are a professional Chinese language professor creating Graded Readers.
Write an engaging, culturally accurate story or article about "$topic" (Category: $category).
CRITICAL: You MUST restrict your vocabulary entirely to the HSK $hskLevel word list. Keep it under 400 words.

Respond ONLY in valid JSON format with this exact structure:
{
  "sentences": [
    {
      "chinese": "The full sentence in Chinese...",
      "english": "The English translation of the sentence...",
      "words": [
        {
           "hanzi": "The word or character in Chinese",
           "pinyin": "The pinyin for this specific word",
           "meaning": "The contextual meaning of this word in this specific sentence"
        }
      ]
    }
  ]
}

Make sure every single character in the 'chinese' sentence is represented in the 'words' array in order! If a word is multiple characters, group them into one object.
''';

  final url = Uri.parse('https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$apiKey');
  
  for (int attempt = 1; attempt <= 3; attempt++) {
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {'text': prompt}
              ]
            }
          ],
          'generationConfig': {
             'responseMimeType': 'application/json',
          }
        }),
      ).timeout(const Duration(seconds: 120));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final contentStr = data['candidates'][0]['content']['parts'][0]['text'] as String;
        String rawJson = contentStr.trim();
        if (rawJson.startsWith('```json')) {
          rawJson = rawJson.substring(7);
        }
        if (rawJson.startsWith('```')) {
          rawJson = rawJson.substring(3);
        }
        if (rawJson.endsWith('```')) {
          rawJson = rawJson.substring(0, rawJson.length - 3);
        }
        return jsonDecode(rawJson) as Map<String, dynamic>;
      } else {
        throw Exception('Failed to call API: ${response.body}');
      }
    } catch (e) {
      if (attempt == 3) rethrow;
      print('Retrying after error: $e');
      await Future.delayed(Duration(seconds: 5 * attempt));
    }
  }
  throw Exception('Max retries reached');
}

void main() async {
  final apiKey = Platform.environment['GEMINI_API_KEY'] ?? 'YOUR_GEMINI_KEY';
  if (apiKey.isEmpty || apiKey == 'YOUR_GEMINI_KEY') {
    print('Please provide a GEMINI_API_KEY environment variable.');
    exit(1);
  }

  final Map<String, dynamic> db = {};

  for (final blueprint in defaultBlueprints) {
    for (int hskLevel = 1; hskLevel <= 6; hskLevel++) {
      final storyId = '${blueprint.id}_hsk$hskLevel';
      print('Generating $storyId...');
      
      try {
        final result = await _callGemini(blueprint.topic, blueprint.category, hskLevel, apiKey);
        
        final newStoryJson = {
          'id': storyId,
          'title': blueprint.title,
          'category': blueprint.category,
          'hskLevel': hskLevel,
          'imageUrl': blueprint.imageUrl,
          'sentences': result['sentences'],
          'generatedAt': DateTime.now().toIso8601String(),
        };
        
        db[storyId] = newStoryJson;
        print('Successfully generated $storyId');
        await Future.delayed(const Duration(seconds: 1));
      } catch (e) {
        print('Error generating $storyId: $e');
      }
    }
  }

  final outFile = File('assets/data/150_graded_readers.json');
  const encoder = JsonEncoder.withIndent('  ');
  outFile.writeAsStringSync(encoder.convert(db));
  print('Saved ${db.length} stories to assets/data/150_graded_readers.json');
}
