import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/flashcards/presentation/providers/settings_controller.dart';
import '../providers/translation_language_provider.dart';
import '../services/local_translation_service.dart';

/// Displays a canonical English definition in the user's selected app language.
///
/// The complete, untouched [definition] is sent for translation. The English
/// source remains visible while loading and after any translation failure.
class TranslatedDefinition extends ConsumerStatefulWidget {
  final String definition;
  final String? hanzi;
  final TextStyle? originalStyle;
  final TextStyle? translationStyle;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const TranslatedDefinition({
    super.key,
    required this.definition,
    this.hanzi,
    this.originalStyle,
    this.translationStyle,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  });

  @override
  ConsumerState<TranslatedDefinition> createState() =>
      _TranslatedDefinitionState();
}

class _TranslatedDefinitionState extends ConsumerState<TranslatedDefinition> {
  String? _translated;
  String? _requestKey;
  int _requestGeneration = 0;

  void _syncTranslation(String targetLanguage, bool useEnglishDefinitions) {
    final requestKey =
        '$targetLanguage\u0000$useEnglishDefinitions\u0000${widget.hanzi}\u0000${widget.definition}';
    if (_requestKey == requestKey) return;

    _requestKey = requestKey;
    _translated = null;
    final generation = ++_requestGeneration;

    if (useEnglishDefinitions ||
        targetLanguage.toLowerCase() == 'english' ||
        widget.definition.isEmpty) {
      return;
    }

    Future<void>.microtask(() async {
      try {
        final result = await ref
            .read(localTranslationServiceProvider)
            .translateEnglishDefinition(widget.definition, hanzi: widget.hanzi);
        if (!mounted || generation != _requestGeneration) return;
        setState(() {
          _translated = result == widget.definition ? null : result;
        });
      } catch (_) {
        // Keep displaying the canonical English definition on failure.
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final targetLanguage = ref.watch(translationLanguageProvider);
    final useEnglishDefinitions = ref.watch(
        settingsProvider.select((settings) => settings.useEnglishDefinitions));
    _syncTranslation(targetLanguage, useEnglishDefinitions);

    final displayedDefinition = _translated ?? widget.definition;
    final style = _translated == null
        ? widget.originalStyle
        : (widget.translationStyle ?? widget.originalStyle);

    return Text(
      displayedDefinition,
      style: style,
      textAlign: widget.textAlign,
      maxLines: widget.maxLines,
      overflow: widget.overflow,
    );
  }
}
