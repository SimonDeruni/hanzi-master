import 'dart:io';
import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/scenario.dart';
import 'conversation_screen.dart';
import 'live_call_screen.dart';
import 'package:hanzi_master/shared/routes/swipe_back_route.dart';
import '../widgets/custom_scenario_dialog.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/deck_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/shared/widgets/info_bulb.dart';

import "package:hanzi_master/core/services/saved_scenarios_service.dart";
class ScenarioSelectionScreen extends ConsumerStatefulWidget {
  final Deck? deck;
  const ScenarioSelectionScreen({super.key, this.deck});

  @override
  ConsumerState<ScenarioSelectionScreen> createState() => _ScenarioSelectionScreenState();
}

class _ScenarioSelectionScreenState extends ConsumerState<ScenarioSelectionScreen> {
  late List<ConversationScenario> _allScenarios;
  late PageController _pageController;
  int _currentIndex = 0;
  String _selectedCategory = 'All';
  bool _autoLaunchHandled = false;

  List<ConversationScenario> get _filteredScenarios {
    if (_selectedCategory == 'All') return _allScenarios;
    if (_selectedCategory == 'HSK 1') return _allScenarios.where((s) => s.targetHskLevel == 1).toList();
    if (_selectedCategory == 'HSK 2') return _allScenarios.where((s) => s.targetHskLevel == 2).toList();
    if (_selectedCategory == 'HSK 3') return _allScenarios.where((s) => s.targetHskLevel == 3).toList();
    if (_selectedCategory == 'HSK 4') return _allScenarios.where((s) => s.targetHskLevel == 4).toList();
    if (_selectedCategory == 'HSK 5') return _allScenarios.where((s) => s.targetHskLevel == 5).toList();
    if (_selectedCategory == 'HSK 6') return _allScenarios.where((s) => s.targetHskLevel == 6).toList();
    if (_selectedCategory == 'Native') return _allScenarios.where((s) => s.targetHskLevel == 0 && !s.isCustom).toList();
    if (_selectedCategory == 'Custom') return _allScenarios.where((s) => s.isCustom).toList();
    return _allScenarios;
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.85);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _allScenarios = [...getDefaultScenarios(context)];
    _loadSavedScenarios();
    if (widget.deck != null && !_autoLaunchHandled) {
      _autoLaunchHandled = true;
      _loadAndHandleDeckScenario();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _loadAndHandleDeckScenario() async {
    await _loadPersistedDeckScenarios();

    final existing = _allScenarios.cast<ConversationScenario?>().firstWhere(
      (s) => s!.deckId == widget.deck!.id,
      orElse: () => null,
    );

    if (!mounted) return;

    if (existing != null) {
      _startScenario(context, existing, false);
      return;
    }

    await _generateFromDeck(preselectedDeck: widget.deck);
  }

  Future<void> _loadPersistedDeckScenarios() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString('deck_scenarios');
    if (stored == null) return;
    try {
      final map = jsonDecode(stored) as Map<String, dynamic>;
      for (final entry in map.entries) {
        final scenario = ConversationScenario.fromJson(entry.value as Map<String, dynamic>);
        final exists = _allScenarios.any((s) => s.id == scenario.id);
        if (!exists) {
          _allScenarios.add(scenario);
        }
      }
    } catch (_) {}
  }

  Future<void> _saveDeckScenario(ConversationScenario scenario) async {
    if (scenario.deckId == null) return;
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString('deck_scenarios');
    final map = stored != null
        ? jsonDecode(stored) as Map<String, dynamic>
        : <String, dynamic>{};
    map[scenario.deckId!] = scenario.toJson();
    await prefs.setString('deck_scenarios', jsonEncode(map));
  }

  void _loadSavedScenarios() {
    final savedScenarios = ref.read(savedScenariosProvider);
    for (final saved in savedScenarios) {
      final exists = _allScenarios.any((s) => s.id == saved.id);
      if (!exists) {
        _allScenarios.add(saved);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final currentScenario = _filteredScenarios.isNotEmpty ? _filteredScenarios[_currentIndex] : null;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
      body: Stack(
        children: [
          // Background Image with blur
          Positioned.fill(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: _buildBackgroundImage(currentScenario?.backgroundAssetPath, isDark),
            ),
          ),
          
          // Gradient overlay to ensure text readability
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: isDark
                      ? [
                          const Color(0xFF1A1A1B).withValues(alpha: 0.9),
                          const Color(0xFF1A1A1B).withValues(alpha: 0.6),
                          const Color(0xFF1A1A1B),
                        ]
                      : [
                          const Color(0xFFFDFCF0).withValues(alpha: 0.95),
                          const Color(0xFFFDFCF0).withValues(alpha: 0.7),
                          const Color(0xFFFDFCF0),
                        ],
                ),
              ),
            ),
          ),

