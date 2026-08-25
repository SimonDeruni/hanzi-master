import 'package:flutter/material.dart';

class PinyinUtils {
  /// Standard tone colors for the "Zen & Ink" theme.
  static const Map<int, Color> toneColors = {
    1: Color(0xFFD32F2F), // Tone 1: Flat/Red
    2: Color(0xFFF57C00), // Tone 2: Rising/Amber
    3: Color(0xFF388E3C), // Tone 3: Falling-Rising/Green
    4: Color(0xFF1976D2), // Tone 4: Falling/Blue
    5: Color(0xFF1A1A1B), // Tone 5 (Neutral): Ink/Grey
  };

  /// Unicode diacritics for each tone.
  static const String tone1Chars = 'āēīōūǖ';
  static const String tone2Chars = 'áéíóúǘ';
  static const String tone3Chars = 'ǎěǐǒǔǚ';
  static const String tone4Chars = 'àèìòùǜ';

  /// Determines the tone (1-5) of a single pinyin syllable.
  static int getTone(String syllable) {
    String lower = syllable.toLowerCase();
    
    for (int i = 0; i < lower.length; i++) {
      String char = lower[i];
      if (tone1Chars.contains(char)) return 1;
      if (tone2Chars.contains(char)) return 2;
      if (tone3Chars.contains(char)) return 3;
      if (tone4Chars.contains(char)) return 4;
    }
    
    return 5; // Neutral tone
  }

  static const Map<String, String> _vowelMap = {
    'a1': 'ā', 'a2': 'á', 'a3': 'ǎ', 'a4': 'à',
    'e1': 'ē', 'e2': 'é', 'e3': 'ě', 'e4': 'è',
    'i1': 'ī', 'i2': 'í', 'i3': 'ǐ', 'i4': 'ì',
    'o1': 'ō', 'o2': 'ó', 'o3': 'ǒ', 'o4': 'ò',
    'u1': 'ū', 'u2': 'ú', 'u3': 'ǔ', 'u4': 'ù',
    'ü1': 'ǖ', 'ü2': 'ǘ', 'ü3': 'ǚ', 'ü4': 'ǜ',
  };

  /// Converts numeric pinyin (e.g. "jian4", "lu:4") to tone marks (e.g. "jiàn", "lǜ")
  static String convertNumericToMarks(String text) {
    // CC-CEDICT uses u: or v for ü
    String processed = text
        .replaceAll('u:', 'ü')
        .replaceAll('U:', 'Ü')
        .replaceAll('v', 'ü')
        .replaceAll('V', 'Ü');
    
    return processed.replaceAllMapped(RegExp(r'([a-zA-ZüÜ]+)([1-5])'), (match) {
      String word = match.group(1)!;
      int tone = int.parse(match.group(2)!);
      
      if (tone == 5) return word; // Neutral tone has no mark
      
      String lowerWord = word.toLowerCase();
      int targetIdx = -1;
      
      if (lowerWord.contains('a')) {
        targetIdx = lowerWord.indexOf('a');
      } else if (lowerWord.contains('e')) {
        targetIdx = lowerWord.indexOf('e');
      } else if (lowerWord.contains('ou')) {
        targetIdx = lowerWord.indexOf('o');
      } else {
        // Find the last vowel
        for (int i = lowerWord.length - 1; i >= 0; i--) {
          if ('aeiouü'.contains(lowerWord[i])) {
            targetIdx = i;
            break;
          }
        }
      }
      
      if (targetIdx != -1) {
        String vowel = word[targetIdx];
        bool isUpper = vowel == vowel.toUpperCase();
        String vKey = "${vowel.toLowerCase()}$tone";
        String markedVowel = _vowelMap[vKey] ?? vowel;
        if (isUpper) markedVowel = markedVowel.toUpperCase();
        
        return word.substring(0, targetIdx) + markedVowel + word.substring(targetIdx + 1);
      }
      
      return word;
    });
  }

  /// Removes tone diacritics from pinyin (e.g., "hé lì" -> "he li").
  static String removeToneMarks(String text) {
    String stripped = text;
    final Map<String, String> stripMap = {
      'ā': 'a', 'á': 'a', 'ǎ': 'a', 'à': 'a',
      'ē': 'e', 'é': 'e', 'ě': 'e', 'è': 'e',
      'ī': 'i', 'í': 'i', 'ǐ': 'i', 'ì': 'i',
      'ō': 'o', 'ó': 'o', 'ǒ': 'o', 'ò': 'o',
      'ū': 'u', 'ú': 'u', 'ǔ': 'u', 'ù': 'u',
      'ǖ': 'ü', 'ǘ': 'ü', 'ǚ': 'ü', 'ǜ': 'ü',
      'Ā': 'A', 'Á': 'A', 'Ǎ': 'A', 'À': 'A',
      'Ē': 'E', 'É': 'E', 'Ě': 'E', 'È': 'E',
      'Ī': 'I', 'Í': 'I', 'Ǐ': 'I', 'Ì': 'I',
      'Ō': 'O', 'Ó': 'O', 'Ǒ': 'O', 'Ò': 'O',
      'Ū': 'U', 'Ú': 'U', 'Ǔ': 'U', 'Ù': 'U',
      'Ǖ': 'Ü', 'Ǘ': 'Ü', 'Ǚ': 'Ü', 'Ǜ': 'Ü',
    };
    stripMap.forEach((key, value) {
      stripped = stripped.replaceAll(key, value);
    });
    return stripped;
  }

