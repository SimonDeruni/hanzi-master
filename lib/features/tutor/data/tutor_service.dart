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
import 'package:hanzi_master/features/tutor/domain/entities/tutor_reply.dart';
import 'package:hanzi_master/features/tutor/domain/logic/local_tutor.dart';

final tutorServiceProvider = Provider<TutorService>(
  (Ref ref) => TutorService(gemini: ref.watch(geminiServiceProvider)),
);

class TutorService {
  TutorService({required GeminiService gemini}) : _gemini = gemini;

  final GeminiService _gemini;

  /// Asks the tutor. [allowedHanzi] is the set of characters the app can actually
  /// build a widget for (today: the characters in the learner's own library), and
  /// the parser refuses anything outside it — so a reply can never describe a
  /// character the app cannot show.
  Future<TutorReply> ask({
    required String message,
    required TutorContext context,
    Set<String> allowedHanzi = const {},
    Set<String> bookIds = const {},
    Set<String> videoIds = const {},
  }) async {
    // Composed first: it is the fallback, and building it is free.
    final TutorReply local = LocalTutor.compose(message: message, context: context);

    try {
      final String raw = await _gemini.generateText(TutorPrompt.build(
        message: message,
        context: context,
        allowedHanzi: allowedHanzi,
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
