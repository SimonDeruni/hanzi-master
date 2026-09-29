"use strict";

/**
 * Tencent Cloud 智聆口语评测 / Smart Oral Evaluation ("SOE") — pronunciation and
 * **tone** grading.
 *
 * ## ⚠️ NOT ADOPTED — kept as a tested record, not as live code
 *
 * This module was built when audit 40 selected Tencent SOE, and the decision was then
 * reversed in favour of **on-device tone assessment** (`docs/LOCAL_TONE_PLAN.md`),
 * which grades tone without a vendor, a network call or a cross-border transfer.
 * Nothing wires this up. It is kept because it is fully tested and documented, and
 * because the next person to consider a vendor for tone should read §2.1 of the audit
 * rather than repeat the evaluation — but **it must not be connected by accident**.
 *
 * If it is ever adopted, the disclosure in `lib/l10n/app_en.arb`
 * (`aiConsentProvidersBody`, `aiDataPrivacyProvidersBody`, `aiDataPrivacySentBody`,
 * `aiDataPrivacyControlsBody`) and the store data-safety labels have to change with
 * it — see `docs/PRIVACY_UPDATE_TENCENT_AI_DATA.md`.
 *
 * ## What it is
 *
 * Tencent Cloud 智聆口语评测 / Smart Oral Evaluation ("SOE") — pronunciation and
 * **tone** grading.

 * Tencent SOE closes that gap. Every `WordRsp` carries a `Tone` struct:
 *
 *   Tone.Valid           检测结果是否有效   - is this detection trustworthy?
 *   Tone.RefTone         文本标准声调       - the expected tone, [-1,1,2,3,4]
 *   Tone.HypothesisTone  实际发音声调       - **the tone actually pronounced**
 *
 * `HypothesisTone` is the field audit 39 went looking for and Azure never had.
 * Audit 40 §2.1 is the comparison that selected SOE over iFlytek (which returns a
 * tone *verdict* and *score* but not the tone that was heard) and over Azure.
 *
 * Everything here is pure, so `node:test` can cover it: the signing, the request
 * bodies, and — the part that matters — the response mapping. The live call is the
 * only untested link, and it needs credentials.
 */

const crypto = require("crypto");

/** Tencent Cloud API signature v3 (TC3-HMAC-SHA256). */
const TC3_ALGORITHM = "TC3-HMAC-SHA256";
const SOE_HOST = "soe.tencentcloudapi.com";
const SOE_SERVICE = "soe";
const SOE_VERSION = "2018-07-24";

/** `VoiceFileType` 2 = wav; `VoiceEncodeType` 1 = pcm (docs: 16k/16bit/mono only). */
const VOICE_FILE_TYPE_WAV = 2;
const VOICE_ENCODE_TYPE_PCM = 1;

/** `WorkMode` 1 = 非流式一次性评估 — one-shot, no chunking. */
const WORK_MODE_ONESHOT = 1;
/** `EvalMode` 0 = 单字/词模式 — for Chinese this is 文字模式, i.e. per character. */
const EVAL_MODE_CHARACTER = 0;
/** `ServerType` 1 = 中文. **The API defaults to 0 (English)**, so this is not optional. */
const SERVER_TYPE_CHINESE = 1;

/**
 * `MatchTag`, per the SOE data structures:
 * 0 匹配 / 1 新增 (insertion) / 2 缺少 (omission) / 3 错读 / 4 未录入
 */
const MATCH_TAG = {
  MATCHED: 0,
  INSERTION: 1,
  OMISSION: 2,
  MISREAD: 3,
  UNLISTED: 4,
};

/**
 * At or above this word accuracy the *segments* were understood. Below it the
 * syllable itself was off, and reporting a tone fault on top of that would be
 * inventing a second fault.
 */
const MIN_WORD_ACCURACY = 60;

/** Tone values SOE reports. **There is no 5** — SOE does not encode 轻声. */
const SOE_TONES = [-1, 1, 2, 3, 4];

