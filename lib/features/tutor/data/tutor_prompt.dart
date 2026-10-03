/// The prompt that asks for the envelope, and the only context the model sees.
///
/// Pure on purpose: it can be asserted in a test, and it is the single place that
/// states the contract. Note what is deliberately *absent* — the model is never
/// handed a corpus it could recite from, only counts, samples and ids.
///
/// **It is also budgeted.** A prompt is billed per request, so every list in here
/// has a cap, and the conversation arrives as [TutorMemory] — a fixed-size residue
/// — rather than as a transcript that would grow with every turn:
///
///  * [promptHanzi] is a **shortlist** (the deck in focus plus whatever the learner
///    typed), *not* the app's inventory. The validator's set is the bundled
///    metadata — thousands of characters — and putting that here cost on the order
///    of 10k tokens per request for a list the model could not use.
///  * decks are detailed up to [maxDetailedDecks], then listed compactly up to
///    [maxListedDecks]. A deck that is not listed cannot be cited — the same rule
///    as before, with a floor under the cost.
library;

import 'package:hanzi_master/features/tutor/domain/entities/tutor_context.dart';
import 'package:hanzi_master/features/tutor/domain/entities/tutor_memory.dart';
import 'package:hanzi_master/features/tutor/domain/entities/tutor_reply.dart';

abstract final class TutorPrompt {
  /// The largest shortlist of characters the model is given. A learner's message
  /// holds a handful, plus the deck's samples.
  static const int maxPromptHanzi = 24;

  /// Decks given in full detail (id, name, cards, due, sample). The deck in focus
  /// is always one of them.
  static const int maxDetailedDecks = 6;

  /// Decks listed at all. Beyond this the model is told how many it cannot see, so
  /// it can say so rather than pretend the app has no other decks.
  static const int maxListedDecks = 20;

  static String build({
    required String message,
    required TutorContext context,
    TutorMemory memory = TutorMemory.empty,
    Set<String> promptHanzi = const {},
    Set<String> bookIds = const {},
    Set<String> videoIds = const {},
  }) {
    final StringBuffer prompt = StringBuffer();
    void line([String text = '']) => prompt.writeln(text);

    line('You are the tutor inside a Chinese-learning app. You answer with '
        '**JSON only** —');
    line('no prose before or after it.');
    line();
    line(
        '{"say": "your explanation", "artefacts": [], "cites": [], "make": [], '
        '"ask": null}');
    line();
    line('Rules, in priority order:');
    line();
    line('1. "say" is your explanation, written in '
        '${context.interfaceLanguage}. One to three');
    line('   sentences. Be concrete; no filler.');
    line('2. "artefacts" may only use these types:');
    line(
        '   {"type":"characterAnatomy","args":{"hanzi":"好"}}   — how a character '
        'is built');
    line('   {"type":"strokeOrder","args":{"hanzi":"好"}}        — how it is '
        'written');
    line(
        '   {"type":"exampleSet","args":{"hanzi":"好"}}         — how it is used, '
        'in the');
    line('   learner\'s own sentence');
    line('   {"type":"contrastTable","args":{"title":"的 vs 得","left":"的",'
        '"right":"得",');
    line('     "rows":[{"left":"我的书","right":"他跑得快","note":"possessive vs '
        'degree"}]}}');
    line('   A "hanzi" must be exactly ONE character and must appear in the '
        'RELEVANT');
    line(
        '   CHARACTERS list below. If the question is about a character that is '
        'not on');
    line('   that list, answer in "say" without an artefact — never name a '
        'character that');
    line(
        '   is not there. The same rule applies to every character in a table.');
    line(
        '3. "cites" may only reference ids listed below — a deck id, a book id or '
        'a video');
    line('   id. Never invent an id; a citation that is not in these lists is '
        'discarded.');
    line(
        '   When the learner asks to go deeper, to see something demonstrated, or '
        'for more');
    line(
        '   examples, prefer a VIDEO id: give its "why" as one short clause about '
        'its');
    line(
        '   *title* — a claim about the title, never about contents you cannot see '
        '— and');
    line('   the app opens it in its own player.');
    line('4. "make" may only propose '
        '{"kind":"examFolder","deckId":"<id>","items":N,"scope":"hsk3"}');
    line('   for a deck id listed below. This creates a folder the learner can '
        'actually sit.');
    line('   Or {"kind":"examPaper","level":N} (N = 1-6) for a full timed HSK '
        'practise test:');
    line(
        '   the app assembles it from its own bundled vocabulary and grades it, '
        'so propose it');
    line(
        '   when the learner asks for a test or exam — never describe its items '
        'or answers.');
    line(
        '   Never claim you created either one — the app asks them to confirm.');
    line(
        '   Or {"kind":"readingPack","level":N} — a story and questions the app '
        'builds.');
    line('   Or {"kind":"reviewSprint","items":N} — due today.');
    if (memory.focusedDeckId != null) {
      line('   The deck in focus is "${memory.focusedDeckId}" unless they say '
          'otherwise.');
    }
    line('5. "ask" is for a missing parameter: up to 4 tappable options, e.g.');
    line(
        '   {"question":"Which deck?","options":[{"label":"HSK 3","value":"<deck '
        'id>"}]}');
    line(
        '6. If you cannot ground something in the lists below, say so in "say" and '
        'offer');
    line('   what you can. Never invent vocabulary, pinyin, definitions or '
        'sources.');
    // What the app has recorded about this learner: the only place the model is told
    // anything about *this* person rather than about Chinese, and bounded like
    // everything else (§6.2/§6.3).
    if (context.learnerLines.isNotEmpty) {
      line();
      line('WHAT THE APP HAS RECORDED ABOUT THIS LEARNER (facts, not guesses — use '
          'them,');
      line('do not add to them):');
      for (final String entry in context.learnerLines) {
        line('   - $entry');
      }
    }
    if (!memory.isEmpty) {
      line(
          '7. Do not show an artefact that ALREADY SHOWN lists unless the learner '
          'asks for it');
      line('   again. Follow-ups continue the conversation below.');
    }
    if (!memory.isEmpty) {
      line();
      line('CONVERSATION SO FAR (the app remembers; you do not):');
      if (memory.recentAsks.isNotEmpty) {
        line('- recent asks, oldest first: '
            '${memory.recentAsks.map((String ask) => '"$ask"').join(' · ')}');
      }
      final String? lead = memory.lastAnswerLead;
      if (lead != null) {
        line('- your last answer began: "$lead"');
      }
      if (memory.shown.isNotEmpty) {
        line('- ALREADY SHOWN: ${_shownLabel(memory.shown)}');
      }
      final String? character = memory.lastCharacter;
      if (character != null) {
        line('- the character under discussion is $character');
      }
    }

    final String focused = _focusedLabel(context);
    if (focused.isNotEmpty) {
      line();
      line('FOCUSED DECK: $focused');
    }

    line();
    line('DECKS (id · name · cards · due · sample):');
    final String decks = _deckLines(context);
    line(decks.isEmpty ? '- none' : decks);

    line();
    line('RELEVANT CHARACTERS: '
        '${promptHanzi.isEmpty ? '(none)' : promptHanzi.join('')}');
    line('BOOK IDS: ${bookIds.isEmpty ? '(none)' : bookIds.join(', ')}');
    line('VIDEO IDS: ${videoIds.isEmpty ? '(none)' : videoIds.join(', ')}');

    line();
    line('LEARNER: interface ${context.interfaceLanguage}'
        '${context.learnerLevel == null ? '' : ', target HSK ${context.learnerLevel}'}');
    line();
    prompt.write('REQUEST: $message');
    return prompt.toString();
  }

