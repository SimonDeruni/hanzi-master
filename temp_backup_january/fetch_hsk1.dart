// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

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
    '母', '儿', '女', '先', '生', '太', '第', '喜', '欢', '对',
    '不', '谢', '请', '起', '再', '见', '同', '意', '名', '字',
    '叫', '姓', '今', '年', '点', '钟', '分', '刻', '半', '左',
    '右', '前', '后', '里', '外', '天', '月', '日', '星', '期',
    '周', '号', '号', '点', '现', '在', '时', '候', '昨', '天',
    '明', '天', '早', '上', '上', '午', '下', '午', '晚', '上',
  ];

  final uniqueChars = <String>{...hsk1Chars}.toList()..sort();
  
  print('Fetching ${uniqueChars.length} HSK1 characters...');
  
  final strokeData = <String, dynamic>{};
  int success = 0;
  int failed = 0;

  for (int i = 0; i < uniqueChars.length; i++) {
    final char = uniqueChars[i];
    try {
      // Fetch from Hanzi Writer CDN
      final url = 'https://cdn.jsdelivr.net/npm/hanzi-writer-data@2.0/$char.json';
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 5));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        if (data['strokes'] is List && (data['strokes'] as List).isNotEmpty) {
          strokeData[char] = data['strokes'];
          success++;
        }
      }
    } catch (e) {
      failed++;
    }
    
    if ((i + 1) % 10 == 0) {
      print('Progress: ${i + 1}/${uniqueChars.length}');
    }
    
    // Rate limiting
    await Future.delayed(const Duration(milliseconds: 50));
  }
  
  print('\nDownload complete: $success/$failed');
  
  // Save to file
  final output = json.encode(strokeData);
  File('assets/data/hsk1_strokes.json').writeAsStringSync(output);
  print('Saved to assets/data/hsk1_strokes.json');
}