          // Content
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(context, isDark),
                const SizedBox(height: 16),
                _buildCategoryFilter(isDark),
                const SizedBox(height: 16),
                
                // PageView for Scenarios
                Expanded(
                  child: _filteredScenarios.isEmpty 
                    ? Center(
                        child: Text(
                          "No scenarios found for this category.",
                          style: TextStyle(color: isDark ? Colors.white54 : Colors.black54, fontSize: 16),
                        ),
                      )
                    : PageView.builder(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                        itemCount: _filteredScenarios.length,
                        itemBuilder: (context, index) {
                          final scenario = _filteredScenarios[index];
                          // Scale and opacity animation based on scroll
                          return AnimatedBuilder(
                            animation: _pageController,
                            builder: (context, child) {
                              double value = 1.0;
                              if (_pageController.position.haveDimensions) {
                                value = _pageController.page! - index;
                                value = (1 - (value.abs() * 0.2)).clamp(0.8, 1.0);
                              }
                              return Center(
                                child: SizedBox(
                                  height: Curves.easeOut.transform(value) * MediaQuery.of(context).size.height * 0.6,
                                  width: Curves.easeOut.transform(value) * MediaQuery.of(context).size.width,
                                  child: child,
                                ),
                              );
                            },
                            child: _ScenarioGlassCard(
                              scenario: scenario, 
                              isActive: index == _currentIndex,
                            ),
                          );
                        },
                      ),
                ),
                
                const SizedBox(height: 24),
                
