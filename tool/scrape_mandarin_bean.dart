import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

void main() async {
  List<Map<String, dynamic>> stories = [];
  int page = 1;
  
  print('Scraping Mandarin Bean RSS for 150 stories...');

  while (stories.length < 150) {
    final url = page == 1 
        ? 'https://mandarinbean.com/feed/' 
        : 'https://mandarinbean.com/feed/?paged=$page';
        
    print('Fetching page $page: $url');
    
    try {
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 15));
      if (response.statusCode != 200) {
        print('Failed to fetch page $page. Status: ${response.statusCode}');
        break;
      }
      
      final document = XmlDocument.parse(response.body);
      final items = document.findAllElements('item');
      if (items.isEmpty) {
        print('No more items found on page $page.');
        break;
      }
      
      for (final node in items) {
        if (stories.length >= 150) break;
        
        final title = node.findElements('title').firstOrNull?.innerText ?? 'Untitled';
        final link = node.findElements('link').firstOrNull?.innerText ?? '';
        final categories = node.findElements('category').map((e) => e.innerText.toLowerCase()).toList();
        final titleLower = title.toLowerCase();

        // === STRICT CATEGORY FILTER ===
        // Only keep entries that have at least one "story" category.
        // Mandarin Bean uses: reading, contemporary, short stories, beginner/intermediate/advanced
        // It also uses: grammar, vocabulary, exercise, dialogue, hsk preparation, etc.
        final storyCategories = {'reading', 'contemporary', 'short stories', 'advanced', 'intermediate', 'beginner', 'culture', 'history', 'news', 'travel', 'food', 'nature'};
        final blockedCategories = {'grammar', 'vocabulary', 'exercise', 'dialogue', 'hsk preparation', 'jokes', 'lesson', 'academic', 'politics'};

        final hasStoryCategory = categories.any((c) => storyCategories.any((s) => c.contains(s)));
        final hasBlockedCategory = categories.any((c) => blockedCategories.any((b) => c.contains(b)));

        // Also block by title patterns (grammar comparisons like X/Y or X vs Y)
        final isGrammarTitle = RegExp(r'^[^\s]{1,6}/[^\s]{1,6}$').hasMatch(title.trim()) ||
            RegExp(r'\bvs\.?\b', caseSensitive: false).hasMatch(title) ||
            RegExp(r'^\s*[\u4e00-\u9fff]{1,4}\s*\(').hasMatch(title) ||
            titleLower.contains('comprehensive exercise') ||
            titleLower.contains('grammar') ||
            titleLower.contains('tutorial');

        if (hasBlockedCategory || isGrammarTitle) continue;
        // If no category info at all from RSS, apply title-only heuristic
        // (early Mandarin Bean posts had no categories)
        if (!hasStoryCategory && categories.isEmpty) {
          // Allow through — title heuristic above already filtered bad ones
        } else if (!hasStoryCategory) {
          continue; // Has categories but none are story-type — skip
        }
        
        String summary = '';
        String? imageUrl;
        
        final descNode = node.findElements('description').firstOrNull;
        if (descNode != null) {
          final content = descNode.innerText;
          summary = content.replaceAll(RegExp(r'<[^>]*>'), '').trim();
          if (summary.length > 150) {
            summary = '${summary.substring(0, 147)}...';
          }
        }
        
        final contentNode = node.findElements('content:encoded').firstOrNull;
        if (contentNode != null) {
          final htmlContent = contentNode.innerText;
          final imgRegex = RegExp(r'<img[^>]+src="([^">]+)"');
          final match = imgRegex.firstMatch(htmlContent);
          if (match != null) {
            imageUrl = match.group(1);
          }
          
          // Extract text from <span class="si">
          final spanRegex = RegExp(r'<span class="si">([^<]+)</span>');
          final spans = spanRegex.allMatches(htmlContent);
          if (spans.isNotEmpty) {
            final extractedText = spans.map((m) => m.group(1)).join('');
            if (extractedText.isNotEmpty) {
              summary = extractedText.trim();
              if (summary.length > 150) {
                summary = '${summary.substring(0, 147)}...';
              }
            }
          }
        }
        
        String mappedCategory = 'Contemporary Stories';
        int hskLevel = 0;
        for (final cat in categories) {
          if (cat.contains('beginner')) hskLevel = 2;
          else if (cat.contains('intermediate')) hskLevel = 4;
          else if (cat.contains('advanced')) hskLevel = 6;
        }
        
        stories.add({
          'title': title,
          'sourceName': 'Mandarin Bean',
          'link': link,
          'imageUrl': imageUrl,
          'summary': summary,
          'category': mappedCategory,
          'rssCategories': categories,
          'sourceType': 'rss',
          'hskLevel': hskLevel,
          'rawText': summary
        });
      }
      
      page++;
    } catch (e) {
      print('Error fetching page $page: $e');
      break;
    }
  }
  
  final outFile = File('assets/data/mandarin_bean_stories.json');
  final encoder = JsonEncoder.withIndent('  ');
  outFile.writeAsStringSync(encoder.convert(stories));
  print('Saved ${stories.length} stories to ${outFile.path}');
}
