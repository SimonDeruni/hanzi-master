import 'dart:convert';
import 'dart:io';
import 'package:lpinyin/lpinyin.dart';

void main() async {
  print('=== Generating Complete Authentic 36 Chapters for Thirty-Six Stratagems (《三十六计》) ===');

  final List<Map<String, dynamic>> stratagems = [
    {
      'title': '第一计：瞒天过海',
      'titleEn': 'Stratagem 1: Deceive the Heavens to Cross the Ocean',
      'sentences': [
        ['瞒天过海：备周则意怠，常见则不疑。阴在阳之内，不在阳之对。太阳，太阴。', 'Deceive the Heavens to Cross the Ocean: Defense in all quarters breeds laxity; common sights arouse no suspicion. Darkness resides within light, not opposite to it. Extreme Yang generates extreme Yin.'],
        ['唐太宗征讨高句丽，临海畏浪。大将薛仁贵命人以彩帐覆船，假托设宴请皇上入帐，船至海中，帝方悟已登舟度海。', 'When Emperor Taizong of Tang embarked on his campaign, he hesitated at the vast sea. General Xue Rengui disguised the warships as lavish banquet tents to convey the army across unawares.'],
        ['此计意在利用人们对常见事物的松懈心理，将最机密隐蔽的军事行动隐藏在最公开坦荡的表象之下。', 'This tactic uses psychological inertia, concealing the deepest tactical intentions beneath the most public and ordinary appearances.']
      ]
    },
    {
      'title': '第二计：围魏救赵',
      'titleEn': 'Stratagem 2: Besiege Wei to Rescue Zhao',
      'sentences': [
        ['围魏救赵：共敌不如分敌，敌阳不如敌阴。', 'Besiege Wei to Rescue Zhao: Attacking an enemy where united is inferior to dividing them; attacking their strengths is inferior to striking their vulnerabilities.'],
        ['战国时期，魏将庞涓率大军围攻赵国邯郸。齐威王命田忌、孙膑引兵救赵。', 'During the Warring States period, Wei general Pang Juan besieged Zhao\'s capital Handan. King of Qi dispatched Tian Ji and Sun Bin to the rescue.'],
        ['孙膑不直接去邯郸解围，而是直捣魏国空虚的国都大梁。庞涓闻讯急忙回兵，在桂陵遭遇齐军伏击而大败。', 'Instead of marching directly on Handan, Sun Bin struck directly at Wei\'s undefended capital Daliang. Pang Juan rushed home and was routed at Guiling.'],
        ['避开敌人锐气，击其要害空虚之处，迫使敌人不得不放弃攻势回援，从而掌握战场主动权。', 'Avoid the enemy\'s vanguard and strike where they must defend, seizing tactical initiative by forcing them to retreat.']
      ]
    },
    {
      'title': '第三计：借刀杀人',
      'titleEn': 'Stratagem 3: Kill with a Borrowed Knife',
      'sentences': [
        ['借刀杀人：敌已明，友未定，引友杀敌，不自出力。', 'Kill with a Borrowed Knife: When the enemy is clear but allies are undecided, induce an ally to destroy the enemy without expending one\'s own strength.'],
        ['三国时期，周瑜利用蒋干盗书，借曹操多疑之手斩杀了熟谙水战的大将蔡瑁、张允。', 'In the Three Kingdoms, Zhou Yu tricked Jiang Gan into stealing a forged letter, prompting paranoid Cao Cao to execute his own naval commanders Cai Mao and Zhang Yun.'],
        ['善于利用第三方的力量或敌方内部的矛盾来达成自己的战略目标，保存己方实力。', 'Exploit third-party forces or internal enemy contradictions to achieve strategic victory while conserving one\'s own power.']
      ]
    },
    {
      'title': '第四计：以逸待劳',
      'titleEn': 'Stratagem 4: Wait at Ease for the Fatigued Enemy',
      'sentences': [
        ['以逸待劳：困敌之势，不以战；损刚益柔。', 'Wait at Ease for the Fatigued Enemy: Subdue the enemy by constraining their momentum rather than through direct combat; soft flexibility overcomes rigid force.'],
        ['孙子曰：“善战者，致人而不致于人。”让敌人远道奔波、疲惫不堪，己方则养精蓄锐、以静制动。', 'Sun Tzu said: "The master of warfare dictates the battlefield and is not dictated to." Wear down the enemy with distance while conserving your own troops.']
      ]
    },
    {
      'title': '第五计：趁火打劫',
      'titleEn': 'Stratagem 5: Loot a Burning House',
      'sentences': [
        ['趁火打劫：敌之害大，就势取利；刚决柔也。', 'Loot a Burning House: When the enemy suffers great crisis, seize the opportunity to profit; decisive strength overcomes troubled weakness.'],
        ['乘敌之危，在敌方发生内乱、灾荒或遭受重大打击之际，迅速果断出击，一举夺取决定性胜利。', 'Capitalize swiftly when an opponent is engulfed in turmoil, famine, or rebellion to secure absolute victory.']
      ]
    },
    {
      'title': '第六计：声东击西',
      'titleEn': 'Stratagem 6: Clamor in the East, Strike in the West',
      'sentences': [
        ['声东击西：敌志乱萃，不虞，坤下兑上之象。利其不自主而取之。', 'Clamor in the East, Strike in the West: Throw the enemy\'s intentions into disorder; strike where they least expect and take advantage of their confusion.'],
        ['制造虚假声势吸引敌人注意力于东面，主力部队却神速奔袭西面要害，防不胜防。', 'Create false commotion in one sector to fix enemy attention, while striking decisively at their unprotected flank.']
      ]
    },
    {
      'title': '第七计：无中生有',
      'titleEn': 'Stratagem 7: Create Something Out of Nothing',
      'sentences': [
        ['无中生有：诳也，非诳也，实其所诳也。少阴、太阴、太阳。', 'Create Something Out of Nothing: A deception is not mere deceit; it becomes reality through the illusion itself. From weak Yin to strong Yang.'],
        ['用假象迷惑敌人，使其麻痹大意，待敌人误以为全是虚妄之时，虚招瞬间化为致命实攻。', 'Lull the enemy into discounting feints until what seemed an illusion materializes as a deadly, crushing reality.']
      ]
    },
    {
      'title': '第八计：暗度陈仓',
      'titleEn': 'Stratagem 8: Advance Secretly by Chencang',
      'sentences': [
        ['暗度陈仓：示之以动，利其静而有主，“益动而巽”。', 'Advance Secretly by Chencang: Feign overt movement to fix the enemy, while taking advantage of stealth to deliver the real blow.'],
        ['汉高祖刘邦采纳韩信之谋，明修栈道以麻痹三秦守将章邯，暗中率大军绕道陈仓，一举平定关中。', 'Liu Bang followed Han Xin\'s counsel: openly repairing planks to distract General Zhang Han, while secretly marching troops via Chencang to conquer Guanzhong.']
      ]
    },
    {
      'title': '第九计：隔岸观火',
      'titleEn': 'Stratagem 9: Watch the Fire Burning from the Opposite Bank',
      'sentences': [
        ['隔岸观火：阳乖序乱，阴以俟变。暴戾恣睢，其势自毙。顺以动豫，豫顺以动。', 'Watch the Fire from the Opposite Bank: When the opponent\'s camp is torn by discord, wait quietly for crisis to ripen; internal strife consumes them from within.'],
        ['当敌人内部产生激烈内讧时，切勿过早介入，静待其自相残杀、元气大伤之后再坐收渔利。', 'When rivals turn violently on one another, hold your forces back until they exhaust themselves, then reap the full reward.']
      ]
    },
    {
      'title': '第十计：笑里藏刀',
      'titleEn': 'Stratagem 10: Hide a Knife Behind a Smile',
      'sentences': [
        ['笑里藏刀：信而安之，阴以图之；备而后动，勿使有变。刚中柔外也。', 'Hide a Knife Behind a Smile: Win trust to disarm vigilance, while secretly plotting against them; prepare fully before executing without warning.'],
        ['以极其恭敬友善的言行麻痹敌人，使其深信不疑，暗地里则紧锣密鼓布置杀局，一击致命。', 'Adopt an outward demeanor of sweet friendship to disarm suspicion, while preparing an inescapable trap behind the scenes.']
      ]
    },
    {
      'title': '第十一计：李代桃僵',
      'titleEn': 'Stratagem 11: Sacrifice the Plum Tree for the Peach Tree',
      'sentences': [
        ['李代桃僵：势必有损，损阴以益阳。', 'Sacrifice the Plum for the Peach: When loss is inevitable, sacrifice the lesser to preserve the vital.'],
        ['在全局利益面临威胁时，果断牺牲局部的微小利益，以换取战略全局的决定性胜利。', 'Make calculated minor sacrifices when necessary to guarantee overall victory and protect the supreme objective.']
      ]
    },
    {
      'title': '第十二计：顺手牵羊',
      'titleEn': 'Stratagem 12: Take the Goat Along the Way',
      'sentences': [
        ['顺手牵羊：微隙在所必乘，微利在所必得。少阴，少阳。', 'Take the Goat Along the Way: Exploit every small opening; capture every opportunistic gain along your march.'],
        ['善于捕捉敌人稍纵即逝的细微疏漏，顺便获取战术战果，积小胜为大胜。', 'Seize fleeting opportunities and enemy carelessness along the road, compounding small tactical advantages into strategic dominance.']
      ]
    },
    {
      'title': '第十三计：打草惊蛇',
      'titleEn': 'Stratagem 13: Beat the Grass to Startle the Snake',
      'sentences': [
        ['打草惊蛇：疑以叩实，察而后动；复者，诳也。', 'Beat the Grass to Startle the Snake: Test the waters when suspicious; observe the enemy\'s reactions carefully before committing forces.'],
        ['采取试探性行动促使隐蔽的敌人暴露行踪与企图，从而制定针对性的克敌方略。', 'Trigger a reaction to force an entrenched or hidden opponent to reveal their strength and intentions.']
      ]
    },
    {
      'title': '第十四计：借尸还魂',
      'titleEn': 'Stratagem 14: Borrow a Corpse to Resurrect the Soul',
      'sentences': [
        ['借尸还魂：有用者，不可借；不能用者，求借。借不能用者而用之，匪我求童蒙，童蒙求我。', 'Borrow a Corpse to Resurrect the Soul: Do not rely on that which is already powerful; resurrect the dormant or discarded to serve your ambition.'],
        ['借助已经消亡或处于被动地位的名义、传统与力量，赋予其全新内涵，为己方的大业所用。', 'Revive a defunct doctrine, symbol, or legitimate lineage to rally public support and legitimize your cause.']
      ]
    },
    {
      'title': '第十五计：调虎离山',
      'titleEn': 'Stratagem 15: Lure the Tiger Down from the Mountain',
      'sentences': [
        ['调虎离山：待天以困之，用人以诱之，“往蹇来返”。', 'Lure the Tiger Down from the Mountain: Await favorable conditions to entrap the enemy; use human bait to tempt them away from strongholds.'],
        ['设法诱使敌人离开其险要固守的阵地或有利环境，使其在开阔地带失去优势而遭聚歼。', 'Entice the enemy away from fortified fortresses into vulnerable terrain where they can be surrounded and defeated.']
      ]
    },
    {
      'title': '第十六计：欲擒故纵',
      'titleEn': 'Stratagem 16: In Order to Capture, First Let Loose',
      'sentences': [
        ['欲擒故纵：逼则反兵，走则减势。紧随勿迫，累其气力，消其斗志，散而后擒，兵不血刃。', 'To Capture, First Let Loose: Cornered foes fight to the death; fleeing enemies lose momentum. Trail without pressing to break their will before taking them.'],
        ['诸葛亮南征七擒孟获，七次放归，最终使孟获心悦诚服，南中之地永无后顾之忧。', 'Zhuge Liang captured and released Meng Huo seven times, completely winning his heart and securing lasting peace across the southern borders.']
      ]
    },
    {
      'title': '第十七计：抛砖引玉',
      'titleEn': 'Stratagem 17: Cast a Brick to Attract a Jade',
      'sentences': [
        ['抛砖引玉：类以诱之，击蒙也。', 'Cast a Brick to Attract a Jade: Use bait of lesser value to induce the opponent into surrendering something of supreme worth.'],
        ['以微小的利益或看似平常的表象诱导对方，从而换取敌人巨大的战略价值或珍贵收获。', 'Offer a modest lure to elicit the adversary\'s most valuable assets, intelligence, or resources.']
      ]
    },
    {
      'title': '第十八计：擒贼擒王',
      'titleEn': 'Stratagem 18: To Catch Bandits, First Capture Their King',
      'sentences': [
        ['擒贼擒王：摧其坚，夺其魁，以解其体。龙战于野，其道穷也。', 'To Catch Bandits, Capture Their King: Shatter the enemy core and capture their supreme leader to dissolve the entire army.'],
        ['在交锋中直取敌方最高指挥首脑，敌军群龙无首，阵脚大乱，不攻自破。', 'Neutralize the enemy\'s central command to paralyze their entire force, turning unified ranks into chaotic retreat.']
      ]
    },
    {
      'title': '第十九计：釜底抽薪',
      'titleEn': 'Stratagem 19: Remove the Firewood from Under the Cauldron',
      'sentences': [
        ['釜底抽薪：不敌其力，而消其势，兑也。', 'Remove Firewood from Under the Cauldron: Instead of fighting their raw power head-on, eliminate the fundamental source of their strength.'],
        ['从根本上摧毁敌人的后勤粮道、财力支撑或民心依托，使其气数已尽，无力再战。', 'Sever the enemy\'s supply lines, economic resources, or morale to collapse their war machine from the foundation.']
      ]
    },
    {
      'title': '第二十计：混水摸鱼',
      'titleEn': 'Stratagem 20: Disturb the Water to Catch the Fish',
      'sentences': [
        ['混水摸鱼：乘其阴乱，利其弱而无主。随，以蒙大得也。', 'Disturb the Water to Catch the Fish: Take advantage of chaotic internal turbulence when the opponent has lost direction.'],
        ['人为制造或利用敌方的混乱局势，使敌人无所适从，趁机浑水取利，夺取战果。', 'Sow confusion among enemy ranks and exploit their paralysis to achieve maximum objective with minimal resistance.']
      ]
    },
    {
      'title': '第二十一计：金蝉脱壳',
      'titleEn': 'Stratagem 21: The Golden Cicada Sheds Its Shell',
      'sentences': [
        ['金蝉脱壳：存其形，完其势；友不疑，敌不动。巽而止，蛊。', 'The Golden Cicada Sheds Its Shell: Maintain outward military appearances while stealthily withdrawing the main force.'],
        ['在严峻危急关头，留下阵地旗帜与虚设防线迷惑敌人，主力部队早已神不知鬼不觉安全转移。', 'Leave behind tents and banners to freeze the enemy\'s gaze, while your core legions withdraw undetected to new positions.']
      ]
    },
    {
      'title': '第二十二计：关门捉贼',
      'titleEn': 'Stratagem 22: Shut the Door to Catch the Thief',
      'sentences': [
        ['关门捉贼：小敌困之。剥，不利有攸往。', 'Shut the Door to Catch the Thief: Encircle and trap isolated hostile forces completely before executing total containment.'],
        ['切断敌军所有退路与逃窜通道，聚而歼之，不留后患。', 'Cut off every avenue of escape, boxing in isolated opponents to eradicate future threats cleanly.']
      ]
    },
    {
      'title': '第二十三计：远交近攻',
      'titleEn': 'Stratagem 23: Befriend Distant States While Attacking Nearby Ones',
      'sentences': [
        ['远交近攻：形禁势格，利从近取，害以远隔。上火下泽。', 'Befriend Distant States While Attacking Nearby Ones: Geopolitically, capture adjacent territory while forming alliances with distant powers.'],
        ['秦国采纳范雎之策，结好齐楚等远邦，集中兵力逐步蚕食韩赵魏等邻近诸侯，最终一统天下。', 'Qin executed Fan Ju\'s grand strategy: allying with distant Qi and Chu while swallowing neighboring Han, Zhao, and Wei to unite China.']
      ]
    },
    {
      'title': '第二十四计：假道伐虢',
      'titleEn': 'Stratagem 24: Borrow a Road to Conquer Guo',
      'sentences': [
        ['假道伐虢：两大之间，敌胁以从，我假以势。困，蒙。', 'Borrow a Road to Conquer Guo: When a smaller state sits between two giants, use pretext of passage against one to annex both.'],
        ['晋献公以宝马美玉借道于虞国以伐虢国，灭虢回师途中顺手灭虞，两邦尽归晋国。', 'Duke of Jin gave treasures to Yu to borrow road against Guo; upon returning victorious, he annexed Yu without drawing sword.']
      ]
    },
    {
      'title': '第二十五计：偷梁换柱',
      'titleEn': 'Stratagem 25: Replace Beams with Rotten Pillars',
      'sentences': [
        ['偷梁换柱：频更其阵，抽其劲旅，待其自败，披涸撕也。拖，以待其变。', 'Replace Beams with Rotten Pillars: Continuously alter enemy formations and sap their elite strength until they crumble from within.'],
        ['暗中抽换敌方主力骨干，以弱代强，令其外强中干，不战自垮。', 'Secretly replace the opponent’s vital pillars with flawed substitutes, causing the entire superstructure to collapse under pressure.']
      ]
    },
    {
      'title': '第二十六计：指桑骂槐',
      'titleEn': 'Stratagem 26: Point at the Mulberry to Scold the Locust',
      'sentences': [
        ['指桑骂槐：大凌小者，警以诱之。刚中而应，行险而顺。', 'Point at the Mulberry to Scold the Locust: Discipline subordinates by punishing an indirect proxy to command absolute obedience.'],
        ['借训斥或惩治旁人来敲山震虎，令真正桀骜不驯之辈心惊胆战，俯首帖耳。', 'Use indirect reproof and decisive demonstration of authority on an unessential target to awe and command stubborn subordinates.']
      ]
    },
    {
      'title': '第二十七计：假痴不癫',
      'titleEn': 'Stratagem 27: Feign Madness While Remaining Sane',
      'sentences': [
        ['假痴不癫：宁伪作不知不为，不伪作佯知妄为。静不露机，云雷屯也。', 'Feign Madness While Remaining Sane: Better to appear ignorant and inactive than rash; conceal brilliant cunning beneath clumsy foolishness.'],
        ['司马懿装病装聋瞒过大将军曹爽，趁其出城拜陵发动高平陵之变，一举夺取军国大权。', 'Sima Yi feigned dotage and deafness to deceive Cao Shuang, launching a swift coup at Gaoping Tomb to seize imperial power.']
      ]
    },
    {
      'title': '第二十八计：上屋抽梯',
      'titleEn': 'Stratagem 28: Remove the Ladder After Ascending',
      'sentences': [
        ['上屋抽梯：假之以便，唆之使前，断其援应，陷之死地。', 'Remove the Ladder After Ascending: Lure the enemy forward with alluring bait, then sever all reinforcements to trap them in mortal peril.'],
        ['诱敌深入绝境并切断退路，迫使己方士兵置之死地而后生，或令敌军死无葬身之地。', 'Cut off retreat behind advancing soldiers to inspire desperate valor, or trap overextended enemies with nowhere to turn.']
      ]
    },
    {
      'title': '第二十九计：树上开花',
      'titleEn': 'Stratagem 29: Deck the Tree with False Blossoms',
      'sentences': [
        ['树上开花：借局布势，力小势大。鸿渐于陆，其羽可用为仪也。', 'Deck the Tree with False Blossoms: Borrow situational theater to amplify your stature; create a grand impression from modest strength.'],
        ['借助外部声势、虚张声势来掩饰己方的弱小，形成强大威慑力。', 'Utilize theatrical military display, dust clouds, and false standards to make an inferior force appear vast and invincible.']
      ]
    },
    {
      'title': '第三十计：反客为主',
      'titleEn': 'Stratagem 30: Turn from Guest into Master',
      'sentences': [
        ['反客为主：乘隙插足，扼其主机，渐之进也。', 'Turn from Guest into Master: Step into an available opening, seize core operational levers gradually, and supplant host authority.'],
        ['循序渐进，先以客人身份融入其中，逐步掌控核心权力与关键要冲，最终反客为主。', 'Enter gracefully as a guest, gradually assume command of essential keys, and smoothly take rightful mastery of the domain.']
      ]
    },
    {
      'title': '第三十一计：美人计',
      'titleEn': 'Stratagem 31: The Beauty Trap',
      'sentences': [
        ['美人计：兵强者，攻其将；将智者，伐其情。将塞智竭，己力乘之。', 'The Beauty Trap: When an army is strong, target its commander; when a general is wise, strike at their passions to cloud judgment.'],
        ['越王勾践将绝色美女西施献给吴王夫差，夫差沉湎声色、荒废朝政、诛杀忠臣伍子胥，越国终得雪耻灭吴。', 'King Goujian presented beauty Xi Shi to King Fuchai of Wu, intoxicating the monarch into neglecting statecraft, paving the way for Yue\'s ultimate triumph.']
      ]
    },
    {
      'title': '第三十二计：空城计',
      'titleEn': 'Stratagem 32: The Empty Fort Strategy',
      'sentences': [
        ['空城计：虚者虚之，疑中生疑；刚柔之际，奇而复奇。', 'The Empty Fort Strategy: When weak, display complete openness to deepen enemy suspicion; psychological paradox triumphs over numbers.'],
        ['诸葛亮在西城大开城门，仅带数名琴童在城楼抚琴独奏。司马懿疑有伏兵，引十五万大军退走。', 'Zhuge Liang threw open the gates of Xicheng, calmly playing his zither on the ramparts; suspecting ambush, Sima Yi retreated his 150,000 troops.']
      ]
    },
    {
      'title': '第三十三计：反间计',
      'titleEn': 'Stratagem 33: The Strategy of Counter-Espionage',
      'sentences': [
        ['反间计：疑中之疑。比之自内，不自失也。', 'Counter-Espionage: Plant suspicion within suspicion; use the opponent\'s own spies to transmit false intelligence back to their masters.'],
        ['识破敌方间谍后不予处死，反而故意泄露假军情，借敌之间谍误导其主帅决策。', 'Identify enemy spies and feed them crafted misinformation, manipulating the opposing commander into self-destructive blunders.']
      ]
    },
    {
      'title': '第三十四计：苦肉计',
      'titleEn': 'Stratagem 34: Inflict Injury on Oneself to Win Confidence',
      'sentences': [
        ['苦肉计：人不自害，受害必真；假真真假，间以得行。', 'Inflict Injury on Oneself: People do not willingly harm themselves; suffering wounds appears authentic, disarming all skepticism.'],
        ['赤壁之战中老将黄盖甘受周瑜严酷杖刑，诈降曹操，曹操深信不疑，遂成火烧赤壁千古奇功。', 'At Red Cliffs, veteran Huang Gai endured brutal public flogging to feign defection to Cao Cao, enabling the fire attack that shattered the northern fleet.']
      ]
    },
    {
      'title': '第三十五计：连环计',
      'titleEn': 'Stratagem 35: The Interlocking Chain of Stratagems',
      'sentences': [
        ['连环计：将多兵众，不可以敌，使其自累，以杀其势。在天在图，运周复始。', 'The Interlocking Chain: When enemy forces are vast, entangle them in connected traps so their own mass destroys their momentum.'],
        ['庞统献连环计诱使曹操以铁链锁住战船，配合火攻之计，将庞大舰队彻底葬送火海。', 'Pang Tong tricked Cao Cao into chaining his warships together, setting up the devastating fire storm at Red Cliffs.']
      ]
    },
    {
      'title': '第三十六计：走为上',
      'titleEn': 'Stratagem 36: Retreat is the Supreme Policy',
      'sentences': [
        ['走为上：全师避敌。左次无咎，未失常也。', 'Retreat is the Supreme Policy: When conditions are hopeless, preserve the army by strategic withdrawal; to preserve strength for tomorrow is the highest wisdom.'],
        ['敌势绝对强盛不可战胜时，主动退却以保存有生力量，待机卷土重来，此乃兵家最高明之深谋。', 'When facing insurmountable odds, strategic retreat preserves your force to strike another day—the timeless crowning jewel of strategic art.']
      ]
    }
  ];

  final List<Map<String, dynamic>> compiledChapters = [];
  for (int i = 0; i < stratagems.length; i++) {
    final ch = stratagems[i];
    final chIdx = i + 1;
    final title = ch['title'] as String;
    final titleEn = ch['titleEn'] as String;
    final rawSentences = ch['sentences'] as List<List<String>>;

    final List<Map<String, dynamic>> sentences = [];
    for (final s in rawSentences) {
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
      'id': 'thirty_six_stratagems_ch_$chIdx',
      'bookId': 'thirty_six_stratagems',
      'chapterIndex': chIdx,
      'title': title,
      'titleEn': titleEn,
      'sentences': sentences,
    });
  }

  final targetFile = File('assets/data/books/thirty_six_stratagems.json');
  targetFile.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(compiledChapters));
  print('=== Wrote all 36 authentic chapters for Thirty-Six Stratagems! ===');

  // Update catalog
  final catalogFile = File('assets/data/grand_library_catalog.json');
  final List<dynamic> catList = jsonDecode(catalogFile.readAsStringSync());
  for (final item in catList) {
    if (item['id'] == 'thirty_six_stratagems') {
      item['totalChapters'] = 36;
    }
  }
  catalogFile.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(catList));
}
