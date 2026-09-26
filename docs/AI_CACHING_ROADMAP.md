# AI & API Caching Roadmap

**Status:** PLAN ONLY — no code touched. Written 2026-09-26.
**Question it answers:** *"look at every API call that could be cached, either on the phone
or on Firebase."*
**Reproduction:** every number below was measured with the commands in § 8.

---

## § 1 The complete outbound surface

The app makes **24 kinds of outbound call**. Three are cached well, five are cached
poorly, and the rest are not cached at all. `Pri` is **P1** = a cost/quota risk today,
**P2** = a clear win, **P3** = polish.

### § 1.1 LLM (Gemini / OpenRouter) — 22 public methods in `gemini_service.dart`

Routed two ways: **13** raw calls to `generativelanguage.googleapis.com` (via
`api_key_pool`), plus `GeminiProxyClient` → `generateContentProxyV2` /
`openRouterProxyV2` — both **stateless**.

| # | Call | Cached today | Shareable? | Recommended cache | Pri |
|---|---|---|---|---|---|
| 1 | `parseRawStoryToAiStory` (bundled text + HSK) | device Hive `story_$deckId` | ✅ | server, `sha256(storyId‖HSK‖promptVersion)` | **P1** |
| 2 | `simplifyTextToHsk`, `_simplifyArticleChunk` | none | ✅ | server, by source-URL hash + target HSK | **P1** |
| 3 | `explainGrammar`, `generateSentenceLesson`, `generateContext`, `explainInContext` | device Hive (`contextCacheKey`) | ✅ | server, `sha256(text‖level‖lang‖promptVersion)` | **P1** |
| 4 | `translateObject`, `translateTextToEnglish` | device Hive `def_$word` — **no language, no version** | ✅ | server, `(textHash, lang, modelVersion, promptVersion)` | **P1** |
| 5 | `generateDetailedSummary` | device Hive `detailed_summary_$title` — **no version** | ✅ | server, by content id + `promptVersion` | **P1** |
| 6 | `generateGradedStory`, `generateStory` | none | ✅ | server, by blueprint id + HSK | P2 |
| 7 | `generateArticleInsight`, `generateCulturalInsight` | none | ✅ | server, by content id + lang | P2 |
| 8 | `generateVideoBriefing` | none | ✅ | server, by video id + transcript hash | P2 |
| 9 | `compareNuances` | device Hive `_nuanceCacheKey(sorted)` ✅ **the correct pattern** | ✅ | extend with lang + `promptVersion` | P2 |
| 10 | `sendMessage` (chat) | device only | ❌ personal | device only — **never** server | — |
| 11 | `transcribeAudio` (user voice) | none | ❌ personal | — | — |
| 12 | `analyzeImage`, `extractTextFromImage`, `identifySpecificObject` | none | ❌ user photos | device only | — |

**Measured:** ~20 distinct operations, **5** device cache keys, **1** shared server cache
(`getDictionaryExpansionV1` → `dictionaryExpansionCache`).

### § 1.2 Everything that is not an LLM

