import 'gemini_service.dart';

/// The client half of the story-parse contract.
///
/// `functions/story-parse.js` seeds **one** graded parse of each bundled story
/// per HSK level, because a bundled story is identical for every user: parsing it
/// per device pays for the same answer once per installation. This file is the
/// reading end of that deal.
///
/// **`storyParsePromptVersion` mirrors `STORY_PARSE_PROMPT_VERSION` in
/// `functions/story-parse.js`.** A seed is only accepted when the two agree. So
/// if the prompt in `parseRawStoryToAiStory` is ever edited, bump this number:
/// the seeded documents then stop matching and the app goes back to calling the
/// model, which is the safe direction to fail in. Editing the prompt *without*
/// bumping it is the one mistake that matters here.
const int storyParsePromptVersion = 1;

/// The subcollection the seeds live in, one document per HSK level.
const String storySeedCollection = 'parsed';

/// Read a seeded parse, or `null` when there is nothing usable to read.
///
/// Returns `null` - never throws - for every kind of unusable seed: absent,
/// written by an older prompt, or shaped in a way the app cannot display. The
/// caller then falls back to the model, so a bad seed costs a request rather than
/// a broken screen.
AiStory? storyFromSeed(Map<String, dynamic>? data) {
  if (data == null) return null;
  if (data['promptVersion'] != storyParsePromptVersion) return null;
  final Object? sentences = data['sentences'];
  if (sentences is! List || sentences.isEmpty) return null;
  try {
    final AiStory story = AiStory.fromJson(data);
    // `AiStory.fromJson` tolerates an empty list; a blank story on screen is
    // exactly what a bad seed must never produce.
    if (story.sentences.isEmpty) return null;
    return story;
  } catch (_) {
    return null;
  }
}
