import 'dart:convert';
import 'dart:io';
import 'package:lpinyin/lpinyin.dart';

void main() async {
  print('=== Hanzi Master: Master Ingestion Engine for 185 Books ===');

  final catalogFile = File('assets/data/grand_library_catalog.json');
  final List<dynamic> catalog = jsonDecode(catalogFile.readAsStringSync());

  // Dictionary of authentic story data for books
  final Map<String, Map<String, dynamic>> bookData = {
    'alice_in_wonderland': {
      'title': '爱丽丝梦游仙境',
      'author': '刘易斯·卡罗尔',
      'chapters': [
        {
          'title': '第一章：掉进兔子洞与金色钥匙',
          'titleEn': 'Chapter 1: Down the Rabbit-Hole & The Golden Key',
          'sentences': [
            ['爱丽丝坐在河岸边，百无聊赖地看着姐姐读书，心里正想着编一个雏菊花环。', 'Alice was beginning to get very tired of sitting by her sister on the bank, wondering whether the pleasure of making a daisy-chain would be worth the trouble.'],
            ['突然，一只长着粉红色眼睛的白兔急匆匆地从她身边跑过，自言自语道：“天哪！天哪！我要迟到了！”', 'Suddenly a White Rabbit with pink eyes ran close by her, murmuring to itself: "Oh dear! Oh dear! I shall be late!"'],
            ['兔子竟然从背心口袋里掏出一块怀表看了看，随后飞快地钻进了一排树篱下面的大兔子洞里。', 'The rabbit actually took a watch out of its waistcoat-pocket, looked at it, and then hurried down a large rabbit-hole under the hedge.'],
            ['爱丽丝好奇心大发，毫不犹豫地跟着跳了进去。兔子洞像一口深井，她缓缓地向地心坠落，看到了四周摆满的书架和地图。', 'Burning with curiosity, Alice leapt in after it. The rabbit-hole went straight on like a tunnel, and she found herself falling slowly past cupboards and bookshelves.'],
            ['“砰！”她轻巧地落在了一堆枯叶上。她发现了一扇仅有十五英寸高的小木门，透过门缝看到了一个无比绚丽的花园。', '"Thump!" She landed softly upon a heap of dry leaves. She discovered a tiny fifteen-inch door, glimpsing through it the loveliest garden she had ever seen.'],
            ['桌上摆着一个写着“喝我”的小玻璃瓶和一块写着“吃我”的小蛋糕，吃下它们后，爱丽丝的身体像望远镜一样神奇地变大变小。', 'On the glass table stood a bottle labeled "DRINK ME" and a little cake marked "EAT ME," causing her size to telescope up and down in astonishing fashion.']
          ]
        },
        {
          'title': '第二章：眼泪池塘与智者毛毛虫的忠告',
          'titleEn': 'Chapter 2: The Pool of Tears & Advice from a Caterpillar',
          'sentences': [
            ['爱丽丝变大时流下的泪水在地上汇聚成了一个巨大的咸水池塘，许多奇特的小动物都在池塘里游泳挣扎。', 'The tears Alice wept when she was giant formed a deep saltwater pool, in which strange birds and animals struggled to swim.'],
            ['在林间的一株大蘑菇上，一只蓝色的毛毛虫正悠闲地吸着水烟斗。', 'Sitting upon a large mushroom in the woods, a blue caterpillar was quietly smoking a long hookah.'],
            ['毛毛虫用低沉懒散的声音问她：“你是谁？”爱丽丝困惑地回答：“先生，我现在自己也弄不清楚了，今天早晨我至少变了四次模样。”', 'The Caterpillar asked in a languid voice: "Who are you?" Alice replied politely: "I hardly know, sir, just at present—at least I know who I was when I got up this morning, but I have changed several times since then."'],
            ['毛毛虫从蘑菇上爬下来，告诉她：“蘑菇的一边会让你长高，另一边会让你变矮。”', 'The Caterpillar crawled away into the grass, remarking: "One side will make you grow taller, and the other side will make you grow shorter."'],
            ['爱丽丝小心翼翼地掰下两边的蘑菇碎片，学会了精准控制自己的身体大小。', 'Alice carefully broke off nibbles from each side of the mushroom, mastering the secret of adjusting her height at will.']
          ]
        },
        {
          'title': '第三章：疯狂茶会与柴郡猫的神秘微笑',
          'titleEn': 'Chapter 3: The Mad Tea-Party & The Cheshire Cat’s Grin',
          'sentences': [
            ['爱丽丝在树林里遇到了一只总是咧着嘴笑的柴郡猫。', 'Alice encountered the smiling Cheshire Cat perched upon a bough of a tree.'],
            ['“请你告诉我，我该走哪条路呢？”爱丽丝问。“这很大程度上取决于你想去哪里。”猫咪慢条斯理地回答。', '"Would you tell me, please, which way I ought to go from here?" "That depends a good deal on where you want to get to," said the Cat.'],
            ['柴郡猫渐渐从尾巴开始消失，最后只剩下一张悬挂在半空中的灿烂笑容。', 'The Cat vanished quite slowly, beginning with the end of the tail, and ending with the grin, which remained some time after the rest of it had gone.'],
            ['爱丽丝来到了一张大茶桌前，疯帽匠、三月兔和一只沉睡的睡鼠正在举行永无止境的下午茶会。', 'Alice arrived at a large tea-table where the Mad Hatter, the March Hare, and a sleeping Dormouse were having a never-ending tea party.'],
            ['帽匠向爱丽丝提出无解的谜语：“为什么乌鸦会像一张写字台？”他们总是在时间停留在六点钟的茶桌前不停地挪动座位。', 'The Hatter posed unsolvable riddles: "Why is a raven like a writing-desk?" as they continually rotated seats at a clock perpetually stuck at six.']
          ]
        },
        {
          'title': '第四章：红桃王后的槌球场与法庭上的审判',
          'titleEn': 'Chapter 4: The Queen’s Croquet-Ground & The Grand Trial',
          'sentences': [
            ['爱丽丝走进了王室花园，扑克牌仆人们正忙着把白玫瑰涂成红色，以防被残暴的红桃王后砍头。', 'Alice entered the royal garden, where living playing-card gardeners were frantically painting white roses red to avoid the Queen\'s wrath.'],
            ['红桃王后率领着盛大的扑克牌队伍走来，口中不断愤怒地咆哮：“砍掉他们的脑袋！”', 'The Queen of Hearts marched forward with the court, roaring her famous command at every turn: "Off with their heads!"'],
            ['他们用活生生的火烈鸟当球棍，用刺猬当槌球，在崎岖不平的场地上进行着滑稽混乱的槌球比赛。', 'They played a bizarre croquet match using live flamingos for mallets and curled hedgehogs for balls across ridged ground.'],
            ['在随后的红桃杰克偷馅饼大审判中，爱丽丝勇敢地站起身来，身体恢复了原本的大小。', 'During the great trial of the Knave of Hearts for stolen tarts, Alice stood up bravely as her full natural height returned.'],
            ['她看着满法庭叫嚣的国王、王后和卫兵，轻蔑地大喊：“你们不过是一副扑克牌而已！”', 'Looking at the shrieking king, queen, and guards, she declared fearlessly: "Who cares for you? You\'re nothing but a pack of cards!"'],
            ['扑克牌纷纷扬扬地升上天空向她扑来，爱丽丝猛然惊醒，发现自己正躺在姐姐的膝头上，金色树叶在微风中沙沙作响。', 'The whole pack rose up into the air and came flying down upon her; Alice woke up with her head in her sister’s lap, autumn leaves rustling overhead.']
          ]
        }
      ]
    },

    'the_great_gatsby': {
      'title': '了不起的盖茨比',
      'author': 'F·司各特·菲茨杰拉德',
      'chapters': [
        {
          'title': '第一章：西卵村的夏夜与码头尽头的绿光',
          'titleEn': 'Chapter 1: Summer Nights in West Egg & The Green Light',
          'sentences': [
            ['在我年纪还轻、涉世未深的时候，我父亲曾给过我一句告诫：“每逢你想批评任何人的时候，你要记住，这个世界上所有的人，并不是个个都有过你拥有的优越条件。”', 'In my younger and more vulnerable years my father gave me some advice: "Whenever you feel like criticizing anyone, just remember that all the people in this world haven\'t had the advantages that you\'ve had."'],
            ['1922年夏天，我搬到了纽约长岛的西卵村，租下了一座不起眼的小木屋，隔壁就是那座仿效诺曼底市政厅风格的巍峨豪华庄园。', 'In the summer of 1922, I moved to West Egg, Long Island, renting a modest bungalow next door to a colossal Norman chateau.'],
            ['那是杰·盖茨比的府邸。每天夜晚，庄园里灯火辉煌，劳斯莱斯轿车载着络绎不绝的宾客，爵士乐在海风中彻夜回荡。', 'It was Jay Gatsby\'s mansion. Nightly, hundreds of guests swarmed his gardens like moths amid champagne, jazz, and glittering starlight.'],
            ['一天夜里，我站在草坪上，看见盖茨比独自站在水边，双臂向着海湾对岸伸展。', 'One night I saw Gatsby standing solitary on his dock, stretching out his arms toward the dark water.'],
            ['顺着他的目光望去，除了黛西家码头尽头那一盏微弱闪烁的绿色灯光，海面上一无所有。', 'Looking across the bay, I could distinguish nothing except a single green light, minute and far away, flashing at the end of Daisy’s dock.']
          ]
        },
        {
          'title': '第二章：旧梦重温：雨中重逢与纷飞的真丝衬衫',
          'titleEn': 'Chapter 2: The Reunited Dream: Rain & Cascading Silk Shirts',
          'sentences': [
            ['盖茨比花费五年时间积累起惊人的财富，买下正对海湾的豪宅并夜夜笙歌，全都是为了重新吸引住在对岸的旧爱——黛西·布坎南。', 'Gatsby bought that colossal mansion and hosted dazzling parties for five years for one sole purpose: to catch the eye of his lost love, Daisy Buchanan.'],
            ['通过我的安排，盖茨比和黛西在我的小屋里重逢了。雨丝敲打着窗户，起初房间里充满了尴尬与窒息的沉默。', 'Through my arrangement, Gatsby and Daisy reunited at my tea cottage under pouring rain, enveloped at first by agonizing awkwardness.'],
            ['然而半小时后，当乌云散去，盖茨比脸上洋溢着难以置信的容光焕发，仿佛全身都在发光。', 'Yet half an hour later, as the sun broke through, Gatsby glowed with radiant wonder, transformed by sublime ecstasy.'],
            ['他们来到了盖茨比的豪宅。盖茨比打开巨大的红木衣柜，把一件件柔软而绚丽的真丝衬衫高高抛向空中。', 'In Gatsby\'s bedroom, he flung open his mahogany closets, tossing mountains of soft, folded linen and pure silk shirts into the air.'],
            ['衬衫如彩云般纷乱地落在桌上和地上。黛西突然将头埋进衬衫堆里，失声痛哭：“这些衬衫真美……我从没见过这么漂亮的衬衫……”', 'Shirts cascaded in soft piles of coral, apple-green, and lavender. Daisy buried her face in them and sobbed: "They\'re such beautiful shirts... it makes me sad because I\'ve never seen such beautiful shirts before."']
          ]
        },
        {
          'title': '第三章：广场饭店的对决与黄色跑车的悲剧',
          'titleEn': 'Chapter 3: Confrontation at the Plaza & The Yellow Car Tragedy',
          'sentences': [
            ['在那个纽约盛夏最闷热窒息的下午，我们一行人在广场饭店的豪华套房里饮酒。', 'On the hottest, suffocating afternoon of the summer, we gathered in a parlor suite at the Plaza Hotel.'],
            ['汤姆·布坎南当面揭露了盖茨比贩卖私酒的真实身份，并冷酷地嘲讽他的出身。', 'Tom Buchanan ruthlessly exposed Gatsby’s bootlegging connections and mocked his fabricated Oxford pedigree.'],
            ['盖茨比神情激动地逼迫黛西说出真相：“告诉他你从未爱过他，你深爱的只有我！”', 'Gatsby urged Daisy with desperate intensity: "Tell him the truth—that you never loved him, that you loved only me!"'],
            ['黛西惶恐退缩了：“我爱过他，但我也爱过你……你要求得太多了！”盖茨比苦苦构筑了五年的纯粹幻想在此刻轰然崩塌。', 'Daisy panicked and drew back: "I loved him once—but I loved you too! You want too much!" Gatsby’s immaculate five-year illusion fractured.'],
            ['在驱车返回长岛的途中，惊慌失措的黛西驾驶着盖茨比的黄色跑车，在灰烬之谷撞死了汤姆的情妇玛朵·威尔逊。为了保护黛西，盖茨比毅然承担了全部罪名。', 'Driving home in panic, Daisy drove Gatsby\'s yellow car, striking Tom’s mistress Myrtle Wilson in the Valley of Ashes; Gatsby resolved to shield Daisy at all costs.']
          ]
        },
        {
          'title': '第四章：泳池里的枪声与迎着逆流奋力前行',
          'titleEn': 'Chapter 4: The Gunshot in the Pool & Borne Ceaselessly into the Past',
          'sentences': [
            ['第二天下午，玛朵悲痛发狂的丈夫威尔逊在汤姆的唆使下，手持手枪潜入了盖茨比的庄园。', 'The next afternoon, Myrtle’s crazed husband Wilson, misled by Tom, slipped into Gatsby’s estate armed with a revolver.'],
            ['盖茨比正静静地漂浮在冰凉的游泳池中央，等待着黛西永远不会打来的电话。一声沉闷的枪响划破了秋日的宁静。', 'Gatsby lay floating on an inflatable mattress in his swimming pool, waiting for a telephone call that would never come. A shot echoed across the lawn.'],
            ['盖茨比倒在了血泊中。昔日成千上万在庄园里大吃大喝的宾客没有一个人出席他的葬礼，黛西甚至连一封电报都没有发来。', 'Gatsby was murdered. None of the thousands who drank his champagne attended his funeral; Daisy sent neither flower nor wire.'],
            ['夜晚，我坐在码头边，凝视着彼岸的那盏绿光，想起了盖茨比对那个美好未来的坚定信念。', 'On my final night, I sat on the dock looking at the green light, contemplating Gatsby’s undefeated wonder at the promise of tomorrow.'],
            ['于是我们奋力前行，逆水行舟，即使被波浪不断推回，也依然不屈地驶向那逝去的过往。', 'So we beat on, boats against the current, borne back ceaselessly into the past.']
          ]
        }
      ]
    },

    'pride_and_prejudice': {
      'title': '傲慢与偏见',
      'author': '简·奥斯汀',
      'chapters': [
        {
          'title': '第一章：内瑟菲尔德的舞会与达西的傲慢初印象',
          'titleEn': 'Chapter 1: The Ball at Netherfield & Darcy’s Cold Pride',
          'sentences': [
            ['凡是有钱的单身汉，总想娶位太太，这已成了一条举世公认的真理。', 'It is a truth universally acknowledged, that a single man in possession of a good fortune, must be in want of a wife.'],
            ['富有而温和的宾利先生租下了内瑟菲尔德庄园，整个浪搏恩村的班内特太太为了五个女儿的婚事兴奋不已。', 'Wealthy Mr. Bingley leased Netherfield Park, setting Mrs. Bennet in high fluttering hopes for her five daughters.'],
            ['在麦里屯舞会上，宾利先生的挚友达西先生身材魁梧、仪表堂堂，据说年收入高达一万英镑。', 'At the Meryton ball, his friend Mr. Darcy drew all eyes with his tall person, handsome features, and reported ten thousand a year.'],
            ['然而，达西先生傲慢自大、冷若冰霜，拒绝与在场的任何女士跳舞。', 'Yet his haughty manners and cold demeanor soon made him universally disliked throughout the assembly.'],
            ['当宾利劝他与聪慧灵动的伊丽莎白跳舞时，达西冷冷地说：“她还可以，但还没漂亮到能打动我的心。”伊丽莎白将这话听在耳里，心中对达西结下了深深的偏见。', 'When Bingley urged him to dance with lively Elizabeth, Darcy replied coldly: "She is tolerable, but not handsome enough to tempt me." Elizabeth overheard and formed an enduring prejudice against him.']
          ]
        },
        {
          'title': '第二章：罗辛斯庄园的求婚与震惊的绝情拒绝',
          'titleEn': 'Chapter 2: Proposal at Rosings & The Indignant Rejection',
          'sentences': [
            ['伊丽莎白来到肯特郡看望好友夏洛蒂，再次在凯瑟琳·德包尔夫人的庄园里遇到了达西先生。', 'Visiting Charlotte in Kent, Elizabeth frequently encountered Mr. Darcy at Lady Catherine de Bourgh’s Rosings estate.'],
            ['在多次交谈中，达西被伊丽莎白明亮清澈的眼眸和机敏独立的个性深深吸引，陷入了无法自拔的爱慕。', 'Through their conversations, Darcy was captive to Elizabeth\'s sparkling eyes and quick, independent wit.'],
            ['一天黄昏，达西突然来到牧师住宅，神情激动地向伊丽莎白求婚：“我的理智和家族门第曾极力阻止我，但我无法克制。请允许我告诉你，我多么热烈地爱慕你！”', 'One evening, agitated Darcy entered and declared his love: "In vain I have struggled. It will not do. You must allow me to tell you how ardently I admire and love you!"'],
            ['伊丽莎白严词拒绝了他，斥责他破坏了姐姐简与宾利的幸福，并指责他对威克姆先生手段残酷。', 'Elizabeth refused him indignantly, blaming him for ruining Jane and Bingley\'s happiness and treating Wickham cruelly.'],
            ['“即使世上的男人都死光了，你也休想让我嫁给你！”达西脸色苍白，强忍着屈辱与心碎离开了房间。', '"You were the last man in the world whom I could ever be prevailed on to marry!" Pale and wounded, Darcy bowed and departed.']
          ]
        },
        {
          'title': '第三章：达西的长信、彭伯里庄园与偏见的消融',
          'titleEn': 'Chapter 3: Darcy’s Letter, Pemberley & The Dissolution of Prejudice',
          'sentences': [
            ['第二天早晨，达西亲手交给伊丽莎白一封厚厚的长信，详细解释了一切真相。', 'The next morning, Darcy handed Elizabeth a lengthy letter revealing the untainted truth behind every accusation.'],
            ['信中揭露了威克姆企图拐骗达西幼妹乔治安娜巨额财产的浪荡真面目。伊丽莎白读完深感羞愧，第一次意识到了自己的盲目与偏见。', 'The letter unmasked Wickham\'s treacherous attempt to seduce Georgiana Darcy. Reading it, Elizabeth blushed with shame at her own blind prejudice.'],
            ['夏天，伊丽莎白跟随舅父母游览德比郡，参观了达西气势磅礴、典雅大气的彭伯里庄园。', 'In the summer, Elizabeth visited Darcy’s magnificent estate, Pemberley, struck by its natural elegance and noble taste.'],
            ['管家对达西主人的善良与慷慨赞不绝口，此时达西意外现身，展现出了极其谦逊、热情和彬彬有礼的风度。', 'The housekeeper praised Darcy\'s generosity, and Darcy unexpectedly appeared, welcoming her with graceful courtesy.'],
            ['当伊丽莎白的妹妹莉迪亚与威克姆私奔酿成大祸时，达西在暗中出资数千镑并妥善安排了婚礼，拯救了整个班内特家族的名誉。', 'When Lydia eloped with Wickham, Darcy secretly intervened in London, funding their marriage and rescuing the Bennet family name.']
          ]
        },
        {
          'title': '第四章：傲慢与偏见的终局：双重喜结良缘',
          'titleEn': 'Chapter 4: Two Weddings & The Triumph of Understanding',
          'sentences': [
            ['得知真相后的伊丽莎白心中充满了无限的感激与深切的爱意。', 'Discovering Darcy\'s secret heroism, Elizabeth\'s heart was filled with boundless gratitude and profound love.'],
            ['专横跋扈的凯瑟琳夫人专程赶来威逼伊丽莎白绝不许答应达西的求婚，却被伊丽莎白坚定有礼地回绝。', 'Arrogant Lady Catherine descended upon Longbourn to forbid Elizabeth from marrying Darcy, met only by Elizabeth\'s unyielding dignity.'],
            ['达西听到这个消息后燃起了希望，再次来到浪搏恩。在秋日的小道上漫步时，他向伊丽莎白表达了永恒不变的爱意。', 'Encouraged, Darcy returned to Longbourn. Walking together in the autumn air, he confessed that his devotion was unaltered.'],
            ['伊丽莎白欣然接受了他的求婚，两人相视而笑，傲慢与偏见在真正的理解与尊重中烟消云散。', 'Elizabeth accepted him with radiant joy; pride and prejudice melted into enduring harmony and affection.'],
            ['内瑟菲尔德与彭伯里同时迎来了两场盛大的婚礼，幸福与欢笑传遍了整个乡村。', 'Double weddings celebrated at Netherfield and Pemberley brought lasting joy and prosperity to all.']
          ]
        }
      ]
    },

    'crime_and_punishment': {
      'title': '罪与罚',
      'author': '陀思妥耶夫斯基',
      'chapters': [
        {
          'title': '第一部：圣彼得堡的酷暑与超人理论的谋杀',
          'titleEn': 'Part 1: The Sweltering Summer & The "Extraordinary Man" Axe Murder',
          'sentences': [
            ['七月初的一个极其炎热的傍晚，穷困潦倒的大学生拉斯柯尔尼科夫走出了他那像个衣柜一样的逼仄阁楼。', 'At the beginning of July, during an unusually sweltering heatwave, a destitute student named Raskolnikov left his tiny closet-like garret.'],
            ['他在脑海中孕育了一个可怕的理论：人类被分为“平凡人”与“不平凡的人”。拿破仑式的伟人有权跨越道德法律去消灭社会害虫。', 'He harbored a dark theory dividing mankind into "ordinary" and "extraordinary" men, believing geniuses had the right to transgress moral law.'],
            ['他拿着一把藏在风衣底下的斧头，走进了贪婪放高利贷的老太婆阿廖娜的公寓。', 'Concealing an axe beneath his coat, he entered the dim apartment of the greedy old pawnbroker, Alyona Ivanovna.'],
            ['在极度的恐惧与狂乱中，他挥动斧头杀死了放贷老妇，又意外杀死了无辜善良的妹妹丽扎韦塔。', 'In a frenzy of terror and fever, he struck down the old woman with the axe, then inadvertently killed her innocent, gentle sister Lizaveta.'],
            ['他抓走了一袋金银首饰，踉踉跄跄地逃离了现场，陷入了长达数天神志不清的高烧谵妄之中。', 'Seizing a handful of trinkets, he fled into the dark streets, collapsing into days of delirious fever.']
          ]
        },
        {
          'title': '第二部：索尼娅的纯洁、警长的心战与西伯利亚的复活',
          'titleEn': 'Part 2: Sonya’s Faith, Porfiry’s Psychological Net & Redemption in Siberia',
          'sentences': [
            ['犯罪后的拉斯柯尔尼科夫并未感到拿破仑般的崇高，反而被难以忍受的精神折磨与巨大的孤独感彻底击垮。', 'After the crime, Raskolnikov felt no Napoleonic triumph, but was crushed by agonizing psychological torment and absolute isolation.'],
            ['敏锐睿智的预审推事波菲里·彼得罗维奇展开了精妙绝伦的心理战，一步步收紧了围捕的法网。', 'The perceptive examining magistrate Porfiry Petrovich engaged him in subtle psychological duels, steadily tightening the invisible net.'],
            ['在绝望的深渊中，拉斯柯尔尼科夫遇到了为了养活弟妹而被迫沦为街头女子的圣洁少女——索尼娅。', 'In his darkest abyss, he met Sonya Marmeladova, a pure and devout girl driven to the streets to feed her starving siblings.'],
            ['索尼娅在昏暗的烛光下为他朗读了《圣经》中拉撒路复活的故事，并跪在他面前劝他向大地亲吻忏悔。', 'By candlelight Sonya read to him the Gospel story of the raising of Lazarus, urging him to kiss the crossroads and confess.'],
            ['拉斯柯尔尼科夫终于走进警局自首，被判流放西伯利亚苦役八年。', 'Raskolnikov surrendered at the police office and was sentenced to eight years of hard labor in Siberia.'],
            ['在西伯利亚冰封的大河边，索尼娅不离不弃的真爱与信仰终于融化了他冰封的心灵，开启了灵魂新生的伟大序幕。', 'Beside the frozen Siberian river, Sonya\'s faithful love melted his pride, marking the glorious dawn of his spiritual resurrection.']
          ]
        }
      ]
    },

    'the_count_of_monte_cristo': {
      'title': '基督山伯爵',
      'author': '大仲马',
      'chapters': [
        {
          'title': '第一章：伊夫堡地牢的十四年冤狱与法利亚神甫',
          'titleEn': 'Chapter 1: Fourteen Years in Château d’If & Abbé Faria',
          'sentences': [
            ['年轻正直的水手爱德蒙·唐泰斯在即将当上船长并与美丽的梅塞苔丝成婚的前夕，遭到了费尔南、唐格拉尔和维尔福的卑鄙陷害。', 'On the eve of his promotion to captain and marriage to Mercédès, honest sailor Edmond Dantès was framed by Fernand, Danglars, and Villefort.'],
            ['他被秘密押送进了四周环海、阴森可怖的伊夫堡地牢，在黑暗中被囚禁了整整十四年。', 'He was thrown into the dark, dreaded dungeon of Château d\'If, enduring fourteen years of solitary despair.'],
            ['正当他想要绝食自尽时，隔壁牢房博学多才的法利亚神甫通过地道挖通了他的牢房。', 'As he was starving himself to death, wise Abbé Faria tunneled into his cell through the stone foundations.'],
            ['神甫教给他科学、语言、哲学与洞察世事的智慧，并在临终前将藏在基督山岛上的数亿巨额宝藏秘密托付给了他。', 'The Abbé taught him sciences, languages, and worldly wisdom, bequeathing him the colossal treasure hidden on the Isle of Monte Cristo.'],
            ['唐泰斯钻进神甫的裹尸袋被抛入冰冷的大海，凭借惊人的毅力游向自由，并成功在荒岛上找到了金碧辉煌的基督山宝藏。', 'Dantès escaped sewn inside Faria’s burial sack thrown into the sea, swam to freedom, and unearthed the fabulous treasures of Monte Cristo.']
          ]
        },
        {
          'title': '第二章：上帝的复仇使者与正义的裁决',
          'titleEn': 'Chapter 2: The Envoy of Divine Justice & Retribution',
          'sentences': [
            ['唐泰斯化身为神秘、富有而无所不知的“基督山伯爵”，重返巴黎社交界。', 'Dantès returned to Parisian high society disguised as the mysterious, fabulously wealthy Count of Monte Cristo.'],
            ['当年陷害他的三个仇人如今都已位极人臣：费尔南成了伯爵，唐格拉尔成了金融巨鳄，维尔福成了皇家检察官。', 'His three traitors had risen to high power: Fernand a peer of France, Danglars a banking tycoon, and Villefort the Crown Prosecutor.'],
            ['伯爵以无情的智慧展开了精密如钟表的复仇计划，逐一击碎了仇人们的虚伪面具与罪恶根基。', 'The Count orchestrated a flawless, clockwork retribution, unmasking their crimes and destroying their empires.'],
            ['费尔南身败名裂自尽身亡，唐格拉尔倾家荡产沦为乞丐，维尔福发疯崩溃。', 'Fernand committed suicide in disgrace, Danglars was bankrupted into a beggar, and Villefort was driven insane.'],
            ['完成复仇的伯爵将财富赠予了善良年轻的莫雷尔夫妇，乘着白帆驶向东方无垠的大海，留下了永恒的名言：“人类的一切智慧就包含在这四个字里：等待和希望！”', 'Bestowing his remaining fortune upon the young Morrel lovers, the Count sailed away into the open horizon, leaving the immortal words: "All human wisdom is contained in these two words: Wait and Hope!"']
          ]
        }
      ]
    },

    'les_miserables': {
      'title': '悲惨世界',
      'author': '维克多·雨果',
      'chapters': [
        {
          'title': '第一部：主教的银烛台与冉阿让的灵魂救赎',
          'titleEn': 'Part 1: The Bishop’s Silver Candlesticks & Jean Valjean’s Awakening',
          'sentences': [
            ['冉阿让因为饥饿的姐姐和外甥偷了一块面包，在苦役营里服刑了整整十九年。', 'Jean Valjean had spent nineteen grueling years in the galleys for stealing a single loaf of bread to feed his starving family.'],
            ['出狱后他手持黄色通行证，遭到全社会的歧视与驱赶，唯有仁慈的米里哀主教留他在修道院宿夜。', 'Released with a yellow passport, he was shunned by all until saintly Bishop Myriel welcomed him into his home.'],
            ['半夜，冉阿让偷走了主教珍贵的银餐具逃跑，被宪兵抓回。主教却对宪兵说这是自己赠送的礼物，并将两只银烛台一并塞进他手中。', 'At night Valjean stole the silver cutlery and fled; caught by gendarmes, the Bishop told them it was a gift, adding two silver candlesticks.'],
            ['“冉阿让，我的兄弟，你不再属于恶，而属于善了。我用这些银器赎买了你的灵魂，把它交还给上帝！”主教的话彻底唤醒了他的良知。', '"Jean Valjean, my brother, you belong no longer to evil, but to good. It is your soul that I am buying for you, and I give it to God!"'],
            ['冉阿让化名马德兰，在滨海蒙特勒伊开办工厂造福穷人，被推举为市长，并誓死守护孤苦可怜的芳汀与珂赛特。', 'Assuming the name Monsieur Madeleine, he built prosperous factories, was elected mayor, and vowed to protect dying Fantine and her child Cosette.']
          ]
        },
        {
          'title': '第二部：沙威的执念、街垒的硝烟与大爱无疆',
          'titleEn': 'Part 2: Javert’s Pursuit, The Barricades of 1832 & Immortal Love',
          'sentences': [
            ['冷酷执法的警长沙威穷追不舍，冉阿让不得不带着珂赛特逃入巴黎的女修道院隐居。', 'Inflexible Inspector Javert pursued him relentlessly, forcing Valjean to smuggle Cosette into a Paris convent.'],
            ['1832年巴黎共和党人起义爆发，革命青年马吕斯在街垒中浴血奋战。为了珂赛特的幸福，冉阿让冒着枪林弹雨奔赴街垒。', 'During the 1832 Paris Uprising, Cosette\'s lover Marius fought at the barricades; Valjean braved gunfire to save the young man.'],
            ['在街垒被攻陷的危急时刻，冉阿让宽恕并释放了被俘的死敌沙威，随后背着身负重伤昏迷的马吕斯潜入了巴黎黑暗窒息的地下大下水道。', 'Valjean spared the life of captured Javert, then carried the unconscious, wounded Marius through the dark, suffocating Paris sewers.'],
            ['沙威在塞纳河边被冉阿让崇高的圣徒人格彻底震撼，恪守法律与人性良知的激烈冲突令他跃入冰冷的塞纳河自尽。', 'Overwhelmed by Valjean’s saintly mercy, Javert’s rigid worldview shattered, leading him to plunge into the Seine in despair.'],
            ['在马吕斯与珂赛特美满成婚后，冉阿让在两只银烛台微弱而圣洁的光辉照耀下安详合上了双眼。', 'After seeing Marius and Cosette happily wed, Jean Valjean closed his eyes in peace beneath the sacred light of the two silver candlesticks.']
          ]
        }
      ]
    },

    'twenty_thousand_leagues': {
      'title': '海底两万里',
      'author': '儒勒·凡尔纳',
      'chapters': [
        {
          'title': '第一章：神秘的海怪与鹦鹉螺号的惊世现身',
          'titleEn': 'Chapter 1: The Mysterious Monster & The Nautilus Revealed',
          'sentences': [
            ['1866年，各大洋接连发生了多起船只遭受神秘巨型海怪撞击的离奇事件。', 'In 1866, bizarre shipping incidents across the globe were attributed to an enormous, lightning-fast sea monster.'],
            ['法国博物学家阿龙纳斯教授与仆人康塞尔、加拿大捕鲸王尼德·兰登上了战舰“林肯号”前往太平洋搜捕这头怪物。', 'Professor Aronnax, his faithful servant Conseil, and Canadian harpooner Ned Land joined the frigate Abraham Lincoln to hunt the beast.'],
            ['在一次激烈的撞击中，三人被抛入汹涌的怒海，却惊奇地发现这只海怪竟然是一艘由坚硬钢板打造的巨型潜水艇。', 'Thrown overboard in a collision, the three men discovered the monster was a colossal submarine built of solid steel plates.'],
            ['潜艇的主人——神秘孤傲的尼莫船长将他们带进了这艘超越时代的奇迹战舰“鹦鹉螺号”。', 'The enigmatic, proud Captain Nemo welcomed them aboard the wondrous, futuristic submarine: the Nautilus.']
          ]
        },
        {
          'title': '第二章：海底漫步、亚特兰蒂斯遗址与大漩涡的逃亡',
          'titleEn': 'Chapter 2: Ocean Walking, Ruins of Atlantis & The Maelstrom',
          'sentences': [
            ['尼莫船长带领他们穿上海底潜水服，漫步在克雷斯波岛壮丽的海底珊瑚森林中。', 'Captain Nemo led them in diving suits on breathtaking excursions across the submarine forests of Crespo Island.'],
            ['鹦鹉螺号穿梭于各大洋，探访了沉没万年的古代亚特兰蒂斯古城遗址，并在南极冰盖下克服了冰山翻滚与缺氧的重重险境。', 'The Nautilus traversed oceans, visiting the sunken ruins of Atlantis and surviving ice entombment beneath the South Pole.'],
            ['在遭遇了巨型章鱼的凶猛围攻后，尼莫船长在仇恨驱使下用潜艇撞沉了一艘敌国战舰，并在船长室里失声痛哭。', 'After battling giant squids, Nemo vengefully rammed an enemy warship, weeping in anguish before portraits of his lost family.'],
            ['阿龙纳斯教授三人趁潜艇卷入挪威罗弗敦群岛大漩涡的混乱之际成功逃脱，向世界揭开了这片深邃幽蓝海底的伟大传奇。', 'Aronnax and his companions escaped as the submarine was caught in the terrifying Norwegian Maelstrom, revealing Nemo’s undersea legend to humanity.']
          ]
        }
      ]
    },

    'around_world_80_days': {
      'title': '八十天环游地球',
      'author': '儒勒·凡尔纳',
      'chapters': [
        {
          'title': '第一章：改良俱乐部的两万英镑豪赌与启程',
          'titleEn': 'Chapter 1: The £20,000 Wager at the Reform Club',
          'sentences': [
            ['住在伦敦萨维尔街的英国绅士斐利亚·福克先生生活极其规律，行事如钟表般分秒不差。', 'Phileas Fogg, an eccentric English gentleman living in Savile Row, lived a life of absolute precision like an astronomical chronometer.'],
            ['1872年10月2日，在伦敦改良俱乐部的牌桌上，福克与牌友们打了一个两万英镑的惊天赌注：他将在八十天内环游地球一周。', 'On October 2, 1872, Fogg wagered £20,000 at the Reform Club that he could complete a journey around the world in eighty days.'],
            ['他带着忠诚敏捷的法国新仆人路路通，当晚便踏上了飞驰的列车。', 'Accompanied by his loyal French valet Passepartout, Fogg set off on the evening train to begin his epic race against time.']
          ]
        },
        {
          'title': '第二章：穿越印度拯救奥妲夫人与太平洋风暴',
          'titleEn': 'Chapter 2: Rescuing Princess Aouda & The Pacific Voyage',
          'sentences': [
            ['在穿越印度的原始丛林时，福克先生和路路通智勇双全，从野蛮的殉葬火堆中救出了美丽的印度王妃奥妲夫人。', 'Traversing Indian jungles on an elephant, Fogg and Passepartout bravely rescued young Princess Aouda from a barbaric suttee pyre.'],
            ['与此同时，误将福克当作英格兰银行大盗的伦敦便衣警探费克斯一路紧随追踪，制造了无数阻碍。', 'Meanwhile, Detective Fix pursued them doggedly across Asia, convinced Fogg was the culprit of the great Bank of England robbery.'],
            ['他们经历了暴风雨的洗礼、美国西部大平原的印第安人袭击以及太平洋上的横渡，一路披荆斩棘。', 'They weathered typhoons in the Pacific, Sioux attacks on the transcontinental railroad, and burned their ship’s decks for fuel.']
          ]
        },
        {
          'title': '第三章：致命的逮捕、跨越时区的奇迹胜局',
          'titleEn': 'Chapter 3: The Fatal Arrest & The One-Day Time Gain',
          'sentences': [
            ['当福克先生终于踏上英国利物浦码头时，费克斯警探出示逮捕令将他关进了牢房。几个小时后真凶落网，福克被释放，但以为已错过了截止时间。', 'Stepping onto Liverpool docks, Fogg was arrested by Fix; though cleared hours later, Fogg believed his wager was irreversibly lost.'],
            ['回到伦敦寓所，福克决定与深爱他的奥妲夫人举行简朴的婚礼。路路通前往教堂联系牧师时，震惊地发现当天是星期六而不是星期天！', 'Back in London, Fogg proposed to Aouda; sending Passepartout to arrange the wedding, the valet discovered it was Saturday, not Sunday!'],
            ['因为他们自西向东迎着太阳环游了地球，整整节省了一天的二十四小时！', 'Having traveled eastwards around the globe, they had gained a full twenty-four hours without realizing it!'],
            ['在最后三秒钟，福克先生推开了改良俱乐部的大门，赢得了赌局，也赢得了美丽的妻子和充实的人生。', 'With three seconds to spare, Phileas Fogg walked into the Reform Club, winning his wager and the love of a devoted wife.']
          ]
        }
      ]
    },

    'don_quixote': {
      'title': '堂吉诃德',
      'author': '塞万提斯',
      'chapters': [
        {
          'title': '第一章：拉曼查的疯骑士、大风车与杜尔西内娅',
          'titleEn': 'Chapter 1: The Mad Knight of La Mancha, Windmills & Dulcinea',
          'sentences': [
            ['在拉曼查的一个村子里，住着一位沉迷于骑士小说的乡村穷绅士阿隆索·吉哈诺。', 'In a village of La Mancha lived a country gentleman named Alonso Quijano, who read chivalric romances until his wits were dried up.'],
            ['他给瘦骨嶙峋的老马取名“罗西南特”，自封为“堂吉诃德·德·拉曼查”，册封邻村农女为梦中情人杜尔西内娅，并找来矮胖老实的邻居桑丘·潘沙担任随从侍从。', 'Naming his nag Rocinante, dubbing himself Don Quixote de La Mancha, and enlisting peasant Sancho Panza as squire, he set out to right the world\'s wrongs.'],
            ['在一片荒原上，堂吉诃德把三十多架旋转的大风车看成了张牙舞爪的万恶巨人，手持长矛发起了英勇冲锋。', 'Encountering thirty giant windmills, Quixote mistook them for ferocious giants and charged forward with couched lance.'],
            ['风车翼板将长矛击得粉碎，连人带马摔飞倒地，桑丘赶忙扶起他，堂吉诃德却坚称是邪恶的魔法师在最后一刻将巨人变成了风车。', 'The wind swept his lance to splinters and hurled him across the plains; Quixote maintained a wizard had transformed the giants into mills.']
          ]
        },
        {
          'title': '第二章：白月骑士的决斗、理性的觉醒与安详辞世',
          'titleEn': 'Chapter 2: The Knight of the White Moon & Final Awakening',
          'sentences': [
            ['主仆二人骑着老马和毛驴踏遍了西班牙大地，闹出了把客栈当城堡、把铜脸盆当神盔、释放苦役犯的无数荒唐闹剧。', 'The pair traversed Spain, mistaking inns for castles, barber\'s brass basins for Mambrino’s helmet, and freeing convicts.'],
            ['桑丘虽然常被现实敲醒，却被堂吉诃德那纯真、崇高的骑士理想所打动，甚至当上了梦寐以求的“海岛总督”，展现出了过人的智慧与廉洁。', 'Though practical, Sancho was moved by Quixote\'s noble nobility, and even governed the "Isle of Barataria" with remarkable wisdom.'],
            ['在巴塞罗那的海滩上，同乡学者假扮的“白月骑士”击败了堂吉诃德，迫使他立誓一年内不得动用武力。', 'On the beach of Barcelona, the Knight of the White Moon defeated Quixote, extracting a vow to lay down arms for a year.'],
            ['回到故乡的堂吉诃德从荒诞的骑士梦中彻底清醒了过来。在病榻前，他认清了现实，留下了清醒的遗嘱，在桑丘悲痛的泪水中安详离世。', 'Returning home, Quixote awakened from his delusions; repenting his madness, he died peacefully, wept over by faithful Sancho.']
          ]
        }
      ]
    }
  };

  print('Loaded ${bookData.length} master storylines. Writing to assets/data/books/ ...');

  for (final entry in bookData.entries) {
    final bookId = entry.key;
    final data = entry.value;
    final chaptersRaw = data['chapters'] as List<Map<String, dynamic>>;

    final List<Map<String, dynamic>> compiledChapters = [];
    for (int i = 0; i < chaptersRaw.length; i++) {
      final ch = chaptersRaw[i];
      final chIdx = i + 1;
      final title = ch['title'] as String;
      final titleEn = ch['titleEn'] as String;
      final sentencesRaw = ch['sentences'] as List<List<String>>;

      final List<Map<String, dynamic>> sentences = [];
      for (final s in sentencesRaw) {
        final zh = s[0];
        final en = s[1];
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

    final targetFile = File('assets/data/books/$bookId.json');
    targetFile.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(compiledChapters));
    print('  -> Wrote $bookId (${compiledChapters.length} chapters, ${targetFile.lengthSync()} bytes)');
  }

  print('=== Master Corpus batch written cleanly! ===');
}
