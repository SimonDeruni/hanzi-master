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

import 'package:flutter/foundation.dart' show compute;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/providers.dart';
import 'package:hanzi_master/core/services/haptics_manager.dart';
import 'package:hanzi_master/core/services/localized_catalog_service.dart';
import 'package:hanzi_master/features/media/data/youtube_repository.dart';
import 'package:hanzi_master/features/media/domain/models/youtube_video.dart';
import 'package:hanzi_master/features/media/presentation/screens/smart_media_desk_screen.dart';
import 'package:hanzi_master/shared/routes/swipe_back_route.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';
import 'package:hanzi_master/features/exam/data/exam_builder.dart';
import 'package:hanzi_master/features/exam/data/exam_store.dart';
import 'package:hanzi_master/features/exam/domain/entities/exam_blueprint.dart';
import 'package:hanzi_master/features/exam/domain/entities/exam_paper.dart';
import 'package:hanzi_master/features/exam/presentation/screens/exam_screen.dart';
import 'package:hanzi_master/features/learner/data/learner_state_store.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/deck_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/deck_detail_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/tutor/data/exam_folder_builder.dart';
import 'package:hanzi_master/features/tutor/data/reading_pack_builder.dart';
import 'package:hanzi_master/features/tutor/data/tutor_service.dart';
import 'package:hanzi_master/features/tutor/domain/entities/tutor_make_result.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_mode.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/features/reading/data/repositories/story_repository.dart';
import 'package:hanzi_master/features/reading/presentation/providers/story_controller.dart';
import 'package:hanzi_master/features/reading/presentation/screens/story_reader_screen.dart';
import 'package:hanzi_master/shared/widgets/ai_consent_sheet.dart';
import 'package:hanzi_master/features/tutor/domain/entities/tutor_context.dart';
import 'package:hanzi_master/features/tutor/domain/entities/tutor_memory.dart';
import 'package:hanzi_master/features/tutor/domain/entities/tutor_reply.dart';
import 'package:hanzi_master/features/tutor/presentation/widgets/tutor_artefacts.dart';
import 'package:hanzi_master/features/tutor/presentation/widgets/tutor_reply_view.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/bouncing_button.dart';
import 'package:hanzi_master/shared/widgets/zen_filter_pill.dart';
import 'package:hanzi_master/shared/widgets/zen_loader.dart';

/// One exchange, kept for the session.
class _Turn {
  const _Turn({required this.question, this.reply, this.videos = const []});

  final String question;
  final TutorReply? reply;

  /// The video candidates handed to the model for *this* question, kept so a
  /// cited id can be resolved back into something playable.
  final List<YoutubeVideo> videos;

  YoutubeVideo? videoById(String id) =>
      videos.where((YoutubeVideo video) => video.id == id).firstOrNull;
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

  /// `assets/data/hsk1_strokes.json`, so a stroke lesson is not limited to the
  /// learner's own deck.
  Map<String, dynamic> _hsk1Strokes = const <String, dynamic>{};
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

