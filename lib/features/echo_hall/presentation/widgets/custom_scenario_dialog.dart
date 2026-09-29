import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:hanzi_master/core/presentation/widgets/hanzi_text_field.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/features/echo_hall/domain/entities/scenario.dart';
import 'package:hanzi_master/core/services/haptics_manager.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/bouncing_button.dart';
import 'package:hanzi_master/shared/widgets/global_blurred_bottom_sheet.dart';
import 'package:hanzi_master/shared/widgets/loading_swap.dart';
import 'package:hanzi_master/shared/widgets/zen_toast.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:hanzi_master/features/echo_hall/domain/entities/localized_scenario_content.dart';
import 'package:hanzi_master/features/echo_hall/domain/entities/localized_persona_presets.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';

/// The scenario creator behind *Create Custom Scenario*.
///
/// Zen & Ink rules applied here (see `docs/UI_UX_STANDARDS.md`), so the creator
/// reads as the same surface family as the deck picker, the ambient soundscape
/// sheet and the book screens:
/// * One palette (`_InkPalette`), resolved from [AppTheme]: Cinnabar `#8B0000`
///   in light mode, Emperor's Gold in dark mode. The amber `#FFB300` seal tile,
///   the `#FFD54F`/`#B8860B` links and the amber difficulty pills are gone.
/// * Xuan-paper field fills with a hairline, radius 14 — the geometry the book
///   and deck screens use — instead of borderless black-tinted boxes.
/// * The primary action is the book-screen button family (Deep Carbon Ink in
///   light mode, Emperor's Gold in dark mode, elevation 0, radius 14) and swaps
///   its icon for a spinner with `LoadingSwap`, never a bare
///   `CircularProgressIndicator`.
/// * Confirmations are raised with `ZenToast`: a Material `SnackBar` renders
///   *behind* the modal barrier, so from inside this sheet it arrives dimmed and
///   half-covered.
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
      ZenToast.info(context, message);
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
    ZenToast.info(context, message);
  }

  Future<void> _createScenario() async {
    FocusScope.of(context).unfocus();
    FocusManager.instance.primaryFocus?.unfocus();

    final title = _titleController.text.trim();
    final locale = Localizations.localeOf(context);
    if (title.isEmpty) {
      ZenToast.error(context, AppLocalizations.of(context)!.pleaseEnterTopic);
      return;
    }

    HapticsManager.heavy();
    setState(() => _isLoading = true);

    try {
      final scenarioId = const Uuid().v4();
      final desc = _descController.text.trim();
      final prompt = _promptController.text.trim();
      final targetHsk = _hskLevels[_difficultyIndex];

      // Extract persona name if formatted as "Name (Title)" or similar. The
      // fallback is localized, because it is the name the persona wears in
      // Echo Hall.
      String personaName = AppLocalizations.of(context)!.aiCharacter;
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

      // The user writes this persona themselves, so it gets no portrait either:
      // borrowing one of the bundled mascot photos put a stock face on a
      // character the user invented. The picker is kept for its other half —
      // the voice, which still has to follow the persona's gender.
      final (_, String pickedVoice) =
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
        avatarAssetPath: ConversationScenario.noAvatar,
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
        ZenToast.error(
          context,
          '${AppLocalizations.of(context)!.errorPrefix}$e',
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
    final l10n = AppLocalizations.of(context)!;
    final ink = _InkPalette(context);
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
    final maxHeight = MediaQuery.sizeOf(context).height * 0.88;

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
                      // Header — seal tile, title, caption and the persona dice,
                      // in the same geometry as the deck picker's header.
                      _buildHeader(l10n, ink),
                      const SizedBox(height: 20),

                      // Topic
                      _buildSectionLabel(
                        ink: ink,
                        icon: Icons.lightbulb_outline,
                        label: l10n.scenarioTopic,
                        trailing: _buildInlineLink(
                          ink: ink,
                          label: l10n.surpriseMe2,
                          onTap: _randomizePersona,
                        ),
                      ),
                      _buildField(
                        ink: ink,
                        controller: _titleController,
                        hint: l10n.egWeddingReceptionTechInterview,
                      ),
                      const SizedBox(height: 20),

                      // Difficulty
                      _buildSectionLabel(
                        ink: ink,
                        icon: Icons.signal_cellular_alt_rounded,
                        label: l10n.targetDifficulty,
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

                      // Context / setting
                      _buildSectionLabel(
                        ink: ink,
                        icon: Icons.place_outlined,
                        label: l10n.contextSettingOptional,
                      ),
                      _buildField(
                        ink: ink,
                        controller: _descController,
                        hint: l10n.roleplayCreatorContextPlaceholder,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 20),

                      // AI persona
                      _buildSectionLabel(
                        ink: ink,
                        icon: Icons.psychology_alt_outlined,
                        label: l10n.aiCharacterPersonaOptional,
                        trailing: _buildInlineLink(
                          ink: ink,
                          label: l10n.rollCharacter2,
                          onTap: _randomizePersona,
                        ),
                      ),
                      _buildField(
                        ink: ink,
                        controller: _promptController,
                        hint: l10n.roleplayCreatorPersonaPlaceholder,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),

            // Primary action — the book-screen button family: Deep Carbon Ink in
            // light mode, Emperor's Gold in dark mode, flat, radius 14. The icon
            // cross-fades into the spinner so the label never shifts.
            SafeArea(
              bottom: true,
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _createScenario,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ink.isDark
                          ? Colors.amber.shade700
                          : AppTheme.carbonInkLight,
                      foregroundColor:
                          ink.isDark ? AppTheme.carbonInkLight : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LoadingSwap(
                          isLoading: _isLoading,
                          size: 20,
                          spinnerColor: ink.isDark
                              ? AppTheme.carbonInkLight
                              : Colors.white,
                          icon: const Icon(Icons.auto_awesome, size: 19),
                        ),
                        const SizedBox(width: 8),
                        // Flexible + ellipsis: Russian and Vietnamese labels are
                        // roughly twice the English width.
                        Flexible(
                          child: Text(
                            l10n.createScenario,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15.5,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.3,
                            ),
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
    final ink = _InkPalette(context);

    return Expanded(
      child: BouncingButton(
        onPressed: () {
          HapticsManager.selection();
          setState(() => _difficultyIndex = index);
        },
        child: AnimatedContainer(
          duration: ZenMotion.of(context, ZenMotion.swap),
          curve: ZenMotion.natural,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            // The selected difficulty wears the accent; the rest are cards on
            // paper, like the session-mode segments.
            color: isSelected
                ? ink.accent.withValues(alpha: ink.isDark ? 0.18 : 0.12)
                : ink.rowFill,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected ? ink.accent : ink.hairline,
              width: isSelected ? 1.3 : 1.0,
            ),
          ),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: isSelected ? ink.accent : ink.primaryText,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: TextStyle(fontSize: 11, color: ink.secondaryText),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Book-screen parity helpers ────────────────────────────────────────────
  // Shared with the deck picker, the reading sheets and the re-skinned session
  // screens, so every calligraphic surface speaks one vocabulary.

  /// Seal tile, title, caption and the persona dice — the header geometry of the
  /// deck picker, with the title left free to wrap for long locales.
  Widget _buildHeader(AppLocalizations l10n, _InkPalette ink) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: ink.glyphTile,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(Icons.auto_awesome, size: 22, color: ink.accent),
        ),
        const SizedBox(width: 12),
        // Expanded rather than a Spacer: Russian and Vietnamese expand these
        // strings to roughly twice the English width.
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.createYourScenario,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: ink.primaryText,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                l10n.designCustomAiRoleplay,
                style: TextStyle(
                  fontSize: 12,
                  height: 1.3,
                  color: ink.secondaryText,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        _buildInlineLink(
          ink: ink,
          label: l10n.random,
          icon: Icons.casino_rounded,
          onTap: _randomizePersona,
          outlined: true,
        ),
      ],
    );
  }

  /// Accent-icon section label with an optional inline action, matching the
  /// session screens' section headers.
  Widget _buildSectionLabel({
    required _InkPalette ink,
    required IconData icon,
    required String label,
    Widget? trailing,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, size: 18, color: ink.accent),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14.5,
                fontWeight: FontWeight.bold,
                color: ink.primaryText,
              ),
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: 8),
            trailing,
          ],
        ],
      ),
    );
  }

  /// Accent affordance: a gold-hairline chip ([outlined], for the header dice)
  /// or a bare accent label (the inline "Surprise me" / "Roll character").
  Widget _buildInlineLink({
    required _InkPalette ink,
    required String label,
    required VoidCallback onTap,
    IconData? icon,
    bool outlined = false,
  }) {
    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 15, color: ink.accent),
          const SizedBox(width: 5),
        ],
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: ink.accent,
          ),
        ),
      ],
    );

    if (!outlined) {
      return BouncingButton(onPressed: onTap, child: content);
    }

    return BouncingButton(
      onPressed: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: BoxDecoration(
          color: ink.isDark
              ? ink.accent.withValues(alpha: 0.08)
              : AppTheme.cardBgLight,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: ink.goldBorder.withValues(alpha: ink.isDark ? 0.7 : 0.55),
            width: 1.2,
          ),
        ),
        child: content,
      ),
    );
  }

  /// Xuan-paper field: parchment fill, hairline, radius 14 — the same input
  /// geometry as the book and deck screens.
  Widget _buildField({
    required _InkPalette ink,
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
  }) {
    OutlineInputBorder border(Color color, [double width = 1]) =>
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: color, width: width),
        );

    return HanziTextField(
      controller: controller,
      hintText: '',
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: ink.rowFill,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        border: border(ink.hairline),
        enabledBorder: border(ink.hairline),
        focusedBorder: border(ink.accent, 1.3),
      ),
    );
  }
}

