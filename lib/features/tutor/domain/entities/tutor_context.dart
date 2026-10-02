/// What the tutor is allowed to know for one request.
///
/// Grounding starts from the learner's side: a message can carry explicit
/// references to things they own, and the app gathers a **context bundle** from
/// local data. The model only ever sees the bundle, and — critically — it may only
/// cite ids that appear in it, so a fabricated citation cannot resolve.
library;

/// The kinds of thing a message can point at.
enum TutorReferenceKind { deck, character, book }

/// One explicit reference, chosen by the learner (a picker, not typed syntax).
class TutorReference {
  const TutorReference({
    required this.kind,
    required this.id,
    required this.label,
  });

  final TutorReferenceKind kind;

  /// A deck id, a hanzi, or a book id.
  final String id;

  /// What the learner saw when they picked it — also what the prompt shows.
  final String label;

  TutorReference copyWith({String? id, String? label}) => TutorReference(
        kind: kind,
        id: id ?? this.id,
        label: label ?? this.label,
      );
}

/// A deck the learner owns, summarised for the prompt. Deliberately counts, not
/// contents: the model may not be handed a corpus it could recite from.
class TutorDeckSummary {
  const TutorDeckSummary({
    required this.id,
    required this.name,
    required this.cardCount,
    required this.dueCount,
    this.sampleHanzi = const [],
  });

  final String id;
  final String name;
  final int cardCount;
  final int dueCount;

  /// A handful of the deck's real characters, so "explain this deck's words" has
  /// something concrete to talk about.
  final List<String> sampleHanzi;
}

/// Everything the model may reference, assembled locally per request.
class TutorContext {
  const TutorContext({
    this.interfaceLanguage = 'en',
    this.learnerLevel,
    this.decks = const [],
    this.references = const [],
  });

  final String interfaceLanguage;
  final int? learnerLevel;
  final List<TutorDeckSummary> decks;

  /// The references attached to *this* message.
  final List<TutorReference> references;

  TutorReference? referenceOf(TutorReferenceKind kind) {
    for (final TutorReference reference in references) {
      if (reference.kind == kind) return reference;
    }
    return null;
  }

  TutorDeckSummary? deckById(String id) {
    for (final TutorDeckSummary deck in decks) {
      if (deck.id == id) return deck;
    }
    return null;
  }

  /// The deck a request is *about* — the explicit reference wins, otherwise a
  /// single deck is unambiguous, otherwise the tutor has to ask.
  TutorDeckSummary? get focusedDeck {
    final TutorReference? explicit = referenceOf(TutorReferenceKind.deck);
    if (explicit != null) return deckById(explicit.id);
    return decks.length == 1 ? decks.first : null;
  }
}
