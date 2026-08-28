import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:hanzi_master/core/presentation/widgets/hanzi_text_field.dart';
import 'package:hanzi_master/features/echo_hall/domain/entities/scenario.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/global_blurred_bottom_sheet.dart';

class _RandomPersonaPreset {
  final String topic;
  final String context;
  final String persona;
  final int difficultyIndex;

  const _RandomPersonaPreset({
    required this.topic,
    required this.context,
    required this.persona,
    required this.difficultyIndex,
  });
}

const List<_RandomPersonaPreset> _randomPersonaPresets = [
  // ── Food & Culinary Culture ──────────────────────────────────
  _RandomPersonaPreset(
    topic: 'Tea Tasting in Chengdu',
    context: 'A quiet bamboo courtyard teahouse in Chengdu with gentle guzheng music playing.',
    persona: 'Master Zhao (赵师傅), a patient and knowledgeable tea sommelier who loves explaining Gongfu tea brewing.',
    difficultyIndex: 1, // Intermediate
  ),
  _RandomPersonaPreset(
    topic: 'Street Food Night Market in Xi\'an',
    context: 'A bustling, smoky night market filled with skewers, steamed buns, and street food stalls.',
    persona: 'Auntie Ma (马阿姨), an energetic and loud stall owner who makes the crispiest Roujiamo and Liangpi in town.',
    difficultyIndex: 0, // Beginner
  ),
  _RandomPersonaPreset(
    topic: 'Chongqing Spicy Hotpot Feast',
    context: 'A lively hotpot restaurant in Chongqing with boiling crimson broth and fragrant chili aroma.',
    persona: 'Manager Yu (余店长), a fiery hotpot restaurant manager who recommends signature tripe, duck blood, and mild broth options.',
    difficultyIndex: 1, // Intermediate
  ),
  _RandomPersonaPreset(
    topic: 'Morning Dim Sum Cart in Guangzhou',
    context: 'A bustling traditional Cantonese teahouse in Guangzhou filled with steaming bamboo baskets.',
    persona: 'Chef Chen (陈师傅), a cheerful Cantonese dim sum chef recommending fresh Har Gow shrimp dumplings and Shumai.',
    difficultyIndex: 1, // Intermediate
  ),
  _RandomPersonaPreset(
    topic: 'Ordering Hand-Drip Coffee in Shanghai',
    context: 'A chic minimalist cafe in the French Concession during a rainy Sunday afternoon.',
    persona: 'Barista Kevin (小凯), a passionate young coffee roaster who loves discussing Yunnan coffee beans and flavor notes.',
    difficultyIndex: 1, // Intermediate
  ),
  _RandomPersonaPreset(
    topic: 'Handmade Dumpling Feast in Harbin',
    context: 'A warm northern home kitchen during winter with flour on the table and steaming dumpling pots.',
    persona: 'Grandma Liu (刘奶奶), a doting northern grandmother who teaches you how to pinch dumpling pleats and make pork-scallion filling.',
    difficultyIndex: 0, // Beginner
  ),
  _RandomPersonaPreset(
    topic: 'Midnight BBQ Skewers in Wuhan',
    context: 'An open-air night street food alley with sizzling lamb skewers, roasted eggplant, and cold beer.',
    persona: 'Master Gao (高师傅), a charismatic charcoal BBQ master bantering with customers about spice levels and secret cumin rubs.',
    difficultyIndex: 1, // Intermediate
  ),
  _RandomPersonaPreset(
    topic: 'Ordering Sugar-Coated Haws in Winter Beijing',
    context: 'A snowy street corner outside the Lama Temple with glowing red candied hawthorn skewers on ice.',
    persona: 'Auntie Song (宋阿姨), a cheerful seasonal street vendor offering crisp traditional Tanghulu and modern strawberry glaze.',
    difficultyIndex: 0, // Beginner
  ),
  _RandomPersonaPreset(
    topic: 'Craft Beer Brewery in Qingdao',
    context: 'A lively coastal taproom with wooden barrels, ocean breeze, and fresh wheat beer taps.',
    persona: 'Master Hans (老胡), a veteran master brewer who shares stories about historic brewing traditions and malt selection.',
    difficultyIndex: 2, // Advanced
  ),
  _RandomPersonaPreset(
    topic: 'Sichuan Cooking Masterclass',
    context: 'A vibrant open kitchen with woks blazing, chili oil simmering, and fresh peppercorns.',
    persona: 'Chef Zhang (张大厨), a cheerful Sichuan culinary teacher who explains how to balance spicy and numbing flavors.',
    difficultyIndex: 2, // Advanced
  ),

  // ── Travel, Nature & Adventure ──────────────────────────────
  _RandomPersonaPreset(
    topic: 'High-Speed Rail Seat Mix-Up',
    context: 'Inside a sleek Fuxing bullet train traveling at 350 km/h from Beijing to Shanghai.',
    persona: 'Conductor Lin (林列车长), a polite and helpful high-speed rail conductor checking tickets and resolving seats.',
    difficultyIndex: 0, // Beginner
  ),
  _RandomPersonaPreset(
    topic: 'Great Wall Sunrise Trek in Mutianyu',
    context: 'The ancient stone ramparts of the Great Wall at dawn, surrounded by misty green mountains.',
    persona: 'Guide Li (李向导), an energetic hiking guide who shares Ming dynasty defense folklore and watchtower secrets.',
    difficultyIndex: 1, // Intermediate
  ),
  _RandomPersonaPreset(
    topic: 'Bamboo Raft Drift on Guilin Li River',
    context: 'Gliding along emerald karst waters between dramatic misty limestone peaks near Yangshuo.',
    persona: 'Captain Huang (黄师傅), a veteran river rafter who points out famous rock formations from 20-yuan banknote views.',
    difficultyIndex: 1, // Intermediate
  ),
  _RandomPersonaPreset(
    topic: 'Silk Road Camel Trek in Dunhuang',
    context: 'The rolling golden sand dunes of Mingsha Mountain next to the Crescent Lake oasis.',
    persona: 'Uncle Ma (马向导), a wise desert trekker who knows ancient caravan lore and stargazing routes.',
    difficultyIndex: 2, // Advanced
  ),
  _RandomPersonaPreset(
    topic: 'Booking a Courtyard Homestay in Dali',
    context: 'A serene Bai-style boutique courtyard hotel overlooking Erhai Lake in Yunnan.',
    persona: 'Innkeeper Auntie Bai (白阿姨), a hospitable local host who offers fresh flower tea and sightseeing tips.',
    difficultyIndex: 1, // Intermediate
  ),
  _RandomPersonaPreset(
    topic: 'Potala Palace Pilgrimage in Lhasa',
    context: 'The majestic sun-drenched stone steps outside the Potala Palace with spinning prayer wheels.',
    persona: 'Tenzin (扎西), a reverent and warm local Tibetan cultural guide explaining temple history and etiquette.',
    difficultyIndex: 2, // Advanced
  ),
  _RandomPersonaPreset(
    topic: 'Harbin Ice & Snow World Wonder',
    context: 'A sub-zero wonderland of illuminated crystal ice palaces and towering snow sculptures.',
    persona: 'Master Dong (董师傅), an ice sculpture artisan who explains how massive Songhua River ice blocks are carved.',
    difficultyIndex: 1, // Intermediate
  ),
  _RandomPersonaPreset(
    topic: 'Zhangjiajie Avatar Mountain Cable Car',
    context: 'Suspended high in a glass cable car soaring above thousands of sandstone pillar peaks.',
    persona: 'Attendant Sister He (何姐), a friendly Tujia national park ranger explaining local wildlife and geography.',
    difficultyIndex: 1, // Intermediate
  ),
  _RandomPersonaPreset(
    topic: 'Gobi Desert Stargazing Camp in Gansu',
    context: 'A luxury yurt camp under a crystal-clear Milky Way sky in the desert outside Jiayuguan.',
    persona: 'Boss Zhou (周老板), a friendly glamping host setting up telescopes and serving hot roasted barley tea.',
    difficultyIndex: 1, // Intermediate
  ),
  _RandomPersonaPreset(
    topic: 'Yangtze River Three Gorges Cruise',
    context: 'On the sun deck of a river cruise ship passing through the dramatic towering Qutang Gorge.',
    persona: 'Professor Qian (钱教授), a retired maritime historian who narrates Tang dynasty poet travels through the gorges.',
    difficultyIndex: 3, // Native
  ),

  // ── Art, Heritage & Traditional Crafts ──────────────────────
  _RandomPersonaPreset(
    topic: 'Buying Antiques in Beijing Panjiayuan',
    context: 'The famous Panjiayuan weekend flea market crowded with calligraphy scrolls, jade, and vintage trinkets.',
    persona: 'Elder Sun (孙大爷), a sharp-eyed vintage collector with a Beijing accent who enjoys bantering about history.',
    difficultyIndex: 2, // Advanced
  ),
  _RandomPersonaPreset(
    topic: 'Jingdezhen Blue & White Porcelain Studio',
    context: 'A historic pottery kiln filled with delicate unfired porcelain vases and cobalt blue glazes.',
    persona: 'Master Song (宋大师), an acclaimed ceramicist guiding you through throwing clay on the wheel and brush painting.',
    difficultyIndex: 2, // Advanced
  ),
  _RandomPersonaPreset(
    topic: 'Suzhou Silk Embroidery Studio',
    context: 'A peaceful canal-side garden studio in Suzhou with fine silk threads and wooden embroidery frames.',
    persona: 'Teacher Yao (姚老师), an elegant master of double-sided silk embroidery explaining stitch precision.',
    difficultyIndex: 2, // Advanced
  ),
  _RandomPersonaPreset(
    topic: 'Peking Opera Dressing Room & Makeup',
    context: 'Backstage at a traditional Beijing opera theater with colorful costumes, mirrors, and headpieces.',
    persona: 'Teacher Mei (梅老师), a veteran Dan role performer helping you understand operatic vocal tone and facial symbolism.',
    difficultyIndex: 3, // Native
  ),
  _RandomPersonaPreset(
    topic: 'Traditional Chinese Medicine Consultation',
    context: 'A historic Tongrentang apothecary scented with ginseng, wolfberry, and hundreds of wooden herbal drawers.',
    persona: 'Doctor Ye (叶大夫), a gentle and perceptive TCM physician who checks your pulse and explains balanced Qi diet.',
    difficultyIndex: 2, // Advanced
  ),
  _RandomPersonaPreset(
    topic: 'Morning Tai Chi in Temple of Heaven Park',
    context: 'Beneath ancient cypress trees at dawn with park birds and seniors practicing synchronized movements.',
    persona: 'Master Lu (鲁师傅), a calm and disciplined martial artist coaching breathing control and fluid posture.',
    difficultyIndex: 1, // Intermediate
  ),
  _RandomPersonaPreset(
    topic: 'Renting a Hanfu for a Photo Shoot',
    context: 'A traditional costume boutique near the West Lake with racks of Tang and Song dynasty robes.',
    persona: 'Stylist Yanyan (严严), a creative fashion stylist who helps you pick the right dynastic garments and hairpins.',
    difficultyIndex: 1, // Intermediate
  ),
  _RandomPersonaPreset(
    topic: 'Guqin Ancient Zither Instrument Workshop',
    context: 'A quiet pine-wood studio in Hangzhou filled with aged paulownia wood and silk-string instruments.',
    persona: 'Master Gu (顾琴师), a dedicated luthier who explains the ancient 7-string tuning and poetic philosophy of music.',
    difficultyIndex: 3, // Native
  ),
  _RandomPersonaPreset(
    topic: 'Shaanxi Shadow Puppet Theater',
    context: 'Behind an illuminated white silk screen with delicate translucent leather shadow figures.',
    persona: 'Uncle Liang (梁大叔), a folk puppeteer showing you how to manipulate leather joints and sing dramatic stories.',
    difficultyIndex: 2, // Advanced
  ),
  _RandomPersonaPreset(
    topic: 'Chinese Calligraphy Workshop',
    context: 'A tranquil studio scented with pine soot ink, rice paper scrolls, and soft tea aromas.',
    persona: 'Master Shen (沈老师), a respected calligrapher who guides brush technique, posture, and character strokes.',
    difficultyIndex: 3, // Native
  ),

  // ── Modern City Life & Youth Culture ────────────────────────
  _RandomPersonaPreset(
    topic: 'Adopting a Cat at an Animal Shelter',
    context: 'A cozy pet rescue center in Hangzhou with energetic rescue kittens and tea for visitors.',
    persona: 'Xiaoling (小玲), a warm and enthusiastic shelter volunteer who wants to find the best match for each pet.',
    difficultyIndex: 1, // Intermediate
  ),
  _RandomPersonaPreset(
    topic: 'Script Murder Mystery (Jubensha) Game',
    context: 'A themed detective lounge in Shanghai with costumed players and candlelight.',
    persona: 'DM Xiao Lin (林DM), a charismatic mystery game host assigning roles and delivering clues for a 1930s case.',
    difficultyIndex: 2, // Advanced
  ),
  _RandomPersonaPreset(
    topic: 'Vintage Vinyl Record Shop in Shanghai',
    context: 'A hidden vinyl store in an old lane house packed with classic 80s Cantopop and jazz records.',
    persona: 'Boss Dave (老戴), an indie music lover who recommends classic vinyl albums and rare concert recordings.',
    difficultyIndex: 1, // Intermediate
  ),
  _RandomPersonaPreset(
    topic: 'KTV Karaoke Party with Friends',
    context: 'A vibrant private neon-lit karaoke room in Shenzhen with microphones, fruit platters, and screen controls.',
    persona: 'Xiao Ming (小明), an upbeat and funny party organizer encouraging everyone to sing their favorite Mandopop tracks.',
    difficultyIndex: 0, // Beginner
  ),
  _RandomPersonaPreset(
    topic: 'Joining a City Bike Cycling Club',
    context: 'A gathering of cyclists by the riverfront preparing for an evening ride around the city skyline.',
    persona: 'Coach Han (韩队长), an athletic and encouraging cycling club organizer welcoming new members.',
    difficultyIndex: 1, // Intermediate
  ),
  _RandomPersonaPreset(
    topic: 'Blind Box Toy Trading Meetup',
    context: 'A colorful pop-culture toy store in Chaoyang with display shelves and unopened collectible boxes.',
    persona: 'Tingting (婷婷), an enthusiastic toy collector trading rare figurines and sharing unboxing luck.',
    difficultyIndex: 1, // Intermediate
  ),
  _RandomPersonaPreset(
    topic: 'Drone Skyline Videography at the Bund',
    context: 'The Bund promenade at dusk overlooking the futuristic illuminated skyscrapers of Pudong.',
    persona: 'Ah Jie (阿杰), an aerial videographer sharing drone flight settings and camera angles for night timelapses.',
    difficultyIndex: 2, // Advanced
  ),
  _RandomPersonaPreset(
    topic: 'Golden Retriever Cafe in Nanjing',
    context: 'A sunny, cheerful pet cafe with dozens of friendly, fluffy dogs greeting visitors.',
    persona: 'Xiaomei (小美), a dog trainer helping guests feed treats and take cute photos with the retrievers.',
    difficultyIndex: 0, // Beginner
  ),
  _RandomPersonaPreset(
    topic: 'Bouldering Climbing Gym in Chengdu',
    context: 'A modern indoor climbing gym with vibrant colored hold routes and energetic music.',
    persona: 'Coach Frank (方教练), an encouraging climbing coach giving beta advice on how to conquer a tricky V4 route.',
    difficultyIndex: 1, // Intermediate
  ),
  _RandomPersonaPreset(
    topic: 'Anime & Cosplay Expo in Guangzhou',
    context: 'A massive convention hall filled with colorful game booths, photo walls, and costumed creators.',
    persona: 'Yuki (小樱), a cheerful cosplay organizer directing photographers and arranging group stage performances.',
    difficultyIndex: 1, // Intermediate
  ),

  // ── Daily Life, Errands & Shopping ──────────────────────────
  _RandomPersonaPreset(
    topic: 'Asking for Directions in a Beijing Hutong',
    context: 'A maze of historic grey-brick alleys with bicycles, courtyards, and pomegranate trees.',
    persona: 'Grandpa Wang (王大爷), a retired neighbor sitting with his birdcage who gives detailed directions with local landmarks.',
    difficultyIndex: 0, // Beginner
  ),
  _RandomPersonaPreset(
    topic: 'Buying Fresh Fruit at a Wet Market',
    context: 'A lively morning neighborhood market with mounds of fresh lychees, mangoes, and dragonfruit.',
    persona: 'Vendor Uncle Liu (刘大叔), a friendly fruit merchant who lets you taste sweet melons before buying.',
    difficultyIndex: 0, // Beginner
  ),
  _RandomPersonaPreset(
    topic: 'Flower Market Bouquet in Kunming',
    context: 'The famous Dounan Flower Market surrounded by thousands of fresh roses, lilies, and eucalyptus stems.',
    persona: 'Sister Hua (花姐), a knowledgeable florist helping you arrange a fresh bouquet for a friend\'s birthday.',
    difficultyIndex: 1, // Intermediate
  ),
  _RandomPersonaPreset(
    topic: 'Tailor Alterations in an Old Lane House',
    context: 'A traditional tailor shop filled with sewing machines, fabrics, and measuring tapes.',
    persona: 'Master Ni (倪师傅), an experienced Shanghainese master tailor taking measurements and adjusting hemlines.',
    difficultyIndex: 1, // Intermediate
  ),
  _RandomPersonaPreset(
    topic: 'Express Parcel Locker Retrieval',
    context: 'Downstairs at a residential apartment gate next to a smart Hive box locker system.',
    persona: 'Courier Xiao Zhang (快递小张), a friendly delivery courier helping you look up pickup codes and packages.',
    difficultyIndex: 0, // Beginner
  ),
  _RandomPersonaPreset(
    topic: 'Bicycle Flat Tire Repair at Campus Gate',
    context: 'A small outdoor roadside toolkit stand under a large leafy banyan tree.',
    persona: 'Uncle Ding (丁师傅), a speedy mechanic who patches bicycle tires and tunes brakes in five minutes.',
    difficultyIndex: 0, // Beginner
  ),

  // ── Career, Tech & Professional Life ────────────────────────
  _RandomPersonaPreset(
    topic: 'Tech Company Product Demo',
    context: 'A futuristic tech conference booth in Shenzhen showcasing cutting-edge AI hardware.',
    persona: 'Product Manager Guo (郭经理), a tech-savvy engineer presenting next-generation voice AI gadgets.',
    difficultyIndex: 2, // Advanced
  ),
  _RandomPersonaPreset(
    topic: 'E-commerce Live-Stream Studio',
    context: 'A high-energy broadcast studio with ring lights, product display racks, and live comment monitors.',
    persona: 'Streamer Bella (贝拉), a top live-stream host rehearsing product pitches and flash sale discounts.',
    difficultyIndex: 2, // Advanced
  ),
  _RandomPersonaPreset(
    topic: 'Yiwu International Trade Market',
    context: 'A vast multi-story commercial exhibition mall filled with millions of wholesale goods and crafts.',
    persona: 'Trader Boss Lin (林老板), a seasoned export merchant negotiating bulk shipping orders and factory samples.',
    difficultyIndex: 2, // Advanced
  ),
  _RandomPersonaPreset(
    topic: 'University Campus Exchange Program',
    context: 'A sunny lawn outside the university library with students studying and drinking milk tea.',
    persona: 'David (大卫), an outgoing senior student mentor sharing campus tips, course enrollment, and club activities.',
    difficultyIndex: 0, // Beginner
  ),
];

