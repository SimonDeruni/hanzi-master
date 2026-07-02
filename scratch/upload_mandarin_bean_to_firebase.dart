import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import 'package:html/parser.dart' show parse;

void main() async {
  print('=== Uploading Mandarin Bean to Firebase ===\n');

  final projectId = 'hanzi-master-bcef9';
  final firebaseUrl = 'https://firestore.googleapis.com/v1/projects/$projectId/databases/(default)/documents/mandarin_bean_stories';

  int page = 1;
  int failedPages = 0;
  int uploaded = 0;
  int failedUploads = 0;

  while (failedPages < 2 && uploaded < 200) { // Limit to 200 for now to keep it quick
    final url = page == 1
        ? 'https://mandarinbean.com/feed/'
        : 'https://mandarinbean.com/feed/?paged=$page';

    print('Fetching page $page...');
    try {
      final response = await http.get(Uri.parse(url),
          headers: {'User-Agent': 'Mozilla/5.0'});

      if (response.statusCode != 200) {
        print('  -> Page $page returned ${response.statusCode}, stopping.');
        failedPages++;
        page++;
        continue;
      }

      final document = XmlDocument.parse(response.body);
      final items = document.findAllElements('item').toList();

      if (items.isEmpty) {
        print('  -> No items found on page $page, stopping.');
        break;
      }

      for (final item in items) {
        final title = item.findElements('title').firstOrNull?.innerText ?? 'Untitled';
        final link = item.findElements('link').firstOrNull?.innerText ?? '';
        final categories = item.findElements('category').map((e) => e.innerText).toList();
        final categoriesLower = categories.map((c) => c.toLowerCase()).toList();

        // Skip filtered categories
        if (categoriesLower.contains('news')) continue;
        if (categoriesLower.contains('jokes')) continue;

        // Parse summary from description
        String summary = '';
        final descNode = item.findElements('description').firstOrNull;
        if (descNode != null) {
          final doc = parse(descNode.innerText);
          summary = (doc.body?.text ?? '').replaceAll(RegExp(r'\s+'), ' ').trim();
          if (summary.length > 200) summary = '${summary.substring(0, 200)}...';
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
            'sourceType': {'stringValue': 'firebase'},
          }
        };

        try {
          final fireResp = await http.post(
            Uri.parse(firebaseUrl),
            headers: {'Content-Type': 'application/json'},
            body: json.encode(payload),
          );

          if (fireResp.statusCode == 200 || fireResp.statusCode == 201) {
            uploaded++;
          } else {
            failedUploads++;
            if (failedUploads > 5) {
                print('Too many Firebase upload failures (${fireResp.statusCode}): ${fireResp.body}. Stopping.');
                return;
            }
          }
        } catch (e) {
            failedUploads++;
        }
      }

      print('  -> Page $page done. Total uploaded so far: $uploaded');
      failedPages = 0;
      page++;

      // Small delay to be polite to the server
      await Future.delayed(const Duration(milliseconds: 500));
    } catch (e) {
      print('  -> Error on page $page: $e');
      failedPages++;
      page++;
    }
  }

  print('\n=== DONE! ===');
  print('Uploaded $uploaded stories to mandarin_bean_stories collection.');
}
