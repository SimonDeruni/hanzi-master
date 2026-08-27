import 'dart:convert';
import 'dart:io';

void main() {
  final dir = Directory('assets/data/books');
  final files = dir.listSync().whereType<File>().toList();

  final stats = <Map<String, dynamic>>[];
  for (final f in files) {
    try {
      final list = jsonDecode(f.readAsStringSync()) as List<dynamic>;
      final chCount = list.length;
      int sentCount = 0;
      for (final c in list) {
        final sents = (c as Map<String, dynamic>)['sentences'] as List<dynamic>? ?? [];
        sentCount += sents.length;
      }
      stats.add({
        'id': f.uri.pathSegments.last.replaceAll('.json', ''),
        'chapters': chCount,
        'sentences': sentCount,
        'avg': sentCount / (chCount == 0 ? 1 : chCount),
      });
    } catch (_) {}
  }

  stats.sort((a, b) => (b['sentences'] as int).compareTo(a['sentences'] as int));

  print('=== TOP 15 LARGEST BOOKS ===');
  for (final s in stats.take(15)) {
    print('  ${s['id'].toString().padRight(30)}: ${s['chapters']} chapters, ${s['sentences']} sentences (avg ${s['avg'].toStringAsFixed(1)}/ch)');
  }

  print('\n=== BOTTOM 15 SMALLEST BOOKS ===');
  for (final s in stats.reversed.take(15)) {
    print('  ${s['id'].toString().padRight(30)}: ${s['chapters']} chapters, ${s['sentences']} sentences (avg ${s['avg'].toStringAsFixed(1)}/ch)');
  }
}
