const { onCall, onRequest, HttpsError } = require("firebase-functions/v2/https");
const { defineSecret } = require("firebase-functions/params");
const admin = require("firebase-admin");
const fetch = require("node-fetch");
const cors = require("cors")({ origin: true });
const {
  MODEL_VERSION,
  PROMPT_VERSION,
  OUTPUT_SCHEMA,
  parseInput,
  sourceHash,
  cacheIdentity,
  canonicalSource,
  buildPrompt,
  outputText,
  extractGeminiJson,
} = require("./dictionary-expansion");
const {
  recordingIdentity,
  boundariesPath,
  validateBoundaries,
  MAX_AUDIO_BYTES,
} = require("./tts-cache");
const { requireUser } = require("./ai-proxy-auth");

admin.initializeApp();

const revenueCatSecretKey = defineSecret("REVENUECAT_SECRET_API_KEY");
const geminiApiKey = defineSecret("GEMINI_API_KEY");
// NOTE: the speech cache deliberately holds **no** Azure credential. The
// recordings it stores are uploaded by the app, which already has them from its
// own streamed playback, so the server never needs to speak to Azure and there is
// nothing extra to configure in Secret Manager for it.

/**
 * Reject a call that carries no verified identity.
 *
 * W0 (`docs/AI_CACHING_ROADMAP.md`): these proxies forward to a paid model with
 * this project's key, so an unauthenticated call makes them an **open relay** -
 * which is exactly what they were until now, with the only usage limit running
 * on the client. Returns the uid, or `null` after writing the 401 itself, so a
 * handler reads `if (!(await authenticatedUid(req, res))) return;`.
 */
async function authenticatedUid(req, res) {
  try {
    const { uid } = await requireUser(req);
    return uid;
  } catch (error) {
    console.warn("AI proxy rejected an unauthenticated call:", error.message);
    res.status(401).json({ error: "Authentication required" });
    return null;
  }
}

const EXPANSION_DAILY_QUOTA = 20;
const GENERATION_LEASE_MS = 2 * 60 * 1000;
const FAILURE_RETRY_MS = 30 * 1000;

function publicExpansion(cache, cached) {
  return {
    text: outputText(cache.output),
    structuredOutput: cache.output,
    languageCode: cache.provenance.languageCode,
    sourceDefinitionHash: cache.provenance.sourceDefinitionHash,
    modelVersion: cache.provenance.modelVersion,
    promptVersion: cache.provenance.promptVersion,
    cached,
    provenance: cache.provenance,
  };
}

async function callGemini(source, languageCode) {
  const apiKey = geminiApiKey.value() || process.env.GEMINI_API_KEY_LOCAL;
  if (!apiKey) throw new Error("GEMINI_API_KEY is not configured");
  const url = `https://generativelanguage.googleapis.com/v1beta/models/${MODEL_VERSION}:generateContent?key=${encodeURIComponent(apiKey)}`;
  const response = await fetch(url, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      contents: [{ role: "user", parts: [{ text: buildPrompt(source, languageCode) }] }],
      generationConfig: {
        responseMimeType: "application/json",
        responseSchema: OUTPUT_SCHEMA,
        temperature: 0.2,
      },
    }),
  });
  const payload = await response.json().catch(() => null);
  if (!response.ok) throw new Error(`Gemini request failed (${response.status})`);
  return extractGeminiJson(payload);
}

/**
 * Produces a server-grounded dictionary expansion. The client can select only
 * an imported source record and output language; it cannot submit source text
 * or prompt text.
 */
