"use strict";

/**
 * The shared speech cache: one recording per (sentence, voice, rate).
 *
 * Why speech first: the output is **byte-identical** for a given text, voice and
 * rate - no personalisation, no variance - and the spoken content is the app's
 * own (book sentences, dictionary words, story lines), never something a user
 * typed. That makes it the safest thing to share between users, and the most
 * valuable, because Azure speech is metered and the app already runs against a
 * 4-hour weekly fair-use quota. Every recording reused is quota kept.
 *
 * This module holds only what must be identical on both sides of the cache, so
 * it can be unit-tested without Storage, Azure or a network - the same reason
 * `dictionary-expansion.js` factors `cacheIdentity` out of its handler.
 */

/**
 * Bump to re-record everything.
 *
 * It is part of the identity, so raising it makes every existing recording
 * unreachable at once. Do that when the audio format changes, or when a voice's
 * output changes underneath us - otherwise a stale file would be served for ever.
 */
const ENGINE_VERSION = 1;

/** The format the device asks Azure for, so a cached recording matches it. */
const DEFAULT_FORMAT = "audio-24khz-48kbitrate-mono-mp3";

/**
 * The longest text worth caching in one recording.
 *
 * A guard, not a product limit: a whole audiobook chapter would be a huge object
 * to store and download, and speech is spoken a sentence at a time anyway.
 */
const MAX_TEXT_LENGTH = 500;

/** Where the recordings live in the bucket. */
const OBJECT_PREFIX = "tts";

/**
 * Collapse whitespace so the same sentence is one recording, not three.
 *
 * "你好。" and "  你好。 " are the same speech; treating them as different would
 * miss the cache for a difference nobody can hear.
 *
 * @param {unknown} text
 * @returns {string}
 */
function normalizeText(text) {
  if (typeof text !== "string") throw new Error("text must be a string");
  const normalized = text.replace(/\s+/g, " ").trim();
  if (normalized.length === 0) throw new Error("text is empty");
  if (normalized.length > MAX_TEXT_LENGTH) {
    throw new Error(`text longer than ${MAX_TEXT_LENGTH} characters`);
  }
  return normalized;
}

/**
 * Check the voice, and the rate that changes the audio.
 *
 * The voice is validated by **shape rather than against a fixed list**: the
 * device maps its own voice names to Azure ones, and inventing an allowlist here
 * would silently break a voice the app offers. The shape check still stops a
 * caller filling the bucket through an arbitrary string.
 *
 * The rate matters as much as the voice: a learner who slows a sentence down is
 * listening to different audio, so it is part of the identity. Omitting it would
 * serve the fast recording to a slow-speed listener.
 *
 * @param {unknown} voice
 * @param {unknown} rate
 * @returns {{voice: string, rate: number}}
 */
function validateVoiceAndRate(voice, rate) {
  if (typeof voice !== "string" || !/^[A-Za-z0-9_-]{1,64}$/.test(voice)) {
    throw new Error("voice must be a short identifier");
  }
  const numericRate = rate == null ? 1 : Number(rate);
  if (!Number.isFinite(numericRate) || numericRate <= 0 || numericRate > 4) {
    throw new Error("rate must be a positive number no greater than 4");
  }
  // Two decimals: the device rounds its rate before asking, so anything finer is
  // noise that would fragment the cache into near-duplicate recordings.
  return { voice, rate: Math.round(numericRate * 100) / 100 };
}

/**
 * The identity of one recording: everything that changes the audio, and nothing else.
 *
 * @param {{text: string, voice: string, rate?: number, format?: string}} request
 * @returns {{key: string, text: string, voice: string, rate: number, format: string, objectPath: string}}
 */
function recordingIdentity(request) {
  if (!request || typeof request !== "object") {
    throw new Error("a recording request is required");
  }
  const text = normalizeText(request.text);
  const format = request.format == null ? DEFAULT_FORMAT : String(request.format);
  if (format !== DEFAULT_FORMAT) {
    throw new Error(`unsupported audio format: ${format}`);
  }
  const { voice, rate } = validateVoiceAndRate(request.voice, request.rate);
  const key = require("node:crypto")
    .createHash("sha256")
    .update(JSON.stringify([text, voice, rate, format, ENGINE_VERSION]))
    .digest("hex");
  return {
    key,
    text,
    voice,
    rate,
    format,
    objectPath: `${OBJECT_PREFIX}/${key}.mp3`,
  };
}

/** Where the word timings that belong to a recording live. */
function boundariesPath(key) {
  return `${OBJECT_PREFIX}/${key}.json`;
}

/**
 * A recording is at most a sentence or two, so this ceiling is generous.
 *
 * It exists because the app uploads the audio: an unbounded upload is an open
 * invitation to fill the bucket.
 */
const MAX_AUDIO_BYTES = 2 * 1024 * 1024;

/**
 * Check the word timings the app sends alongside a recording.
 *
 * These drive the highlighting that follows the spoken words, which is why they
 * must travel with the audio: timings from a different take would appear to
 * "slide" against the voice. They come from the app rather than from Azure
 * because Azure returns them on its streaming path, which the app uses - so the
 * app is the only party that has a *matching* pair.
 *
 * Validation is deliberately lenient about the numbers and strict about the
 * shape: a bad set of timings should be discarded, never allowed to crash
 * playback or corrupt the stored recording.
 *
 * @param {unknown} value
 * @returns {Array<object>}
 */
function validateBoundaries(value) {
  if (value == null) return [];
  if (!Array.isArray(value)) throw new Error("boundaries must be an array");
  if (value.length > 2000) throw new Error("too many boundaries for one recording");
  const checked = [];
  for (const [index, entry] of value.entries()) {
    if (!entry || typeof entry !== "object") {
      throw new Error(`boundary ${index} is not an object`);
    }
    const offset = Number(entry.OffsetMs ?? entry.offsetMs);
    const duration = Number(entry.DurationMs ?? entry.durationMs);
    const word = entry.Word ?? entry.word;
    if (!Number.isFinite(offset) || offset < 0) {
      throw new Error(`boundary ${index} has no usable offset`);
    }
    if (!Number.isFinite(duration) || duration < 0) {
      throw new Error(`boundary ${index} has no usable duration`);
    }
    if (typeof word !== "string") {
      throw new Error(`boundary ${index} has no word`);
    }
    // Normalised on the way in, so one recording cannot be stored in two shapes
    // depending on which app version uploaded it.
    checked.push({
      OffsetMs: Math.round(offset),
      DurationMs: Math.round(duration),
      Word: word,
    });
  }
  return checked;
}

module.exports = {
  ENGINE_VERSION,
  DEFAULT_FORMAT,
  MAX_AUDIO_BYTES,
  MAX_TEXT_LENGTH,
  OBJECT_PREFIX,
  normalizeText,
  validateVoiceAndRate,
  validateBoundaries,
  recordingIdentity,
  boundariesPath,
};