  /// Everything the SHOW blocks build from, loaded once.
  ///
  /// Both maps are decoded **off the main thread**: the metadata catalogue is a
  /// megabyte, and decoding it inline stalled the frame that first shows the tutor.
  /// The stroke bundle is smaller but it is the same job, so it takes the same route.
  Future<void> _loadLocalData(String languageCode) async {
    try {
      final String metadataRaw =
          await rootBundle.loadString('assets/data/hanzi_metadata.json');
      // HSK 1 stroke outlines, so a stroke lesson works for a character the learner
      // has never saved — the level most learners start at.
      final String strokesRaw =
          await rootBundle.loadString('assets/data/hsk1_strokes.json');
      final Map<String, dynamic> radicals =
          await LocalizedCatalogService.getRadicals(languageCode);

      final Map<String, dynamic> metadata =
          await compute(_decodeJsonMap, metadataRaw);
      final Map<String, dynamic> strokes =
          await compute(_decodeJsonMap, strokesRaw);
      if (!mounted) return;
      setState(() {
        _metadata = metadata;
        _hsk1Strokes = strokes;
        _radicals = radicals;
      });
    } catch (error) {
      // Anatomy and stroke cards simply will not render; the rest of the tutor still
      // works, and a reply with no widget is still a reply.
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
        : summaries
            .where((TutorDeckSummary s) => s.id == referenceId)
            .firstOrNull;

    return TutorContext(
      interfaceLanguage: _languageCode ?? 'en',
      learnerLevel: _learnerLevel(cards),
      decks: summaries,
      // The record, as the model is allowed to see it: at most four short lines, and
      // only facts the app observed itself (§6.2).
      learnerLines: ref
          .watch(learnerStateProvider)
          .forPrompt(focusLimit: 2, mistakeLimit: 2),
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
        hsk1Strokes: _hsk1Strokes,
      );

  /// The level to tell the model about, inferred from the learner's own cards:
  /// the most common HSK level among the cards that have one.
  ///
  /// It is a heuristic, not a setting — the app has no stored "learner level" — so
  /// it is only offered when there is real evidence, and the prompt drops the line
  /// entirely otherwise. Guessing a level is worse than admitting none: it would
  /// change the vocabulary the tutor uses with nothing to support it.
  static const int _minCardsForLevel = 5;

  int? _learnerLevel(List<Flashcard> cards) {
    final Map<int, int> counts = <int, int>{};
    for (final Flashcard card in cards) {
      if (card.hskLevel > 0) {
        counts[card.hskLevel] = (counts[card.hskLevel] ?? 0) + 1;
      }
    }
    int? level;
    int best = 0;
    counts.forEach((int candidate, int count) {
      if (count > best) {
        best = count;
        level = candidate;
      }
    });
    return best >= _minCardsForLevel ? level : null;
  }

  /// The bounded residue of the conversation, for the model and for the offline
  /// composer. Built from the transcript the *app* keeps — see [TutorMemory] for
  /// why only this much travels.
  TutorMemory _memory(TutorContext context) => TutorMemory.from(
        _turns.map((_Turn turn) => TutorExchange(
              ask: turn.question,
              say: turn.reply?.say,
              artefacts: turn.reply?.artefacts ?? const <TutorArtefact>[],
            )),
        focusedDeckId: context.focusedDeck?.id,
      );

  Future<void> _send(String rawMessage) async {
    final String message = rawMessage.trim();
    if (message.isEmpty || _isAsking) return;
    final AppLocalizations l10n = AppLocalizations.of(context)!;

    // Assembled *before* this turn is added, so the memory is what the tutor knew
    // when the question was asked — and so the question is not in the prompt twice.
    final TutorContext tutorContext = _context();
    final TutorMemory memory = _memory(tutorContext);

    // Consent lives with the AI calls, before any request leaves the device.
    final bool consented = await AiConsentSheet.ensureConsent(context);
    if (!consented || !mounted) return;

    setState(() {
      _isAsking = true;
      _turns.add(_Turn(question: message));
    });
    _controller.clear();
    _scrollToBottom();

    // Fetched before the tutor is asked, so the model can only cite a video the
    // app has already resolved — and so the chip has something to open.
    final List<YoutubeVideo> videos = await _videoCandidates(message);
    if (!mounted) return;

    final TutorArtefactData data = _artefactData();
    final TutorReply reply = await ref.read(tutorServiceProvider).ask(
          message: message,
          context: tutorContext,
          // The answer, including the offline fallback, is written in the
          // learner's language.
          l10n: l10n,
          // The conversation as a bounded residue, never as a transcript: the
          // input cost of turn 50 is the cost of turn 2.
          memory: memory,
          // The characters the app can actually build a widget for. A reply that
          // names anything else loses that block and keeps the rest. This stays
          // out of the prompt on purpose — the prompt gets a shortlist, because
          // this set is the app's whole inventory (~9,600 characters).
          allowedHanzi: data.describableHanzi,
          // The ids the parser will accept a citation against. Without this the
          // envelope's video cites were dropped the moment they arrived, which is
          // why the tutor could never suggest something to watch.
          videoIds: videos.map((YoutubeVideo video) => video.id).toSet(),
        );

    if (!mounted) return;
    setState(() {
      _turns[_turns.length - 1] =
          _Turn(question: message, reply: reply, videos: videos);
      _isAsking = false;
    });
    _scrollToBottom();
  }

  /// How many videos the model is shown. Enough to choose from, few enough that
  /// the list stays a citation list rather than a corpus.
  static const int _maxVideoCandidates = 6;

  /// The teaching videos that may be cited for [message], or none.
  ///
  /// A failure here must never cost the learner an answer — the tutor still has
  /// its prose, its widgets and its decks — so anything that goes wrong yields no
  /// candidates and the reply simply carries no video chip.
  Future<List<YoutubeVideo>> _videoCandidates(String message) async {
    try {
      final List<YoutubeVideo> found = await ref
          .read(youtubeRepositoryProvider)
          .searchVideos(message, preferChineseCaptions: true);
      return found.take(_maxVideoCandidates).toList(growable: false);
    } catch (error) {
      debugPrint('Tutor video candidates unavailable: $error');
      return const <YoutubeVideo>[];
    }
  }

  /// Opens a cited video in the app's own YouTube player.
  ///
  /// The id resolves only against the candidates fetched for that same turn, so a
  /// citation can never send the learner somewhere the app did not already choose.
  void _openVideo(_Turn turn, String videoId) {
    final YoutubeVideo? video = turn.videoById(videoId);
    if (video == null) return;
    HapticsManager.medium();
    Navigator.of(context).push(
      SwipeBackPageRoute(
        builder: (BuildContext context) => SmartMediaDeskScreen(video: video),
      ),
    );
  }

  /// Opens the folder a `make` created, in the deck screen the rest of the app
  /// uses. Kept here rather than in the reply view, which owns no navigation.
  void _openDeck(String deckId) {
    final List<Deck> decks =
        ref.read(deckControllerProvider).valueOrNull ?? const <Deck>[];
    final Deck? deck =
        decks.where((Deck candidate) => candidate.id == deckId).firstOrNull;
    // Gone (deleted from another tab in the meantime): nothing to open, and no
    // error worth interrupting the learner for.
    if (deck == null) return;
    HapticsManager.light();
    Navigator.of(context).push(
      SwipeBackPageRoute(
        builder: (BuildContext context) => DeckDetailScreen(deck: deck),
      ),
    );
  }

  /// Executes a proposal. Called **only** from the confirm card's Create button.
  ///
  /// The kind decides who does the work: a folder is copied from the learner's own
  /// deck, a paper is assembled from the app's bundled vocabulary, a review sprint
  /// is gathered from what is due, and a reading pack is written once and cached.
  /// In every case the model chose *what*, and the app built it.
  Future<TutorMakeResult> _make(TutorMake make) async {
    switch (make.kind) {
      case TutorMakeKind.examPaper:
        return _makePaper(make);
      case TutorMakeKind.examFolder:
        final AppLocalizations l10n = AppLocalizations.of(context)!;
        final List<Flashcard> cards =
            ref.read(flashcardControllerProvider).valueOrNull ?? const [];
        return ExamFolderBuilder.create(
          make: make,
          sourceCards: cards,
          deckController: ref.read(deckControllerProvider.notifier),
          flashcardRepository: ref.read(flashcardRepositoryProvider),
          // Named in the learner's language, the way the AI deck generator names
          // its own: the deck it came from plus what it is.
          name: l10n.tutorQuizFolderName(make.title ?? l10n.deck),
          description: l10n.generatedByAi,
        );
      case TutorMakeKind.readingPack:
        return _makeReadingPack(make);
      case TutorMakeKind.reviewSprint:
        return _makeReviewSprint(make);
    }
  }

  /// Where a reading pack's story comes from, and where a paper's passage comes
  /// from: the device's story cache first, the model only when the cache is empty.
  StoryPackSource _storySource() => CachedStorySource(
        stories: ref.read(storyRepositoryProvider),
        gemini: ref.read(geminiServiceProvider),
      );

  /// A reading pack: the one `make` that asks the model to write something, so it
  /// asks for consent first.
  ///
  /// Everything after the story is the app's own work — which words become
  /// questions, which words are the options, and what the answer is — so a pack can
  /// be sat on a plane once the story is on the device.
  Future<TutorMakeResult> _makeReadingPack(TutorMake make) async {
    final bool consented = await AiConsentSheet.ensureConsent(context);
    if (!consented) return const TutorMakeResult.failed();

    return ReadingPackBuilder.create(
      make: make,
      source: _storySource(),
      exams: ref.read(examStoreProvider),
    );
  }

  /// Today's cards, in a folder of their own.
  ///
  /// Nothing is chosen here: the app already knows which cards are due, so this is
  /// the one proposal whose content the model cannot influence at all — it can only
  /// notice that the learner wants one.
  Future<TutorMakeResult> _makeReviewSprint(TutorMake make) async {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final List<Flashcard> cards =
        ref.read(flashcardControllerProvider).valueOrNull ??
            const <Flashcard>[];

    final List<Flashcard> due = cards
        .where((Flashcard card) => card.isDue(StudyMode.reading))
        .toList()
      ..sort((Flashcard a, Flashcard b) => a
          .getStatsForMode(StudyMode.reading)
          .nextReviewDate
          .compareTo(b.getStatsForMode(StudyMode.reading).nextReviewDate));
    // Nothing due is its own answer, and a better one than an empty folder.
    if (due.isEmpty) return const TutorMakeResult.nothingDue();

    return ExamFolderBuilder.createFromCards(
      cards: due.take(make.items).toList(),
      name: l10n.tutorReviewSprint,
      description: l10n.generatedByAi,
      deckController: ref.read(deckControllerProvider.notifier),
      flashcardRepository: ref.read(flashcardRepositoryProvider),
    );
  }

  /// Opens a reading pack's story out of the cache the pack wrote it to — the same
  /// story the library shows, so this needs no network at all.
  void _openStory(String blueprintId, int level) {
    final StoryBlueprint? blueprint = StoryController.defaultBlueprints
        .where((StoryBlueprint candidate) => candidate.id == blueprintId)
        .firstOrNull;
    if (blueprint == null) return;
    HapticsManager.light();
    Navigator.of(context).push(
      SwipeBackPageRoute(
        builder: (BuildContext context) =>
            StoryReaderScreen(blueprint: blueprint, hskLevel: level),
      ),
    );
  }

  /// Builds a paper for the source the model asked for, and saves it with its key.
  ///
  /// Two sources, one examiner: a **deck** the learner already studies (their
  /// vocabulary, their cards) or the **bundled HSK vocabulary** for a level. In
  /// both cases everything except the choice is the app's — the blueprint, the
  /// items, the distractors and the answer key — so there is no generated answer
  /// that could be wrong in an exam (§11.3).
  Future<TutorMakeResult> _makePaper(TutorMake make) async {
    final AppLocalizations l10n = AppLocalizations.of(context)!;

    final String? deckId = make.deckId;
    if (deckId != null) {
      final List<Flashcard> cards =
          (ref.read(flashcardControllerProvider).valueOrNull ??
                  const <Flashcard>[])
              .where((Flashcard card) => card.deckId == deckId)
              .toList();
      final ExamPaper? fromDeck =
          ExamBuilder.buildFromCards(cards: cards, deckName: make.title);
      // Too small for a paper at all: the app's existing answer for that, rather
      // than a sitting with nothing in it.
      if (fromDeck == null) {
        return TutorMakeResult.notEnoughCards(cards.length);
      }

      await ref.read(examStoreProvider).savePaper(fromDeck);
      return TutorMakeResult.createdPaper(
        paperId: fromDeck.id,
        title: fromDeck.deckName ?? l10n.deck,
        itemCount: fromDeck.totalItems,
      );
    }

    final int? level = make.level;
    final ExamBlueprint? blueprint =
        level == null ? null : ExamBlueprint.forLevel(level);
    if (blueprint == null) return const TutorMakeResult.failed();

    final ExamPaper? paper = await ExamBuilder.build(
      blueprint: blueprint,
      // A story the learner already has at this level becomes the paper's passage,
      // so its gap-fill items are asked about something they can read rather than
      // about example sentences joined together. No story, no passage — and the
      // paper simply has no passage items, exactly as before.
      passage: await ReadingPackBuilder.passageFor(
        level: blueprint.level,
        source: _storySource(),
      ),
    );
    if (paper == null) return const TutorMakeResult.failed();

    await ref.read(examStoreProvider).savePaper(paper);
    return TutorMakeResult.createdPaper(
      paperId: paper.id,
      title: l10n.examTitle(paper.level),
      itemCount: paper.totalItems,
    );
  }

  /// Opens a paper the tutor created, from the store it was saved into.
  Future<void> _openPaper(String paperId) async {
    final ExamPaper? paper = await ref.read(examStoreProvider).paper(paperId);
    if (paper == null || !mounted) return;
    HapticsManager.light();
    Navigator.of(context).push(
      SwipeBackPageRoute(
        builder: (BuildContext context) => ExamScreen(paper: paper),
      ),
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
                  // The reply replaces the loader, so it eases in rather than
                  // snapping (UI_UX_STANDARDS: "fade result content in").
                  child: ZenFadeIn(
                    child: TutorReplyView(
                      reply: reply,
                      data: data,
                      onMake: _make,
                      onAskOption: (TutorAskOption option) {
                        // Answering the tutor's own question. A deck option
                        // attaches the deck and re-asks the same thing; any other
                        // option (a level, say) *is* the follow-up message.
                        final List<Deck> decks =
                            ref.read(deckControllerProvider).valueOrNull ??
                                const <Deck>[];
                        if (decks.any((Deck deck) => deck.id == option.value)) {
                          setState(() => _deckReferenceId = option.value);
                          _send(turn.question);
                          return;
                        }
                        _send(option.value);
                      },
                      onOpenDeck: _openDeck,
                      onOpenPaper: _openPaper,
                      onOpenStory: _openStory,
                      onOpenVideo: (String id) => _openVideo(turn, id),
                    ),
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
      // The same cap the app's other chat bubbles use, and a fraction of the
      // viewport rather than a pixel width: a question in Russian or Thai must
      // not fix the bubble at English size.
      constraints: BoxConstraints(
        maxWidth: MediaQuery.sizeOf(context).width * 0.78,
      ),
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
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
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

/// Decodes one of the bundled catalogues off the main thread.
///
/// `compute` needs a top-level function, and this is worth an isolate: the metadata
/// catalogue is a megabyte, and decoding it inline stalled the frame that first shows
/// the tutor — the jank this screen used to ship with.
Map<String, dynamic> _decodeJsonMap(String raw) =>
    (json.decode(raw) as Map).cast<String, dynamic>();
