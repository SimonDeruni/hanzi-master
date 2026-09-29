import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/translation_language_provider.dart';
import '../services/local_translation_service.dart';

class TranslatedText extends ConsumerStatefulWidget {
  final String text;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool showOriginalOnLoading;
  final String? placeholder;

  /// The already-known English rendering of [text], when the caller has one.
  ///
  /// Book chapters ship a per-sentence `english` field, and the reader used to
  /// print it unconditionally - so a German or Japanese reader was handed the
  /// hard-coded English and the translator was never consulted, because the
  /// `TranslatedText` branch only ran when that field was *empty*. Passing the
  /// field here instead gives the widget both halves of the decision:
  ///
  /// * when the target language **is** English it renders this string and never
  ///   calls the translator - there is nothing to translate and nothing to pay
  ///   for;
  /// * for every other target language it is shown while the translation is in
  ///   flight, so the line never blanks out and never shows the wrong language.
  final String? englishFallback;

  const TranslatedText(
    this.text, {
    super.key,
    this.style,
    this.maxLines,
    this.overflow,
    this.showOriginalOnLoading = false,
    this.placeholder,
    this.englishFallback,
  });

  @override
  ConsumerState<TranslatedText> createState() => _TranslatedTextState();
}

class _TranslatedTextState extends ConsumerState<TranslatedText> {
  String? _translatedText;
  bool _isLoading = true;

  /// The language [_translatedText] belongs to. Kept so the widget can notice a
  /// language change: it used to translate once and keep that result forever,
  /// so switching the app language left the previous translation on screen.
  String? _translatedFor;

  @override
  void initState() {
    super.initState();
    _translatedFor = ref.read(translationLanguageProvider);
    _translate();
  }

  @override
  void didUpdateWidget(TranslatedText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      _translatedText = null;
      _isLoading = true;
      _translate();
    }
  }

  Future<void> _translate() async {
    // An English target with a known English string is already the answer: the
    // chapter data carries it, so spending a request on it would be waste.
    final String? english = widget.englishFallback;
    if (english != null && english.isNotEmpty && _wantsEnglish) {
      if (mounted) {
        setState(() {
          _translatedText = english;
          _isLoading = false;
        });
      }
      return;
    }

    if (widget.text.isEmpty) {
      if (mounted) setState(() => _isLoading = false);
      return;
    }
    final translator = ref.read(localTranslationServiceProvider);
    final result = await translator.translate(widget.text);
    if (mounted) {
      setState(() {
        _translatedText = result;
        _isLoading = false;
      });
    }
  }

  bool get _wantsEnglish =>
      ref.read(translationLanguageProvider).toLowerCase() == 'english';

  @override
  Widget build(BuildContext context) {
    // A language change must produce that language, not the cached one.
    final String language = ref.watch(translationLanguageProvider);
    if (language != _translatedFor) {
      _translatedFor = language;
      _translatedText = null;
      _isLoading = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _translate();
      });
    }

    final String? fallback = widget.englishFallback;

    if (_isLoading && _translatedText == null) {
      final String? loadingText =
          widget.showOriginalOnLoading ? widget.text : fallback;
      if (loadingText != null) {
        return Text(
          loadingText,
          style: widget.style,
          maxLines: widget.maxLines,
          overflow: widget.overflow,
        );
      }
      return Text(
        widget.placeholder ?? '...',
        style: widget.style?.copyWith(
          color: widget.style?.color?.withValues(alpha: 0.45) ?? Colors.grey.withValues(alpha: 0.5),
        ),
        maxLines: widget.maxLines,
        overflow: widget.overflow,
      );
    }

    final displayText = _translatedText ??
        (widget.showOriginalOnLoading ? widget.text : null) ??
        fallback ??
        '';

    return Text(
      displayText,
      style: widget.style,
      maxLines: widget.maxLines,
      overflow: widget.overflow,
    );
  }
}
