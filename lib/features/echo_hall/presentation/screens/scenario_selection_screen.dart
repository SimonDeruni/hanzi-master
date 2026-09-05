import 'dart:io';
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
import 'package:hanzi_master/core/services/saved_scenarios_service.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/core/presentation/widgets/zen_search_bar.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:hanzi_master/core/widgets/translated_text.dart';
import 'package:hanzi_master/features/echo_hall/domain/logic/generated_scenario_parser.dart';

class ScenarioSelectionScreen extends ConsumerStatefulWidget {
  final Deck? deck;
  final bool showBackButton;
  const ScenarioSelectionScreen(
      {super.key, this.deck, this.showBackButton = true});

  @override
  ConsumerState<ScenarioSelectionScreen> createState() =>
      _ScenarioSelectionScreenState();
}

class _ScenarioSelectionScreenState
    extends ConsumerState<ScenarioSelectionScreen> {
  String _selectedCategory = '';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  bool _autoLaunchHandled = false;

  List<ConversationScenario> get _allScenarios {
    final defaults = getDefaultScenarios(context);
    final saved = ref.watch(savedScenariosProvider);
    final list = <ConversationScenario>[...saved];
    for (final d in defaults) {
      if (!list.any((s) => s.id == d.id)) {
        list.add(d);
      }
    }
    return list;
  }

  List<ConversationScenario> get _filteredScenarios {
    var scenarios = _allScenarios;
    if (_selectedCategory != AppLocalizations.of(context)!.allLabel) {
      if (_selectedCategory == 'HSK 1') {
        scenarios = _allScenarios.where((s) => s.targetHskLevel == 1).toList();
      } else if (_selectedCategory == 'HSK 2') {
        scenarios = _allScenarios.where((s) => s.targetHskLevel == 2).toList();
      } else if (_selectedCategory == 'HSK 3') {
        scenarios = _allScenarios.where((s) => s.targetHskLevel == 3).toList();
      } else if (_selectedCategory == 'HSK 4') {
        scenarios = _allScenarios.where((s) => s.targetHskLevel == 4).toList();
      } else if (_selectedCategory == 'HSK 5') {
        scenarios = _allScenarios.where((s) => s.targetHskLevel == 5).toList();
      } else if (_selectedCategory == 'HSK 6') {
        scenarios = _allScenarios.where((s) => s.targetHskLevel == 6).toList();
      } else if (_selectedCategory ==
          AppLocalizations.of(context)!.customLabel) {
        scenarios = _allScenarios.where((s) => s.isCustom).toList();
      }
    }
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      scenarios = scenarios.where((s) {
        return s.title.toLowerCase().contains(query) ||
            s.description.toLowerCase().contains(query) ||
            s.personaName.toLowerCase().contains(query) ||
            s.quests.any((q) => q.toLowerCase().contains(query));
      }).toList();
    }
    return scenarios;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.deck != null && !_autoLaunchHandled) {
      _autoLaunchHandled = true;
      _loadAndHandleDeckScenario();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
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
      if (widget.showBackButton) {
        Navigator.of(context).pushReplacement(SwipeBackRoute(
            builder: (context) => ConversationScreen(scenario: existing)));
      } else {
        _startScenario(context, existing, false);
      }
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
        final scenario =
            ConversationScenario.fromJson(entry.value as Map<String, dynamic>);
        await ref.read(savedScenariosProvider.notifier).saveScenario(scenario);
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final scenarios = _filteredScenarios;
    final isSearching = _searchQuery.isNotEmpty;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Column(
        children: [
          if (widget.showBackButton)
            SafeArea(
              bottom: false,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded,
                          size: 20),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 4),
          // Search bar
          ZenSearchBar(
            controller: _searchController,
            hintText: AppLocalizations.of(context)!.searchScenariosHint,
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            onChanged: (value) => setState(() => _searchQuery = value),
          ),
          const SizedBox(height: 8),
          // Filter chips
          _buildCategoryFilter(isDark),
          const SizedBox(height: 12),
          // Grid content
          Expanded(
            child: scenarios.isEmpty
                ? Center(
                    child: Text(
                      "No scenarios found.",
                      style: TextStyle(
                        color: isDark ? Colors.white38 : Colors.black54,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 4, bottom: 24),
                    itemCount: isSearching
                        ? (scenarios.length / 2).ceil()
                        : (scenarios.length / 2).ceil() + 2,
                    itemBuilder: (context, index) {
                      if (!isSearching) {
                        if (index == 0) return _buildCreateScenarioCard(isDark);
                        if (index == 1) return _buildCreateFromDeckCard(isDark);
                      }
                      final rowIndex = isSearching ? index : index - 2;
                      final leftScenario = rowIndex * 2 < scenarios.length
                          ? scenarios[rowIndex * 2]
                          : null;
                      final rightScenario = rowIndex * 2 + 1 < scenarios.length
                          ? scenarios[rowIndex * 2 + 1]
                          : null;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: leftScenario != null
                                  ? _buildScenarioCard(leftScenario, isDark)
                                  : const SizedBox(),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: rightScenario != null
                                  ? _buildScenarioCard(rightScenario, isDark)
                                  : const SizedBox(),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  List<Color> _getScenarioGradient(String id, int hsk) {
    if (id.startsWith('food')) {
      return [
        const Color(0xFF8B1E1E),
        const Color(0xFF4A0E0E)
      ]; // Chinese Culinary Crimson
    } else if (id.startsWith('taxi') || id.startsWith('travel')) {
      return [
        const Color(0xFF1E355B),
        const Color(0xFF0E1E36)
      ]; // Travel Midnight Indigo
    } else if (id.startsWith('market') || id.startsWith('shop')) {
      return [
        const Color(0xFF52221B),
        const Color(0xFF2E100C)
      ]; // Silk Market Amber Terracotta
    } else if (id.startsWith('doctor') || id.startsWith('health')) {
      return [
        const Color(0xFF1E3A2B),
        const Color(0xFF0F2218)
      ]; // Herbal Forest Jade
    } else if (id.startsWith('job') || id.startsWith('work')) {
      return [
        const Color(0xFF233142),
        const Color(0xFF111B26)
      ]; // Professional Scholar Slate
    } else if (id.startsWith('intro') || id.startsWith('friend')) {
      return [
        const Color(0xFF38234D),
        const Color(0xFF1B0F29)
      ]; // Twilight Purple
    } else {
      switch (hsk) {
        case 1:
        case 2:
          return [const Color(0xFF1E3A2B), const Color(0xFF0F2218)];
        case 3:
        case 4:
          return [const Color(0xFF52221B), const Color(0xFF2E100C)];
        case 5:
        case 6:
        default:
          return [const Color(0xFF3D0C0C), const Color(0xFF1A0404)];
      }
    }
  }

  String _getScenarioSealText(ConversationScenario scenario) {
    if (scenario.id.startsWith('food')) return '餐饮';
    if (scenario.id.startsWith('taxi')) return '出行';
    if (scenario.id.startsWith('market')) return '市井';
    if (scenario.id.startsWith('doctor')) return '诊所';
    if (scenario.id.startsWith('job')) return '职场';
    if (scenario.id.startsWith('intro')) return '社交';
    if (scenario.isCustom) return '自创';
    return '角色';
  }

  Widget _buildCreateScenarioCard(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: InkWell(
        onTap: () async {
          final newScenario = await CustomScenarioDialog.show(context);
          if (newScenario != null) {
            await ref
                .read(savedScenariosProvider.notifier)
                .saveScenario(newScenario);
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E22) : const Color(0xFFFDFCF0),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFFFB300)
                  .withValues(alpha: isDark ? 0.35 : 0.4),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: (isDark ? Colors.black : const Color(0xFFFFB300))
                    .withValues(alpha: isDark ? 0.25 : 0.08),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFB300)
                      .withValues(alpha: isDark ? 0.2 : 0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: Color(0xFFFFB300),
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)?.createCustomScenario ??
                          'Create Custom Scenario',
                      style: TextStyle(
                        color: isDark ? Colors.white : const Color(0xFF1A1A1B),
                        fontSize: 15.5,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      AppLocalizations.of(context)?.designCustomAiRoleplay ??
                          'Design your own AI roleplay experience',
                      style: TextStyle(
                        color: isDark ? Colors.white54 : Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: isDark ? Colors.white38 : Colors.black38,
                size: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCreateFromDeckCard(bool isDark) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0, bottom: 8.0),
      child: InkWell(
        onTap: _generateFromDeck,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E22) : const Color(0xFFFDFCF0),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFBA68C8)
                  .withValues(alpha: isDark ? 0.35 : 0.4),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: (isDark ? Colors.black : const Color(0xFFBA68C8))
                    .withValues(alpha: isDark ? 0.25 : 0.08),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFBA68C8)
                      .withValues(alpha: isDark ? 0.2 : 0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.layers_rounded,
                  color: Color(0xFFBA68C8),
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)?.generateFromDeck ??
                          'Generate from Deck',
                      style: TextStyle(
                        color: isDark ? Colors.white : const Color(0xFF1A1A1B),
                        fontSize: 15.5,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      AppLocalizations.of(context)
                              ?.practiceFlashcardVocabulary ??
                          'Practice flashcard vocabulary in a live dialogue',
                      style: TextStyle(
                        color: isDark ? Colors.white54 : Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: isDark ? Colors.white38 : Colors.black38,
                size: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScenarioCard(ConversationScenario scenario, bool isDark) {
    final gradientColors =
        _getScenarioGradient(scenario.id, scenario.targetHskLevel);
    final sealText = _getScenarioSealText(scenario);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: InkWell(
        onTap: () => _showScenarioDetailSheet(scenario),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF222224) : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.08)
                  : Colors.black.withValues(alpha: 0.06),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.06),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── AI Persona Hero Portrait Header ───────────────────
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(19)),
                child: Container(
                  height: 125,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: gradientColors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Background Environment Artwork (subtle overlay)
                      if (scenario.backgroundAssetPath != null &&
                          scenario.backgroundAssetPath!.isNotEmpty)
                        Opacity(
                          opacity: 0.22,
                          child: Image.asset(
                            scenario.backgroundAssetPath!,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const SizedBox(),
                          ),
                        ),

                      // Ambient Glow behind Avatar
                      Center(
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.4),
                                blurRadius: 16,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Prominent Hero Avatar
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(2.5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFFFFB300),
                              width: 2.0,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 34,
                            backgroundColor: isDark
                                ? const Color(0xFF2C2C2E)
                                : const Color(0xFFF0EAE1),
                            backgroundImage: scenario.hasAvatar
                                ? _getAvatarImage(
                                    scenario.resolvedAvatarAssetPath)
                                : null,
                            child: !scenario.hasAvatar
                                ? Text(
                                    scenario.personaName.isNotEmpty
                                        ? scenario.personaName[0]
                                        : (scenario.title.isNotEmpty
                                            ? scenario.title[0]
                                            : '悟'),
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFFFB300),
                                    ),
                                  )
                                : null,
                          ),
                        ),
                      ),

                      // Top Left Role Seal Capsule
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 2.5),
                          decoration: BoxDecoration(
                            color: const Color(0xFF9E2A2B),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: const Color(0xFFD4AF37)
                                  .withValues(alpha: 0.8),
                              width: 0.8,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.3),
                                blurRadius: 4,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Text(
                            sealText,
                            style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFFF8E7),
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),

                      // Top Right HSK Difficulty Badge
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 2.5),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.2),
                              width: 0.5,
                            ),
                          ),
                          child: Text(
                            scenario.targetHskLevel == 0
                                ? 'Native'
                                : 'HSK ${scenario.targetHskLevel}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9.5,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Persona Name, Context & Speech Bubble ───────────
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Persona Name (Hero)
                    Text(
                      scenario.personaName,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                        color: isDark ? Colors.white : const Color(0xFF1A1A1B),
                        letterSpacing: 0.2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),

                    // Scenario Topic / Context
                    Text(
                      scenario.title,
                      style: TextStyle(
                        color:
                            isDark ? Colors.white70 : const Color(0xFF555555),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),

                    // Opening Dialogue Speech Bubble
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 5),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.06)
                            : const Color(0xFFF7F4EA),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.06)
                              : const Color(0xFFE8E2D2),
                          width: 0.8,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.format_quote_rounded,
                            size: 13,
                            color: isDark
                                ? const Color(0xFFFFD54F)
                                : const Color(0xFF9E2A2B),
                          ),
                          const SizedBox(width: 3),
                          Expanded(
                            child: Text(
                              scenario.initialAiMessage,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: isDark
                                    ? const Color(0xFFFFE082)
                                    : const Color(0xFF6B1D1D),
                                height: 1.2,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Bottom Action Pill: Tap to Talk
                    Row(
                      children: [
                        const Icon(
                          Icons.graphic_eq_rounded,
                          size: 14,
                          color: Color(0xFFFFB300),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          AppLocalizations.of(context)?.tapToRoleplay ?? "Tap to roleplay",
                          style: TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? const Color(0xFFFFD54F)
                                : const Color(0xFFB8860B),
                          ),
                        ),
                        const Spacer(),
                        if (scenario.isCustom)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 1.5),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFB300)
                                  .withValues(alpha: isDark ? 0.2 : 0.12),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.customLabel,
                              style: const TextStyle(
                                fontSize: 8.5,
                                color: Color(0xFFFFB300),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryFilter(bool isDark) {
    final categories = [
      AppLocalizations.of(context)!.allLabel,
      'HSK 1',
      'HSK 2',
      'HSK 3',
      'HSK 4',
      'HSK 5',
      'HSK 6',
      AppLocalizations.of(context)!.customLabel
    ];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: categories.map((cat) {
            final isSelected = _selectedCategory == cat;
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ChoiceChip(
                label: Text(cat),
                selected: isSelected,
                onSelected: (val) {
                  if (val) setState(() => _selectedCategory = cat);
                },
                selectedColor: const Color(0xFFFFB300)
                    .withValues(alpha: isDark ? 0.25 : 0.15),
                labelStyle: TextStyle(
                  color: isSelected
                      ? (isDark
                          ? const Color(0xFFFFD54F)
                          : const Color(0xFF1A1A1B))
                      : (isDark ? Colors.white70 : Colors.black87),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 12.5,
                ),
                backgroundColor:
                    isDark ? const Color(0xFF242426) : Colors.white,
                side: BorderSide(
                  color: isSelected
                      ? const Color(0xFFFFB300).withValues(alpha: 0.6)
                      : (isDark ? Colors.white12 : Colors.black12),
                ),
                showCheckmark: false,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showScenarioDetailSheet(ConversationScenario scenario) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final savedScenarios = ref.read(savedScenariosProvider);
    final isBookmarked = savedScenarios.any((s) => s.id == scenario.id);

    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.7),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          border: Border(
              top: BorderSide(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.1)
                      : Colors.black.withValues(alpha: 0.1))),
        ),
        child: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                    color: isDark ? Colors.white24 : Colors.black12,
                    borderRadius: BorderRadius.circular(2))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(children: [
                CircleAvatar(
                    radius: 28,
                    backgroundImage: scenario.hasAvatar
                        ? _getAvatarImage(scenario.resolvedAvatarAssetPath)
                        : null,
                    backgroundColor: scenario.hasAvatar
                        ? Colors.transparent
                        : (isDark
                            ? const Color(0xFF2C2C2E)
                            : const Color(0xFFF0EAE1)),
                    child: !scenario.hasAvatar
                        ? Text(
                            scenario.personaName.isNotEmpty
                                ? scenario.personaName[0]
                                : (scenario.title.isNotEmpty
                                    ? scenario.title[0]
                                    : '悟'),
                            style: const TextStyle(
                                color: Color(0xFFFFB300),
                                fontSize: 20,
                                fontWeight: FontWeight.bold))
                        : null),
                const SizedBox(width: 16),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(scenario.title,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: isDark
                                  ? Colors.white
                                  : const Color(0xFF1A1A1B))),
                      const SizedBox(height: 2),
                      Text(scenario.personaName,
                          style: TextStyle(
                              fontSize: 14,
                              color: isDark ? Colors.white54 : Colors.black54)),
                    ])),
                Row(mainAxisSize: MainAxisSize.min, children: [
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                          color: Colors.indigo
                              .withValues(alpha: isDark ? 0.3 : 0.1),
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                          scenario.targetHskLevel == 0
                              ? 'Native'
                              : 'HSK ${scenario.targetHskLevel}',
                          style: const TextStyle(
                              color: Colors.indigo,
                              fontSize: 12,
                              fontWeight: FontWeight.bold))),
                  if (scenario.isCustom) ...[
                    const SizedBox(width: 8),
                    IconButton(
                        icon: const Icon(Icons.delete_outline, size: 20),
                        color: Colors.red.shade300,
                        onPressed: () async {
                          final confirm = await showDialog<bool>(
                              context: ctx,
                              builder: (ctx2) => AlertDialog(
                                    title: Text(AppLocalizations.of(context)!
                                        .deleteScenario),
                                    content: Text(AppLocalizations.of(context)!
                                        .areYouSure),
                                    actions: [
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(ctx2, false),
                                          child: Text(
                                              AppLocalizations.of(context)!
                                                  .cancelAction)),
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(ctx2, true),
                                          child: Text(
                                              AppLocalizations.of(context)!
                                                  .deleteLabel,
                                              style: const TextStyle(
                                                  color: Colors.red))),
                                    ],
                                  ));
                          if (confirm == true) {
                            await ref
                                .read(savedScenariosProvider.notifier)
                                .remove(scenario.id);
                            setState(() => _allScenarios
                                .removeWhere((s) => s.id == scenario.id));
                            if (ctx.mounted) Navigator.pop(ctx);
                          }
                        }),
                  ],
                ]),
              ]),
            ),
            const SizedBox(height: 12),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(scenario.description,
                    style: TextStyle(
                        fontSize: 15,
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.7)
                            : Colors.black.withValues(alpha: 0.6),
                        height: 1.4))),
            if (scenario.quests.isNotEmpty)
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Row(children: [
                          Icon(Icons.flag,
                              color: Colors.amber.shade700, size: 18),
                          const SizedBox(width: 8),
                          Text(AppLocalizations.of(context)!.objectivesTitle,
                              style: TextStyle(
                                  color: Colors.amber.shade700,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                  fontSize: 12))
                        ]),
                        const SizedBox(height: 10),
                        ...scenario.quests.map((q) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(
                                          top: 6, right: 10),
                                      width: 6,
                                      height: 6,
                                      decoration: BoxDecoration(
                                          color: isDark
                                              ? Colors.white54
                                              : Colors.black38,
                                          shape: BoxShape.circle)),
                                  Expanded(
                                      child: RegExp(r'[\u4e00-\u9fa5]')
                                              .hasMatch(q)
                                          ? TranslatedText(
                                              q,
                                              style: TextStyle(
                                                  color: isDark
                                                      ? Colors.white.withValues(
                                                          alpha: 0.7)
                                                      : Colors.black.withValues(
                                                          alpha: 0.6),
                                                  fontSize: 14,
                                                  height: 1.3),
                                            )
                                          : Text(
                                              q,
                                              style: TextStyle(
                                                  color: isDark
                                                      ? Colors.white.withValues(
                                                          alpha: 0.7)
                                                      : Colors.black.withValues(
                                                          alpha: 0.6),
                                                  fontSize: 14,
                                                  height: 1.3),
                                            )),
                                ]))),
                      ])),
            const SizedBox(height: 24),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(children: [
                  Expanded(
                      child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(ctx);
                      HapticsManager.medium();
                      _startScenario(context, scenario, true);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: theme.colorScheme.onPrimary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        elevation: 0),
                    icon: const Icon(Icons.mic, size: 22),
                    label: Text(AppLocalizations.of(context)!.voiceCall,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                  )),
                  const SizedBox(width: 12),
                  Expanded(
                      child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(ctx);
                      HapticsManager.light();
                      _startScenario(context, scenario, false);
                    },
                    style: OutlinedButton.styleFrom(
                        foregroundColor: isDark ? Colors.white : Colors.black87,
                        side: BorderSide(
                            color: isDark
                                ? Colors.white.withValues(alpha: 0.3)
                                : Colors.black.withValues(alpha: 0.2)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16))),
                    icon: const Icon(Icons.chat_bubble_outline, size: 22),
                    label: Text(AppLocalizations.of(context)!.textChat,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                  )),
                ])),
            const SizedBox(height: 12),
            TextButton.icon(
              onPressed: () {
                ref.read(savedScenariosProvider.notifier).toggle(scenario);
                if (ctx.mounted) Navigator.pop(ctx);
              },
              icon: Icon(isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  size: 20,
                  color: isBookmarked ? theme.colorScheme.primary : null),
              label: Text(isBookmarked
                  ? AppLocalizations.of(context)!.removeFromSaved
                  : AppLocalizations.of(context)!.saveScenario),
            ),
            const SizedBox(height: 16),
          ]),
        ),
      ),
    );
  }

  bool _isGenerating = false;

  (String, String) _pickAvatarAndVoice(String persona, String title) {
    final text = '$persona $title'.toLowerCase();
    if (text.contains('waiter') ||
        text.contains('restaurant') ||
        text.contains('food') ||
        text.contains('chef') ||
        text.contains('tea') ||
        text.contains('cafe') ||
        text.contains('cook') ||
        text.contains('dish')) {
      return ('assets/mascot/waiter_avatar.png', 'Fenrir');
    }
    if (text.contains('taxi') ||
        text.contains('driver') ||
        text.contains('traffic') ||
        text.contains('car') ||
        text.contains('train') ||
        text.contains('airport') ||
        text.contains('station')) {
      return ('assets/mascot/taxi_driver_avatar.png', 'Charon');
    }
    if (text.contains('market') ||
        text.contains('shop') ||
        text.contains('store') ||
        text.contains('vendor') ||
        text.contains('buy') ||
        text.contains('cloth') ||
        text.contains('seller') ||
        text.contains('price')) {
      return ('assets/mascot/market_vendor_avatar.png', 'Kore');
    }
    if (text.contains('doctor') ||
        text.contains('clinic') ||
        text.contains('hospital') ||
        text.contains('nurse') ||
        text.contains('health') ||
        text.contains('medicine') ||
        text.contains('fever')) {
      return ('assets/mascot/doctor_avatar.png', 'Aoede');
    }
    if (text.contains('job') ||
        text.contains('interview') ||
        text.contains('manager') ||
        text.contains('boss') ||
        text.contains('office') ||
        text.contains('company') ||
        text.contains('work')) {
      return ('assets/mascot/interviewer_avatar.png', 'Puck');
    }
    if (text.contains('guide') ||
        text.contains('tour') ||
        text.contains('museum') ||
        text.contains('park') ||
        text.contains('hike') ||
        text.contains('travel') ||
        text.contains('hotel')) {
      return ('assets/mascot/guide_avatar.png', 'Aoede');
    }
    return ('assets/mascot/friend_avatar.png', 'Aoede');
  }

  Future<void> _generateFromDeck({Deck? preselectedDeck}) async {
    final l10n = AppLocalizations.of(context)!;

    Deck? selectedDeck = preselectedDeck;

    if (selectedDeck == null) {
      final decks = ref.read(deckControllerProvider).valueOrNull ?? [];
      final deckNames = decks.map((d) => d.name).toList();

      final picked = await showDialog<String>(
        context: context,
        builder: (ctx) => SimpleDialog(
          title: Text(l10n.chooseADeck),
          children: deckNames
              .map((name) => SimpleDialogOption(
                    onPressed: () => Navigator.pop(ctx, name),
                    child: Text(name),
                  ))
              .toList(),
        ),
      );

      if (picked == null) return;
      selectedDeck = decks.firstWhere((d) => d.name == picked);
    }

    if (_isGenerating) return;
    setState(() => _isGenerating = true);

    try {
      final allCards = ref.read(flashcardControllerProvider).valueOrNull ?? [];
      final cards =
          allCards.where((c) => c.deckId == selectedDeck!.id).toList();

      final wordsList = cards.take(20).map((c) => c.hanzi).join('\n');

      final deck = selectedDeck;
      final hskMatch = RegExp(r'hsk(\d)').firstMatch(deck.id);
      final hskLevel = hskMatch != null ? int.parse(hskMatch.group(1)!) : 1;

      final prompt =
          '''You are a creative writer and immersive roleplay designer. Create a rich, 100% in-character Chinese conversational roleplay scenario based on these vocabulary words:
$wordsList

Requirements:
1. Scenario Title: A specific, clear English title that directly matches what is happening in the scene (e.g. "Dinner with Dad", "Ordering at a Chengdu Teahouse", "Buying Tea at the Market", "Meeting an Old Classmate").
2. Scenario Description: 2-3 sentences in English setting the exact fictional scene, who the persona is, and what situation you are in.
3. Persona Name: A realistic Chinese character name and title (e.g. "Mei Ling (美玲)", "Master Zhao (赵师傅)", "Auntie Chen (陈阿姨)", "Dr. Wang (王医生)").
4. In-Character Opening Line: An authentic in-character opening line in natural Chinese spoken directly to start the situation (e.g. "爸，今天晚饭你想吃点什么？" or "你好！欢迎光临，请问几位？").
   CRITICAL 4TH-WALL RULE: NEVER break character or the 4th wall! NEVER say "Ready to practice?", "Let's practice Chinese", "Are you ready?", or mention studying, language learning, lessons, or practicing. The persona must talk directly as a real person in that scenario.
5. Opening Line English Translation: English translation of that opening line.
6. 3 Quest Objectives in ENGLISH: 3 concrete, conversational goals in ENGLISH for the user to achieve in character (e.g. ["Discuss what to have for dinner", "Suggest watching a movie afterwards", "Ask if they would like tea"]). ALL 3 MUST be in English.
7. Detailed System Prompt: An immersive character prompt. MUST include: "You are {personaName}. Your ONLY role is {personaName}. Stay 100% in character as {personaName} in the situation: '{title}'. NEVER break character, never act like a chatbot or language teacher, never mention language learning or practicing Chinese. Respond naturally in spoken Mandarin suited for HSK $hskLevel. Keep responses concise (1-3 sentences) and conversational."

Respond ONLY in valid JSON format with NO markdown formatting:
{
  "title": "...",
  "description": "...",
  "personaName": "...",
  "initialAiMessage": "...",
  "initialEnglish": "...",
  "quests": ["...", "...", "..."],
  "systemPrompt": "..."
}''';

      final result = await ref.read(geminiServiceProvider).generateText(prompt);
      final generated = GeneratedScenarioData.parse(result);

      final (avatarPath, voice) = _pickAvatarAndVoice(
        generated.personaName,
        generated.title,
      );

      final initialChinese = generated.initialAiMessage;
      final initialEng = generated.initialEnglish;
      final initialPin = PinyinHelper.getPinyinE(initialChinese,
          separator: ' ', format: PinyinFormat.WITH_TONE_MARK);

      final scenario = ConversationScenario(
        id: 'deck-${deck.id}',
        title: generated.title,
        description: generated.description,
        initialAiMessage: initialChinese,
        initialEnglish: initialEng,
        initialPinyin: initialPin,
        systemPrompt: generated.systemPrompt,
        targetHskLevel: hskLevel,
        avatarAssetPath: 'none',
        personaName: generated.personaName,
        quests: generated.quests,
        deckId: deck.id,
        isCustom: true,
        voiceName: voice,
      );

      await ref.read(savedScenariosProvider.notifier).saveScenario(scenario);
      await _saveDeckScenario(scenario);
      if (!mounted) return;
      if (widget.deck != null && widget.showBackButton) {
        Navigator.of(context).pushReplacement(SwipeBackRoute(
            builder: (context) => ConversationScreen(scenario: scenario)));
      } else {
        _startScenario(context, scenario, false);
      }
    } catch (e) {
      if (!mounted) return;
      debugPrint('Failed to generate deck scenario: $e');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'We had trouble generating this scenario. Please try again.',
        ),
      ));
    } finally {
      if (mounted) {
        setState(() => _isGenerating = false);
      }
    }
  }

  void _startScenario(
      BuildContext context, ConversationScenario scenario, bool isVoice) {
    HapticsManager.medium();
    if (isVoice) {
      Navigator.of(context).push(SwipeBackRoute(
          builder: (context) => LiveCallScreen(scenario: scenario)));
    } else {
      Navigator.of(context).push(SwipeBackRoute(
          builder: (context) => ConversationScreen(scenario: scenario)));
    }
  }

  ImageProvider _getAvatarImage(String path) {
    if (path.startsWith('/') || path.contains(':\\\\')) {
      return FileImage(File(path));
    }
    return AssetImage(path);
  }
}
