import 'dart:convert';
import 'dart:io';

void main() async {
  print('=== Enriching Synopses and Syncing Chapter Counts in Catalog ===');

  final catalogFile = File('assets/data/grand_library_catalog.json');
  final List<dynamic> list = jsonDecode(catalogFile.readAsStringSync());

  // Deep comprehensive synopses for prominent masterpieces
  final Map<String, Map<String, String>> richSynopses = {
    'journey_to_the_west': {
      'zh': '《西游记》是中国古代四大名著之一，成书于明代。全书共一百回，讲述齐天大圣孙悟空因大闹天宫被压于五行山下五百年，后受观音菩萨点化，与猪八戒、沙悟净一同护送大唐高僧玄奘法师西天取经的宏大传奇。师徒四人跋涉十万八千里，历经九九八十一难，一路斩妖除魔，不仅战胜了白骨精、红孩儿、铁扇公主与牛魔王等诸多妖魔，更在心性磨砺中完成了从凡俗到成佛的灵性蜕变。小说融合了儒、释、道三家思想，以奇幻浪漫的想象、幽默诙谐的笔调和深刻的社会隐喻，构筑了一座世界文学史上无可逾越的东方奇幻神魔史诗。',
      'en': 'Journey to the West (Xi You Ji) is one of the Four Great Classical Novels of Chinese literature, attributed to Wu Cheng\'en in the Ming Dynasty. Across 100 chapters, it chronicles the sweeping mythical pilgrimage of the Buddhist monk Xuanzang (Tripitaka) and his three extraordinary supernatural disciples—Sun Wukong (The Monkey King), Zhu Bajie (Pigsy), and Sha Wujing (Sandy)—as they journey 108,000 li westward toward India in search of sacred Buddhist sutras. Overcoming eighty-one perilous tribulations, monstrous demons, and moral trials, the epic blends Daoist alchemy, Buddhist philosophy, and satirical folklore into an immortal masterpiece of resilience, enlightenment, and divine humor.',
    },
    'romance_of_three_kingdoms': {
      'zh': '《三国演义》是中国古代历史演义小说的巅峰之作，由元末明初罗贯中根据正史《三国志》与民间传说加工而成。全书一百二十回，全景式地展现了从东汉末年黄巾起义爆发，到魏、蜀、吴三国鼎立争霸，直至西晋统一全国的百年波澜壮阔的历史风云。书中塑造了智绝诸葛亮、义绝关羽、奸绝曹操、勇绝张飞与仁德刘备等四百多位栩栩如生的人物形象。从桃园结义、煮酒论英雄、官渡之战，到赤壁之战借东风、七擒孟获、秋风五丈原，小说将军事韬略、政治博弈与人性忠烈展现得淋漓尽致，被誉为“中国传统智慧之百科全书”。',
      'en': 'Romance of the Three Kingdoms is the crowning historical epic of classical Chinese literature, compiled by Luo Guanzhong across 120 monumental chapters. Spanning over a century of turbulence from the decline of the Han dynasty through the rise and fall of the Three Kingdoms (Wei, Shu, and Wu), the saga weaves grand military strategy, statecraft, and human drama. It introduces immortal archetypes such as the brilliant strategist Zhuge Liang, the loyal martial paragon Guan Yu, the ambitious warlord Cao Cao, and the benevolent Liu Bei. From the Oath of the Peach Garden to the fiery Battle of Red Cliffs, it remains an eternal encyclopedia of Eastern strategy, chivalry, and tragic heroism.',
    },
    'water_margin': {
      'zh': '《水浒传》是中国古典文学中第一部描写农民起义的白话长篇小说，由施耐庵在宋元话本基础上创作完成。全书共一百二十回，讲述北宋末年朝政腐败、奸臣当道，以宋江、卢俊义、林冲、武松、鲁智深、李逵等为代表的一百零八位好汉，因不堪官逼民反，在山东水泊梁山结义聚义、惩恶扬善的英雄史诗。从林教头风雪山神庙、鲁提辖拳打镇关西、武松景阳冈打虎，到三打祝家庄、梁山大聚义与南征方腊的悲壮结局，作品深刻揭示了封建社会的黑暗与正义反抗的宿命，洋溢着豪迈悲壮的英雄气概。',
      'en': 'Water Margin (Outlaws of the Marsh) is the pioneering classical Chinese novel of heroic rebellion, authored by Shi Nai\'an across 120 epic chapters. Set in the twilight years of the Northern Song Dynasty, it recounts how 108 righteous heroes and outlaws—each bearing unique martial prowess and driven outside the law by tyrannical and corrupt imperial officials—gather at the impenetrable marsh of Mount Liang. United by an oath of brotherhood and social justice, figures like Wu Song, Lin Chong, Lu Zhishen, and Song Jiang battle corrupted governors before facing the tragic ironies of imperial amnesty, creating a breathtaking epic of honor and camaraderie.',
    },
    'dream_of_red_chamber': {
      'zh': '《红楼梦》是中国古代白话小说的至高巅峰与古典文学的集大成者，由清代曹雪芹倾尽毕生心血著成。全书一百二十回，以贾宝玉、林黛玉、薛宝钗的木石前盟与金玉良缘之爱情悲剧为主线，通过荣国府、宁国府四大家族的由盛转衰，全方位、多维度地解剖了封建晚期的社会结构、宗法家族、礼教伦理与人生百态。书中描摹了大观园中的儿女情长、诗社酬唱，与家族败落时的抄家获罪、树倒猢狲散形成鲜明对照。“满纸荒唐言，一把辛酸泪”，小说具有极其深邃的哲学反思与无与伦比的美学价值。',
      'en': 'Dream of the Red Chamber (The Story of the Stone) is revered as the supreme pinnacle of Chinese prose fiction, crafted by Cao Xueqin during the Qing Dynasty. Spanning 120 chapters, it chronicles the poignant love triangle between the spiritual Jia Baoyu, the fragile and poetic Lin Daiyu, and the dutiful Xue Baochai, set against the opulent rise and tragic collapse of the aristocratic Jia clan. Through the miniature paradise of the Grand View Garden and the inexorable decay of aristocratic society, the novel explores profound Buddhist-Daoist themes of illusion, mortal impermanence, familial destiny, and the bittersweet beauty of memory.',
    },
    'the_art_of_war': {
      'zh': '《孙子兵法》是中国现存最早的兵书，也是世界上最早的军事著作，被誉为“兵学圣典”与“百代兵家之祖”，由春秋时期齐国名将孙武所著。全书共十三篇，立足于深邃的辩证法思想，系统阐述了战争规律、战略谋划、用兵谋略与治军用人之道。从“知己知彼，百战不殆”、“不战而屈人之兵”的至高境界，到“兵者诡道也”、“致人而不致于人”的灵活战术，《孙子兵法》超越了单纯的军事范畴，广泛应用于现代商业竞争、外交博弈与人生处世智慧。',
      'en': 'The Art of War by Sun Tzu is the most influential military and strategic treatise in world history, composed in the Spring and Autumn period. Spanning thirteen profound chapters, it delivers timeless principles of leadership, psychological warfare, resource management, and strategic calculations. Emphasizing that supreme excellence consists of breaking the enemy\'s resistance without fighting, Sun Tzu\'s philosophical insights on deception, adaptability, terrain, and knowing oneself and the adversary have profoundly shaped global military thought, business management, and modern strategic philosophy.',
    },
    'dao_de_jing': {
      'zh': '《道德经》（又称《老子》）是先秦道家学派的开山奠基巨著，相传为春秋末期思想家老子所著，全文八十一章五千余言。上篇《道经》探讨天地宇宙的本源与运行规律，提出“道法自然”、“无为而治”的至高哲学；下篇《德经》阐述处世治国之德，倡导“上善若水”、“大巧若拙”、“柔弱胜刚强”的处世智慧。作品文约义丰、辞简理赜，不仅是中华民族精神特质与哲学思维的重要源泉，也是对全人类思想宝库做出卓越贡献的世界级经典。',
      'en': 'The Tao Te Ching (Daodejing) is the foundational text of Daoist philosophy, traditionally attributed to the ancient sage Laozi. Comprising 81 poetic and aphoristic chapters, the text explores the Tao (The Way)—the fundamental, nameless principle behind the cosmos—and De (Virtue)—the natural expression of harmony with the universe. Advocating wu wei (effortless action), supreme humility like water, and simplicity, this seminal work remains one of the most translated and influential philosophical masterpieces in human civilization.',
    },
    'the_analects': {
      'zh': '《论语》是儒家学派的经典巨著之一，由孔子弟子及再传弟子记录孔子及其弟子言行而成。全书共二十篇，集中体现了孔子在政治、哲学、教育、伦理及人生修养方面的核心思想。其以“仁”为核心追求，以“礼”为行为规范，倡导“学而时习之”、“温故而知新”的治学态度，以及“己所不欲，勿施于人”、“三人行必有我师焉”的谦和品德。两千多年来，《论语》深刻塑造了中华民族的文化心理、道德伦理与价值追求。',
      'en': 'The Analects of Confucius (Lun Yu) is the core foundational scripture of Confucianism, compiled by disciples to record the teachings, dialogues, and philosophical discourses of Master Kong (Confucius). Across 20 thematic chapters, it articulates ideals of Ren (Benevolence), Li (Ritual Propriety), filial piety, and righteous governance. Promoting life-long learning and moral self-cultivation, The Analects has served for over two millennia as the ethical compass and cultural backbone of East Asian civilization.',
    },
    'records_grand_historian': {
      'zh': '《史记》是中国历史上第一部纪传体通史，由西汉史学家司马迁历经数十年艰辛著成，被鲁迅誉为“史家之绝唱，无韵之离骚”。全书一百三十篇，记载了从上古传说中的黄帝时代至汉武帝太初四年共三千多年的历史。全书涵盖本纪、表、书、世家、列传五种体裁，以宏大的历史视野、严谨的实录精神和生动传神的文学笔触，塑造了项羽、刘邦、陈胜、荆轲、韩信等无数鲜活的历史人物，开创了中国史学与传记文学的崭新纪元。',
      'en': 'Records of the Grand Historian (Shiji) by Sima Qian of the Western Han Dynasty is the monumental foundational text of Chinese historiography and biographical literature. Spanning 130 expansive chapters and over 3,000 years of history from the mythical Yellow Emperor to Emperor Wu of Han, Sima Qian pioneered the biographical-thematic format (jizhuanti). Celebrated by Lu Xun as "the grandest song of historians, a rhymeless Li Sao," it blends rigorous historical truth with sublime literary dramatization.',
    },
  };

  int updatedCount = 0;

  for (final item in list) {
    final book = item as Map<String, dynamic>;
    final id = book['id'] as String;
    final bookFile = File('assets/data/books/$id.json');

    // 1. Sync total chapters with actual file
    if (bookFile.existsSync()) {
      try {
        final chapters = jsonDecode(bookFile.readAsStringSync()) as List<dynamic>;
        if (chapters.isNotEmpty) {
          book['totalChapters'] = chapters.length;
        }
      } catch (_) {}
    }

    // 2. Enrich synopses
    final custom = richSynopses[id];
    if (custom != null) {
      book['description'] = custom['zh'];
      book['descriptionEn'] = custom['en'];
    } else {
      final oldZh = (book['description'] as String?) ?? '';
      final oldEn = (book['descriptionEn'] as String?) ?? '';
      final title = book['title'] as String;
      final titleEn = book['titleEn'] as String;
      final author = book['author'] as String;
      final authorEn = book['authorEn'] as String;
      final dynasty = book['dynastyOrEra'] as String;
      final category = book['category'] as String;

      if (!oldZh.contains('《') || oldZh.length < 50) {
        book['description'] = '《$title》是$author在$dynasty时期创作的$category代表巨著。$oldZh 作品融汇了深厚的人文精神与精妙的艺术构思，以生动的叙事与跌宕起伏的情节，深刻展现了时代的变迁与人性的光辉，具有历久弥新的思想魅力与世界文学价值。';
        book['descriptionEn'] = '"$titleEn" is a classic masterpiece composed by $authorEn during the $dynasty era. $oldEn Celebrated worldwide as a defining jewel of $category, it delves into timeless human experiences, moral dilemmas, and cultural resonance with extraordinary literary artistry.';
      }
    }

    updatedCount++;
  }

  catalogFile.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(list));
  print('=== Successfully updated $updatedCount book synopses and chapter counts in catalog! ===');
}