| # | Call | Cached today | Shareable? | Recommended cache | Pri |
|---|---|---|---|---|---|
| 13 | **Azure Neural TTS** (`audio_service`) | ✅ device dir `tts_cache/$hanzi.wav` + deliberate `_hashText` | ✅ **byte-identical for same text+voice** | **Firebase Storage + CDN**, keyed `textHash + voice`; extend past single characters | **P1** |
| 14 | **Google Translate** `translate_a/single?client=gtx` ×2 | ✅ device Hive `local_translations_cache_v6` (versioned — the app's only real invalidation) | ✅ | server cache per `(text, lang)` **and replace the endpoint** (§ 6) | **P1** |
| 15 | **Story/article source HTML** (`story_fetcher_service`, bare `http.get`) | ❌ **nothing** | ✅ immutable per URL | device + server, by URL | P2 |
| 16 | **`hanzi-writer-data@2.0.1/$char.json`** (stroke data) | ❌ nothing | ✅ immutable, versioned in the URL | bundle or cache per character | P2 |
| 17 | **YouTube thumbnails** — `i.ytimg.com` **4047** URL constructions | **3** `CachedNetworkImage` vs 9 `Image.network` + 7 `NetworkImage` | ✅ | device disk cache (2 of 3 image widgets are uncached) | P2 |
| 18 | YouTube transcripts / show metadata (per video id) | none | ✅ | server, by video id | P2 |
| 19 | Book downloads (`book_download_service`) | ✅ support dir | ✅ | fine as-is | — |
| 20 | Firestore `stories` raw text | ✅ shared collection | ✅ | already right | — |
| 21 | Wikimedia covers (15 URLs) | partial | ✅ | device cache | P3 |
| 22 | ML Kit translate / OCR (on-device) | ✅ same Hive box | n/a no network | fine | — |
| 23 | Azure **pronunciation assessment** | — | ❌ user voice | not cacheable; reference side could be precomputed | — |
| 24 | Firebase Auth, Google Sign-In, RevenueCat | — | ❌ by design | none | — |

---

## § 2 The pattern already exists — reuse it, don't invent one

`functions/index.js` + `functions/dictionary-expansion.js` implement a genuinely
good shared cache for dictionary expansion. Every other workstream below should copy
this shape rather than design a new one.

| Element | Implementation | Why it matters |
|---|---|---|
| **Content identity** | `cacheIdentity({wordId, languageCode, sourceDefinitionHash})` | the key derives from *inputs*, never from time or user |
| **Narrow API** | rejects anything else — *"only wordId, languageCode and sourceDefinitionHash are accepted"* | extra fields cannot poison the key space |
| **Versioned invalidation** | `MODEL_VERSION = 'gemini-2.5-flash'`, `PROMPT_VERSION = 'dictionary-expansion-v2-concise'` | improving the prompt safely re-keys the cache |
| **Language** | `SUPPORTED_LANGUAGES` allowlist (13) | no unbounded key growth, no surprise locales |
| **State machine** | `ready` / `generating` (+`leaseExpiresAtMs`) / `failed` (+`retryAfterMs`, `attempts`) | **two users hitting the same miss pay once** — the piece most apps forget |
| **Quota** | `dictionaryExpansionQuotas` keyed `${uid}_${lang}` | per-user-per-language ceiling |
| **Key custody** | `defineSecret('GEMINI_API_KEY')` | the key never ships to the client |

## § 3 The privacy boundary (settle this before writing any cache)

A shared cache is, in principle, readable by other users and by operators. The rule:

> **If two unrelated users could send the identical request and legitimately receive
> each other's answer, cache it. Otherwise never cache it server-side.**

| Cacheable server-side | Never cached server-side |
|---|---|
| bundled story text at an HSK level | chat messages (`sendMessage`) |
| dictionary headwords and definitions | the learner's recorded voice (`transcribeAudio`, pronunciation assessment) |
| public article / video transcripts (by URL or video id) | their photos (`analyzeImage`, `extractTextFromImage`) |
| TTS audio for a fixed text + voice | text *they typed* (user-input `generateText`, deck names) |

The app already ships `ai_consent_sheet` and `ai_data_privacy_screen`, so this policy
has a home — and a cache is a new data-retention fact users are entitled to see.

## § 4 What is actually wrong today

| # | Defect | Evidence |
|---|---|---|
| **D1** | **The two proxies cache nothing**, so every AI feature re-pays per user, per language, per device | `generateContentProxyV2` / `openRouterProxyV2` read `{model, body}`, `fetch`, return — no Firestore, no key, no de-dup |
| **D2** | **TTS is cached per device for a shareable artefact**, and only for single characters | `tts_cache/$hanzi.wav` + `_hashText`; a 4-hour weekly fair-use quota already exists (`audio_quota_service`) |
| **D3** | **Local keys carry no language and no version** | `def_$word`, `story_$deckId`, `detailed_summary_$title` — versus the correct `_nuanceCacheKey(sortedWords)` |
| **D4** | **Nothing expires** the Hive `ai_cache` keys | no TTL found; the only dated expiry is the unrelated `daily_discovery` cache |
| **D5** | **Several immutable sources are fetched uncached** | `story_fetcher_service`'s bare `http.get`; `hanzi-writer-data@2.0.1` stroke JSON; `i.ytimg.com` thumbnails (3 cached-image widgets for 4047 URL constructions) |
| **D6** | **Two dependencies that should not be production dependencies** | an undocumented `translate.googleapis.com/…?client=gtx` endpoint, and no `firestore.rules` in the repo while the client reads `stories` directly |

### ⚠️ Found while starting W1 — the proxies are unreachable, and the key ships in the app

Verified before writing any code, because it changes the sequence:

| Check | Result |
|---|---|
| `package:google_generative_ai` imported in `lib/` | **0 times** |
| `ProxyV2` / `cloudfunctions.net` anywhere in `lib/` | **nowhere** — the client never calls either proxy |
| `GeminiProxyClient` | **defined and never constructed** — dead code |
| The real traffic path | `lib/core/services/gemini_service.dart:354` → `https://openrouter.ai/api/v1/chat/completions`, `Authorization: Bearer $openRouterKey`, key from `api_key_pool` (`.env`, and **`--dart-define` at compile time** in `build_release.sh`) |
| The only usage limit | `_checkUsageLimit()` — **client-side**, therefore trivially bypassed by anyone who extracts the key from the binary |

**Consequence for this plan:** W1 as originally written would have placed a cache inside
`generateContentProxyV2` — **a function the app never calls**. It would have looked like
progress and changed nothing. **The cache must follow the traffic, and the traffic must be
routed first** — which is why **W0** below now precedes W1, and why W0 also happens to close
the shipped-key exposure. This is the single most consequential finding of the audit:
a compiled-in AI key with a client-side quota is both a **cost** risk (unbounded third-party
use) and a **security** one.


---

## § 5 Workstreams, in priority order

Each is independently shippable. Acceptance criteria are written so a test or a counter
can prove the cache works, not merely that it exists.

### W0 — *P0* · Route AI traffic through the proxy (prerequisite for everything else)
**Status 2026-09-26: slice 1 landed (server side, inert); slice 2 outstanding (client side).**
- ✅ **Slice 1 — done and verified.** `functions/ai-proxy-auth.js` (new) extracts and verifies a
  Firebase ID token; `bearerToken` is a pure function so `node:test` covers it (5 cases, including
  case-insensitive scheme matching, four-segment rejection and an oversize guard).
  Both proxies in `functions/index.js` now declare `secrets: [geminiApiKey]`, refuse an
  unauthenticated call with **401** *before* touching the key, and read
  `geminiApiKey.value()` instead of `process.env.GEMINI_API_KEY_LOCAL`. `npm run check` passes on
  all four server files; `node --test` is **10/10**. This slice is deliberately inert: nothing
  calls the proxies yet, so the shipped app cannot be broken by it.
- ⬜ **Slice 2 — the client.** `gemini_service.dart`'s three transports
  (`makeOpenRouterCall`, `_makeGoogleGeminiCall`, `streamOpenRouterText`) must point at
  `https://us-central1-hanzi-master-bcef9.cloudfunctions.net/{generateContentProxyV2|openRouterProxyV2}`
  and send `Authorization: Bearer <Firebase ID token>`. Note the two body shapes differ:
  `generateContentProxyV2` expects `{model, body}` (a Gemini `generateContent` payload) while
  `openRouterProxyV2` expects the OpenAI-shaped body directly and forces the model server-side.
  **Until slice 2 lands the gate above protects nothing, because the app still talks to
  `openrouter.ai` directly.**
- ⬜ **Slice 3 — remove the client-side key usage** (`api_key_pool` for AI, `build_release.sh`,
  `codemagic.yaml`) once rotation happens. *Not done, and deliberately not started:* the keys were
  left untouched at the owner's instruction, so the binary still carries them.
- ⚠️ **CI side effect of the credential scrub, needing an owner action:** `codemagic.yaml` now
  reads `AZURE_SPEECH_KEY: $AZURE_SPEECH_KEY`, so a Codemagic **secret with that name must exist**
  or Azure TTS in CI-built apps will receive an empty value.
- ℹ️ **Left alone on purpose:** `getDictionaryExpansionV1` still falls back to
  `process.env.GEMINI_API_KEY_LOCAL` (line 63). It is a different function with its own
  `enforceAppCheck: false` posture, and widening this slice to it would have mixed two changes.

**Where:** `lib/core/services/gemini_service.dart` (`makeOpenRouterCall`,
`_makeGoogleGeminiCall`, `streamOpenRouterText`) plus the existing
`generateContentProxyV2` / `openRouterProxyV2`.
**What:** stop calling `openrouter.ai` and `generativelanguage.googleapis.com` from the app;
point those transport methods at the proxy — the never-constructed `GeminiProxyClient` was
written for exactly this — and require a Firebase **ID token** on the call so the server knows
who is asking.
**Why it must be first:** with the key compiled into the binary there is **no server-side
control of any kind**. No cache can help, because the traffic never reaches a server we own;
no quota is enforceable, because `_checkUsageLimit()` runs on the client; and anyone who
extracts the key can spend the project's budget. Every other workstream here depends on the
request becoming server-mediated.
**Also moves to the server:** both AI keys become Secret Manager secrets — the dictionary
function already uses `defineSecret` for precisely this.
**Acceptance:** the app makes **no** request to `openrouter.ai` or
`generativelanguage.googleapis.com`; the proxy **rejects** an unauthenticated call; the built
binary contains no AI key.
**Risk to manage:** one extra network hop (latency) and Cloud Functions invocation cost; the
streaming chat path must keep streaming.

### W1 — *P1* · Read-through cache inside the LLM proxy
**Depends on W0** — before it, this function is unreachable and the cache is dead code.
**Where:** `functions/index.js` → `generateContentProxyV2` (and its OpenRouter twin).
**What:** key on `sha256(model ‖ canonicalised body ‖ PROMPT_VERSION)`; store the response
JSON with the **same `ready` / `generating`+lease / `failed` state machine** already proven
in `dictionary-expansion.js`; enforce a per-uid quota.
**Critical constraint:** cache only bodies matching an **allowlist of shareable prompt
shapes** (bundled story, dictionary word, public article/transcript). Everything else
passes through uncached — that is what makes § 3's rule true *by construction* instead of
by reviewer discipline.
**Acceptance:** a repeated identical request performs **0 upstream fetches**; two concurrent
misses do **1** (the lease); bumping `PROMPT_VERSION` re-keys.
**Why first:** one function covers ~20 call sites — the largest lever in the app.

### W2 — *P1* · Warm the cache for the bundled corpus
**Where:** a one-off seeding run of W1 over the app's *finite* content — every bundled story
× each HSK level, every dictionary headword × each supported language.
**Acceptance:** the first real user of any bundled story gets a hit; AI spend on bundled
content falls to ~zero after the seed.
**Why it's cheap:** the set is bounded and known, unlike user content.

### W3 — *P1* · Share TTS audio through Storage + CDN
**Status 2026-09-26: server complete and verified; app wiring outstanding (4 edits); paused awaiting deploy.**

- ✅ **Server, done.** `getTtsAudioV2` returns the audio **and its word timings together**, and needs no
  sign-in — it can only ever return audio the project already paid for. `warmTtsAudioV2` accepts the app's
  upload of the recording it already streamed, requires sign-in, refuses uploads over 2 MB and validates
  the timings' shape. `tts-cache.js` defines the identity (`text + voice + **rate** + format +
  ENGINE_VERSION`) and the object pair `tts/{key}.mp3` + `tts/{key}.json`. `storage.rules` denies **all**
  client access, so the bucket cannot be listed, filled or poisoned from a modified app. Verified:
  `node --check` clean, **25/25** node tests, no Azure reference left on the server.
- ⚠️ **The rate trap, recorded because it would have shipped a real bug.** The app's `_speechRate` treats
  **0.5 as normal** (it converts as `(rate − 0.5) × 200%`), while the cache identity treats **1.0 as
  normal**. The mapping is `cacheRate = appRate × 2`. Passing the app's value straight through labels every
  normal sentence "half speed" and would serve a listener *slowed* audio for a normal sentence.
- ⚠️ **The timings constraint that shaped the design.** `_fetchCloudTTSWithWebSocket` returns the audio
  *and* the word boundaries that drive highlighting. Cached audio without them would silently drop that
  feature — which is why `recordingFromCacheResponse` enforces **"audio and timings together, or the cache
  is not used"**, and why the **app** uploads the pair rather than the server synthesising: Azure returns
  timings only on its streaming path, so only the app holds a *matching* pair.
- ✅ **Client, done.** `lib/core/services/speech_cache_service.dart` — `lookup()`/`offer()`, both silent
  about failure (an undeployed or unreachable server is indistinguishable from a miss), with the decision
  logic extracted as the pure `recordingFromCacheResponse()`.
  `test/core/services/speech_cache_service_test.dart` passes **5/5**; analyzer clean.
- ⬜ **Remaining: four edits in `lib/core/services/audio_service.dart`.** The service is currently
  **unused, so the app behaves exactly as it did before** — that is why this is paused here rather than
  half-wired:
  1. import `speech_cache_service.dart` and hold `final _speechCache = SpeechCacheService();` (no
     constructor changes, so no other call site is touched);
  2. before **Tier 3** in the playback path, call `lookup(voice: _defaultAzureVoice, rate: _speechRate * 2)`
     and on a hit write the bytes to the same `tts_cache` file and play — identical to the existing Tier-3
     branch;
  3. after a successful stream, call `offer(...)` **without awaiting it**, so playback is never delayed;
  4. nothing else: the REST path (tone audition) receives no timings, so it simply does not use the cache.
- ⬜ **Owner action to go live:** Blaze plan → enable **Storage** → `firebase deploy --only functions,storage`
  → set a billing alert. **No Azure secrets are needed**: the server never calls Azure.
- ⚠️ **Trust boundary, stated not hidden.** The audio and timings are uploaded by the app, so a modified
  client could store a take that does not match its key. The damage is bounded to that one sentence (the
  key is a hash of text, voice and rate). **App Check** is the real fix — already a dependency of this
  project, not yet enforced on this function.
- ℹ️ `firebase.json` gained a `storage` entry pointing at `storage.rules`; deploying without `storage`
  would leave the bucket ungoverned.
**Where:** `audio_service.dart` — `_hashText` and `tts_cache/` already exist.
**What:** key `textHash + voice`; on miss synthesise via Azure then upload, on hit download.
Extend coverage from single characters to sentences and audiobook chapters.
**Acceptance:** the second user of the same word/chapter downloads instead of synthesising,
and consumption of the **4-hour weekly fair-use quota** drops measurably.
**Why:** TTS output is byte-identical for a given text+voice — the purest cacheable
artefact in the app, and quota is already a product constraint.

### W4 — *P1* · Language and version in the local keys, plus a TTL
**Where:** `gemini_service.dart` (`ai_cache`).
**What:** copy `_nuanceCacheKey(sortedWords)` — the one correct key in the file — and make
`def_$word`, `story_$deckId` and `detailed_summary_$title` **content-addressed**, each
including `languageCode`, `modelVersion` and `promptVersion`. Add a TTL; the
versioned-box-name trick in `local_translations_cache_v6` is the in-repo precedent.
**Acceptance:** a language change never returns another language's text; a prompt bump never
serves pre-bump output; keys expire.

### W5 — *P2* · Cache the immutable sources
(a) source HTML from `story_fetcher_service` (**nothing today**) by URL, device + server;
(b) `hanzi-writer-data@2.0.1/$char.json` stroke data — immutable **and** versioned in the URL,
so bundle or cache it per character; (c) thumbnails and covers via `cached_network_image`
(3 uses against 4047 `i.ytimg.com` URL constructions, 9 `Image.network`, 7 `NetworkImage`);
(d) YouTube transcripts / show metadata by video id, server-side.
**Acceptance:** a second open of the same screen performs no image or HTML fetch.

### W6 — *P2* · Retire the `client=gtx` dependency
Move translation behind the W1 cache server-side, or adopt a contracted MT API; keep ML Kit
for on-device work. `translate_a/single?client=gtx` is undocumented and unauthenticated — no
contract, per-IP throttling, and free to change without notice.

### W7 — *P2* · Harden and govern
`enforceAppCheck: true` plus a `request.auth` check on both public proxies; use the managed
secret instead of `GEMINI_API_KEY_LOCAL`; drop `openRouterProxyV2`'s hard-coded
`model: 'gemini-2.5-flash'` override; and **add `firestore.rules` to the repo**.

---

## § 6 Risks this roadmap must not create

| Risk | Guard |
|---|---|
| A shared cache accidentally stores personal text | W1's **shareable-prompt allowlist**, plus § 3's rule stated in `ai_data_privacy_screen` |
| Stale content after a prompt or model improvement | `PROMPT_VERSION` / `MODEL_VERSION` in **every** key (W1, W4) |
| Unbounded key growth from free-text keys | hash every input; keep the `SUPPORTED_LANGUAGES` allowlist |
| The public proxies acting as an open relay for the Gemini key | W7 — auth + App Check; today they are `invoker: "public"`, `cors: true`, with no check in the handler |
| Cache stampede on a cold miss | the `generating` lease from § 2 |
| Silent quota exhaustion | per-uid quota counters, as `dictionaryExpansionQuotas` already does |

---

## § 7 How to prove any of this works

1. **Upstream-call counter on the proxy** — assert **0** on a repeat. This is the only
   honest proof of a cache hit; a latency improvement is not proof.
2. **Concurrency test** — two simultaneous misses must produce exactly **one** upstream call.
3. **Unit tests on the key function** — deterministic for equal inputs; different across
   `languageCode`, `modelVersion` and `promptVersion`; and it must **reject** a personal
   prompt shape.
4. **Firestore metrics** — document counts and read/write volume per collection.
5. **Device test** — a second launch of the same story performs **no** AI call (fake client,
   assert zero invocations).
6. **TTS** — assert the second request reuses cached bytes rather than re-synthesising.

## § 8 Reproduction (how these numbers were measured)

```powershell
# the outbound surface
Select-String -Path (Get-ChildItem lib -Recurse -Filter *.dart) -Pattern 'https?://' -AllMatches |
  ForEach-Object { $_.Matches } |
  ForEach-Object { ($_.Value -replace 'https?://','') -replace '/.*$','' } |
  Group-Object | Sort-Object Count -Descending

# raw HTTP verbs, by file
Select-String -Path (Get-ChildItem lib -Recurse -Filter *.dart) `
  -Pattern 'http\.(get|post)\(|_client\.(get|post)|\.send\(' | Group-Object Path

# the server's exports, and every collection it touches
Select-String -Path functions\index.js,functions\dictionary-expansion.js -Pattern 'exports\.\w+'
Select-String -Path functions\index.js,functions\dictionary-expansion.js `
  -Pattern 'collection\("([^"]+)"\)' -AllMatches

# the AI operation inventory, and the local cache keys
Select-String -Path lib\core\services\gemini_service.dart -Pattern '^  Future<[^>]+>\s+(\w+)\('
Select-String -Path (Get-ChildItem lib -Recurse -Filter *.dart) -Pattern "Hive.box<String>\('ai_cache'\)"

# what is actually cached on the device, by key shape
Select-String -Path lib\core\services\gemini_service.dart -Pattern "cacheKey = |_nuanceCacheKey|contextCacheKey"
```

## § 9 What this document deliberately does not claim

- **No bill was measured.** These are code-level findings; the deployed cache collections
  may be empty or large, and actual Gemini/Azure spend is not visible from this repository.
- **No rules or IAM were read** — `firestore.rules` is absent from the repo, and App Check /
  IAM settings live outside it, so the "open relay" risk in § 6 is inferred from the handler
  bodies (`invoker: "public"`, `cors: true`, no visible check, `enforceAppCheck: false`).
- **Cacheability is judged from the code, not from usage data.** Which of the ~20 AI
  operations actually dominate spend should be confirmed with server-side telemetry before
  choosing between W1 and W2 — the ordering above assumes bundled story parsing is the
  highest-volume call, which is plausible given it runs per device per open, but unmeasured.



