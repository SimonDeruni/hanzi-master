import 'dart:convert';
import 'dart:io';

void main() {
  final file = File('assets/data/hsk1_hanzivg.json');
  final jsonStr = file.readAsStringSync();
  final data = json.decode(jsonStr) as Map<String, dynamic>;
  final firstKey = data.keys.first;
  print("First char: $firstKey");
  print("Keys for this char: ${data[firstKey].keys}");
  print("Paths length: ${(data[firstKey]['paths'] as List).length}");
  if (data[firstKey].containsKey('medians')) {
    print("Medians length: ${(data[firstKey]['medians'] as List).length}");
  } else {
    print("NO MEDIANS KEY!");
  }
}
