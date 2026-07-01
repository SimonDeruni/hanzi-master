import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import 'package:hanzi_master/features/media/domain/models/library_story.dart';
import 'dart:convert';
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
        
        final rawStories = items.map((node) {
          final title = node.findElements('title').firstOrNull?.innerText ?? 'Untitled';
          final link = node.findElements('link').firstOrNull?.innerText ?? '';
          
          final categories = node.findElements('category').map((e) => e.innerText.toLowerCase()).toList();
          final titleLower = title.toLowerCase();
          
          if (categories.contains('news') || titleLower.startsWith('news:')) return null;
          if (categories.contains('jokes') || titleLower.startsWith('joke:') || titleLower.startsWith('jokes:')) return null;
          if (categories.contains('academic / science') || categories.contains('politics & communism')) return null;
          
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
        }).whereType<LibraryStory>().toList();

        // If imageUrl is still null, fetch the actual page and look for og:image
        final futures = rawStories.map((story) async {
          if (story.imageUrl == null && story.link.isNotEmpty) {
            try {
              final pageResp = await http.get(Uri.parse(story.link));
              if (pageResp.statusCode == 200) {
                final doc = parse(pageResp.body);
                // Try OpenGraph image
                String? img = doc.querySelector('meta[property="og:image"]')?.attributes['content'];
                // Try twitter:image
                img ??= doc.querySelector('meta[name="twitter:image"]')?.attributes['content'];
                // Try first image in content
                img ??= doc.querySelector('article img')?.attributes['src'];
                img ??= doc.querySelector('.entry-content img')?.attributes['src'];
                
                if (img != null && img.isNotEmpty) {
                  return story.copyWith(imageUrl: img);
                }
              }
            } catch (_) {}
          }
          return story;
        });
        
        return Future.wait(futures);
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
    try {
      final String response = await rootBundle.loadString('assets/data/stories/index.json');
      final List<dynamic> data = jsonDecode(response);
      return data.map((json) {
        return LibraryStory(
          title: json['title'] ?? 'Untitled',
          sourceName: json['sourceName'] ?? 'Unknown',
          link: json['link'] ?? '',
          imageUrl: json['imageUrl'],
          summary: json['summary'] ?? '',
          sourceType: StorySourceType.json,
        );
      }).toList();
    } catch (e) {
      print('Error fetching public domain classics: $e');
      return [];
    }
  }
}
