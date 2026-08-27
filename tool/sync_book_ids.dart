import 'dart:convert';
import 'dart:io';

void syncBook(String sourceId, String targetId) {
  final srcFile = File('assets/data/books/$sourceId.json');
  if (!srcFile.existsSync()) return;

  final content = srcFile.readAsStringSync();
  final List<dynamic> chapters = jsonDecode(content);

  for (final ch in chapters) {
    ch['bookId'] = targetId;
    ch['id'] = (ch['id'] as String).replaceAll(sourceId, targetId);
  }

  final targetFile = File('assets/data/books/$targetId.json');
  targetFile.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(chapters));
  print('✅ Synced $sourceId -> $targetId (${targetFile.lengthSync() ~/ 1024} KB, ${chapters.length} chapters)');
}

void main() {
  syncBook('the_adventures_of_sherlock_holmes', 'sherlock_holmes');
  syncBook('the_call_of_the_wild', 'call_of_the_wild');
}
