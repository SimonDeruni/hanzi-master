import 'dart:convert';
import 'dart:io';

void main() {
  print('=== Pruning Partial Books from Grand Library ===\n');

  final auditReportFile = File('tool/audit_library_report.json');
  if (!auditReportFile.existsSync()) {
    print('❌ Audit report not found');
    return;
  }

  final auditData = jsonDecode(auditReportFile.readAsStringSync()) as Map<String, dynamic>;
  final fullBooksList = auditData['fullBooks'] as List<dynamic>;
  final partialBooksList = auditData['partialBooks'] as List<dynamic>;

  final Set<String> fullBookIds = fullBooksList.map((e) => e['id'] as String).toSet();
  final Set<String> partialBookIds = partialBooksList.map((e) => e['id'] as String).toSet();

  print('Total in Audit: ${fullBooksList.length} Full Books, ${partialBooksList.length} Partial Books');

  // 1. Filter grand_library_catalog.json
  final catalogFile = File('assets/data/grand_library_catalog.json');
  final List<dynamic> originalCatalog = jsonDecode(catalogFile.readAsStringSync());

  final List<dynamic> prunedCatalog = originalCatalog.where((book) {
    final id = book['id'] as String;
    return fullBookIds.contains(id);
  }).toList();

  print('\nCatalog Pruning:');
  print('  Original Books: ${originalCatalog.length}');
  print('  Pruned (Full Only) Books: ${prunedCatalog.length}');

  catalogFile.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(prunedCatalog));
  print('✅ Updated assets/data/grand_library_catalog.json');

  // 2. Remove partial book JSON files from assets/data/books/
  int removedFiles = 0;
  for (final partialId in partialBookIds) {
    // If the file exists and is not in fullBookIds, delete it
    if (!fullBookIds.contains(partialId)) {
      final file = File('assets/data/books/$partialId.json');
      if (file.existsSync()) {
        file.deleteSync();
        removedFiles++;
      }
    }
  }

  print('✅ Cleaned up $removedFiles partial book files from assets/data/books/');

  // 3. Print breakdown by category
  final Map<String, int> categoryCounts = {};
  for (final book in prunedCatalog) {
    final cat = book['category'] as String? ?? 'Other';
    categoryCounts[cat] = (categoryCounts[cat] ?? 0) + 1;
  }

  print('\n=== Final Grand Library Catalog Breakdown (${prunedCatalog.length} Full Books) ===');
  for (final entry in categoryCounts.entries) {
    print('  - ${entry.key}: ${entry.value} full-length books');
  }
}