// ---------------------------------------------------------------------------
// Signing (TC3-HMAC-SHA256)
// ---------------------------------------------------------------------------

/** @returns {string} lowercase hex SHA-256 of a string or Buffer. */
function sha256Hex(data) {
  return crypto
    .createHash("sha256")
    .update(typeof data === "string" ? Buffer.from(data, "utf8") : data)
    .digest("hex");
}

/** @returns {Buffer} HMAC-SHA256. */
function hmacSha256(key, data) {
  return crypto
    .createHmac("sha256", key)
    .update(typeof data === "string" ? Buffer.from(data, "utf8") : data)
    .digest();
}

/** @returns {string} lowercase hex HMAC-SHA256. */
function hmacSha256Hex(key, data) {
  return hmacSha256(key, data).toString("hex");
}

/**
 * The UTC calendar date for a Unix timestamp — what the credential scope is keyed
 * on. Getting this wrong returns `AuthFailure.SignatureExpire` rather than anything
 * that names the real problem, so it is its own exported function.
 */
function credentialDate(timestampSeconds) {
  return new Date(timestampSeconds * 1000).toISOString().slice(0, 10);
}

/**
 * Step 1 — the canonical request.
 *
 * The signed header set mirrors Tencent's own worked example
 * (`content-type;host;x-tc-action`) rather than the bare minimum of
 * `content-type;host`, so the request is identical in shape to the one in their
 * docs. `x-tc-action` is lowercased because the spec lowercases every header value
 * that participates in the signature.
 */
function buildCanonicalRequest({ action, payload, host = SOE_HOST }) {
  const canonicalHeaders =
    "content-type:application/json; charset=utf-8\n" +
    `host:${host}\n` +
    `x-tc-action:${action.toLowerCase()}\n`;
  const signedHeaders = "content-type;host;x-tc-action";
  return [
    "POST", // HTTPRequestMethod
    "/", // CanonicalURI — always "/" for API 3.0
    "", // CanonicalQueryString — always "" for POST
    canonicalHeaders,
    signedHeaders,
    sha256Hex(payload), // HashedRequestPayload
  ].join("\n");
}

/** Step 2 — the string to sign. */
function buildStringToSign({ timestamp, date, canonicalRequest }) {
  return [
    TC3_ALGORITHM,
    String(timestamp),
    `${date}/${SOE_SERVICE}/tc3_request`,
    sha256Hex(canonicalRequest),
  ].join("\n");
}

/** Step 3 — the derived signing key (never the secret itself). */
function deriveSigningKey({ secretKey, date }) {
  const kDate = hmacSha256(`TC3${secretKey}`, date);
  const kService = hmacSha256(kDate, SOE_SERVICE);
  return hmacSha256(kService, "tc3_request");
}

/**
 * Step 4 — the `Authorization` header value, plus the intermediate strings.
 *
 * The intermediates are returned rather than kept private because they are the
 * only part of signing that can be asserted without live credentials: Tencent
 * redacts the keys in their published example, so there is no known-answer vector
 * to test the final signature against. Asserting the canonical request and the
 * string to sign is the strongest check available, and it is the part that fails
 * when a header casing or a carriage return drifts.
 */
function buildAuthorization({ secretId, secretKey, action, payload, timestamp }) {
  const date = credentialDate(timestamp);
  const canonicalRequest = buildCanonicalRequest({ action, payload });
  const stringToSign = buildStringToSign({ timestamp, date, canonicalRequest });
  const signature = hmacSha256Hex(
    deriveSigningKey({ secretKey, date }),
    stringToSign,
  );

  return {
    Authorization:
      `${TC3_ALGORITHM} Credential=${secretId}/${date}/${SOE_SERVICE}/tc3_request, ` +
      `SignedHeaders=content-type;host;x-tc-action, Signature=${signature}`,
    signature,
    date,
    canonicalRequest,
    stringToSign,
  };
}

/**
 * The full header set for one SOE call.
 *
 * The signature covers the payload, so `payload` must be the **exact string** sent
 * on the wire — re-serialising it after signing is the classic way to get
 * `AuthFailure.SignatureFailure`.
 */
