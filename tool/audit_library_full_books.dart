import 'dart:convert';
import 'dart:io';

void main() {
  print('=== Auditing All Books in Hanzi Master Library ===');

  final catalogFile = File('assets/data/grand_library_catalog.json');
  final List<dynamic> catalog = jsonDecode(catalogFile.readAsStringSync());

  final dir = Directory('assets/data/books');
  final List<Map<String, dynamic>> fullBooks = [];
  final List<Map<String, dynamic>> partialBooks = [];

  for (final item in catalog) {
    final book = item as Map<String, dynamic>;
    final id = book['id'] as String;
    final title = book['title'] as String;
    final titleEn = book['titleEn'] as String;
    final author = book['author'] as String;
    final category = book['category'] as String;

    final file = File('assets/data/books/$id.json');
    if (!file.existsSync()) {
      partialBooks.add({
        'id': id,
        'title': title,
        'titleEn': titleEn,
        'author': author,
        'category': category,
        'sizeKB': 0,
        'chapters': 0,
        'sentences': 0,
        'status': 'MISSING_FILE',
      });
      continue;
    }

    try {
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      int totalSentences = 0;
      for (final ch in list) {
        final sList = (ch as Map<String, dynamic>)['sentences'] as List<dynamic>? ?? [];
        totalSentences += sList.length;
      }
      final sizeKB = file.lengthSync() ~/ 1024;

      // Criteria for Full Unabridged Text:
      // Real unabridged books have either large size (>100KB), high chapter count (>20 chapters with real text), or many total sentences (>100).
      // Short / partial books typically have 2-15 chapters with only 5-7 sentences each (<60KB).
      final isFullUnabridged = sizeKB >= 100 || totalSentences >= 200 || (id == 'the_little_prince' && list.length == 27) || (id == 'thirty_six_stratagems' && list.length == 36);

      final bookInfo = {
        'id': id,
        'title': title,
        'titleEn': titleEn,
        'author': author,
        'category': category,
        'sizeKB': sizeKB,
        'chapters': list.length,
        'sentences': totalSentences,
      };

      if (isFullUnabridged) {
        fullBooks.add(bookInfo);
      } else {
        partialBooks.add(bookInfo);
      }
    } catch (e) {
      print('Error parsing $id: $e');
    }
  }

  print('\n======================================================');
  print('📊 TOTAL LIBRARY AUDIT SUMMARY');
  print('======================================================');
  print('Total Catalog Books: ${catalog.length}');
  print('🟢 Full Unabridged Books: ${fullBooks.length}');
  print('🔴 Partial / Short / Summary Books: ${partialBooks.length}');

  print('\n------------------------------------------------------');
  print('🟢 LIST OF FULL UNABRIDGED BOOKS (${fullBooks.length}):');
  print('------------------------------------------------------');
  for (final b in fullBooks) {
    print('• ${b['title']} (${b['titleEn']}) | ${b['author']} | ${b['chapters']} ch | ${b['sentences']} sentences | ${b['sizeKB']} KB');
  }

  print('\n------------------------------------------------------');
  print('🔴 LIST OF PARTIAL / SUMMARY BOOKS (${partialBooks.length}) [BY CATEGORY]:');
  print('------------------------------------------------------');

  final Map<String, List<Map<String, dynamic>>> byCategory = {};
  for (final b in partialBooks) {
    final cat = b['category'] as String;
    byCategory.putIfAbsent(cat, () => []).add(b);
  }

  for (final cat in byCategory.keys) {
    print('\n[Category: $cat (${byCategory[cat]!.length} books)]');
    for (final b in byCategory[cat]!) {
      print('  - ${b['title']} (${b['titleEn']}) | ${b['author']} | ${b['chapters']} ch | ${b['sentences']} sentences | ${b['sizeKB']} KB');
    }
  }

  // Save audit report to JSON
  final reportFile = File('tool/audit_library_report.json');
  reportFile.writeAsStringSync(const JsonEncoder.withIndent('  ').convert({
    'total': catalog.length,
    'fullCount': fullBooks.length,
    'partialCount': partialBooks.length,
    'fullBooks': fullBooks,
    'partialBooks': partialBooks,
  }));
  print('\nSaved detailed JSON report to tool/audit_library_report.json');
}
