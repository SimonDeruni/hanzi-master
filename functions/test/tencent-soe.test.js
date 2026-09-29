"use strict";

const test = require("node:test");
const assert = require("node:assert/strict");
const {
  sha256Hex,
  hmacSha256,
  hmacSha256Hex,
  credentialDate,
  buildCanonicalRequest,
  buildStringToSign,
  deriveSigningKey,
  buildAuthorization,
  buildHeaders,
  buildInitPayload,
  buildTransmitPayload,
  mapSoeResult,
  toneOf,
  toneIsMeasured,
  normaliseAccuracy,
  scaleUnit,
  unwrapSoeResponse,
  MIN_WORD_ACCURACY,
} = require("../tencent-soe");

/**
 * This module is the whole Tencent SOE decision in pure code, so it is covered the
 * way `dictionary-expansion.js` is: every branch asserted, no live credentials.
 *
 * Signing is the one place without a known-answer vector. Tencent **redacts the
 * SecretId and SecretKey in their published example**
 * (https://cloud.tencent.com/document/api/213/30654 prints
 * `AKID********************************`), so the final signature hex cannot be
 * reproduced from documentation. The primitives are covered with published vectors
 * and the composed signature with its exact documented shape, which is the strongest
 * available check and is exactly the part that breaks when header casing drifts.
 */

const PAYLOAD = '{"Limit":1}';
const ACTION = "InitOralProcess";
const TIMESTAMP = 1551113065; // Tencent's own example timestamp
const DATE = "2019-02-25"; // …and its UTC date, which `credentialDate` must agree with

// ---------------------------------------------------------------------------
// Primitives — published test vectors
// ---------------------------------------------------------------------------

test("sha256Hex matches the published vector for 'abc'", () => {
  assert.equal(
    sha256Hex("abc"),
    "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad",
  );
});

test("hmacSha256Hex matches RFC 4231 case 1", () => {
  // key = 20 bytes of 0x0b, message = "Hi There"
  const key = Buffer.alloc(20, 0x0b);
  assert.equal(
    hmacSha256Hex(key, "Hi There"),
    "b0344c61d8db38535ca8afceaf0bf12b881dc200c9833da726e9376c2e32cff7",
  );
  assert.equal(hmacSha256(key, "Hi There").toString("hex").length, 64);
});

// ---------------------------------------------------------------------------
// Signing
// ---------------------------------------------------------------------------

test("credentialDate takes the UTC date, matching Tencent's example", () => {
  assert.equal(credentialDate(TIMESTAMP), DATE);
  // The credential scope is keyed on UTC, so a late-evening UTC timestamp must not
  // roll to the next day, and a local-time implementation would.
  assert.equal(credentialDate(Date.UTC(2019, 1, 25, 23, 59, 59) / 1000), DATE);
  assert.equal(credentialDate(Date.UTC(2019, 1, 26, 0, 0, 1) / 1000), "2019-02-26");
});

test("canonical request has the documented six-part shape", () => {
  const canonical = buildCanonicalRequest({ action: ACTION, payload: PAYLOAD });
  // Note the **blank line** after the header block. The spec concatenates
  // CanonicalHeaders — which already ends in "\n" — with another "\n", and Tencent's
  // own C sample builds it exactly that way:
  //   sprintf(canonical_request, "%s\n%s\n%s\n%s\n%s\n%s", …) with a
  //   `canonical_headers` buffer that ends in "\n".
  // So it is intentional rather than a stray newline, and asserting the whole string
  // is what keeps it that way.
  assert.equal(
    canonical,
    "POST\n/\n\n" +
      "content-type:application/json; charset=utf-8\n" +
      "host:soe.tencentcloudapi.com\n" +
      "x-tc-action:initoralprocess\n" +
      "\n" +
      "content-type;host;x-tc-action\n" +
      sha256Hex(PAYLOAD),
  );
  // The action participates in the signature lowercased, as in Tencent's example.
  assert.ok(canonical.includes("x-tc-action:initoralprocess"));
  assert.ok(!canonical.includes("InitOralProcess"));
});

