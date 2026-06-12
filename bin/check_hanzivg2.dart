import 'dart:convert';
import 'dart:io';

void main() {
  final file = File('assets/data/hsk1_hanzivg.json');
  final jsonStr = file.readAsStringSync();
  final data = json.decode(jsonStr) as Map<String, dynamic>;
  final ren = data['人'];
  if (ren != null) {
    print("Ren paths: ${(ren['paths'] as List).length}");
  }
  final h = data['汉'];
  if (h != null) {
      print("Han paths: ${(h['paths'] as List).length}");
  }
}
