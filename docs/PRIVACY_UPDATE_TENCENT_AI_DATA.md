# Privacy update — Tencent SOE evaluated, **NOT ADOPTED**

**Status: reversed 2026-09-27. The in-app disclosure has been reverted and names no
Chinese processor.** Tone grading is going **on-device** instead
(`docs/LOCAL_TONE_PLAN.md`), which needs no vendor, no network and no cross-border
transfer — so everything below about contracts, transfers and store-label moves is
**no longer required**.

Kept as a record because two parts are still live and one part is still useful if the
decision is ever revisited:

- **Still live:** the URL inventory below, and the fact that **the public policy page is
  not in this repository**.
- **Still live, and unrelated to Tencent:** the consent-logging gap (item 2) and the US
  biometric point (item 4) — both apply to sending voice to Azure as well.
- **Useful if revisited:** the vendor verification, and the checklist items 1 and 3.

Not legal advice.

## Why this is a material change, not a wording tweak

Two facts changed at once, and both are the kind a policy has to state explicitly:

1. **A new sub-processor receives audio.** Voice recordings submitted for
   pronunciation and tone grading now go to **Tencent Cloud Smart Oral Evaluation
   (智聆口语评测)**. They previously went to Microsoft Azure, which is still named in
   the policy and still handles speech recognition and cloud-voice text.
2. **The audio crosses a border, to mainland China.** Tencent Cloud serves SOE from
   the mainland, and the SOE API does not accept a `Region` parameter — so there is no
   choice of processing location.

Voice recordings are personal data, and this app's audience is **adult learners of
Chinese** — which shapes the risk in two directions. There is no children's-data
regime in play (COPPA, Apple's Kids Category and Play's Families rules do not apply),
so verifiable parental consent is not required and a clear informed opt-in is the
right model. But the audience cuts the other way too: these are people *studying China
on purpose*, which lowers the cultural shock of a Chinese processor, while university
Chinese departments and schools — a natural institutional channel for this app — are
exactly the buyers most likely to hold a blanket rule against China-hosted data.

## Where the policy is referenced — the whole inventory

Three in-app entry points, all reaching the same external page:

| Entry point | URL |
|---|---|
| Settings → AI Data & Privacy → "Read Full Privacy Policy" | `https://sinospark.app/privacy.html#ai-data` |
| Auth screen → Privacy Policy / Terms | `https://sinospark.app/privacy.html`, `/terms.html` |
| Paywall → Privacy Policy / Terms | `https://sinospark.app/privacy.html`, `/terms.html` |

**None of those pages exist in this repository.** `web/index.html` is the Flutter web
bootstrap ("A new Flutter project") and `firebase.json` has no `hosting` block, so the
site is served from somewhere else. To find its source:

```
rg "sinospark.app/privacy" -g '!build' -g '!node_modules'
```

Keep the `#ai-data` fragment — the app deep-links to it.

## What changed in the app (done)

| Key (`lib/l10n/app_en.arb`) | Change |
|---|---|
| `aiConsentProvidersBody` | Azure reduced to *speech recognition & voice synthesis*; **Tencent Cloud Smart Oral Evaluation** added for pronunciation & tone, **with "processed in mainland China" in the same bullet** |
| `aiDataPrivacyProvidersBody` | the same reassignment, one sentence longer, with the residency explained |
| `aiDataPrivacySentBody` | now states that grading recordings are transferred to Tencent Cloud in mainland China, and that the other speech features use Azure |
| `aiDataPrivacyControlsBody` | states the only real opt-out: *"Skipping voice practice is the only way to avoid the mainland-China transfer — pronunciation and tone cannot be graded without sending the recording to Tencent Cloud."* |

⚠️ All four live in `app_en.arb` only. `flutter gen-l10n` reports the new strings as
untranslated per locale, consistent with the ~200-key English-fallback gap this project
already carries. A **native reviewer should take the residency sentences** in
particular — a privacy disclosure is the one place a machine translation is not good
enough.

## Copy to publish — the `#ai-data` section

Paste-ready. The heading structure mirrors the in-app cards so the two cannot drift.

> ### AI service providers
>
> SinoSpark uses third-party AI services only when you choose a feature that needs
> them. The processors, and what each receives, are:
>
> - **Google Gemini** — generative text and image requests.
> - **OpenRouter** — routes some generative requests to Google Gemini or DeepSeek.
> - **Microsoft Azure AI Speech** — speech recognition, and the text sent for cloud
>   voice synthesis.
> - **Tencent Cloud Smart Oral Evaluation** — the voice recordings you submit for
>   pronunciation and tone grading. Tencent Cloud processes these in **mainland
>   China**, so submitting a recording for grading transfers it there. The grading API
>   does not offer an alternative processing region.
>
> ### Your choices
>
> You do not have to use AI features. Declining the AI consent leaves the rest of the
> app available. **Pronunciation and tone grading cannot be done without sending the
> recording to Tencent Cloud** — skipping voice practice is the only way to avoid that
> transfer. You can also deny microphone, camera or photo permission in your device
> settings, and choose the on-device voice to keep text-to-speech local.
>
> ### Retention
>
> SinoSpark does not intentionally store raw prompts, submitted images or voice
> recordings on its own servers after processing. Tencent Cloud does not retain the
> audio submitted for grading by default; see their terms for detail. Generated
> results are saved on your device or with your account only when you choose to save
> them.

