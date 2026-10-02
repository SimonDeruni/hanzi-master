/// Parses and **validates** a model reply into a [TutorReply].
///
/// This is where the tutor's promises are actually kept, and every rule below is
/// a rule from `docs/AI_TUTOR_CONCEPT.md`:
///
///  * **Unknown artefact type → dropped.** A reply may name a widget this build
///    does not have; the rest of the reply still renders.
///  * **An artefact may only be built from data the app owns** (§4.3). A stroke
///    lesson for a character that is not in the dictionary is not "unlikely", it
///    is rejected here.
///  * **A citation may only point at something the learner has** (§12.2). Deck ids
///    are checked against the context the model was given, and book/video/
///    dictionary ids against the set the caller supplied, so an invented id
///    cannot resolve.
///  * **A `make` may only reference a deck that exists**, and its item count is
///    clamped to what that deck actually holds.
///  * **Nothing throws.** Anything malformed loses the smallest possible piece of
///    the reply; if nothing survives, this returns null and the caller falls back
///    to the local composer rather than showing a blank bubble.
library;

import 'dart:convert';

import 'package:hanzi_master/features/tutor/domain/entities/tutor_context.dart';
import 'package:hanzi_master/features/tutor/domain/entities/tutor_reply.dart';

abstract final class TutorEnvelopeParser {
  /// The largest paper a reply may propose.
  static const int maxItems = 60;

  /// [allowedExternalIds] are the book / video / dictionary ids the caller put in
  /// front of the model (a retrieved book excerpt, a video candidate, a looked-up
  /// word). Anything else is refused, which is what makes citations verifiable.
  static TutorReply? parse(
    String raw, {
    required TutorContext context,
    Set<String>? allowedHanzi,
    Map<TutorCiteSource, Set<String>> allowedExternalIds = const {},
  }) {
    final Map<String, dynamic>? json = _decodeObject(raw);
    if (json == null) return null;

    final TutorReply reply = TutorReply(
      say: _cleanString(json['say']),
      artefacts: _parseArtefacts(json['artefacts'], allowedHanzi: allowedHanzi),
      cites: _parseCites(json['cites'], context: context, allowed: allowedExternalIds),
      makes: _parseMakes(json['make'], context: context),
      ask: _parseAsk(json['ask']),
      fromModel: true,
    );
    return reply.isEmpty ? null : reply;
  }

  /// Finds the JSON object in a model reply: models like to wrap it in fences or
  /// in a sentence, so the outermost braces are taken and decoded.
  static Map<String, dynamic>? _decodeObject(String raw) {
    final int first = raw.indexOf('{');
    final int last = raw.lastIndexOf('}');
    if (first < 0 || last <= first) return null;
    try {
      final Object? decoded = json.decode(raw.substring(first, last + 1));
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return decoded.cast<String, dynamic>();
      return null;
    } catch (_) {
      return null;
    }
  }