/// The Zen & Ink palette for this sheet, resolved once per build.
///
/// Mirrors `DeckSelectionSheet._InkPalette` and the book-screen parity helpers
/// in `shadowing_studio_screen.dart`, so every calligraphic surface reads as one
/// surface family rather than a Material default.
class _InkPalette {
  final bool isDark;

  /// Cinnabar `#8B0000` in light mode, Emperor's Gold in dark mode.
  final Color accent;

  _InkPalette(BuildContext context)
      : isDark = Theme.of(context).brightness == Brightness.dark,
        accent = AppTheme.accentOf(context);

  Color get primaryText =>
      isDark ? AppTheme.carbonInkDark : AppTheme.carbonInkLight;

  Color get secondaryText => isDark ? Colors.white60 : const Color(0xFF6B655B);

  /// Emperor's Gold hairline, as used by every calligraphic surface.
  Color get goldBorder =>
      isDark ? Colors.amber.shade700 : const Color(0xFFD4AF37);

  Color get hairline => isDark
      ? Colors.white.withValues(alpha: 0.1)
      : Colors.black.withValues(alpha: 0.08);

  Color get rowFill =>
      isDark ? Colors.white.withValues(alpha: 0.04) : const Color(0xFFF7F3E9);

  Color get glyphTile => accent.withValues(alpha: isDark ? 0.18 : 0.1);
}
