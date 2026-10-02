/// The tutor surface: ask something, get a stack of blocks back.
///
/// This is the first draft of `docs/AI_TUTOR_CONCEPT.md`, wired end to end:
///
///  * **The reference picker** is the deck strip at the top. Tapping a deck is how
///    a message says "…on *this* deck", which is what makes a request answerable
///    without the model guessing.
///  * **Everything a reply may touch is assembled here**: the learner's cards (for
///    stroke data), the bundled metadata (for anatomy) and the deck summaries the
///    model is allowed to name. That bundle *is* the grounding.
///  * **The one write path is `make`**, and it runs only from the confirm card.
library;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/providers.dart';
import 'package:hanzi_master/core/services/localized_catalog_service.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/deck_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/tutor/data/exam_folder_builder.dart';
import 'package:hanzi_master/features/tutor/data/tutor_service.dart';
import 'package:hanzi_master/features/tutor/domain/entities/tutor_context.dart';
import 'package:hanzi_master/features/tutor/domain/entities/tutor_reply.dart';
import 'package:hanzi_master/features/tutor/presentation/widgets/tutor_artefacts.dart';
import 'package:hanzi_master/features/tutor/presentation/widgets/tutor_reply_view.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/ai_consent_sheet.dart';
import 'package:hanzi_master/shared/widgets/bouncing_button.dart';
import 'package:hanzi_master/shared/widgets/zen_filter_pill.dart';
import 'package:hanzi_master/shared/widgets/zen_loader.dart';

/// One exchange, kept for the session.
class _Turn {
  const _Turn({required this.question, this.reply});

  final String question;
  final TutorReply? reply;
}

class TutorScreen extends ConsumerStatefulWidget {
  const TutorScreen({super.key, this.showBackButton = false});

  final bool showBackButton;

  @override
  ConsumerState<TutorScreen> createState() => _TutorScreenState();
}

