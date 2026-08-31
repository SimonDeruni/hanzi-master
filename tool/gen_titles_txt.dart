import 'dart:convert';
import 'dart:io';
void main() {
  final f=json.decode(File('assets/data/l10n/chapter_titles_fr.json').readAsStringSync())as Map<String,dynamic>;
  File('tool/all_chapter_titles.txt').writeAsStringSync(f.keys.join('\n'));
}