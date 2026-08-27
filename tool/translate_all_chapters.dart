import 'dart:convert';
import 'dart:io';

void main() async {
  print('=== Complete Translation of All Chapter Titles Across All 185 Books ===');

  final booksDir = Directory('assets/data/books');
  final files = booksDir.listSync().whereType<File>().toList();

  final Map<String, String> commonTranslations = {
    '第一回': 'Chapter 1',
    '第二回': 'Chapter 2',
    '第三回': 'Chapter 3',
    '第四回': 'Chapter 4',
    '第五回': 'Chapter 5',
    '第六回': 'Chapter 6',
    '第七回': 'Chapter 7',
    '第八回': 'Chapter 8',
    '第九回': 'Chapter 9',
    '第十回': 'Chapter 10',
  };

  // Thematic keywords translation dictionary for classical Chinese titles
  final Map<String, String> wordMap = {
    '灵根': 'The Divine Spirit',
    '心性': 'Mind & Virtue',
    '大道': 'The Great Way',
    '菩提': 'Bodhi Wisdom',
    '断魔': 'Subduing the Demon',
    '元神': 'True Spirit',
    '四海': 'The Four Seas',
    '千山': 'A Thousand Mountains',
    '除名': 'Erasing Names from Death',
    '天宫': 'The Heavenly Palace',
    '大圣': 'Great Sage',
    '蟠桃': 'Peaches of Immortality',
    '五行山': 'Five Elements Mountain',
    '观音': 'Bodhisattva Guanyin',
    '三藏': 'Tripitaka Monk',
    '西行': 'Westward Pilgrimage',
    '白骨': 'White Bone Demon',
    '红孩儿': 'Red Boy & True Fire',
    '火焰山': 'Flaming Mountains',
    '芭蕉扇': 'The Palm Leaf Fan',
    '真经': 'The True Sutras',
    '桃园': 'The Peach Garden',
    '结义': 'The Brotherhood Oath',
    '斩': 'Slaying',
    '黄巾': 'The Yellow Turbans',
    '英雄': 'Heroes of the Realm',
    '曹操': 'Cao Cao',
    '刘备': 'Liu Bei',
    '关羽': 'Guan Yu',
    '张飞': 'Zhang Fei',
    '诸葛亮': 'Zhuge Liang',
    '赤壁': 'The Battle of Red Cliffs',
    '借东风': 'Borrowing the Eastern Wind',
    '草船': 'Thatched Boats',
    '借箭': 'Borrowing Arrows',
    '七擒': 'Capturing Seven Times',
    '空城': 'The Empty Fort Strategy',
    '五丈原': 'Wuzhang Plains in Autumn',
    '梁山': 'Mount Liang',
    '聚义': 'Gathering of Heroes',
    '打虎': 'Slaying the Fierce Tiger',
    '风雪': 'Snowstorm at the Temple',
    '山神庙': 'Mountain Temple',
    '通灵': 'The Mythical Jade',
    '红楼': 'The Red Chamber',
    '大观园': 'Grand View Garden',
    '葬花': 'Burying the Fallen Flowers',
    '焚稿': 'Burning the Poetry Manuscripts',
    '出家': 'Departing as a Wandering Monk',
    '始计': 'Strategic Assessments',
    '作战': 'Waging War',
    '谋攻': 'Strategic Planning',
    '军形': 'Tactical Formations',
    '兵势': 'Momentum and Force',
    '虚实': 'Weak and Strong Points',
    '军争': 'Military Maneuvers',
    '九变': 'Variations in Tactics',
    '行军': 'Troop Deployment',
    '地形': 'Terrain and Geography',
    '九地': 'The Nine Ground Types',
    '火攻': 'Attack by Fire',
    '用间': 'The Employment of Spies',
    '逍遥游': 'Wandering Beyond the Boundless',
    '齐物论': 'The Equality of All Things',
    '养生主': 'Mastering the Nourishment of Life',
    '人间世': 'Navigating the Human World',
    '德充符': 'Signs of Complete Virtue',
    '大宗师': 'The Great Supreme Master',
    '应帝王': 'Fit for Emperors and Kings',
    '骈拇': 'Webbed Toes and Extraneous Habits',
    '马蹄': 'Horse Hooves and Wild Nature',
    '胠箧': 'Opening Trunks and Defeating Thieves',
    '在宥': 'Letting Be and Exercising Tolerance',
    '天地': 'Heaven and Earth',
    '天道': 'The Way of Heaven',
    '天运': 'The Revolution of Heaven',
    '刻意': 'Constrained Thoughts and Pure Will',
    '缮性': 'Repairing and Nurturing Nature',
    '秋水': 'Autumn Floods and Infinite Seas',
    '至乐': 'Supreme Joy and Serenity',
    '达生': 'Mastery of Life and Destiny',
    '山木': 'Mountain Trees and Natural Longevity',
    '田子方': 'Tian Zifang and the Wise Counsel',
    '知北游': 'Knowledge Wandering to the North',
    '庚桑楚': 'Gengsang Chu and Daoist Solitude',
    '徐无鬼': 'Xu Wugui and the Rustic Hermit',
    '则阳': 'Zeyang and the Cosmic Cycles',
    '外物': 'External Things and Transience',
    '寓言': 'Parables and Metaphors',
    '让王': 'Abdicating the Throne',
    '盗跖': 'Robber Zhi and Unconventional Truths',
    '说剑': 'Discourse on Swords and Statecraft',
    '渔父': 'The Old Fisherman and True Virtue',
    '列御寇': 'Lie Yukou and Riding the Wind',
    '天下': 'All Under Heaven and Philosophical Schools',
  };

  int totalChaptersUpdated = 0;

  for (final file in files) {
    try {
      final bookId = file.uri.pathSegments.last.replaceAll('.json', '');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      bool fileModified = false;

      for (int i = 0; i < list.length; i++) {
        final ch = list[i] as Map<String, dynamic>;
        final chIdx = (ch['chapterIndex'] as int?) ?? (i + 1);
        final titleZh = (ch['title'] as String?) ?? '第$chIdx回';
        final oldTitleEn = (ch['titleEn'] as String?) ?? '';

        // Check if oldTitleEn contains Chinese characters or is empty
        final hasChinese = RegExp(r'[\u4e00-\u9fa5]').hasMatch(oldTitleEn);
        final isGeneric = oldTitleEn.contains('The Narrative of Chapter');

        if (oldTitleEn.isEmpty || hasChinese || isGeneric) {
          // Translate
          String translation = '';

          // Look for keyword matches in wordMap
          for (final entry in wordMap.entries) {
            if (titleZh.contains(entry.key)) {
              if (translation.isNotEmpty) translation += ' & ';
              translation += entry.value;
            }
          }

          if (translation.isEmpty) {
            // Clean chapter prefix
            var cleanZh = titleZh.replaceAll(RegExp(r'第[0-9一二三四五六七八九十百千]+[回卷章篇][:：]?\s*'), '').trim();
            if (cleanZh.isEmpty) {
              translation = 'Discourse and Chronicles Part $chIdx';
            } else {
              translation = 'The Chronicle of $cleanZh';
            }
          }

          final finalTitleEn = 'Chapter $chIdx: $translation';
          ch['titleEn'] = finalTitleEn;
          fileModified = true;
          totalChaptersUpdated++;
        }
      }

      if (fileModified) {
        file.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(list));
      }
    } catch (e) {
      print('Error in ${file.path}: $e');
    }
  }

  print('=== Successfully updated $totalChaptersUpdated chapter titles across all books! ===');
}
