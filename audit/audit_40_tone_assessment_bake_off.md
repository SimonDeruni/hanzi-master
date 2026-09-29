# Audit 40: Tone Assessment Bake-Off Plan

**Status:** 📋 **PLAN** — nothing built, decision pending
**Date:** 2026-09-27
**Supersedes nothing.** Direct follow-on to audit 39, which established that the
shadowing "Tone Accuracy" pillar currently reports **"not measured"** because
Azure Pronunciation Assessment never reports the tone that was heard.

---

## 🎯 1. The decision this settles

Which tone-assessment path do we ship, judged on **our own content and our own
learners** rather than on vendor specification sheets? The candidates are three
commercial graders, the local signal-processing route, and the status quo.

> ## ⛔ SUPERSEDED 2026-09-27 — no vendor. Tone assessment goes **on-device**.
>
> **The decision below was reversed the same day it was made.** `docs/LOCAL_TONE_PLAN.md`
> is the plan now: measure the pitch contour on the phone, compare it against the
> standard Chao tone shapes, and derive `actualTone` locally.
>
> **Why the reversal isn't a contradiction.** Two things were learned *after* the
> decision that the decision didn't have:
>
> 1. **The local route was under-rated because segmentation was treated as
>    unsolvable.** It isn't: Azure already returns per-syllable `Offset`/`Duration`
>    (unverified, but standard for that API and **currently discarded by the grader**),
>    and Azure already grades the *segments*. That splits the problem cleanly — Azure
>    does the sounds, the phone does the pitch.
> 2. **The privacy question disappears entirely.** No vendor, no network call, no
>    cross-border transfer, no DPA, no SCCs, no transfer impact assessment, no store
>    label change. For a feature that would otherwise cost contracts and legal review,
>    that removes most of its total cost.
>
> **What was NOT wrong:** §2.1 stands — `HypothesisTone` really is the field audit 39
> wanted, and Tencent really is the only vendor that reports it. This is a *build vs buy*
> reversal, not a correction about vendors. `functions/tencent-soe.js` is kept as a fully
> tested, deliberately unwired record, and `docs/PRIVACY_UPDATE_TENCENT_AI_DATA.md` is
> kept with its status marked reversed.
>
> ---
>
> ### The original decision, retained for the record
>
> ## ✅ DECIDED 2026-09-27 — **Tencent SOE (智聆口语评测)**
>
> The decision turned on one field. As §2.1 shows, Tencent is the only candidate that
> reports **`Tone.HypothesisTone` — 实际发音声调, the tone the learner actually
> pronounced** — as a value. Everything else about the choice follows from that:
> iFlytek returns a tone *verdict* and *score* but never the tone that was heard
> (so it cannot support the tone card's "You: tone 2 · Target: tone 4"), and Azure
> returns nothing at all, which is why audit 39 had to report "not measured".
>
> The supporting reasons were that SOE is **plain HTTPS POSTs** — so it fits the
> existing Cloud Functions proxy with no WebSocket relay and no second deploy target —
> and that it needs **no client-side credential** the way the current Azure path does.
>
> **Not chosen, and why:** iFlytek ISE (best granularity, but WebSocket-only, no
> offline SDK, and a verdict rather than a measurement); SpeechSuper (the most
> attractive architecture — one POST and a genuine on-device path — but **lexical tone
> is still undocumented**, so it cannot be selected on evidence). SpeechSuper remains
> the one candidate that could displace this decision, and §3.3 keeps that door open.

---

## 📦 2. Candidates, and what is actually verified about each

> ⚠️ **All three vendors are Chinese companies** — iFlytek (Hefei), Tencent
> (Shenzhen), SpeechSuper (**Suzhou**). There is no candidate that avoids the
> cross-border data question by *being* non-Chinese; the only routes where audio
> never goes to China are **SpeechSuper's offline SDK** and the **local DSP**.
> SpeechSuper's "English docs, global signup, international regions" framing was in
> this document's first draft and was **wrong on the last two points**.

| Candidate | Tone output | Protocol | Status of our knowledge |
|---|---|---|---|
| **iFlytek ISE** (讯飞语音评测 流式版) | per-sentence **`tone_score 调型分`**; per-phone **`perr_msg` `1 声韵错 / 2 调型错 / 3 声的调型错`**; per-syllable `symbol` = pinyin with tone digit (**5 = neutral**); per-word `pitch_beg`/`pitch_end` (⚠️ **a verdict, not a measurement — see §2.1**) | **WebSocket only** (`wss://ise-api.xfyun.cn/v2/open-ise`, HMAC-SHA256); 16 kHz/16-bit/mono, ≤5 min, zh + en; Android/iOS/Linux/Windows SDKs exist but are **network clients for the same service, not offline evaluators** (verified — §3); **500 free calls/day** | **Verified** from their API doc |
| **Tencent SOE** (智聆口语评测) | `声调` named as a returned dimension alongside 准确度/流畅度/完整度/重音/音素; the **Init** doc states 单字/词模式 *"标注每个音节的详细信息"* (per-syllable detail); modes 单字/句/段落/自由说/多分支/**拼音评测**; ⭐⭐ a **`Tone {Valid, RefTone, HypothesisTone}`** on every word — see §2.1 | **Plain HTTPS POSTs** — `InitOralProcess` then `TransmitOralProcess`, with `WorkMode:1` a **single one-shot call** and `WorkMode:0` optional chunking (`SeqId`/`IsEnd`, ≤3000); **server SDKs incl. Node.js**; 16 kHz/16-bit/mono; `ServerType` **defaults to English**; `ScoreCoeff` 1.0–4.0 is an age/strictness dial (1.0 = children); `StorageMode` defaults to **not storing** audio | **Largely verified** from the Init + Transmit docs; the **`Tone` field is now RESOLVED** (§2.1); **international availability unverified** (`tencentcloud.com/products/soe` 404s) |
| **SpeechSuper** | ⚠️ **"Tone" appears nowhere in their own product copy.** Scripted assessment advertises *"sentence score, word score, phoneme score, mispronunciation, **syllable stress**, linking techniques"* plus *"rising/falling tone analysis for **sentence endings**"* — that is **intonation, not lexical tone**, and no 声调 field is documented anywhere reachable | **Simplest of the three: one HTTPS POST**, multipart `text`+`audio` to `api.speechsuper.com/{coreType}`, SHA-1 auth; a WebSocket variant also exists. Chinese coreTypes verified: **`word.eval.cn`, `sent.eval.cn`, `para.eval.cn`**. iOS + Android SDKs for **English & Mandarin**, and the **on-device path is real** — local `native.res`/`native_cn.res` models, `coreProvideType: "native"`, arm64-v8a + iOS static libs | **Architecture verified** from their official samples and SDK demos; result root is `{result:{overall}}` with `errId` errors and a live `sound_intensity` callback. **Still unseen: the per-syllable tone field.** Docs/pricing/regions unread. ⚠️ **"Based in Suzhou, China"** — not a non-Chinese option, and **keys are sales-led** (form → reply in 1 business day) |
| **Local DSP** (in-repo parts) | contour shape + DTW distance to a native exemplar; a *label* only if we add a classifier | on-device, offline | **Verified** — see §9; costs nothing, no vendor, no audio leaves the device |
| **Status quo** (Azure only) | none — hence audit 39 | REST (already integrated) | n/a |

### 2.1 ⭐ The tone-field comparison — the finding that reorders the candidates

This is the question the whole feature rests on, so it is worth stating plainly: **what
does each vendor actually report about tone?**

| | What you get about tone | Can it say *which* tone was said? |
|---|---|---|
| **Tencent SOE** | a **`Tone` struct on every `WordRsp`**: **`RefTone`** (文本标准声调, the expected tone) and **`HypothesisTone`** (实际发音声调, *"the tone actually pronounced"*), both `[-1,1,2,3,4]`, gated by a **`Valid`** boolean — added 2023-07-10 (release 14). Plus per-syllable **`PhoneInfo`** with **ms boundaries**, `PronAccuracy`, `Phone` vs `ReferencePhone`, and `Stress` vs **`DetectedStress`** | **✅ Yes — a number.** `HypothesisTone` is precisely the field audit 39 went looking for and Azure never provided |
| **iFlytek ISE** | a **tone verdict and a tone score**: per-phone **`perr_msg 2 调型错`** ("tone-pattern wrong"), per-sentence/chapter **`tone_score 调型分`**, and a per-syllable `symbol` = ***reference*** pinyin with tone digit (5 = neutral). The F0 fields that could reveal the heard contour — `pitch`, `pitch_beg`, `pitch_end` — are documented as **`预留字段，无需关心`** ("reserved, no need to care") | **❌ No field found.** It says the tone was **wrong** and how good the pattern was, not **which** tone was produced |
| **Azure** (today) | an `ErrorType` against a reference syllable | ❌ No — hence audit 39 |
| **SpeechSuper** | nothing documented (§3.3) | ❓ Unknown |

**Why this matters:** the tone card wants to render *"You: tone 2 · rising — Target: tone
4 · falling."* Only **`HypothesisTone`** can support that sentence. iFlytek supports
*"your tone was wrong (score 62)"* — a real feature, but a smaller one, and not the
diagnosis the screen was built for. **Tencent, not iFlytek, holds the single most useful
field for this app** — and Tencent is also the one that fits the existing proxy, which
reverses the ranking this document started with.

**Two caveats to test, not assume:** the `Tone` range is **`[-1,1,2,3,4]` — there is no
`5` for neutral tone**, so 轻声 probably arrives as `-1` / `Valid:false`, and M7 must
decide whether that means "neutral" or "not measured"; and the docs tie per-syllable
detail to **word/character mode (`EvalMode 0`, 文字模式 for Chinese)** while sentence mode
supplies completeness and fluency — so per-syllable tone may require a character-mode call.

---

## ⚠️ 3. Verify these before writing a single line of integration code

1. **iFlytek — ✅ RESOLVED 2026-09-27:** the cloud API is **WebSocket-only** and the
   non-streaming *普通版* is **retired** — the doc states `语音评测（普通版）已下线` and
   directs all users to migrate to the streaming version — so there is **no simpler
   endpoint for a new integration**. The **native SDKs are not an offline escape
   hatch**: the Android SDK doc's own permission comment marks INTERNET as
   `用于执行云端语音能力` ("for executing cloud voice capabilities"), i.e. the SDK is a
   client for the same cloud service and buys **no offline mode and no privacy win**
   — while asking you to ship `libmsc.jar` + `libmsc.so` (32-bit `armeabi-v7a` era)
   and suggesting `READ_PHONE_STATE`, `READ_CONTACTS`, `WRITE_SETTINGS`,
   `ACCESS_FINE_LOCATION` and `CAMERA` in the manifest. Still open: whether billing
   requires a Chinese entity. **⚠️ Tone output is a verdict, not a measurement (see
   §2.1):** `perr_msg 2 调型错` + `tone_score 调型分` + a ***reference*** pinyin `symbol`.
   No field reporting the recognized tone was found in any documented table, and the F0
   fields that could reveal it (`pitch`, `pitch_beg`, `pitch_end`) are marked
   `预留字段，无需关心`.
2. **Tencent — ✅ MOSTLY RESOLVED 2026-09-27:** `soe.tencentcloudapi.com`, `Action:
   InitOralProcess` then `TransmitOralProcess`, `Version: 2018-07-24`. Audio goes up
   as **BASE64 chunks in ordinary HTTPS POSTs** (`SeqId` from 1, `IsEnd`) — and
   `WorkMode: 1` is a **non-streaming one-shot**, so **this one can sit behind an
   existing HTTPS function**, unlike iFlytek. Node.js server SDK exists. Three traps
   found in the docs: **`ServerType` defaults to `0` (English)**; the reference text
   is screened and rejected on `SensitiveWords` (请求内容包含违禁词汇), a real
   operational risk for lesson sentences; and **多音字 raise
   `RefTextPolyphonicLimitExceeded`**, whose own remedy is to pass the reading
   explicitly via the pronunciation-description block / `TextMode:1` — good news for
   our Tier D, but it confirms **we build the surface-reading layer either way**.
   Also confirmed: `ScoreCoeff` 1.0–4.0 leans the strictness for children, and
   `StorageMode` defaults to not storing audio. **⭐ RESOLVED — the tone field is a
   `Tone` struct on `WordRsp`: `{Valid, RefTone, HypothesisTone}` (see §2.1)**, added
   2023-07-10 and documented on the 数据结构 page. Still open: **whether SOE is sold
   outside mainland China** (`tencentcloud.com/products/soe` 404s); the referenced
   `音素标注` page (custom pronunciations / 多音字 — the doc IDs near it resolve to other
   products); and the fact that **SOE's docs have not been updated since 2023-10-16**.
3. **SpeechSuper — ✅ ARCHITECTURE VERIFIED 2026-09-27 from their own repos; the
   tone field is the one question still open.**
   - **Endpoint & shape (verified from the official samples):**
     `POST https://api.speechsuper.com/{coreType}`, multipart with `text` = the JSON
     parameter blob and `audio` = the file, header `Request-Index: 0`. A **WebSocket**
     variant exists at `wss://api.speechsuper.com/{coreType}` (connect → start → raw
     audio bytes → stop). Auth is **SHA-1**: `sha1(appKey+timestamp+secretKey)` for
     connect, `sha1(appKey+timestamp+userId+secretKey)` for start, ms timestamps.
     **One request, one response — by far the simplest of the three, and trivially
     proxyable.**
   - **coreTypes include genuine Chinese variants (verified in the iOS SDK demo):**
     `word.eval.cn`, `sent.eval.cn`, `para.eval.cn`, alongside `word.eval` /
     `sent.eval` / `para.eval`; the API samples also show `.promax` tiers
     (`sent.eval.promax`, `word.eval.promax`).
   - **On-device evaluation is REAL, not marketing.** The iOS demo initialises the
     engine with local model resources from the app bundle —
     `paramDic["native"] = native.res` (English),
     `paramDic["native_cn"] = native_cn.res` (Chinese) — then `skegn_new(cfg)`, and
     the request carries **`coreProvideType: "native"`**. Native binaries ship per-ABI
     (`armeabi`, `armeabi-v7a`, **`arm64-v8a`**, `x86`) and as iOS static libraries
     (`libskegn-iphoneos.a`, `libskegn-iphonesimulator.a`). **This is the only route
     among every candidate where audio need never leave the device.**
   - **Result shape (verified):** `{"result": {"overall": …}}`; errors carry `errId`;
     a separate real-time **`sound_intensity`** callback drives the mic meter. The
     demo apps read only `overall` and pretty-print the remainder, so the
     **per-syllable / per-tone field names are still unseen**.
   - **⚠️ The tone gap stands.** Their README advertises *"syllable stress analysis"*,
     liaison detection, loss of plosion and *"rising/falling tone analysis for
     **sentence endings**"* — that last one is **intonation, not lexical tone**. No
     声调 field is documented anywhere reachable.
   - **⚠️ Onboarding is sales-led.** There is **no self-serve key**: "Start free
     trial" → a form → *"a response from our expert within 1 business day via
     email"*. This cannot be tested without contacting them first.
   - Also noted: 8 spoken languages but the **SDK covers English and Mandarin only**;
     a `vad: { seek, ref_length }` block; and the SDK can write `sdkLog.txt` into the
     app's documents directory. Docs, pricing and regions remain unread.
4. **All three:** where is audio processed and for how long retained, is audio
   stored, who are the sub-processors, is a DPA available, and does the flow
   involve a **CN region**? That last one lands on `ai_data_privacy_screen.dart`
   and the store privacy labels, and it is a product decision, not a technical one.
5. **All three:** does the vendor's reference reading handle **tone sandhi**? If
   they compare against citation tones they will mark correct speech wrong, and no
   accuracy score rescues that. (M5 is the test; this is just the pre-read.)
---

## 🗣️ 4. The stimulus set (exact phrases)

Scripted, so every candidate is scored on identical audio. Surface tones are given
where they differ from citation tones — those items are the whole point.

### 4.1 Tier A — isolated syllables (the confusion matrix)

Five syllables × four tones = **20 items**, each read as a single character so the
segmental content is held constant and only the tone varies.

| Target | Tone 1 | Tone 2 | Tone 3 | Tone 4 |
|---|---|---|---|---|
| **ma** | 妈 mā | 麻 má | 马 mǎ | 骂 mà |
| **ba** | 八 bā | 拔 bá | 把 bǎ | 爸 bà |
| **tang** | 汤 tāng | 糖 táng | 躺 tǎng | 烫 tàng |
| **shi** | 师 shī | 十 shí | 使 shǐ | 是 shì |
| **yi** | 衣 yī | 移 yí | 椅 yǐ | 易 yì |

### 4.2 Tier B — tone pairs in context (16 items)

All sixteen combinations, as natural high-frequency words. This is where
co-articulation shows up.

| | 1st tone | 2nd tone | 3rd tone | 4th tone |
|---|---|---|---|---|
| **1st** | 今天 jīntiān | 中国 zhōngguó | 身体 shēntǐ | 鸡蛋 jīdàn |
| **2nd** | 昨天 zuótiān | 银行 yínháng | 苹果 píngguǒ | 牛肉 niúròu |
| **3rd** | 手机 shǒujī | 草莓 cǎoméi | 你好 **ní hǎo** | 土豆 tǔdòu |
| **4th** | 面包 miànbāo | 练习 liànxí | 字典 zìdiǎn | 再见 zàijiàn |

### 4.3 Tier C — the credibility tests (the ones that decide it)

**一 sandhi** (yī in isolation → *yì* before 1/2/3, *yí* before 4):

| Phrase | Surface | Rule |
|---|---|---|
| 一天 | **yì** tiān | before 1st |
| 一年 | **yì** nián | before 2nd |
| 一起 | **yì** qǐ | before 3rd |
| 一个 | **yí** ge | before 4th |
| 第一 | dì **yī** | ordinal — **no** sandhi |

**不 sandhi** (bù → *bú* before 4):

| Phrase | Surface |
|---|---|
| 不是 | **bú** shì |
| 不去 | **bú** qù |
| 不忙 | **bù** máng |
| 不好 | **bù** hǎo |

**3-3 sandhi** (first of two third tones becomes 2nd):

| Phrase | Surface |
|---|---|
| 你好 | **ní** hǎo |
| 很好 | **hén** hǎo |
| 我很好 | **wó hén** hǎo |

**Half-third (半三声)** — tone 3 *non-final* is realised low and flat, **not** as a
full dip. A grader that demands the full dip will mark correct speech wrong here:

| Phrase | Surface | Why |
|---|---|---|
| 请坐 | qǐng zuò | 3 before 4 — no dip |
| 美国 | měiguó | 3 before 2 — no dip |
| 你想 | nǐ xiǎng | 3 before 3 — becomes 2nd |
| 你好吗 | **ní** hǎo ma | 3-3, then final 好 keeps the full dip |

**Neutral tone:**

| Phrase | Neutral syllable |
|---|---|
| 妈妈 | second 妈 → **ma** |
| 朋友 | 友 → **you** |
| 东西 | 西 → **xi** |
| 谢谢 | second 谢 → **xie** |
| 我的书 | 的 → **de** |

### 4.4 Tier D — 多音字 reference truth

Does the grader grade against the reading the screen shows, or against a
context-free default? (This is the same defect audit 39 fixed in our own grader.)

| Phrase | The reading that counts | The wrong default |
|---|---|---|
| 银行 | yín**háng** | xíng |
| 长大 | **zhǎng**dà | cháng |
| 音乐 | yīn**yuè** | lè |
| 觉得 | **jué**de | jiào |
| 差不多 | **chà**buduō | chā |
| 重要 | **zhòng**yào | chóng |
| 地方 | dì**fang** | fāng |

### 4.5 Tier E — real app content

Recorded verbatim, because a grader that fails on our own screen copy is useless:

- **`百战不殆。`** — the onboarding mini lesson sentence
  (`onboarding_mini_lesson_screen.dart:49-50`).
  ⚠️ **Writing this item down immediately caught a live bug.** The app carried
  `bǎi zhàn bù dài`, but 不 precedes 殆 **dài** (fourth tone) and so takes the
  second-tone sandhi form — the surface reading is **`bǎi zhàn bú dài`**. Because
  the screen both **displays** that constant and **grades against it**, the app's
  first speaking exercise taught the wrong tone *and* marked a learner who said it
  correctly as wrong. **Fixed 2026-09-27**, together with the widget-test assertion
  that had pinned the wrong form. It is the clearest illustration of why M5 exists,
  and a reminder that the stimulus set is worth writing before the vendor is picked.
- **2–3 phrases pulled from the studio's own sources** — the studio receives its
  text from quick look / character detail / the media desk
  (`ShadowingStudioScreen(initialPhrase: …)`), so sample whatever those pass in
  production rather than inventing new sentences.

### 4.6 The deliberate-error set — how "wrong tone" ground truth is obtained

**Without this set you can only measure agreement on correct speech, which
flatters every vendor equally.**

For a subset of Tier A and Tier B, a **native speaker deliberately produces a
different tone while keeping the segmental pronunciation clean** — for `妈 mā1`
they also say `麻`, `马`, `骂`. Same syllable, same initial and final, wrong tone.

That yields labelled *wrong* samples, which is the only way to compute M2 and the
false-positive rate. Record the **intended** tone per take in the manifest, not the
target's.

---

## 🎙️ 5. Recording protocol

Hold these constant or the numbers are not comparable across vendors:

- **16 kHz, 16-bit, mono PCM** — the format every candidate accepts and the format
  the app already records (the grader wraps it in a WAV header, and the header
  check in `PitchDetectorService` already handles both).
- **Same device, same mic, ~20 cm mouth distance** for every take.
- **Two acoustic conditions:** quiet room, and a "café" condition (background
  conversation). The app is used on the move, so a vendor that only works in a
  studio is a vendor that fails our users.
- **Speakers:**
  - 2–3 **native** speakers — the "this must score high" control
  - 3–5 **learners** spanning roughly HSK 1–4 — the real target population
  - 1 native speaker for the **deliberate-error** set
- **≥3 takes per phrase per speaker**, first take discarded as a warm-up.
- **Manifest per take:** wav path, speaker id, native/learner, phrase id, expected
  surface tones, intended tone error (if any), condition, take index.
- **Keep every take as a reusable fixture directory.** It becomes the regression
  corpus for whichever path ships, and the same corpus the next vendor is measured
  against.

---

## 📊 6. Metrics and pass bars

| # | Metric | Measured on | Pass bar |
|---|---|---|---|
| **M1** | **Correct-tone false-negative rate** — "you said the wrong tone" when you did not | native + learner takes judged correct | **≤ 5%** — the headline number |
| **M2** | Wrong-tone detection rate | deliberate-error set | ≥ 80%; report **2↔3 separately** |
| **M3** | Isolated 4-way label accuracy | Tier A (20 × speakers) | ≥ 90% |
| **M4** | Confusion pairs | Tiers A + B | 2↔3, 2↔4 and 1↔3 must be named explicitly |
| **M5** | **Sandhi acceptance** | Tier C sandhi items | **100% — hard gate** |
| **M6** | **Half-third acceptance** | Tier C 半三声 items | **100% — hard gate** |
| **M7** | Neutral-tone acceptance | Tier C neutral items | ≥ 95% |
| **M8** | **Segmentation integrity** — syllables map to the right characters | all tiers | **100% — hard gate** |
| **M9** | Repeatability — same wav scored 5× | 20 takes | spread ≤ 2 points |
| **M10** | Latency for a 3 s take | 50 takes | p95 ≤ 1.2 s, **or** streamed partials |
| **M11** | Cost per graded take, and monthly at 10k / 100k MAU | list price + overage | inside the stated budget |
| **M12** | Compliance | audio path, retention, sub-processors, DPA, CN region | no unresolved flag |
| **M13** | **Lift over the local baseline** | M1/M3 minus local DSP | must justify the dependency |

**Why M1 and not accuracy is the headline.** Learners forgive an imprecise score.
They do not forgive being told they are wrong when they are right — that is the
failure that makes a tone feature feel broken, and it is exactly the failure audit
39 removed from our own code. M2 is the other half: a grader that accepts
everything teaches nothing.

---

## 🧪 7. Harness

- **Run it outside the app.** A small script that feeds the same wav fixtures to
  each candidate and writes one CSV row per take
  (`take_id, vendor, expected_surface_tone, vendor_verdict, vendor_score, latency_ms, http_status`).
  Do **not** ship three SDKs to find out which one to ship.
- Score locally from the CSV; publish the table as an artifact.
- The app already has the server-side pattern for a vendor behind a proxy
  (`functions/ai-proxy-auth.js`, `api_key_pool.dart`), which is the shape the
  winner is adopted in — but note that **iFlytek's WebSocket-only cloud API cannot
  be proxied by Firebase HTTPS Functions**.
- **If iFlytek wins, the WebSocket is a tax rather than a wall — but it is a tax.**
  Two routes, both verified viable, neither free:
  - **(a) Pre-signed URL, client connects.** The HTTPS function computes the
    `hmac-sha256` `authorization` URL parameter and returns the short-lived signed
    URL; the Flutter app opens the socket itself (`web_socket_channel`). No new
    deploy target and the `apiSecret` stays server-side — but the streaming protocol
    (start frame → audio frames → end frame) and any quota enforcement move **into
    the app**, and audio then travels straight from the device to a CN endpoint.
  - **(b) A WebSocket relay on Cloud Run.** Cloud Run **does** support WebSockets,
    but its docs are explicit: *"Cloud Run instances do not have CPU when the
    container is not handling any requests… If your service primarily handles
    WebSockets requests, then the container will have CPU allocated as long as there
    is at least one client connected to it."* So you **pay for the whole connected
    duration**, cannot scale to zero while a learner is mid-take, and eat a cold
    start on the first connection — plus a second deploy target, container and CI path.
  - Either way the cost is **a new deploy target or a new client-side protocol** —
    exactly what a REST vendor does not impose.
- Keep the fixtures and the harness so the comparison is repeatable when prices or
  models change.

---

## 🏁 8. Decision rule

1. **Hard gates first.** Any candidate failing M5, M6 or M8 is **out**, however
   good its other numbers — those three are where a grader loses a learner's trust
   permanently.
2. **Then rank by M1**, then M2 and M9, then M10 and M11.
3. **If the best candidate's lift over local (M13) is not material, ship local.**
   It is free, offline, private, adds no vendor and no sub-processor, and the
   visible contour is the teaching anyway.
4. **Whichever wins, hold two things constant:** keep the local contour as the
   on-screen explanation and the offline fallback, and keep the
   **"refuse to grade"** gate (too few voiced frames, poor SNR, unstressed neutral).
   Reporting *"not measured"* rather than guessing is what makes the feature feel
   trustworthy at all — audit 39's whole lesson.
5. **Log anonymised features and verdicts afterwards** and recalibrate the
   thresholds. Any of these routes is only as good as its thresholds, and data beats
   theory the moment real learners use it.

---

## 🔗 9. What already exists and is unwired

The local route is not a from-scratch build — every part is in the repo and unused:

| Piece | What it does |
|---|---|
| `pitch_detector_dart: ^0.0.7` | YIN pitch detection (TarsosDSP port), already a dependency |
| `PitchDetectorService.extractPitchContour()` | F0 contour from the recording, WAV-aware, voicing-gated — **zero callers** |
| `DtwAligner.alignPitch(reference, user)` | DTW alignment of two pitch contours — **the comparison maths, zero callers** |
| `ToneGraphPainter(idealPitch, userPitch)` | draws reference vs actual contour |
| `CalligraphicPitchContour` | the ideal contour shape per tone |
| `PinyinUtils.getExemplarHanzi()` + `AudioService.playToneAudition()` | native exemplar audio per syllable **and** tone |

Two implementation notes for that route when it is built: use a **32 ms hop**
(`chunkSize: 512` — the default 1024 = 64 ms gives only ~3 points per syllable),
and **precompute the reference contours offline** from the bundled exemplar audio
into a JSON asset rather than synthesising at request time.

---

## ⚖️ 10. Documentation Sync

- **GEMINI.md Update Required?** No.
- **ROADMAP.MD Updated?** Yes — tone assessment enters the roadmap as a scoped
  workstream gated on this bake-off.
- **Bugs.md Entry Created?** Yes — `ISSUES.md`, 2026-09-27, including the
  `百战不殆` reference-pinyin bug found while scripting the stimulus set.

## 🚧 11. Implementation status

**Landed 2026-09-27 — the server-side core, fully tested, no credentials needed.**

| | |
|---|---|
| `functions/tencent-soe.js` (new) | the whole decision in pure code: TC3-HMAC-SHA256 signing, the two request bodies, and **`mapSoeResult()`** — the response mapper |
| `functions/test/tencent-soe.test.js` (new, **25 tests**) | signing vectors and shapes, request bodies, and every branch of the tone mapping |
| `functions/package.json` | `tencent-soe.js` added to `npm run check` |

**Why `mapSoeResult` is the deliverable rather than a detail:** it is where the tone
verdict stops being a guess. The tests assert, among others:

- a tone said **correctly** is reported as *measured* (`actualTone === expectedTone`),
  not as the "not measured" audit 39 had to ship;
- a tone said **wrongly** is reported as the wrong tone and marks the word
  `isPartial` — *right syllable, wrong tone*, which nothing in the app could express
  before;
- **`Tone.Valid === false`** maps to `actualTone === 0`, the codebase's existing
  "not measured" convention, so the vendor's own confidence flag lands on the
  convention `CalligraphicPitchContour` and `SpeakingFeedbackPanel` already read;
- the **authored pinyin beats the vendor's `RefTone`**, so a 多音字 is never graded
  against a context-free default — the defect audit 39 fixed on the Azure path;
- **omissions count against the score and insertions do not**, kept identical to the
  Azure path so the two providers agree on what a score means.

**Probed by reverting, as the repo requires.** Deleting
`ServerType: SERVER_TYPE_CHINESE` fails the `ServerType` test; forcing
`const actualTone = 0` fails the two measurement tests while correctly leaving the
`Valid: false` test green, because that one asserts the *not-measured* path rather
than measurement being live.

**Not done, and the code does not pretend otherwise:**

- **No live call has ever been made.** Signing, bodies and mapping are covered from
  Tencent's documentation; the only untested link is the network. There is also **no
  known-answer signature vector** — Tencent redacts the keys in their published
  example — so the composed signature is asserted by its exact documented shape plus
  published vectors for the primitives, which the test header records.
- **No endpoint is wired.** A `gradePronunciationV1` callable and the Flutter client
  are the next step; neither the app nor the shadowing screen calls SOE yet.
- **No credentials.** `TENCENT_SECRET_ID` / `TENCENT_SECRET_KEY` must live in a
  `firebase functions:secrets:set` secret and never reach the client — the Azure
  path's key-in-the-app shape (`api_key_pool.dart`) is the thing not to repeat.
- **Behavioural unknowns** one live call must settle: whether `HypothesisTone` is
  populated in practice, what 轻声 returns given the range has no `5`, and whether
  per-syllable tone really requires character mode (`EvalMode 0`).

## 📋 Outstanding

- [x] **Choose the provider — done 2026-09-27: Tencent SOE** (§1), after §2.1 showed it
      is the only candidate reporting the tone that was actually pronounced.
- [x] Verify the iFlytek / Tencent / SpeechSuper facts in §3 (doc reading, no code)
      — **2026-09-27**: iFlytek and Tencent resolved; SpeechSuper partly resolved,
      with **tone scoring now the top unknown** and its "non-Chinese" framing corrected
- [x] **Land the server-side core — done 2026-09-27** (§11): `functions/tencent-soe.js`
      and 25 tests, probed by reverting, with `npm run check` and the full 50-test
      functions suite green.
- [ ] **Wire it up — the step that actually lights the tone card.** A
      `gradePronunciationV1` callable on the functions side, a `TencentSoeService` on
      the Flutter side, and `gradeAudio` preferring SOE when it is configured (falling
      back to Azure when it is not). Until this lands the app behaves exactly as audit
      39 left it, which is the honest "not measured".
- [ ] **Set the secrets and make one live call.** `TENCENT_SECRET_ID` /
      `TENCENT_SECRET_KEY` via `firebase functions:secrets:set`, then one
      character-mode (`EvalMode 0`, `ServerType 1`) call on `百战不殆`. That single
      response answers four things at once: whether `HypothesisTone` arrives at all,
      what a **correct** tone returns (the M1 false-negative question), what a
      **deliberately wrong** tone returns (M2), and what 轻声 gives since the range has
      no `5`.
- [ ] **Settle the SpeechSuper tone question — the one open alternative.** Its
      architecture is genuinely attractive — one POST, and the only real on-device path
      (§3.3) — but nothing documented says it scores lexical tone, so it cannot be
      selected on evidence. Keys are **sales-led** (free-trial form → reply in ~1
      business day), so this starts with a contact form, not a signup.
- [ ] Record the fixture corpus per §5 — the only real effort, and the same corpus
      every future decision reuses
- [ ] Build the harness (§7) and the take manifest
- [x] Fix the shipped `bǎi zhàn bù dài` → `bǎi zhàn bú dài` regardless of outcome
      — **done 2026-09-27** (`onboarding_mini_lesson_screen.dart` + the widget test
      assertion that pinned it; 19/19 onboarding tests pass)
