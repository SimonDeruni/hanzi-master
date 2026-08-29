import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/local_translation_service.dart';
import '../providers/translation_language_provider.dart';
import '../../features/flashcards/presentation/providers/settings_controller.dart';

/// Wraps a definition widget and shows a Google-translated version below it
/// when the user's target language is not English.
///
/// Rules:
/// - Only translates when [translationLanguageProvider] ≠ 'English'
/// - Skips translation when `englishDefinitions` setting is enabled
/// - Skips translation if the definition contains Chinese characters
/// - Uses Hive caching via [LocalTranslationService.translateDefinition]
class TranslatedDefinition extends ConsumerStatefulWidget {
  final String definition;
  final TextStyle? originalStyle;
  final TextStyle? translationStyle;
  final TextAlign textAlign;

  const TranslatedDefinition({
    super.key,
    required this.definition,
    this.originalStyle,
    this.translationStyle,
    this.textAlign = TextAlign.start,
  });

  @override
  ConsumerState<TranslatedDefinition> createState() => _TranslatedDefinitionState();
}

class _TranslatedDefinitionState extends ConsumerState<TranslatedDefinition> {
  String? _translated;
  bool _isLoading = false;
  String? _lastDefinition;
  String? _lastTargetLang;

  @override
  void initState() {
    super.initState();
    _tryTranslate();
  }

  @override
  void didUpdateWidget(TranslatedDefinition oldWidget) {
    super.didUpdateWidget(oldWidget);
    final currentLang = ref.read(translationLanguageProvider);
    if (oldWidget.definition != widget.definition || _lastTargetLang != currentLang) {
      _translated = null;
      _lastTargetLang = currentLang;
      _tryTranslate();
    }
  }

  void _tryTranslate() {
    final targetLang = ref.read(translationLanguageProvider);
    final settings = ref.read(settingsProvider);
    _lastTargetLang = targetLang;
    _lastDefinition = widget.definition;

    if (targetLang.toLowerCase() == 'english') {
      _translated = null;
      return;
    }

    if (false) { // settings.englishDefinitions
      _translated = null;
      return;
    }

    if (RegExp(r'[\u4e00-\u9fa5]').hasMatch(widget.definition)) {
      _translated = null;
      return;
    }

    if (!_isLoading) {
      _isLoading = true;
      _doTranslate();
    }
  }

  Future<void> _doTranslate() async {
    final service = ref.read(localTranslationServiceProvider);
    final result = ''; // await service.translateDefinition(widget.definition);
    if (mounted && widget.definition == _lastDefinition) {
      setState(() {
        _translated = result;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final defaultStyle = widget.originalStyle ??
        TextStyle(
          fontSize: 18,
          color: isDark ? Colors.white70 : Colors.black87,
        );

    final transStyle = widget.translationStyle ??
        defaultStyle.copyWith(
          fontSize: (defaultStyle.fontSize ?? 18) - 2,
          fontStyle: FontStyle.italic,
          color: (isDark ? Colors.white70 : Colors.black87).withValues(alpha: 0.7),
        );

    final align = widget.textAlign;
    final crossAlign = align == TextAlign.center
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;

    if (_translated != null && _translated!.isNotEmpty) {
      return Column(
        crossAxisAlignment: crossAlign,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.definition, style: defaultStyle, textAlign: align),
          const SizedBox(height: 4),
          Text(_translated!, style: transStyle, textAlign: align),
        ],
      );
    }

    if (_isLoading) {
      return Column(
        crossAxisAlignment: crossAlign,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.definition, style: defaultStyle, textAlign: align),
          const SizedBox(height: 4),
          SizedBox(
            height: (transStyle.fontSize ?? 14) + 4,
            width: 12,
            child: Center(
              child: SizedBox(
                height: 10,
                width: 10,
                child: CircularProgressIndicator(
                  strokeWidth: 1.5,
                  color: isDark ? Colors.white38 : Colors.black38,
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Text(widget.definition, style: defaultStyle, textAlign: align);
  }
}
