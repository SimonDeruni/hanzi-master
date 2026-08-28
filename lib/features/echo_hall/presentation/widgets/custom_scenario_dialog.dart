import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:hanzi_master/core/presentation/widgets/hanzi_text_field.dart';
import 'package:hanzi_master/features/echo_hall/domain/entities/scenario.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/global_blurred_bottom_sheet.dart';

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

  final List<int> _hskLevels = [2, 4, 6, 7];

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _promptController.dispose();
    super.dispose();
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
                        ],
                      ),
                      const SizedBox(height: 28),

                      // Topic Field
                      const Text(
                        "Scenario Topic",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
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
                      const Text(
                        "AI Character / Persona (Optional)",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
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
