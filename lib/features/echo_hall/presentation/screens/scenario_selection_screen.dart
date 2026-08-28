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
import 'package:hanzi_master/core/presentation/widgets/hanzi_text_field.dart';

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
  late List<ConversationScenario> _allScenarios;
  String _selectedCategory = 'All';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  bool _autoLaunchHandled = false;

  List<ConversationScenario> get _filteredScenarios {
    var scenarios = _allScenarios;
    if (_selectedCategory != 'All') {
      if (_selectedCategory == 'HSK 1')
        scenarios = _allScenarios.where((s) => s.targetHskLevel == 1).toList();
      else if (_selectedCategory == 'HSK 2')
        scenarios = _allScenarios.where((s) => s.targetHskLevel == 2).toList();
      else if (_selectedCategory == 'HSK 3')
        scenarios = _allScenarios.where((s) => s.targetHskLevel == 3).toList();
      else if (_selectedCategory == 'HSK 4')
        scenarios = _allScenarios.where((s) => s.targetHskLevel == 4).toList();
      else if (_selectedCategory == 'HSK 5')
        scenarios = _allScenarios.where((s) => s.targetHskLevel == 5).toList();
      else if (_selectedCategory == 'HSK 6')
        scenarios = _allScenarios.where((s) => s.targetHskLevel == 6).toList();
      else if (_selectedCategory == 'Custom')
        scenarios = _allScenarios.where((s) => s.isCustom).toList();
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
  void initState() {
    super.initState();
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
        final scenario =
            ConversationScenario.fromJson(entry.value as Map<String, dynamic>);
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

  IconData _getScenarioIcon(ConversationScenario scenario) {
    final lower =
        scenario.title.toLowerCase() + ' ' + scenario.description.toLowerCase();
    if (lower.contains('restaurant') ||
        lower.contains('waiter') ||
        lower.contains('food') ||
        lower.contains('order')) return Icons.restaurant;
    if (lower.contains('doctor') ||
        lower.contains('clinic') ||
        lower.contains('hospital') ||
        lower.contains('medical')) return Icons.local_hospital;
    if (lower.contains('market') ||
        lower.contains('shop') ||
        lower.contains('store') ||
        lower.contains('vendor')) return Icons.store;
    if (lower.contains('interview') ||
        lower.contains('job') ||
        lower.contains('work')) return Icons.work;
    if (lower.contains('friend') ||
        lower.contains('meet') ||
        lower.contains('catch')) return Icons.people;
    if (lower.contains('taxi') ||
        lower.contains('driver') ||
        lower.contains('ride') ||
        lower.contains('transport')) return Icons.local_taxi;
    if (lower.contains('hotel') || lower.contains('reception'))
      return Icons.hotel;
    return Icons.theater_comedy;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final scenarios = _filteredScenarios;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(children: [
                if (widget.showBackButton)
                  IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () => Navigator.pop(context))
                else
                  const SizedBox(width: 48),
                const Spacer(),
                Text('Echo Hall',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: isDark ? Colors.white : const Color(0xFF1A1A1B),
                        letterSpacing: 1.0)),
                const Spacer(),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.add_circle_outline),
                  onSelected: (value) async {
                    if (value == 'custom') {
                      final newScenario =
                          await CustomScenarioDialog.show(context);
                      if (newScenario != null) {
                        await ref
                            .read(savedScenariosProvider.notifier)
                            .toggle(newScenario);
                        setState(() => _allScenarios.insert(0, newScenario));
                      }
                    } else if (value == 'deck') {
                      _generateFromDeck();
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                        value: 'custom',
                        child: Row(children: [
                          Icon(Icons.edit),
                          SizedBox(width: 8),
                          Text("AI Custom Scenario")
                        ])),
                    const PopupMenuItem(
                        value: 'deck',
                        child: Row(children: [
                          Icon(Icons.style),
                          SizedBox(width: 8),
                          Text("Generate from Deck")
                        ])),
                  ],
                ),
              ]),
            ),
          ),
          // Search bar
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: HanziTextField(
              controller: _searchController,
              hintText: 'Search scenarios...',
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.indigo),
                filled: true,
                fillColor: isDark ? const Color(0xFF2A2A2B) : Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none),
              ),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        setState(() => _searchQuery = '');
                      })
                  : null,
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),
          const SizedBox(height: 8),
          // Filter chips
          _buildCategoryFilter(isDark),
          const SizedBox(height: 12),
          // Grid content
          Expanded(
            child: scenarios.isEmpty
                ? Center(
                    child: Text("No scenarios found.",
                        style: TextStyle(
                            color: isDark ? Colors.white38 : Colors.black54,
                            fontSize: 16),
                        textAlign: TextAlign.center))
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 4, bottom: 24),
                    itemCount: (scenarios.length / 2).ceil() + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) return _buildCreateScenarioCard(isDark);
                      final rowIndex = index - 1;
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
                                      : const SizedBox()),
                              const SizedBox(width: 12),
                              Expanded(
                                  child: rightScenario != null
                                      ? _buildScenarioCard(
                                          rightScenario, isDark)
                                      : const SizedBox()),
                            ]),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreateScenarioCard(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: InkWell(
        onTap: () async {
          final newScenario = await CustomScenarioDialog.show(context);
          if (newScenario != null) {
            await ref.read(savedScenariosProvider.notifier).toggle(newScenario);
            setState(() => _allScenarios.insert(0, newScenario));
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: [Color(0xFF3F51B5), Color(0xFF5C6BC0)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                  color: Colors.indigo.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4))
            ],
          ),
          child: Row(children: [
            Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle),
                child: const Icon(Icons.auto_awesome,
                    color: Colors.white, size: 28)),
            const SizedBox(width: 16),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  const Text('Create Custom Scenario',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('Design your own AI roleplay experience',
                      style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 13)),
                ])),
            const Icon(Icons.arrow_forward_ios,
                color: Colors.white70, size: 18),
          ]),
        ),
      ),
    );
  }

  Widget _buildScenarioCard(ConversationScenario scenario, bool isDark) {
    final icon = _getScenarioIcon(scenario);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: InkWell(
        onTap: () => _showScenarioDetailSheet(scenario),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF2A2A2B) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : Colors.black.withValues(alpha: 0.06)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2))
            ],
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Colors.indigo.shade400,
                  Colors.indigo.shade700
                ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                child: Stack(fit: StackFit.expand, children: [
                  if (scenario.backgroundAssetPath != null &&
                      scenario.backgroundAssetPath!.isNotEmpty)
                    Image.asset(scenario.backgroundAssetPath!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const SizedBox()),
                  Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                        Colors.indigo.withValues(alpha: 0.6),
                        Colors.indigo.withValues(alpha: 0.9)
                      ]))),
                  Center(
                      child: Icon(icon,
                          color: Colors.white.withValues(alpha: 0.8),
                          size: 40)),
                  Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(6)),
                          child: Text(
                              scenario.targetHskLevel == 0
                                  ? 'Native'
                                  : 'HSK ${scenario.targetHskLevel}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold)))),
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(scenario.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: isDark
                                ? Colors.white
                                : const Color(0xFF1A1A1B)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 4),
                    Text(scenario.description,
                        style: TextStyle(
                            color: isDark
                                ? Colors.white.withValues(alpha: 0.5)
                                : Colors.black.withValues(alpha: 0.6),
                            fontSize: 12),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 8),
                    Row(children: [
                      Icon(Icons.person_outline,
                          size: 14,
                          color: isDark ? Colors.white38 : Colors.black38),
                      const SizedBox(width: 4),
                      Expanded(
                          child: Text(scenario.personaName,
                              style: TextStyle(
                                  fontSize: 11,
                                  color:
                                      isDark ? Colors.white38 : Colors.black38),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis)),
                      if (scenario.isCustom)
                        Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                                color: Colors.indigo
                                    .withValues(alpha: isDark ? 0.2 : 0.08),
                                borderRadius: BorderRadius.circular(4)),
                            child: const Text('Custom',
                                style: TextStyle(
                                    fontSize: 9,
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.bold))),
                    ]),
                  ]),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _buildCategoryFilter(bool isDark) {
    final categories = [
      'All',
      'HSK 1',
      'HSK 2',
      'HSK 3',
      'HSK 4',
      'HSK 5',
      'HSK 6',
      'Custom'
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
                selectedColor: Colors.indigo,
                labelStyle: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : (isDark ? Colors.white70 : Colors.black87)),
                backgroundColor:
                    isDark ? const Color(0xFF2A2A2B) : Colors.white,
                side: BorderSide(
                    color: isSelected
                        ? Colors.indigo
                        : (isDark ? Colors.white24 : Colors.black12)),
                showCheckmark: false,
              ),
            );
          }).toList())),
    );
  }

  void _showScenarioDetailSheet(ConversationScenario scenario) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final savedScenarios = ref.read(savedScenariosProvider);
    final isBookmarked = savedScenarios.any((s) => s.id == scenario.id);

    showModalBottomSheet(
      context: context,
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
                if (scenario.avatarAssetPath != 'none' &&
                    scenario.avatarAssetPath.isNotEmpty)
                  CircleAvatar(
                      radius: 28,
                      backgroundImage:
                          _getAvatarImage(scenario.avatarAssetPath),
                      backgroundColor: Colors.transparent)
                else
                  CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.indigo,
                      child: Text(
                          scenario.personaName.isNotEmpty
                              ? scenario.personaName[0].toUpperCase()
                              : '?',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold))),
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
                                    title: const Text("Delete Scenario"),
                                    content: const Text("Are you sure?"),
                                    actions: [
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(ctx2, false),
                                          child: const Text("Cancel")),
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(ctx2, true),
                                          child: const Text("Delete",
                                              style: TextStyle(
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
                          Text("OBJECTIVES",
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
                                      child: Text(q,
                                          style: TextStyle(
                                              color: isDark
                                                  ? Colors.white
                                                      .withValues(alpha: 0.7)
                                                  : Colors.black
                                                      .withValues(alpha: 0.6),
                                              fontSize: 14,
                                              height: 1.3))),
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
                    label: const Text("Voice Call",
                        style: TextStyle(
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
                    label: const Text("Text Chat",
                        style: TextStyle(
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
              label: Text(isBookmarked ? 'Remove from Saved' : 'Save Scenario'),
            ),
            const SizedBox(height: 16),
          ]),
        ),
      ),
    );
  }

  bool _isGenerating = false;

  Future<void> _generateFromDeck({Deck? preselectedDeck}) async {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

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

    setState(() => _isGenerating = true);

    try {
      final allCards = ref
          .read(flashcardControllerProvider)
          .valueOrNull ?? [];
      final cards = allCards
          .where((c) => c.deckId == selectedDeck!.id)
          .toList();

      final wordsList = cards.take(20).map((c) => c.hanzi).join('\n');

      final prompt =
          '''Create a conversational scenario in Chinese based on these vocabulary words:
$wordsList

Generate a scenario with:
1. scenario title (in English)
2. scenario description (2-3 sentences in English describing the situation)
3. persona name (Chinese name)
4. 2-3 quest objectives (in Chinese, conversational goals)

Respond ONLY in valid JSON:
{
  "title": "...",
  "description": "...",
  "personaName": "...",
  "quests": ["...", "..."]
}''';

      final result = await ref.read(geminiServiceProvider).generateText(prompt);
      final cleaned =
          result.replaceAll('```json', '').replaceAll('```', '').trim();
      final Map<String, dynamic> json = jsonDecode(cleaned);

      final deck = selectedDeck!;
      // Derive HSK level from deck id (e.g. 'hsk3' → 3, 'default' → 1)
      final hskMatch = RegExp(r'hsk(\d)').firstMatch(deck.id);
      final hskLevel = hskMatch != null ? int.parse(hskMatch.group(1)!) : 1;

      final scenario = ConversationScenario(
        id: 'deck-${deck.id}',
        title: json['title'] as String,
        description: json['description'] as String,
        initialAiMessage: '你好！准备好练习了吗？',
        initialEnglish: 'Hello! Ready to practice?',
        initialPinyin: 'Nǐ hǎo! Zhǔnbèi hǎo liànxí le ma?',
        systemPrompt:
            'You are ${json['personaName']}. Speak Chinese at HSK $hskLevel level.',
        targetHskLevel: hskLevel,
        avatarAssetPath: 'none',
        personaName: json['personaName'] as String,
        quests: List<String>.from(json['quests']),
        deckId: deck.id,
        isCustom: true,
      );

      await _saveDeckScenario(scenario);
      if (!mounted) return;
      _startScenario(context, scenario, false);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to generate scenario: $e')));
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
