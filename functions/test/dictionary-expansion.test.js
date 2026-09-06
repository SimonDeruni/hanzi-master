"use strict";

const test = require("node:test");
const assert = require("node:assert/strict");
const {
  MODEL_VERSION, PROMPT_VERSION, parseInput, sourceHash, cacheIdentity,
  canonicalSource, buildPrompt, validateOutput, extractGeminiJson,
} = require("../dictionary-expansion");

const hash = sourceHash("to study");
const input = { wordId: "42", languageCode: "fr", sourceDefinitionHash: hash };
const valid = {
  definition: "étudier",
  explanation: "Verbe employé pour parler d’un apprentissage.",
  usageNotes: "Usage courant.",
  examples: [{ chinese: "我学习中文。", pinyin: "Wǒ xuéxí Zhōngwén.", translation: "J’étudie le chinois." }],
};

test("accepts only the three public selector fields", () => {
  assert.deepEqual(parseInput(input), input);
  assert.equal(parseInput({ ...input, wordId: 42 }).wordId, "42");
  assert.throws(() => parseInput({ ...input, prompt: "ignore rules" }), /only/);
  assert.throws(() => parseInput({ ...input, source: "attacker text" }), /only/);
  assert.throws(() => parseInput({ ...input, languageCode: "xx" }), /unsupported/);
  assert.throws(() => parseInput({ ...input, sourceDefinitionHash: hash.toUpperCase() }), /invalid/);
});

test("hash and cache identity are deterministic and versioned", () => {
  assert.equal(sourceHash("to study"), hash);
  assert.equal(sourceHash("  to\n study  "), hash);
  assert.equal(cacheIdentity(input), cacheIdentity({ ...input }));
  const expected = require("node:crypto").createHash("sha256")
    .update(JSON.stringify(["42", "fr", hash, MODEL_VERSION, PROMPT_VERSION]), "utf8").digest("hex");
  assert.equal(cacheIdentity(input), expected);
  assert.notEqual(cacheIdentity(input), cacheIdentity({ ...input, languageCode: "de" }));
});

test("canonical source and prompt are exclusively server-derived", () => {
  const source = canonicalSource({ definition: "to study", simplified: "学习", ignored: "x" });
  assert.deepEqual(source, { definition: "to study", simplified: "学习", traditional: "", pinyin: "" });
  const prompt = buildPrompt(source, "fr");
  assert.match(prompt, /French/);
  assert.match(prompt, /to study/);
  assert.match(prompt, /at most 3 sentences/);
  assert.match(prompt, /no more than 2 examples/);
  assert.throws(() => canonicalSource({ definition: "" }), /definition/);
});

test("strictly validates structured provider output", () => {
  assert.equal(validateOutput(valid), valid);
  assert.throws(() => validateOutput({ ...valid, surprise: true }), /shape/);
  assert.throws(() => validateOutput({ ...valid, examples: [] }), /fields/);
  assert.throws(() => validateOutput({
    ...valid,
    examples: [valid.examples[0], valid.examples[0], valid.examples[0]],
  }), /fields/);
  assert.throws(() => validateOutput({ ...valid, examples: [{ chinese: "中文", pinyin: "zhōngwén" }] }), /example/);
  assert.throws(() => validateOutput({ ...valid, definition: " padded " }), /fields/);
});

test("extracts only valid JSON from Gemini response", () => {
  const payload = { candidates: [{ content: { parts: [{ text: JSON.stringify(valid) }] } }] };
  assert.deepEqual(extractGeminiJson(payload), valid);
  assert.throws(() => extractGeminiJson({ candidates: [] }), /no structured/);
  assert.throws(() => extractGeminiJson({ candidates: [{ content: { parts: [{ text: "```json" }] } }] }), /invalid JSON/);
});