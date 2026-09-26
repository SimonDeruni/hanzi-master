"use strict";

/**
 * The prompt and output contract for turning a bundled story into graded
 * sentences - the same work `GeminiService.parseRawStoryToAiStory` does on the
 * device, extracted here so the seeder can do it **once for everyone**.
 *
 * Why this file exists: a bundled story is identical for every user, so parsing
 * it per device means every new installation pays for the same answer. Seeding
 * it once (see `scripts/precompute-story-parses.js`) makes that cost happen a
 * single time instead of once per device.
 *
 * The `v1` alias and the shape validation mirror `dictionary-expansion.js`
 * deliberately: that module proved the pattern of keeping everything a handler
 * needs testable in a plain, require-able module.
 */

const GEMINI_ENDPOINT =
  "https://generativelanguage.googleapis.com/v1beta/models";

/** The model the device path uses, so a seed matches what the app would produce. */
const MODEL_VERSION = "google/gemini-2.5-flash";

/**
 * Bump when [buildPrompt] changes.
 *
 * The Dart client keeps a mirror of this number (`storyParsePromptVersion`).
 * A seed is only used when the two agree, so editing the prompt without bumping
 * degrades to "call the AI again" rather than to "serve a stale story". That is
 * the safe direction to fail in, and it is the whole reason the version is
 * stored on every seeded document.
 */
const STORY_PARSE_PROMPT_VERSION = 1;

/** The instruction the device path uses when no translation is supplied. */
const NO_TRANSLATION_INSTRUCTION =
  'CRITICAL: Put the English translation in the "english" JSON key!';

/**
 * Build the parse prompt for a story.
 *
 * Mirrors `parseRawStoryToAiStory` in `lib/core/services/gemini_service.dart`
 * including the optional-English-translation variant. Seeds are generated for
 * the **no-translation** variant only, because a caller that supplies its own
 * translation is asking a different question.
 *
 * @param {string} rawChineseText the story's Chinese text
 * @param {number} hskLevel the level the meanings should target
 * @param {string} [englishTranslation] omit to mirror the device default
 * @returns {string}
 */
function buildPrompt(rawChineseText, hskLevel, englishTranslation) {
  if (typeof rawChineseText !== "string" || rawChineseText.length === 0) {
    throw new Error("buildPrompt needs the story text");
  }
  if (!Number.isInteger(hskLevel)) throw new Error("buildPrompt needs an HSK level");
  const englishInstruction =
    typeof englishTranslation === "string" && englishTranslation.length > 0
      ? 'Here is the English translation for the story:\n"' +
        englishTranslation +
        '"' +
        "\n\nCRITICAL: You MUST use this provided translation to guide your " +
        "sentence-by-sentence translation. Match your sentence translations to " +
        "this provided meaning."
      : NO_TRANSLATION_INSTRUCTION;
  return [
    "I have the following Chinese story. Parse it into an array of sentences, " +
      "each broken down into words, with pinyin and English definitions.",
    `Ensure that the vocabulary targets HSK level ${hskLevel} as a guideline for meanings.`,
    englishInstruction,
    "",
    "Story:",
    rawChineseText,
    "",
    "Respond ONLY with a valid JSON document matching this exact structure:",
    "{",
    '  "sentences": [',
    "    {",
    '      "english": "English translation of the entire sentence",',
    '      "words": [',
    "        {",
    '          "hanzi": "Hanzi word",',
    '          "pinyin": "pinyin with tone marks",',
    '          "english": "definition in English",',
    '          "hskLevel": 1',
    "        }",
    "      ]",
    "    }",
    "  ]",
    "}",
  ].join("\n");
}

/**
 * Refuse to seed anything the device could not read back.
 *
 * A seed that parses into an empty story would be worse than no seed at all: the
 * client would prefer it over calling the model and show a blank story. So an
 * unusable answer is rejected here, at seeding time, where a human can see it.
 *
 * @param {unknown} data parsed model output
 * @returns {{sentences: Array}}
 */
function validateOutput(data) {
  if (!data || typeof data !== "object") throw new Error("output is not an object");
  const sentences = data.sentences;
  if (!Array.isArray(sentences) || sentences.length === 0) {
    throw new Error("output has no sentences");
  }
  for (const [index, sentence] of sentences.entries()) {
    if (!sentence || typeof sentence !== "object") {
      throw new Error(`sentence ${index} is not an object`);
    }
    if (!Array.isArray(sentence.words) || sentence.words.length === 0) {
      throw new Error(`sentence ${index} has no words`);
    }
    for (const [wordIndex, word] of sentence.words.entries()) {
      if (!word || typeof word !== "object" || typeof word.hanzi !== "string" || word.hanzi.length === 0) {
        throw new Error(`sentence ${index} word ${wordIndex} has no hanzi`);
      }
    }
  }
  return { sentences };
}

module.exports = {
  GEMINI_ENDPOINT,
  MODEL_VERSION,
  STORY_PARSE_PROMPT_VERSION,
  NO_TRANSLATION_INSTRUCTION,
  buildPrompt,
  validateOutput,
};
