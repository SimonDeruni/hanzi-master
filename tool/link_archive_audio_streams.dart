import 'dart:convert';
import 'dart:io';

void main() async {
  print('=== Linking Archive.org Audio Streams to Grand Library Catalog ===');

  final Map<String, String> archiveAudioMap = {
    'journey_to_the_west': 'https://archive.org/download/a7zerwneey84c2wgt9cbbwig5nb5rxshbznp48ys/nuxkocf0qevgk2i-2697257640844528134_hd.mp3',
    'romance_of_three_kingdoms': 'https://archive.org/download/w73c9plhpwnxbrnuiirr35904vgtrtcmiyvvlfst/pc5yjok3qzmkwfv-2686884444420524038_ud.mp3',
    'tang_poetry_300': 'https://archive.org/download/tangpoems4_1207_librivox/tangpoems4_01_various_64kb.mp3',
    'the_art_of_war': 'https://archive.org/download/art_of_war_librivox/art_of_war_01-02_sun_tzu_64kb.mp3',
    'the_analects': 'https://archive.org/download/analects_confucius_1303_librivox/analects_01_confucius_64kb.mp3',
    'dream_of_red_chamber': 'https://archive.org/download/dream_red_chamber_1_1603_librivox/dreamoftheredchamber1_01_cao_64kb.mp3',
  };

  final catalogFile = File('assets/data/grand_library_catalog.json');
  final List<dynamic> list = jsonDecode(catalogFile.readAsStringSync());

  for (final item in list) {
    final book = item as Map<String, dynamic>;
    final id = book['id'] as String;
    if (archiveAudioMap.containsKey(id)) {
      book['audioStreamUrl'] = archiveAudioMap[id];
      print('Linked Archive.org audio to book: $id');
    }
  }

  catalogFile.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(list));
  print('=== Catalog updated with Archive.org open audio streams! ===');
}
