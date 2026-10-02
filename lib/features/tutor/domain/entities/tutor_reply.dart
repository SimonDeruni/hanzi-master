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
    required this.deckId,
    required this.items,
    this.scope,
    this.title,
  });

  final TutorMakeKind kind;

  /// The deck the items are drawn *from*. This is the whole safety story: the
  /// folder can only contain cards the learner already has.
  final String deckId;

  final int items;
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
