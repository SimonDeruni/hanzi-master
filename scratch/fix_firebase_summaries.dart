import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

void main() async {
  print('=== Fixing Mandarin Bean Summaries ===\n');

  final projectId = 'hanzi-master-bcef9';
  final collectionUrl = 'https://firestore.googleapis.com/v1/projects/$projectId/databases/(default)/documents/mandarin_bean_stories';

  // 1. Delete all existing documents to prevent duplicates
  print('Fetching existing documents to delete...');
  String? nextPageToken;
  int deletedCount = 0;
  do {
    final url = nextPageToken == null ? collectionUrl : '$collectionUrl?pageToken=$nextPageToken';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      print('Failed to fetch documents: ${response.body}');
      break;
    }
    final data = json.decode(response.body);
    final documents = data['documents'] as List<dynamic>? ?? [];
    
    for (var doc in documents) {
      final docName = doc['name'] as String;
      final delRes = await http.delete(Uri.parse('https://firestore.googleapis.com/v1/$docName'));
      if (delRes.statusCode == 200) deletedCount++;
    }
    nextPageToken = data['nextPageToken'];
  } while (nextPageToken != null);
  
  print('Deleted $deletedCount old documents.');

  // 2. Re-upload with proper summaries
  print('\nStarting clean upload...');
  int page = 1;
  int failedPages = 0;
  int uploaded = 0;
  int failedUploads = 0;

  while (failedPages < 2 && uploaded < 200) {
    final url = page == 1
        ? 'https://mandarinbean.com/feed/'
        : 'https://mandarinbean.com/feed/?paged=$page';

    print('Fetching page $page...');
    try {
      final response = await http.get(Uri.parse(url),
          headers: {'User-Agent': 'Mozilla/5.0'});

      if (response.statusCode != 200) {
        failedPages++;
        page++;
        continue;
      }

      final document = XmlDocument.parse(response.body);
      final items = document.findAllElements('item').toList();

      if (items.isEmpty) {
        break;
      }

      for (final item in items) {
        final title = item.findElements('title').firstOrNull?.innerText ?? 'Untitled';
        final link = item.findElements('link').firstOrNull?.innerText ?? '';
        final categories = item.findElements('category').map((e) => e.innerText).toList();
        final categoriesLower = categories.map((c) => c.toLowerCase()).toList();

        if (categoriesLower.contains('news')) continue;
        if (categoriesLower.contains('jokes')) continue;

        // NEW: Parse summary from content:encoded
        String summary = '';
        final contentNode = item.findElements('content:encoded').firstOrNull;
        if (contentNode != null) {
          final pMatch = RegExp(r'<p(>|\s[^>]*>)(.*?)</p>', dotAll: true).firstMatch(contentNode.innerText);
          if (pMatch != null) {
             // remove HTML tags, then remove multiple spaces
             summary = pMatch.group(2)!.replaceAll(RegExp(r'<[^>]*>'), '').replaceAll(RegExp(r'\s+'), ' ').trim();
          }
        }
        
        // Filter out junk
        if (summary.contains('[&#8230;]')) {
          summary = summary.replaceAll('[&#8230;]', '...').trim();
        }

        // Determine HSK level
        int hskLevel = 0;
        for (final cat in categories) {
          final c = cat.toLowerCase().replaceAll(' ', '');
          if (c.contains('hsk1')) hskLevel = 1;
          else if (c.contains('hsk2')) hskLevel = 2;
          else if (c.contains('hsk3')) hskLevel = 3;
          else if (c.contains('hsk4')) hskLevel = 4;
          else if (c.contains('hsk5')) hskLevel = 5;
          else if (c.contains('hsk6')) hskLevel = 6;
        }

        // Determine theme
        final fullText = (title + ' ' + summary + ' ' + categories.join(' ')).toLowerCase();
        String theme = 'Contemporary Stories';
        if (fullText.contains('food') || fullText.contains('dumpling') || fullText.contains('eat') || fullText.contains('recipe') || fullText.contains('restaurant')) {
          theme = 'Food & Dining';
        } else if (fullText.contains('history') || fullText.contains('dynasty') || fullText.contains('emperor') || fullText.contains('ancient')) {
          theme = 'History';
        } else if (fullText.contains('travel') || fullText.contains('city') || fullText.contains('mountain') || fullText.contains('gorges')) {
          theme = 'Travel & Places';
        } else if (fullText.contains('myth') || fullText.contains('legend') || fullText.contains('dragon') || fullText.contains('fairy') || fullText.contains('magic')) {
          theme = 'Mythology & Fantasy';
        } else if (fullText.contains('culture') || fullText.contains('festival') || fullText.contains('tradition') || fullText.contains('confucius')) {
          theme = 'Culture & Traditions';
        } else if (fullText.contains('nature') || fullText.contains('animal') || fullText.contains('weather')) {
          theme = 'Nature & Animals';
        } else if (fullText.contains('science') || fullText.contains('technology') || fullText.contains('ai') || fullText.contains('robot')) {
          theme = 'Science & Tech';
        } else if (fullText.contains('business') || fullText.contains('economy') || fullText.contains('money')) {
          theme = 'Business & Economy';
        }

        final payload = {
          'fields': {
            'title': {'stringValue': title},
            'sourceName': {'stringValue': 'Mandarin Bean'},
            'link': {'stringValue': link},
            'summary': {'stringValue': summary},
            'category': {'stringValue': theme},
            'hskLevel': {'integerValue': hskLevel},
            'sourceType': {'stringValue': 'json'}, // Update this as well!
          }
        };

        try {
          final fireResp = await http.post(
            Uri.parse(collectionUrl),
            headers: {'Content-Type': 'application/json'},
            body: json.encode(payload),
          );

          if (fireResp.statusCode == 200 || fireResp.statusCode == 201) {
            uploaded++;
          } else {
            failedUploads++;
            if (failedUploads > 5) return;
          }
        } catch (e) {
            failedUploads++;
        }
      }

      print('  -> Page $page done. Total uploaded so far: $uploaded');
      failedPages = 0;
      page++;
      await Future.delayed(const Duration(milliseconds: 500));
    } catch (e) {
      failedPages++;
      page++;
    }
  }

  print('\n=== DONE! ===');
  print('Uploaded $uploaded stories with FIXED summaries.');
}
