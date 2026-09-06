import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/data/services/dictionary_expansion_service.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/dictionary_expansion_provider.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

enum DictionaryExpansionPresentation { compact, full }

class DictionaryExpansionPanel extends ConsumerStatefulWidget {
  final Flashcard card;
  final bool isDark;
  final bool autoExpand;
  final DictionaryExpansionPresentation presentation;

  const DictionaryExpansionPanel({
    super.key,
    required this.card,
    required this.isDark,
    this.autoExpand = false,
    this.presentation = DictionaryExpansionPresentation.compact,
  });

  static bool isAvailableFor(Flashcard card) =>
      card.isExpansionEligible &&
      card.dictionaryWordId != null &&
      card.sourceDefinitionHash != null &&
      card.definitionLanguage != null;

  @override
  ConsumerState<DictionaryExpansionPanel> createState() =>
      _DictionaryExpansionPanelState();
}

class _DictionaryExpansionPanelState
    extends ConsumerState<DictionaryExpansionPanel> {
  late final DictionaryExpansionRequest _request;
  bool _requested = false;
  bool _checkingCache = true;

  @override
  void initState() {
    super.initState();
    _request = DictionaryExpansionRequest(
      wordId: widget.card.dictionaryWordId!,
      languageCode: _languageCode(widget.card.definitionLanguage!),
      sourceDefinitionHash: widget.card.sourceDefinitionHash!,
    );
    _loadCachedExpansion();
  }

  Future<void> _loadCachedExpansion() async {
    final cached = await ref
        .read(dictionaryExpansionServiceProvider)
        .getCachedExpansion(_request);
    if (!mounted) return;
    setState(() {
      _requested = cached != null || widget.autoExpand;
      _checkingCache = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_checkingCache) return const SizedBox.shrink();

    if (!_requested) {
      return _panel(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _briefEntryLabel(Localizations.localeOf(context).languageCode),
              style: TextStyle(
                fontSize: 12,
                color: widget.isDark ? Colors.white70 : Colors.black54,
              ),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              key: const ValueKey('dictionary-expansion-button'),
              onPressed: () => setState(() => _requested = true),
              icon: const Icon(Icons.auto_awesome, size: 16),
              label: Text(
                _expandLabel(Localizations.localeOf(context).languageCode),
              ),
            ),
          ],
        ),
      );
    }

    final expansion = ref.watch(dictionaryExpansionProvider(_request));
    return expansion.when(
      loading: () => _panel(
        child: const LinearProgressIndicator(minHeight: 2),
      ),
      error: (error, _) => _panel(
        child: Row(
          children: [
            Expanded(
              child: Text(
                _errorLabel(
                  Localizations.localeOf(context).languageCode,
                  error,
                ),
                style: TextStyle(
                  fontSize: 12,
                  color: widget.isDark ? Colors.white70 : Colors.black54,
                ),
              ),
            ),
            TextButton(
              onPressed: () => ref.invalidate(
                dictionaryExpansionProvider(_request),
              ),
              child: Text(AppLocalizations.of(context)!.retry),
            ),
          ],
        ),
      ),
      data: (value) => _panel(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _provenanceLabel(Localizations.localeOf(context).languageCode),
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: widget.isDark ? Colors.white70 : Colors.indigo,
              ),
            ),
            const SizedBox(height: 5),
            DictionaryExpansionText(
              text: value.text,
              compact: widget.presentation ==
                  DictionaryExpansionPresentation.compact,
            ),
          ],
        ),
      ),
    );
  }

  Widget _panel({required Widget child}) => Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.indigo.withValues(alpha: widget.isDark ? 0.14 : 0.06),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.indigo.withValues(alpha: 0.18)),
        ),
        child: child,
      );

  String _languageCode(String language) {
    const codes = {
      'French': 'fr',
      'German': 'de',
      'Spanish': 'es',
      'Russian': 'ru',
      'Italian': 'it',
      'Portuguese': 'pt',
      'Japanese': 'ja',
      'Korean': 'ko',
      'Vietnamese': 'vi',
      'Indonesian': 'id',
      'Arabic': 'ar',
      'Hindi': 'hi',
      'Thai': 'th',
    };
    return codes[language] ?? language.toLowerCase();
  }

  String _provenanceLabel(String locale) {
    const labels = {
      'ar': 'تفاصيل موسعة بالذكاء الاصطناعي',
      'de': 'KI-erweiterter Wörterbucheintrag',
      'es': 'Detalle ampliado por IA',
      'fr': 'Détail enrichi par l’IA',
      'hi': 'AI द्वारा विस्तृत शब्दकोश विवरण',
      'id': 'Detail kamus yang diperluas AI',
      'it': 'Dettaglio del dizionario ampliato dall’IA',
      'ja': 'AIによる辞書の補足',
      'ko': 'AI로 확장된 사전 설명',
      'pt': 'Detalhe de dicionário expandido por IA',
      'ru': 'Расширенная ИИ словарная статья',
      'th': 'รายละเอียดพจนานุกรมที่ขยายโดย AI',
      'vi': 'Chi tiết từ điển được AI mở rộng',
      'zh': 'AI 扩展词典释义',
    };
    return labels[locale] ?? 'AI-expanded dictionary detail';
  }

  String _briefEntryLabel(String locale) {
    const labels = {
      'fr': 'Cette entrée est brève. Une explication détaillée est disponible.',
      'de':
          'Dieser Eintrag ist kurz. Eine ausführliche Erklärung ist verfügbar.',
      'es': 'Esta entrada es breve. Hay una explicación detallada disponible.',
      'it': 'Questa voce è breve. È disponibile una spiegazione dettagliata.',
      'pt': 'Esta entrada é breve. Está disponível uma explicação detalhada.',
    };
    return labels[locale] ??
        'This dictionary entry is brief. A detailed explanation is available.';
  }

  String _expandLabel(String locale) {
    const labels = {
      'fr': 'Développer en français',
      'de': 'Auf Deutsch erweitern',
      'es': 'Ampliar en español',
      'it': 'Approfondisci in italiano',
      'pt': 'Expandir em português',
      'ja': '詳しい説明を見る',
      'ko': '자세한 설명 보기',
    };
    return labels[locale] ?? 'Expand definition';
  }

  String _errorLabel(String locale, Object error) {
    final failure = error is DictionaryExpansionException
        ? error.failure
        : DictionaryExpansionFailure.unknown;
    if (failure == DictionaryExpansionFailure.signIn) {
      const labels = {
        'fr': 'Connectez-vous pour développer cette définition.',
        'de': 'Melde dich an, um diese Definition zu erweitern.',
        'es': 'Inicia sesión para ampliar esta definición.',
        'it': 'Accedi per ampliare questa definizione.',
        'pt': 'Entre para expandir esta definição.',
      };
      return labels[locale] ?? 'Sign in to expand this definition.';
    }
    if (failure == DictionaryExpansionFailure.quota) {
      const labels = {
        'fr': 'Limite quotidienne atteinte. Réessayez demain.',
        'de': 'Tageslimit erreicht. Versuche es morgen erneut.',
        'es': 'Límite diario alcanzado. Inténtalo mañana.',
      };
      return labels[locale] ?? 'Daily expansion limit reached. Try tomorrow.';
    }
    if (failure == DictionaryExpansionFailure.appVerification) {
      const labels = {
        'fr':
            'Impossible de vérifier cette installation. Réessayez après avoir redémarré l’app.',
        'de':
            'Diese Installation konnte nicht überprüft werden. Starte die App neu und versuche es erneut.',
        'es':
            'No se pudo verificar esta instalación. Reinicia la aplicación e inténtalo de nuevo.',
      };
      return labels[locale] ??
          'Unable to verify this installation. Restart the app and try again.';
    }
    if (failure == DictionaryExpansionFailure.notEligible ||
        failure == DictionaryExpansionFailure.staleSource) {
      const labels = {
        'fr':
            'Cette entrée doit être actualisée avant de pouvoir être développée.',
        'de': 'Dieser Eintrag muss vor der Erweiterung aktualisiert werden.',
        'es': 'Esta entrada debe actualizarse antes de ampliarla.',
      };
      return labels[locale] ??
          'This entry must be refreshed before it can be expanded.';
    }
    const labels = {
      'fr': 'Impossible de charger l’explication.',
      'de': 'Die Erklärung konnte nicht geladen werden.',
      'es': 'No se pudo cargar la explicación.',
      'it': 'Impossibile caricare la spiegazione.',
      'pt': 'Não foi possível carregar a explicação.',
    };
    return labels[locale] ?? 'Unable to load the explanation.';
  }
}

class DictionaryExpansionText extends StatefulWidget {
  final String text;
  final bool compact;

  const DictionaryExpansionText({
    super.key,
    required this.text,
    required this.compact,
  });

  @override
  State<DictionaryExpansionText> createState() =>
      _DictionaryExpansionTextState();
}

class _DictionaryExpansionTextState extends State<DictionaryExpansionText> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final shouldOfferExpansion = widget.compact && widget.text.length > 140;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          key: const ValueKey('dictionary-expansion-text'),
          maxLines: widget.compact && !_expanded ? 2 : null,
          overflow: widget.compact && !_expanded
              ? TextOverflow.ellipsis
              : TextOverflow.visible,
          style: const TextStyle(fontSize: 14, height: 1.4),
        ),
        if (shouldOfferExpansion)
          TextButton(
            key: const ValueKey('dictionary-expansion-toggle'),
            onPressed: () => setState(() => _expanded = !_expanded),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.only(top: 4),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(_expanded ? 'Show less' : 'Show more'),
          ),
      ],
    );
  }
}
