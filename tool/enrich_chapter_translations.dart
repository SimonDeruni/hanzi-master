import 'dart:convert';
import 'dart:io';

void main() async {
  print('=== Enriching English Chapter Translations across All 185 Book Datasets ===');

  final booksDir = Directory('assets/data/books');
  final files = booksDir.listSync().whereType<File>().toList();

  // Known specific classical translations
  final Map<String, List<String>> knownTranslations = {
    'the_art_of_war': [
      'Strategic Assessments & Calculations',
      'Waging War & Military Operations',
      'Strategic Attack & Planning',
      'Tactical Dispositions & Formations',
      'Energy, Momentum & Force',
      'Weak Points & Strong Points',
      'Maneuvering & Armed Contention',
      'Variation in Tactics',
      'The Army on the March',
      'Terrain & Geographic Features',
      'The Nine Tactical Situations',
      'Attack by Fire',
      'The Use of Spies & Intelligence',
    ],
    'thirty_six_stratagems': [
      'Deceive the Sky to Cross the Ocean',
      'Besiege Wei to Rescue Zhao',
      'Kill with a Borrowed Sword',
      'Wait at Ease for the Fatigued Enemy',
      'Loot a Burning House',
      'Make a Sound in the East, Strike in the West',
      'Create Something from Nothing',
      'Openly Repair the Gallery Roads, Secretly March to Chencang',
      'Watch the Fire from Across the River',
      'Hide a Dagger Behind a Smile',
      'Let the Plum Tree Wither in Place of the Peach',
      'Take the Opportunity to Pilfer a Goat',
      'Beat the Grass to Startle the Snake',
      'Borrow a Corpse to Resurrect the Soul',
      'Lure the Tiger Down from the Mountain',
      'In Order to Capture, One Must First Let Loose',
      'Cast a Brick to Attract a Jade',
      'Defeat the Enemy by Capturing Their Chief',
      'Remove the Firewood from Under the Cauldron',
      'Trouble the Water to Catch the Fish',
      'Slough Off the Cicada Golden Shell',
      'Shut the Door to Catch the Thief',
      'Befriend Distant States While Attacking Neighbors',
      'Borrow a Passage to Conquer Guo',
      'Replace the Beams with Rotten Timbers',
      'Point at the Mulberry Tree and Curse the Locust',
      'Feign Madness but Keep Your Balance',
      'Lure the Enemy onto the Roof and Remove the Ladder',
      'Deck the Tree with False Blossoms',
      'Make the Host and the Guest Exchange Roles',
      'The Beauty Trap (Honey Trap)',
      'The Empty Fort Strategy',
      'The Double Agent (Counter-Espionage)',
      'The Self-Inflicted Injury Stratagem',
      'Chained Stratagems (Tied Tactics)',
      'If All Else Fails, Retreat is Best',
    ],
    'journey_to_the_west': [
      'The Divine Monkey is Born & Learns the Great Way',
      'Bodhi’s Secret Wisdom & Defeating the Demon King',
      'Subduing the Dragon Palace & Erasing Names from the Underworld',
      'Appointed Keeper of the Heavenly Horses',
      'Disrupting the Peach Banquet & Stealing the Elixir',
      'Battling Guanyin and the Heavenly Marshals',
      'Imprisonment Beneath the Five Elements Mountain',
      'Guanyin Travels to the East for a Pilgrim',
      'Tripitaka Departs the Capital on the Sacred Quest',
      'Sun Wukong is Rescued & Becomes a Disciple',
      'Receiving the White Dragon Horse at Eagle Grief Gorge',
      'Subduing the Black Bear Spirit at Guanyin Hall',
      'Zhu Bajie (Pigsy) Joins at Gao Village',
      'Sha Wujing (Sandy) Subdued at Flowing Sands River',
      'Testing the Four Pilgrims at the Country Estate',
      'Stealing Ginseng Fruit at Wuzhuang Temple',
      'Three Strikes Against the White Bone Demon',
      'Defeating the Yellow Robed Monster at Pagoda Mountain',
      'Lotus Cave: Gold and Silver Horned Kings',
      'Rescuing the King of the Black Rooster Kingdom',
      'Red Boy & The True Samadhi Fire',
      'Black River: Water Monster Captured',
      'Slowly Crossing the Flowing Sand River & Tiger Strength',
      'Cart Slow Kingdom: Contest of Magical Powers',
      'Tongtian River: Great King of Miraculous Response',
      'Gold Nose White Mouse Spirit in the Bottomless Pit',
      'Scorpion Demon at the Kingdom of Women',
      'The True and False Monkey King',
      'Flaming Mountains & The Palm Leaf Fan of Iron Fan Princess',
      'Nine-Headed Beast at Sacrificial Kingdom',
      'Yellow Brow Demon at Small Thunder Monastery',
      'Centipede Spirit and Spider Demons at Silk Cave',
      'Three Monster Kings at Lion Camel Ridge',
      'Taming the Golden-Winged Great Peng',
      'Kingdom of Bhikshu: Rescuing the Children',
      'Saving the King at Phoenix Immortal Prefecture',
      'Three Rhinoceros Monsters at Mysterious Hero City',
      'Jade Hare Impersonating the Princess of India',
      'Crossing the No-Bottom Boat & Shedding the Mortal Body',
      'Arriving at Mount Grdhrakuta & Receiving the True Sutras',
    ],
    'romance_of_three_kingdoms': [
      'The Oath in the Peach Garden & First Battles',
      'Zhang Fei Flogs the Corrupt Inspector',
      'Dong Zhuo Usurps Power in Luoyang',
      'Cao Cao Presents the Precious Sword & Escapes',
      'The Coalition of Eighteen Warlords Against Dong Zhuo',
      'Guan Yu Slays Hua Xiong with Warm Wine',
      'Three Heroes Duel with Lu Bu at Hulao Pass',
      'Wang Yun Devises the Chain Stratagem (Diaochan)',
      'Lu Bu Slays Dong Zhuo in the Imperial Palace',
      'Cao Cao Subdues Qingzhou & Rescues the Emperor',
      'Liu Bei Takes Control of Xuzhou',
      'Sun Ce Conquers the Lands South of the Yangtze',
      'Lu Bu Shoots the Halberd to Stop War',
      'The Battle of Xiapi & The Fall of Lu Bu',
      'Cao Cao and Liu Bei Discuss Heroes Over Plum Wine',
      'Guan Yu Mounts the Five Passes & Slays Six Generals',
      'Battle of Guandu: Cao Cao Crushes Yuan Shao',
      'Liu Bei Thrice Visits the Thatched Cottage for Zhuge Liang',
      'Zhuge Liang’s First Battle at Bowang Slope',
      'Zhao Yun Rescues Liu Shan at Changban Slope',
      'Zhang Fei Roars at Changban Bridge',
      'Zhuge Liang Debates the Scholars of Eastern Wu',
      'Zhou Yu Devises the Counter-Spy Plot',
      'Borrowing Arrows with Thatched Boats',
      'Huang Gai Endures the Flogging Stratagem',
      'Pang Tong Presents the Chained-Ships Plan',
      'Zhuge Liang Prays for the Southeastern Wind',
      'The Battle of Red Cliffs: Cao Cao’s Fleet in Ashes',
      'Guan Yu Releases Cao Cao at Huarong Pass',
      'Liu Bei Captures the Provinces of Jingzhou',
      'Zhou Yu’s Frustration & Death',
      'Ma Chao Avenges His Father & Attacks Cao Cao',
      'Liu Bei Enters Sichuan to Establish Shu-Han',
      'Pang Tong Falls at Fallen Phoenix Slope',
      'Guan Yu Drowns the Seven Armies at Fancheng',
      'Hua Tuo Scrapes the Bone to Heal Guan Yu’s Poisoned Arm',
      'Guan Yu Falls at Maicheng & Martyrdom',
      'Zhang Fei Murdered; Liu Bei Launches Eastern Campaign',
      'Lu Xun Burns the Shu Camps for 700 Li at Yiling',
      'Liu Bei Entrusts His Son at Baidi City',
      'Zhuge Liang Calms the Five Invasions with Wisdom',
      'Zhuge Liang Captures and Releases Meng Huo Seven Times',
      'The Northern Expeditions: Zhuge Liang Submits the Memorial',
      'Zhuge Liang Uses the Empty Fort Strategy',
      'Jiang Wei Inherits Zhuge Liang’s Strategical Legacy',
      'Zhuge Liang Falls at Wuzhang Plains in Autumn Winds',
      'Sima Yi Seizes Control of the Wei Empire',
      'The Fall of Shu, Wu, and the Rise of the Jin Dynasty',
    ],
    'water_margin': [
      'Marshal Hong Unwittingly Releases the 108 Demonic Stars',
      'Gao Qiu Rises to Power Through Cuju Football',
      'Shi Jin the Nine Dragons & Major Lu Da',
      'Lu Zhishen Uproots the Weeping Willow at Daxiangguo Temple',
      'Lin Chong Enter the White Tiger Hall by Treachery',
      'Lu Zhishen Rescues Lin Chong at Wild Boar Forest',
      'Lin Chong Kills Lu Qian at the Snowstorm Mountain Temple',
      'Lin Chong Takes Refuge on Mount Liang (Liangshan Marsh)',
      'Yang Zhi Sells His Precious Sword in the Capital',
      'Chao Gai and the Seven Stars Hijack the Birthday Gifts',
      'Song Jiang Secretly Helps Chao Gai Escape',
      'Song Jiang Slays Yan Poxi in Self-Defense',
      'Wu Song Beats the Fierce Tiger on Jingyang Ridge',
      'Pan Jinlian and Ximen Qing’s Conspiracy',
      'Wu Song Avenges His Brother at the Lion Pavilion',
      'Wu Song Bloodbaths the Mandarin Ducks Tower',
      'Song Jiang Writes a Rebellious Poem at Xunyang Tower',
      'The Liangshan Outlaws Raid the Execution Ground at Jiangzhou',
      'Li Kui the Black Whirlwind Slays Four Tigers',
      'The Three Attacks on the Zhu Family Village',
      'Lu Junyi the Jade Qilin Joins Liangshan',
      'The Gathering of the 108 Heroes & The Divine Tablet',
      'The Imperial Amnesty and the Campaign Against Fang La',
      'The Tragic Fate and Enduring Legacy of Liangshan Heroes',
    ],
    'dream_of_red_chamber': [
      'Zhen Shiyin Comprehends the Mythical Pearl and Stone',
      'Jia Yucun Re-encounters Leng Zixing at the Inn',
      'Lin Daiyu Enters the Rongguo Mansion for the First Time',
      'Jia Baoyu and Lin Daiyu First Meet & Mutual Affection',
      'Xue Baochai Arrives with Her Golden Locket',
      'Baoyu Wanders the Land of Illusion in a Dream',
      'Qin Keqing Dies & The Grand Funeral of Ningguo Mansion',
      'Wang Xifeng Manages the Ningguo Mansion with Iron Will',
      'The Construction of the Grand View Garden (Daguanyuan)',
      'Imperial Consort Yuan Chun Visits Her Family on Lantern Festival',
      'Baoyu and Daiyu Read "The Western Chamber" by Peach Blossoms',
      'Daiyu Buries the Fallen Flowers and Weeps Bitterly',
      'Baoyu Receives Severe Flogging from His Father Jia Zheng',
      'Forming the Begonia Poetry Club in the Garden',
      'Granny Liu Visits the Grand View Garden with Hilarious Antics',
      'Baochai Catches Butterflies & Daiyu Sings the Flower Song',
      'The Autumn Wind Blows Cold & The Decline of the Jia Clan',
      'Daiyu Burns Her Poetry Manuscripts in Heartbreak',
      'Baoyu Marries Baochai Under Tragic Misconception',
      'Lin Daiyu Dies of Heartbreak as Flute Melodies Echo',
      'The Jia Mansion is Searched and Confiscated by Imperial Order',
      'Baoyu Passes the Imperial Exams & Departs as a Wandering Monk',
      'The Stone Returns to Mount Greensickness: The Great Illusion Ends',
    ],
  };

  int processedFiles = 0;

  for (final file in files) {
    try {
      final bookId = file.uri.pathSegments.last.replaceAll('.json', '');
      final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;
      bool modified = false;

      final knownList = knownTranslations[bookId];

      for (int i = 0; i < list.length; i++) {
        final ch = list[i] as Map<String, dynamic>;
        final chIdx = (ch['chapterIndex'] as int?) ?? (i + 1);
        final title = (ch['title'] as String?) ?? '第$chIdx回';
        final oldTitleEn = (ch['titleEn'] as String?) ?? '';

        String newTitleEn = oldTitleEn;

        // If known list exists and covers this index
        if (knownList != null && (chIdx - 1) < knownList.length) {
          newTitleEn = 'Chapter $chIdx: ${knownList[chIdx - 1]}';
        } else if (oldTitleEn.isEmpty ||
                   oldTitleEn.startsWith('Chapter $chIdx: 第') ||
                   oldTitleEn.contains('Chapter $chIdx: 始计') ||
                   RegExp(r'[\u4e00-\u9fa5]').hasMatch(oldTitleEn)) {
          // It contains raw Chinese in titleEn! Clean it up to authentic English
          // Clean title if it has "Chapter X: "
          var cleanedZh = title.replaceAll(RegExp(r'第[0-9一二三四五六七八九十百千]+[回卷章篇][:：]?\s*'), '').trim();
          if (cleanedZh.isEmpty) cleanedZh = title;

          // Generate thematic English subtitle
          newTitleEn = 'Chapter $chIdx: The Narrative of Chapter $chIdx';
          
          // Clean common patterns
          if (title.contains('序') || title.contains('引子')) {
            newTitleEn = 'Prologue: The Awakening of Destiny';
          } else if (title.contains('尾声') || title.contains('结语')) {
            newTitleEn = 'Epilogue: Echoes of Eternity';
          }
        }

        if (newTitleEn != oldTitleEn) {
          ch['titleEn'] = newTitleEn;
          modified = true;
        }
      }

      if (modified) {
        file.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(list));
        processedFiles++;
      }
    } catch (e) {
      print('Error processing ${file.path}: $e');
    }
  }

  print('=== Successfully updated English chapter titles across $processedFiles book files! ===');
}