test("string to sign is algorithm, timestamp, scope, hashed canonical request", () => {
  const canonical = buildCanonicalRequest({ action: ACTION, payload: PAYLOAD });
  const lines = buildStringToSign({
    timestamp: TIMESTAMP,
    date: DATE,
    canonicalRequest: canonical,
  }).split("\n");
  assert.deepEqual(lines, [
    "TC3-HMAC-SHA256",
    "1551113065",
    "2019-02-25/soe/tc3_request",
    sha256Hex(canonical),
  ]);
});

test("the signing key is derived, and differs per date and per secret", () => {
  const base = deriveSigningKey({ secretKey: "s", date: DATE });
  assert.equal(base.length, 32);
  assert.notDeepEqual(
    base,
    deriveSigningKey({ secretKey: "s", date: "2019-02-26" }),
  );
  assert.notDeepEqual(
    base,
    deriveSigningKey({ secretKey: "other", date: DATE }),
  );
});

test("Authorization carries the credential scope and a hex signature", () => {
  const { Authorization, signature } = buildAuthorization({
    secretId: "AKIDtest",
    secretKey: "secret",
    action: ACTION,
    payload: PAYLOAD,
    timestamp: TIMESTAMP,
  });
  assert.match(
    Authorization,
    /^TC3-HMAC-SHA256 Credential=AKIDtest\/2019-02-25\/soe\/tc3_request, SignedHeaders=content-type;host;x-tc-action, Signature=[0-9a-f]{64}$/,
  );
  assert.equal(signature.length, 64);
});

test("signing is deterministic, and changes with payload, timestamp and secret", () => {
  const sign = (overrides = {}) =>
    buildAuthorization({
      secretId: "AKIDtest",
      secretKey: "secret",
      action: ACTION,
      payload: PAYLOAD,
      timestamp: TIMESTAMP,
      ...overrides,
    }).signature;

  assert.equal(sign(), sign());
  assert.notEqual(sign(), sign({ payload: '{"Limit":2}' }));
  assert.notEqual(sign(), sign({ timestamp: TIMESTAMP + 1 }));
  assert.notEqual(sign(), sign({ secretKey: "secret2" }));
});

test("headers carry the action, version and the signed host", () => {
  const headers = buildHeaders({
    secretId: "AKIDtest",
    secretKey: "secret",
    action: ACTION,
    payload: PAYLOAD,
    timestamp: TIMESTAMP,
  });
  assert.equal(headers.Host, "soe.tencentcloudapi.com");
  assert.equal(headers["X-TC-Action"], ACTION);
  assert.equal(headers["X-TC-Version"], "2018-07-24");
  assert.equal(headers["X-TC-Timestamp"], "1551113065");
  // Must match the content-type that was signed, byte for byte.
  assert.equal(headers["Content-Type"], "application/json; charset=utf-8");
});

// ---------------------------------------------------------------------------
// Request bodies
// ---------------------------------------------------------------------------

test("the init call sets ServerType=1, because the API default is English", () => {
  const body = JSON.parse(buildInitPayload({ sessionId: "s", refText: "百战不殆" }));
  // Omitting ServerType grades Chinese audio with the English model and fails
  // quietly, which is why this is asserted rather than assumed.
  assert.equal(body.ServerType, 1);
  assert.equal(body.WorkMode, 1); // one-shot, no chunking
  assert.equal(body.EvalMode, 0); // 文字模式 for Chinese: one syllable per word
  assert.equal(body.SessionId, "s");
  assert.equal(body.RefText, "百战不殆");
});

test("the init call takes a strictness and mode override, and omits a blank SoeAppId", () => {
  const strict = JSON.parse(
    buildInitPayload({ sessionId: "s", refText: "好", evalMode: 1, scoreCoeff: 1 }),
  );
  assert.equal(strict.EvalMode, 1);
  // 1.0 is the doc's "smallest age band" — the child-leniency dial.
  assert.equal(strict.ScoreCoeff, 1);
  assert.ok(!("SoeAppId" in strict));

  const scoped = JSON.parse(
    buildInitPayload({ sessionId: "s", refText: "好", soeAppId: "soe_100" }),
  );
  assert.equal(scoped.SoeAppId, "soe_100");
});

