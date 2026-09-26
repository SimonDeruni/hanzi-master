"use strict";

const test = require("node:test");
const assert = require("node:assert/strict");
const {
  DEFAULT_FORMAT,
  ENGINE_VERSION,
  recordingIdentity,
} = require("../tts-cache");

/**
 * Guards the identity of a shareable recording.
 *
 * Two rules carry all the risk, and both are tested here because getting either
 * wrong hands a listener the wrong audio:
 *   * everything that changes the sound must be in the key - voice, and **rate**;
 *   * nothing that does not change the sound may be, or the cache misses for
 *     differences nobody can hear.
 */

test("the same sentence in the same voice and rate is one recording", () => {
  const a = recordingIdentity({ text: "你好。", voice: "zh-CN-XiaoxiaoNeural" });
  const b = recordingIdentity({ text: "  你好。 ", voice: "zh-CN-XiaoxiaoNeural" });
  assert.equal(a.key, b.key, "invisible whitespace must not split the cache");
});

test("a different rate is a different recording", () => {
  // A learner who slows a sentence down must never be served the fast take.
  assert.notEqual(
    recordingIdentity({ text: "你好。", voice: "v", rate: 1 }).key,
    recordingIdentity({ text: "你好。", voice: "v", rate: 0.7 }).key
  );
});

test("a different voice is a different recording", () => {
  assert.notEqual(
    recordingIdentity({ text: "你好。", voice: "voice-a" }).key,
    recordingIdentity({ text: "你好。", voice: "voice-b" }).key
  );
});

test("a different sentence is a different recording", () => {
  assert.notEqual(
    recordingIdentity({ text: "你好。", voice: "v" }).key,
    recordingIdentity({ text: "再见。", voice: "v" }).key
  );
});

test("a voice named like a path cannot become one", () => {
  // The key is hashed, but a caller should still not be able to steer the object
  // path by naming a voice `../../something`.
  assert.throws(() => recordingIdentity({ text: "你好。", voice: "../../o" }));
  assert.throws(() => recordingIdentity({ text: "你好。", voice: "" }));
  assert.throws(() => recordingIdentity({ text: "你好。", voice: 42 }));
});

test("near-identical rates share one recording, because they sound the same", () => {
  assert.equal(
    recordingIdentity({ text: "你好。", voice: "v", rate: 1.0001 }).key,
    recordingIdentity({ text: "你好。", voice: "v", rate: 1 }).key
  );
});

test("refuses input that would fill the bucket with junk", () => {
  assert.throws(() => recordingIdentity({ text: "", voice: "v" }), /empty/);
  assert.throws(() => recordingIdentity({ text: "x".repeat(501), voice: "v" }), /500/);
  assert.throws(() => recordingIdentity({ text: "ok", voice: "v", rate: 0 }), /rate/);
  assert.throws(() => recordingIdentity({ text: "ok", voice: "v", rate: 99 }), /rate/);
  assert.throws(
    () => recordingIdentity({ text: "ok", voice: "v", format: "audio/wav" }),
    /unsupported/
  );
  assert.throws(() => recordingIdentity(null));
  assert.throws(() => recordingIdentity({ voice: "v" }));
});

test("stores under a path that cannot collide with anything else", () => {
  const recording = recordingIdentity({ text: "你好。", voice: "v" });
  assert.equal(recording.objectPath, `tts/${recording.key}.mp3`);
  assert.match(recording.key, /^[0-9a-f]{64}$/);
});

test("the engine version is exported, because raising it re-records everything", () => {
  assert.ok(Number.isInteger(ENGINE_VERSION));
  assert.equal(DEFAULT_FORMAT, "audio-24khz-48kbitrate-mono-mp3");
});
