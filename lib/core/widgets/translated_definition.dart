import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/flashcards/presentation/providers/settings_controller.dart';
import '../providers/translation_language_provider.dart';
import '../services/local_translation_service.dart';
import '../utils/definition_formatter.dart';
import 'package:hanzi_master/shared/widgets/zen_expand.dart';

enum DefinitionPresentation { plain, fullDetail }

/// Displays a canonical English definition in the user's selected app language.
///
/// The complete, untouched [definition] is sent for translation. The English
/// source is hidden while loading to avoid flashing the wrong language, and is
/// shown only when translation fails.
class TranslatedDefinition extends ConsumerStatefulWidget {
  final String definition;
  final String? definitionLanguage;
  final String? hanzi;
  final Map<String, String> bundledTranslations;
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
    this.bundledTranslations = const {},
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
  bool _translationFailed = false;

  void _syncTranslation(String targetLanguage, bool useEnglishDefinitions) {
    final requestKey =
        '$targetLanguage\u0000$useEnglishDefinitions\u0000${widget.definitionLanguage}\u0000${widget.hanzi}\u0000${widget.definition}';
    if (_requestKey == requestKey) return;

    _requestKey = requestKey;
    _translated = null;
    _translationFailed = false;
    final generation = ++_requestGeneration;

    if (useEnglishDefinitions ||
        targetLanguage.toLowerCase() == 'english' ||
        widget.bundledTranslations.containsKey(targetLanguage.toLowerCase()) ||
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
          if (result == widget.definition) {
            _translationFailed = true;
          } else {
            _translated = result;
          }
        });
      } catch (_) {
        if (!mounted || generation != _requestGeneration) return;
        setState(() => _translationFailed = true);
      }
    });
  }

  static String _normalizeLanguage(String lang) {
    final cleaned = lang.trim().toLowerCase();
    const map = {
      'en': 'english',
      'english': 'english',
      'fr': 'french',
      'french': 'french',
      'es': 'spanish',
      'spanish': 'spanish',
      'de': 'german',
      'german': 'german',
      'it': 'italian',
      'italian': 'italian',
      'ja': 'japanese',
      'japanese': 'japanese',
      'ko': 'korean',
      'korean': 'korean',
      'pt': 'portuguese',
      'portuguese': 'portuguese',
      'ru': 'russian',
      'russian': 'russian',
      'hi': 'hindi',
      'hindi': 'hindi',
      'ar': 'arabic',
      'arabic': 'arabic',
      'id': 'indonesian',
      'indonesian': 'indonesian',
      'vi': 'vietnamese',
      'vietnamese': 'vietnamese',
      'th': 'thai',
      'thai': 'thai',
    };
    final prefix = cleaned.split(RegExp('[-_]')).first;
    return map[cleaned] ?? map[prefix] ?? cleaned;
  }

  bool _sameLanguage(String? source, String target) {
    if (source == null || source.trim().isEmpty) return false;
    return _normalizeLanguage(source) == _normalizeLanguage(target);
  }

  @override
  Widget build(BuildContext context) {
    final targetLanguage = ref.watch(translationLanguageProvider);
    final useEnglishDefinitions = ref.watch(
        settingsProvider.select((settings) => settings.useEnglishDefinitions));
    _syncTranslation(targetLanguage, useEnglishDefinitions);

    final bundledTranslation = useEnglishDefinitions
        ? null
        : widget.bundledTranslations[targetLanguage.toLowerCase()];
    final needsTranslation = !useEnglishDefinitions &&
        targetLanguage.toLowerCase() != 'english' &&
        bundledTranslation == null &&
        !_sameLanguage(widget.definitionLanguage, targetLanguage) &&
        widget.definition.isNotEmpty;
    if (needsTranslation && _translated == null && !_translationFailed) {
      return const SizedBox(height: 16);
    }

    final displayedDefinition =
        bundledTranslation ?? _translated ?? widget.definition;
    final isTranslated = bundledTranslation != null || _translated != null;
    final style = !isTranslated
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

    // ZenExpand eases the height change, so revealing more meanings grows the
    // list smoothly instead of jumping the rest of the screen.
    return ZenExpand(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var index = 0; index < visibleMeanings.length; index++) ...[
            if (index > 0) const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // A minimum width (never a fixed one) lets a wider locale or a
                // large system text scale grow the index while the Expanded
                // meaning beside it absorbs the difference.
                ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 30),
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
      ),
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
