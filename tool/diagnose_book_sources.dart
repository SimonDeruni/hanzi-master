import 'dart:convert';
import 'dart:io';

void main() {
  final dir = Directory('assets/data/books');
  final files = dir.listSync().whereType<File>().toList();

  print('Total book files: ${files.length}');
  int authenticCount = 0;
  int templateCount = 0;

  final List<String> templateBooks = [];
  final List<String> authenticBooks = [];

  for (final f in files) {
    try {
      final id = f.uri.pathSegments.last.replaceAll('.json', '');
      final list = jsonDecode(f.readAsStringSync()) as List<dynamic>;
      if (list.isEmpty) continue;

      final firstCh = list.first as Map<String, dynamic>;
      final sentences = firstCh['sentences'] as List<dynamic>? ?? [];
      final firstSentence = sentences.isNotEmpty ? (sentences.first['chinese'] as String? ?? '') : '';

      // Check if it has template boilerplate
      if (firstSentence.contains('倾尽心血谱写的传世经典') || firstSentence.contains('历经岁月淘洗而愈显光彩') || firstSentence.contains('波澜壮阔中，主角置身于')) {
        templateCount++;
        templateBooks.add(id);
      } else {
        authenticCount++;
        authenticBooks.add('$id (${list.length} ch, ${f.lengthSync() ~/ 1024} KB)');
      }
    } catch (e) {
      print('Error parsing ${f.path}: $e');
    }
  }

  print('\n=== AUTHENTIC FULL-TEXT BOOKS ($authenticCount) ===');
  for (final b in authenticBooks.take(15)) {
    print('  - $b');
  }
  if (authenticBooks.length > 15) print('  ... and ${authenticBooks.length - 15} more');

  print('\n=== TEMPLATE / CROPPED BOOKS ($templateCount) ===');
  for (final b in templateBooks.take(15)) {
    print('  - $b');
  }
  if (templateBooks.length > 15) print('  ... and ${templateBooks.length - 15} more');
}