  static String? _cleanString(Object? value) {
    if (value is! String) return null;
    final String trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  static List<TutorArtefact> _parseArtefacts(
    Object? value, {
    Set<String>? allowedHanzi,
  }) {
    if (value is! List) return const [];
    final List<TutorArtefact> artefacts = <TutorArtefact>[];
    for (final Object? entry in value) {
      if (entry is! Map) continue;
      final Map<String, dynamic> map = entry.cast<String, dynamic>();
      final TutorArtefactType? type = _artefactType(map['type']);
      if (type == null) continue; // unknown widget: dropped, reply survives

      final Map<String, Object?> args =
          ((map['args'] as Map?) ?? const <String, Object?>{})
              .cast<String, Object?>();

      switch (type) {
        case TutorArtefactType.strokeOrder:
        case TutorArtefactType.characterAnatomy:
          final String hanzi = args['hanzi']?.toString() ?? '';
          // Exactly one character, and one the app can actually draw/build: the
          // §4.3 rule, enforced rather than hoped for.
          if (hanzi.runes.length != 1) continue;
          if (allowedHanzi != null && !allowedHanzi.contains(hanzi)) continue;
          artefacts.add(TutorArtefact(type, <String, Object?>{'hanzi': hanzi}));
      }
    }
    return artefacts;
  }

  static TutorArtefactType? _artefactType(Object? value) {
    switch (value?.toString()) {
      case 'strokeOrder':
        return TutorArtefactType.strokeOrder;
      case 'characterAnatomy':
        return TutorArtefactType.characterAnatomy;
      default:
        return null;
    }
  }

  static List<TutorCite> _parseCites(
    Object? value, {
    required TutorContext context,
    required Map<TutorCiteSource, Set<String>> allowed,
  }) {
    if (value is! List) return const [];
    final List<TutorCite> cites = <TutorCite>[];
    for (final Object? entry in value) {
      if (entry is! Map) continue;
      final Map<String, dynamic> map = entry.cast<String, dynamic>();
      final TutorCiteSource? source = _citeSource(map['source']);
      if (source == null) continue;

      final String id = (map['id'] ??
              map['deckId'] ??
              map['bookId'] ??
              map['videoId'] ??
              '')
          .toString();
      if (id.isEmpty) continue;

      // The verifiability check: the id must be one we handed over.
      final bool isKnownDeck =
          source == TutorCiteSource.deck && context.deckById(id) != null;
      final bool isAllowed = allowed[source]?.contains(id) ?? false;
      if (!isKnownDeck && !isAllowed) continue;

      cites.add(TutorCite(
        source: source,
        id: id,
        note: _cleanString(map['note']),
        quote: _cleanString(map['quote']),
        sentence: map['sentence'] is int ? map['sentence'] as int : null,
        why: _cleanString(map['why']),
      ));
    }
    return cites;
  }

  static TutorCiteSource? _citeSource(Object? value) {
    switch (value?.toString()) {
      case 'deck':
        return TutorCiteSource.deck;
      case 'book':
        return TutorCiteSource.book;
      case 'dictionary':
        return TutorCiteSource.dictionary;
      case 'video':
        return TutorCiteSource.video;
      default:
        return null;
    }
  }

  static List<TutorMake> _parseMakes(
    Object? value, {
    required TutorContext context,
  }) {
    if (value is! List) return const [];
    final List<TutorMake> makes = <TutorMake>[];
    for (final Object? entry in value) {
      if (entry is! Map) continue;
      final Map<String, dynamic> map = entry.cast<String, dynamic>();
      if (map['kind']?.toString() != 'examFolder') continue;

      final String deckId = (map['deckId'] ?? '').toString();
      final TutorDeckSummary? deck = context.deckById(deckId);
      // A folder can only be drawn from a deck that exists and has cards — which
      // is what makes the items impossible to hallucinate.
      if (deck == null || deck.cardCount == 0) continue;

      final int requested = map['items'] is int ? map['items'] as int : 20;
      final int items = requested.clamp(1, deck.cardCount).clamp(1, maxItems);

      makes.add(TutorMake(
        kind: TutorMakeKind.examFolder,
        deckId: deckId,
        items: items,
        scope: _cleanString(map['scope']),
        title: _cleanString(map['title']),
      ));
    }
    return makes;
  }

  static TutorAsk? _parseAsk(Object? value) {
    if (value is! Map) return null;
    final Map<String, dynamic> map = value.cast<String, dynamic>();
    final String? question = _cleanString(map['question'] ?? map['say']);
    if (question == null) return null;

    final List<TutorAskOption> options = <TutorAskOption>[];
    final Object? rawOptions = map['options'];
    if (rawOptions is List) {
      for (final Object? entry in rawOptions.take(4)) {
        if (entry is Map) {
          final Map<String, dynamic> option = entry.cast<String, dynamic>();
          final String? label = _cleanString(option['label']) ?? _cleanString(option['value']);
          final String? optionValue = _cleanString(option['value']) ?? label;
          if (label != null && optionValue != null) {
            options.add(TutorAskOption(label: label, value: optionValue));
          }
        } else if (entry != null) {
          final String label = entry.toString().trim();
          if (label.isNotEmpty) {
            options.add(TutorAskOption(label: label, value: label));
          }
        }
      }
    }
    return TutorAsk(question: question, options: options);
  }
}