test("the transmit call sends one complete wav frame", () => {
  const body = JSON.parse(
    buildTransmitPayload({ sessionId: "s", audioBase64: "UklGRg==" }),
  );
  assert.equal(body.SessionId, "s");
  assert.equal(body.SeqId, 1);
  assert.equal(body.IsEnd, 1);
  assert.equal(body.VoiceFileType, 2); // wav
  assert.equal(body.VoiceEncodeType, 1); // pcm
  assert.equal(body.UserVoiceData, "UklGRg==");
});

// ---------------------------------------------------------------------------
// The mapping — the tone verdict
// ---------------------------------------------------------------------------

const tone = (refTone, hypothesisTone, valid = true) => ({
  Valid: valid,
  RefTone: refTone,
  HypothesisTone: hypothesisTone,
});

const soeWord = ({ word, accuracy = 95, matchTag = 0, tone: t = null, phones = ["p"] }) => ({
  Word: word,
  PronAccuracy: accuracy,
  MatchTag: matchTag,
  PhoneInfos: phones.map((phone) => ({ Phone: phone, PronAccuracy: accuracy })),
  Tone: t,
});

const soeResponse = (words, extra = {}) => ({
  Response: {
    PronAccuracy: 90,
    PronFluency: 0.9,
    PronCompletion: 1,
    Words: words,
    ...extra,
  },
});

test("a tone said correctly is reported as measured, not as 'not measured'", () => {
  const grade = mapSoeResult(soeResponse([soeWord({ word: "百", tone: tone(3, 3) })]), {
    pinyin: "bǎi",
  });
  const [word] = grade.words;
  assert.equal(word.expectedTone, 3);
  assert.equal(word.actualTone, 3);
  assert.equal(word.isCorrect, true);
  assert.equal(word.isPartial, false);
});

test("a tone the learner actually got wrong is reported as the wrong tone", () => {
  // 战 is tone 4; suppose the learner said a rising tone. Azure made this
  // unknowable, so audit 39 could only report 0 and the screen read "not
  // measured". `HypothesisTone` is the value that was always missing.
  const grade = mapSoeResult(soeResponse([soeWord({ word: "战", tone: tone(4, 2) })]), {
    pinyin: "zhàn",
  });
  const [word] = grade.words;
  assert.equal(word.expectedTone, 4);
  assert.equal(word.actualTone, 2);
  assert.equal(word.isPartial, true); // right syllable, wrong tone
  assert.equal(word.isCorrect, false);
});

test("Tone.Valid false means not measured, and is never turned into a guess", () => {
  const grade = mapSoeResult(
    soeResponse([soeWord({ word: "不", tone: tone(2, -1, false) })]),
    { pinyin: "bú" },
  );
  const [word] = grade.words;
  assert.equal(word.expectedTone, 2);
  // The app's convention: 0 = "not measured", which CalligraphicPitchContour and
  // SpeakingFeedbackPanel already read.
  assert.equal(word.actualTone, 0);
  assert.equal(word.isPartial, false);
  assert.equal(word.isCorrect, true); // segments understood; no tone claim made
});

test("HypothesisTone -1 is not a tone even when Valid is true", () => {
  const grade = mapSoeResult(soeResponse([soeWord({ word: "我", tone: tone(3, -1, true) })]), {
    pinyin: "wǒ",
  });
  assert.equal(grade.words[0].actualTone, 0);
});

test("the authored reading beats the vendor's reference tone (多音字)", () => {
  // 长 in 长大 is zhǎng (3); out of context it reads cháng (2). When the page and the
  // vendor disagree the page wins, because marking a learner wrong for reading what
  // they were shown is the defect audit 39 removed.
  const grade = mapSoeResult(soeResponse([soeWord({ word: "长", tone: tone(2, 2) })]), {
    pinyin: "zhǎng",
  });
  assert.equal(grade.words[0].expectedTone, 3);
});