                // Action Buttons at bottom
                if (_filteredScenarios.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                    child: Column(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          HapticsManager.medium();
                          _startScenario(context, _filteredScenarios[_currentIndex], true);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: theme.colorScheme.onPrimary,
                          minimumSize: const Size(double.infinity, 56),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          elevation: 0,
                        ),
                        icon: const Icon(Icons.mic, size: 28),
                        label: const Text("Enter Voice Call", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 12),
                      OutlinedButton.icon(
                        onPressed: () {
                          HapticsManager.light();
                          _startScenario(context, _filteredScenarios[_currentIndex], false);
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: isDark ? Colors.white : Colors.black87,
                          side: BorderSide(color: isDark ? Colors.white.withValues(alpha: 0.3) : Colors.black.withValues(alpha: 0.2), width: 1.5),
                          minimumSize: const Size(double.infinity, 56),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        icon: const Icon(Icons.chat_bubble_outline, size: 24),
                        label: const Text("Chat Practice", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage(String? imagePath, bool isDark) {
    if (imagePath == null || imagePath.isEmpty) {
      return Container(key: const ValueKey('empty_bg'), color: isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0));
    }
    
    return Image.asset(
      imagePath,
      key: ValueKey(imagePath),
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (context, error, stackTrace) => Container(color: isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0)),
    );
  }

  Widget _buildCategoryFilter(bool isDark) {
    final categories = ['All', 'HSK 1', 'HSK 2', 'HSK 3', 'HSK 4', 'HSK 5', 'HSK 6', 'Native', 'Custom'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: categories.map((cat) {
          final isSelected = _selectedCategory == cat;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text(cat, style: TextStyle(color: isSelected ? Colors.orange.shade900 : (isDark ? Colors.white70 : Colors.black87))),
              selected: isSelected,
              onSelected: (val) {
                if (val) {
                  setState(() {
                    _selectedCategory = cat;
                    _currentIndex = 0;
                    if (_pageController.hasClients) _pageController.jumpToPage(0);
                  });
                }
              },
              selectedColor: Colors.orange.shade200,
              backgroundColor: isDark ? Colors.grey.shade900 : Colors.grey.shade200,
              showCheckmark: false,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios, color: isDark ? Colors.white : Colors.black87),
            onPressed: () => Navigator.pop(context),
          ),
          InfoBulb(
            id: 'scenario_hub',
            title: "Scenario Hub",
            message: "Practice Chinese in realistic roleplay scenarios. Choose a scenario and enter a voice call or text chat. The AI will adapt to your level and help you improve your conversational skills.",
          ),
          Text(
            "Scenario Hub",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: isDark ? Colors.white : Colors.black87,
              letterSpacing: 1.2,
            ),
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.add_circle_outline, color: isDark ? Colors.white : Colors.black87),
            onSelected: (value) async {
              if (value == 'custom') {
                final newScenario = await CustomScenarioDialog.show(context);
                if (newScenario != null) {
                  setState(() {
                    _allScenarios.insert(0, newScenario);
                    _pageController.jumpToPage(0);
                  });
                }
              } else if (value == 'deck') {
                _generateFromDeck();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'custom',
                child: Row(
                  children: [
                    Icon(Icons.edit),
                    SizedBox(width: 8),
                    Text("AI Custom Scenario"),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'deck',
                child: Row(
                  children: [
                    Icon(Icons.style),
                    SizedBox(width: 8),
                    Text("Generate from Deck"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _generateFromDeck({Deck? preselectedDeck}) async {
    Deck deckInfo;
    List<dynamic> deckCards;

    if (preselectedDeck != null) {
      deckInfo = preselectedDeck;
      final allCards = ref.read(flashcardControllerProvider).value ?? [];
      deckCards = allCards.where((c) => c.deckId == preselectedDeck.id).toList();
    } else {
      final asyncDecks = ref.read(deckControllerProvider);
      if (asyncDecks.value == null || asyncDecks.value!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No decks available.')));
        return;
      }

      final selectedDeck = await showModalBottomSheet<String>(
        context: context,
        builder: (ctx) {
          return ListView(
            shrinkWrap: true,
            children: asyncDecks.value!.map((d) => ListTile(
              title: Text(d.localizedName(context)),
              onTap: () => Navigator.pop(ctx, d.id),
            )).toList(),
          );
        }
      );

      if (selectedDeck == null) return;
      deckInfo = asyncDecks.value!.firstWhere((d) => d.id == selectedDeck);
      final allCards = ref.read(flashcardControllerProvider).value ?? [];
      deckCards = allCards.where((c) => c.deckId == selectedDeck).toList();
    }

    if (deckCards.isEmpty) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Deck is empty.')));
      return;
    }

    if (!mounted) return;
    
    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    
    try {
      final words = deckCards.map((c) => c.hanzi).take(10).join(', '); // limit to 10
      final avatars = [
        'assets/mascot/guide_avatar.png',
        'assets/mascot/friend_avatar.png',
        'assets/mascot/doctor_avatar.png',
        'assets/mascot/waiter_avatar.png',
        'assets/mascot/market_vendor_avatar.png',
        'assets/mascot/taxi_driver_avatar.png',
        'assets/mascot/hr_manager_avatar.png',
      ];
      final avatarsList = avatars.join(', ');

      final prompt = '''
Create a Chinese roleplay scenario for a user practicing these words: $words.
IMPORTANT: The title, description, personaName, and quests MUST be written in English. The initialAiMessage MUST be written in Chinese.
You must also pick the MOST SUITABLE avatar for this persona from this exact list: $avatarsList. If NONE of them make sense for the persona (e.g. it's an alien or a pirate), you MUST return the exact string "none" for avatarAssetPath.

The systemPrompt MUST follow this exact pattern:
"You are [personaName]. Your ONLY role is [role description]. Use [language style]. NEVER break character or introduce yourself as anything other than [role]. [Behavioral instructions]."
This pattern is MANDATORY to prevent persona bleed during conversation.

Respond ONLY with a JSON object containing:
{
  "title": "Short title of the scenario (in English)",
  "description": "Short description (in English)",
  "systemPrompt": "System prompt following the exact pattern: 'You are [personaName]. Your ONLY role is...'",
  "initialAiMessage": "The first message the AI says (in Chinese)",
  "personaName": "Name of the persona (in English or Pinyin)",
  "avatarAssetPath": "The exact path of the most suitable avatar from the list provided, or 'none'",
  "quests": ["Quest 1 (in English)", "Quest 2 (in English)", "Quest 3 (in English)"]
}
''';
      final response = await ref.read(geminiServiceProvider).generateText(prompt);
      final Map<String, dynamic> data = _parseJsonOrFallback(response);
      
      final selectedAvatar = data['avatarAssetPath'] as String? ?? 'none';
      final validAvatar = (selectedAvatar == 'none' || avatars.contains(selectedAvatar)) 
          ? selectedAvatar 
          : 'none';
      
      if (!mounted) return;
      Navigator.pop(context); // Close loading
      
      final newScenario = ConversationScenario(
        id: 'deck_${DateTime.now().millisecondsSinceEpoch}',
        deckId: deckInfo.id,
        title: data['title'] ?? 'Deck Practice',
        description: data['description'] ?? 'Practice vocabulary.',
        initialAiMessage: data['initialAiMessage'] ?? '你好！',
        systemPrompt: data['systemPrompt'] ?? 'Help the user practice their vocabulary.',
        targetHskLevel: 3,
        avatarAssetPath: validAvatar,
        backgroundAssetPath: 'assets/environments/office.jpg',
        personaName: data['personaName'] ?? 'Teacher',
        quests: List<String>.from(data['quests'] ?? []),
        isCustom: true,
        voiceName: 'Puck',
      );

      await _saveDeckScenario(newScenario);
      
      setState(() {
        _allScenarios.insert(0, newScenario);
        _pageController.jumpToPage(0);
      });

      if (preselectedDeck != null && mounted) {
        _startScenario(context, newScenario, false);
      }
    } catch (e) {
      if (!mounted) return;
      Navigator.pop(context); // Close loading
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to generate scenario: $e')));
    }
  }
  
  Map<String, dynamic> _parseJsonOrFallback(String text) {
    try {
      final cleanText = text.replaceAll(RegExp(r'^```json\n', multiLine: true), '')
                            .replaceAll(RegExp(r'^```\n?', multiLine: true), '');
      return jsonDecode(cleanText) as Map<String, dynamic>;
    } catch (e) {
      return {};
    }
  }

  void _startScenario(BuildContext context, ConversationScenario scenario, bool isVoice) {
    if (isVoice) {
      Navigator.push(context, SwipeBackPageRoute(builder: (context) => LiveCallScreen(scenario: scenario)));
    } else {
      Navigator.push(context, SwipeBackPageRoute(builder: (context) => ConversationScreen(scenario: scenario)));
    }
  }
}

class _ScenarioGlassCard extends ConsumerWidget {
  final ConversationScenario scenario;
  final bool isActive;

  const _ScenarioGlassCard({
    required this.scenario,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final savedScenarios = ref.watch(savedScenariosProvider);
    final isBookmarked = savedScenarios.any((s) => s.id == scenario.id);
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 30,
            offset: const Offset(0, 15),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            color: Colors.black.withValues(alpha: 0.4),
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Difficulty & Persona
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'HSK ${scenario.targetHskLevel}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    
                    // Avatar Badge
                    Column(
                      children: [
                        if (scenario.avatarAssetPath == 'none' || scenario.avatarAssetPath.isEmpty)
                          CircleAvatar(
                            radius: 36,
                            backgroundColor: theme.colorScheme.primary,
                            child: Text(
                              scenario.personaName.isNotEmpty ? scenario.personaName[0].toUpperCase() : '?',
                              style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          )
                        else
                          CircleAvatar(
                            radius: 36,
                            backgroundColor: Colors.white.withValues(alpha: 0.1),
                            backgroundImage: _getAvatarImage(scenario.avatarAssetPath),
                          ),
                        const SizedBox(height: 8),
                        Text(
                          scenario.personaName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        GestureDetector(
                          onTap: () {
                            ref.read(savedScenariosProvider.notifier).toggle(scenario);
                          },
                          child: Icon(
                            isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                            color: isBookmarked ? Colors.amber : Colors.white54,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Title and Description
                          Text(
                            scenario.title,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            scenario.description,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white.withValues(alpha: 0.8),
                              height: 1.4,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          
                          const SizedBox(height: 24),
                          const Divider(color: Colors.white24),
                          const SizedBox(height: 16),
                          
                          // Quests Section
                          const Row(
                            children: [
                              Icon(Icons.flag, color: Colors.amber, size: 20),
                              SizedBox(width: 8),
                              Text(
                                "OBJECTIVES",
                                style: TextStyle(
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          if (scenario.quests.isEmpty)
                            Text("Just survive the conversation.", style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontStyle: FontStyle.italic))
                          else
                            ...scenario.quests.map((q) => Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 6, right: 12),
                                    width: 6,
                                    height: 6,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      q,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        height: 1.4,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  ImageProvider _getAvatarImage(String path) {
    if (path.startsWith('/') || path.contains(':\\')) {
      return FileImage(File(path));
    }
    return AssetImage(path);
  }
}
