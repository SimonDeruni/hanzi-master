import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:hanzi_master/core/presentation/widgets/hanzi_text_field.dart';
import 'package:hanzi_master/features/echo_hall/domain/entities/scenario.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/global_blurred_bottom_sheet.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:hanzi_master/features/echo_hall/domain/entities/localized_scenario_content.dart';
import 'package:hanzi_master/features/echo_hall/domain/entities/localized_persona_presets.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';


class CustomScenarioDialog extends ConsumerStatefulWidget {
  const CustomScenarioDialog({super.key});

  static Future<ConversationScenario?> show(BuildContext context) async {
    final result = await GlobalBlurredBottomSheet.show<ConversationScenario>(
      context,
      child: const CustomScenarioDialog(),
    );
    FocusManager.instance.primaryFocus?.unfocus();
    return result;
  }

  @override
  ConsumerState<CustomScenarioDialog> createState() =>
      _CustomScenarioDialogState();
}

class _CustomScenarioDialogState extends ConsumerState<CustomScenarioDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _promptController = TextEditingController();
  int _difficultyIndex =
      1; // 0: Beginner, 1: Intermediate, 2: Advanced, 3: Native
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

  Future<void> _randomizePersona() async {
    HapticsManager.selection();
    final locale = Localizations.localeOf(context);
    final basePresets = LocalizedPersonaPresets.getPresets(locale);
    int nextIndex;
    if (basePresets.length > 1) {
      do {
        nextIndex = Random().nextInt(basePresets.length);
      } while (nextIndex == _lastRandomIndex);
    } else {
      nextIndex = 0;
    }
    _lastRandomIndex = nextIndex;
    final basePreset = basePresets[nextIndex];

    // For English and French, resolution is instant (0ms)
    if (locale.languageCode == 'en' || locale.languageCode == 'fr') {
      final preset = await LocalizedPersonaPresets.resolvePreset(
        gemini: ref.read(geminiServiceProvider),
        basePreset: basePreset,
        locale: locale,
      );
      if (!mounted) return;
      setState(() {
        _titleController.text = preset.topic;
        _descController.text = preset.context;
        _promptController.text = preset.persona;
        _difficultyIndex = preset.difficultyIndex;
      });

      final personaSummary = preset.persona.split(',').first.trim();
      final message = LocalizedPersonaPresets.loadedMessage(
        locale,
        preset.topic,
        personaSummary,
      );
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: ZenMotion.toast,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // For other languages, show placeholder then resolve via free Gemini API
    setState(() {
      _titleController.text = basePreset.topic;
      _descController.text = basePreset.context;
      _promptController.text = basePreset.persona;
      _difficultyIndex = basePreset.difficultyIndex;
    });

    final gemini = ref.read(geminiServiceProvider);
    final translated = await LocalizedPersonaPresets.resolvePreset(
      gemini: gemini,
      basePreset: basePreset,
      locale: locale,
    );

    if (!mounted) return;
    setState(() {
      _titleController.text = translated.topic;
      _descController.text = translated.context;
      _promptController.text = translated.persona;
      _difficultyIndex = translated.difficultyIndex;
    });

    final personaSummary = translated.persona.split(',').first.trim();
    final message = LocalizedPersonaPresets.loadedMessage(
      locale,
      translated.topic,
      personaSummary,
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: ZenMotion.toast,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _createScenario() async {
    FocusScope.of(context).unfocus();
    FocusManager.instance.primaryFocus?.unfocus();

    final title = _titleController.text.trim();
    final locale = Localizations.localeOf(context);
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

      String initialAiMessage = "你好！欢迎来到这里，今天我们聊些什么呢？";
      String? initialEnglish =
          "Hello! Welcome here, what shall we chat about today?";
      String? initialPinyin =
          "Nǐ hǎo! Huānyíng lái dào zhèlǐ, jīntiān wǒmen liáo xiē shénme ne?";
      List<String> quests =
          LocalizedScenarioContent.customScenarioQuests(locale, title);

      try {
        final gemini = ref.read(geminiServiceProvider);
        final interfaceLanguage = LocalizedScenarioContent.languageName(
          locale,
        );
        final aiPrompt =
            '''You are a creative writer and immersive roleplay designer. Create a 100% in-character opening line and 3 $interfaceLanguage quest goals for a roleplay scenario:
Topic: $title
Context: $desc
Persona: $prompt
HSK Level: $targetHsk

CRITICAL 4TH-WALL RULE: The opening greeting must be 100% in-character dialogue spoken directly inside the fictional situation (e.g. asking what to order, greeting as a friend, starting an interview). NEVER break the 4th wall! NEVER say "Ready to practice?", "Let's practice Chinese", or mention studying, language learning, lessons, or practicing.

Respond ONLY in valid JSON format:
{
  "greeting": "in-character opening line in Chinese (1 natural sentence)",
  "greetingEnglish": "English translation",
  "greetingPinyin": "Pinyin with tone marks",
  "quests": ["Goal 1 in $interfaceLanguage", "Goal 2 in $interfaceLanguage", "Goal 3 in $interfaceLanguage"]
}''';
        final response = await gemini.generateText(aiPrompt);
        final clean =
            response.replaceAll('```json', '').replaceAll('```', '').trim();
        final map = jsonDecode(clean);
        if (map['greeting'] != null &&
            (map['greeting'] as String).trim().isNotEmpty) {
          initialAiMessage = (map['greeting'] as String).trim();
          initialEnglish = map['greetingEnglish'] as String?;
          initialPinyin = map['greetingPinyin'] as String?;
        }
        if (map['quests'] is List && (map['quests'] as List).isNotEmpty) {
          quests = List<String>.from(map['quests']);
        }
      } catch (e) {
        debugPrint("AI scenario enhancement fallback: $e");
      }

      if (initialPinyin == null || initialPinyin.isEmpty) {
        initialPinyin = PinyinHelper.getPinyinE(initialAiMessage,
            separator: ' ', format: PinyinFormat.WITH_TONE_MARK);
      }

      final (pickedAvatar, pickedVoice) =
          ConversationScenario.pickAvatarAndVoice(
        personaName,
        title,
        description: desc,
      );

      final scenario = ConversationScenario(
        id: scenarioId,
        title: title,
        description: desc.isNotEmpty ? desc : "Custom scenario: $title",
        initialAiMessage: initialAiMessage,
        initialEnglish: initialEnglish,
        initialPinyin: initialPinyin,
        systemPrompt: prompt.isNotEmpty
            ? "You are $personaName. Your ONLY role is $personaName. The user is practicing spoken Chinese in the scenario: $title. ${desc.isNotEmpty ? 'Setting: $desc.' : ''} Reply in natural Mandarin suited for HSK $targetHsk. NEVER break character, never act like a generic AI."
            : "You are $personaName. Your ONLY role is $personaName. The user is practicing spoken Chinese in the scenario: $title. Reply in natural Mandarin suited for HSK $targetHsk. NEVER break character.",
        targetHskLevel: targetHsk,
        avatarAssetPath: pickedAvatar,
        personaName: personaName,
        backgroundAudioPath: null,
        quests: quests,
        isCustom: true,
        voiceName: pickedVoice,
      );

      if (mounted) {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
        Navigator.pop(context, scenario);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${AppLocalizations.of(context)?.errorPrefix ?? "Error: "}$e',
            ),
          ),
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
    final l10n = AppLocalizations.of(context)!;
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
                                      AppLocalizations.of(context)!
                                          .createScenario,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  l10n.designCustomAiRoleplay,
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
                                    l10n.random,
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
                          Expanded(
                            child: Text(
                              l10n.scenarioTopic,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: _randomizePersona,
                            child: Text(
                              l10n.surpriseMe2,
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
                          hintText: AppLocalizations.of(context)!
                              .egWeddingReceptionTechInterview,
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
                      Text(
                        l10n.targetDifficulty,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          _buildDifficultySegment(0, l10n.beginner, "HSK 1-2"),
                          const SizedBox(width: 8),
                          _buildDifficultySegment(
                              1, l10n.intermediate, "HSK 3-4"),
                          const SizedBox(width: 8),
                          _buildDifficultySegment(2, l10n.advanced, "HSK 5-6"),
                          const SizedBox(width: 8),
                          _buildDifficultySegment(3, l10n.native, l10n.master),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Context / Setting Field
                      Text(
                        l10n.contextSettingOptional,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      HanziTextField(
                        controller: _descController,
                        hintText: '',
                        maxLines: 2,
                        decoration: InputDecoration(
                          hintText: l10n.roleplayCreatorContextPlaceholder,
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
                          Expanded(
                            child: Text(
                              l10n.aiCharacterPersonaOptional,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: _randomizePersona,
                            child: Text(
                              l10n.rollCharacter2,
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
                          hintText: l10n.roleplayCreatorPersonaPlaceholder,
                          filled: true,
                          fillColor: isDark
                              ? Colors.white.withValues(alpha: 0.05)
                              : Colors.black.withValues(alpha: 0.04),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: const Icon(Icons.psychology_alt_outlined),
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
                      foregroundColor:
                          isDark ? const Color(0xFF1A1A1B) : Colors.white,
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
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.auto_awesome, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                AppLocalizations.of(context)!.createScenario,
                                style: const TextStyle(
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
          duration: ZenMotion.of(context, ZenMotion.swap),
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
                      ? (isDark
                          ? const Color(0xFFFFD54F)
                          : const Color(0xFF1A1A1B))
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
                      ? (isDark
                          ? const Color(0xFFFFD54F)
                          : const Color(0xFF1A1A1B))
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