function buildHeaders({ secretId, secretKey, action, payload, timestamp }) {
  const { Authorization } = buildAuthorization({
    secretId,
    secretKey,
    action,
    payload,
    timestamp,
  });
  return {
    Authorization,
    "Content-Type": "application/json; charset=utf-8",
    Host: SOE_HOST,
    "X-TC-Action": action,
    "X-TC-Version": SOE_VERSION,
    "X-TC-Timestamp": String(timestamp),
  };
}

// ---------------------------------------------------------------------------
// Response helpers
// ---------------------------------------------------------------------------

/** The tone marks the app's pinyin uses, so authored pinyin can be read server-side. */
const TONE_MARKS = {
  ā: 1, á: 2, ǎ: 3, à: 4,
  ē: 1, é: 2, ě: 3, è: 4,
  ī: 1, í: 2, ǐ: 3, ì: 4,
  ō: 1, ó: 2, ǒ: 3, ò: 4,
  ū: 1, ú: 2, ǔ: 3, ù: 4,
  ǖ: 1, ǘ: 2, ǚ: 3, ǜ: 4,
};

/**
 * The tone of a pinyin syllable — 1-4, **5 for neutral**, or 0 when unreadable.
 *
 * Accepts both forms the app produces, numeric (`zhàn4`) and diacritic (`zhàn`),
 * because the shadowing studio authors one and the dictionary supplies the other.
 */
function toneOf(syllable) {
  const text = String(syllable == null ? "" : syllable).trim();
  if (!text) return 0;
  const numeric = /([1-5])\s*$/.exec(text);
  if (numeric) return Number(numeric[1]);
  for (const ch of text) {
    if (TONE_MARKS[ch]) return TONE_MARKS[ch];
  }
  // No mark and no digit means neutral **only when the token actually looks like
  // pinyin**; otherwise an empty or mangled token would claim to be neutral tone.
  return /^[a-zü]+$/i.test(text) ? 5 : 0;
}

/** A 1-4 tone value, or 0 when SOE reported `-1` / anything out of range. */
function knownTone(value) {
  return Number.isInteger(value) && value >= 1 && value <= 4 ? value : 0;
}

/**
 * Whether SOE vouches for the tone it detected.
 *
 * `Tone.Valid` is the vendor's own "don't trust this" flag, and it is the reason
 * the integration does not need to invent a confidence heuristic: SOE says when
 * the detection is unreliable, and that maps straight onto the app's
 * **`actualTone === 0` = "not measured"** convention, which
 * `CalligraphicPitchContour` and `SpeakingFeedbackPanel` already read.
 */
function toneIsMeasured(tone) {
  if (!tone || typeof tone !== "object") return false;
  if (tone.Valid !== true) return false;
  return knownTone(tone.HypothesisTone) !== 0;
}

/** SOE reports accuracy in [-1, 100] where **-1 means "no match at all"**. */
function normaliseAccuracy(value) {
  const number = typeof value === "number" ? value : Number(value);
  if (!Number.isFinite(number) || number < 0) return 0;
  return Math.min(100, number);
}

/** SOE reports fluency and completion in [0, 1], with -1 for "not meaningful". */
function scaleUnit(value) {
  const number = typeof value === "number" ? value : Number(value);
  if (!Number.isFinite(number) || number < 0) return 0;
  return Math.round(Math.min(1, number) * 100);
}

/** The same four bands the Azure path used, so the copy does not change. */
function feedbackFor(score) {
  if (score >= 90) return "Perfect pronunciation! Sounds like a native speaker.";
  if (score >= 80) return "Great job! A few minor tone inaccuracies.";
  if (score >= 60) return "Not bad, but your tones need some work.";
  return "Keep practicing! Listen to the native audio and try again.";
}

