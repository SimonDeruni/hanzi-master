"use strict";

const test = require("node:test");
const assert = require("node:assert/strict");
const {
  MODEL_VERSION,
  NO_TRANSLATION_INSTRUCTION,
  STORY_PARSE_PROMPT_VERSION,
  buildPrompt,
  validateOutput,
} = require("../story-parse");

/**
 * Guards the prompt and output contract shared between the seeder and the device
 * path in `gemini_service.dart`.
 *
 * The dangerous failure here is not a crash. It is a seed that is *accepted* and
 * then renders badly, or a prompt that drifts on one side only - which is why
 * the version is exported and asserted, and why unusable output is refused at
 * seeding time where a human can read the error.
 */

const STORY = "从前有一只猫。";

test("the prompt carries the level and the story, and asks for the JSON shape", () => {
  const prompt = buildPrompt(STORY, 3);
  assert.match(prompt, /HSK level 3/);
  assert.match(prompt, /从前有一只猫。/);
  assert.match(prompt, /"sentences"/);
  assert.match(prompt, /"hskLevel"/);
  assert.match(prompt, new RegExp(NO_TRANSLATION_INSTRUCTION.replace(/[.*+?^${}()|[\]\\]/g, "\\$&")));
});

test("supplying a translation asks a different question", () => {
  const plain = buildPrompt(STORY, 3);
  const guided = buildPrompt(STORY, 3, "Once there was a cat.");
  assert.notEqual(plain, guided);
  assert.match(guided, /Once there was a cat\./);
  assert.doesNotMatch(guided, /Put the English translation in the/);
});

test("refuses to build a prompt from nothing usable", () => {
  assert.throws(() => buildPrompt("", 3), /story text/);
  assert.throws(() => buildPrompt(STORY), /HSK level/);
  assert.throws(() => buildPrompt(STORY, "3"), /HSK level/);
});

test("accepts a well-formed answer", () => {
  const parsed = validateOutput({
    sentences: [
      {
        english: "Once there was a cat.",
        words: [{ hanzi: "猫", pinyin: "māo", english: "cat", hskLevel: 1 }],
      },
    ],
  });
  assert.equal(parsed.sentences.length, 1);
});

test("refuses an answer the app could not display", () => {
  // Each of these would otherwise be stored as a seed and preferred over calling
  // the model, which turns one bad answer into a permanent blank story.
  assert.throws(() => validateOutput(null));
  assert.throws(() => validateOutput({}));
  assert.throws(() => validateOutput({ sentences: [] }));
  assert.throws(() => validateOutput({ sentences: [{}] }), /no words/);
  assert.throws(() => validateOutput({ sentences: [{ words: [] }] }), /no words/);
  assert.throws(() => validateOutput({ sentences: [{ words: [{}] }] }), /no hanzi/);
  assert.throws(
    () => validateOutput({ sentences: [{ words: [{ hanzi: "" }] }] }),
    /no hanzi/
  );
});

test("exports the version and model, because a seed is only usable when they match", () => {
  assert.ok(Number.isInteger(STORY_PARSE_PROMPT_VERSION));
  assert.equal(typeof MODEL_VERSION, "string");
  assert.ok(MODEL_VERSION.length > 0);
});
