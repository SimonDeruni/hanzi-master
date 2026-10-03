/// The tutor's reply envelope — **structure, not prose we interpret**.
///
/// This is the contract from `docs/AI_TUTOR_CONCEPT.md` §4.1/§12: the model
/// chooses *blocks*, the app *builds* them from data it already owns. A reply is
/// therefore never a bare string:
///
///  * `say`   — prose, the only thing the model wrote itself
///  * `show`  — widgets the app renders from local data (see the artefact registry)
///  * `cite`  — pointers to things the learner already has (a deck, a downloaded
///              book, a video id) — the app resolves them, so an invented citation
///              cannot resolve and is dropped
///  * `make`  — a durable object the tutor *proposes* (never creates silently)
///  * `ask`   — a clarifying question, with tappable answers
///
/// Everything here is immutable and validated; nothing renders a `dynamic`.
library;

/// The widgets a tutor reply may show.
///
/// Adding one is: this enum + an args parser + a builder in the registry + a test.
/// An unknown name in a model reply is dropped, so this list may grow without
/// breaking old replies.
enum TutorArtefactType {
  /// Animated stroke order for a character.
  strokeOrder,

  /// The character's radical and components, each named and explained.
  characterAnatomy,

  /// The app's own examples of a character in use: the sentence the learner's card
  /// was saved with, and the context around it. Built from the library, so the
  /// examples are ones they have already met.
  exampleSet,

  /// A two-column comparison for a grammar point — 的 against 得, 了 against 过.
  ///
  /// The **explanation** is the model's, like prose is anywhere else in a reply, but
  /// the table is the app's: it checks every example against the characters it can
  /// actually describe, spells them with its own metadata, and drops the whole table
  /// if it does not check out. A grammar table the app cannot back is a grammar table
  /// the learner should not be shown (§4.3).
  contrastTable,
}

/// Where a citation points.
enum TutorCiteSource {
  /// One of the learner's own decks.
  deck,

  /// A book the app ships or the learner downloaded (cited by chapter/sentence).
  book,

  /// The app's dictionary.
  dictionary,

  /// A teaching video, played through the compliant YouTube path.
  video,
}

/// The durable object a reply may propose to create.
enum TutorMakeKind {
  /// A new folder of cards drawn from a deck the learner already has.
  examFolder,

  /// A timed practise paper in HSK scope, built by the app from bundled
  /// vocabulary. Deliberately *not* delegated to the model: §11.3 explains why a
  /// generated exam is worse than a generated card — a wrong key fails a learner
  /// who answered correctly. The model may propose it, the app assembles it.
  examPaper,

  /// A graded story at a level, plus questions built from that story's own words.
  ///
  /// The model chooses the **level** and nothing else: the story comes from a topic
  /// the app already ships, is written once and cached on the device, and every
  /// question is derived from the text that was saved. So the reader and the exam
  /// share one source, and reopening the pack needs no network at all.
  readingPack,

  /// The cards that are due today, gathered into one folder across every deck.
  ///
  /// Takes no arguments on purpose: what is due is a fact the app owns, and a
  /// study plan that could be argued with would be a study plan that could be
  /// wrong. The model can only decide that the learner wants one.
  reviewSprint,
}

/// One widget request: a type plus the arguments its builder validates.
class TutorArtefact {
  const TutorArtefact(this.type, this.args);

  final TutorArtefactType type;
  final Map<String, Object?> args;

  String? get hanzi => args['hanzi']?.toString();
}

/// One citation. `note` is for the deck/dictionary case, `quote`/`sentence` for a
/// book, `why` for a video (a claim about its *title*, never its content).
class TutorCite {
  const TutorCite({
    required this.source,
    required this.id,
    this.note,
    this.quote,
    this.sentence,
    this.why,
  });

  final TutorCiteSource source;
  final String id;
  final String? note;
  final String? quote;
  final int? sentence;
  final String? why;
}

/// A proposal to create something durable. Rendering it is a confirm card; the
/// learner commits, the tutor never writes on its own.
class TutorMake {
  const TutorMake({
    required this.kind,
    this.deckId,
    required this.items,
    this.level,
    this.scope,
    this.title,
  });

  final TutorMakeKind kind;

  /// The deck the items are drawn *from*. This is the whole safety story for a
  /// folder: it can only contain cards the learner already has. Null for a paper,
  /// which is drawn from the app's own bundled vocabulary instead.
  final String? deckId;

  final int items;

  /// For [TutorMakeKind.examPaper]: the HSK level, 1-6.
  final int? level;

  final String? scope;
  final String? title;
}

/// One tappable answer to a clarifying question.
class TutorAskOption {
  const TutorAskOption({required this.label, required this.value});

  final String label;
  final String value;
}

/// A clarifying question. It exists so the tutor never guesses a parameter.
class TutorAsk {
  const TutorAsk({required this.question, this.options = const []});

  final String question;
  final List<TutorAskOption> options;
}

/// A whole reply.
class TutorReply {
  const TutorReply({
    this.say,
    this.artefacts = const [],
    this.cites = const [],
    this.makes = const [],
    this.ask,
    this.fromModel = false,
  });

  final String? say;
  final List<TutorArtefact> artefacts;
  final List<TutorCite> cites;
  final List<TutorMake> makes;
  final TutorAsk? ask;

  /// False when a local, model-free composer produced this (no key, or the model
  /// returned something invalid). Surfaced in the UI so the app never pretends an
  /// ungrounded answer came from the tutor.
  final bool fromModel;

  /// A reply with nothing in it is a bug, not an empty state — the parser and the
  /// local composer both guarantee at least one block.
  bool get isEmpty =>
      (say == null || say!.trim().isEmpty) &&
      artefacts.isEmpty &&
      cites.isEmpty &&
      makes.isEmpty &&
      ask == null;
}