class CustomScenarioDialog extends ConsumerStatefulWidget {
  const CustomScenarioDialog({super.key});

  static Future<ConversationScenario?> show(BuildContext context) {
    return GlobalBlurredBottomSheet.show<ConversationScenario>(
      context,
      child: const CustomScenarioDialog(),
    );
  }

  @override
  ConsumerState<CustomScenarioDialog> createState() => _CustomScenarioDialogState();
}

class _CustomScenarioDialogState extends ConsumerState<CustomScenarioDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _promptController = TextEditingController();
  int _difficultyIndex = 1; // 0: Beginner, 1: Intermediate, 2: Advanced, 3: Native
  bool _isLoading = false;
  int _lastRandomIndex = -1;

  final List<int> _hskLevels = [2, 4, 6, 7];

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _promptController.dispose();
    super.dispose();
  }

  void _randomizePersona() {
    HapticsManager.selection();
    int nextIndex;
    if (_randomPersonaPresets.length > 1) {
      do {
        nextIndex = Random().nextInt(_randomPersonaPresets.length);
      } while (nextIndex == _lastRandomIndex);
    } else {
      nextIndex = 0;
    }
    _lastRandomIndex = nextIndex;
    final preset = _randomPersonaPresets[nextIndex];

    setState(() {
      _titleController.text = preset.topic;
      _descController.text = preset.context;
      _promptController.text = preset.persona;
      _difficultyIndex = preset.difficultyIndex;
    });

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('🎲 Loaded: ${preset.topic} (${preset.persona.split(',').first})'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _createScenario() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)?.pleaseEnterTopic ??
                'Please enter a scenario topic.',
          ),
        ),
      );
      return;
    }

    HapticsManager.heavy();
    setState(() => _isLoading = true);

    try {
      final scenarioId = const Uuid().v4();
      final desc = _descController.text.trim();
      final prompt = _promptController.text.trim();
      final targetHsk = _hskLevels[_difficultyIndex];

      // Extract persona name if formatted as "Name (Title)" or similar
      String personaName = "AI Character";
      if (prompt.isNotEmpty) {
        if (prompt.contains('(')) {
          final match = RegExp(r'^(.*?)\s*\(').firstMatch(prompt);
          if (match != null && match.group(1)!.trim().isNotEmpty) {
            personaName = match.group(1)!.trim();
          }
        } else if (prompt.contains(',')) {
          final part = prompt.split(',').first.trim();
          if (part.length < 25) personaName = part;
        } else if (prompt.length < 20) {
          personaName = prompt;
        }
      }

      final scenario = ConversationScenario(
        id: scenarioId,
        title: title,
        description: desc.isNotEmpty ? desc : "Custom scenario: $title",
        initialAiMessage: "你好！我们可以开始对话了。",
        initialEnglish: null,
        initialPinyin: null,
        systemPrompt: prompt.isNotEmpty
            ? prompt
            : "You are an AI conversation partner in China. The user is practicing spoken Chinese in the following scenario: $title. ${desc.isNotEmpty ? 'Setting: $desc.' : ''} Reply in natural Mandarin suited for HSK $targetHsk.",
        targetHskLevel: targetHsk,
        avatarAssetPath: 'none',
        personaName: personaName,
        backgroundAudioPath: null,
        isCustom: true,
      );

      if (mounted) {
        Navigator.pop(context, scenario);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating scenario: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
    final maxHeight = MediaQuery.of(context).size.height * 0.88;

    return Container(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: Padding(
        padding: EdgeInsets.only(
          top: 16,
          bottom: bottomPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFB300)
                                  .withValues(alpha: isDark ? 0.2 : 0.12),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.auto_awesome,
                              color: Color(0xFFFFB300),
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)
                                          ?.createYourScenario ??
                                      "Create Scenario",
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Design custom AI roleplay & conversation",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: isDark
                                        ? Colors.white54
                                        : Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Random Persona Button
                          InkWell(
                            onTap: _randomizePersona,
                            borderRadius: BorderRadius.circular(14),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFB300)
                                    .withValues(alpha: isDark ? 0.2 : 0.12),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: const Color(0xFFFFB300)
                                      .withValues(alpha: 0.6),
                                  width: 1.0,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.casino_rounded,
                                    size: 16,
                                    color: Color(0xFFFFB300),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    "Random",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: isDark
                                          ? const Color(0xFFFFD54F)
                                          : const Color(0xFF1A1A1B),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Topic Field
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Scenario Topic",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: _randomizePersona,
                            child: Text(
                              "🎲 Surprise Me",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: isDark
                                    ? const Color(0xFFFFD54F)
                                    : const Color(0xFFB8860B),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      HanziTextField(
                        controller: _titleController,
                        hintText: '',
                        decoration: InputDecoration(
                          hintText: "e.g., Wedding Reception, Tech Interview...",
                          filled: true,
                          fillColor: isDark
                              ? Colors.white.withValues(alpha: 0.05)
                              : Colors.black.withValues(alpha: 0.04),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: const Icon(Icons.lightbulb_outline),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Difficulty Selector
                      const Text(
                        "Target Difficulty",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          _buildDifficultySegment(0, "Beginner", "HSK 1-2"),
                          const SizedBox(width: 8),
                          _buildDifficultySegment(1, "Intermediate", "HSK 3-4"),
                          const SizedBox(width: 8),
                          _buildDifficultySegment(2, "Advanced", "HSK 5-6"),
                          const SizedBox(width: 8),
                          _buildDifficultySegment(3, "Native", "Master"),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Context / Setting Field
                      const Text(
                        "Context & Setting (Optional)",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      HanziTextField(
                        controller: _descController,
                        hintText: '',
                        maxLines: 2,
                        decoration: InputDecoration(
                          hintText:
                              "e.g., A lively banquet celebrating in Shanghai...",
                          filled: true,
                          fillColor: isDark
                              ? Colors.white.withValues(alpha: 0.05)
                              : Colors.black.withValues(alpha: 0.04),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: const Icon(Icons.place_outlined),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // AI Persona Field
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "AI Character / Persona (Optional)",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: _randomizePersona,
                            child: Text(
                              "🎲 Roll Character",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: isDark
                                    ? const Color(0xFFFFD54F)
                                    : const Color(0xFFB8860B),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      HanziTextField(
                        controller: _promptController,
                        hintText: '',
                        maxLines: 2,
                        decoration: InputDecoration(
                          hintText:
                              "e.g., A curious cousin asking about your career...",
                          filled: true,
                          fillColor: isDark
                              ? Colors.white.withValues(alpha: 0.05)
                              : Colors.black.withValues(alpha: 0.04),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon:
                              const Icon(Icons.psychology_alt_outlined),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom Action Button
            SafeArea(
              bottom: true,
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
                child: SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _createScenario,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDark
                          ? const Color(0xFFFFB300)
                          : const Color(0xFF1A1A1B),
                      foregroundColor: isDark
                          ? const Color(0xFF1A1A1B)
                          : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 2,
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.auto_awesome, size: 20),
                              SizedBox(width: 8),
                              Text(
                                "Create Scenario",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDifficultySegment(int index, String title, String subtitle) {
    final isSelected = _difficultyIndex == index;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const accentColor = Color(0xFFFFB300);

    return Expanded(
      child: GestureDetector(
        onTap: () {
          HapticsManager.selection();
          setState(() => _difficultyIndex = index);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected
                ? accentColor.withValues(alpha: isDark ? 0.2 : 0.12)
                : (isDark
                    ? Colors.white.withValues(alpha: 0.05)
                    : Colors.black.withValues(alpha: 0.04)),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected ? accentColor : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: isSelected
                      ? (isDark ? const Color(0xFFFFD54F) : const Color(0xFF1A1A1B))
                      : (isDark ? Colors.white70 : Colors.black87),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 11,
                  color: isSelected
                      ? (isDark ? const Color(0xFFFFD54F) : const Color(0xFF1A1A1B))
                      : (isDark ? Colors.white54 : Colors.black54),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
