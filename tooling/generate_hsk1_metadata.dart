// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

/// Script to extract high-quality radical and decomposition metadata for HSK1.
/// Source: Make Me a Hanzi project (Linguistically accurate).
Future<void> main() async {
  final hsk1Chars = [
    '爱', '八', '爸', '杯', '子', '北', '京', '本', '不', '客', '气', '菜', '茶', '吃', '出', '租', '车', '打', '电', '话', '大', '的', '点', '脑', '视', '影', '东', '西', '都', '读', '对', '多', '少', '儿', '二', '饭', '馆', '飞', '机', '分', '钟', '高', '兴', '个', '工', '作', '狗', '汉', '语', '好', '号', '喝', '和', '很', '后', '面', '回', '会', '几', '家', '叫', '今', '天', '九', '开', '看', '见', '块', '来', '老', '师', '了', '冷', '里', '零', '六', '妈', '吗', '买', '猫', '没', '关', '系', '米', '明', '名', '字', '哪', '那', '呢', '能', '你', '年', '女', '朋', '友', '亮', '苹', '果', '七', '钱', '前', '请', '去', '热', '人', '认', '识', '日', '三', '商', '店', '上', '午', '少', '谁', '什', '么', '十', '候', '是', '书', '水', '睡', '觉', '说', '四', '岁', '他', '她', '太', '气', '听', '同', '学', '喂', '我', '们', '五', '喜', '欢', '下', '雨', '先', '生', '现', '在', '想', '小', '姐', '些', '写', '谢', '星', '期', '习', '校', '一', '衣', '服', '医', '院', '椅', '有', '月', '再', '见', '怎', '样', '这', '中', '住', '桌', '坐', '做'
  ];

  final uniqueChars = <String>{...hsk1Chars}.toList()..sort();
  
  print('Building linguistic metadata for ${uniqueChars.length} HSK1 characters...');
  
  // Note: For production, we'd process the full 20MB dictionary.txt.
  // For this HSK1 sprint, I'm fetching the verified radical data for these specific characters.
  final metadata = <String, dynamic>{};
  
  // Official MMH data source
  const dictionaryUrl = 'https://raw.githubusercontent.com/skishore/makemeahanzi/master/dictionary.txt';
  
  try {
    final response = await http.get(Uri.parse(dictionaryUrl));
    if (response.statusCode == 200) {
      final lines = const LineSplitter().convert(response.body);
      
      for (final line in lines) {
        final data = json.decode(line);
        final char = data['character'];
        
        if (uniqueChars.contains(char)) {
          metadata[char] = {
            'radical': data['radical'],
            'decomposition': data['decomposition'],
            'etymology': data['etymology'] != null ? data['etymology']['type'] : 'ideograph',
          };
        }
      }
    }
  } catch (e) {
    print('Error fetching metadata: $e');
    return;
  }

  print('\n✅ Metadata generated for ${metadata.length} characters.');
  
  // Save to file
  final jsonStr = const JsonEncoder.withIndent('  ').convert(metadata);
  final file = File('assets/data/hanzi_metadata.json');
  file.writeAsStringSync(jsonStr);
  
  print('✅ Saved to assets/data/hanzi_metadata.json');
}
