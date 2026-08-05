import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import 'package:html/parser.dart' show parse;

void main() async {
  print('=== Mandarin Bean Story Downloader ===\n');

  final stories = <Map<String, dynamic>>[];
  final imgDir = Directory('assets/images/mandarin_bean');
  if (!await imgDir.exists()) await imgDir.create(recursive: true);

  int page = 1;
  int failedPages = 0;

  while (failedPages < 2) {
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
          if (c.contains('hsk1')) {
            hskLevel = 1;
          } else if (c.contains('hsk2')) hskLevel = 2;
          else if (c.contains('hsk3')) hskLevel = 3;
          else if (c.contains('hsk4')) hskLevel = 4;
          else if (c.contains('hsk5')) hskLevel = 5;
          else if (c.contains('hsk6')) hskLevel = 6;
        }

        // Determine theme
        final fullText = ('$title $summary ${categories.join(' ')}').toLowerCase();
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

        // Fetch og:image from story page
        String? imageUrl;
        String? localImagePath;
        try {
          final pageResp = await http.get(Uri.parse(link),
              headers: {'User-Agent': 'Mozilla/5.0'});
          if (pageResp.statusCode == 200) {
            final doc = parse(pageResp.body);
            imageUrl = doc.querySelector('meta[property="og:image"]')?.attributes['content'];
            imageUrl ??= doc.querySelector('meta[name="twitter:image"]')?.attributes['content'];
          }
        } catch (_) {}

        // Download image locally
        if (imageUrl != null && imageUrl.isNotEmpty) {
          try {
            final slug = Uri.parse(link).pathSegments.where((s) => s.isNotEmpty).last;
            final ext = imageUrl.split('.').last.split('?').first;
            final filename = '${slug.replaceAll(RegExp(r'[^a-z0-9_-]'), '_')}.$ext';
            final imgFile = File('assets/images/mandarin_bean/$filename');
            if (!await imgFile.exists()) {
              final imgResp = await http.get(Uri.parse(imageUrl));
              if (imgResp.statusCode == 200) {
                await imgFile.writeAsBytes(imgResp.bodyBytes);
                localImagePath = 'assets/images/mandarin_bean/$filename';
                print('  ✓ Image saved: $filename');
              }
            } else {
              localImagePath = 'assets/images/mandarin_bean/$filename';
            }
          } catch (_) {}
        }

        stories.add({
          'title': title,
          'sourceName': 'Mandarin Bean',
          'link': link,
          'summary': summary,
          'category': theme,
          'hskLevel': hskLevel,
          'imageUrl': imageUrl,
          'localImagePath': localImagePath,
        });

        print('  ✓ Story: $title (HSK $hskLevel, $theme)');
      }

      print('  -> Page $page done. Total stories: ${stories.length}\n');
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

  // Save to JSON
  final jsonFile = File('assets/data/mandarin_bean_stories.json');
  await jsonFile.writeAsString(json.encode(stories));
  print('\n=== DONE! ===');
  print('Saved ${stories.length} stories to assets/data/mandarin_bean_stories.json');
  print('Images saved to assets/images/mandarin_bean/');
}