exports.getDictionaryExpansionV1 = onCall(
  // Authentication, server-owned source records, eligibility, quotas, hashes,
  // and strict output validation remain enforced. App Check enforcement stays
  // off until every shipping iOS bundle is registered for App Attest.
  { enforceAppCheck: false, secrets: [geminiApiKey], timeoutSeconds: 120 },
  async (request) => {
    if (!request.auth) throw new HttpsError("unauthenticated", "Sign in to request an expansion.");

    let input;
    try { input = parseInput(request.data); } catch (error) {
      throw new HttpsError("invalid-argument", error.message);
    }

    const db = admin.firestore();
    const sourceRef = db.collection("dictionarySources").doc(input.wordId);
    const eligibilityRef = db.collection("dictionaryScoreEligibility")
      .doc(`${input.wordId}_${input.languageCode}`);
    const [sourceSnapshot, eligibilitySnapshot] = await Promise.all([
      sourceRef.get(), eligibilityRef.get(),
    ]);
    if (!sourceSnapshot.exists) throw new HttpsError("not-found", "Dictionary source was not found.");

    let source;
    try { source = canonicalSource(sourceSnapshot.data()); } catch (error) {
      console.error("Invalid canonical dictionary source", { wordId: input.wordId, error });
      throw new HttpsError("failed-precondition", "Dictionary source is unavailable.");
    }
    const storedHash = sourceSnapshot.get("sourceDefinitionHash");
    if (storedHash !== input.sourceDefinitionHash || sourceHash(source.definition) !== storedHash) {
      throw new HttpsError("failed-precondition", "Dictionary source has changed. Refresh and try again.");
    }
    const eligibility = eligibilitySnapshot.exists ? eligibilitySnapshot.data() : null;
    if (!eligibility || eligibility.eligible !== true ||
        eligibility.sourceDefinitionHash !== input.sourceDefinitionHash) {
      throw new HttpsError("failed-precondition", "This dictionary entry is not eligible for expansion.");
    }

    const cacheId = cacheIdentity(input);
    const cacheRef = db.collection("dictionaryExpansionCache").doc(cacheId);
    const day = new Date().toISOString().slice(0, 10);
    const quotaRef = db.collection("dictionaryExpansionQuotas").doc(`${request.auth.uid}_${day}`);
    const leaseToken = require("node:crypto").randomUUID();
    const now = Date.now();

    const acquisition = await db.runTransaction(async (transaction) => {
      const [cacheSnapshot, quotaSnapshot] = await Promise.all([
        transaction.get(cacheRef), transaction.get(quotaRef),
      ]);
      const cache = cacheSnapshot.exists ? cacheSnapshot.data() : null;
      if (cache && cache.state === "ready") return { ready: cache };
      if (cache && cache.state === "generating" && cache.leaseExpiresAtMs > now) return { busy: true };
      if (cache && cache.state === "failed" && cache.retryAfterMs > now) return { retryLater: true };

      const quota = quotaSnapshot.exists ? quotaSnapshot.data() : {};
      const used = Number.isInteger(quota.used) ? quota.used : 0;
      if (used >= EXPANSION_DAILY_QUOTA) return { quotaExceeded: true };

      transaction.set(quotaRef, {
        uid: request.auth.uid, day, used: used + 1,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
      transaction.set(cacheRef, {
        state: "generating", leaseToken, leaseExpiresAtMs: now + GENERATION_LEASE_MS,
        wordId: input.wordId, languageCode: input.languageCode,
        sourceDefinitionHash: input.sourceDefinitionHash,
        modelVersion: MODEL_VERSION, promptVersion: PROMPT_VERSION,
        attempts: (cache && Number.isInteger(cache.attempts) ? cache.attempts : 0) + 1,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      }, { merge: true });
      return { acquired: true };
    });

    if (acquisition.ready) return publicExpansion(acquisition.ready, true);
    if (acquisition.quotaExceeded) throw new HttpsError("resource-exhausted", "Daily expansion quota reached.");
    if (acquisition.busy || acquisition.retryLater) {
      throw new HttpsError("unavailable", "Expansion is being prepared. Retry shortly.");
    }

    try {
      const output = await callGemini(source, input.languageCode);
      const provenance = {
        wordId: input.wordId,
        languageCode: input.languageCode,
        sourceDefinitionHash: input.sourceDefinitionHash,
        modelVersion: MODEL_VERSION,
        promptVersion: PROMPT_VERSION,
      };
      const saved = await db.runTransaction(async (transaction) => {
        const snapshot = await transaction.get(cacheRef);
        const current = snapshot.data();
        if (!current || current.state !== "generating" || current.leaseToken !== leaseToken) return false;
        transaction.set(cacheRef, {
          state: "ready", output, provenance,
          generatedAt: admin.firestore.FieldValue.serverTimestamp(),
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
          leaseToken: admin.firestore.FieldValue.delete(),
          leaseExpiresAtMs: admin.firestore.FieldValue.delete(),
          retryAfterMs: admin.firestore.FieldValue.delete(),
          lastError: admin.firestore.FieldValue.delete(),
        }, { merge: true });
        return true;
      });
      if (!saved) throw new Error("generation lease was lost");
      return publicExpansion({ output, provenance }, false);
    } catch (error) {
      await db.runTransaction(async (transaction) => {
        const snapshot = await transaction.get(cacheRef);
        const current = snapshot.data();
        if (!current || current.leaseToken !== leaseToken) return;
        transaction.set(cacheRef, {
          state: "failed", retryAfterMs: Date.now() + FAILURE_RETRY_MS,
          lastError: "provider-or-validation-failure",
          failedAt: admin.firestore.FieldValue.serverTimestamp(),
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
          leaseToken: admin.firestore.FieldValue.delete(),
          leaseExpiresAtMs: admin.firestore.FieldValue.delete(),
        }, { merge: true });
      }).catch((writeError) => console.error("Could not record expansion failure", writeError));
      console.error("Dictionary expansion failed", { cacheId, wordId: input.wordId, error });
      throw new HttpsError("internal", "Expansion generation failed. Retry later.");
    }
  },
);

async function deleteDocumentTree(path) {
  const document = admin.firestore().doc(path);
  try {
    await admin.firestore().recursiveDelete(document);
  } catch (error) {
    if (error.code !== 5 && error.code !== "not-found") throw error;
  }
}

async function deleteStoragePrefix(prefix) {
  const bucket = admin.storage().bucket();
  await bucket.deleteFiles({ prefix, force: true });
}

async function deleteRevenueCatCustomer(uid) {
  const apiKey = revenueCatSecretKey.value();
  if (!apiKey) {
    throw new Error("REVENUECAT_SECRET_API_KEY is not configured");
  }

  const response = await fetch(
    `https://api.revenuecat.com/v1/subscribers/${encodeURIComponent(uid)}`,
    {
      method: "DELETE",
      headers: {
        Authorization: `Bearer ${apiKey}`,
        "Content-Type": "application/json",
      },
    },
  );

  // A missing subscriber is already in the desired state.
  if (!response.ok && response.status !== 404) {
    const body = await response.text();
    throw new Error(`RevenueCat deletion failed (${response.status}): ${body}`);
  }
}

/**
 * Permanently deletes all server-side data owned by the authenticated user.
 *
 * Every cleanup operation is idempotent. Firebase Auth is deliberately deleted
 * last so a partial failure remains retryable by the same authenticated user.
 */
exports.deleteAccountV1 = onCall(
  { secrets: [revenueCatSecretKey], timeoutSeconds: 120 },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError("unauthenticated", "Sign in before deleting your account.");
    }

    const authTime = Number(request.auth.token.auth_time || 0);
    if (!authTime || Date.now() / 1000 - authTime > 5 * 60) {
      throw new HttpsError(
        "failed-precondition",
        "Recent authentication is required before account deletion.",
      );
    }

    const uid = request.auth.uid;
    try {
      // These are the only supported user-owned namespaces. Keep this list in
      // sync whenever a new cloud persistence path is introduced.
      await Promise.all([
        deleteDocumentTree(`users/${uid}`),
        deleteStoragePrefix(`users/${uid}/`),
        deleteStoragePrefix(`user_uploads/${uid}/`),
      ]);
      await deleteRevenueCatCustomer(uid);

      try {
        await admin.auth().deleteUser(uid);
      } catch (error) {
        if (error.code !== "auth/user-not-found") throw error;
      }

      return { deleted: true };
    } catch (error) {
      console.error("Account deletion failed", { uid, error });
      throw new HttpsError(
        "internal",
        "Account deletion could not be completed. No sign-in account was deleted.",
      );
    }
  },
);

