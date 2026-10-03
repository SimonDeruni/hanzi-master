/// What the tutor is told about the conversation so far — deliberately tiny.
///
/// The obvious design is to replay the transcript. It is also the wrong one: the
/// input grows with every turn, so the tenth question costs ten times the tokens
/// of the first — and the part that grows fastest is the model's own prose, which
/// is exactly the part it does not need back.
///
/// So this is the alternative: **the app keeps the transcript, the model gets a
/// bounded residue.** Three things, each fixed-size by construction:
///
///  * the learner's own words for the last few asks — a learner types "and how is
///    it written?", not a paragraph, and each line is capped anyway;
///  * the **first sentence** of the last answer, capped, so a follow-up has an
///    antecedent without paying for a whole paragraph;
///  * the artefacts already shown (a type plus the character), capped, so the
///    tutor does not show 好's stroke order twice in one conversation.
///
/// The cost of turn 50 is therefore the cost of turn 2, and building this from a
/// 500-turn transcript costs the same as building it from a 3-turn one. Nothing
/// here is prose the model wrote: that stays in the app, on the learner's screen,
/// where it belongs.
library;

import 'package:hanzi_master/features/tutor/domain/entities/tutor_reply.dart';

/// One finished exchange, as the screen holds it.
class TutorExchange {
  const TutorExchange({required this.ask, this.say, this.artefacts = const []});

  final String ask;

  /// What the tutor said, or null while it is still thinking.
  final String? say;

  final List<TutorArtefact> artefacts;
}

class TutorMemory {
  const TutorMemory({
    this.recentAsks = const [],
    this.lastAnswerLead,
    this.shown = const [],
    this.focusedDeckId,
  });

  /// No memory at all — the first message of a session.
  static const TutorMemory empty = TutorMemory();

  /// How many of the learner's own asks are carried over.
  static const int maxAsks = 3;

  /// How many artefacts are remembered, in total, however long the session runs.
  static const int maxShown = 6;

  /// Per-line caps. A learner's ask is short; a lead sentence is capped because a
  /// model answer has no length limit at all.
  static const int maxAskChars = 120;
  static const int maxLeadChars = 160;

  /// The learner's own words, oldest first.
  final List<String> recentAsks;

  /// The first sentence of the last answer, clipped.
  final String? lastAnswerLead;

  /// Artefacts already on screen, oldest first.
  final List<TutorArtefact> shown;

  /// The deck the conversation is anchored to, if any.
  final String? focusedDeckId;

  bool get isEmpty =>
      recentAsks.isEmpty && lastAnswerLead == null && shown.isEmpty;

  /// The character the conversation is currently about: the most recent one an
  /// artefact was built for. This is what lets "and how is it written?" mean
  /// something without the model remembering anything.
  String? get lastCharacter {
    for (final TutorArtefact artefact in shown.reversed) {
      final String? hanzi = artefact.hanzi;
      if (hanzi != null && hanzi.isNotEmpty) return hanzi;
    }
    return null;
  }

  /// Summarises [exchanges] into the bounded residue described above.
  ///
  /// It walks the transcript **newest first and stops early** once it has what it
  /// needs, so a long session is not even scanned in full.
  factory TutorMemory.from(
    Iterable<TutorExchange> exchanges, {
    String? focusedDeckId,
  }) {
    final List<TutorExchange> all = exchanges.toList();
    if (all.isEmpty) return TutorMemory(focusedDeckId: focusedDeckId);

    final List<String> asks = <String>[
      for (final TutorExchange exchange
          in all.reversed.take(maxAsks).toList().reversed)
        _clip(exchange.ask, maxAskChars),
    ];

    String? lead;
    final List<TutorArtefact> newestFirst = <TutorArtefact>[];
    final Set<String> seen = <String>{};

    for (final TutorExchange exchange in all.reversed) {
      if (lead == null) {
        final String? say = exchange.say;
        if (say != null && say.trim().isNotEmpty) {
          lead = _clip(_firstSentence(say), maxLeadChars);
        }
      }
      for (final TutorArtefact artefact in exchange.artefacts.reversed) {
        if (newestFirst.length >= maxShown) break;
        if (seen.add('${artefact.type.name}:${artefact.hanzi ?? ''}')) {
          newestFirst.add(artefact);
        }
      }
      // Both answers found: nothing later in the transcript can change them.
      if (lead != null && newestFirst.length >= maxShown) break;
    }

    return TutorMemory(
      recentAsks: asks,
      lastAnswerLead: lead,
      shown: newestFirst.reversed.toList(),
      focusedDeckId: focusedDeckId,
    );
  }

  /// Sentence enders in the languages the app ships: Latin, CJK, Arabic and Thai
  /// all end a sentence with a full stop, whatever it looks like.
  static final RegExp _sentenceEnd = RegExp(r'[.!?。！？…\n]');

  static String _firstSentence(String text) {
    final String trimmed = text.trim();
    final int cut = trimmed.indexOf(_sentenceEnd);
    if (cut <= 0) return trimmed;
    final String first = trimmed.substring(0, cut).trim();
    return first.isEmpty ? trimmed : first;
  }

  /// [text] limited to [max] characters, with an ellipsis so truncation is
  /// visible rather than silent.
  static String _clip(String text, int max) {
    final String trimmed = text.trim();
    if (trimmed.length <= max) return trimmed;
    return '${trimmed.substring(0, max - 1).trimRight()}…';
  }
}
