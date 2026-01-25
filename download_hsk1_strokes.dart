// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<void> main() async {
  // Official HSK1 character list
  final hsk1Chars = [
    '一', '二', '三', '四', '五', '六', '七', '八', '九', '十',
    '百', '千', '万', '上', '下', '大', '小', '口', '中', '国',
    '人', '个', '他', '们', '好', '爸', '妈', '爱', '学', '生',
    '书', '米', '饭', '北', '京', '水', '火', '木', '金', '土',
    '气', '女', '山', '石', '田', '色', '眼', '耳', '手', '足',
    '身', '心', '肉', '新', '老', '少', '多', '来', '去', '到',
    '出', '进', '和', '是', '有', '没', '很', '高', '低', '长',
    '短', '快', '慢', '早', '晚', '冷', '热', '开', '失', '望',
    '工', '作', '班', '朋', '友', '兄', '弟', '姐', '妹', '父',
    '母', '儿', '女', '先', '太', '第', '喜', '欢', '对', '不',
    '谢', '请', '起', '再', '见', '同', '意', '名', '字', '叫',
    '姓', '今', '年', '点', '钟', '分', '刻', '半', '左', '右',
    '前', '后', '里', '外', '天', '月', '日', '星', '期', '周',
    '号', '现', '在', '时', '候', '昨', '明', '早', '上', '午',
    '下', '晚', '中', '本', '次', '第', '期', '间', '完', '成'
  ];

  final uniqueChars = <String>{...hsk1Chars}.toList()..sort();
  
  print('Downloading REAL Hanzi Writer stroke data for ${uniqueChars.length} HSK1 characters...\n');
  
  final strokeData = <String, dynamic>{};
  int success = 0;
  int failed = 0;
  final failedChars = <String>[];

  for (int i = 0; i < uniqueChars.length; i++) {
    final char = uniqueChars[i];
    try {
      // Fetch from Hanzi Writer CDN
      final url = 'https://cdn.jsdelivr.net/npm/hanzi-writer-data@2.0/$char.json';
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 8));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        if (data['strokes'] is List && (data['strokes'] as List).isNotEmpty) {
          final strokes = (data['strokes'] as List).cast<String>();
          strokeData[char] = strokes;
          success++;
          stdout.write('✓');
        } else {
          failed++;
          failedChars.add(char);
          stdout.write('✗');
        }
      } else {
        failed++;
        failedChars.add(char);
        stdout.write('-');
      }
    } catch (e) {
      failed++;
      failedChars.add(char);
      stdout.write('!');
    }
    
    if ((i + 1) % 50 == 0) {
      print('\n[${i + 1}/${uniqueChars.length}] Progress: $success succeeded, $failed failed');
    }
    
    // Rate limiting - be nice to the server
    await Future.delayed(const Duration(milliseconds: 100));
  }
  
  print('\n\n✅ Download complete!');
  print('   Success: $success characters');
  print('   Failed: $failed characters');
  
  if (failedChars.isNotEmpty) {
    print('   Failed chars: ${failedChars.join(", ") }');
  }
  
  // Save to file
  final jsonStr = jsonEncode(strokeData);
  final file = File('assets/data/hsk1_strokes.json');
  file.writeAsStringSync(jsonStr);
  
  print('\n✅ Saved ${strokeData.length} characters to assets/data/hsk1_strokes.json');
  print('   File size: ${file.lengthSync()} bytes');
}