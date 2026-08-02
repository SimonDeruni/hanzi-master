import 'package:hanzi_master/l10n/app_localizations.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/echo_hall/domain/entities/scenario.dart';
import 'package:hanzi_master/core/presentation/widgets/hanzi_text_field.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/core/services/api_key_pool.dart';

class CustomScenarioDialog extends ConsumerStatefulWidget {
  const CustomScenarioDialog({super.key});

  static Future<ConversationScenario?> show(BuildContext context) {
    return showDialog<ConversationScenario>(
      context: context,
      barrierDismissible: false,
      builder: (context) => const CustomScenarioDialog(),
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
  int _hskLevel = 3;
  bool _isLoading = false;
  String _loadingText = "Generating scenario...";

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _promptController.dispose();
    super.dispose();
  }

  Future<void> _generateAndReturn() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() {
      _isLoading = true;
      _loadingText = "Crafting Scenario...";
    });

    try {
      final scenarioId = const Uuid().v4();
      
      final scenario = ConversationScenario(
        id: scenarioId,
        title: _titleController.text,
        description: _descController.text,
        initialAiMessage: "你好！我们可以开始对话了。",
        initialEnglish: null,
        initialPinyin: null,
        systemPrompt: _promptController.text,
        targetHskLevel: _hskLevel,
        avatarAssetPath: 'none',
        backgroundAudioPath: null,
        isCustom: true,
      );

      if (mounted) {
        Navigator.pop(context, scenario);
      }
    } catch (e) {
      debugPrint("Error generating scenario: $e");
      setState(() {
        _isLoading = false;
        _loadingText = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1A1A1B).withValues(alpha: 0.85) : const Color(0xFFFDFCF0).withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: isDark ? Colors.white.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.05),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: _isLoading
                ? _buildLoadingState(theme)
                : _buildForm(theme, isDark),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState(ThemeData theme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 24),
        SizedBox(
          height: 60,
          width: 60,
          child: CircularProgressIndicator(
            color: theme.colorScheme.primary,
            strokeWidth: 3,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          _loadingText,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildForm(ThemeData theme, bool isDark) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppLocalizations.of(context)?.createYourScenario ?? "Create Scenario",
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w900,
                fontFamily: 'NotoSerifSC',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            HanziTextField(
              controller: _titleController,
              hintText: '',
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)?.customScenarioTitleHint ?? "Title",
                filled: true,
                fillColor: isDark ? Colors.black26 : Colors.white54,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (v) => v == null || v.isEmpty ? "Required" : null,
            ),
            const SizedBox(height: 16),
            HanziTextField(
              controller: _descController,
              hintText: '',
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)?.customScenarioDescHint ?? "Context/Setting",
                filled: true,
                fillColor: isDark ? Colors.black26 : Colors.white54,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
              maxLines: 2,
              validator: (v) => v == null || v.isEmpty ? "Required" : null,
            ),
            const SizedBox(height: 16),
            HanziTextField(
              controller: _promptController,
              hintText: '',
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)?.customScenarioPersonaHint ?? "Persona Instructions",
                filled: true,
                fillColor: isDark ? Colors.black26 : Colors.white54,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
              maxLines: 3,
              validator: (v) => v == null || v.isEmpty ? "Required" : null,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)?.difficulty ?? "Difficulty",
                  style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.black26 : Colors.white54,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      value: _hskLevel,
                      icon: const Icon(Icons.arrow_drop_down, size: 20),
                      items: [
                        ...List.generate(6, (i) => i + 1).map((i) => DropdownMenuItem(value: i, child: Text("HSK $i", style: const TextStyle(fontWeight: FontWeight.bold)))),
                        const DropdownMenuItem(value: 7, child: Text("Native", style: TextStyle(fontWeight: FontWeight.bold))),
                      ],
                      onChanged: (v) => setState(() => _hskLevel = v ?? 3),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: Text(AppLocalizations.of(context)?.cancel ?? "Cancel", style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _generateAndReturn,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: Text(AppLocalizations.of(context)?.create ?? "Create", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