exports.generateContentProxyV2 = onRequest({ cors: true, invoker: "public", secrets: [geminiApiKey] }, (req, res) => {
  cors(req, res, async () => {
    if (req.method !== "POST") {
      return res.status(405).send("Method Not Allowed");
    }

    // W0: require a signed-in app user, so this is not an open relay for the
    // project's key (see ai-proxy-auth.js).
    if (!(await authenticatedUid(req, res))) return;

    // W0: the key is a Secret Manager parameter now, not a process env var.
    const apiKey = geminiApiKey.value();
    if (!apiKey) {
      return res.status(500).json({ error: "Missing Gemini API Key" });
    }

    try {
      const { model, body } = req.body;
      const targetModel = model || "gemini-2.5-flash";
      const url = `https://generativelanguage.googleapis.com/v1beta/models/${targetModel}:generateContent?key=${apiKey}`;

      const response = await fetch(url, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(body),
      });

      const data = await response.json();
      return res.status(response.status).json(data);
    } catch (error) {
      console.error("Proxy error:", error);
      return res.status(500).json({ error: "Internal Server Error" });
    }
  });
});

exports.openRouterProxyV2 = onRequest({ cors: true, invoker: "public", secrets: [geminiApiKey] }, (req, res) => {
  cors(req, res, async () => {
    if (req.method !== "POST") {
      return res.status(405).send("Method Not Allowed");
    }

    // W0: require a signed-in app user, so this is not an open relay for the
    // project's key (see ai-proxy-auth.js).
    if (!(await authenticatedUid(req, res))) return;

    // This proxy targets Gemini's OpenAI-compatible endpoint with the project
    // key, which is why it is a Secret Manager parameter rather than a value
    // the app carries.
    const apiKey = geminiApiKey.value();
    if (!apiKey) {
      return res.status(500).json({ error: "Missing Gemini API Key" });
    }

    try {
      // Use Gemini's official OpenAI-compatible endpoint
      const url = "https://generativelanguage.googleapis.com/v1beta/openai/chat/completions";
      
      // Intercept the request and force the model to Gemini 2.5 Flash, ignoring any OpenRouter models
      const requestBody = { ...req.body, model: "gemini-2.5-flash" };

      const response = await fetch(url, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "Authorization": `Bearer ${apiKey}`
        },
        body: JSON.stringify(requestBody),
      });

      if (req.body.stream) {
        res.setHeader("Content-Type", "text/event-stream");
        res.setHeader("Cache-Control", "no-cache");
        res.setHeader("Connection", "keep-alive");
        res.status(response.status);
        response.body.pipe(res);
      } else {
        const data = await response.json();
        return res.status(response.status).json(data);
      }
    } catch (error) {
      console.error("Proxy error:", error);
      return res.status(500).json({ error: "Internal Server Error" });
    }
  });
});