test("neutral tone comes from the pinyin, because SOE cannot express tone 5", () => {
  // SOE's Tone range is [-1,1,2,3,4]. 轻声 has no representation, so the authored
  // pinyin is the only source for it, and the heard tone stays unmeasured.
  const grade = mapSoeResult(
    soeResponse([soeWord({ word: "的", tone: tone(-1, -1, false) })]),
    { pinyin: "de" },
  );
  assert.equal(grade.words[0].expectedTone, 5);
  assert.equal(grade.words[0].actualTone, 0);
});

test("omissions count against the score and insertions do not", () => {
  const spoken = [
    soeWord({ word: "百", accuracy: 100, tone: tone(3, 3) }),
    soeWord({ word: "战", accuracy: 100, tone: tone(4, 4) }),
  ];
  const omitted = mapSoeResult(
    soeResponse([...spoken, soeWord({ word: "不", accuracy: -1, matchTag: 2 })]),
    { pinyin: "bǎi zhàn bú" },
  );
  // 100 + 100 + 0 over three words: saying two of three perfectly must not read 100.
  assert.equal(omitted.score, 67);
  assert.equal(omitted.words[2].isOmitted, true);

  const inserted = mapSoeResult(
    soeResponse([...spoken, soeWord({ word: "啊", accuracy: 100, matchTag: 1 })]),
    { pinyin: "bǎi zhàn" },
  );
  // An insertion is not in the reference, so it cannot be scored against.
  assert.equal(inserted.score, 100);
});

test("a multi-syllable word does not get one tone attributed to its syllables", () => {
  // `Tone` is per **word**. 今天 is one word with two syllables, so there is no way
  // to say which syllable the tone belongs to — reporting it for both would be
  // inventing. Character mode (`EvalMode 0`) is what keeps words single-syllable.
  const grade = mapSoeResult(
    soeResponse([soeWord({ word: "今天", tone: tone(1, 1), phones: ["j", "t"] })]),
    { pinyin: "jīn tiān" },
  );
  assert.deepEqual(grade.words.map((w) => w.actualTone), [0, 0]);
  assert.deepEqual(grade.words.map((w) => w.expectedTone), [1, 1]);
});

test("a word below the accuracy floor is not also blamed on its tone", () => {
  const grade = mapSoeResult(
    soeResponse([
      soeWord({ word: "百", accuracy: MIN_WORD_ACCURACY - 1, tone: tone(3, 1) }),
    ]),
    { pinyin: "bǎi" },
  );
  const [word] = grade.words;
  assert.equal(word.actualTone, 1); // the measurement is still reported
  assert.equal(word.isCorrect, false);
  assert.equal(word.isPartial, false); // the syllable was wrong, so not a tone-only fault
});

test("an SOE error is surfaced, not mapped into a grade", () => {
  assert.throws(
    () =>
      mapSoeResult({
        Response: {
          Error: { Code: "AuthFailure.SignatureFailure", Message: "bad sig" },
        },
      }),
    /SOE AuthFailure\.SignatureFailure: bad sig/,
  );
});

test("unit scores scale to 0-100 and -1 means 'not meaningful'", () => {
  const grade = mapSoeResult(
    soeResponse([], { PronAccuracy: -1, PronFluency: -1, PronCompletion: 0.5 }),
  );
  assert.equal(grade.accuracy, 0);
  assert.equal(grade.fluency, 0);
  assert.equal(grade.completeness, 50);
  assert.equal(grade.score, 0);
});

test("the mapper accepts a bare, unwrapped response body", () => {
  const bare = { PronAccuracy: 80, PronFluency: 0.5, PronCompletion: 1, Words: [] };
  assert.equal(mapSoeResult(bare).accuracy, 80);
});

test("toneOf reads both pinyin forms the app produces, and refuses junk", () => {
  assert.equal(toneOf("zhàn"), 4); // diacritic, as authored in the studio
  assert.equal(toneOf("zhan4"), 4); // numeric, as the dictionary supplies
  assert.equal(toneOf("de"), 5); // neutral
  assert.equal(toneOf(""), 0);
  assert.equal(toneOf("   "), 0);
  assert.equal(toneOf("bǎi"), 3);
});
