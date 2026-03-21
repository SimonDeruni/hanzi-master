// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

/// Script to download high-quality centerline data from HanziVG for HSK1 characters.
/// This fixes the "robotic" hints by providing smooth Bezier-based paths.
Future<void> main() async {
  // Official HSK1 character list from assets/data/hsk1.json
  final hsk1Chars = [
    '爱', '八', '爸', '杯', '子', '北', '京', '本', '不', '客', '气', '菜', '茶', '吃', '出', '租', '车', '打', '电', '话', '大', '的', '点', '脑', '视', '影', '东', '西', '都', '读', '对', '多', '少', '儿', '二', '饭', '馆', '飞', '机', '分', '钟', '高', '兴', '个', '工', '作', '狗', '汉', '语', '好', '号', '喝', '和', '很', '后', '面', '回', '会', '几', '家', '叫', '今', '天', '九', '开', '看', '见', '块', '来', '老', '师', '了', '冷', '里', '零', '六', '妈', '吗', '买', '猫', '没', '关', '系', '米', '明', '名', '字', '哪', '那', '呢', '能', '你', '年', '女', '朋', '友', '亮', '苹', '果', '七', '钱', '前', '请', '去', '热', '人', '认', '识', '日', '三', '商', '店', '上', '午', '少', '谁', '什', '么', '十', '候', '是', '书', '水', '睡', '觉', '说', '四', '岁', '他', '她', '太', '气', '听', '同', '学', '喂', '我', '们', '五', '喜', '欢', '下', '雨', '先', '生', '现', '在', '想', '小', '姐', '些', '写', '谢', '星', '期', '习', '校', '一', '衣', '服', '医', '院', '椅', '有', '月', '再', '见', '怎', '样', '这', '中', '住', '桌', '坐', '做'
  ];

  final uniqueChars = <String>{...hsk1Chars}.toList()..sort();
  
  print('Downloading high-quality HanziVG SVG data for ${uniqueChars.length} HSK1 characters...\n');
  
  final hanzivgData = <String, dynamic>{};
  int success = 0;
  int failed = 0;

  for (int i = 0; i < uniqueChars.length; i++) {
    final char = uniqueChars[i];
    final hexCode = char.runes.first.toRadixString(16).padLeft(5, '0');
    
    try {
      // Fetch from HanziVG (Connum's repo)
      final url = 'https://raw.githubusercontent.com/Connum/hanzivg/master/hanzi/$hexCode.svg';
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 5));
      
      if (response.statusCode == 200) {
        final svgContent = response.body;
        
        // Simple regex to extract path 'd' attributes
        // Matches <path ... d="DATA" ... />
        final pathRegex = RegExp(r'<path[^>]*d="([^\"]+)"');
        final matches = pathRegex.allMatches(svgContent);
        
        final paths = matches.map((m) => m.group(1)!).toList();
        
        if (paths.isNotEmpty) {
          hanzivgData[char] = {
            'hex': hexCode,
            'paths': paths,
          };
          success++;
          stdout.write('✓');
        } else {
          failed++;
          stdout.write('✗');
        }
      } else {
        // Fallback to KanjiVG if it's a common character not in HanziVG's specific folder yet
        final kanjiUrl = 'https://raw.githubusercontent.com/Connum/hanzivg/master/kanji/$hexCode.svg';
        final kanjiResponse = await http.get(Uri.parse(kanjiUrl)).timeout(const Duration(seconds: 5));
        
        if (kanjiResponse.statusCode == 200) {
          final svgContent = kanjiResponse.body;
          final pathRegex = RegExp(r'<path[^>]*d="([^\"]+)"');
          final matches = pathRegex.allMatches(svgContent);
          final paths = matches.map((m) => m.group(1)!).toList();
          
          if (paths.isNotEmpty) {
            hanzivgData[char] = {
              'hex': hexCode,
              'paths': paths,
              'source': 'kanjivg'
            };
            success++;
            stdout.write('k'); // k for kanjivg
          } else {
            failed++;
            stdout.write('✗');
          }
        } else {
          failed++;
          stdout.write('-');
        }
      }
    } catch (e) {
      failed++;
      stdout.write('!');
    }
    
    if ((i + 1) % 50 == 0) {
      print('\n[${i + 1}/${uniqueChars.length}] Progress: $success succeeded, $failed failed');
    }
    
    // Slight delay to be nice to GitHub
    await Future.delayed(const Duration(milliseconds: 20));
  }
  
  print('\n\n✅ Audit complete!');
  print('   Success: $success characters (HanziVG/KanjiVG)');
  print('   Failed: $failed characters');
  
  // Save to file
  final jsonStr = jsonEncode(hanzivgData);
  final file = File('assets/data/hsk1_hanzivg.json');
  file.writeAsStringSync(jsonStr);
  
  print('\n✅ Saved new high-quality centerline data to assets/data/hsk1_hanzivg.json');
}
