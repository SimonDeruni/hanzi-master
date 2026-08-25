import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:hanzi_master/features/media/domain/models/library_story.dart';
import 'dart:convert';
import 'package:html/parser.dart' show parse;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final storyFetcherServiceProvider = Provider((ref) => StoryFetcherService());

class StoryFetcherService {
  /// Returns true if this entry looks like a real narrative/article story,
  /// not a grammar tip, dialogue snippet, single-character lesson, or exercise.
  bool _isActualStory(String title, String summary, List<dynamic> rssCategories) {
    final cats = rssCategories.map((c) => c.toString().toLowerCase()).toList();

    // Mandarin Bean RSS category allowlist — only keep real reading content
    // "live in china" = phrasebook dialogues, NOT stories
    const allowedCats = {
      'story', 'culture', 'news', 'advanced', 'lifestyle',
      'business & economics', 'history', 'travel', 'food', 'nature',
    };
    const blockedCats = {
      'grammar', 'vocabulary', 'exercise', 'dialogue',
      'hsk preparation', 'jokes', 'lesson', 'live in china',
    };

    if (cats.isNotEmpty) {
      if (cats.any((c) => blockedCats.any((b) => c.contains(b)))) return false;
      // Must have at least one allowed category
      if (!cats.any((c) => allowedCats.any((a) => c.contains(a)))) return false;
    }

    // Title patterns that always mean non-story regardless of category
    final titleTrim = title.trim();

    // Chinese-char comparison: "真/非常", "是否/如果", "次/遍"
    if (RegExp(r'^[\u4e00-\u9fff\(\)a-zA-ZÀ-ÿ\s\/\u00c0-\u00ff]+$').hasMatch(titleTrim) &&
        titleTrim.contains('/') && titleTrim.length < 40) {
      return false;
    }

    // Single char with pinyin: "与 (yǔ)", "所 (suǒ)"
    if (RegExp(r'^[\u4e00-\u9fff]{1,3}\s*\(').hasMatch(titleTrim)) return false;

    // "X vs Y" comparisons
    if (RegExp(r'\bvs\.?\b', caseSensitive: false).hasMatch(titleTrim) &&
        titleTrim.length < 60) {
      return false;
    }

    final titleLower = title.toLowerCase();
    const blockedWords = [
      'comprehensive exercise', 'grammar', 'tutorial',
      'how to use', 'uses of', 'hsk preparation',
    ];
    if (blockedWords.any((w) => titleLower.contains(w))) return false;

    // Stub with no content
    if (summary.contains('appeared first on Mandarin Bean') && summary.length < 120) return false;

    return true;
  }

  List<String> _extractKeywords(Map<String, dynamic> data) {
    try {
      final Set<String> keywords = {};
      int count = 0;
      if (data['sentences'] != null && data['sentences'] is List) {
        for (var sentence in data['sentences']) {
          if (sentence['words'] != null && sentence['words'] is List) {
            for (var word in sentence['words']) {
              if (count > 15) return keywords.toList();
              
              if (word['meaning'] != null) {
                keywords.add(word['meaning'].toString().toLowerCase());
              }
              if (word['hanzi'] != null) {
                keywords.add(word['hanzi'].toString());
              }
              if (word['pinyin'] != null) {
                keywords.add(word['pinyin'].toString().toLowerCase());
              }
              count++;
            }
          }
        }
      }
      return keywords.toList();
    } catch (_) {
      return <String>[];
    }
  }
  
