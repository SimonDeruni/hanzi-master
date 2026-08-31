import 'dart:convert';
import 'dart:io';
void main() {
  final f=json.decode(File('assets/data/l10n/chapter_titles_fr.json').readAsStringSync())as Map<String,dynamic>;
  for(final k in f.keys.toList()..sort()){
    final v=f[k]as String;
    if(v==k)print(k);
  }
}