// ---------------------------------------------------------------------------
// Shared speech cache
// ---------------------------------------------------------------------------
//
// One recording per (sentence, voice, rate), shared by every user. Speech is the
// safest thing to share - the bytes are identical for a given request, the
// content is the app's own (never something a user typed), and Azure is metered
// against a 4-hour weekly quota, so every reused recording is quota kept.
//
// The app keeps streaming from Azure for the *first* listener, exactly as it
// does today, so nobody waits for this: on a miss it asks `warmTtsAudioV2` to
// record the sentence for everyone who comes after.
//
// See `tts-cache.js` for the identity rules, and `test/tts-cache.test.js` for the
// two that must never be wrong: everything that changes the sound is in the key
// (voice, and rate), and nothing that does not is.

/**
 * Read the word timings stored with a recording.
 *
 * Returns an empty list for anything unreadable. Timings are an enhancement, so
 * a recording without them must still be playable - just without highlighting -
 * rather than becoming an error.
 */
function parseBoundaries(buffer) {
  if (!buffer) return [];
  try {
    const parsed = JSON.parse(buffer.toString("utf8"));
    return Array.isArray(parsed) ? parsed : [];
  } catch (error) {
    console.warn("Stored speech timings were unreadable:", error.message);
    return [];
  }
}

/**
 * Read a recording, or `null` when there is nothing to read.
 *
 * Never throws. A bucket that is missing, not yet enabled or unreachable must
 * look exactly like a miss, so the app carries on with its own path - a cache
 * that can break speech would be worse than no cache at all.
 */
async function readRecording(objectPath) {
  try {
    const file = admin.storage().bucket().file(objectPath);
    const [exists] = await file.exists();
    if (!exists) return null;
    const [buffer] = await file.download();
    return buffer;
  } catch (error) {
    console.warn("Speech cache read failed (treated as a miss):", error.message);
    return null;
  }
}

/** Store an object. Never throws: by this point the caller has the content. */
async function storeRecording(objectPath, buffer, contentType = "audio/mpeg") {
  try {
    await admin.storage().bucket().file(objectPath).save(buffer, {
      contentType,
      metadata: { cacheControl: "public, max-age=31536000, immutable" },
    });
    return true;
  } catch (error) {
    console.warn("Speech cache write failed:", error.message);
    return false;
  }
}