  // Option A: RSS Feeds
  Future<List<LibraryStory>> fetchRssFeed(String url, String sourceName) async {
    try {
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
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
          
          // Determine thematic category based on keywords
          String theme = 'Contemporary Stories';
          final fullText = ('$title $summary ${categories.join(' ')}').toLowerCase();
          
          if (fullText.contains('food') || fullText.contains('recipe') || fullText.contains('restaurant') || fullText.contains('cooking') || fullText.contains('eat') || fullText.contains('delicious') || fullText.contains('dumpling')) {
            theme = 'Food & Dining';
          } else if (fullText.contains('science') || fullText.contains('space') || fullText.contains('alien') || fullText.contains('robot') || fullText.contains('future') || fullText.contains('technology') || fullText.contains('sci-fi')) {
            theme = 'Science Fiction & Tech';
          } else if (fullText.contains('history') || fullText.contains('dynasty') || fullText.contains('emperor') || fullText.contains('ancient')) {
            theme = 'History';
          } else if (fullText.contains('travel') || fullText.contains('city') || fullText.contains('mountain') || fullText.contains('visit') || fullText.contains('tourist') || fullText.contains('gorges')) {
            theme = 'Travel & Places';
          } else if (fullText.contains('myth') || fullText.contains('legend') || fullText.contains('god') || fullText.contains('fairy') || fullText.contains('magic') || fullText.contains('dragon')) {
            theme = 'Mythology & Fantasy';
          } else if (fullText.contains('culture') || fullText.contains('festival') || fullText.contains('tradition') || fullText.contains('custom') || fullText.contains('confucius')) {
            theme = 'Culture & Traditions';
          } else if (fullText.contains('business') || fullText.contains('economy') || fullText.contains('market') || fullText.contains('money') || fullText.contains('company')) {
            theme = 'Business & Economy';
          } else if (fullText.contains('nature') || fullText.contains('animal') || fullText.contains('weather') || fullText.contains('environment') || fullText.contains('cat') || fullText.contains('dog')) {
            theme = 'Nature & Animals';
          } else if (categories.contains('advanced')) {
            theme = 'Advanced Reading';
          } else if (categories.contains('intermediate')) {
            theme = 'Intermediate Reading';
          } else if (categories.contains('beginner')) {
            theme = 'Beginner Reading';
          }
          
          // Determine HSK Level
          int hskLevel = 0;
          for (final cat in categories) {
            final catLower = cat.toLowerCase().replaceAll(' ', '');
            if (catLower.contains('hsk1')) {
              hskLevel = 1;
            } else if (catLower.contains('hsk2')) {
              hskLevel = 2;
            } else if (catLower.contains('hsk3')) {
              hskLevel = 3;
            } else if (catLower.contains('hsk4')) {
              hskLevel = 4;
            } else if (catLower.contains('hsk5')) {
              hskLevel = 5;
            } else if (catLower.contains('hsk6')) {
              hskLevel = 6;
            }
          }
          if (hskLevel == 0) {
            // Check title as fallback
            final titleLower = title.toLowerCase().replaceAll(' ', '');
            if (titleLower.contains('hsk1')) {
              hskLevel = 1;
            } else if (titleLower.contains('hsk2')) {
              hskLevel = 2;
            } else if (titleLower.contains('hsk3')) {
              hskLevel = 3;
            } else if (titleLower.contains('hsk4')) {
              hskLevel = 4;
            } else if (titleLower.contains('hsk5')) {
              hskLevel = 5;
            } else if (titleLower.contains('hsk6')) {
              hskLevel = 6;
            }
          }

          return LibraryStory(
            title: title,
            sourceName: sourceName,
            link: link,
            imageUrl: imageUrl,
            summary: summary,
            category: theme,
            sourceType: StorySourceType.rss,
            hskLevel: hskLevel,
          );
        }).whereType<LibraryStory>().toList();