/** SOE wraps every payload in `{ Response: {…} }` and reports failures inside it. */
function unwrapSoeResponse(raw) {
  const response = raw && raw.Response ? raw.Response : raw;
  if (!response || typeof response !== "object") {
    throw new Error("SOE returned no Response object");
  }
  if (response.Error) {
    const code = response.Error.Code || "Unknown";
    const message = response.Error.Message || "";
    throw new Error(`SOE ${code}: ${message}`);
  }
  return response;
}

// ---------------------------------------------------------------------------
// Request bodies
// ---------------------------------------------------------------------------

/**
 * `InitOralProcess` — must precede every evaluation, and carries the settings that
 * are easiest to get silently wrong:
 *
 *   - **`ServerType` defaults to 0 (English).** Omitting it grades Chinese audio
 *     with the English model, which fails quietly rather than loudly.
 *   - **`EvalMode 0` is 文字模式 for Chinese** — per character. That is what makes
 *     each `WordRsp` a single syllable, and therefore what makes its `Tone`
 *     unambiguous.
 *   - **`ScoreCoeff` leans the strictness.** The doc says
 *     `1.0：适用于最小年龄段用户，一般对应儿童应用场景`, which is a real answer to the
 *     false-negative metric — so it is a parameter, not a constant.
 */
function buildInitPayload({
  sessionId,
  refText,
  evalMode = EVAL_MODE_CHARACTER,
  scoreCoeff = 3.5,
  soeAppId,
}) {
  const payload = {
    SessionId: sessionId,
    RefText: refText,
    WorkMode: WORK_MODE_ONESHOT,
    EvalMode: evalMode,
    ScoreCoeff: scoreCoeff,
    ServerType: SERVER_TYPE_CHINESE,
  };
  if (soeAppId) payload.SoeAppId = soeAppId;
  return JSON.stringify(payload);
}

/**
 * `TransmitOralProcess` — one shot: `SeqId` 1, `IsEnd` 1, the whole file.
 *
 * The audio must be 16 kHz / 16-bit / mono, BASE64, and **a complete frame** — SOE
 * rejects a WAV header that ends mid-sample
 * (`InvalidParameterValue.WAVHeaderDecodeFailed`).
 */
function buildTransmitPayload({
  sessionId,
  audioBase64,
  seqId = 1,
  isEnd = 1,
  soeAppId,
}) {
  const payload = {
    SessionId: sessionId,
    SeqId: seqId,
    IsEnd: isEnd,
    VoiceFileType: VOICE_FILE_TYPE_WAV,
    VoiceEncodeType: VOICE_ENCODE_TYPE_PCM,
    UserVoiceData: audioBase64,
  };
  if (soeAppId) payload.SoeAppId = soeAppId;
  return JSON.stringify(payload);
}

// ---------------------------------------------------------------------------
// The mapping — where the tone verdict finally becomes real
// ---------------------------------------------------------------------------

/**
 * Map an SOE result onto the exact JSON shape `PronunciationGrade` reads.
 *
 * The shape is deliberately the same one the Azure path returns, so every consumer
 * (shadowing studio, live call, Echo Hall roleplay, flashcards speaking mode) needs
 * no change beyond receiving better data.
 *
 * @param {object} raw  the SOE response body, wrapped or unwrapped
 * @param {{pinyin?: string}} reference  the pinyin the learner was **shown**.
 *   Authored pinyin wins over SOE's `RefTone`, because grading a 多音字 at a
 *   context-free default is the defect audit 39 fixed on the Azure path.
 */