/**
 * Hand back a recording of one sentence, if it has already been made.
 *
 * **No sign-in required, on purpose.** This half can only return audio the
 * project has already paid for - a miss costs nothing and answers `hit: false` -
 * so a signed-out listener still benefits from everyone else's recordings. The
 * half that *spends* money is `warmTtsAudioV2`, and that one requires a user.
 *
 * No secrets either: reading the bucket needs none, so the read path cannot fail
 * for want of Secret Manager configuration.
 */
exports.getTtsAudioV2 = onCall(async (request) => {
  let identity;
  try {
    identity = recordingIdentity(request.data || {});
  } catch (error) {
    // Malformed or oversized input is not worth surfacing to a learner
    // mid-sentence: it is simply not cacheable.
    return { hit: false, reason: error.message };
  }
  const audio = await readRecording(identity.objectPath);
  if (!audio) return { hit: false };
  // The timings must travel with the audio: they drive the highlighting that
  // follows the spoken words, and timings from a different take would appear to
  // slide against the voice. An empty list means "no timings", which the app
  // treats as "still playable, just without highlighting".
  const boundaries = parseBoundaries(
    await readRecording(boundariesPath(identity.key))
  );
  return {
    hit: true,
    audioBase64: audio.toString("base64"),
    boundaries,
    contentType: "audio/mpeg",
    bytes: audio.length,
  };
});

/**
 * Turn the app's base64 audio into bytes, refusing anything implausible.
 *
 * The app uploads the recording it has already streamed and played. That is not
 * a shortcut - it is the only way to keep the audio and its word timings
 * consistent, because Azure returns those timings on its streaming path, so the
 * app is the one party holding a *matching* pair.
 */
function decodeAudio(audioBase64) {
  if (typeof audioBase64 !== "string" || audioBase64.length === 0) {
    throw new HttpsError("invalid-argument", "audioBase64 is required.");
  }
  const buffer = Buffer.from(audioBase64, "base64");
  if (buffer.length === 0) {
    throw new HttpsError("invalid-argument", "audioBase64 was not decodable.");
  }
  // The ceiling matters because the length comes from the caller: without it, the
  // bucket is an open invitation.
  if (buffer.length > MAX_AUDIO_BYTES) {
    throw new HttpsError(
      "invalid-argument",
      `audio exceeds ${MAX_AUDIO_BYTES} bytes.`
    );
  }
  return buffer;
}

/**
 * Store a sentence for everyone who comes after.
 *
 * The app calls this *after* it played its own streamed audio, and does not wait
 * for the reply, so the first listener pays no latency cost. It requires a
 * signed-in caller because it is the half that writes to shared storage.
 *
 * **Trust boundary, stated plainly:** the audio and timings come from the app, so
 * a modified client could store a take that does not match its key. The damage is
 * bounded to that one sentence - the key is a hash of text, voice and rate - and
 * at worst to highlighting, and the shape is validated above. The real fix is App
 * Check, which this project already depends on but does not yet enforce here.
 * Recorded rather than hidden.
 */
exports.warmTtsAudioV2 = onCall(async (request) => {
    if (!request.auth || !request.auth.uid) {
      throw new HttpsError(
        "unauthenticated",
        "Sign in to contribute to the shared speech cache."
      );
    }

    let identity;
    try {
      identity = recordingIdentity(request.data || {});
    } catch (error) {
      throw new HttpsError("invalid-argument", error.message);
    }

    const data = request.data || {};
    const audio = decodeAudio(data.audioBase64);
    let boundaries;
    try {
      boundaries = validateBoundaries(data.boundaries);
    } catch (error) {
      throw new HttpsError("invalid-argument", error.message);
    }

    // Already recorded: keep the existing take rather than replacing good audio
    // with a later one, so one sentence does not change voice mid-book.
    if (await readRecording(identity.objectPath)) {
      return { stored: false, alreadyPresent: true };
    }

    const stored = await storeRecording(identity.objectPath, audio);
    const timingsStored =
      boundaries.length > 0 &&
      (await storeRecording(
        boundariesPath(identity.key),
        Buffer.from(JSON.stringify(boundaries), "utf8"),
        "application/json"
      ));
    return {
      stored,
      timingsStored,
      bytes: audio.length,
      boundaries: boundaries.length,
    };
  }
);

