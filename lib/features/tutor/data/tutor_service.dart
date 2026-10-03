/// The tutor's one entry point: ask → AI if possible → else a local answer.
///
/// The interesting part is what happens on failure. A tutor that shows an error
/// toast when the network drops is worse than a tutor that still teaches, so the
/// local composer answers instead (`TutorReply.fromModel == false`), and the reply
/// says where it came from rather than pretending.
library;

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/features/tutor/data/tutor_envelope_parser.dart';
import 'package:hanzi_master/features/tutor/data/tutor_prompt.dart';
import 'package:hanzi_master/features/tutor/domain/entities/tutor_context.dart';
import 'package:hanzi_master/features/tutor/domain/entities/tutor_memory.dart';
import 'package:hanzi_master/features/tutor/domain/entities/tutor_reply.dart';
import 'package:hanzi_master/features/tutor/domain/logic/local_tutor.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

final tutorServiceProvider = Provider<TutorService>(
  (Ref ref) => TutorService(gemini: ref.watch(geminiServiceProvider)),
);

class TutorService {
  TutorService({required GeminiService gemini}) : _gemini = gemini;

  final GeminiService _gemini;

  /// Asks the tutor. There are two character sets on purpose, and the difference
  /// between them is the whole cost story:
  ///
  ///  * [promptHanzi] is the **shortlist** the model may be asked about — the deck
  ///    in focus plus whatever the learner typed. It goes in the prompt.
  ///  * [allowedHanzi] is what the app can actually **build a widget for** (the
  ///    learner's library plus the bundled metadata: thousands of characters). It
  ///    stays local, in the validator, where it is free.
  ///
  /// Passing the second as the first is what made every request ~10k tokens.
  /// [memory] is the bounded residue of the conversation, never a transcript.
  Future<TutorReply> ask({
    required String message,
    required TutorContext context,
    required AppLocalizations l10n,
    TutorMemory memory = TutorMemory.empty,
    Set<String> promptHanzi = const {},
    Set<String> allowedHanzi = const {},
    Set<String> bookIds = const {},
    Set<String> videoIds = const {},
  }) async {
    // Composed first: it is the fallback, and building it is free. It is also the
    // only answer that works offline, which is why it is localised rather than
    // left in English — and why it gets the memory too, so a follow-up still has
    // a subject.
    final TutorReply local = LocalTutor.compose(
      message: message,
      context: context,
      l10n: l10n,
      memory: memory,
    );

    try {
      // The default shortlist is the cheap one: the caller would have to *opt in*
      // to the unbounded list, which is the mistake this signature removes.
      final Set<String> shortlist = promptHanzi.isNotEmpty
          ? promptHanzi
          : TutorPrompt.shortlist(message: message, context: context);

      final String raw = await _gemini.generateText(TutorPrompt.build(
        message: message,
        context: context,
        memory: memory,
        promptHanzi: shortlist,
        bookIds: bookIds,
        videoIds: videoIds,
      ));
      if (raw.trim().isEmpty) return local;

      final TutorReply? parsed = TutorEnvelopeParser.parse(
        raw,
        context: context,
        allowedHanzi: allowedHanzi,
        allowedExternalIds: <TutorCiteSource, Set<String>>{
          TutorCiteSource.book: bookIds,
          TutorCiteSource.video: videoIds,
        },
      );
      return parsed ?? local;
    } catch (error) {
      debugPrint('Tutor request failed; answering from local data: $error');
      return local;
    }
  }
}