## Store data-safety labels that must change

- **Apple App Store** privacy details: "Audio Data" is now collected by **Tencent
  Cloud** as a third-party processor, not only Azure, and is **transferred
  internationally**. Guideline 5.1.1 requires the disclosure to match the in-app text.
- **Google Play** Data safety: declare Audio → *collected* **and** *shared* with a
  named third party, with the transfer entry reflecting a non-EU/US destination.
- **Institutional buyers:** university Chinese departments, schools and employers are a
  natural channel for a Chinese-learning app, and they routinely apply their own
  data-residency rules regardless of what the stores allow. Worth having a one-line
  answer ready before a procurement questionnaire asks.

## What actually needs doing — a checklist, not legal advice

Ordered by what a regulator or a store app reviewer reaches for first. **I am not a
lawyer**; this is an engineering-derived list to take to one. Item 1 is the only true
blocker.

### 1. Contracts — the blocker, and the cheapest thing to resolve

- [ ] **A DPA with Tencent** naming them a processor for the audio: confidentiality,
      security, breach notice, deletion. **Without this there is no lawful basis for an
      EU/UK transfer, whatever else is in place.** A vendor of their size has a
      standard one — ask for it.
- [ ] **SCCs** (EU 2021/914, plus the UK addendum) with Tencent **if you have EU/UK
      users**. Tencent will either produce these or decline; either answer settles the
      question quickly.
- [ ] Confirm the **Azure and Google** DPAs are in place — normally accepted inside
      their standard terms, so usually already done.
- [ ] **Get retention in writing.** SOE's `StorageMode` defaults to *not storing* the
      audio, and the whole "processed ephemerally" claim in your consent sheet rests on
      it. If they *do* retain it, the analysis gets materially worse.

### 2. The paperwork a regulator asks to see

- [ ] **Transfer Impact Assessment (TIA)** — 2–4 pages: what data, to where, the legal
      regime in the destination, the safeguards (TLS, no names or emails, no retention,
      contractual commitments), and a conclusion. This is the step people skip and the
      first thing asked for. Write it before you need it, not after.
- [ ] **Record of processing** (GDPR Art. 30) — a table with one row per processor.
- [ ] **Log the consent.** Today `has_agreed_to_ai_privacy` is a local boolean with no
      timestamp or version. Consent has to be demonstrable, so record *when* and *which
      version* of the disclosure was agreed to.

### 3. Transparency — the part that is genuinely a legal duty

- [ ] **Publish the updated policy page** and keep it matching the app. (Not in this
      repo — see the inventory above.)
- [ ] **Apple App Privacy** and **Google Play Data safety**: Audio Data → collected
      **and shared with Tencent Cloud**, transferred internationally.
- [ ] **Keep the age rating as an adult audience.** That is the single thing that keeps
      the children's regimes out of scope — so don't let it drift.

### 4. US-specific — the sharpest remaining item for an adult audience

- [ ] **Illinois BIPA / Texas CUBI / Washington HB 1493.** BIPA carries statutory
      damages and a private right of action, and whether a raw recording counts as a
      "voiceprint" is litigated rather than settled. The low-cost protection is a
      **written consent specific to voice** — what is collected, why, how long, who
      receives it — before the first recording, plus a public retention statement. That
      is a small addition to the consent sheet you already show.
- [ ] **CCPA/CPRA** if you cross its thresholds. The policy copy above covers most of
      it; note that CPRA classes biometric information as *sensitive personal
      information* with a right to limit.

### The one engineering change that deletes the problem

**Do not send EU/UK users' audio across the border.** The proxy already knows who is
calling, so a region switch can route pronunciation and tone grading to **Azure** for
EU/UK users and **Tencent SOE** for everyone else. Without a third-country transfer
there is nothing to justify for those users, and the SCC and TIA work stops being
load-bearing. This is the highest-leverage item on the page and it is code, not
counsel.

### Not applicable, given an adult audience

COPPA and verifiable parental consent; Apple's Kids Category and Play's Families
rules; PIPL outbound-transfer filings (the inbound direction is Tencent's duty, not
yours).

## The alternative worth knowing about

`audit/audit_40_tone_assessment_bake_off.md` §3.3 records that **SpeechSuper** is the
only candidate with a genuinely **on-device** path — a Mandarin acoustic model running
on the phone, with the audio never leaving it. If the mainland-China transfer is judged
unacceptable, that route, or reverting tone grading to Azure and shipping no tone
score, are the two ways to avoid it entirely.
