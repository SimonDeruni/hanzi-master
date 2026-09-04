import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/flashcards/presentation/providers/settings_controller.dart';
import '../providers/translation_language_provider.dart';
import '../services/local_translation_service.dart';
import '../utils/definition_formatter.dart';

enum DefinitionPresentation { plain, fullDetail }

/// Displays a canonical English definition in the user's selected app language.
///
/// The complete, untouched [definition] is sent for translation. The English
/// source remains visible while loading and after any translation failure.
class TranslatedDefinition extends ConsumerStatefulWidget {
  final String definition;
  final String? definitionLanguage;
  final String? hanzi;
  final TextStyle? originalStyle;
  final TextStyle? translationStyle;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final DefinitionPresentation presentation;

  const TranslatedDefinition({
    super.key,
    required this.definition,
    this.definitionLanguage,
    this.hanzi,
    this.originalStyle,
    this.translationStyle,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.presentation = DefinitionPresentation.plain,
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
        '$targetLanguage\u0000$useEnglishDefinitions\u0000${widget.definitionLanguage}\u0000${widget.hanzi}\u0000${widget.definition}';
    if (_requestKey == requestKey) return;

    _requestKey = requestKey;
    _translated = null;
    final generation = ++_requestGeneration;

    if (useEnglishDefinitions ||
        targetLanguage.toLowerCase() == 'english' ||
        _sameLanguage(widget.definitionLanguage, targetLanguage) ||
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

  bool _sameLanguage(String? source, String target) {
    if (source == null || source.trim().isEmpty) return false;
    return source.trim().toLowerCase() == target.trim().toLowerCase();
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

    if (widget.presentation == DefinitionPresentation.fullDetail) {
      return _FullDetailDefinition(
        definition: displayedDefinition,
        style: style,
        textAlign: widget.textAlign,
      );
    }

    return Text(
      displayedDefinition,
      style: style,
      textAlign: widget.textAlign,
      maxLines: widget.maxLines,
      overflow: widget.overflow,
    );
  }
}

class _FullDetailDefinition extends StatefulWidget {
  const _FullDetailDefinition({
    required this.definition,
    required this.style,
    required this.textAlign,
  });

  final String definition;
  final TextStyle? style;
  final TextAlign textAlign;

  @override
  State<_FullDetailDefinition> createState() => _FullDetailDefinitionState();
}

class _FullDetailDefinitionState extends State<_FullDetailDefinition> {
  static const int _collapsedMeaningCount = 6;
  bool _expanded = false;

  @override
  void didUpdateWidget(covariant _FullDetailDefinition oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.definition != widget.definition) {
      _expanded = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final meanings = DefinitionFormatter.splitMeanings(widget.definition);
    if (meanings.length <= 1) {
      return Text(
        widget.definition,
        style: widget.style,
        textAlign: widget.textAlign,
      );
    }

    final visibleMeanings = _expanded
        ? meanings
        : meanings.take(_collapsedMeaningCount).toList(growable: false);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var index = 0; index < visibleMeanings.length; index++) ...[
          if (index > 0) const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 30,
                child: Text(
                  '${index + 1}',
                  textAlign: TextAlign.end,
                  style: widget.style?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .primary
                        .withValues(alpha: 0.75),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  visibleMeanings[index],
                  style: widget.style,
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ],
        if (meanings.length > _collapsedMeaningCount) ...[
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              key: const ValueKey('definition-expansion-button'),
              onPressed: () => setState(() => _expanded = !_expanded),
              child: Text(_expanded
                  ? _showFewerLabel(context)
                  : _showMoreLabel(
                      context, meanings.length - _collapsedMeaningCount)),
            ),
          ),
        ],
      ],
    );
  }

  String _showMoreLabel(BuildContext context, int count) {
    final locale = Localizations.localeOf(context).languageCode;
    const labels = {
      'de': '{count} weitere Bedeutungen anzeigen',
      'es': 'Mostrar {count} significados más',
      'fr': 'Afficher {count} sens de plus',
      'it': 'Mostra altri {count} significati',
      'ja': '他{count}件の意味を表示',
      'ko': '의미 {count}개 더 보기',
      'pt': 'Mostrar mais {count} significados',
      'zh': '显示另外 {count} 个释义',
    };
    return (labels[locale] ?? 'Show {count} more meanings')
        .replaceAll('{count}', '$count');
  }

  String _showFewerLabel(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    const labels = {
      'de': 'Weniger anzeigen',
      'es': 'Mostrar menos',
      'fr': 'Afficher moins',
      'it': 'Mostra meno',
      'ja': '表示を減らす',
      'ko': '간략히 보기',
      'pt': 'Mostrar menos',
      'zh': '收起',
    };
    return labels[locale] ?? 'Show fewer';
  }
}
