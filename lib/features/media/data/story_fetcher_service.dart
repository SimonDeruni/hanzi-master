import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import 'package:hanzi_master/features/media/domain/models/library_story.dart';
import 'package:html/parser.dart' show parse;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final storyFetcherServiceProvider = Provider((ref) => StoryFetcherService());

class StoryFetcherService {
  
  // Option A: RSS Feeds
  Future<List<LibraryStory>> fetchRssFeed(String url, String sourceName) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final document = XmlDocument.parse(response.body);
        final items = document.findAllElements('item');
        
        return items.map((node) {
          final title = node.findElements('title').firstOrNull?.innerText ?? 'Untitled';
          final link = node.findElements('link').firstOrNull?.innerText ?? '';
          
          // Parse description, strip HTML tags for summary
          String summary = '';
          String? imageUrl;
          
          // Helper to find element by local name regardless of namespace
          XmlElement? findLocal(String name) {
            return node.descendants.whereType<XmlElement>().where((e) => e.name.local == name).firstOrNull;
          }
          
          final descNode = node.findElements('description').firstOrNull;
          final contentNode = findLocal('encoded');
          
          if (descNode != null) {
            final doc = parse(descNode.innerText);
            summary = doc.body?.text ?? '';
            summary = summary.replaceAll(RegExp(r'\s+'), ' ').trim();
            if (summary.length > 150) summary = '${summary.substring(0, 150)}...';
            
            // Try image from description
            imageUrl ??= doc.querySelector('img')?.attributes['src'];
          }
          
          if (contentNode != null && imageUrl == null) {
            final doc = parse(contentNode.innerText);
            imageUrl ??= doc.querySelector('img')?.attributes['src'];
          }
          
          // Fallback to enclosure or media:content
          if (imageUrl == null) {
             final enclosure = node.findElements('enclosure').firstOrNull;
             if (enclosure != null && enclosure.getAttribute('type')?.startsWith('image/') == true) {
                 imageUrl = enclosure.getAttribute('url');
             }
          }
          if (imageUrl == null) {
             final media = findLocal('content'); // media:content
             if (media != null && media.getAttribute('medium') == 'image') {
                 imageUrl = media.getAttribute('url');
             }
          }
          
          return LibraryStory(
            title: title,
            sourceName: sourceName,
            link: link,
            imageUrl: imageUrl,
            summary: summary,
            sourceType: StorySourceType.rss,
          );
        }).toList();
      }
    } catch (e) {
      print('Error fetching RSS from $url: $e');
    }
    return [];
  }

  // Fetch all Option A sources
  Future<List<LibraryStory>> fetchAllRssSources() async {
    final mandarinBean = await fetchRssFeed('https://mandarinbean.com/feed/', 'Mandarin Bean');
    final chineseReading = await fetchRssFeed('https://chinesereadingpractice.com/feed/', 'Chinese Reading Practice');
    
    return [...mandarinBean, ...chineseReading];
  }

  // Option B: Public Domain JSON
  // We'll mock this for now to show the hybrid capability, but it could fetch from GitHub
  Future<List<LibraryStory>> fetchPublicDomainClassics() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      LibraryStory(
        title: "西游记 (Journey to the West - Excerpt)",
        sourceName: "Classical Texts",
        link: "json://journey_to_the_west",
        summary: "The legendary mythological tale of Sun Wukong, the Monkey King.",
        sourceType: StorySourceType.json,
      ),
      LibraryStory(
        title: "木兰辞 (The Ballad of Mulan)",
        sourceName: "Classical Texts",
        link: "json://ballad_of_mulan",
        summary: "The famous Northern Dynasties folk song about a girl who takes her father's place in the army.",
        sourceType: StorySourceType.json,
      ),
    ];
  }
}