        // Return stories immediately WITHOUT waiting for images
        return rawStories;
      }
    } catch (e) {
      debugPrint('Error fetching RSS from $url: $e');
    }
    return [];
  }

  /// Fetch og:image for a batch of stories that are missing images.
  /// Call this AFTER displaying stories to enrich them lazily.
  Future<List<LibraryStory>> enrichWithImages(List<LibraryStory> stories) async {
    final futures = stories.map((story) async {
      if (story.imageUrl == null && story.link.isNotEmpty) {
        try {
          final pageResp = await http.get(Uri.parse(story.link)).timeout(const Duration(seconds: 5));
          if (pageResp.statusCode == 200) {
            final doc = parse(pageResp.body);
            String? img = doc.querySelector('meta[property="og:image"]')?.attributes['content'];
            img ??= doc.querySelector('meta[name="twitter:image"]')?.attributes['content'];
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

  // Fetch all Option A sources — 50 pages of Mandarin Bean in waves to avoid rate limiting
  Future<List<LibraryStory>> fetchAllRssSources() async {
    final allStories = <LibraryStory>[];
    const totalPages = 50;
    const waveSiz = 5; // Send 5 requests at a time

    for (int i = 0; i < totalPages; i += waveSiz) {
      final wave = <Future<List<LibraryStory>>>[];
      for (int j = i; j < (i + waveSiz) && j < totalPages; j++) {
        final page = j + 1;
        final url = page == 1
            ? 'https://mandarinbean.com/feed/'
            : 'https://mandarinbean.com/feed/?paged=$page';
        wave.add(fetchRssFeed(url, 'Mandarin Bean'));
      }
      final results = await Future.wait(wave);
      final batch = results.expand((list) => list).toList();
      // If a wave returns nothing, Mandarin Bean has no more pages — stop early
      if (batch.isEmpty) break;
      allStories.addAll(batch);
    }

    return allStories;
  }

  String _translateAuthor(String author) {
    if (author == 'Unknown' || author == 'Local DB') return author;
    
    // Some hardcoded common ones for better formatting
    const Map<String, String> commonTranslations = {
      '太宗皇帝': 'Emperor Taizong',
      '李隆基': 'Emperor Xuanzong',
    };
    
    if (commonTranslations.containsKey(author)) {
      return '$author (${commonTranslations[author]})';
    }

    try {
      // Use lpinyin to generate proper pinyin for the author's name
      // Example: '李白' -> 'Li Bai'
      String pinyin = PinyinHelper.getPinyinE(author, separator: " ", defPinyin: "", format: PinyinFormat.WITHOUT_TONE);
      if (pinyin.isNotEmpty) {
        // Capitalize each word
        List<String> words = pinyin.split(" ");
        String capitalized = words.map((w) {
          if (w.isEmpty) return "";
          return w[0].toUpperCase() + w.substring(1).toLowerCase();
        }).join(" ");
        return '$author ($capitalized)';
      }
    } catch (e) {
      // Fallback
    }
    
    return author;
  }

  Future<List<LibraryStory>> fetchLocalStories() async {
    final List<LibraryStory> localStories = [];

    try {
      // NOTE: Removed 1000_stories.json loading here as they were just short dictionary citations, 
      // not actual narrative stories. The UI now only shows full stories.

      // Load Mandarin Bean Stories
      String mbJsonString;
      try {
        mbJsonString = await rootBundle.loadString('assets/data/mandarin_bean_stories_en.json');
      } catch (_) {
        mbJsonString = await rootBundle.loadString('assets/data/mandarin_bean_stories.json');
      }
      final List<dynamic> listMb = json.decode(mbJsonString);

      for (var data in listMb) {
        final title = (data['title'] as String?) ?? '';
        final summary = (data['summary'] as String?) ?? '';
        final rssCategories = (data['rssCategories'] as List<dynamic>?) ?? [];

        if (!_isActualStory(title, summary, rssCategories)) continue;

        localStories.add(LibraryStory(
          title: title,
          titleEn: data['title_en'],
          sourceName: data['sourceName'] ?? 'Mandarin Bean',
          link: data['link'] ?? 'mandarin_bean_$title',
          imageUrl: data['imageUrl'],
          summary: summary,
          summaryEn: data['summary_en'],
          category: data['category'] ?? 'Contemporary Stories',
          sourceType: StorySourceType.json,
          hskLevel: data['hskLevel'] ?? 0,
          keywords: _extractKeywords(data),
        ));
      }
    } catch (e) {
      debugPrint("Error loading local stories: $e");
    }

    try {
      // Load Poetry
      String jsonString2;
      try {
        jsonString2 = await rootBundle.loadString('assets/data/tang_poetry_en.json');
      } catch (_) {
        jsonString2 = await rootBundle.loadString('assets/data/tang_poetry.json');
      }
      final List<dynamic> list2 = json.decode(jsonString2);
      localStories.addAll(list2.map((data) {
        final rawAuthor = data['sourceName'] ?? 'Unknown';
        return LibraryStory(
          title: data['title'] ?? '',
          titleEn: data['title_en'],
          sourceName: _translateAuthor(rawAuthor),
          link: data['link'] ?? 'tang_poetry_${data['title']}',
          imageUrl: data['imageUrl'] ?? 'assets/images/ai_hub_ink_mountains.png',
          summary: data['summary'] ?? '',
          summaryEn: data['summary_en'],
          category: data['category'] ?? 'Classical Literature',
          sourceType: StorySourceType.json,
          hskLevel: data['hskLevel'] ?? 0,
          keywords: _extractKeywords(data),
        );
      }));
    } catch (e) {
      debugPrint('Error loading local bundled stories: $e');
    }
    return localStories;
  }

  Future<List<LibraryStory>> fetchFirebaseStories() async {
    final List<LibraryStory> localStories = [];
    
    try {
      // Load Graded Readers (default_stories.json)
      final jsonString = await rootBundle.loadString('assets/default_stories.json');
      final Map<String, dynamic> map = json.decode(jsonString);
      final List<dynamic> list = map.values.map((v) => v is String ? json.decode(v) : v).toList();
      localStories.addAll(list.map((data) {
        return LibraryStory(
          title: data['title'] ?? '',
          sourceName: data['sourceName'] ?? 'Local DB',
          link: data['link'] ?? 'default_story_${data['id']}',
          imageUrl: data['imageUrl'],
          summary: data['summary'] ?? '',
          category: data['category'] ?? 'Graded Reader',
          sourceType: StorySourceType.json,
          hskLevel: data['hskLevel'] ?? 0,
          keywords: _extractKeywords(data),
        );
      }));
    } catch (e) {
      debugPrint("Error loading default_stories: $e");
    }

    try {
      // Load Contemporary Stories (Mandarin Bean)
      String jsonString;
      try {
        jsonString = await rootBundle.loadString('assets/data/mandarin_bean_stories_en.json');
      } catch (_) {
        jsonString = await rootBundle.loadString('assets/data/mandarin_bean_stories.json');
      }
      final List<dynamic> list = json.decode(jsonString);
      localStories.addAll(list.map((data) {
        return LibraryStory(
          title: data['title'] ?? '',
          titleEn: data['title_en'],
          sourceName: data['sourceName'] ?? 'Mandarin Bean',
          link: data['link'] ?? '',
          imageUrl: data['imageUrl'],
          summary: data['summary'] ?? '',
          summaryEn: data['summary_en'],
          category: data['category'] ?? 'Contemporary Stories',
          sourceType: StorySourceType.json,
          hskLevel: data['hskLevel'] ?? 0,
        );
      }));
    } catch (e) {
      debugPrint("Error loading mandarin_bean_stories: $e");
    }

    return localStories;
  }
}
