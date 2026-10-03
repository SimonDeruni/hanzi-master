/// The input budget — the rules that keep a conversation from getting expensive.
///
/// Two things grow silently in a chat feature, and both did here:
///
///  1. **The conversation.** Replaying the transcript per turn makes the input
///     grow linearly, so turn 50 costs 50x turn 1 — and the fastest-growing part
///     is the model's own prose, which it does not need back. `TutorMemory` is the
///     answer: a fixed-size residue (the learner's last few asks, the first
///     sentence of the last answer, the artefacts already shown).
///  2. **The character list.** The validator's set is the app's whole inventory —
///     the bundled metadata alone is **9,574** characters — and sending that as
///     the prompt's suggestion list cost ~10k tokens on every request, for a list
///     the model could not use. The prompt gets [TutorPrompt.shortlist] instead.
///
/// These tests assert the *outcome*, not the implementation: turn 50 is the same
/// size as turn 3, and the two character sets stay separate.
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/tutor/data/tutor_prompt.dart';
import 'package:hanzi_master/features/tutor/domain/entities/tutor_context.dart';
import 'package:hanzi_master/features/tutor/domain/entities/tutor_memory.dart';
import 'package:hanzi_master/features/tutor/domain/entities/tutor_reply.dart';
import 'package:hanzi_master/features/tutor/domain/logic/local_tutor.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final AppLocalizations enL10n = lookupAppLocalizations(const Locale('en'));

  const TutorContext context = TutorContext(
    decks: <TutorDeckSummary>[
      TutorDeckSummary(
        id: 'hsk3',
        name: 'HSK 3',
        cardCount: 24,
        dueCount: 3,
        sampleHanzi: <String>['你', '好', '我'],
      ),
    ],
    references: <TutorReference>[
      TutorReference(kind: TutorReferenceKind.deck, id: 'hsk3', label: 'HSK 3'),
    ],
  );

  /// One exchange with a fixed-size ask, so two transcripts can be compared
  /// without arithmetic noise.
  TutorExchange exchange(int index, {String say = 'A short answer.'}) =>
      TutorExchange(
        ask: 'question-$index'.padRight(20, '.'),
        say: say,
        artefacts: const <TutorArtefact>[
          TutorArtefact(
              TutorArtefactType.strokeOrder, <String, Object?>{'hanzi': '好'}),
        ],
      );

  group('the conversation is a residue, not a transcript', () {
    test('turn 50 costs exactly what turn 3 costs', () {
      String promptFor(int turns) => TutorPrompt.build(
            message: 'and how is it written?',
            context: context,
            memory: TutorMemory.from(
              List<TutorExchange>.generate(
                turns,
                (int i) =>
                    exchange(i, say: 'A much longer answer, ${'filler ' * 40}'),
              ),
              focusedDeckId: 'hsk3',
            ),
            promptHanzi: const <String>{'好'},
          );

      final String short = promptFor(3);
      final String long = promptFor(50);

      expect(long.length, short.length,
          reason: 'the prompt must not grow with the conversation');
      // The old asks really are gone, not merely short.
      expect(short, contains('question-1......'));
      expect(long, isNot(contains('question-1......')));
      expect(long, contains('question-49'));
      // Long prose never accumulates: the prompt is bounded, however many answers
      // the session has produced.
      //
      // The ceiling moved from 3000 to 3600 when the artefact catalogue grew from two
      // widgets to four — stroke order, anatomy, examples and a grammar table, the
      // last of which needs a payload schema. The assertion above is the one that
      // matters (the session adds nothing); this number exists to catch *accidental*
      // growth, and this growth was deliberate and reviewed.
      expect(long.length, lessThan(3600),
          reason:
              'the rules are a fixed ~3.1k characters; the session adds none');
    });

    test('memory is bounded however long the session is', () {
      final TutorMemory memory = TutorMemory.from(
        List<TutorExchange>.generate(500, (int i) => exchange(i)),
        focusedDeckId: 'hsk3',
      );

      expect(memory.recentAsks.length, lessThanOrEqualTo(TutorMemory.maxAsks));
      expect(memory.shown.length, lessThanOrEqualTo(TutorMemory.maxShown));
      expect(memory.lastAnswerLead!.length,
          lessThanOrEqualTo(TutorMemory.maxLeadChars));
      for (final String ask in memory.recentAsks) {
        expect(ask.length, lessThanOrEqualTo(TutorMemory.maxAskChars));
      }
    });

    test('the lead is one sentence, not the whole answer', () {
      final TutorMemory memory = TutorMemory.from(<TutorExchange>[
        const TutorExchange(
          ask: 'explain 好',
          say: '好 is a woman and a child. That is why it means good.',
        ),
      ]);

      expect(memory.lastAnswerLead, '好 is a woman and a child');
    });

    test('nothing is remembered before the first answer', () {
      expect(TutorMemory.from(const <TutorExchange>[]).isEmpty, isTrue);
      expect(TutorMemory.from(const <TutorExchange>[]).lastCharacter, isNull);
    });

    test('an artefact already shown is named, so it is not shown twice', () {
      final String withMemory = TutorPrompt.build(
        message: 'what else?',
        context: context,
        memory: TutorMemory.from(<TutorExchange>[
          const TutorExchange(
            ask: 'explain 好',
            say: 'Here is how 好 is built.',
            artefacts: <TutorArtefact>[
              TutorArtefact(TutorArtefactType.characterAnatomy,
                  <String, Object?>{'hanzi': '好'}),
            ],
          ),
        ]),
        promptHanzi: const <String>{'好'},
      );

      expect(withMemory, contains('ALREADY SHOWN: characterAnatomy(好)'));
      expect(withMemory, contains('the character under discussion is 好'));

      // No memory is no block at all, rather than an empty heading.
      final String first = TutorPrompt.build(
        message: 'hello',
        context: context,
        promptHanzi: const <String>{},
      );
      expect(first, isNot(contains('ALREADY SHOWN')));
      expect(first, isNot(contains('CONVERSATION SO FAR')));
    });

    test('a follow-up offline still has a subject', () {
      final TutorMemory memory = TutorMemory.from(<TutorExchange>[
        const TutorExchange(
          ask: 'explain 好',
          say: 'Here is how 好 is built.',
          artefacts: <TutorArtefact>[
            TutorArtefact(
                TutorArtefactType.strokeOrder, <String, Object?>{'hanzi': '好'}),
          ],
        ),
      ]);

      final TutorReply followUp = LocalTutor.compose(
        message: 'and how is it written?',
        context: context,
        l10n: enL10n,
        memory: memory,
      );
      expect(followUp.artefacts, isNotEmpty,
          reason: 'the offline tutor should keep talking about 好');
      expect(followUp.say, enL10n.tutorCharacterIntro('好'));

      // A real question with no subject of its own still gets the honest intro,
      // so the follow-up path can never hijack it.
      final TutorReply unrelated = LocalTutor.compose(
        message:
            'How do I say thank you when meeting a teacher for the first time?',
        context: context,
        l10n: enL10n,
        memory: memory,
      );
      expect(unrelated.artefacts, isEmpty);
      expect(unrelated.say, enL10n.tutorFallbackIntro);
    });
  });

  group('the two character sets stay separate', () {
    test('the shortlist is the deck and the message, not the inventory', () {
      final Set<String> shortlist = TutorPrompt.shortlist(
        message: 'explain 好 please',
        context: context,
      );

      // The deck's samples are there, so a question about the deck has a subject.
      expect(shortlist, containsAll(<String>['你', '我', '好']));
      expect(shortlist.length, lessThanOrEqualTo(TutorPrompt.maxPromptHanzi));

      // And nothing else is, even when the message is a wall of characters.
      final Set<String> huge = TutorPrompt.shortlist(
        message: List<String>.generate(3000, (int i) => '好你').join(),
        context: context,
      );
      expect(huge.length, lessThanOrEqualTo(TutorPrompt.maxPromptHanzi));
    });

    test('a request is an order of magnitude smaller than it was', () {
      // What the validator gets: every character the app can build a widget for.
      final Set<String> inventory = <String>{
        for (int i = 0x4E00; i < 0x4E00 + 9574; i++) String.fromCharCode(i),
      };
      final Set<String> shortlist =
          TutorPrompt.shortlist(message: 'explain 好', context: context);

      final int expensive = TutorPrompt.build(
        message: 'explain 好',
        context: context,
        promptHanzi: inventory,
      ).length;
      final int cheap = TutorPrompt.build(
        message: 'explain 好',
        context: context,
        promptHanzi: shortlist,
      ).length;

      expect(expensive, greaterThan(10000),
          reason: 'the old prompt shipped the whole inventory');
      // What matters is the delta: the inventory was ~9.5k characters of a prompt
      // whose rules are ~2k. The ratio cannot be 10x because the skeleton is
      // fixed — which is exactly why the skeleton is worth keeping small.
      expect(expensive - cheap, greaterThan(9000));
      expect(cheap, lessThan(3000),
          reason: 'the whole request, contract and all');
    });

    test('the deck list is capped, and says so', () {
      final TutorContext many = TutorContext(
        decks: <TutorDeckSummary>[
          for (int i = 0; i < 40; i++)
            TutorDeckSummary(
              id: 'deck$i',
              name: 'Deck $i',
              cardCount: 10,
              dueCount: 1,
              sampleHanzi: const <String>['好'],
            ),
        ],
        references: <TutorReference>[
          const TutorReference(
              kind: TutorReferenceKind.deck, id: 'deck0', label: 'Deck 0'),
        ],
      );

      final String prompt = TutorPrompt.build(
        message: 'quiz',
        context: many,
        promptHanzi: const <String>{},
      );

      // The deck in focus always survives...
      expect(prompt, contains('FOCUSED DECK: deck0'));
      // ...the detailed blocks stop at the cap...
      expect(
          'sample: '.allMatches(prompt).length, TutorPrompt.maxDetailedDecks);
      // ...and the ones that are not listed are counted, not silently dropped.
      expect(
          prompt,
          contains(
              '${40 - TutorPrompt.maxListedDecks} more decks, not listed'));
    });
  });
}