  /// Tokenizes a string (which may contain multiple syllables, punctuation, and spaces)
  /// into a list of Map objects containing the text and its tone.
  static List<Map<String, dynamic>> tokenize(String rawText) {
    final String text = convertNumericToMarks(rawText);
    final List<Map<String, dynamic>> tokens = [];
    
    // Improved Regex to match individual pinyin syllables more accurately.
    // Group 1: Matches a pinyin syllable (consonants + vowels + nasal ending)
    // Group 2: Catch-all for spaces, punctuation, or individual non-syllable letters.
    final RegExp regExp = RegExp(
      r'([bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ]*[aeiouvüAEIOUVÜāēīōūǖáéíóúǘǎěǐǒǔǚàèìòùǜ]+(?:ng?|r)?)|(.)',
      caseSensitive: true,
    );
    
    final Iterable<RegExpMatch> matches = regExp.allMatches(text);
    
    for (final match in matches) {
      String matchedText = match.group(0)!;
      bool isSyllable = match.group(1) != null;
      
      if (isSyllable) {
        tokens.add({
          'text': matchedText,
          'tone': getTone(matchedText),
        });
      } else {
        // This handles spaces, punctuation, or extra letters
        tokens.add({
          'text': matchedText,
          'tone': 5, // Neutral
        });
      }
    }
    
    return tokens;
  }

  /// Generates the 4 (or 5) tone variations for a given pinyin syllable.
  /// E.g. "mā" -> {1: "mā", 2: "má", 3: "mǎ", 4: "mà", 5: "ma"}
  static Map<int, String> getAllTonesForSyllable(String pinyinWithTone) {
    final base = removeToneMarks(pinyinWithTone).trim();
    if (base.isEmpty) return {};
    return {
      1: convertNumericToMarks('${base}1'),
      2: convertNumericToMarks('${base}2'),
      3: convertNumericToMarks('${base}3'),
      4: convertNumericToMarks('${base}4'),
      5: base,
    };
  }

  /// Human-readable name for each tone (e.g. "1st Tone (High Flat)").
  static String getToneName(int tone) {
    switch (tone) {
      case 1:
        return "1st Tone (High Flat — 55)";
      case 2:
        return "2nd Tone (Rising — 35)";
      case 3:
        return "3rd Tone (Falling-Rising — 214)";
      case 4:
        return "4th Tone (Falling — 51)";
      default:
        return "Neutral Tone (Light)";
    }
  }

  /// Description of the pitch shape for each tone.
  static String getToneDescription(int tone) {
    switch (tone) {
      case 1:
        return "Keep your pitch high and steady like singing a note.";
      case 2:
        return "Start in the middle and slide your pitch upward like asking 'What?'";
      case 3:
        return "Dip your voice down low, then rise gently back up.";
      case 4:
        return "Drop your pitch sharply and decisively like a firm 'No!'";
      default:
        return "Pronounce softly, briefly, and without emphasis.";
    }
  }

  /// Generates a concise diagnostic summary comparing expected tone vs actual spoken tone.
  static String getToneDiagnostic(int expectedTone, int actualTone) {
    if (expectedTone == actualTone && expectedTone > 0) {
      switch (expectedTone) {
        case 1:
          return "Spot on! Pitch was high, flat, and steady.";
        case 2:
          return "Spot on! Upward pitch rise was clear.";
        case 3:
          return "Spot on! Low dipping curve was accurate.";
        case 4:
          return "Spot on! Sharp falling drop was decisive.";
        default:
          return "Spot on! Tone was pronounced accurately.";
      }
    }

    // Specific diagnostic guidance based on the error pair
    if (expectedTone == 1 && actualTone == 2) {
      return "You rose your pitch (2nd tone /). Keep your voice flat and high across the whole syllable (1st tone ˉ).";
    } else if (expectedTone == 1 && actualTone == 3) {
      return "You dipped your voice (3rd tone ˇ). Keep your pitch steady and high without dipping (1st tone ˉ).";
    } else if (expectedTone == 1 && actualTone == 4) {
      return "You dropped your pitch (4th tone \\). Sustain a high, level pitch like singing a note (1st tone ˉ).";
    } else if (expectedTone == 2 && actualTone == 1) {
      return "You stayed flat (1st tone ˉ). Slide your pitch upward like asking 'What?' (2nd tone /).";
    } else if (expectedTone == 2 && actualTone == 3) {
      return "You dipped too deep (3rd tone ˇ). Start mid-level and rise smoothly without bottoming out (2nd tone /).";
    } else if (expectedTone == 2 && actualTone == 4) {
      return "You dropped your pitch (4th tone \\). Rise upward like asking a question (2nd tone /).";
    } else if (expectedTone == 3 && actualTone == 1) {
      return "You stayed high and flat (1st tone ˉ). Let your pitch drop low into your chest register before rising (3rd tone ˇ).";
    } else if (expectedTone == 3 && actualTone == 2) {
      return "You rose immediately (2nd tone /). Make sure to dip down low first before rising back up (3rd tone ˇ).";
    } else if (expectedTone == 3 && actualTone == 4) {
      return "You dropped sharply without rising (4th tone \\). Allow your pitch to bounce gently back up at the end (3rd tone ˇ).";
    } else if (expectedTone == 4 && actualTone == 1) {
      return "You stayed flat (1st tone ˉ). Drop your pitch sharply and decisively like a firm 'No!' (4th tone \\).";
    } else if (expectedTone == 4 && actualTone == 2) {
      return "You rose your pitch (2nd tone /). Start high and snap sharply downward (4th tone \\).";
    } else if (expectedTone == 4 && actualTone == 3) {
      return "You dipped and rose (3rd tone ˇ). Drop straight down without rising back up (4th tone \\).";
    }

    return "Target was ${getToneName(expectedTone)}. Listen to the 4 tones below to hear the difference.";
  }

