import 'dart:convert';
import 'dart:io';

void main() async {
  final file = File('assets/data/hanzivg_paths.json');
  final data = json.decode(await file.readAsString());
  print("Count: ${data.length}");
  print("Contains 尔: ${data.containsKey('尔')}");
  print("Contains 和: ${data.containsKey('和')}");
}
