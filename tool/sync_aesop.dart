import 'dart:convert';
import 'dart:io';

void main() {
  final srcFile = File('assets/data/books/aesop_fables.json');
  if (!srcFile.existsSync()) return;

  final content = srcFile.readAsStringSync();
  final List<dynamic> chapters = jsonDecode(content);

  for (final ch in chapters) {
    ch['bookId'] = 'aesops_fables';
    ch['id'] = (ch['id'] as String).replaceAll('aesop_fables', 'aesops_fables');
  }

  final targetFile = File('assets/data/books/aesops_fables.json');
  targetFile.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(chapters));
  print('✅ Synced aesop_fables -> aesops_fables (${targetFile.lengthSync() ~/ 1024} KB, ${chapters.length} fables)');
}
