import 'dart:convert';
import 'dart:io';

void main() {
  final catalogFile = File('assets/data/grand_library_catalog.json');
  final list = jsonDecode(catalogFile.readAsStringSync()) as List<dynamic>;
  print('Total books in catalog: ${list.length}');

  final booksDir = Directory('assets/data/books');
  final existingFiles = booksDir.listSync().whereType<File>().map((f) => f.uri.pathSegments.last).toSet();
  print('Existing files in assets/data/books: ${existingFiles.length}');

  final missing = <Map<String, dynamic>>[];
  for (final item in list) {
    final book = item as Map<String, dynamic>;
    final id = book['id'] as String;
    if (!existingFiles.contains('$id.json')) {
      missing.add(book);
    }
  }

  print('Missing books to generate/download: ${missing.length}');
  final categories = <String, int>{};
  for (final m in missing) {
    final cat = m['category'] as String? ?? 'Unknown';
    categories[cat] = (categories[cat] ?? 0) + 1;
  }
  print('Missing by category: $categories');
}