function mapSoeResult(raw, { pinyin = "" } = {}) {
  const response = unwrapSoeResponse(raw);
  const soeWords = Array.isArray(response.Words) ? response.Words : [];
  const authored = String(pinyin || "")
    .trim()
    .split(/\s+/)
    .filter(Boolean);

  const words = [];
  let pinyinIndex = 0;
  let scoreTotal = 0;
  let scoreCount = 0;

  for (const soeWord of soeWords) {
    const wordText = String(soeWord.Word == null ? "" : soeWord.Word);
    const chars = Array.from(wordText);
    const matchTag = Number.isInteger(soeWord.MatchTag)
      ? soeWord.MatchTag
      : MATCH_TAG.MATCHED;
    const accuracy = normaliseAccuracy(soeWord.PronAccuracy);
    const isOmission = matchTag === MATCH_TAG.OMISSION;
    const isInsertion = matchTag === MATCH_TAG.INSERTION;
    const syllables = Array.isArray(soeWord.PhoneInfos) ? soeWord.PhoneInfos : [];

    // `Tone` is a per-**word** field, so it is only unambiguous when the word is a
    // single syllable — which is what character mode gives us. A longer word would
    // need its tone split across syllables and the API does not offer that, so
    // those characters report "not measured" rather than a guess.
    const toneAttributable = syllables.length <= 1;
    const heardTone =
      toneAttributable && toneIsMeasured(soeWord.Tone)
        ? soeWord.Tone.HypothesisTone
        : 0;
    const vendorRefTone =
      toneAttributable && soeWord.Tone ? knownTone(soeWord.Tone.RefTone) : 0;

    // Omissions count against the score and insertions do not — the audit 39 rule,
    // kept identical so the two providers agree on what a score means.
    if (!isInsertion) {
      scoreCount += 1;
      scoreTotal += isOmission ? 0 : accuracy;
    }

    const units = chars.length > 0 ? chars : [wordText];
    units.forEach((char, index) => {
      const authoredTone = toneOf(authored[pinyinIndex + index]);
      const expectedTone = authoredTone || vendorRefTone || 0;
      // ***The point of the whole integration.*** `HypothesisTone` is measured, not
      // inferred, so a genuinely wrong tone is reported as the wrong tone instead of
      // being back-filled from the accuracy percentage the way audit 39 found.
      const actualTone = heardTone;
      const segmentsUnderstood = !isOmission && accuracy >= MIN_WORD_ACCURACY;
      const toneMatches =
        actualTone > 0 && expectedTone > 0 ? actualTone === expectedTone : null;

      words.push({
        word: char,
        pinyin: authored[pinyinIndex + index] || "",
        english: null,
        isCorrect: segmentsUnderstood && toneMatches !== false,
        isPartial: segmentsUnderstood && toneMatches === false,
        isOmitted: isOmission,
        feedback: "",
        wordScore: Math.round(accuracy),
        accuracyScore: accuracy,
        accuracy: Math.round(accuracy),
        expectedTone,
        actualTone,
        phonemes: syllables.map((syllable) => ({
          phoneme: String(syllable.Phone == null ? "" : syllable.Phone),
          accuracy: normaliseAccuracy(syllable.PronAccuracy),
        })),
      });
    });

    pinyinIndex += chars.length;
  }

  const score = scoreCount > 0 ? Math.round(scoreTotal / scoreCount) : 0;
  return {
    score,
    accuracy: normaliseAccuracy(response.PronAccuracy),
    completeness: scaleUnit(response.PronCompletion),
    fluency: scaleUnit(response.PronFluency),
    overallFeedback: feedbackFor(score),
    words,
  };
}

module.exports = {
  TC3_ALGORITHM,
  SOE_HOST,
  SOE_SERVICE,
  SOE_VERSION,
  VOICE_FILE_TYPE_WAV,
  VOICE_ENCODE_TYPE_PCM,
  WORK_MODE_ONESHOT,
  EVAL_MODE_CHARACTER,
  SERVER_TYPE_CHINESE,
  MATCH_TAG,
  MIN_WORD_ACCURACY,
  SOE_TONES,
  sha256Hex,
  hmacSha256,
  hmacSha256Hex,
  credentialDate,
  buildCanonicalRequest,
  buildStringToSign,
  deriveSigningKey,
  buildAuthorization,
  buildHeaders,
  TONE_MARKS,
  toneOf,
  knownTone,
  toneIsMeasured,
  normaliseAccuracy,
  scaleUnit,
  feedbackFor,
  unwrapSoeResponse,
  buildInitPayload,
  buildTransmitPayload,
  mapSoeResult,
};