  /// Returns a native Hanzi exemplar character for a given syllable base and tone,
  /// or null if this tone does not exist in standard Mandarin Chinese.
  static String? getExemplarHanzi(String pinyinWithTone, int tone) {
    final base = removeToneMarks(pinyinWithTone).trim().toLowerCase();
    final map = _syllableExemplars[base];
    if (map != null && map.containsKey(tone)) {
      final val = map[tone];
      if (val != null && val.trim().isNotEmpty) {
        return val.trim();
      }
    }
    return null;
  }

  static const Map<String, Map<int, String>> _syllableExemplars = {
    'a': {1: '啊', 2: '嗄'},
    'ai': {1: '哀', 2: '啀', 3: '矮', 4: '爱'},
    'an': {1: '安', 2: '啽', 3: '俺', 4: '按'},
    'ang': {1: '肮', 2: '昂', 4: '盎'},
    'ao': {1: '凹', 2: '嗷', 3: '袄', 4: '傲'},
    'ba': {1: '八', 2: '拔', 3: '把', 4: '爸'},
    'bai': {1: '掰', 2: '白', 3: '百', 4: '拜'},
    'ban': {1: '斑', 3: '板', 4: '半'},
    'bang': {1: '帮', 3: '榜', 4: '棒'},
    'bao': {1: '包', 2: '雹', 3: '宝', 4: '抱'},
    'bei': {1: '杯', 3: '北', 4: '被'},
    'ben': {1: '奔', 3: '本', 4: '笨'},
    'beng': {1: '崩', 2: '甭', 3: '埄', 4: '蹦'},
    'bi': {1: '逼', 2: '鼻', 3: '比', 4: '必'},
    'bian': {1: '边', 3: '匾', 4: '变'},
    'biao': {1: '标', 2: '嫑', 3: '表', 4: '俵'},
    'bie': {1: '憋', 2: '别', 3: '瘪'},
    'bin': {1: '宾', 4: '鬓'},
    'bing': {1: '兵', 3: '丙', 4: '病'},
    'bo': {1: '波', 2: '亳', 3: '跛', 4: '擘'},
    'bu': {1: '晡', 2: '醭', 3: '补', 4: '不'},
    'ca': {1: '擦', 3: '礤'},
    'cai': {1: '猜', 2: '才', 3: '采', 4: '菜'},
    'can': {1: '参', 2: '残', 3: '惨', 4: '灿'},
    'cang': {1: '仓', 2: '鑶'},
    'cao': {1: '操', 2: '槽', 3: '草', 4: '肏'},
    'ce': {4: '测'},
    'cen': {2: '涔'},
    'ceng': {1: '噌', 2: '层', 4: '蹭'},
    'cha': {1: '叉', 2: '茶', 3: '衩', 4: '岔'},
    'chai': {1: '拆', 2: '柴', 3: '茝', 4: '囆'},
    'chan': {1: '搀', 2: '缠', 3: '产', 4: '颤'},
    'chang': {1: '伥', 2: '常', 3: '厰', 4: '唱'},
    'chao': {1: '抄', 2: '朝', 3: '炒', 4: '耖'},
    'che': {1: '车', 3: '尺', 4: '撤'},
    'chen': {1: '嗔', 2: '陈', 3: '碜', 4: '衬'},
    'cheng': {1: '偁', 2: '成', 3: '逞'},
    'chi': {1: '吃', 2: '迟', 3: '侈', 4: '赤'},
    'chong': {1: '充', 2: '虫', 3: '宠', 4: '揰'},
    'chou': {1: '抽', 2: '俦', 3: '丑', 4: '臭'},
    'chu': {1: '初', 2: '除', 3: '楚', 4: '亍'},
    'chua': {1: '欻'},
    'chuai': {1: '揣', 2: '膗', 4: '踹'},
    'chuan': {1: '川', 2: '船', 3: '喘', 4: '串'},
    'chuang': {1: '窗', 2: '床', 3: '闯', 4: '创'},
    'chui': {1: '吹', 2: '垂', 4: '龡'},
    'chun': {1: '春', 2: '纯', 3: '蠢'},
    'chuo': {1: '戳', 4: '啜'},
    'ci': {1: '疵', 2: '辞', 3: '此', 4: '次'},
    'cong': {1: '聪', 2: '从'},
    'cou': {4: '凑'},
    'cu': {1: '粗', 2: '徂', 3: '皻', 4: '醋'},
    'cuan': {1: '蹿', 2: '攒', 4: '窜'},
    'cui': {1: '催', 3: '璀', 4: '脆'},
    'cun': {1: '村', 2: '存', 3: '忖', 4: '寸'},
    'cuo': {1: '搓', 2: '嵯', 3: '脞', 4: '错'},
    'da': {1: '搭', 2: '达', 4: '大'},
    'dai': {1: '呆', 3: '歹', 4: '带'},
    'dan': {1: '丹', 3: '胆', 4: '蛋'},
    'dang': {1: '当', 3: '挡', 4: '凼'},
    'dao': {1: '刀', 2: '捯', 3: '岛', 4: '到'},
    'de': {1: '嘚', 2: '德'},
    'den': {4: '扽'},
    'deng': {1: '灯', 3: '等', 4: '邓'},
    'di': {1: '低', 2: '敌', 3: '呧', 4: '俤'},
    'dia': {3: '嗲'},
    'dian': {1: '颠', 3: '点', 4: '电'},
    'diao': {1: '雕', 3: '鸟', 4: '掉'},
    'die': {1: '跌', 2: '叠'},
    'ding': {1: '丁', 3: '顶', 4: '定'},
    'diu': {1: '丢'},
    'dong': {1: '东', 3: '懂', 4: '动'},
    'dou': {1: '兜', 3: '斗', 4: '豆'},
    'du': {1: '督', 2: '凟', 3: '赌', 4: '度'},
    'duan': {1: '端', 3: '短', 4: '断'},
    'dui': {1: '堆', 3: '怼', 4: '对'},
    'dun': {1: '吨', 3: '盹', 4: '顿'},
    'duo': {1: '多', 2: '夺', 3: '朵', 4: '舵'},
    'e': {1: '婀', 2: '鹅', 3: '恶', 4: '饿'},
    'ei': {1: '诶'},
    'en': {1: '恩', 4: '摁'},
    'eng': {1: '鞥'},
    'er': {2: '而', 3: '尔', 4: '二'},
    'fa': {1: '发', 2: '乏', 3: '法', 4: '珐'},
    'fan': {1: '帆', 2: '凡', 3: '反', 4: '饭'},
    'fang': {1: '方', 2: '防', 3: '仿', 4: '放'},
    'fei': {1: '飞', 2: '肥', 3: '匪', 4: '费'},
    'fen': {1: '分', 2: '坟', 3: '粉', 4: '份'},
    'feng': {1: '风', 2: '逢', 3: '讽', 4: '奉'},
    'fiao': {4: '覅'},
    'fo': {2: '佛'},
    'fou': {2: '紑', 3: '否'},
    'fu': {1: '夫', 2: '服', 3: '府', 4: '父'},
    'ga': {1: '咖', 2: '噶', 3: '尕', 4: '尬'},
    'gai': {1: '该', 3: '改', 4: '丐'},
    'gan': {1: '干', 3: '赶', 4: '倝'},
    'gang': {1: '刚', 3: '港', 4: '戆'},
    'gao': {1: '高', 3: '稿', 4: '告'},
    'ge': {1: '歌', 2: '蛤', 3: '个', 4: '亇'},
    'gei': {1: '假', 3: '给'},
    'gen': {1: '根', 2: '哏', 3: '艮', 4: '亘'},
    'geng': {1: '更', 3: '埂'},
    'gong': {1: '工', 3: '巩', 4: '共'},
    'gou': {1: '勾', 3: '狗', 4: '够'},
    'gu': {1: '姑', 3: '古', 4: '故'},
    'gua': {1: '瓜', 3: '寡', 4: '挂'},
    'guai': {1: '乖', 3: '拐', 4: '怪'},
    'guan': {1: '关', 3: '管', 4: '惯'},
    'guang': {1: '光', 3: '犷', 4: '逛'},
    'gui': {1: '归', 3: '轨', 4: '贵'},
    'gun': {3: '滚', 4: '棍'},
    'guo': {1: '锅', 2: '国', 3: '果'},
    'ha': {1: '哈', 2: '虾'},
    'hai': {1: '嗨', 2: '孩', 3: '海', 4: '害'},
    'han': {1: '酣', 2: '韩', 3: '喊', 4: '汉'},
    'hang': {2: '吭', 4: '沆'},
    'hao': {1: '蒿', 2: '豪', 3: '好', 4: '恏'},
    'he': {1: '喝', 2: '河', 4: '佫'},
    'hei': {1: '黑'},
    'hen': {2: '拫', 3: '狠', 4: '恨'},
    'heng': {1: '哼', 2: '横', 4: '堼'},
    'hong': {1: '轰', 2: '红', 4: '澒'},
    'hou': {1: '齁', 2: '猴', 3: '吼', 4: '后'},
    'hu': {1: '呼', 2: '胡', 3: '虎', 4: '户'},
    'hua': {1: '花', 2: '华', 4: '话'},
    'huai': {2: '淮', 4: '坏'},
    'huan': {1: '欢', 2: '环', 3: '缓', 4: '换'},
    'huang': {1: '荒', 2: '黄', 3: '谎'},
    'hui': {1: '灰', 2: '回', 3: '悔', 4: '会'},
    'hun': {1: '婚', 2: '魂', 4: '圂'},
    'huo': {1: '劐', 2: '活', 3: '火', 4: '或'},
    'ji': {1: '鸡', 2: '及', 3: '丮', 4: '记'},
    'jia': {1: '家', 2: '唊', 3: '甲', 4: '嫁'},
    'jian': {1: '尖', 3: '减', 4: '见'},
    'jiang': {1: '江', 3: '讲', 4: '降'},
    'jiao': {1: '交', 2: '嚼', 3: '佼', 4: '叫'},
    'jie': {1: '接', 2: '捷', 3: '姐', 4: '价'},
    'jin': {1: '金', 3: '紧', 4: '近'},
    'jing': {1: '京', 3: '井', 4: '静'},
    'jiong': {1: '冂', 3: '窘'},
    'jiu': {1: '究', 3: '酒', 4: '就'},
    'ju': {1: '居', 2: '局', 3: '举', 4: '足'},
    'juan': {1: '圈', 3: '卷', 4: '倦'},
    'jue': {1: '噘', 2: '绝'},
    'jun': {1: '军', 4: '俊'},
    'ka': {1: '喀', 3: '卡'},
    'kai': {1: '开', 3: '凯', 4: '愒'},
    'kan': {1: '看', 3: '砍', 4: '墈'},
    'kang': {1: '康', 4: '抗'},
    'kao': {1: '尻', 3: '烤', 4: '靠'},
    'ke': {1: '科', 3: '渴', 4: '客'},
    'kei': {1: '剋'},
    'ken': {3: '啃', 4: '掯'},
    'keng': {1: '坑'},
    'kong': {1: '空', 3: '恐', 4: '控'},
    'kou': {1: '抠', 3: '口', 4: '扣'},
    'ku': {1: '哭', 3: '苦', 4: '裤'},
    'kua': {1: '夸', 3: '垮', 4: '跨'},
    'kuai': {3: '蒯', 4: '快'},
    'kuan': {1: '宽', 3: '款'},
    'kuang': {1: '劻', 2: '狂', 3: '夼', 4: '况'},
    'kui': {1: '亏', 2: '葵', 3: '煃', 4: '愧'},
    'kun': {1: '昆', 3: '捆', 4: '困'},
    'kuo': {4: '阔'},
    'la': {1: '拉', 2: '剌', 4: '落'},
    'lai': {2: '来', 4: '赖'},
    'lan': {2: '蓝', 3: '懒', 4: '烂'},
    'lang': {1: '啷', 2: '郎', 3: '朗', 4: '浪'},
    'lao': {1: '捞', 2: '劳', 3: '老', 4: '酪'},
    'le': {4: '乐'},
    'lei': {2: '雷', 3: '磊', 4: '泪'},
    'leng': {1: '棱', 2: '塄', 3: '冷', 4: '愣'},
    'li': {2: '梨', 3: '里', 4: '力'},
    'lia': {3: '俩'},
    'lian': {2: '联', 3: '脸', 4: '练'},
    'liang': {2: '梁', 3: '两', 4: '亮'},
    'liao': {1: '撩', 2: '聊', 3: '憭', 4: '料'},
    'lie': {1: '咧', 4: '猎'},
    'lin': {1: '拎', 2: '林', 3: '凛', 4: '吝'},
    'ling': {1: '昤', 2: '灵', 3: '领', 4: '另'},
    'liu': {1: '溜', 2: '流', 3: '柳', 4: '六'},
    'long': {2: '龙', 3: '拢', 4: '弄'},
    'lou': {1: '搂', 2: '楼', 3: '嵝', 4: '漏'},
    'lu': {1: '噜', 2: '芦', 3: '鲁', 4: '绿'},
    'luan': {2: '峦', 3: '卵', 4: '乱'},
    'lun': {1: '抡', 2: '轮'},
    'luo': {1: '啰', 2: '罗', 3: '裸', 4: '摞'},
    'lu:': {2: '驴', 3: '铝', 4: '率'},
    'lu:e': {4: '圙'},
    'm': {1: '姆', 2: '呣'},
    'ma': {1: '妈', 2: '麻', 3: '马', 4: '骂'},
    'mai': {2: '埋', 3: '买', 4: '卖'},
    'man': {1: '嫚', 2: '馒', 3: '满', 4: '慢'},
    'mang': {1: '牤', 2: '忙', 3: '漭'},
    'mao': {1: '猫', 2: '毛', 3: '卯', 4: '帽'},
    'mei': {2: '梅', 3: '美', 4: '妹'},
    'men': {1: '闷', 2: '门', 4: '懑'},
    'meng': {2: '盟', 3: '猛', 4: '梦'},
    'mi': {1: '咪', 2: '迷', 3: '米', 4: '密'},
    'mian': {2: '棉', 3: '免', 4: '面'},
    'miao': {1: '喵', 2: '苗', 3: '秒', 4: '妙'},
    'mie': {1: '咩', 4: '蔑'},
    'min': {2: '民', 3: '敏'},
    'ming': {2: '明', 3: '酩', 4: '命'},
    'miu': {4: '谬'},
    'mo': {1: '摸', 2: '模', 4: '万'},
    'mou': {1: '哞', 2: '牟', 3: '某'},
    'mu': {2: '毪', 3: '母', 4: '目'},
    'na': {1: '那', 2: '拿', 3: '哪', 4: '呐'},
    'nai': {3: '奶', 4: '耐'},
    'nan': {1: '囡', 2: '男', 3: '戁'},
    'nang': {1: '囊', 2: '馕', 3: '攮', 4: '齉'},
    'nao': {1: '孬', 2: '挠', 3: '脑', 4: '闹'},
    'ne': {4: '疒'},
    'nei': {3: '馁', 4: '内'},
    'nen': {4: '嫩'},
    'neng': {2: '能'},
    'ni': {1: '妮', 2: '泥', 3: '你', 4: '逆'},
    'nian': {1: '拈', 2: '年', 3: '撵', 4: '念'},
    'niang': {2: '娘', 4: '酿'},
    'niao': {3: '袅', 4: '尿'},
    'nie': {1: '捏', 2: '苶', 4: '聂'},
    'nin': {2: '您'},
    'ning': {2: '儜', 4: '泞'},
    'niu': {1: '妞', 2: '牛', 3: '扭'},
    'nong': {2: '浓', 4: '挊'},
    'nou': {4: '獳'},
    'nu': {2: '奴', 3: '弩', 4: '怒'},
    'nuan': {3: '暖'},
    'nun': {2: '黁'},
    'nuo': {2: '挪', 4: '懦'},
    'nu:': {3: '女', 4: '衄'},
    'nu:e': {4: '疟'},
    'o': {1: '喔'},
    'ou': {1: '区', 3: '偶', 4: '怄'},
    'pa': {1: '趴', 2: '爬', 4: '怕'},
    'pai': {1: '拍', 2: '排', 4: '哌'},
    'pan': {1: '潘', 2: '盘', 4: '盼'},
    'pang': {1: '乓', 2: '旁', 3: '嗙'},
    'pao': {1: '抛', 2: '袍', 4: '疱'},
    'pei': {1: '胚', 2: '陪', 4: '配'},
    'pen': {1: '喷', 2: '盆'},
    'peng': {1: '烹', 2: '朋', 3: '捧', 4: '碰'},
    'pi': {1: '披', 2: '皮', 3: '匹', 4: '屁'},
    'pian': {1: '偏', 2: '楩', 3: '谝', 4: '騗'},
    'piao': {1: '飘', 2: '瓢', 3: '殍', 4: '票'},
    'pie': {1: '撇', 3: '丿'},
    'pin': {1: '拼', 2: '贫', 3: '品', 4: '聘'},
    'ping': {1: '乒', 2: '平'},
    'po': {1: '坡', 2: '婆', 3: '叵', 4: '破'},
    'pou': {1: '剖', 2: '掊', 3: '咅'},
    'pu': {1: '扑', 2: '匍', 3: '普', 4: '铺'},
    'qi': {1: '七', 2: '亓', 3: '起', 4: '气'},
    'qia': {1: '掐', 2: '拤', 4: '恰'},
    'qian': {1: '千', 2: '前', 3: '缱', 4: '欠'},
    'qiang': {1: '枪', 2: '强', 3: '襁', 4: '炝'},
    'qiao': {1: '敲', 2: '桥', 3: '巧', 4: '俏'},
    'qie': {1: '切', 2: '癿', 3: '且', 4: '怯'},
    'qin': {1: '亲', 2: '琴', 3: '寝', 4: '沁'},
    'qing': {1: '清', 2: '晴', 3: '请', 4: '庆'},
    'qiong': {1: '銎', 2: '琼'},
    'qiu': {1: '秋', 2: '仇', 3: '糗'},
    'qu': {1: '伹', 2: '渠', 3: '取', 4: '去'},
    'quan': {1: '悛', 2: '全', 3: '犬', 4: '劝'},
    'que': {1: '缺', 2: '瘸', 4: '确'},
    'qun': {1: '囷', 2: '群'},
    'ran': {2: '燃', 3: '染'},
    'rang': {2: '瓤', 3: '壤', 4: '让'},
    'rao': {2: '饶', 3: '扰', 4: '绕'},
    're': {3: '惹', 4: '热'},
    'ren': {2: '仁', 3: '忍', 4: '认'},
    'reng': {1: '扔', 2: '仍', 4: '芿'},
    'ri': {4: '日'},
    'rong': {2: '荣', 3: '冗'},
    'rou': {2: '柔', 4: '肉'},
    'ru': {2: '儒', 3: '乳', 4: '入'},
    'rua': {2: '挼'},
    'ruan': {2: '堧', 3: '软'},
    'rui': {2: '緌', 3: '蕊', 4: '瑞'},
    'run': {2: '犉', 4: '润'},
    'ruo': {2: '捼', 4: '弱'},
    'sa': {1: '撒', 3: '潵', 4: '萨'},
    'sai': {1: '塞', 4: '赛'},
    'san': {1: '三', 3: '伞', 4: '散'},
    'sang': {1: '桑', 3: '嗓'},
    'sao': {1: '搔', 3: '嫂', 4: '喿'},
    'se': {4: '瑟'},
    'sen': {1: '森'},
    'seng': {1: '僧'},
    'sha': {1: '沙', 2: '啥', 3: '傻', 4: '歃'},
    'shai': {1: '筛', 4: '晒'},
    'shan': {1: '山', 3: '睒', 4: '善'},
    'shang': {1: '伤', 3: '上', 4: '尚'},
    'shao': {1: '烧', 2: '勺', 3: '少', 4: '哨'},
    'she': {1: '奢', 2: '蛇', 3: '舍', 4: '射'},
    'shei': {2: '谁'},
    'shen': {1: '身', 2: '神', 3: '审', 4: '愼'},
    'sheng': {1: '生', 2: '绳', 3: '省', 4: '胜'},
    'shi': {1: '师', 2: '十', 3: '史', 4: '是'},
    'shou': {1: '收', 3: '手', 4: '瘦'},
    'shu': {1: '书', 2: '熟', 3: '数', 4: '树'},
    'shua': {1: '刷', 3: '耍'},
    'shuai': {1: '摔', 3: '甩', 4: '帅'},
    'shuan': {1: '栓', 4: '涮'},
    'shuang': {1: '双', 3: '爽'},
    'shui': {3: '水', 4: '睡'},
    'shun': {3: '吮', 4: '顺'},
    'shuo': {4: '朔'},
    'si': {1: '司', 3: '死', 4: '四'},
    'song': {1: '松', 2: '怂', 3: '耸', 4: '宋'},
    'sou': {1: '搜', 3: '叟', 4: '嗽'},
    'su': {1: '苏', 2: '俗', 4: '速'},
    'suan': {1: '酸', 3: '匴', 4: '算'},
    'sui': {1: '虽', 2: '随', 3: '瀡', 4: '碎'},
    'sun': {1: '孙', 3: '损'},
    'suo': {1: '缩', 3: '锁'},
    'ta': {1: '他', 3: '塔', 4: '嚃'},
    'tai': {1: '胎', 2: '台', 4: '太'},
    'tan': {1: '摊', 2: '谈', 3: '坦', 4: '探'},
    'tang': {1: '汤', 2: '堂', 3: '躺', 4: '烫'},
    'tao': {1: '涛', 2: '桃', 3: '讨', 4: '套'},
    'te': {4: '特'},
    'teng': {1: '熥', 2: '藤'},
    'ti': {1: '梯', 2: '厗', 3: '躰', 4: '替'},
    'tian': {1: '天', 2: '田', 3: '舔', 4: '掭'},
    'tiao': {1: '挑', 2: '条', 3: '宨', 4: '跳'},
    'tie': {1: '贴', 3: '鉄', 4: '餮'},
    'ting': {1: '厅', 2: '亭', 3: '挺'},
    'tong': {1: '通', 2: '同', 3: '统', 4: '痛'},
    'tou': {1: '偷', 2: '头', 3: '妵', 4: '透'},
    'tu': {1: '突', 2: '图', 3: '土', 4: '兔'},
    'tuan': {1: '圕', 2: '团', 3: '疃', 4: '彖'},
    'tui': {1: '推', 2: '颓', 3: '腿', 4: '褪'},
    'tun': {1: '吞', 2: '屯', 3: '氽'},
    'tuo': {1: '拖', 2: '驼', 3: '妥', 4: '拓'},
    'wa': {1: '蛙', 2: '娃', 3: '瓦', 4: '袜'},
    'wai': {1: '歪', 3: '崴', 4: '外'},
    'wan': {1: '湾', 2: '完', 3: '晚', 4: '卍'},
    'wang': {1: '汪', 2: '王', 3: '网', 4: '望'},
    'wei': {1: '微', 2: '唯', 3: '伟', 4: '位'},
    'wen': {1: '温', 2: '文', 3: '吻', 4: '问'},
    'weng': {1: '翁', 3: '塕', 4: '瓮'},
    'wo': {1: '窝', 3: '我', 4: '握'},
    'wu': {1: '屋', 2: '俉', 3: '五', 4: '物'},
    'xi': {1: '西', 2: '席', 3: '洗', 4: '细'},
    'xia': {1: '瞎', 2: '峡', 4: '夏'},
    'xian': {1: '仙', 2: '咸', 3: '显', 4: '现'},
    'xiang': {1: '香', 2: '详', 3: '想', 4: '向'},
    'xiao': {1: '消', 2: '崤', 3: '小', 4: '笑'},
    'xie': {1: '些', 2: '鞋', 3: '写', 4: '谢'},
    'xin': {1: '心', 3: '伈', 4: '伩'},
    'xing': {1: '星', 2: '形', 3: '擤', 4: '性'},
    'xiong': {1: '凶', 2: '雄', 4: '敻'},
    'xiu': {1: '休', 3: '朽', 4: '秀'},
    'xu': {1: '虚', 2: '徐', 3: '许', 4: '续'},
    'xuan': {1: '宣', 2: '玄', 3: '选', 4: '炫'},
    'xue': {1: '靴', 2: '学', 3: '雪', 4: '谑'},
    'xun': {1: '勋', 2: '寻', 4: '讯'},
    'ya': {1: '鸭', 2: '牙', 3: '痖', 4: '亚'},
    'yan': {1: '烟', 2: '言', 3: '广', 4: '厌'},
    'yang': {1: '央', 2: '羊', 3: '养', 4: '样'},
    'yao': {1: '约', 2: '摇', 3: '咬', 4: '曜'},
    'ye': {1: '椰', 2: '爷', 3: '也', 4: '夜'},
    'yi': {1: '一', 2: '移', 3: '以', 4: '意'},
    'yin': {1: '因', 2: '银', 3: '引', 4: '印'},
    'ying': {1: '英', 2: '迎', 3: '影', 4: '硬'},
    'yo': {1: '唷'},
    'yong': {1: '拥', 2: '喁', 3: '勇', 4: '用'},
    'you': {1: '优', 2: '油', 3: '有', 4: '右'},
    'yu': {1: '迂', 2: '鱼', 3: '雨', 4: '玉'},
    'yuan': {1: '冤', 2: '元', 3: '远', 4: '院'},
    'yue': {1: '曰', 4: '刖'},
    'yun': {1: '晕', 2: '云', 3: '允', 4: '运'},
    'za': {1: '匝', 2: '砸', 3: '咋'},
    'zai': {1: '灾', 3: '宰', 4: '再'},
    'zan': {1: '簪', 2: '咱', 3: '儹', 4: '赞'},
    'zang': {1: '赃', 3: '驵', 4: '葬'},
    'zao': {1: '糟', 2: '凿', 3: '早', 4: '造'},
    'ze': {2: '择', 4: '仄'},
    'zei': {2: '贼'},
    'zen': {3: '怎', 4: '谮'},
    'zeng': {1: '增', 4: '赠'},
    'zha': {1: '扎', 2: '闸', 3: '眨', 4: '乍'},
    'zhai': {1: '摘', 2: '宅', 3: '窄', 4: '债'},
    'zhan': {1: '旃', 3: '展', 4: '站'},
    'zhang': {1: '章', 3: '掌', 4: '帐'},
    'zhao': {1: '招', 3: '找', 4: '照'},
    'zhe': {1: '遮', 2: '哲', 3: '者', 4: '这'},
    'zhen': {1: '针', 3: '枕', 4: '阵'},
    'zheng': {1: '争', 3: '拯', 4: '政'},
    'zhi': {1: '之', 2: '直', 3: '止', 4: '志'},
    'zhong': {1: '中', 3: '种', 4: '乑'},
    'zhou': {1: '舟', 2: '妯', 3: '帚', 4: '昼'},
    'zhu': {1: '猪', 2: '竹', 3: '主', 4: '住'},
    'zhua': {1: '抓'},
    'zhuai': {3: '转'},
    'zhuan': {1: '专', 3: '孨', 4: '赚'},
    'zhuang': {1: '装', 4: '撞'},
    'zhui': {1: '锥', 4: '坠'},
    'zhun': {1: '窀', 3: '准'},
    'zhuo': {1: '捉', 2: '卓'},
    'zi': {1: '资', 3: '紫', 4: '字'},
    'zong': {1: '宗', 3: '总', 4: '纵'},
    'zou': {1: '邹', 3: '走', 4: '奏'},
    'zu': {1: '租', 2: '族', 3: '组'},
    'zuan': {1: '躜', 3: '纂', 4: '揝'},
    'zui': {1: '厜', 3: '嘴', 4: '最'},
    'zun': {1: '尊', 3: '僔', 4: '捘'},
    'zuo': {1: '作', 2: '昨', 3: '左', 4: '坐'},
  };

}