class _TutorScreenState extends ConsumerState<TutorScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scroll = ScrollController();
  final List<_Turn> _turns = <_Turn>[];

  Map<String, dynamic> _metadata = const <String, dynamic>{};
  Map<String, dynamic> _radicals = const <String, dynamic>{};
  String? _languageCode;
  String? _deckReferenceId;
  bool _isAsking = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final String locale = Localizations.localeOf(context).languageCode;
    if (_languageCode == locale) return;
    _languageCode = locale;
    // Bundled once per language: the anatomy cards' names are localised.
    _loadLocalData(locale);
  }

  @override
  void dispose() {
    _controller.dispose();
    _scroll.dispose();
    super.dispose();
  }

  Future<void> _loadLocalData(String languageCode) async {
    try {
      final String raw =
          await rootBundle.loadString('assets/data/hanzi_metadata.json');
      final Map<String, dynamic> radicals =
          await LocalizedCatalogService.getRadicals(languageCode);
      if (!mounted) return;
      setState(() {
        _metadata = (json.decode(raw) as Map).cast<String, dynamic>();
        _radicals = radicals;
      });
    } catch (error) {
      // Anatomy cards simply will not render; the rest of the tutor still works.
      debugPrint('Tutor local data failed to load: $error');
    }
  }

  /// The bundle the model is allowed to see, plus the references attached to this
  /// message. Counts and samples, never a corpus.
  TutorContext _context() {
    final List<Deck> decks =
        ref.watch(deckControllerProvider).valueOrNull ?? const [];
    final List<Flashcard> cards =
        ref.watch(flashcardControllerProvider).valueOrNull ?? const [];

    final List<TutorDeckSummary> summaries = <TutorDeckSummary>[];
    for (final Deck deck in decks) {
      final List<Flashcard> deckCards =
          cards.where((Flashcard card) => card.deckId == deck.id).toList();
      summaries.add(TutorDeckSummary(
        id: deck.id,
        name: deck.localizedName(context),
        cardCount: deckCards.length,
        // "Due" here means never reviewed — the honest reading for an untouched
        // card, and it costs nothing to compute.
        dueCount:
            deckCards.where((Flashcard card) => card.modeStats.isEmpty).length,
        sampleHanzi: deckCards
            .where((Flashcard card) => card.hanzi.runes.length == 1)
            .take(8)
            .map((Flashcard card) => card.hanzi)
            .toList(),
      ));
    }

    final String? referenceId = _deckReferenceId;
    final TutorDeckSummary? referenced = referenceId == null
        ? null
        : summaries.where((TutorDeckSummary s) => s.id == referenceId).firstOrNull;

    return TutorContext(
      interfaceLanguage: _languageCode ?? 'en',
      decks: summaries,
      references: referenced == null
          ? const []
          : <TutorReference>[
              TutorReference(
                kind: TutorReferenceKind.deck,
                id: referenced.id,
                label: referenced.name,
              ),
            ],
    );
  }

  Map<String, Flashcard> get _cardsByHanzi {
    final List<Flashcard> cards =
        ref.watch(flashcardControllerProvider).valueOrNull ?? const [];
    return <String, Flashcard>{
      for (final Flashcard card in cards)
        if (card.hanzi.isNotEmpty) card.hanzi: card,
    };
  }

  TutorArtefactData _artefactData() => TutorArtefactData(
        cardsByHanzi: _cardsByHanzi,
        metadata: _metadata,
        radicals: _radicals,
      );

  Future<void> _send(String rawMessage) async {
    final String message = rawMessage.trim();
    if (message.isEmpty || _isAsking) return;

    // Consent lives with the AI calls, before any request leaves the device.
    final bool consented = await AiConsentSheet.ensureConsent(context);
    if (!consented || !mounted) return;

    setState(() {
      _isAsking = true;
      _turns.add(_Turn(question: message));
    });
    _controller.clear();
    _scrollToBottom();

    final TutorArtefactData data = _artefactData();
    final TutorReply reply = await ref.read(tutorServiceProvider).ask(
          message: message,
          context: _context(),
          // The characters the app can actually build a widget for. A reply that
          // names anything else loses that block and keeps the rest.
          allowedHanzi: data.describableHanzi,
        );

    if (!mounted) return;
    setState(() {
      _turns[_turns.length - 1] = _Turn(question: message, reply: reply);
      _isAsking = false;
    });
    _scrollToBottom();
  }

  /// Executes a proposal. Called **only** from the confirm card's Create button.
  Future<ExamFolderResult> _make(TutorMake make) async {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final List<Flashcard> cards =
        ref.read(flashcardControllerProvider).valueOrNull ?? const [];

    return ExamFolderBuilder.create(
      make: make,
      sourceCards: cards,
      deckController: ref.read(deckControllerProvider.notifier),
      flashcardRepository: ref.read(flashcardRepositoryProvider),
      // Data, not prose: the deck's own name plus the date.
      name: '${make.title ?? l10n.deck} · '
          '${DateTime.now().toIso8601String().substring(0, 10)}',
      description: l10n.generatedByAi,
    );
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scroll.hasClients) return;
      _scroll.animateTo(
        _scroll.position.maxScrollExtent,
        duration: ZenMotion.quick,
        curve: ZenMotion.natural,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final List<Deck> decks =
        ref.watch(deckControllerProvider).valueOrNull ?? const [];
    final TutorArtefactData data = _artefactData();

    return CalligraphyBackground(
      child: Column(
        children: [
          _deckStrip(decks, isDark),
          Expanded(child: _transcript(theme, l10n, data)),
          _composer(theme, l10n),
        ],
      ),
    );
  }

  /// The reference picker: tap a deck and the next message is *about* it.
  Widget _deckStrip(List<Deck> decks, bool isDark) {
    if (decks.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
      child: SizedBox(
        height: 40,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: decks.length,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (BuildContext context, int index) {
            final Deck deck = decks[index];
            return Center(
              child: ZenFilterPill(
                label: deck.localizedName(context),
                isSelected: _deckReferenceId == deck.id,
                isDark: isDark,
                onTap: () => setState(() => _deckReferenceId =
                    _deckReferenceId == deck.id ? null : deck.id),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _transcript(
    ThemeData theme,
    AppLocalizations l10n,
    TutorArtefactData data,
  ) {
    if (_turns.isEmpty) return _emptyState(theme, l10n);

    return ListView.builder(
      controller: _scroll,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      itemCount: _turns.length + (_isAsking ? 1 : 0),
      itemBuilder: (BuildContext context, int index) {
        if (index >= _turns.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Center(child: ZenLoader()),
          );
        }

        final _Turn turn = _turns[index];
        final TutorReply? reply = turn.reply;
        return Padding(
          padding: const EdgeInsets.only(bottom: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: _questionBubble(theme, turn.question),
              ),
              if (reply != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TutorReplyView(
                    reply: reply,
                    data: data,
                    onMake: _make,
                    onAskOption: (TutorAskOption option) {
                      // Answering the tutor's own question: attach the deck it
                      // offered, then ask the same thing again.
                      setState(() => _deckReferenceId = option.value);
                      _send(turn.question);
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _emptyState(ThemeData theme, AppLocalizations l10n) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.school_outlined,
              size: 40,
              color: theme.colorScheme.primary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.askTutor,
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _questionBubble(ThemeData theme, String question) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      constraints: const BoxConstraints(maxWidth: 280),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Text(question, style: theme.textTheme.bodyMedium),
    );
  }

  Widget _composer(ThemeData theme, AppLocalizations l10n) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.06),
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.cardTheme.color,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color:
                          theme.colorScheme.onSurface.withValues(alpha: 0.1),
                    ),
                  ),
                  child: TextField(
                    controller: _controller,
                    maxLines: 4,
                    minLines: 1,
                    textInputAction: TextInputAction.send,
                    onSubmitted: _send,
                    style: theme.textTheme.bodyMedium,
                    decoration: InputDecoration(
                      hintText: l10n.typeYourMessage,
                      hintStyle: theme.textTheme.bodyMedium?.copyWith(
                        color:
                            theme.colorScheme.onSurface.withValues(alpha: 0.4),
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              BouncingButton(
                onPressed: _isAsking ? null : () => _send(_controller.text),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.colorScheme.primary,
                  ),
                  child: Icon(
                    Icons.arrow_upward,
                    color: theme.colorScheme.onPrimary,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
