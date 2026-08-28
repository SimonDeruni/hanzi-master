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
    topic: 'Buying Antiques in Beijing Panjiayuan',
    context: 'The famous Panjiayuan weekend flea market crowded with calligraphy scrolls, jade, and vintage trinkets.',
    persona: 'Elder Sun (孙大爷), a sharp-eyed vintage collector with a Beijing accent who enjoys bantering about history.',
    difficultyIndex: 2, // Advanced
  ),
  _RandomPersonaPreset(
    topic: 'Adopting a Cat at an Animal Shelter',
    context: 'A cozy pet rescue center in Hangzhou with energetic rescue kittens and tea for visitors.',
    persona: 'Xiaoling (小玲), a warm and enthusiastic shelter volunteer who wants to find the best match for each pet.',
    difficultyIndex: 1, // Intermediate
  ),
  _RandomPersonaPreset(
    topic: 'Ordering Hand-Drip Coffee in Shanghai',
    context: 'A chic minimalist cafe in the French Concession during a rainy Sunday afternoon.',
    persona: 'Barista Kevin (小凯), a passionate young coffee roaster who loves discussing Yunnan coffee beans and flavors.',
    difficultyIndex: 1, // Intermediate
  ),
  _RandomPersonaPreset(
    topic: 'High-Speed Rail Seat Mix-Up',
    context: 'Inside a sleek Fuxing bullet train traveling at 350 km/h from Beijing to Shanghai.',
    persona: 'Conductor Lin (林列车长), a polite and helpful high-speed rail conductor checking tickets and resolving seats.',
    difficultyIndex: 0, // Beginner
  ),
  _RandomPersonaPreset(
    topic: 'Sichuan Cooking Masterclass',
    context: 'A vibrant open kitchen with woks blazing, chili oil simmering, and fresh peppercorns.',
    persona: 'Chef Zhang (张大厨), a cheerful Sichuan culinary teacher who explains how to balance spicy and numbing flavors.',
    difficultyIndex: 2, // Advanced
  ),
  _RandomPersonaPreset(
    topic: 'Renting a Hanfu for a Photo Shoot',
    context: 'A traditional costume boutique near the West Lake with racks of Tang and Song dynasty robes.',
    persona: 'Stylist Yanyan (严严), a creative fashion stylist who helps you pick the right dynastic garments and hairpins.',
    difficultyIndex: 1, // Intermediate
  ),
  _RandomPersonaPreset(
    topic: 'Booking a Courtyard Homestay in Dali',
    context: 'A serene Bai-style boutique courtyard hotel overlooking Erhai Lake in Yunnan.',
    persona: 'Innkeeper Auntie Bai (白阿姨), a hospitable local host who offers fresh flower tea and sightseeing tips.',
    difficultyIndex: 1, // Intermediate
  ),
  _RandomPersonaPreset(
    topic: 'Asking for Directions in a Beijing Hutong',
    context: 'A maze of historic grey-brick alleys with bicycles, courtyards, and pomegranate trees.',
    persona: 'Grandpa Wang (王大爷), a retired neighbor sitting with his birdcage who gives detailed directions with local landmarks.',
    difficultyIndex: 0, // Beginner
  ),
  _RandomPersonaPreset(
    topic: 'Joining a City Bike Cycling Club',
    context: 'A gathering of cyclists by the riverfront preparing for an evening ride around the city skyline.',
    persona: 'Coach Han (韩队长), an athletic and encouraging cycling club organizer welcoming new members.',
    difficultyIndex: 1, // Intermediate
  ),
  _RandomPersonaPreset(
    topic: 'Tech Company Product Demo',
    context: 'A futuristic tech conference booth in Shenzhen showcasing cutting-edge AI hardware.',
    persona: 'Product Manager Guo (郭经理), a tech-savvy engineer presenting next-generation voice AI gadgets.',
    difficultyIndex: 2, // Advanced
  ),
  _RandomPersonaPreset(
    topic: 'Buying Fresh Fruit at a Wet Market',
    context: 'A lively morning neighborhood market with mounds of fresh lychees, mangoes, and dragonfruit.',
    persona: 'Vendor Uncle Liu (刘大叔), a friendly fruit merchant who lets you taste sweet melons before buying.',
    difficultyIndex: 0, // Beginner
  ),
  _RandomPersonaPreset(
    topic: 'Chinese Calligraphy Workshop',
    context: 'A tranquil studio scented with pine soot ink, rice paper scrolls, and soft tea aromas.',
    persona: 'Master Shen (沈老师), a respected calligrapher who guides brush technique, posture, and character strokes.',
    difficultyIndex: 3, // Native
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
