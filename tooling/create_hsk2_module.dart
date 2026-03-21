// ignore_for_file: avoid_print
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<void> main() async {
  print('=============================================');
  print('🚀 Building HSK 2 Module (The Tome Library)');
  print('=============================================\n');

  // The Official 150 HSK 2 Vocabulary Words
  final List<Map<String, String>> hsk2Vocab = [
    {"hanzi": "吧", "pinyin": "ba", "definition": "suggestion particle; right?; OK?"},
    {"hanzi": "白", "pinyin": "bái", "definition": "white; snowy; pure; bright; empty"},
    {"hanzi": "百", "pinyin": "bǎi", "definition": "hundred"},
    {"hanzi": "帮助", "pinyin": "bāngzhù", "definition": "assistance; aid; to help; to assist"},
    {"hanzi": "报纸", "pinyin": "bàozhǐ", "definition": "newspaper; newsprint"},
    {"hanzi": "比", "pinyin": "bǐ", "definition": "(particle used for comparison and '-er than'); to compare"},
    {"hanzi": "别", "pinyin": "bié", "definition": "don't; to leave; to depart; to separate; to distinguish"},
    {"hanzi": "长", "pinyin": "cháng", "definition": "length; long; forever; always; constantly"},
    {"hanzi": "唱歌", "pinyin": "chànggē", "definition": "to sing a song"},
    {"hanzi": "出", "pinyin": "chū", "definition": "to go out; to come out; to occur; to produce; to turn out"},
    {"hanzi": "穿", "pinyin": "chuān", "definition": "to wear; to put on; to dress"},
    {"hanzi": "次", "pinyin": "cì", "definition": "next in sequence; second; the second; time (measure word)"},
    {"hanzi": "从", "pinyin": "cóng", "definition": "from; via; passing through; through (a gap)"},
    {"hanzi": "错", "pinyin": "cuò", "definition": "mistake; wrong; bad; interlocking; complex; to grind"},
    {"hanzi": "打篮球", "pinyin": "dǎlánqiú", "definition": "play basketball"},
    {"hanzi": "大家", "pinyin": "dàjiā", "definition": "everyone; everybody"},
    {"hanzi": "到", "pinyin": "dào", "definition": "to (a place); until (a time); up to; to go; to arrive"},
    {"hanzi": "得", "pinyin": "de", "definition": "structural particle: used after a verb (or adjective)"},
    {"hanzi": "等", "pinyin": "děng", "definition": "class; rank; grade; equal to; to wait for; to await"},
    {"hanzi": "弟弟", "pinyin": "dìdi", "definition": "younger brother"},
    {"hanzi": "第一", "pinyin": "dìyī", "definition": "first; number one"},
    {"hanzi": "懂", "pinyin": "dǒng", "definition": "to understand; to know"},
    {"hanzi": "对", "pinyin": "duì", "definition": "right; correct; couple; pair; towards; at; for; to face"},
    {"hanzi": "房间", "pinyin": "fángjiān", "definition": "room"},
    {"hanzi": "非常", "pinyin": "fēicháng", "definition": "unusual; extraordinary; extreme; very; exceptional"},
    {"hanzi": "服务员", "pinyin": "fúwùyuán", "definition": "waiter; waitress; attendant; customer service"},
    {"hanzi": "高", "pinyin": "gāo", "definition": "high; tall; above average; loud"},
    {"hanzi": "告诉", "pinyin": "gàosu", "definition": "to tell; to inform; to let know"},
    {"hanzi": "哥哥", "pinyin": "gēge", "definition": "older brother"},
    {"hanzi": "给", "pinyin": "gěi", "definition": "to; for; for the benefit of; to give; to allow; to do sth (for sb)"},
    {"hanzi": "公共汽车", "pinyin": "gōnggòngqìchē", "definition": "bus"},
    {"hanzi": "公司", "pinyin": "gōngsī", "definition": "(business) company; company; firm; corporation; incorporated"},
    {"hanzi": "贵", "pinyin": "guì", "definition": "expensive; noble; your (name); precious"},
    {"hanzi": "过", "pinyin": "guò", "definition": "(experienced action marker); to cross; to go over; to pass"},
    {"hanzi": "还", "pinyin": "hái", "definition": "still; still in progress; still more; yet; even more"},
    {"hanzi": "孩子", "pinyin": "háizi", "definition": "child"},
    {"hanzi": "好吃", "pinyin": "hǎochī", "definition": "tasty; delicious"},
    {"hanzi": "黑", "pinyin": "hēi", "definition": "black; dark"},
    {"hanzi": "红", "pinyin": "hóng", "definition": "bonus; popular; red; revolutionary"},
    {"hanzi": "欢迎", "pinyin": "huānyíng", "definition": "to welcome; welcome"},
    {"hanzi": "回答", "pinyin": "huídá", "definition": "to reply; to answer; the answer"},
    {"hanzi": "件", "pinyin": "jiàn", "definition": "item; component; classifier for events, things, clothes etc"},
    {"hanzi": "教室", "pinyin": "jiàoshì", "definition": "classroom"},
    {"hanzi": "机场", "pinyin": "jīchǎng", "definition": "airport; airfield"},
    {"hanzi": "鸡蛋", "pinyin": "jīdàn", "definition": "(chicken) egg"},
    {"hanzi": "几乎", "pinyin": "jīhū", "definition": "almost; nearly; practically"},
    {"hanzi": "机会", "pinyin": "jīhuì", "definition": "opportunity; chance; occasion"},
    {"hanzi": "极", "pinyin": "jí", "definition": "extremely; pole (geography, physics); utmost; top"},
    {"hanzi": "记得", "pinyin": "jìde", "definition": "to remember"},
    {"hanzi": "记", "pinyin": "jì", "definition": "to record; to note; to memorize"},
    {"hanzi": "加", "pinyin": "jiā", "definition": "to add; plus"},
    {"hanzi": "健康", "pinyin": "jiànkāng", "definition": "health; healthy"},
    {"hanzi": "见面", "pinyin": "jiànmiàn", "definition": "to meet; to see each other"},
    {"hanzi": "教", "pinyin": "jiāo", "definition": "to teach"},
    {"hanzi": "角", "pinyin": "jiǎo", "definition": "angle; corner; horn; horn-shaped; unit of money equal to 0.1 yuan"},
    {"hanzi": "脚", "pinyin": "jiǎo", "definition": "foot; leg; base; kick"},
    {"hanzi": "接", "pinyin": "jiē", "definition": "to receive; to answer (the phone); to meet or welcome sb; to connect"},
    {"hanzi": "街道", "pinyin": "jiēdào", "definition": "street"},
    {"hanzi": "节目", "pinyin": "jiémù", "definition": "program; item (on a program)"},
    {"hanzi": "节日", "pinyin": "jiérì", "definition": "holiday; festival"},
    {"hanzi": "结婚", "pinyin": "jiéhūn", "definition": "to marry; to get married"},
    {"hanzi": "结束", "pinyin": "jiéshù", "definition": "termination; to finish; to end; to conclude; to close"},
    {"hanzi": "解决", "pinyin": "jiějué", "definition": "to settle (a dispute); to resolve; to solve"},
    {"hanzi": "借", "pinyin": "jiè", "definition": "to lend; to borrow; excuse; pretext"},
    {"hanzi": "介绍", "pinyin": "jièshào", "definition": "to present; to introduce; to recommend; to suggest"},
    {"hanzi": "今天", "pinyin": "jīntiān", "definition": "today; at the present"},
    {"hanzi": "进", "pinyin": "jìn", "definition": "to advance; to enter; to come (or go) into; to receive or admit"},
    {"hanzi": "近", "pinyin": "jìn", "definition": "near; close to; approximately"},
    {"hanzi": "就", "pinyin": "jiù", "definition": "at once; right away; only; just (emphasis); as early as; already; as soon as"},
    {"hanzi": "觉得", "pinyin": "juéde", "definition": "to think; to feel"},
    {"hanzi": "咖啡", "pinyin": "kāfēi", "definition": "coffee"},
    {"hanzi": "开始", "pinyin": "kāishǐ", "definition": "to begin; beginning; to start; initial"},
    {"hanzi": "考试", "pinyin": "kǎoshì", "definition": "exam"},
    {"hanzi": "可能", "pinyin": "kěnéng", "definition": "might (happen); possible; probable; possibility; probability"},
    {"hanzi": "可以", "pinyin": "kěyǐ", "definition": "can; may; possible; able to"},
    {"hanzi": "课", "pinyin": "kè", "definition": "subject; course; class; lesson"},
    {"hanzi": "快", "pinyin": "kuài", "definition": "rapid; quick; speed; rate; soon; almost"},
    {"hanzi": "快乐", "pinyin": "kuàilè", "definition": "happy; merry"},
    {"hanzi": "累", "pinyin": "lèi", "definition": "implicate; tired"},
    {"hanzi": "离", "pinyin": "lí", "definition": "to leave; to part from; to be away from"},
    {"hanzi": "两", "pinyin": "liǎng", "definition": "both; two; ounce; some; a few; tael"},
    {"hanzi": "路", "pinyin": "lù", "definition": "road; path; way"},
    {"hanzi": "旅游", "pinyin": "lǚyóu", "definition": "trip; journey; tourism; travel; tour"},
    {"hanzi": "卖", "pinyin": "mài", "definition": "to sell"},
    {"hanzi": "慢", "pinyin": "màn", "definition": "slow"},
    {"hanzi": "忙", "pinyin": "máng", "definition": "busy; hurriedly"},
    {"hanzi": "每", "pinyin": "měi", "definition": "each; every"},
    {"hanzi": "妹妹", "pinyin": "mèimei", "definition": "younger sister"},
    {"hanzi": "门", "pinyin": "mén", "definition": "gate; door"},
    {"hanzi": "男", "pinyin": "nán", "definition": "male"},
    {"hanzi": "您", "pinyin": "nín", "definition": "you (polite)"},
    {"hanzi": "牛奶", "pinyin": "niúnǎi", "definition": "cow's milk"},
    {"hanzi": "旁边", "pinyin": "pángbiān", "definition": "lateral; side; to the side; beside"},
    {"hanzi": "跑步", "pinyin": "pǎobù", "definition": "to walk quickly; to march; to run"},
    {"hanzi": "便宜", "pinyin": "piányi", "definition": "small advantages; to let sb off lightly; cheap; inexpensive"},
    {"hanzi": "票", "pinyin": "piào", "definition": "ticket; ballot; bank note; person held for ransom"},
    {"hanzi": "妻子", "pinyin": "qīzi", "definition": "wife"},
    {"hanzi": "起床", "pinyin": "qǐchuáng", "definition": "to get up"},
    {"hanzi": "千", "pinyin": "qiān", "definition": "thousand"},
    {"hanzi": "铅笔", "pinyin": "qiānbǐ", "definition": "(lead) pencil"},
    {"hanzi": "晴", "pinyin": "qíng", "definition": "clear; fine (weather)"},
    {"hanzi": "去年", "pinyin": "qùnián", "definition": "last year"},
    {"hanzi": "让", "pinyin": "ràng", "definition": "to yield; to permit; to let sb do sth; to have sb do sth"},
    {"hanzi": "上班", "pinyin": "shàngbān", "definition": "to go to work; to be on duty; to start work; to go to the office"},
    {"hanzi": "身体", "pinyin": "shēntǐ", "definition": "(human) body; health"},
    {"hanzi": "生病", "pinyin": "shēngbìng", "definition": "to fall ill; to sicken"},
    {"hanzi": "生日", "pinyin": "shēngrì", "definition": "birthday"},
    {"hanzi": "时间", "pinyin": "shíjiān", "definition": "time; period"},
    {"hanzi": "事情", "pinyin": "shìqing", "definition": "affair; matter; thing; business"},
    {"hanzi": "手表", "pinyin": "shǒubiǎo", "definition": "wrist watch"},
    {"hanzi": "手机", "pinyin": "shǒujī", "definition": "cell phone; cellular phone; mobile phone"},
    {"hanzi": "送", "pinyin": "sòng", "definition": "to deliver; to carry; to give (as a present); to present (with); to see off; to send"},
    {"hanzi": "虽然", "pinyin": "suīrán", "definition": "although; even though; even if"},
    {"hanzi": "但是", "pinyin": "dànshì", "definition": "but; however"},
    {"hanzi": "它", "pinyin": "tā", "definition": "it"},
    {"hanzi": "踢足球", "pinyin": "tīzúqiú", "definition": "play football"},
    {"hanzi": "题", "pinyin": "tí", "definition": "topic; problem for discussion; exam question"},
    {"hanzi": "跳舞", "pinyin": "tiàowǔ", "definition": "to dance"},
    {"hanzi": "外", "pinyin": "wài", "definition": "outside; in addition; foreign; external"},
    {"hanzi": "完", "pinyin": "wán", "definition": "to finish; to be over; whole; complete; entire"},
    {"hanzi": "玩", "pinyin": "wán", "definition": "toy; sth used for amusement; curio or antique; to play; to have fun"},
    {"hanzi": "晚上", "pinyin": "wǎnshang", "definition": "in the evening"},
    {"hanzi": "往", "pinyin": "wǎng", "definition": "to go (in a direction); to; towards; (of a train) bound for; past; previous"},
    {"hanzi": "为什么", "pinyin": "wèishénme", "definition": "why?; for what reason?"},
    {"hanzi": "问", "pinyin": "wèn", "definition": "to ask"},
    {"hanzi": "问题", "pinyin": "wèntí", "definition": "question; problem; issue; topic"},
    {"hanzi": "希望", "pinyin": "xīwàng", "definition": "to wish for; to desire; hope"},
    {"hanzi": "洗", "pinyin": "xǐ", "definition": "to wash; to bathe"},
    {"hanzi": "笑", "pinyin": "xiào", "definition": "laugh; smile"},
    {"hanzi": "新", "pinyin": "xīn", "definition": "new; newly; meso- (chemistry)"},
    {"hanzi": "姓", "pinyin": "xìng", "definition": "family name; surname; name"},
    {"hanzi": "休息", "pinyin": "xiūxi", "definition": "rest; to rest"},
    {"hanzi": "雪", "pinyin": "xuě", "definition": "snow; snowfall"},
    {"hanzi": "颜色", "pinyin": "yánsè", "definition": "color; countenance; appearance; facial expression; pigment; dyestuff"},
    {"hanzi": "眼睛", "pinyin": "yǎnjing", "definition": "eye"},
    {"hanzi": "羊肉", "pinyin": "yángròu", "definition": "mutton"},
    {"hanzi": "药", "pinyin": "yào", "definition": "medicine; drug; cure"},
    {"hanzi": "要", "pinyin": "yào", "definition": "important; vital; to want; will; going to (as future auxiliary); may; must"},
    {"hanzi": "也", "pinyin": "yě", "definition": "also; too; (in classical Chinese) final particle serving as copula"},
    {"hanzi": "一起", "pinyin": "yìqǐ", "definition": "in the same place; together; with; altogether (in total)"},
    {"hanzi": "一下", "pinyin": "yíxià", "definition": "(used after a verb) give it a go; to do (sth for a bit to give it a try); one time; once; in a while; all of a sudden; all at once"},
    {"hanzi": "已经", "pinyin": "yǐjīng", "definition": "already"},
    {"hanzi": "意思", "pinyin": "yìsi", "definition": "idea; opinion; meaning; wish; desire"},
    {"hanzi": "阴", "pinyin": "yīn", "definition": "overcast (weather); cloudy; shady; Yin (the negative principle of Yin and Yang)"},
    {"hanzi": "游泳", "pinyin": "yóuyǒng", "definition": "swim"},
    {"hanzi": "右边", "pinyin": "yòubian", "definition": "right side; right, to the right"},
    {"hanzi": "鱼", "pinyin": "yú", "definition": "fish"},
    {"hanzi": "远", "pinyin": "yuǎn", "definition": "far; distant; remote"},
    {"hanzi": "运动", "pinyin": "yùndòng", "definition": "movement; campaign; sports"},
    {"hanzi": "再", "pinyin": "zài", "definition": "again; once more; re-; second; another; then (after sth, and not until then)"},
    {"hanzi": "早上", "pinyin": "zǎoshang", "definition": "early morning"},
    {"hanzi": "丈夫", "pinyin": "zhàngfu", "definition": "husband"},
    {"hanzi": "找", "pinyin": "zhǎo", "definition": "to try to find; to look for; to call on sb; to find; to seek; to return; to give change"},
    {"hanzi": "着", "pinyin": "zhe", "definition": "particle attached after verb to indicate action in progress, like -ing ending"},
    {"hanzi": "真", "pinyin": "zhēn", "definition": "really; truly; indeed; real; true; genuine"},
    {"hanzi": "正在", "pinyin": "zhèngzài", "definition": "in the process of (doing something or happening); while (doing)"},
    {"hanzi": "知道", "pinyin": "zhīdào", "definition": "to know; to be aware of"},
    {"hanzi": "准备", "pinyin": "zhǔnbèi", "definition": "preparation; prepare"},
    {"hanzi": "自行车", "pinyin": "zìxíngchē", "definition": "bicycle; bike"},
    {"hanzi": "走", "pinyin": "zǒu", "definition": "to walk; to go; to run; to move (of vehicle); to visit; to leave; to go away"},
    {"hanzi": "最", "pinyin": "zuì", "definition": "most; the most; -est"},
    {"hanzi": "左边", "pinyin": "zuǒbian", "definition": "left; the left side; to the left of"}
  ];

  // 1. Extract every unique individual character so we know what SVGs to download.
  final Set<String> uniqueCharacters = {};
  for (var word in hsk2Vocab) {
    for (int i = 0; i < word['hanzi']!.length; i++) {
      uniqueCharacters.add(word['hanzi']![i]);
    }
  }
  
  print('Found ${uniqueCharacters.length} unique characters across ${hsk2Vocab.length} words.\n');

  final Map<String, dynamic> characterData = {};
  int success = 0;
  int failed = 0;

  print('📥 Fetching stroke vectors from AnimCJK and HanziVG...');
  for (var char in uniqueCharacters) {
    final hexCode = char.runes.first.toRadixString(16).padLeft(5, '0');
    final decimalCode = char.runes.first.toString();
    
    Map<String, dynamic> strokeInfo = {};

    try {
      // Priority 1: AnimCJK (Best quality outlines + skeletons)
      final animUrl = 'https://raw.githubusercontent.com/parsimonhi/animCJK/master/svgsZhHans/$decimalCode.svg';
      final animResponse = await http.get(Uri.parse(animUrl)).timeout(const Duration(seconds: 4));
      
      if (animResponse.statusCode == 200) {
        final svgContent = animResponse.body;
        final skeletonRegex = RegExp(r'<path [^>]*clip-path="url\(#[^)]+\)" d="([^\"]+)"');
        final skeletonMatches = skeletonRegex.allMatches(svgContent);
        final skeletons = skeletonMatches.map((m) => m.group(1)!).toList();
        
        if (skeletons.isNotEmpty) {
          strokeInfo = {
            'hex': hexCode,
            'paths': skeletons,
            'source': 'animcjk'
          };
          success++;
          stdout.write('✨');
        }
      } 
      
      // Fallback: HanziVG (Great medians, missing in some AnimCJK repos)
      if (strokeInfo.isEmpty) {
        final hanziUrl = 'https://raw.githubusercontent.com/Connum/hanzivg/master/hanzi/$hexCode.svg';
        final hanziResponse = await http.get(Uri.parse(hanziUrl)).timeout(const Duration(seconds: 4));
        
        if (hanziResponse.statusCode == 200) {
          final svgContent = hanziResponse.body;
          final pathRegex = RegExp(r'<path[^>]*d="([^\"]+)"');
          final matches = pathRegex.allMatches(svgContent);
          final paths = matches.map((m) => m.group(1)!).toList();
          
          if (paths.isNotEmpty) {
            strokeInfo = {
              'hex': hexCode,
              'paths': paths,
              'source': 'hanzivg'
            };
            success++;
            stdout.write('🖌️');
          }
        }
      }

      if (strokeInfo.isNotEmpty) {
        characterData[char] = strokeInfo;
      } else {
        failed++;
        stdout.write('❌');
      }

    } catch (e) {
      failed++;
      stdout.write('❗');
    }
  }

  print('\n\n✅ Vector Download Complete: $success succeeded, $failed failed.');

  // 2. Package everything together into the final payload format
  final Map<String, dynamic> finalBundle = {
    'version': '1.0',
    'hskLevel': 2,
    'vocabulary': hsk2Vocab,
    'strokes': characterData,
  };

  final jsonOutput = jsonEncode(finalBundle);
  final file = File('assets/data/hsk2_bundle.json');
  await file.writeAsString(jsonOutput);
  
  print('💾 Saved module to: assets/data/hsk2_bundle.json (${(file.lengthSync() / 1024).toStringAsFixed(2)} KB)');
}
