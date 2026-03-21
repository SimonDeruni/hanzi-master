// ignore_for_file: avoid_print

import 'dart:convert';

import 'dart:io';

import 'package:http/http.dart' as http;

 // We'll need a way to parse XML properly

/// Script to download high-quality AnimCJK data for HSK1 characters.
/// This provides BOTH the beautiful outlines AND the single-line skeletons.
Future<void> main() async {
  final hsk1Chars = [
    '爱', '八', '爸', '杯', '子', '北', '京', '本', '不', '客', '气', '菜', '茶', '吃', '出', '租', '车', '打', '电', '话', '大', '的', '点', '脑', '视', '影', '东', '西', '都', '读', '对', '多', '少', '儿', '二', '饭', '馆', '飞', '机', '分', '钟', '高', '兴', '个', '工', '作', '狗', '汉', '语', '好', '号', '喝', '和', '很', '后', '面', '回', '会', '几', '家', '叫', '今', '天', '九', '开', '看', '见', '块', '来', '老', '师', '了', '冷', '里', '零', '六', '妈', '吗', '买', '猫', '没', '关', '系', '米', '明', '名', '字', '哪', '那', '呢', '能', '你', '年', '女', '朋', '友', '亮', '苹', '果', '七', '钱', '前', '请', '去', '热', '人', '认', '识', '日', '三', '商', '店', '上', '午', '少', '谁', '什', '么', '十', '候', '是', '书', '水', '睡', '觉', '说', '四', '岁', '他', '她', '太', '气', '听', '同', '学', '喂', '我', '们', '五', '喜', '欢', '下', '雨', '先', '生', '现', '在', '想', '小', '姐', '些', '写', '谢', '星', '期', '习', '校', '一', '衣', '服', '医', '院', '椅', '有', '月', '再', '见', '怎', '样', '这', '中', '住', '桌', '坐', '做'
  ];

  final uniqueChars = <String>{...hsk1Chars}.toList()..sort();
  
  print('Downloading high-quality AnimCJK data for ${uniqueChars.length} HSK1 characters...\n');
  
  final animcjkData = <String, dynamic>{};
  int success = 0;
  int failed = 0;

  for (int i = 0; i < uniqueChars.length; i++) {
    final char = uniqueChars[i];
    final decimalCode = char.runes.first.toString();
    
    try {
      final url = 'https://raw.githubusercontent.com/parsimonhi/animCJK/master/svgsZhHans/$decimalCode.svg';
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 5));
      
      if (response.statusCode == 200) {
        final svgContent = response.body;
        
        // Use regex to extract paths since we don't have an XML parser in a simple script
        // 1. Outlines: <path id="z...d..." d="DATA" />
        final outlineRegex = RegExp(r'<path id="[^"].*?" d="([^\"]+)"');
        final outlineMatches = outlineRegex.allMatches(svgContent);
        final outlines = outlineMatches.map((m) => m.group(1)!).toList();
        
        // 2. Skeletons: <path ... clip-path="url(#...)" d="DATA" />
        final skeletonRegex = RegExp(r'<path [^>]*clip-path="url\(#[^)]+\)" d="([^\"]+)"');
        final skeletonMatches = skeletonRegex.allMatches(svgContent);
        final skeletons = skeletonMatches.map((m) => m.group(1)!).toList();
        
        if (outlines.isNotEmpty && skeletons.isNotEmpty) {
          animcjkData[char] = {
            'outlines': outlines,
            'skeletons': skeletons,
          };
          success++;
          stdout.write('✓');
        } else {
          failed++;
          stdout.write('✗');
        }
      } else {
        failed++;
        stdout.write('-');
      }
    } catch (e) {
      failed++;
      stdout.write('!');
    }
    
    if ((i + 1) % 50 == 0) {
      print('\n[${i + 1}/${uniqueChars.length}] Progress: $success succeeded, $failed failed');
    }
    
    await Future.delayed(const Duration(milliseconds: 20));
  }
  
  print('\n\n✅ Download complete!');
  print('   Success: $success characters');
  print('   Failed: $failed characters');
  
  final jsonStr = jsonEncode(animcjkData);
  final file = File('assets/data/hsk1_animcjk.json');
  file.writeAsStringSync(jsonStr);
  
  print('\n✅ Saved AnimCJK data to assets/data/hsk1_animcjk.json');
}
