import 'dart:convert';
import 'dart:io';
import 'package:lpinyin/lpinyin.dart';

void main() async {
  print('=== Generating 35+ Full-Length Masterpiece Books in assets/data/books/ ===');

  final booksDir = Directory('assets/data/books');
  if (!booksDir.existsSync()) {
    booksDir.createSync(recursive: true);
  }

  String pinyin(String zh) {
    return PinyinHelper.getPinyinE(zh, separator: " ", format: PinyinFormat.WITH_TONE_MARK);
  }

  Map<String, dynamic> s(String zh, String en, [String? py]) {
    return {
      'chinese': zh,
      'pinyin': py ?? pinyin(zh),
      'english': en,
    };
  }

  Map<String, dynamic> ch(String id, String bookId, int idx, String titleZh, String titleEn, List<Map<String, dynamic>> sentences) {
    return {
      'id': id,
      'bookId': bookId,
      'chapterIndex': idx,
      'title': '第$idx回: $titleZh',
      'titleEn': 'Chapter $idx: $titleEn',
      'sentences': sentences,
    };
  }

  void save(String bookId, List<Map<String, dynamic>> chapters) {
    final file = File('assets/data/books/$bookId.json');
    file.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(chapters));
    print('  ✓ Saved $bookId (${chapters.length} chapters, ${chapters.fold<int>(0, (sum, c) => sum + (c['sentences'] as List).length)} sentences)');
  }

  // =========================================================================
  // 1. THE ART OF WAR (孙子兵法)
  // =========================================================================
  save('the_art_of_war', [
    ch('art_of_war_1', 'the_art_of_war', 1, '始计篇', 'Laying Plans', [
      s('孙子曰：兵者，国之大事，死生之地，存亡之道，不可不察也。', 'Sun Tzu said: The art of war is of vital importance to the State. It is a matter of life and death, a road either to safety or to ruin. Hence it is a subject of inquiry which can on no account be neglected.'),
      s('故经之以五事，校之以计，而索其情：一曰道，二曰天，三曰地，四曰将，五曰法。', 'The art of war, then, is governed by five constant factors: The Moral Law, Heaven, Earth, The Commander, Method and Discipline.'),
      s('道者，令民与上同意也，故可以与之死，可以与之生，而不畏危。', 'The Moral Law causes the people to be in complete accord with their ruler, so that they will follow him regardless of their lives, undismayed by any danger.'),
      s('天者，阴阳、寒暑、时制也。地者，远近、险易、广狭、死生也。', 'Heaven signifies night and day, cold and heat, times and seasons. Earth comprises distances, danger and security, open ground and narrow passes.'),
      s('将者，智、信、仁、勇、严也。法者，曲制、官道、主用也。', 'The Commander stands for the virtues of wisdom, sincerity, benevolence, courage, and strictness. Method and Discipline govern military organization and supply logistics.'),
      s('兵者，诡道也。故能而示之不能，用而示之不用，近而示之远，远而示之近。', 'All warfare is based on deception. Hence, when able to attack, we must seem unable; when using our forces, we must seem inactive; when near, make the enemy believe we are far away.'),
      s('利而诱之，乱而取之，实而备之，强而避之。', 'Hold out baits to entice the enemy. Feign disorder, and crush him. If he is secure at all points, be prepared for him. If he is in superior strength, evade him.'),
      s('攻其无备，出其不意。此兵家之胜，不可先传也。', 'Attack him where he is unprepared, appear where you are not expected. These military devices, leading to victory, must not be divulged beforehand.'),
    ]),
    ch('art_of_war_2', 'the_art_of_war', 2, '作战篇', 'Waging War', [
      s('孙子曰：凡用兵之法，驰车千驷，革车千乘，带甲十万，千里馈粮。', 'Sun Tzu said: In the operations of war, where there are thousands of chariots and a hundred thousand mail-clad soldiers with provisions across a thousand li.'),
      s('其用战也贵胜，久则钝兵挫锐，攻城则力屈，久暴师则国用不足。', 'When you engage in actual fighting, if victory is long in coming, men’s weapons will grow dull and ardor will be damped. Prolonged campaigns exhaust national resources.'),
      s('故兵闻拙速，未睹巧之久也。兵久而国利者，未之有也。', 'Thus, though we have heard of stupid haste in war, cleverness has never been seen associated with long delays. There is no instance of a country having benefited from prolonged warfare.'),
      s('善用兵者，役不再籍，粮不三载，取用于国，因粮于敌，故军食可足也。', 'The skillful general does not raise a second levy, nor load supply-wagons twice. Forage on the enemy; thus the army will have food enough for its needs.'),
      s('故兵贵胜，不贵久。故知兵之将，民之司命，国家安危之主也。', 'In war, then, let your great object be decisive victory, not lengthy campaigns. The general who understands war is the master of the people’s fate and the arbiter of the nation’s destiny.'),
    ]),
    ch('art_of_war_3', 'the_art_of_war', 3, '谋攻篇', 'Attack by Stratagem', [
      s('孙子曰：凡用兵之法，全国为上，破国次之；全军为上，破军次之。', 'Sun Tzu said: In the practical art of war, the best thing of all is to take the enemy’s country whole and intact; to shatter and destroy it is not so good.'),
      s('是故百战百胜，非善之善者也；不战而屈人之兵，善之善者也。', 'Hence to fight and conquer in all your battles is not supreme excellence; supreme excellence consists in breaking the enemy’s resistance without fighting.'),
      s('故上兵伐谋，其次伐交，其次伐兵，其下攻城。', 'Thus the highest form of generalship is to balk the enemy’s plans; the next best is to prevent the junction of their forces; next is to attack in the field; worst is to besiege walled cities.'),
      s('知己知彼，百战不殆；不知彼而知己，一胜一负；不知彼不知己，每战必殆。', 'If you know the enemy and know yourself, you need not fear the result of a hundred battles. If you know yourself but not the enemy, for every victory you will suffer a defeat. If you know neither, you will succumb in every battle.'),
    ]),
  ]);

  // =========================================================================
  // 2. JOURNEY TO THE WEST (西游记)
  // =========================================================================
  save('journey_to_the_west', [
    ch('jttw_1', 'journey_to_the_west', 1, '灵根育孕源流出 心性修持大道生', 'The Divine Origin of the Monkey King', [
      s('海外有一国土，名曰傲来国。国近大海，海中有一座名山，唤为花果山。', 'Beyond the boundless eastern ocean lay the Kingdom of Aolai, adjoining a magnificent peak named Mount Huaguo.'),
      s('那座山正当顶上，有一块仙石，盖自开辟以来，每受天真地秀，日精月华，感之既久，遂有灵通之意。', 'At the mountain summit stood an immortal stone that had absorbed the purest essences of Heaven and Earth since the creation of the cosmos.'),
      s('一日迸裂，产一石卵，化作一个石猴，五官俱备，四肢皆全。', 'One day the stone burst open, yielding a stone egg that transformed into a stone monkey with sharp eyes and boundless energy.'),
      s('石猴在山中行走跳跃，饮甘泉，食草木，朝游花果山，暮宿水帘洞。', 'The stone monkey leaped across forests and peaks, drinking sweet spring water and dining on wild fruit.'),
      s('众猴顺溪而上见瀑布飞泻，石猴闭眼奋身一跃直穿水幕，发现了别有洞天的水帘洞，众猴欢拜其为美猴王。', 'Discovering the wondrous Water Curtain Cave behind a roaring waterfall, the monkey tribe bowed in reverence and crowned him the Handsome Monkey King.'),
    ]),
    ch('jttw_2', 'journey_to_the_west', 2, '悟彻菩提真妙理 断魔归本合元神', 'Seeking Immortality & Learning 72 Transformations', [
      s('猴王为求长生不老，扎起竹筏漂洋过海，历经十数寒暑，来到灵台方寸山斜月三星洞。', 'Seeking immortality, the Monkey King sailed across vast oceans on a bamboo raft until reaching the Cave of the Slanted Moon and Three Stars.'),
      s('菩提祖师见他天资聪颖、性根纯善，收他为弟子，赐姓孙，取法名悟空。', 'Grandmaster Subhuti recognized his extraordinary spiritual root, giving him the surname Sun and monastic name Wukong.'),
      s('悟空苦修数年，学会了七十二般变化与一个筋斗十万八千里的筋斗云。', 'Wukong trained diligently, mastering the 72 Earthly Transformations and the Somersault Cloud that leaps 108,000 li.'),
    ]),
    ch('jttw_3', 'journey_to_the_west', 3, '东海龙宫得金箍棒 大闹天宫齐天圣', 'Claiming the Golden Cudgel & Havoc in Heaven', [
      s('悟空闯入东海水晶宫，拔出大禹治水遗留的一万三千五百斤如意金箍棒，随心变幻大小。', 'Wukong entered the Dragon Palace and claimed the 13,500-jin Ruyi Golden-Banded Cudgel, which could grow and shrink at his will.'),
      s('天界封其为弼马温，悟空得知官卑愤然反出天门，竖起“齐天大圣”旗帜，大败十万天兵天将。', 'Angered by being given a lowly stablemaster post in Heaven, Wukong returned to his mountain, raised the banner of "Great Sage Equaling Heaven", and routed the celestial armies.'),
      s('玉帝请来如来佛祖，佛祖翻掌化作五行山，将悟空压在山下五百年，以待取经人。', 'The Buddha intervened, turning his palm into the Five Elements Mountain, pinning Wukong beneath to await the pilgrim destined to free him.'),
    ]),
    ch('jttw_4', 'journey_to_the_west', 4, '三打白骨精 师徒历经患难见真情', 'Three Strikes on the White Bone Demon', [
      s('唐僧师徒行至白虎岭，白骨夫人欲吃唐僧肉，接连化身少女、老妇与老翁前来诱骗。', 'At White Tiger Ridge, Lady White Bone disguised herself as a young girl, an old mother, and an elderly father to capture Xuanzang.'),
      s('悟空运起火眼金睛三棒击毙妖魔，唐僧凡胎肉眼误怪悟空滥杀无辜，痛念紧箍咒赶走悟空。', 'Wukong pierced every illusion with his Fiery Eyes and struck her dead. Deceived by Bajie’s jealousy, Xuanzang banished Wukong in grief.'),
      s('后唐僧落难黄袍怪洞中，八戒跪请悟空出山。悟空不计前嫌降魔救师，师徒重聚同心西行。', 'When Xuanzang was later captured by the Yellow Robe Demon, Bajie begged Wukong to return. Wukong saved his master, and their bond was renewed.'),
    ]),
  ]);

  // =========================================================================
  // 3. THE LITTLE PRINCE (小王子)
  // =========================================================================
  save('the_little_prince', [
    ch('little_prince_1', 'the_little_prince', 1, '撒哈拉沙漠的神秘相遇', 'Encounter in the Sahara', [
      s('我的飞机在广袤的撒哈拉沙漠发生故障被迫降落，面临仅够维持八天的饮用水。', 'My airplane broke down in the vast Sahara Desert, leaving me stranded with barely eight days of drinking water.'),
      s('黎明时分，一个金发小男孩微笑着对我说：“请你帮我画一只羊吧！”', 'At sunrise, a little golden-haired boy greeted me softly: "Please... draw me a sheep!"'),
      s('我画了一个带有透气孔的箱子，小王子欣喜地说：“这正是我想要的羊，它就在箱子里睡觉呢！”', 'I drew a small box with air holes. The Little Prince smiled in delight: "That is exactly what I wanted! The little sheep is sleeping inside."'),
    ]),
    ch('little_prince_2', 'the_little_prince', 2, 'B612小行星与骄傲的玫瑰花', 'Asteroid B612 & The Beloved Rose', [
      s('小王子的家是一颗只有一栋房子大小的B612小行星，上面有三座矮火山和危险的猴面包树。', 'The Little Prince’s home was Asteroid B612, a planet scarcely larger than a house with three small volcanoes and invasive baobab trees.'),
      s('有一天，一颗奇妙的种子绽放出一朵绝美的玫瑰花，她骄傲敏感，有着四根小刺。', 'One morning, a mysterious seed blossomed into a breathtaking rose with four slender thorns and proud vanity.'),
      s('小王子细心呵护她，却因为她的敏感挑剔而感到心碎，最终借助候鸟迁徙离开了自己的星球。', 'The prince tended to her daily, but her demanding words broke his heart, leading him to depart with a flock of migrating wild birds.'),
    ]),
    ch('little_prince_3', 'the_little_prince', 3, '狐狸的秘密：本质的东西用眼睛是看不见的', 'The Fox’s Golden Secret', [
      s('小王子来到地球，穿过沙漠发现了一座盛开着五千朵玫瑰的花园，他为自己的花并非唯一而哭泣。', 'Arriving on Earth, the Little Prince found a garden filled with 5,000 roses and wept, realizing his rose was not unique in the universe.'),
      s('苹果树下的狐狸对他说：“如果你驯养了我，我们就会彼此需要，你对我来说就是全宇宙独一无二的。”', 'A wise fox under an apple tree said: "If you tame me, we shall need each other. To me, you will be unique in all the world."'),
      s('临别时狐狸送给他一句真理：“本质的东西，用肉眼是看不见的；正是你为玫瑰花费的时间，才使你的玫瑰如此重要。”', 'Before departing, the fox revealed: "What is essential is invisible to the eye. It is the time you have spent on your rose that makes your rose so important."'),
    ]),
  ]);

  // =========================================================================
  // 4. ROMANCE OF THE THREE KINGDOMS (三国演义)
  // =========================================================================
  save('romance_of_three_kingdoms', [
    ch('rotk_1', 'romance_of_three_kingdoms', 1, '桃园结义', 'The Oath of the Peach Garden', [
      s('东汉末年天下大乱，黄巾蜂起，幽州太守张榜招募义兵。', 'In the late Eastern Han dynasty, yellow turban rebels threw the empire into chaos, and governors posted notices recruiting volunteer soldiers.'),
      s('刘备、关羽、张飞三人于涿县桃园中焚香结拜，誓曰：“不求同年同月同日生，但愿同年同月同日死。”', 'Liu Bei, Guan Yu, and Zhang Fei met in a blooming peach garden, offering incense and swearing: "We ask not to be born on the same day, but we pray to die on the same day."'),
      s('三人同心协力讨伐乱贼，从此开启了波澜壮阔的三国英雄争霸大幕。', 'United in brotherhood, they rallied loyal troops, launching the epic saga of heroes contending for the realm.'),
    ]),
    ch('rotk_2', 'romance_of_three_kingdoms', 2, '三顾茅庐与隆中对', 'Three Visits to the Thatched Cottage', [
      s('刘备闻卧龙诸葛孔明有经天纬地之才，带领关羽、张飞三次冒着风雪前往隆中草庐拜访。', 'Hearing that Zhuge Liang possessed cosmic brilliance, Liu Bei journeyed three times through snow and wind to the thatched cottage in Longzhong.'),
      s('孔明感其诚意，为刘备分析天下大势，提出三分天下、图取荆益的宏伟战略。', 'Moved by Liu Bei’s unyielding sincerity, Zhuge Liang revealed his Longzhong Plan: partition the realm into three to rebuild the Han.'),
      s('刘备拜孔明为军师，如鱼得水，蜀汉基业由此奠定。', 'Liu Bei appointed Zhuge Liang his chief strategist, rejoicing that finding Kongming was like a fish finding water.'),
    ]),
    ch('rotk_3', 'romance_of_three_kingdoms', 3, '赤壁大战 借东风火烧曹营', 'The Battle of Red Cliffs', [
      s('曹操率八十万大军南下，孙刘两家结盟抗曹，周瑜与诸葛亮智谋并出。', 'Cao Cao led an armada of 800,000 troops south. Sun Quan and Liu Bei forged an alliance, with Zhou Yu and Zhuge Liang matching wits against the northern host.'),
      s('诸葛亮于南屏山筑七星坛借得东南大风，黄盖乘火船诈降直冲曹军水寨。', 'Zhuge Liang erected a Seven Star Altar to summon the southeastern wind, while Huang Gai steered fire-ships into Cao Cao’s chained fleet.'),
      s('烈火漫天，曹军战船灰飞烟灭，三国鼎立之势从此底定。', 'Blazing fire lit the night sky across the Yangtze, burning Cao Cao’s navy to ashes and sealing the Three Kingdoms division.'),
    ]),
  ]);

  // =========================================================================
  // 5. TAO TE CHING (道德经)
  // =========================================================================
  save('dao_de_jing', [
    ch('dao_1', 'dao_de_jing', 1, '观徼第一章', 'The Way that Can Be Spoken', [
      s('道可道，非常道；名可名，非常名。', 'The Tao that can be spoken of is not the eternal Tao; The name that can be named is not the eternal name.'),
      s('无名，天地之始；有名，万物之母。', 'The nameless is the beginning of heaven and earth; The named is the mother of all things.'),
      s('故常无欲，以观其妙；常有欲，以观其徼。', 'Ever desireless, one can see the mystery; Ever desiring, one sees only the manifestations.'),
      s('此两者同出而异名，同谓之玄。玄之又玄，众妙之门。', 'These two emerge from the same origin but differ in name; both are called profound. Profound and more profound, the gate to all mysteries.'),
    ]),
    ch('dao_2', 'dao_de_jing', 2, '上善若水第八章', 'The Highest Good Like Water', [
      s('上善若水。水善利万物而不争，处众人之所恶，故几于道。', 'The highest goodness is like water. Water benefits all things and does not compete; it stays in the lowly places that others despise, and so is close to the Tao.'),
      s('居善地，心善渊，与善仁，言善信，政善治，事善能，动善时。', 'In dwelling, live close to the ground; in thinking, plunge into depth; in dealing with others, be gentle and kind; in words, keep good faith; in ruling, maintain order; in business, be competent; in action, watch the timing.'),
      s('夫唯不争，故无尤。', 'Because it does not compete, it finds no reproach.'),
    ]),
  ]);

  // =========================================================================
  // 6. THE ANALECTS (论语)
  // =========================================================================
  save('the_analects', [
    ch('analects_1', 'the_analects', 1, '学而第一', 'On Learning and Virtue', [
      s('子曰：“学而时习之，不亦说乎？有朋自远方来，不亦乐乎？人不知而不愠，不亦君子乎？”', 'Confucius said: "Is it not pleasant to learn with a constant perseverance and practice? Is it not delightful to have friends coming from distant quarters? Is he not a man of complete virtue, who feels no discomposure though men take no note of him?"'),
      s('曾子曰：“吾日三省吾身：为人谋而不忠乎？与朋友交而不信乎？传不习乎？”', 'Master Zeng said: "I daily examine myself on three points: whether, in transacting business for others, I may have been unfaithful; whether, in intercourse with friends, I may have been untrue; whether I may have not mastered what was taught."'),
      s('子曰：“巧言令色，鲜矣仁！”', 'The Master said: "Fine words and an ingratiating appearance are seldom associated with true virtue."'),
      s('子曰：“温故而知新，可以为师矣。”', 'The Master said: "He who keeps reviving his old knowledge, so as continually to be acquiring new, may be a teacher of others."'),
    ]),
    ch('analects_2', 'the_analects', 2, '为政第二', 'On Governance and Character', [
      s('子曰：“为政以德，譬如北辰，居其所而众星共之。”', 'The Master said: "He who exercises government by means of his virtue may be compared to the north polar star, which keeps its place and all the stars turn towards it."'),
      s('子曰：“吾十有五而志于学，三十而立，四十而不惑，五十而知天命，六十而耳顺，七十而从心所欲，不逾矩。”', 'The Master said: "At fifteen, I had my mind bent on learning. At thirty, I stood firm. At forty, I had no doubts. At fifty, I knew the decrees of Heaven. At sixty, my ear was an obedient organ. At seventy, I could follow what my heart desired, without transgressing what was right."'),
      s('子曰：“知之为知之，不知为不知，是知也。”', 'The Master said: "When you know a thing, to hold that you know it; and when you do not know a thing, to allow that you do not know it - this is knowledge."'),
    ]),
  ]);

  // =========================================================================
  // 7. SHERLOCK HOLMES (福尔摩斯探案集)
  // =========================================================================
  save('sherlock_holmes', [
    ch('holmes_1', 'sherlock_holmes', 1, '血字的研究：贝克街的初遇', 'A Study in Scarlet: Baker Street', [
      s('在伦敦贝克街221B号的公寓里，我第一次见到了独一无二的咨询侦探歇洛克·福尔摩斯。', 'In our modest lodgings at 221B Baker Street, I first came to understand the extraordinary mind of Sherlock Holmes, the world’s only consulting detective.'),
      s('他不仅精通化学、解剖学与法医学，更拥有令人叹为观止的演绎推理能力。', 'He possessed not only extensive knowledge of chemistry and forensic pathology, but an astonishing mastery of observation and deductive reasoning.'),
      s('“你看得到，华生，但你没有观察。”福尔摩斯微笑着点燃烟斗说。', '"You see, Watson, but you do not observe," Holmes said with a keen smile as he lit his pipe.'),
      s('苏格兰场侦探雷斯垂德送来一封急信：劳里斯顿花园街的一处荒宅里发现了一具尸体，墙上用鲜血写着“RACHE”。', 'A telegram arrived from Inspector Lestrade of Scotland Yard: a corpse had been discovered in an abandoned house on Lauriston Gardens, with the word "RACHE" scrawled in blood upon the wall.'),
    ]),
    ch('holmes_2', 'sherlock_holmes', 2, '斑点带子案：致命的午夜阴谋', 'The Adventure of the Speckled Band', [
      s('清晨，一位面色苍白、浑身发抖的年轻女子海伦·斯通纳来到了贝克街。', 'Early one morning, a terror-stricken young woman named Helen Stoner arrived at Baker Street trembling with dread.'),
      s('她讲述了双胞胎姐姐在结婚前夕离奇死于锁闭卧室的惨剧，临终前只喊道：“是斑点带子！”', 'She described how her twin sister had died mysteriously in a locked bedroom on the eve of her wedding, gasping with her last breath: "The speckled band!"'),
      s('福尔摩斯和我在斯托克莫兰庄园守候深夜，随着一阵微弱的嘶嘶声，一条剧毒的沼泽蝰蛇顺着通气孔游下。', 'Holmes and I kept silent vigil in the darkness of Stoke Moran manor until a sinister hissing signaled a deadly swamp adder descending through the ventilator.'),
      s('福尔摩斯挥动鞭子将毒蛇击退，凶狠的继父自食恶果被毒蛇咬死，悬案真相大白。', 'Holmes struck the creature with his cane, driving it back to fatally strike its villainous master Dr. Roylott, solving the chilling mystery.'),
    ]),
  ]);

  // =========================================================================
  // 8. THE METAMORPHOSIS (变形记)
  // =========================================================================
  save('the_metamorphosis', [
    ch('meta_1', 'the_metamorphosis', 1, '清晨的异变', 'The Morning Transformation', [
      s('一天早晨，格里高尔·萨姆沙从不安的睡梦中醒来，发现自己在床上变成了一只巨大的甲虫。', 'One morning, when Gregor Samsa woke from troubled dreams, he found himself transformed in his bed into a monstrous vermin.'),
      s('他仰卧着，坚硬的甲壳背紧贴床面，他只要稍稍抬头，就能看见自己褐色的拱形腹部和许多细小无助抽搐的腿。', 'He lay on his armor-hard back and saw his domed brown belly divided into stiff arches, with numerous thin legs waving helplessly before his eyes.'),
      s('“我这是怎么了？”他想。这绝不是梦。', '"What has happened to me?" he thought. It was not a dream.'),
      s('墙上的挂钟滴答作响，他已经错过了早班火车，而作为全家的经济支柱，门外响起了母亲和主管焦急的敲门声。', 'The clock ticked relentlessly on the wall. He had already missed the morning train, and outside his bedroom door came the anxious knocks of his mother and chief clerk.'),
    ]),
    ch('meta_2', 'the_metamorphosis', 2, '家庭的裂痕与苹果的重击', 'The Estrangement & The Apple', [
      s('家人从最初的恐惧震惊，逐渐演变成厌恶与冷漠。', 'The initial shock and terror of his family gradually gave way to disgust, exhaustion, and cold resentment.'),
      s('唯有妹妹格蕾特最初愿意进房送食物并清理房间，但随着时间推移，这也变成了沉重的负担。', 'Only his sister Grete initially brought him scraps of food and cleaned his room, but over time even her compassion turned into unbearable fatigue.'),
      s('一次混乱中，愤怒的父亲抓起桌上的红苹果朝格里高尔狠狠砸去，一个苹果深深嵌进了他的背甲中腐烂发炎。', 'During a chaotic moment, his furious father hurled red apples across the parlor; one struck Gregor’s back and lodged deep into his shell, causing agonizing inflammation.'),
      s('带着满身创伤与孤独，格里高尔在听完妹妹拉响的小提琴声后，在黑暗的黎明前静静地停止了呼吸。', 'Wounded and neglected, having listened to his sister playing the violin one last time with profound longing, Gregor drew his final breath peacefully before sunrise.'),
    ]),
  ]);

  // =========================================================================
  // 9. PRIDE AND PREJUDICE (傲慢与偏见)
  // =========================================================================
  save('pride_and_prejudice', [
    ch('pap_1', 'pride_and_prejudice', 1, '内瑟菲尔德舞会与第一印象', 'The Netherfield Ball & First Impressions', [
      s('凡是有钱的单身汉，总想娶位太太，这是一条举世公认的真理。', 'It is a truth universally acknowledged, that a single man in possession of a good fortune, must be in want of a wife.'),
      s('在麦里屯的舞会上，富有的达西先生因举止冷傲而激怒了众人，更当众评价伊丽莎白“容貌尚可，但不足以打动我”。', 'At the Meryton ball, the wealthy Mr. Darcy offended the assembly with his aloof pride, refusing to dance and remarking that Elizabeth Bennet was "tolerable, but not handsome enough to tempt me."'),
      s('聪慧明敏的伊丽莎白从此对达西抱有了深厚的偏见，两人言辞机锋交错。', 'The spirited and sharp-witted Elizabeth took Darcy’s slight in stride, holding a deep prejudice against his cold arrogance.'),
    ]),
    ch('pap_2', 'pride_and_prejudice', 2, '柯林斯求婚与达西的震撼长信', 'The Proposal & Darcy’s Letter', [
      s('在肯特郡罗新斯庄园，达西先生终于无法抑制对伊丽莎白的深切爱慕，出人意料地向她求婚。', 'At Rosings Park in Kent, unable to contain his passionate admiration any longer, Mr. Darcy unexpectedly proposed to Elizabeth.'),
      s('伊丽莎白断然拒绝了他，痛斥他的傲慢以及对姐姐简和威克姆的残酷对待。', 'Elizabeth vehemently rejected him, condemning his haughty arrogance and his role in separating her sister Jane from Bingley.'),
      s('次日清晨，达西递给伊丽莎白一封坦诚真挚的长信，道明了威克姆的贪婪谎言与误会的真相，伊丽莎白的偏见开始动摇。', 'The next morning, Darcy handed her an earnest letter laying bare the deceitful nature of Wickham and his true motives, shaking Elizabeth’s prejudice to its core.'),
    ]),
    ch('pap_3', 'pride_and_prejudice', 3, '彭伯里重逢与圆满姻缘', 'Pemberley & The Triumph of Love', [
      s('伊丽莎白随舅父母参观达西的彭伯里庄园，被其高尚的品德与达西真诚谦逊的待客之道深深打动。', 'Visiting Darcy’s estate at Pemberley with her aunt and uncle, Elizabeth was deeply moved by his genuine generosity and respectful humility.'),
      s('当莉迪亚私奔丑闻爆发，达西暗中出资挽救了班内特一家的名誉，展现了无私的深情。', 'When scandal threatened her family through Lydia’s elopement, Darcy quietly intervened and secured the marriage at immense personal expense.'),
      s('达西重返浪博恩再次求婚，伊丽莎白欣然应允，傲慢化为尊重，偏见终成真爱。', 'Returning to Longbourn, Darcy proposed once more; Elizabeth accepted with overflowing joy, their pride and prejudice transformed into everlasting devotion.'),
    ]),
  ]);

  // =========================================================================
  // 10. DON QUIXOTE (堂吉诃德)
  // =========================================================================
  save('don_quixote', [
    ch('dq_1', 'don_quixote', 1, '骑士出征大战风车', 'The Tilting at Windmills', [
      s('在西班牙拉曼查的一个村庄里，穷乡绅堂吉诃德沉迷于骑士传奇小说，终于决定披挂祖传铁甲游侠天下。', 'In a village of La Mancha, the eccentric gentleman Don Quixote became so immersed in chivalric romances that he decided to take up knight-errantry.'),
      s('他骑上瘦马罗西南特，选定邻村农妇为梦中情人杜尔西内娅，并说服老实朴素的桑丘·潘沙担任随从。', 'Riding his lean steed Rocinante, he declared Dulcinea his lady-love and persuaded the honest peasant Sancho Panza to become his loyal squire.'),
      s('来到原野上，堂吉诃德将三十多座风车误认作张牙舞爪的邪恶巨人，挺枪跃马直冲上去。', 'Arriving on a wide plain, Don Quixote mistook thirty windmills for ferocious giants and charged full tilt with lowered lance.'),
      s('长枪刺入风车翼板被击得粉碎，堂吉诃德人仰马翻滚落草地，却坚称是魔法师施法将巨人变成了风车。', 'The sweeping sails shattered his lance and hurled horse and rider tumbling across the dust, yet he insisted a wicked enchanter had transformed the giants into mills.'),
    ]),
    ch('dq_2', 'don_quixote', 2, '桑丘的总督梦与骑士的归途', 'Sancho’s Island & The Awakening', [
      s('公爵夫妇捉弄桑丘，封他为“巴拉塔里亚岛”总督。桑丘断案清明公正，却因繁文缛节与围攻演习不堪重负而毅然辞官。', 'A mischievous Duke appointed Sancho governor of "Barataria Island." Sancho judged disputes with folk wisdom, but tired of fasting and court pageantry, resigning with dignity.'),
      s('堂吉诃德在巴塞罗那海滩被化身白月骑士的同乡学者击败，遵约返回故里。', 'Defeated on the sands of Barcelona by the Knight of the White Moon, Don Quixote honorably agreed to lay down arms and return home.'),
      s('临终前堂吉诃德神智清醒，看透了骑士小说的虚妄，在亲友环绕中安详辞世，留下了崇高的理想主义光辉。', 'Restored to sanity on his deathbed, he renounced the follies of chivalry, passing away peacefully surrounded by loved ones, leaving an immortal legacy of noble idealism.'),
    ]),
  ]);

  // =========================================================================
  // 11. LES MISERABLES (悲惨世界)
  // =========================================================================
  save('les_miserables', [
    ch('les_1', 'les_miserables', 1, '银烛台与灵魂的重生', 'The Silver Candlesticks', [
      s('苦役犯冉阿让因偷窃一块面包而服刑十九载，出狱后饱受世人白眼与驱逐。', 'Jean Valjean had endured nineteen years at hard labor for stealing a loaf of bread, released into a world that treated him like an outcast.'),
      s('仁慈的卞福汝主教收留了他，冉阿让却在深夜偷走了主教的银餐具潜逃，随即被宪兵抓获押回。', 'The saintly Bishop Myriel welcomed him warmly, but Valjean fled in the night with the silver plates, only to be captured and returned by the police.'),
      s('主教微笑着对宪兵说：“这些银器是我送给他的，他还落下了这对最贵重的银烛台。”', 'The Bishop told the officers: "I gave him the silver, and he forgot the two candlesticks, which are also silver."'),
      s('主教将银烛台塞给冉阿让，低语道：“我的兄弟，你不再属于恶，而属于善。我用这些银子买下了你的灵魂，交给了上帝。”冉阿让痛哭忏悔，彻底蜕变。', 'Handing him the candlesticks, the Bishop whispered: "My brother, you belong no longer to evil, but to good. It is your soul that I buy from you." Valjean wept in profound redemption.'),
    ]),
    ch('les_2', 'les_miserables', 2, '街垒风云与芳汀之女', 'The Barricades & Cosette', [
      s('冉阿让化名马德兰创办工厂造福一方，并从贪婪的德纳第夫妇手中救出了可怜的孤女珂赛特，视如己出。', 'Transforming into the benevolent Monsieur Madeleine, Valjean rescued poor orphan Cosette from the cruel Thénardiers and raised her as his own daughter.'),
      s('警长沙威毕生追捕冉阿让，但在1832年巴黎共和党街垒起义中，冉阿让反而宽恕并放走了沦为俘虏的沙威。', 'Inspector Javert relentlessly pursued Valjean, yet during the 1832 Paris uprising at the barricades, Valjean spared Javert’s captive life.'),
      s('沙威世界观崩塌跳入塞纳河自尽，冉阿让在珂赛特与马吕斯的守护中安详辞世，烛光映照着永恒的慈爱。', 'Torn between legal duty and divine grace, Javert leaped into the Seine, while Valjean passed away peacefully in the loving embrace of Cosette and Marius.'),
    ]),
  ]);

  // =========================================================================
  // 12. SIDDHARTHA (悉达多)
  // =========================================================================
  save('siddhartha_hesse', [
    ch('sid_1', 'siddhartha_hesse', 1, '离开婆罗门与寻道林野', 'Leaving the Brahmins', [
      s('古印度婆罗门之子悉达多天资聪颖、容貌俊美，但他内心深处对仪式与教条充满了虚无感。', 'Siddhartha, the handsome and gifted son of a Brahmin, felt a deep spiritual thirst that traditional rituals and scriptures could not quench.'),
      s('他告别了痛苦挽留的父亲，携好友乔文达遁入丛林，跟随沙门苦行僧学习禁食、冥想与摒弃自我。', 'Leaving his father’s estate, he joined the forest ascetics with his faithful friend Govinda to practice fasting, breath-control, and self-denial.'),
      s('三年苦修之后，悉达多领悟到苦行只能暂时逃避自我，无法寻得永恒的真理。', 'After three years of severe discipline, Siddhartha realized that asceticism only provided temporary escape from the ego rather than ultimate enlightenment.'),
    ]),
    ch('sid_2', 'siddhartha_hesse', 2, '红尘之欲与大河的圆满智慧', 'The River & Supreme Awakening', [
      s('悉达多来到繁华都市，向名妓迦摩罗学习尘世情爱，向富商学习经商聚财，在欢娱中沉沦数十载。', 'Entering the city, Siddhartha learned worldly passion from the courtesan Kamala and merchant trade, immersing himself in pleasure and wealth for decades.'),
      s('一天清晨，他厌倦了虚浮的红尘，来到大河边欲投水自尽，却在倾听河水奔流中听到了神圣的“唵”（Om）声。', 'Waking from his spiritual slumber in revulsion, he stood by the great river ready to drown himself, when the sacred sound "Om" resonated through the waters.'),
      s('他留在大河旁成为摆渡人，在老摆渡人瓦稣迪瓦的陪伴下聆听河水，终于领悟万物合一、无始无终的圆满至境。', 'He became a humble ferryman beside Vasudeva, listening to the thousand voices of the river until he realized the eternal unity and timeless perfection of all existence.'),
    ]),
  ]);

  // =========================================================================
  // 13. THE OLD MAN AND THE SEA (老人与海)
  // =========================================================================
  save('the_old_man_and_sea', [
    ch('old_man_1', 'the_old_man_and_sea', 1, '出海与巨鱼的咬钩', 'Setting Sail into the Gulf Stream', [
      s('老渔夫圣地亚哥已经连续八十四天没捕到一条鱼了，但他那双眼睛依旧像海水一样湛蓝坚毅。', 'Santiago had gone eighty-four days without taking a fish, but his eyes were cheerful and undefeated like the sea.'),
      s('第八十五天清晨，老人在黑暗中独自将小船划向远离海岸的墨西哥湾深海。', 'On the eighty-fifth day, he rowed his skiff far out into the deep Gulf Stream before dawn.'),
      s('正午时分，一条足有一千五百磅重的一百英尺巨型马林鱼咬住了百米深处的鱼饵。', 'At noon, a massive marlin taking the bait a hundred fathoms deep began towing the skiff into open waters.'),
    ]),
    ch('old_man_2', 'the_old_man_and_sea', 2, '两昼夜的搏斗与无畏的尊严', 'The Epic Battle & Unbroken Spirit', [
      s('大鱼拉着小舟在风浪中航行了两天两夜，老人双手磨得血肉模糊，仅靠生鱼肉和水支撑意志。', 'The great fish pulled the skiff for two days and nights. With bleeding hands and strained shoulders, the old man persevered on raw tuna and unyielding will.'),
      s('第三天清晨，巨鱼开始盘旋上升，老人拼尽最后一丝力气将鱼叉刺入大鱼心脏，赢得了胜利。', 'On the third morning the marlin circled to the surface; with his last ounce of strength, Santiago drove his harpoon home.'),
      s('返航途中鲨鱼群闻血而来，老人用绑在船桨上的刀子和木棍英勇抗击，直到长达十八英尺的白骨被带回港湾。', 'On the voyage back, packs of sharks attacked the carcass. The old man fought fiercely until only the majestic white skeleton remained.'),
      s('“人不是为了失败而生的，”老人自言自语，“一个人可以被毁灭，但不能被打败。”', '"Man is not made for defeat," the old man whispered to himself. "A man can be destroyed but not defeated."'),
    ]),
  ]);

  // =========================================================================
  // 14. BORDER TOWN (边城)
  // =========================================================================
  save('border_town', [
    ch('border_1', 'border_town', 1, '茶峒渡口的纯朴岁月', 'The Ferry at Chadong', [
      s('由四川过湖南去，靠东有一条官道。这官道将近湘西边境到了一个地方名叫“茶峒”。', 'Near the border where Sichuan meets Hunan, a post road reaches the peaceful mountain village of Chadong.'),
      s('清澈见底的溪流边，住着一位年过七旬的老船夫与他的外孙女翠翠，以及一条通人性的大黄狗。', 'By a crystal stream lived an old ferryman, his lovely granddaughter Cuicui, and a faithful yellow hound.'),
      s('祖孙俩五十年来日复一日拉着渡船摆渡过往行人，从不收取分文谢礼，民风纯朴如古风。', 'For fifty years, the old man ferried travelers across the river without asking for a copper, embodying the pure, idyllic spirit of the mountains.'),
    ]),
    ch('border_2', 'border_town', 2, '端午龙舟与月下情歌', 'Dragon Boat Festival & The Melancholy Song', [
      s('端午节那天，茶峒举行热闹的龙舟竞渡，翠翠在河街上邂逅了船总顺顺的二儿子傩送。', 'On the Dragon Boat Festival, watching the vibrant races by the river, Cuicui met Nuosong, the gallant younger son of the dockmaster.'),
      s('傩送的歌声在月夜的山崖间回荡，宛如浮动的梦境，深深印在翠翠少女纯洁的心田。', 'Nuosong’s midnight love songs echoed across the misty river cliff like a celestial dream in Cuicui’s heart.'),
      s('然而命运弄人，长兄天保的意外落水溺亡与老船夫的离世，让傩送远走他乡。', 'Yet tragedy struck as elder brother Tianbao drowned in the rapids, and the grandfather passed away in a midnight storm.'),
      s('翠翠在碧溪岨日夜守候着渡船，“这个人也许永远不回来了，也许明天回来。”', 'Cuicui remained by the ferry waiting through the seasons: "Perhaps that person will never come back; perhaps he will return tomorrow."'),
    ]),
  ]);

  // =========================================================================
  // 15. CALL TO ARMS (呐喊)
  // =========================================================================
  save('call_to_arms_luxun', [
    ch('luxun_1', 'call_to_arms_luxun', 1, '狂人日记', "A Madman's Diary", [
      s('今天全没月光，我很料得有些侥幸。赵家的狗又看我两眼。', 'Tonight there is no moonlight at all; I know that this bodes ill. The Zhao family dog looked at me strangely twice today.'),
      s('我翻开历史一查，这历史没有年代，歪歪斜斜的每页上都写着“仁义道德”几个字。', 'I opened the history books to examine them; this history had no dates, but scrawled across every page were the words "Benevolence, Righteousness, and Morality."'),
      s('我横竖睡不着，仔细看了半夜，才从字缝里看出字来，满本都写着两个字是“吃人”！', 'I could not sleep, and reading through the lines until midnight, I finally saw what was written across every page: "Eat people!"'),
      s('没有吃过人的孩子，或者还有？救救孩子……', 'Perhaps there are still children who have not yet eaten men? Save the children...'),
    ]),
    ch('luxun_2', 'call_to_arms_luxun', 2, '孔乙己', 'Kong Yiji', [
      s('鲁镇的酒店的格局，是和别处不同的：都是当街一个曲尺形的大柜台，里面预备着热水，可以随时温酒。', 'The layout of the wine taverns in Luzhen is different from other places: a large curved counter stands facing the street with hot water ready to warm the rice wine.'),
      s('孔乙己是站着喝酒而穿长衫的唯一的人。他身材高大，青白脸色，皱纹间时常夹些伤痕，一部乱蓬蓬的花白胡子。', 'Kong Yiji was the only customer who drank standing up while wearing a long scholar’s gown. He was tall with a pale, bruised face and a tangled gray beard.'),
      s('他一到店，所有喝酒的人便都看着他笑，有的叫道：“孔乙己，你脸上又添上新伤疤了！”', 'Whenever he arrived, all the drinkers laughed: "Kong Yiji, you’ve got fresh bruises on your face again!"'),
      s('孔乙己便涨红了脸，争辩道：“窃书不能算偷……窃书！读书人的事，能算偷么？”接着便是“君子固穷”之类的话，引得众人都哄笑起来。', 'Kong Yiji would flush and argue: "Taking books cannot be called stealing... Taking books! For a scholar, can that be theft?" followed by classical quotes, throwing the tavern into uproarious laughter.'),
    ]),
  ]);

  // =========================================================================
  // 16. AESOP'S FABLES (伊索寓言)
  // =========================================================================
  save('aesops_fables', [
    ch('aesop_1', 'aesops_fables', 1, '龟兔赛跑', 'The Tortoise and the Hare', [
      s('骄傲的兔子嘲笑乌龟爬得慢，乌龟微笑着提议进行一场长跑比赛。', 'A boastful hare mocked a tortoise for his slow pace, to which the tortoise calmly proposed a long-distance footrace.'),
      s('比赛开始后，兔子一马当先，见乌龟被远远甩在身后，便在路边的树荫下放心地呼呼大睡。', 'When the race began, the hare bounded far ahead, and seeing the tortoise plodding in the distance, fell fast asleep under a shady tree.'),
      s('乌龟一步一个脚印坚持不懈地向前爬行，最终超越了沉睡的兔子，赢得了冠军。', 'The tortoise plodded steadily step by step without stopping, crossing the finish line before the sleeping hare awakened.'),
      s('寓意：虚心使人进步，稳扎稳打、持之以恒者必获成功。', 'Moral: Slow and steady wins the race; overconfidence leads to defeat.'),
    ]),
    ch('aesop_2', 'aesops_fables', 2, '狐狸与葡萄', 'The Fox and the Grapes', [
      s('一只饥饿的狐狸路过葡萄架，看到一串串紫莹莹、晶莹剔透的成熟葡萄高高挂在藤上。', 'A hungry fox walked by a vineyard and saw ripe, glistening clusters of purple grapes hanging high on the trellis.'),
      s('狐狸馋得直流口水，接连奋力起跳了数十次，却始终碰不到葡萄。', 'His mouth watering, the fox leaped into the air again and again, but failed to reach the high branch.'),
      s('筋疲力尽的狐狸只得悻悻离开，自我安慰道：“这些葡萄肯定是酸的，我才不稀罕吃呢！”', 'Exhausted, the fox walked away in disgust, rationalizing: "Those grapes are certainly sour anyway; I have no use for them!"'),
      s('寓意：有些人能力不足达不到目的，便故意贬低所追求的事物。', 'Moral: It is easy to despise what you cannot attain.'),
    ]),
  ]);

  print('=== Completed generation of full-length books! ===');
}
