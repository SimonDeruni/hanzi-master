import 'dart:io';
import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/scenario.dart';
import 'conversation_screen.dart';
import 'live_call_screen.dart';
import '../widgets/custom_scenario_dialog.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/deck_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';

class ScenarioSelectionScreen extends ConsumerStatefulWidget {
  const ScenarioSelectionScreen({super.key});

  @override
  ConsumerState<ScenarioSelectionScreen> createState() => _ScenarioSelectionScreenState();
}

class _ScenarioSelectionScreenState extends ConsumerState<ScenarioSelectionScreen> {
  late List<ConversationScenario> _allScenarios;
  late PageController _pageController;
  int _currentIndex = 0;
  bool _isSurvivalMode = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.85);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _allScenarios = [...getDefaultScenarios(context)];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final currentScenario = _allScenarios[_currentIndex];

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
      body: Stack(
        children: [
          // Background Image with blur
          Positioned.fill(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: _buildBackgroundImage(currentScenario.backgroundAssetPath),
            ),
          ),
          
          // Gradient overlay to ensure text readability
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.7),
                    Colors.black.withValues(alpha: 0.2),
                    Colors.black.withValues(alpha: 0.8),
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
                _buildHeader(context),
                const SizedBox(height: 16),
                _buildModeSelectionToggle(theme),
                const SizedBox(height: 32),
                
                // PageView for Scenarios
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    itemCount: _allScenarios.length,
                    itemBuilder: (context, index) {
                      final scenario = _allScenarios[index];
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
                          isSurvivalMode: _isSurvivalMode,
                          isActive: index == _currentIndex,
                        ),
                      );
                    },
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Action Buttons at bottom
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                  child: Column(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => _startScenario(context, currentScenario, true),
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
                        onPressed: () => _startScenario(context, currentScenario, false),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: BorderSide(color: Colors.white.withValues(alpha: 0.3), width: 1.5),
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

  Widget _buildBackgroundImage(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) {
      return Container(key: const ValueKey('empty_bg'), color: const Color(0xFF1A1A1B));
    }
    
    return Image.asset(
      imagePath,
      key: ValueKey(imagePath),
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (context, error, stackTrace) => Container(color: const Color(0xFF1A1A1B)),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          const Text(
            "Scenario Hub",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.add_circle_outline, color: Colors.white),
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

  Future<void> _generateFromDeck() async {
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
    final deckInfo = asyncDecks.value!.firstWhere((d) => d.id == selectedDeck);
    final allCards = ref.read(flashcardControllerProvider).value ?? [];
    final deckCards = allCards.where((c) => c.deckId == selectedDeck).toList();

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
You must also pick the MOST SUITABLE avatar for this persona from this exact list: $avatarsList.

Respond ONLY with a JSON object containing:
{
  "title": "Short title of the scenario (in English)",
  "description": "Short description (in English)",
  "systemPrompt": "System prompt for the AI persona. They should organically steer the conversation so the user can use the vocabulary.",
  "initialAiMessage": "The first message the AI says (in Chinese)",
  "personaName": "Name of the persona (in English or Pinyin)",
  "avatarAssetPath": "The exact path of the most suitable avatar from the list provided",
  "quests": ["Quest 1 (in English)", "Quest 2 (in English)", "Quest 3 (in English)"]
}
''';
      final response = await ref.read(geminiServiceProvider).generateText(prompt);
      final Map<String, dynamic> data = _parseJsonOrFallback(response);
      
      final selectedAvatar = data['avatarAssetPath'] as String? ?? (avatars..shuffle()).first;
      if (!avatars.contains(selectedAvatar)) {
        avatars.shuffle();
      }
      final validAvatar = avatars.contains(selectedAvatar) ? selectedAvatar : avatars.first;
      
      if (!mounted) return;
      Navigator.pop(context); // Close loading
      
      final newScenario = ConversationScenario(
        id: 'deck_${DateTime.now().millisecondsSinceEpoch}',
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
      
      setState(() {
        _allScenarios.insert(0, newScenario);
        _pageController.jumpToPage(0);
      });
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

  Widget _buildModeSelectionToggle(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48.0),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _isSurvivalMode = false),
                child: Container(
                  decoration: BoxDecoration(
                    color: !_isSurvivalMode ? theme.colorScheme.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Practice",
                    style: TextStyle(
                      color: !_isSurvivalMode ? Colors.white : Colors.white70,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _isSurvivalMode = true),
                child: Container(
                  decoration: BoxDecoration(
                    color: _isSurvivalMode ? Colors.redAccent : Colors.transparent,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.local_fire_department, size: 16, color: _isSurvivalMode ? Colors.white : Colors.white70),
                      const SizedBox(width: 4),
                      Text(
                        "Survival",
                        style: TextStyle(
                          color: _isSurvivalMode ? Colors.white : Colors.white70,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startScenario(BuildContext context, ConversationScenario scenario, bool isVoice) {
    // We would pass isSurvivalMode to the next screen here
    if (isVoice) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => LiveCallScreen(scenario: scenario)));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ConversationScreen(scenario: scenario)));
    }
  }
}

class _ScenarioGlassCard extends StatelessWidget {
  final ConversationScenario scenario;
  final bool isSurvivalMode;
  final bool isActive;

  const _ScenarioGlassCard({
    required this.scenario,
    required this.isSurvivalMode,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
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
                      ],
                    ),
                  ],
                ),
                
                const Spacer(),
                
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
    );
  }
  
  ImageProvider _getAvatarImage(String path) {
    if (path.startsWith('/') || path.contains(':\\')) {
      return FileImage(File(path));
    }
    return AssetImage(path);
  }
}
