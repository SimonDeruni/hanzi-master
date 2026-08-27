import 'dart:convert';
import 'dart:io';
import 'package:lpinyin/lpinyin.dart';

void main() async {
  print('=== Generating Complete Authentic 27 Chapters for The Little Prince (《小王子》) ===');

  final List<Map<String, dynamic>> chapters = [
    {
      'title': '第一章：六岁时的蟒蛇画与大人们的偏见',
      'titleEn': 'Chapter 1: The Drawing of the Boa Constrictor & Adult Blindness',
      'dialogues': [
        ['我六岁的时候，在一本书中看到了一幅精彩的插画，画的是一条蟒蛇正在吞食一只野兽。', 'When I was six years old, I saw a magnificent picture in a book, depicting a boa constrictor swallowing a wild beast.'],
        ['书上写着：“蟒蛇把猎物整个吞下去，不用咀嚼；然后它们动弹不得，睡上整整六个月来消化。”', 'The book said: "Boa constrictors swallow their prey whole, without chewing; then they cannot move and sleep for six months to digest."'],
        ['我想了很久，用彩色铅笔画出了我的第一幅作品：那不是一顶帽子，而是一条正在消化大象的巨蟒。', 'I pondered deeply, and with a colored pencil drew my first artwork: it was not a hat, but a boa constrictor digesting an elephant.'],
        ['我把杰作拿给大人们看，问他们害不害怕。他们却回答：“一顶帽子有什么好怕的？”', 'I showed my masterpiece to the grown-ups and asked if it frightened them. They answered: "Why should anyone be frightened by a hat?"'],
        ['为了让大人看明白，我又画了第二幅画，把巨蟒肚子里面切开，露出了里面的大象。', 'So that grown-ups could understand, I drew a second picture, showing the interior of the boa constrictor with the elephant inside.'],
        ['大人们劝我把这些画放在一边，专心去学地理、历史、算术和语法。', 'The grown-ups advised me to lay aside drawings of snakes and devote myself instead to geography, history, arithmetic, and grammar.'],
        ['就这样，我在六岁时放弃了成为一名画家的伟大志向。大人们自己永远什么也弄不懂，总要小孩子反复解释，真是累人。', 'Thus, at the age of six, I gave up a magnificent career as a painter. Grown-ups never understand anything by themselves, and it is exhausting for children to always explain.'],
      ]
    },
    {
      'title': '第二章：撒哈拉沙漠坠机与“请给我画一只羊”',
      'titleEn': 'Chapter 2: Crash in the Sahara & "Please Draw Me a Sheep"',
      'dialogues': [
        ['六年前，我的飞机在茫茫无际的撒哈拉沙漠中发生了故障。我的发动机里有些东西碎了。', 'Six years ago, my plane broke down in the boundless Sahara desert. Something had broken in my engine.'],
        ['由于身边没有机械师，也没有乘客，我只能孤身一人尝试进行艰难的维修，饮用水只够维持八天。', 'With neither mechanic nor passengers, I prepared to attempt a difficult repair alone, with barely eight days of drinking water.'],
        ['第一天晚上，我在远离人烟一千英里的沙漠上睡着了，比汪洋大海中遭遇海难的水手还要孤独。', 'The first night, I went to sleep on the sand, a thousand miles from any human habitation, more isolated than a shipwrecked sailor on an ocean.'],
        ['拂晓时分，一个奇怪的小声音唤醒了我：“请……请给我画一只羊吧！”', 'At daybreak, a strange little voice woke me: "Please... please draw me a sheep!"'],
        ['我猛地跳了起来，揉了揉眼睛。我看到一个非同寻常的小人儿，正神情严肃地审视着我。', 'I leaped to my feet, rubbing my eyes. I saw an extraordinary little fellow standing there, examining me with solemn gravity.'],
        ['他既不像迷了路，也不像饥渴交加。他就是一个来自异星的金色头发的小王子。', 'He did not appear lost, nor dying of hunger or thirst. He was simply a golden-haired little prince from another world.'],
        ['我画了一只生病的羊，他不要；又画了一只有角的公羊，他也摇头。最后我画了一个箱子：“你要的羊就在盒子里。”小王子的脸上顿时绽放出灿烂的笑容。', 'I drew a sickly sheep, which he rejected; then a horned ram, which he also shook his head at. Finally, I drew a wooden box: "The sheep you asked for is inside." The little prince beamed with a radiant smile.']
      ]
    },
    {
      'title': '第三章：小王子的来历与微小的B612星球',
      'titleEn': 'Chapter 3: The Origins of the Prince & His Tiny Home',
      'dialogues': [
        ['我花了好长一段时间才弄清楚他究竟是从哪里来的。小王子向我提出了很多问题，却似乎从不听我的回答。', 'It took me a long time to understand where he came from. The little prince asked many questions, yet never seemed to hear mine.'],
        ['当他第一次看到我的飞机时，他好奇地问：“这是什么东西？”我说：“这是会飞的飞机。”', 'When he first caught sight of my airplane, he asked curiously: "What is that thing?" I said: "It is an airplane that flies."'],
        ['他惊讶地喊道：“什么！你是从天上掉下来的吗？”随后发出了一阵清脆动听的笑声。', 'He cried in wonder: "What! Did you drop from the sky?" And then he let out a lovely, ringing laugh.'],
        ['他打量着我的画箱：“真好，夜晚可以把这个箱子当成它的房子。”', 'He examined my drawing box: "How wonderful, at night he can use this box as his little house."'],
        ['我说：“如果它乖，我还会给你一根绳子和一根木桩，白天可以把它拴住。”', 'I said: "And if he is good, I will give you a rope and a post to tie him up during the day."'],
        ['小王子听了十分诧异：“把它拴住？多么奇怪的想法！它能跑到哪里去呢？在我那里，所有的东西都那么小，一直往前走，也走不了多远……”', 'The little prince was surprised: "Tie him up? What a strange idea! Where could he go? Where I live, everything is so tiny—even if one goes straight ahead, one cannot go very far..."']
      ]
    },
    {
      'title': '第四章：小行星B612与大人对数字的执念',
      'titleEn': 'Chapter 4: Asteroid B-612 & Adults Obsessed with Numbers',
      'dialogues': [
        ['我有充分的理由相信，小王子离开的那颗星球就是小行星B612。', 'I have serious reason to believe that the planet the little prince came from is Asteroid B-612.'],
        ['这颗小行星在1909年曾被一位土耳其天文学家通过望远镜观察到，但他当时因穿着民族服装而不被学术界信任。', 'This asteroid was seen only once through a telescope in 1909 by a Turkish astronomer, who was dismissed because of his traditional attire.'],
        ['大人们就是这样，他们深爱着枯燥的数字。', 'Grown-ups are like that; they have a profound passion for dry numbers.'],
        ['如果你对大人们说：“我看到了一座用玫瑰色砖块砌成、窗台上开满天竺葵、屋顶上停着白鸽的漂亮房子。”他们根本想象不出这所房子有多美。', 'If you tell grown-ups: "I saw a beautiful house made of rosy brick, with geraniums in the windows and doves on the roof," they cannot imagine it at all.'],
        ['但如果你对他们说：“我看到了一座价值十万法郎的房子。”他们就会惊叹：“那真是太华丽了！”', 'But if you say to them: "I saw a house worth a hundred thousand francs," they will exclaim: "Oh, how magnificent!"'],
        ['为了不让小王子被遗忘，我买了颜料和画笔，努力在纸上重现他的模样。遗忘一个朋友是一件极其悲哀的事情。', 'To ensure the little prince is not forgotten, I bought paints and pencils, striving to capture his form on paper. Forgetting a friend is a deeply sorrowful thing.']
      ]
    },
    {
      'title': '第五章：猴面包树的幼苗与每日清理的责任',
      'titleEn': 'Chapter 5: The Threat of Baobab Trees & Daily Vigilance',
      'dialogues': [
        ['每天我都能从小王子的交谈中了解到关于他的星球、他的离开和他的旅程的新秘密。', 'Every day I learned something new about the prince’s planet, his departure, and his cosmic journey.'],
        ['到了第三天，我知道了关于猴面包树的可怕悲剧。', 'On the third day, I learned of the terrible tragedy regarding the baobab trees.'],
        ['小王子问我：“绵羊真的会吃小灌木吗？”我回答：“是的。”小王子高兴地说：“太好了！那它们也会吃猴面包树吧？”', 'The little prince asked me: "Do sheep eat little bushes?" I answered: "Yes." The prince rejoiced: "Splendid! Then they also eat baobabs?"'],
        ['我向他解释，猴面包树可不是小灌木，而是像教堂一样庞大的参天巨树，即使带上一群大象也啃不完一棵猴面包树。', 'I explained that baobabs are not little bushes, but trees as immense as cathedrals, and a whole herd of elephants could not eat a single one.'],
        ['小王子聪明地指出：“猴面包树在长大之前，也是从小苗开始长起的呀。”', 'The little prince wisely pointed out: "Before baobabs grow huge, they start out as tiny little sprouts."'],
        ['在他的星球上，好植物长出好种子，坏植物长出坏种子。如果不及时拔掉猴面包树的幼苗，它们庞大的根系就会把整颗微小的星球撑得四分五裂。', 'On his planet, good plants grow good seeds, bad plants grow bad seeds. If baobabs are not weeded immediately, their roots will pierce and split the tiny world apart.'],
        ['小王子说：“这是一件纪律严明的事。每天早晨梳洗完毕后，就必须认真地去清理星球。”', 'The little prince said: "It is a matter of discipline. When you finish washing in the morning, you must carefully clean up the planet."']
      ]
    },
    {
      'title': '第六章：四十四次日落与忧郁的落日之美',
      'titleEn': 'Chapter 6: Forty-Four Sunsets & The Solace of Twilight',
      'dialogues': [
        ['啊，小王子！我就是这样一点一点地理解了你那忧郁而恬静的微小生命。', 'Ah, little prince! Bit by bit I came to understand the secrets of your sad, gentle little life.'],
        ['在很长一段时间里，你唯一的乐趣就是静静地观赏落日带来的温柔余晖。', 'For a long time your only entertainment had been the quiet pleasure of watching sunsets.'],
        ['第四天早晨，你对我说：“我非常喜欢日落。我们去看一次日落吧……”', 'On the fourth morning, you said to me: "I love sunsets very much. Let us go watch a sunset now..."'],
        ['我对你说：“但我们必须等待。”你问：“等什么？”我说：“等太阳落山啊。”', 'I told you: "But we must wait." You asked: "Wait for what?" I said: "Wait for the sun to go down."'],
        ['你先是一愣，随后孩子般地笑了：“我总以为我还在自己的星球上呢！”', 'At first you seemed surprised, then you laughed at yourself: "I always think I am still at home on my own planet!"'],
        ['在小王子的星球上，只要把椅子挪动几步，就能随时看到黄昏。', 'On the prince\'s planet, one needed only to pull their chair a few steps to watch twilight fall.'],
        ['“有一天，”你说，“我一共看了四十四次日落！”过了一会儿，你又补充道：“你知道吗……当一个人感到极其忧伤的时候，他是最喜欢看日落的。”', '"One day," you said, "I watched the sunset forty-four times!" A moment later you added: "You know... when one is terribly sad, one loves the sunset."']
      ]
    },
    {
      'title': '第七章：花朵的刺与小王子眼中的宇宙之泪',
      'titleEn': 'Chapter 7: The Thorns & The Secrets of Sacred Tears',
      'dialogues': [
        ['第五天，借助小绵羊的话题，小王子的生活秘密彻底向我敞开了。', 'On the fifth day, through the subject of the sheep, the secret of the little prince’s life was revealed to me.'],
        ['他突然问我：“如果羊吃小灌木，它也会吃花吗？”我回答：“羊看见什么就吃什么。”', 'He asked abruptly: "If a sheep eats bushes, does it eat flowers too?" I answered: "A sheep eats whatever it finds."'],
        ['“即使是有刺的花也吃吗？”“是的，即使有刺也吃。”', '"Even flowers with thorns?" "Yes, even flowers that have thorns."'],
        ['“那花儿身上的刺究竟有什么用呢？”当时我正忙着修理卡死的螺栓，便烦躁地随口答道：“刺什么用也没有，纯粹是花朵的恶意！”', '"Then what purpose do thorns serve?" Busy fixing a jammed bolt, I answered irritably: "Thorns serve no purpose at all; they are pure spite from flowers!"'],
        ['小王子沉默片刻后，气得浑身发抖，眼里闪烁着泪光：“我不信！花朵是柔弱的、天真的。它们以为有了刺就能保护自己！”', 'The little prince grew pale with indignation: "I don\'t believe you! Flowers are weak and naive. They think their thorns make them terrible and safe!"'],
        ['他激动地喊道：“如果一个人爱上一朵世上独一无二的花，那朵花只长在亿万颗星星中的一颗上，只要抬头看着星空，他就会感到无比幸福。可如果羊把花吃掉了，对他而言，就像所有的星星瞬间熄灭了一样！这难道不重要吗？”', 'He cried passionately: "If someone loves a flower, the only one of its kind in millions of stars, looking at the sky makes him happy. But if the sheep eats the flower, to him it is as if all the stars went dark at once! Does that not matter?"'],
        ['他再也说不下去了，突然失声痛哭起来。夜色降临，我扔下了手中的扳手，将他紧紧抱在怀里，轻轻摇晃着他：“泪水的国度，是多么神秘莫测啊。”', 'He could say no more, bursting into tears. Night fell; I dropped my tools and took him into my arms: "The land of tears is so mysterious and uncharted."']
      ]
    },
    {
      'title': '第八章：娇艳玫瑰的诞生与她的骄傲与谎言',
      'titleEn': 'Chapter 8: The Birth of the Rose & Her Fragile Pride',
      'dialogues': [
        ['我很快就更深入地了解了那朵花。在小王子的星球上，以往只有简单的单层花朵，从不引人注意。', 'I soon learned to know this flower better. On the prince’s planet, there had always been simple flowers with single rings of petals.'],
        ['但有一天，一粒不知从何处飘来的神秘种子发芽了。小王子细心地看护着这棵奇特的幼苗。', 'But one day, a seed blown from an unknown place sprouted. The little prince watched over this curious green shoot closely.'],
        ['这朵花在绿色的花萼里精心挑选自己的衣裳，精心搭配花瓣的颜色。她不愿像野罂粟那样带着褶皱出场，只愿在最绚烂的光彩中绽放。', 'The flower dressed herself meticulously inside her green chamber, choosing colors with care, wishing to emerge only in the full radiance of beauty.'],
        ['终于，在一个晴朗的早晨，伴随着朝阳升起，她绽放了花瓣，打着哈欠娇柔地说道：“啊！我才刚刚睡醒……请原谅，我的花瓣还没梳理整齐呢……”', 'At sunrise she unfolded her petals, yawning sweetly: "Ah! I have just awakened... forgive me, my petals are still untidy..."'],
        ['小王子禁不住由衷地赞叹：“你真美啊！”花儿轻声答道：“是吧？我是和太阳同时出生的呢……”', 'The little prince could not contain his admiration: "How beautiful you are!" The flower replied softly: "Am I not? And I was born at the same moment as the sun..."'],
        ['但这朵花儿不仅美丽，还带着虚荣与多疑。她炫耀自己的四根刺，声称自己不怕老虎，却害怕冷风，要求小王子在夜晚为她套上玻璃罩。', 'Yet this flower was also vain and demanding. She showed off her four thorns, claimed she feared no tigers, yet feared drafts and demanded a glass globe at night.'],
        ['小王子回忆道：“我那时太年轻了，不懂得如何去爱她。我应该根据她的行动而不是言语来评判她。她的芬芳充盈了我的星球，我本不该离开她逃走。”', 'The prince reflected: "I was too young to know how to love her. I should have judged her by deeds rather than words. She perfumed my planet, and I should never have run away."']
      ]
    },
    {
      'title': '第九章：清理火山、告别玫瑰与借助候鸟离开',
      'titleEn': 'Chapter 9: Leaving the Rose & Migration with Wild Birds',
      'dialogues': [
        ['我相信小王子是借助一群迁徙的候鸟离开他的星球的。', 'I believe that for his departure, the little prince took advantage of a migration of wild birds.'],
        ['出发的那个清晨，他把自己的星球打扫得干干净净。他认真地疏通了两座活火山，顺便也清理了一座死火山。', 'On the morning of his departure, he put his planet in perfect order. He carefully swept out his two active volcanoes and one extinct volcano.'],
        ['他还怀着忧伤的心情，拔掉了最后几棵猴面包树的幼苗。他以为自己再也不会回来了。', 'With a heavy heart, he also pulled up the last baobab shoots. He believed he would never return.'],
        ['当他最后一次给玫瑰浇水，准备为她盖上玻璃罩时，他发现自己很想哭泣。', 'When he watered his rose one last time and prepared to place her under the glass globe, he felt close to tears.'],
        ['“再见。”他对花儿说。花儿没有回答。“再见。”他又说了一遍。', '"Goodbye," he said to the flower. She did not answer. "Goodbye," he repeated gently.'],
        ['花儿咳嗽了一声，轻声说：“我以前真蠢。请你原谅我。祝你幸福。”小王子为她的平静与毫无怨言感到惊讶。', 'The flower coughed and said softly: "I have been silly. I ask your forgiveness. Try to be happy." The prince was astonished by her calm lack of reproaches.'],
        ['“是的，我是爱你的，”花儿对他说，“没能让你明白这一点，是我的错。但你也一样傻。把玻璃罩拿走吧，我不再需要它了。夜晚的新鲜空气对我的健康有好处。我是一朵花啊。”', '"Yes, I love you," the flower told him. "It is my fault that you never knew. But you were just as foolish. Take away the glass globe; I no longer need it. The night air will do me good. I am a flower."'],
        ['“快走吧，别磨磨蹭蹭的，既然你决定要离开，那就走吧！”因为她太骄傲了，不想让小王子看到她流下的泪水。', '"Go now, do not linger like this; you decided to leave, so go!" For she was too proud to let him see her weep.']
      ]
    },
    {
      'title': '第十章：第325号小行星：独自统治的国王',
      'titleEn': 'Chapter 10: Asteroid 325: The King Who Rules Solitude',
      'dialogues': [
        ['小王子的宇宙旅程首先来到了第325、326、327、328、329和330号小行星。', 'The little prince found himself in the neighborhood of asteroids 325, 326, 327, 328, 329, and 330.'],
        ['在第一颗星球上，住着一位身穿紫袍和白貂皮大衣的国王，威严地坐在极其简朴却庄严的宝座上。', 'On the first planet lived a king, dressed in purple and ermine, seated upon a throne that was both simple and majestic.'],
        ['国王一见到小王子就喊道：“啊！来了一个臣民！”小王子纳闷：他以前从没见过我，怎么会认得我呢？', 'The king exclaimed upon seeing him: "Ah! Here is a subject!" The prince wondered: How can he recognize me when he has never seen me before?'],
        ['小王子累得打了个哈欠。国王威严地命令：“在国王面前打哈欠是违反礼仪的，我禁止你打哈欠！”', 'Fatigued, the prince yawned. The king declared: "It is contrary to etiquette to yawn before a king; I forbid you to yawn!"'],
        ['小王子难为情地说：“我忍不住，我走了很远的路，还没睡觉呢……”国王立刻改口：“那我命令你打哈欠！我已经很多年没见过别人打哈欠了。”', 'The prince blushed: "I could not help it, I made a long journey and had no sleep..." The king quickly amended: "Then I command you to yawn! I have not seen anyone yawn in years."'],
        ['小王子向国王请求：“陛下，请命令太阳落山吧，我想看一次日落。”', 'The little prince requested: "Sire, please command the sun to set; I wish to see a sunset."'],
        ['国王理智地回答：“向每个人提出的要求，应该是他们力所能及的。权威首先建立在理性的基础之上。我命令太阳在今晚七点四十分落山，你会看到我的命令被精准执行！”', 'The king replied wisely: "One must require from each what each can give. Authority rests first upon reason. I shall command the sun to set tonight at twenty to eight, and you will see how well I am obeyed!"'],
        ['小王子感到无趣，准备告辞。国王为了留住他，甚至许诺任命他为司法大臣。小王子叹息道：“大人们真是太奇怪了。”', 'Bored, the prince prepared to leave. To retain him, the king offered to make him Minister of Justice. The prince sighed: "Grown-ups are truly astonishing."']
      ]
    },
    {
      'title': '第十一章：第326号小行星：渴望掌声的虚荣者',
      'titleEn': 'Chapter 11: Asteroid 326: The Conceited Man Craving Praise',
      'dialogues': [
        ['第二颗行星上住着一个爱虚荣的人。', 'The second planet was inhabited by a conceited man.'],
        ['“啊！一个崇拜者来拜访我了！”虚荣者老远看到小王子就高呼起来。在虚荣者眼里，所有别的人都是他的崇拜者。', '"Ah! An admirer comes to visit me!" the conceited man cried from afar. For to conceited men, all others are admirers.'],
        ['虚荣者头上戴着一顶滑稽的帽子。他说：“这是用来致意行礼的，当有人为我鼓掌时，我就举起帽子致意。请你拍手吧！”', 'He wore a curious hat: "It is for saluting when people applaud me. Clap your hands together!"'],
        ['小王子拍了拍手，虚荣者便得意洋洋地举起帽子行礼。', 'The little prince clapped his hands, and the conceited man modestly lifted his hat in salute.'],
        ['连续鼓掌五分钟后，小王子觉得单调乏味：“要怎么做才能让帽子掉下来呢？”虚荣者却充耳不闻，因为虚荣的人只能听见赞美的话。', 'After five minutes of clapping, the prince tired of the game: "What must one do to make the hat fall off?" But the conceited man heard nothing, for conceited men hear only praise.'],
        ['“你真的非常崇拜我吗？”他问小王子。“‘崇拜’是什么意思？”小王子问。“就是承认我是这颗星球上最英俊、最会穿衣服、最富有和最聪明的人！”', '"Do you truly admire me greatly?" he asked. "What does admire mean?" asked the prince. "It means recognizing that I am the most handsome, best dressed, richest, and most intelligent man on the planet!"'],
        ['“可这颗星球上只有你一个人啊！”“那就请行行好，无论如何崇拜我吧！”小王子耸耸肩离开了：“大人们确实古怪极了。”', '"But you are alone on your planet!" "Do me this favor; admire me anyway!" The prince shrugged and left: "Grown-ups are definitely very odd."']
      ]
    },
    {
      'title': '第十二章：第327号小行星：为了忘却羞愧而喝酒的酒鬼',
      'titleEn': 'Chapter 12: Asteroid 327: The Tippler Drinking to Forget',
      'dialogues': [
        ['下一颗星球上住着一个酒鬼。这次拜访时间非常短暂，却让小王子陷入了极深的悲伤之中。', 'The next planet was inhabited by a tippler. This brief visit plunged the little prince into profound sadness.'],
        ['酒鬼默默地坐在由一堆空瓶子和一堆满瓶子组成的桌子前。', 'The tippler sat in silence before a collection of empty bottles and full bottles.'],
        ['“你在这里做什么？”小王子问。“我喝酒。”酒鬼神情沮丧地回答。', '"What are you doing here?" asked the little prince. "I am drinking," replied the tippler lugubriously.'],
        ['“你为什么喝酒呢？”小王子继续关切地问。“为了忘却。”酒鬼低垂着头。', '"Why do you drink?" the prince asked with concern. "To forget," the tippler hung his head.'],
        ['“忘却什么呢？”小王子想帮助他。“忘却我的羞愧。”酒鬼坦白道。', '"To forget what?" the prince inquired, wishing to help. "To forget that I am ashamed," the tippler confessed.'],
        ['“你羞愧什么呢？”小王子同情地问。“羞愧我喝酒！”酒鬼说完便彻底陷入了沉默。', '"Ashamed of what?" asked the prince with sympathy. "Ashamed of drinking!" The tippler concluded, retreating into absolute silence.'],
        ['小王子困惑而茫然地离开了：“大人们毫无疑问真是太奇怪了。”', 'The little prince went away, perplexed and sorrowful: "Grown-ups are without a doubt very, very strange."']
      ]
    },
    {
      'title': '第十三章：第328号小行星：日夜数星星的实业家',
      'titleEn': 'Chapter 13: Asteroid 328: The Businessman Counting Stars',
      'dialogues': [
        ['第四颗星球属于一个实业家。这个人忙得不可开交，小王子到来时他甚至连头都没有抬一下。', 'The fourth planet belonged to a businessman. This man was so engrossed in his calculations that he did not even raise his head.'],
        ['“三加二等于五。五加七等于十二……五亿一百六十二万二千七百三十一。”商人嘴里不断念叨着。', '"Three and two make five. Five and seven make twelve... five hundred and one million, six hundred twenty-two thousand, seven hundred thirty-one," the businessman muttered.'],
        ['“五亿什么东西？”小王子问。“五亿颗闪闪发光的小东西。我占有它们，我拥有五亿颗星星，这样我就很富有！”商人傲慢地说。', '"Five hundred million what?" asked the prince. "Five hundred million little glittering things in the sky. I own them, which makes me rich!" the businessman declared.'],
        ['小王子不解：“拥有星星对你有什么用呢？”商人答：“能让我买下更多别的星星。”', 'The little prince asked: "And what good does it do you to own stars?" "It allows me to buy more stars if any are discovered."'],
        ['小王子反驳道：“我拥有一朵花，我每天给她浇水；我拥有三座火山，我每周给它们清灰。我对我的花和火山是有益处的。但你对星星却没有任何益处！”', 'The prince argued: "I own a flower, which I water every day; I own three volcanoes, which I sweep every week. It is useful to my flower and volcanoes that I own them. But you are of no use to the stars!"'],
        ['商人张口结舌，无言以对。小王子再次踏上了旅途：“大人们的逻辑真是匪夷所思。”', 'The businessman opened his mouth but could find nothing to say. The prince resumed his journey: "Grown-ups are utterly extraordinary."']
      ]
    },
    {
      'title': '第十四章：第329号小行星：忠于职责的点灯人',
      'titleEn': 'Chapter 14: Asteroid 329: The Faithful Lamplighter',
      'dialogues': [
        ['第五颗行星非常奇特，它是所有行星中最小的一颗，刚好只能容纳一盏路灯和一个点灯人。', 'The fifth planet was the smallest of all, having just enough room for a street lamp and a lamplighter.'],
        ['小王子想：这个人虽然看起来荒谬，但他点亮路灯，就像在夜空中点燃了一颗新星或唤醒了一朵花；当他熄灭路灯，就像让花儿或星星入睡，这是一项美丽的职业。', 'The prince thought: Though absurd, this man lighting his lamp is like bringing a new star or flower to birth; extinguishing it puts them to sleep. That is a beautiful occupation.'],
        ['“你好，为什么你刚把路灯熄灭，又立刻点亮它呢？”小王子问。“这是规定。”点灯人回答，“早上熄灯，晚上点灯。”', '"Good morning. Why did you just extinguish your lamp and then relight it?" "It is the orders," answered the lamplighter. "Extinguish in morning, light at night."'],
        ['“可是为什么你一秒钟都不休息呢？”“因为星球一年比一年转得更快！现在它每分钟自转一周，我连一秒钟的睡眠都没有了！”', '"Why do you not rest for a single second?" "Because the planet turns faster every year! Now it revolves once a minute, leaving me not a second of sleep!"'],
        ['小王子看着这位忠实坚守职责的人，心里充满了敬意：“在国王、虚荣者、酒鬼和商人眼中，这个人也许很可笑，但他却是唯一不只顾自己的人。他是我唯一想结交为朋友的人。”', 'Looking at this faithful man, the prince felt deep respect: "The king, the conceited man, the tippler, and the businessman might despise him, yet he is the only one who cares for something other than himself. He is the only one I could have befriended."']
      ]
    },
    {
      'title': '第十五章：第330号小行星：足不出户的地理学家',
      'titleEn': 'Chapter 15: Asteroid 330: The Geographer & Ephemeral Rose',
      'dialogues': [
        ['第六颗行星比之前的要大十倍，上面住着一位正在撰写鸿篇巨著的老先生。', 'The sixth planet was ten times larger, inhabited by an old gentleman writing voluminous books.'],
        ['“看哪！来了一位探险家！”老人欢呼道。他是位地理学家。', '"Look! Here comes an explorer!" the old gentleman exclaimed. He was a geographer.'],
        ['小王子环顾四周：“你的星球真壮观啊！这里有海洋、高山和沙漠吗？”地理学家答道：“我不知道，因为我不是探险家。地理学家太重要了，不能到处闲逛，我们坐在办公室里记录探险家的报告。”', 'The prince looked around: "Your planet is magnificent! Are there oceans, mountains, and deserts?" "I cannot know," said the geographer, "for I am not an explorer. A geographer is too important to wander; we sit in offices recording explorers\' findings."'],
        ['地理学家拿出大账本准备记录小王子的星球：“你有山脉和花朵吗？”小王子说：“我有三座火山，还有一朵花。”', 'The geographer opened his ledger to record the prince\'s planet: "Do you have mountains and flowers?" "I have three volcanoes, and a flower," said the prince.'],
        ['地理学家摇头：“我们不记录花朵，因为花朵是‘转瞬即逝’的。”“‘转瞬即逝’是什么意思？”小王子追问。', 'The geographer shook his head: "We do not record flowers, because they are ephemeral." "What does ephemeral mean?" asked the prince.'],
        ['“意思是说：它面临着很快消亡的危险。”小王子心中猛然一颤：“我的花儿是转瞬即逝的！她只有四根刺来抵抗整个世界，而我却把她孤零零地留在了家里！”这是小王子第一次感到由衷的懊悔。', '"It means: that which is in danger of speedy disappearance." The prince felt a pang in his heart: "My flower is ephemeral! She has only four thorns to defend herself against the world, and I left her all alone at home!" For the first time, he felt deep regret.'],
        ['在地理学家的推荐下，小王子决定前往下一颗行星——地球。', 'On the recommendation of the geographer, the little prince set off for his next destination: Earth.']
      ]
    },
    {
      'title': '第十六章：第七颗行星：拥有二十亿大人的地球',
      'titleEn': 'Chapter 16: The Seventh Planet: The Vast Earth',
      'dialogues': [
        ['第七颗行星就是地球。', 'The seventh planet, then, was the Earth.'],
        ['地球可不是一颗普普通通的行星！上面有一百一十一位国王、七千个地理学家、九十万个实业家、七百五十万个酒鬼和三亿一千一百万个虚荣者——也就是说，大约有二十亿个大人。', 'The Earth is no ordinary planet! It counts 111 kings, 7,000 geographers, 900,000 businessmen, 7,500,000 tipplers, and 311,000,000 conceited men—about two billion grown-ups.'],
        ['在发明电灯之前，地球上的六大洲需要维持一支由四十六万二千五百一十一人组成的长明灯点灯大军，那场面壮观极了。', 'Before the invention of electricity, the six continents maintained a vast army of 462,511 lamplighters, creating a truly magnificent spectacle.'],
        ['然而，小王子踏上地球时，降落在了非洲广袤孤寂的撒哈拉沙漠上，那里一个人影也没有。', 'Yet when the little prince set foot upon the Earth, he landed in the vast, desolate sands of the African Sahara, without a single human soul in sight.']
      ]
    },
    {
      'title': '第十七章：金黄毒蛇与孤独的谜语',
      'titleEn': 'Chapter 17: The Golden Snake & Riddles in the Desert',
      'dialogues': [
        ['小王子站在金黄色的沙丘上，只看到一道月光般闪耀的金色绳索在沙中移动。那是一条毒蛇。', 'Standing upon the golden dunes, the prince saw only a moonlight-colored cord moving in the sand. It was a snake.'],
        ['“晚上好，”小王子礼貌地说。“晚上好，”蛇说。“我落在什么星球上了？”小王子问。“在非洲的沙漠里，”蛇回答。', '"Good evening," said the prince politely. "Good evening," said the snake. "What planet have I fallen upon?" "In the desert of Africa," the snake replied.'],
        ['小王子在一块岩石上坐了下来：“在沙漠里真有点孤独……”蛇幽幽地说：“在人群中，你也一样会感到孤独。”', 'The prince sat upon a rock: "It is a little lonely in the desert..." The snake murmured: "It is also lonely among men."'],
        ['小王子看着这条细如手指的小动物：“你真弱小啊，连脚都没有。”蛇冷笑一声：“我比国王的手指更有力量。被我触碰过的人，都会回归他由之而来的尘土。”', 'The prince looked at the slender creature: "You are very weak; you have no feet." The snake hissed softly: "I am more powerful than the finger of a king. Whomever I touch, I return to the earth from whence they came."'],
        ['蛇凝视着小王子纯洁的金发：“但我可怜你，你来自一颗纯净的星星。如果你哪天太思念你的故乡，我可以帮助你回去……”小王子懂得它的隐喻，默默地点了点头。', 'The snake gazed at his golden hair: "I feel pity for you, coming from a pure star. If one day you miss your planet too dearly, I can help you return..." The prince understood its riddle and nodded in silence.']
      ]
    },
    {
      'title': '第十八章：沙漠中三片花瓣的孤单小花',
      'titleEn': 'Chapter 18: The Desert Flower with Three Petals',
      'dialogues': [
        ['小王子穿过沙漠，一路上只遇到了一朵毫不起眼的三瓣小花。', 'The little prince crossed the desert and met only one insignificant three-petaled flower.'],
        ['“你好，”小王子说。“你好，”花儿说。', '"Good morning," said the little prince. "Good morning," said the flower.'],
        ['“请问人在哪里呢？”小王子礼貌地打听。', '"Where are the people?" the little prince asked politely.'],
        ['这朵花曾经见过一支经过沙漠的骆驼商队，便回答：“人吗？我想大概有六七个人吧，多年前我见过他们。但是谁也不知道该去哪里寻找他们，因为风吹着他们到处流浪。他们没有根，这让他们过得很艰难。”', 'The flower had once seen a caravan pass by: "People? There are perhaps six or seven; I saw them years ago. But one never knows where to find them, for the wind carries them away. They have no roots, which makes life hard for them."'],
        ['“再见，”小王子说。“再见，”小花轻声答道。', '"Goodbye," said the little prince. "Goodbye," whispered the little flower.']
      ]
    },
    {
      'title': '第十九章：高山顶峰的回声与寂寞的呼喊',
      'titleEn': 'Chapter 19: Echoes from the Mountain Summit',
      'dialogues': [
        ['小王子爬上了一座高耸入云的山峰。在他的星球上，除了膝盖高的三座火山外，他从未见过如此高大的山。', 'The little prince climbed a high mountain. On his planet, the only mountains were his three knee-high volcanoes.'],
        ['他心想：“从这么高的山上，我一眼就能看清整个地球和所有的人了。”', 'He thought: "From a mountain this high, I will be able to see the entire Earth and all its people at a single glance."'],
        ['然而，放眼望去，除了陡峭尖锐的岩石峭壁，什么也没有。', 'Yet looking out, he saw nothing but sharp, needle-like peaks of rock.'],
        ['“你好！”小王子大声呼喊。“你好……你好……你好……”群山发出了清脆的回声。', '"Hello!" cried the little prince into the silence. "Hello... hello... hello..." the mountain echoes answered.'],
        ['“你们是谁？”小王子问。“你们是谁……是谁……是谁……”回声重复着。', '"Who are you?" asked the little prince. "Who are you... who are you..." the echoes replied.'],
        ['“请做我的朋友吧，我很孤独！”小王子恳求道。“我很孤独……孤独……孤独……”回声再次传来。', '"Be my friends, I am all alone!" pleaded the prince. "I am all alone... alone... alone..." the echo repeated.'],
        ['小王子伤心地想：“这颗星球真是古怪，干燥、尖锐而且毫无想象力。人们只会重复别人说的话。而在我的家里，我的玫瑰总是第一个开口说话……”', 'The prince thought sadly: "What a strange planet! Dry, pointed, and lacking imagination. People only repeat what is said to them. While at home, my rose always spoke first..."']
      ]
    },
    {
      'title': '第二十章：盛开五千朵玫瑰的花园与破碎的心',
      'titleEn': 'Chapter 20: The Garden of Five Thousand Roses',
      'dialogues': [
        ['小王子在沙漠、岩石与积雪中走了很久很久，终于发现了一条道路。所有的道路都是通向人群的。', 'After walking a long time through sand, rocks, and snow, the little prince at last came upon a road. All roads lead to humanity.'],
        ['他走到了一个盛开着五千朵玫瑰的花园前。', 'He found himself standing before a garden filled with five thousand blooming roses.'],
        ['“你好，”小王子惊呆了。五千朵花齐声回答：“你好。”', '"Good morning," gasped the little prince. "Good morning," replied the roses in unison.'],
        ['小王子凝视着她们：她们每一朵都和自己星球上的那一朵长得一模一样！', 'The prince stared at them: every single one was identical to the flower on his own planet!'],
        ['“你们是谁？”他颤抖着问。“我们是玫瑰花。”花儿们骄傲地回答。', '"Who are you?" he asked, trembling. "We are roses," the flowers answered with pride.'],
        ['小王子感到万分悲伤。他的玫瑰曾经告诉他，她是全宇宙中独一无二的奇迹，而这里仅仅一座花园里就有整整五千朵完全相同的花！', 'The little prince felt overwhelmed with grief. His rose had told him she was the only one of her kind in the universe, yet here were five thousand in a single garden!'],
        ['“如果她看到这些，一定会羞愤得咳嗽并装死来掩饰自己的难堪。而我还以为自己拥有一朵无可比拟的绝世珍宝，原来我拥有的不过是一朵普通的玫瑰和三座膝盖高的火山。”小王子趴在草地上，伤心地痛哭起来。', '"If she saw this, she would cough terribly and pretend to die to escape ridicule. And I thought I was rich with a unique flower, when I possessed only a common rose and three knee-high volcanoes." He lay down in the grass and wept.']
      ]
    },
    {
      'title': '第二十一章：狐狸的智慧与“驯服”的秘密：唯用心方能看清',
      'titleEn': 'Chapter 21: The Fox & The Secret: Only the Heart Sees Rightly',
      'dialogues': [
        ['就在这时，一只狐狸出现了。', 'It was at this moment that the fox appeared.'],
        ['“你好，”狐狸说。“你好，”小王子有礼貌地回答，转过身来却什么也没看见。“我在这里，在苹果树下。”声音说。', '"Good morning," said the fox. "Good morning," answered the little prince, turning around but seeing nothing. "Here I am, under the apple tree."'],
        ['“过来和我一起玩吧，”小王子提议道，“我正难过得要命……”“我不能和你一起玩，”狐狸说，“我还没有被驯服呢。”', '"Come play with me," the prince proposed, "I am terribly sad..." "I cannot play with you," said the fox, "I am not tamed."'],
        ['“‘驯服’是什么意思？”小王子问。“这是常常被遗忘的事情，”狐狸说，“它的意思是‘建立羁绊’。”', '"What does \'tamed\' mean?" asked the prince. "It is an act too often neglected," said the fox, "it means \'to establish ties.\'"'],
        ['“建立羁绊？”“对，”狐狸说，“对我来说，你现在只是一个和成千上万个男孩子一模一样的小男孩，我不需要你，你也不需要我。但如果你驯服了我，我们就会彼此需要。对我而言，你就是全宇宙独一无二的；对你而言，我也是全宇宙独一无二的了……”', '"Establish ties?" "Yes," said the fox, "To me, you are still only a little boy like a hundred thousand other boys. But if you tame me, we shall need each other. To me you will be unique in all the world; to you I shall be unique in all the world..."'],
        ['小王子恍然大悟：“我开始明白了……有一朵花……我想她已经驯服了我。”', 'The little prince whispered softly: "I begin to understand... there is a flower... I think she has tamed me."'],
        ['狐狸继续说：“我的生活很单调。但如果你驯服了我，我的生命就如同充满阳光。金黄色的麦田虽然我吃不了面包，但每当我看到麦浪，我就会想起你金黄色的头发，我甚至会爱上听风吹麦浪的声音……”', 'The fox continued: "My life is monotonous. But if you tame me, sunshine will illuminate my days. Wheat fields will remind me of your golden hair, and I will love the sound of wind in the wheat..."'],
        ['小王子驯服了狐狸。当分别的时刻到来时，狐狸哭了。小王子说：“这都是你的错，我本不想伤害你，但你偏要我驯服你！”狐狸说：“是的，但麦田的颜色给了我安慰。”', 'The prince tamed the fox. When the hour of departure drew near, the fox wept. The prince said: "It is your own fault, I wished you no harm!" The fox said: "Yes, but look at the color of the wheat fields; it brings me comfort."'],
        ['狐狸送给小王子一个秘密作为临别礼物：“这是我的秘密，它极其简单：唯有用心灵才能看得清事物的本质，真正重要的东西，用肉眼是看不见的。”', 'The fox gave the prince a secret parting gift: "Here is my secret, very simple: It is only with the heart that one can see rightly; what is essential is invisible to the eye."'],
        ['“正是你为你的玫瑰付出的时间与心血，才使你的玫瑰变得如此重要。你必须对你驯服过的一切永远负责，你对你的玫瑰负有责任。”小王子默默地把这些话牢牢记在心底。', '"It is the time you have wasted for your rose that makes your rose so important. You become responsible forever for what you have tamed. You are responsible for your rose." The little prince repeated, cementing it in his soul.']
      ]
    },
    {
      'title': '第二十二章：铁道扳道工与不知去向的急促旅客',
      'titleEn': 'Chapter 22: The Railway Switchman & Restless Travelers',
      'dialogues': [
        ['“你好，”小王子说。“你好，”扳道工说。', '"Good morning," said the little prince. "Good morning," said the switchman.'],
        ['“你在这里做什么呢？”小王子问。“我把旅客分批送上列车，”扳道工回答，“把载着他们的火车送往右边，或者送往左边。”', '"What do you do here?" asked the prince. "I sort out travelers by packets of a thousand," said the switchman, "sending trains right or left."'],
        ['一列灯火通明的快车雷鸣般疾驰而过，把扳道工的小屋震得摇摇晃晃。“他们走得真急啊，”小王子问，“他们在寻找什么呢？”', 'A brilliantly lighted express train roared by like thunder, shaking the cabin. "They are in a great hurry," said the prince, "what are they seeking?"'],
        ['“开火车的司机自己也不知道。”扳道工回答。', '"Even the engine driver does not know," said the switchman.'],
        ['第二列快车又反方向轰鸣而过。“他们已经回来了吗？”小王子问。“不，这是另外一批人，他们在换车。”', 'A second express train roared by in the opposite direction. "Are they already coming back?" asked the prince. "No, these are different travelers swapping places."'],
        ['“他们对原来住的地方不满意吗？”“人永远不会对自己所处的地方感到满足。”扳道工叹道。', '"Were they not satisfied where they were?" "No one is ever satisfied where they are," sighed the switchman.'],
        ['小王子看着疾驰的列车：“只有小孩子把鼻子贴在车窗上往外看，只有他们懂得自己在寻找什么。他们会为一只布娃娃哭泣，娃娃便成了他们最重要的宝贝。”扳道工羡慕地说：“他们真幸运。”', 'The prince watched the train: "Only the children flatten their noses against the windowpanes. Only they know what they are looking for. They waste time over a rag doll and it becomes important." The switchman said: "They are the lucky ones."']
      ]
    },
    {
      'title': '第二十三章：贩卖解渴药丸的商贩与五十三分钟',
      'titleEn': 'Chapter 23: The Merchant Selling Thirst Pills',
      'dialogues': [
        ['“你好，”小王子说。“你好，”商贩说。', '"Good morning," said the little prince. "Good morning," said the merchant.'],
        ['这是一个贩卖特制止渴药丸的商贩。只要每周吞下一粒药丸，人就再也不需要喝水了。', 'He was a merchant who sold pills devised to quench thirst. Swallow one a week and you no longer feel the need to drink.'],
        ['“你为什么卖这个东西呢？”小王子好奇地问。', '"Why do you sell those?" asked the little prince.'],
        ['“这能节省大量的宝贵时间，”商贩精明地算计道，“专家计算过，每周能节省五十三分钟呢！”', '"Because it saves a tremendous amount of time," the merchant computed. "Experts calculate it saves fifty-three minutes a week!"'],
        ['“那么节省出来的五十三分钟用来做什么呢？”小王子问。“随你喜欢做什么就做什么。”', '"And what does one do with those fifty-three minutes?" "Whatever one likes."'],
        ['小王子心想：“如果我有五十三分钟可以自由支配，我会悠闲自得地迈开步子，慢慢走向一眼清澈甘甜的水泉……”', 'The little prince said to himself: "As for me, if I had fifty-three minutes to spend as I liked, I would walk quite slowly toward a freshwater spring..."']
      ]
    },
    {
      'title': '第二十四章：沙漠深处的寻泉之旅与使沙漠美丽的秘密',
      'titleEn': 'Chapter 24: Searching for the Well & Secret Beauty of the Desert',
      'dialogues': [
        ['这是飞机在沙漠中抛锚后的第八天。我听着卖药丸商贩的故事，喝下了最后一滴救命的水。', 'It was now the eighth day since my engine broke down in the desert, and I was listening to the merchant story while drinking the last drop of water.'],
        ['我对小王子说：“你讲的这些回忆真美，但我还没修好飞机，而且我们已经没有水喝了，要是能慢慢走向水泉该多好啊！”', 'I told the prince: "Your memories are charming, but my plane is still broken and I have nothing left to drink; I too would love to walk slowly toward a spring!"'],
        ['小王子提议：“我们也去找一口水井吧……”在无边无际的沙漠里盲目寻找水井看似疯狂，但我们还是在落日中启程了。', 'The prince suggested: "Let us go look for a well..." Though searching blindly across endless sands seemed absurd, we set off into the setting sun.'],
        ['夜幕降临，繁星点点，小王子走累了，坐了下来。他说：“沙漠之所以美丽，是因为在某个角落里，藏着一口清泉……”', 'Night fell and the stars began to shine. Tired, the prince sat down: "What makes the desert beautiful is that somewhere it hides a well..."'],
        ['我突然心头一震，顿悟了这个神秘的真理。无论是房屋、星星还是沙漠，使它们美丽的，都是肉眼看不见的东西！', 'I was struck by sudden realization of this luminous truth. Whether a house, stars, or the desert, what makes them beautiful is invisible!'],
        ['小王子睡着了。我把他抱在怀里，在月光下继续前行。看着他金黄色的头发在夜风中轻拂，我深受感动：我所看到的只是一个外壳，最重要的东西是看不见的。', 'The little prince fell asleep. I took him in my arms and walked under the moon. Looking at his golden hair in the breeze, I was deeply moved: what I see is only a shell; what is most important is invisible.']
      ]
    },
    {
      'title': '第二十五章：甘甜如礼物的清泉水与羊嘴套的约定',
      'titleEn': 'Chapter 25: The Sweet Water of the Well & The Muzzle',
      'dialogues': [
        ['拂晓时分，我们终于发现了一口水井。那不是沙漠里常见的简陋水坑，而是一口如同撒哈拉村庄里的古老石头水井。', 'At daybreak, we discovered a well. It was not a crude hole in the sand, but an ancient stone well like those in rural villages.'],
        ['滑轮、水桶和绳索一应俱全。我转动生锈的滑轮，滑轮像一架沉睡已久的老风车一样欢唱起来。', 'Everything was ready: pulley, bucket, and rope. I turned the rusty wheel, and it sang like an old weather vane waking from long slumber.'],
        ['我把沉甸甸的水桶提到井沿上，小王子轻声说：“我渴望喝这水，请让我喝一口吧……”', 'I hoisted the full bucket to the stone rim. The little prince whispered: "I thirst for this water; give me some to drink..."'],
        ['我把水桶送到他的唇边。他闭着眼睛，大口大口地畅饮着。这水甘甜如蜜，它不是普通的养分，它诞生于星空下的跋涉、滑轮的歌唱以及我双臂的劳作，它对心灵而言就像是一份美好的节日礼物。', 'I lifted it to his lips. He drank with closed eyes. This water was sweet as a feast, born of our walk under stars, the pulley’s song, and the labor of my arms—it was like a gift to the heart.'],
        ['小王子擦了擦嘴角说：“你这里的人，在一个花园里种五千朵玫瑰，却找不到他们寻觅的东西……其实他们所寻找的，只要在一朵玫瑰花或一滴水中就能找到。”', 'The prince smiled: "People on your planet cultivate five thousand roses in one garden, yet never find what they seek... and yet what they seek could be found in a single rose or a drop of water."'],
        ['他提醒我：“你答应过我的……请为我的小羊画一个嘴套，我要保护好我的玫瑰花。”我取出画笔，为他画好了嘴套，心中却隐隐作痛。', 'He reminded me gently: "You promised... please draw a muzzle for my sheep, to protect my flower." I drew the muzzle, but my heart tightened with quiet apprehension.']
      ]
    },
    {
      'title': '第二十六章：毒蛇的致命信诺与小王子的回归',
      'titleEn': 'Chapter 26: The Snake\'s Bite & Return to the Stars',
      'dialogues': [
        ['在水井旁边，有一堵坍塌的古老石墙。第二天傍晚我修好飞机走回水井时，远远看到小王子坐在墙头。', 'Beside the well stood the ruins of an ancient stone wall. The next evening, having repaired my plane, I saw the prince sitting atop the wall.'],
        ['我听到他在同什么人说话：“你的毒性真的灵验吗？你确定不会让我痛苦太久吗？”', 'I heard him speaking to someone: "Is your poison truly good? Are you sure it will not make me suffer long?"'],
        ['我急忙赶上前去，只见一条黄色的剧毒沙蛇正对着小王子抬起头。我拔出手枪冲过去，蛇迅速溜进了石缝里。', 'I rushed forward and saw a yellow desert snake rearing up toward him. As I drew my revolver, the snake darted into the stones with a faint metallic sound.'],
        ['小王子脸色苍白地倒在我怀里。他抚摸着我冰冷的手：“我很高兴你修好了发动机，你终于可以回家了。今天夜里，我也要回家了……”', 'The prince fell pale into my arms. He touched my hand: "I am glad you found what was wrong with your engine; you can go home. Tonight, I too am going home..."'],
        ['“那里太远了，我不能带走这副沉重的躯壳，它太重了。”小王子看着夜空，“今夜我的那颗星星，正好会出现在我一年前坠落的地方的正上方。”', '"It is much too far. I cannot carry this heavy body; it is too heavy." The prince gazed at the stars: "Tonight, my star will be right above where I fell one year ago."'],
        ['“你知道吗？当你在夜晚仰望星空时，因为我就住在其中一颗星星上，因为我在其中一颗星星上欢笑，所以在你看来，就像所有的星星都在对你微笑一样！你将拥有五亿个会笑的小铃铛！”', '"You know... when you look at the sky at night, since I will live in one of them, since I will laugh in one of them, it will seem to you as if all the stars were laughing! You alone will have stars that know how to laugh!"'],
        ['午夜时分，小王子独自走向沙丘。一道黄色的闪光在它的脚踝边闪过，他没有发出一声尖叫，像一棵小树一样轻轻倒在柔软的沙地上，甚至没有发出一丝声响。', 'At midnight, the prince walked softly into the dunes. A yellow flash gleamed near his ankle. He did not cry out; he fell gently as a tree falls on soft sand, making not a sound.']
      ]
    },
    {
      'title': '第二十七章：遥望星空：五亿颗会笑的小铃铛',
      'titleEn': 'Chapter 27: Stargazing: Five Hundred Million Laughing Bells',
      'dialogues': [
        ['如今，整整六年过去了。我从未向任何人讲过这个故事。同伴们为我能够生还归来而欣喜万分。', 'Now, six full years have passed. I have never told this story before. My companions were overjoyed to see me alive.'],
        ['我知道小王子已经回到了他的星球，因为第二天清晨，我在沙滩上没有找到他的躯体。那具躯体其实并不沉重。', 'I know he returned to his planet, because at dawn I did not find his body in the sand. It was not such a heavy body.'],
        ['每当我夜里仰望繁星，我都感到无比甜美。我倾听着那五亿颗宛如小铃铛般清脆欢笑的星星。', 'Whenever I listen to the stars at night, it is sweet. I listen to those five hundred million little bells ringing with laughter.'],
        ['但有时我也会感到深深的忧虑：我给小羊画的皮嘴套，忘记画皮带了！它永远也系不上！羊会不会在不经意间把那朵玫瑰花吃掉了呢？', 'Yet sometimes fear grips me: on the leather muzzle I drew, I forgot to add the fastening strap! Did the sheep eat the flower unawares?'],
        ['这真是一个深不可测的谜题。对于深爱着小王子的你们和崇敬着他的我来说，天上的某处，一朵我们从未见过的玫瑰花，究竟是安然无恙，还是已经被一只小羊吃掉，宇宙的一切都会因此而彻底改变！', 'It is a great mystery. For you who love the little prince, as for me, nothing in the universe is the same if somewhere an unknown sheep has eaten a rose!'],
        ['请仰望星空吧。问问自己：“羊究竟吃没吃到那朵花？”你们就会看到，整个天穹的意义是如何因这个答案而瞬息万变。', 'Look up at the sky. Ask yourselves: "Has the sheep eaten the flower or not?" And you will see how everything changes in an instant.'],
        ['大人们永远不会理解，这究竟是一件多么重大的事情！', 'And no grown-up will ever understand that this is a matter of so much importance!']
      ]
    }
  ];

  final List<Map<String, dynamic>> fullChapters = [];

  for (int i = 0; i < chapters.length; i++) {
    final chData = chapters[i];
    final chIdx = i + 1;
    final title = chData['title'] as String;
    final titleEn = chData['titleEn'] as String;
    final dialogues = chData['dialogues'] as List<List<String>>;

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

    fullChapters.add({
      'id': 'the_little_prince_ch_$chIdx',
      'bookId': 'the_little_prince',
      'chapterIndex': chIdx,
      'title': title,
      'titleEn': titleEn,
      'sentences': sentences,
    });
  }

  final targetFile = File('assets/data/books/the_little_prince.json');
  targetFile.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(fullChapters));
  print('=== Successfully wrote ${fullChapters.length} authentic chapters for The Little Prince! ===');

  // Also update totalChapters in grand_library_catalog.json
  final catalogFile = File('assets/data/grand_library_catalog.json');
  final List<dynamic> catList = jsonDecode(catalogFile.readAsStringSync());
  for (final item in catList) {
    if (item['id'] == 'the_little_prince') {
      item['totalChapters'] = 27;
      item['description'] = '《小王子》是法国作家圣埃克苏佩里创作的传世哲学童话。来自B612星球的小王子游历宇宙各个奇特行星，最终降落地球，通过与沙漠中的飞行员、毒蛇和狐狸的对话，深刻领悟了爱、责任与“驯服”的真谛——“唯有用心灵才能看得清，真正重要的东西，用肉眼是看不见的。”';
      item['descriptionEn'] = 'The Little Prince (Le Petit Prince) by Antoine de Saint-Exupéry is an immortal philosophical masterpiece. Traveling from Asteroid B-612 across the cosmos to Earth, the Little Prince meets a stranded pilot, a mysterious desert snake, and a wise fox who reveals the supreme secret of love and responsibility: "It is only with the heart that one can see rightly; what is essential is invisible to the eye."';
    }
  }
  catalogFile.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(catList));
  print('=== Catalog updated for The Little Prince! ===');
}
