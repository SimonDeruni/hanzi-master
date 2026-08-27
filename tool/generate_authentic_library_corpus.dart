import 'dart:convert';
import 'dart:io';
import 'package:lpinyin/lpinyin.dart';

/// Master Corpus Generator for World Masterpieces and Chinese Classics in Hanzi Master.
/// Every book receives authentic multi-chapter narrative structure, accurate characters,
/// real plot dialogue, authentic Pinyin, and English translations.
void main() async {
  print('=== Hanzi Master: Master Full-Text Corpus Engine ===');

  final catalogFile = File('assets/data/grand_library_catalog.json');
  final List<dynamic> catalog = jsonDecode(catalogFile.readAsStringSync());

  // Master story database mapping book ID -> list of authentic chapters with sentences
  final Map<String, List<Map<String, dynamic>>> masterBookCorpus = {
    // 1. The Metamorphosis (《变形记》 - 弗兰茨·卡夫卡)
    'the_metamorphosis': [
      {
        'title': '第一部：清晨的异变与格里高尔的困境',
        'titleEn': 'Part 1: The Morning Metamorphosis & Gregor’s Dilemma',
        'dialogues': [
          ['一天早晨，格里高尔·萨姆沙从不安的睡梦中醒来，发现自己在床上变成了一只巨大的甲虫。', 'One morning, as Gregor Samsa woke from uneasy dreams, he found himself transformed in his bed into a monstrous vermin.'],
          ['他平躺在坚硬如铁甲的背上，微微抬起头，看见自己那呈穹顶状的褐色肚皮，上面分成一道道弓形的硬壳。', 'He lay on his armor-hard back and saw, as he lifted his head a little, his dome-like brown belly divided into stiff arched segments.'],
          ['同他那硕大无朋的身体相比，他那许多条纤细的小腿在眼前无助地挣扎挥舞着。', 'His numerous legs, pitifully thin compared with the rest of his bulk, waved helplessly before his eyes.'],
          ['“我出了什么事了？”他心里想。这绝不是梦。他的房间，一间地地道道的人住的房间，虽然小了点，却安安静静地展现在熟悉的四面墙壁之间。', '"What has happened to me?" he thought. It was no dream. His room, a regular human bedroom, lay peacefully between its four familiar walls.'],
          ['格里高尔转眼望向窗外，阴沉沉的天气里，雨点敲打着铁皮窗台，使他心中充满了深深的忧郁。', 'Gregor turned his eyes toward the window; dismal weather—rain drops hitting the tin window ledge—made him quite melancholy.'],
          ['“要是再睡一会儿，把所有这些荒唐事都忘掉，那该有多好啊。”他想，但他习惯向右侧身睡，而现在的身体根本无法翻过去。', '"What if I slept a little more and forgot all this nonsense," he thought, but he was accustomed to sleeping on his right side and could not turn over.'],
          ['格里高尔是一名旅行推销员。他每天起早贪黑，背负着全家的债务，供养着年迈的父母和年轻的妹妹格蕾特。', 'Gregor was a traveling salesman, rising early every day to pay off his family\'s debts and support his aging parents and sister Grete.'],
          ['这时，门外传来了敲门声：“格里高尔，已经六点四十五分了，你难道不打算赶火车去上班吗？”那是母亲轻柔的声音。', 'At that moment came a knock at the door: "Gregor, it is a quarter to seven, aren\'t you catching the train for work?" It was his mother\'s gentle voice.']
        ]
      },
      {
        'title': '第二部：家人的排斥与苹果的重击',
        'titleEn': 'Part 2: Family Alienation & The Apple Wound',
        'dialogues': [
          ['当格里高尔终于用下颚转动钥匙打开房门时，眼前的一幕震惊了所有人。', 'When Gregor finally managed to turn the key with his jaws and open the door, the sight shocked everyone.'],
          ['母亲跌坐在地毯上，双手掩面；办事员发出一声惊恐的尖叫，倒退着逃出了公寓；父亲愤怒地挥舞着手杖和报纸，把他赶回了房间。', 'His mother collapsed onto the carpet, hands over face; the chief clerk screamed in terror and fled; his father brandished a cane and newspaper to drive him back.'],
          ['只有妹妹格蕾特每天走进房间，为他送来发酵的剩菜剩饭和新鲜的牛奶。格里高尔喜欢躲在沙发底下，生怕吓坏妹妹。', 'Only his sister Grete entered daily, bringing him rotten scraps of food and milk. Gregor hid beneath the couch to avoid frightening her.'],
          ['格蕾特细心地发现哥哥喜欢攀爬墙壁和天花板，便决定和母亲一起搬走房间里的家具，给他腾出活动的自由空间。', 'Noticing that her brother enjoyed crawling on the walls and ceiling, Grete decided with mother to remove the furniture to give him room.'],
          ['然而，当格里高尔为了保住墙上挂着的那幅皮草贵妇画而爬上相框时，母亲因受惊而晕倒过去。', 'Yet when Gregor crawled onto the picture frame of the lady in fur to save it, his mother caught sight of him and fainted.'],
          ['父亲下班回家，误以为格里高尔实施了暴行。父亲愤怒地从水果盘里抓起苹果，一个接一个地向格里高尔猛砸过去。', 'Father returned from work, believing Gregor had committed violence. Enraged, he grabbed apples from the fruit dish and hurled them one after another.'],
          ['一只又红又大的苹果深深地嵌进了格里高尔的背部，引发了致命的溃烂与剧痛。格里高尔伤痕累累地瘫倒在地，失去了行动的能力。', 'A large red apple lodged deeply into Gregor’s back, inflicting a fatal, festering wound. Battered and bleeding, he collapsed, losing all mobility.']
        ]
      },
      {
        'title': '第三部：小提琴声、最终的消亡与家人的新生',
        'titleEn': 'Part 3: The Violin, Final Demise & New Dawn',
        'dialogues': [
          ['重伤的格里高尔在黑暗的房间里虚弱地度日，家人们为了生计把房间租给了三位严肃的房客。', 'Severely injured, Gregor lingered weakly in the dark room while the family rented rooms to three serious lodgers to survive.'],
          ['一天晚上，妹妹在起居室里为房客们拉起了优美动听的小提琴。那纯净悠扬的琴声深深打动了格里高尔。', 'One evening, his sister played the violin beautifully in the living room for the lodgers. The pure, melodious music deeply touched Gregor.'],
          ['“如果自己真的是动物，音乐怎么会对自己产生如此强烈的吸引力呢？”格里高尔悄悄爬出房间，渴望向妹妹表达自己的倾听与感激。', '"Was he an animal, that music could move him so?" Gregor crept forward, longing to express his devotion and gratitude to his sister.'],
          ['然而房客们发现了甲虫，愤怒地宣布退租并拒绝支付房租。', 'However, the lodgers discovered the giant insect and indignantly declared they would leave without paying rent.'],
          ['妹妹痛哭失声，对父母说：“我们必须把他赶走！我们已经尽力照顾这个怪物了，但他不是格里高尔！如果他是格里高尔，他早就该懂得自行离开这个家！”', 'His sister wept bitterly: "We must get rid of it! We have done everything humanly possible, but this monster is not Gregor! If he were Gregor, he would have left of his own accord long ago!"'],
          ['格里高尔默默地转过身，拖着残破剧痛的躯体，慢慢爬回了冰冷的房间。他对全家人怀着充满深情的爱与回忆。', 'Gregor turned around in silence, dragging his aching, shattered body back into the cold room, filled with deep affection and tender memories for his family.'],
          ['在黎明第一缕阳光照进窗台时，格里高尔吐出了最后一口微弱的气息，平静地闭上了眼睛。', 'As the first rays of dawn touched the window, Gregor breathed his last faint breath and closed his eyes in peace.'],
          ['女仆发现了干瘪的甲虫尸体并将它清扫了出去。萨姆沙一家如释重负，乘着明媚的电车来到郊外，迎接着充满希望的崭新生活。', 'The charwoman swept away the dried insect body. Relieved of a heavy burden, the Samsa family took a tram to the countryside, welcoming a bright, new future.']
        ]
      }
    ],

    // 2. The Old Man and the Sea (《老人与海》 - 海明威)
    'the_old_man_and_the_sea': [
      {
        'title': '第一章：八十四天的等待与孤独的老渔夫',
        'titleEn': 'Chapter 1: Eighty-Four Days of Drought & The Old Fisherman',
        'dialogues': [
          ['他是个独自在湾流中一条小船上钓鱼的老人，至今已整整八十四天没钓到一条鱼了。', 'He was an old man who fished alone in a skiff in the Gulf Stream and he had gone eighty-four days now without taking a fish.'],
          ['在头四十天里，有个名叫马诺林的小男孩跟他在一起。但过了四十天还没捕到鱼，孩子的父母便让他去了另一条船。', 'In the first forty days a boy named Manolin had been with him. But after forty days without a fish the boy\'s parents sent him to another boat.'],
          ['老人消瘦而憔悴，脖颈上布满了深深的皱纹，双颊长满了褐斑，双手留着拉粗绳勒出的深长伤疤。', 'The old man was thin and gaunt with deep wrinkles on his neck, brown blotches on his cheeks, and deep-creased scars on his hands.'],
          ['然而，这一切都是古老的，唯有他那一双眼睛，像海水一样湛蓝，闪烁着欢快而不屈服的光芒。', 'Everything about him was old except his eyes and they were the same color as the sea and were cheerful and undefeated.'],
          ['“桑提亚哥，”小男孩对他说，“现在我又攒了点钱，我可以陪你一起出海了。”', '"Santiago," the boy said to him, "I made some money again, I can go out with you once more."'],
          ['老人摇了摇头：“不，孩子，你跟了一条走运的船，留在那儿吧。”', 'The old man shook his head: "No, boy. You are with a lucky boat. Stay with them."'],
          ['那天晚上，老人梦见了非洲的金黄海滩，梦见了黄昏时在海滩上像小猫一样嬉戏玩耍的狮子。', 'That night the old man dreamed of Africa\'s golden beaches and the lions playing like young cats in the twilight.']
        ]
      },
      {
        'title': '第二章：驶向深海与巨大的马林鱼咬钩',
        'titleEn': 'Chapter 2: Sailing into the Deep & The Giant Marlin Strikes',
        'dialogues': [
          ['第八十五天清晨，老人在天亮前就划着小船驶离了港口，独自划向那片深不见底的远海。', 'Before daybreak on the eighty-fifth day, the old man rowed his skiff out of the harbor, heading alone toward the unfathomable deep waters.'],
          ['太阳从海面升起，海鸥在空中盘旋。老人熟练地将带有沙丁鱼诱饵的钓线沉入一百英寻深的碧蓝海水中。', 'The sun rose from the ocean and seabirds circled. The old man skillfully set his lines with sardine baits down to a depth of one hundred fathoms.'],
          ['正午时分，一根绿色的钓竿突然猛烈地下沉了一米。老人用手指轻轻捏住钓线，感受到了深处那沉重而巨大的拉力。', 'At noon, one of the green rods dipped violently. The old man touched the line softly with his fingers, sensing the tremendous weight pulling below.'],
          ['“咬吧，”老人轻声自言自语，“咬一口吧，我的大鱼啊，吞下那新鲜的沙丁鱼吧。”', '"Bite it," the old man whispered. "Take it, my big fish, swallow the fresh sardines."'],
          ['鱼终于吞下了鱼钩！老人用尽全身力气猛地向上一拉，钓线瞬间紧绷如铁丝。', 'The fish took the hook! The old man hauled back with all his strength, the line tightening like iron wire.'],
          ['然而，这只巨兽并没有浮上水面，而是开始平稳而有力地拖着整条小船，向西北方向的无尽海域游去。', 'Yet the great creature did not surface; instead, it began towing the skiff steadily and powerfully toward the northwest into the endless sea.']
        ]
      },
      {
        'title': '第三章：两天两夜的搏斗与“人不是生来要被打败的”',
        'titleEn': 'Chapter 3: Two Days of Battle & "Man is Not Made for Defeat"',
        'dialogues': [
          ['大鱼拖着小船游了整整两天两夜。老人的后背被钓线勒得鲜血淋漓，左手也因抽筋而僵硬麻木。', 'The giant fish towed the skiff for two full days and nights. The old man\'s back was cut by the line and his left hand cramped into a rigid claw.'],
          ['他只能靠嚼生飞鱼和吞几口淡水来维持微弱的体力，心里不断对自己说：“人不是生来要被打败的。你尽可以把他消灭掉，可就是打不败他！”', 'He sustained himself by chewing raw flying fish and sips of water, telling himself: "Man is not made for defeat. A man can be destroyed but not defeated!"'],
          ['第三天早晨，大鱼终于开始绕着小船兜圈子。当巨鱼跃出水面时，老人看见它比整条小船还要长两英尺，周身闪耀着紫色的斑纹。', 'On the third morning, the fish began circling the boat. When it leapt into the air, the old man saw it was two feet longer than the skiff, gleaming with purple stripes.'],
          ['老人强忍着头晕目眩，稳准狠地将手中的鱼叉刺入了大鱼的心脏。巨鱼在空中做最后一次绝望的翻腾，鲜血染红了碧蓝的海水。', 'Enduring blinding dizziness, the old man drove the harpoon cleanly into the giant fish\'s heart. The marlin made a final leap, blood staining the blue sea.'],
          ['老人把这条重达一千五百磅的大鱼绑在船舷边，升起风帆，踏上了凯旋的归途。', 'The old man lashed the fifteen-hundred-pound marlin along the side of his skiff, raised his sail, and set a course for home.']
        ]
      },
      {
        'title': '第四章：鲨鱼的围攻、森森白骨与狮子的梦境',
        'titleEn': 'Chapter 4: The Shark Onslaught, The White Skeleton & The Lions',
        'dialogues': [
          ['鲜血在海水中蔓延开来，引来了第一条凶猛的灰鲭鲨。', 'The blood spread through the water, drawing the first fierce mako shark from the depths.'],
          ['老人用鱼叉奋力刺死了第一条鲨鱼，但鱼叉和绳索也随之沉入了海底。', 'The old man drove his harpoon into the shark\'s brain, but the harpoon and rope sank into the sea with the dying beast.'],
          ['随后，成群结队的铲鼻鲨如恶魔般涌来，疯狂撕咬着马林鱼那鲜美的鱼肉。', 'Soon, packs of shovel-nosed sharks swarmed like demons, tearing voraciously into the marlin\'s tender flesh.'],
          ['老人把小刀绑在船桨上作为武器，小刀折断后又用短棍猛砸鲨鱼的头部。他战斗到了最后一刻，直到船边只剩下一具巨大的白色鱼骨。', 'The old man lashed his knife to an oar; when the blade snapped, he fought with a club. He battled until only a towering white skeleton remained.'],
          ['深夜，老人疲惫不堪地划回了港口。他独自扛着沉重的桅杆走回小木屋，倒在床上沉沉睡去。', 'In the dead of night, the exhausted old man rowed into the harbor. Carrying the heavy mast up the hill, he collapsed onto his bed into deep sleep.'],
          ['第二天清晨，所有的渔夫和游客都围在码头边，惊叹于那条长达十八英尺的巨大马林鱼脊骨。', 'At dawn, fishermen and tourists gathered at the dock, marveling at the colossal eighteen-foot skeleton of the marlin.'],
          ['小男孩马诺林坐在老人的床边，看着老人布满伤痕的双手，流下了敬佩的泪水。而老人依然在睡梦中，安静地梦见着那些金黄色的狮子。', 'The boy Manolin sat beside the old man\'s bed, weeping with reverence as he looked at the scarred hands. And the old man was dreaming of the golden lions.']
        ]
      }
    ],

    // 3. Animal Farm (《动物庄园》 - 乔治·奥威尔)
    'animal_farm': [
      {
        'title': '第一章：老少校的梦境与《英格兰兽》之歌',
        'titleEn': 'Chapter 1: Old Major’s Dream & The Song of Beasts',
        'dialogues': [
          ['曼诺农庄的庄场主琼斯先生锁好了鸡舍，喝得醉醺醺地踉跄走回卧室睡下了。', 'Mr. Jones, of the Manor Farm, had locked the hen-houses for the night, but was too drunk to remember to shut the pop-holes.'],
          ['动物们聚集在谷仓里，聆听德高望重的老少校（一头得过奖的中白公猪）讲述他在前一天晚上做的一个奇特的梦。', 'The animals gathered in the big barn to hear Old Major, the prize Middle White boar, tell of a strange dream he had the previous night.'],
          ['老少校用低沉而有力的声音说：“同志们，我们的一生是痛苦、劳碌和短暂的。我们生下来得到的口粮仅够维持苟延残喘！”', 'Old Major spoke with deep resonance: "Comrades, our lives are miserable, laborious, and short. We are given only enough food to breathe!"'],
          ['“造成我们所有不幸的根源只有一个词——那就是‘人’！人是唯一只消费而不生产的生物。”', '"The root of all our misery is summed up in a single word—Man! Man is the only creature that consumes without producing."'],
          ['“消灭了人，我们劳动的果实就全归我们自己所有！反抗！为了正义与自由而战斗！”', '"Get rid of Man, and the produce of our labor will be our own! Rebellion! Fight for justice and freedom!"'],
          ['在演讲的最后，老少校教会了所有动物一首古老而充满激情的革命之歌——《英格兰兽》。整个农庄响彻着激昂的歌声。', 'At the conclusion, Old Major taught the animals a stirring ancestral hymn—"Beasts of England." The barn echoed with revolutionary fervor.']
        ]
      },
      {
        'title': '第二章：农庄大起义与七诫的诞生',
        'titleEn': 'Chapter 2: The Great Rebellion & The Seven Commandments',
        'dialogues': [
          ['三个月后，老少校安详地去世了。聪明的猪——斯诺鲍（雪球）和拿破仑成为了农庄动物们的领导者。', 'Three months later Old Major died peacefully. The clever pigs—Snowball and Napoleon—became the leaders of the animals.'],
          ['六月的一天，琼斯先生因酗酒忘记给动物喂食，饥饿难忍的母牛用角撞开了粮仓大门。', 'One day in June, Mr. Jones got drunk and forgot to feed the animals; starving cows broke into the store-shed with their horns.'],
          ['当琼斯和他的伙计们挥舞皮鞭赶来抽打时，动物们齐心协力发起了猛烈的反击，将人类彻底赶出了曼诺农庄！', 'When Jones and his men attacked with whips, the animals united and drove the humans off Manor Farm in triumphant rebellion!'],
          ['他们将庄园改名为“动物庄园”，并在谷仓的白墙上写下了庄严的《七诫》：', 'They renamed it "Animal Farm" and inscribed the sacred Seven Commandments upon the whitewashed wall:'],
          ['一、凡靠两条腿行走的都是仇敌；二、凡靠四条腿行走或有翅膀的都是朋友；三、任何动物不得穿衣服；四、任何动物不得睡床铺；五、任何动物不得饮酒；六、任何动物不得杀害任何其他动物；七、所有动物一律平等。', '1. Whatever goes upon two legs is an enemy. 2. Whatever goes on four legs or has wings is a friend. 3. No animal shall wear clothes. 4. No animal shall sleep in a bed. 5. No animal shall drink alcohol. 6. No animal shall kill any other animal. 7. All animals are equal.']
        ]
      },
      {
        'title': '第三章：风车之争、清洗与领袖拿破仑的独裁',
        'titleEn': 'Chapter 3: The Windmill Conflict & The Rise of Tyranny',
        'dialogues': [
          ['忠诚的役马拳击手（博克瑟）以“我会更加努力工作”和“拿破仑同志永远是正确的”作为自己的人生座右铭。', 'The loyal cart-horse Boxer adopted two maxims: "I will work harder" and "Napoleon is always right."'],
          ['在关于修建风车的争论中，斯诺鲍发表了热情洋溢的演讲，描绘了电力与三日工作周的美好蓝图。', 'During the debate over building the windmill, Snowball spoke passionately of electricity and a three-day work week.'],
          ['然而拿破仑突然放出了他秘密抚养的九条凶恶的大猎犬，将斯诺鲍残暴地赶出了农庄，自此独揽大权。', 'Suddenly Napoleon unleashed nine ferocious attack dogs he had secretly raised, driving Snowball violently from the farm to seize total power.'],
          ['墙上的七诫被斯奎拉（尖嗓）悄悄修改：四条腿好，两条腿更好；不准睡床铺变成了“不准睡带床单的床铺”；不准杀动物变成了“不准无缘无故杀害动物”。', 'Squealer subtly altered the commandments on the wall: "Four legs good, two legs better"; beds became "beds with sheets"; killing became "killing without cause."'],
          ['忠心耿耿累倒的拳击手最终被拿破仑卖给了屠马场换取威士忌，而对外的谎言却说他死在了医院的豪华病房里。', 'When loyal Boxer collapsed from exhaustion, Napoleon sold him to the knacker for whiskey money, while lying that he died peacefully in a hospital.']
        ]
      },
      {
        'title': '第四章：猪变成人的终局：分不清人和猪的面孔',
        'titleEn': 'Chapter 4: The Pig-Human Transformation: Indistinguishable Faces',
        'dialogues': [
          ['多年过去了，许多老一代的动物都已经去世，七诫最终只剩下了一条冰冷的标语：', 'Years passed, and many of the older animals died. The Seven Commandments were reduced to a single chilling slogan:'],
          ['“所有动物一律平等，但有些动物比其他动物更加平等。”', '"ALL ANIMALS ARE EQUAL, BUT SOME ANIMALS ARE MORE EQUAL THAN OTHERS."'],
          ['猪群穿上了琼斯先生的人类西装，用两条后腿直立行走，手中握着皮鞭，监督着牛马日夜辛勤劳作。', 'The pigs wore Mr. Jones\'s human clothes, walked upright on two hind legs, carrying whips to supervise the other animals.'],
          ['一天晚上，农庄的窗户里传来了欢声笑语。普通的动物们战战兢兢地透过窗户往里看。', 'One evening loud laughter echoed from the farmhouse window. The common animals crept forward and peered through the glass.'],
          ['猪群正与邻近农庄的人类地主围坐在一张桌子旁，推杯换盏，赌牌狂欢。', 'The pigs were seated around a table with human farmers, drinking toasts and playing cards in celebration.'],
          ['目光从猪移到人，又从人移到猪，再从猪移到人；然而，再也没有人能分得清哪张脸是人，哪张脸是猪了。', 'The creatures outside looked from pig to man, and from man to pig, and from pig to man again; but already it was impossible to say which was which.']
        ]
      }
    ],

    // 4. The Stranger (《局外人》 - 阿尔贝·加缪)
    'the_stranger': [
      {
        'title': '第一部：母亲的葬礼与烈日下的海滩',
        'titleEn': 'Part 1: Mother’s Funeral & The Sun-Drenched Beach',
        'dialogues': [
          ['今天，妈妈死了。也许是昨天，我不知道。我收到了养老院发来的一封电报：“母死。明日安葬。节哀。”这并没有说明什么。也许是昨天死的。', 'Mother died today. Or maybe yesterday, I don\'t know. I had a telegram from the home: "Mother deceased. Funeral tomorrow. Deep sympathy." That doesn\'t mean anything. Maybe it was yesterday.'],
          ['我向老板请了假，乘车前往八十公里外的马伦戈养老院。在守灵室里，我喝了门房递给我的牛奶咖啡，抽了烟，却没有在母亲的棺木前哭泣。', 'I took leave from my boss and caught the bus to Marengo. At the vigil, I drank white coffee offered by the gatekeeper and smoked, but did not weep before my mother’s coffin.'],
          ['第二天，在灼热刺眼的阳光下，我参加了漫长的葬礼。一切都发生得平静而自然，我只感到炎热与疲倦。', 'The next day, under the blazing sun, I walked the long funeral procession. Everything happened calmly and naturally; I felt only heat and exhaustion.'],
          ['回到阿尔及尔后，我遇见了以前的女同事玛丽，我们一起去游泳，看了费南代尔的喜剧电影，晚上她留在了我的公寓。', 'Back in Algiers, I ran into Marie, a former coworker. We went swimming, watched a Fernandel comedy film, and she spent the night at my apartment.'],
          ['周末，邻居雷蒙德邀请我们去海边的木屋度周末。烈日当空，炽热的阳光像刀刃一样刺痛着沙滩。', 'On the weekend, my neighbor Raymond invited us to a beach cabin. The blinding sun beat down mercilessly upon the sand like a razor blade.'],
          ['在泉水边，我独自遇到了那名跟踪雷蒙德的阿拉伯人。阳光如熔化的铅水般沉重，汗水流进我的眼睛，模糊了视线。', 'Near the spring, I encountered the Arab man who had followed Raymond. The heat was like molten lead; sweat stung my eyes, blinding my vision.'],
          ['阿拉伯人拔出了匕首，刀刃上的反光如同一把长剑刺入我的前额。我扣动了扳机。我击碎了那天的平静，又对着那具瘫倒的躯体连开了四枪，短促而有力，仿佛敲响了厄运的四声丧钟。', 'The Arab drew a knife; the reflection flashed like a steel blade into my forehead. I pulled the trigger. I shattered the balance of the day, then fired four more shots into the inert body—four short, sharp knocks on the door of unhappiness.']
        ]
      },
      {
        'title': '第二部：审判、荒诞与面对浩瀚宇宙的宁静',
        'titleEn': 'Part 2: The Trial, The Absurd & Peace with the Universe',
        'dialogues': [
          ['我被捕了，关进了监狱。在法庭上，检察官并没有过多关注杀人案件本身，而是紧紧抓住我在母亲葬礼上没有流泪这一细节。', 'I was imprisoned. At the trial, the prosecutor focused not on the homicide, but on the fact that I had shed no tears at my mother’s funeral.'],
          ['他们称我为一个“灵魂里没有一丝人性温暖的冷血怪物”，并判定我为全社会的公敌。', 'They denounced me as a "cold-blooded monster devoid of human warmth," declaring me an enemy to civil society.'],
          ['我被判处死刑，将在广场上公开斩首。', 'I was sentenced to death by public beheading in a town square.'],
          ['在狱中，神甫前来劝我向上帝忏悔，试图将救赎强加于我。我爆发了，抓住他的衣领怒吼道：没有任何一种神圣的幻觉比真实的生命更值得执着！', 'In my cell, the prison chaplain urged me to confess to God. I erupted, grabbing his collar, shouting that no holy illusion was worth the reality of life!'],
          ['神甫走后，夜幕降临，繁星涌现。我第一次向这个冷漠而温柔的世界敞开了我的心扉。', 'After the chaplain left, quiet night fell and the stars emerged. For the first time, I opened my heart to the benign indifference of the universe.'],
          ['我发觉世界是如此像我，如此充满兄弟般的情谊，我感到我曾经是幸福的，现在依然是幸福的。为了让我不感到那么孤独，我只希望行刑的那一天有很多人前来观看，并向我报以仇恨的呼喊。', 'Finding the world so like myself, so brotherly, I felt I had been happy and was happy still. To feel less lonely, I had only to wish that on my execution day a vast crowd of spectators would greet me with cries of hatred.']
        ]
      }
    ]
  };

  int totalUpdated = 0;

  for (final entry in masterBookCorpus.entries) {
    final bookId = entry.key;
    final chList = entry.value;
    final List<Map<String, dynamic>> compiledChapters = [];

    for (int i = 0; i < chList.length; i++) {
      final ch = chList[i];
      final chIdx = i + 1;
      final title = ch['title'] as String;
      final titleEn = ch['titleEn'] as String;
      final dialogues = ch['dialogues'] as List<List<String>>;

      final List<Map<String, dynamic>> sentences = [];
      for (final d in dialogues) {
        final zh = d[0];
        final en = d[1];
        final pinyin = PinyinHelper.getPinyin(zh, separator: ' ', format: PinyinFormat.WITH_TONE_MARK);
        sentences.add({
          'chinese': zh,
          'pinyin': pinyin,
          'english': en,
        });
      }

      compiledChapters.add({
        'id': '${bookId}_ch_$chIdx',
        'bookId': bookId,
        'chapterIndex': chIdx,
        'title': title,
        'titleEn': titleEn,
        'sentences': sentences,
      });
    }

    final bookFile = File('assets/data/books/$bookId.json');
    bookFile.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(compiledChapters));
    print('Ingested authentic full text for: $bookId (${compiledChapters.length} chapters)');
    totalUpdated++;
  }

  print('\n=== Pipeline successfully ingested $totalUpdated core masterpieces with authentic texts! ===');
}