  /// The characters a request may plausibly be about: the samples of the deck in
  /// focus, plus whatever the learner typed.
  ///
  /// This is what belongs in the prompt — *not*
  /// `TutorArtefactData.describableHanzi`, which is the app's whole inventory
  /// (thousands of characters) and belongs to the validator. The two sets look
  /// similar and are not: one is a suggestion list, the other is a security
  /// boundary.
  static Set<String> shortlist({
    required String message,
    required TutorContext context,
  }) {
    final Set<String> hanzi = <String>{};
    final TutorDeckSummary? focused = context.focusedDeck;
    if (focused != null) hanzi.addAll(focused.sampleHanzi);
    for (final int rune in message.runes) {
      if (rune >= 0x4E00 && rune <= 0x9FFF) {
        hanzi.add(String.fromCharCode(rune));
      }
      if (hanzi.length >= maxPromptHanzi) break;
    }
    return hanzi;
  }

  /// `deckId · name · N cards`, for the deck a request is anchored to.
  static String _focusedLabel(TutorContext context) {
    final TutorDeckSummary? focused = context.focusedDeck;
    if (focused == null) return '';
    return '${focused.id} · "${focused.name}" · ${focused.cardCount} cards';
  }

  /// The deck in focus first and in full; then the rest in full detail up to
  /// [maxDetailedDecks]; then one line each up to [maxListedDecks]; then a count,
  /// so an unlisted deck is a stated limit rather than a silent one.
  static String _deckLines(TutorContext context) {
    final List<TutorDeckSummary> ordered = <TutorDeckSummary>[];
    final TutorDeckSummary? focused = context.focusedDeck;
    if (focused != null) ordered.add(focused);
    for (final TutorDeckSummary deck in context.decks) {
      if (deck.id != focused?.id) ordered.add(deck);
    }

    final StringBuffer lines = StringBuffer();
    for (int i = 0; i < ordered.length && i < maxListedDecks; i++) {
      final TutorDeckSummary deck = ordered[i];
      if (i < maxDetailedDecks) {
        lines.writeln(
            '- id: ${deck.id} · "${deck.name}" · ${deck.cardCount} cards '
            '· ${deck.dueCount} due · sample: ${deck.sampleHanzi.take(8).join('')}');
      } else {
        lines.writeln(
            '- id: ${deck.id} · "${deck.name}" · ${deck.cardCount} cards');
      }
    }
    if (ordered.length > maxListedDecks) {
      lines.writeln(
          '- (${ordered.length - maxListedDecks} more decks, not listed)');
    }
    return lines.toString().trimRight();
  }

  /// `characterAnatomy(好), strokeOrder(好)` — short enough to be worth showing.
  static String _shownLabel(List<TutorArtefact> shown) => shown
      .map((TutorArtefact artefact) =>
          '${artefact.type.name}(${artefact.hanzi ?? '?'})')
      .join(', ');
}
