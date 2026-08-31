# API Calls & Their Output Language

This document lists every external API call made across the application (non-tool source files under `lib/`) and documents whether the response content is in English, Chinese, or mixed. Developer-only scripts under `scratch/`, `tool/`, `tooling/`, `test/`, and root-level `.dart` utilities are noted separately.

---

## Legend

| Language | Description |
|---|---|
| **EN** | Response is English text |
| **ZH** | Response is Chinese text |
| **MIXED** | Response contains both English and Chinese |
| **BINARY** | Response is binary (audio) |
| **N/A** | No inherent language (structured data, JSON keys) |

---

## 1. OpenRouter API (`https://openrouter.ai/api/v1/chat/completions`)

**Endpoint:** `POST` — used via `makeOpenRouterCall()` in `lib/core/services/gemini_service.dart`

All OpenRouter calls prompt Gemini/DEEPSEEK models and request the response in a **specific language** via the prompt. Every single call is explicitly told to output in the user's **target language** (FR, ES, DE, JA, KO, IT, PT, RU, AR, ID, VI, HI) **or English** when no target language applies.

| # | Caller File | Method / Feature | Language Instruction | Output Lang |
|---|---|---|---|---|
| 1.1 | `gemini_service.dart` | `generateText()` [generic] | Varies per caller | varies |
| 1.2 | `gemini_service.dart` | `streamGenerateText()` | Varies per caller | varies |
| 1.3 | `gemini_service.dart` | `getFlashcardContext()` (mnemonic) | "Use the user's native language: $targetLanguage" | **target lang or EN** |
| 1.4 | `gemini_service.dart` | `getTranslation()` | "Translate to $targetLanguage" | **target lang or EN** |
| 1.5 | `gemini_service.dart` | `extractTextFromImageDetailed()` (OCR) | "Extract ALL text. Return JSON." | **ZH** (Chinese from image) |
| 1.6 | `gemini_service.dart` | `generateDeckTitle()` | No language constraint → model default | **EN** |
| 1.7 | `gemini_service.dart` | `generateDeckDescription()` | No language constraint → model default | **EN** |
| 1.8 | `gemini_service.dart` | `generateAddToDeck()` | "english" JSON key → model default | **EN** |
| 1.9 | `gemini_service.dart` | `generateStory()` | "Put the $targetLanguage translation in the english key" | **target lang** |
| 1.10 | `gemini_service.dart` | `generatePoemStory()` | Prompt asks for $targetLanguage | **target lang** |
| 1.11 | `gemini_service.dart` | `generateSentenceAudio()` | Short text pass-through | **ZH** |
| 1.12 | `gemini_service.dart` | `extractVocabularyFromTranscript()` | No language constraint | **EN / MIXED** |
| 1.13 | `gemini_service.dart` | `extractTranscriptJson()` | "Return Chinese transcript..." | **ZH** |
| 1.14 | `echo_hall_service.dart` | `getConversationResponse()` | Persona + JSON with "english" key | **MIXED** (ZH + target) |
| 1.15 | `echo_hall_service.dart` | `getResponse()` | Persona instructions | **MIXED** (ZH + EN) |
| 1.16 | `echo_hall_service.dart` | `getPronunciationFeedback()` | "Critique **in English**" | **EN** |
| 1.17 | `cultural_context_provider.dart` | insight generation | "Write primarily **in English**" | **EN** |
| 1.18 | `cultural_context_provider.g.dart` | (generated riverpod) | Same as 1.17 | **EN** |

### Summary — OpenRouter
- **EN-only:** 1.1 (when called by cultural_context), 1.6, 1.7, 1.8, 1.16, 1.17, 1.18
- **Target-language (user's L1):** 1.3, 1.4, 1.9, 1.10
- **ZH:** 1.5, 1.11, 1.13
- **MIXED:** 1.12, 1.14, 1.15

---

## 2. YouTube Data API v3 (`https://www.googleapis.com/youtube/v3/...`)

**Endpoint:** `GET` — used via `http.get()` and `_client.get()`

| # | Caller File | URL Pattern | Response Lang | Notes |
|---|---|---|---|---|
| 2.1 | `show_repository.dart` | `/youtube/v3/playlistItems?part=snippet,contentDetails&playlistId=...` | **N/A** — JSON, titles in **ZH** | Chinese drama episodes |
| 2.2 | `show_repository.dart` | `/youtube/v3/channels?part=snippet&id=...` | **N/A** — JSON metadata | Channel names in ZH |
| 2.3 | `show_repository.dart` | `/youtube/v3/search` | **N/A** — JSON, titles in **ZH** | Chinese video titles |
| 2.4 | `youtube_repository.dart` | YoutubeExplodeDart → `yt.search.search()` | **ZH** (Chinese video titles) | Chinese content search |
| 2.5 | `youtube_repository.dart` | YoutubeExplodeDart → `yt.channels.getUploadsFromPage()` | **ZH** (Chinese video titles) | Chinese content |
| 2.6 | `youtube_repository.dart` | `yt.videos.closedCaptions.getManifest()` | **N/A** — language codes only | Metadata only |
| 2.7 | `youtube_repository.dart` | `yt.videos.closedCaptions.getByTrackId()` | **ZH** (Chinese transcript) | Video subtitles |
| 2.8 | `daily_discovery_repository.dart` | YoutubeExplodeDart → channel video fetch | **ZH/EN** | Mixed language channels |

### Helper/debug scripts (not in `lib/`):
- `fetch_shows_api.dart` — Direct API calls; response JSON with ZH titles
- `fetch_new_shows.dart` — Uses YoutubeExplode; same as above

---

## 3. Google Translate API (`translate.googleapis.com`)

**Endpoint:** `GET /translate_a/single` — used in `local_translation_service.dart`

| # | Caller File | Method | Source → Target | Output Lang |
|---|---|---|---|---|
| 3.1 | `local_translation_service.dart` | `translateWordDefinition()` | **EN** → $targetLanguage | **target lang** (user's L1) |
| 3.2 | `local_translation_service.dart` | `translateText()` | **ZH-CN** → $targetLanguage | **target lang** (user's L1) |

Both calls translate **away from** English/Chinese into the user's chosen language. The translations are never intentionally in English — they go **to** the user's L1 (which could be EN if the user selected English).

---

## 4. Google Gemini Native API (`generativelanguage.googleapis.com`)

**Endpoint:** `POST` — used in standalone test file only

| # | Caller File | Method | Output Lang |
|---|---|---|---|
| 4.1 | `test_gemini.dart` (root-level test, not in `lib/`) | Gemini SDK direct call | **EN** (model default) |

This is a quick test/sanity check script, not app code.

---

## 5. Azure Cognitive Services — TTS (`cognitiveservices.azure.com`)

**Endpoint:** `POST` — used in `audio_service.dart`

| # | Caller File | URL Pattern | Output | Notes |
|---|---|---|---|---|
| 5.1 | `audio_service.dart` | `$region.tts.speech.microsoft.com/cognitiveservices/v1` | **AUDIO** (Chinese speech) | SSML: `xml:lang="zh-CN"`, voice `zh-CN-XiaoxiaoNeural` |

TTS (Text-to-Speech) API. Input is Chinese text, output is Chinese binary MP3 audio. No text content in the response.

---

## 6. Hanzi Writer Data CDN (`cdn.jsdelivr.net`)

**Endpoint:** `GET` — used in `flashcard_repository_impl.dart`

| # | Caller File | URL Pattern | Output Lang | Notes |
|---|---|---|---|---|
| 6.1 | `flashcard_repository_impl.dart` | `cdn.jsdelivr.net/npm/hanzi-writer-data@2.0.1/$char.json` | **N/A** — stroke path data | No human language; pure geometry data |

---

## 7. BBC RSS Feed (`feeds.bbci.co.uk`)

**Endpoint:** `GET` — used in `daily_discovery_repository.dart`

| # | Caller File | URL Pattern | Output Lang | Notes |
|---|---|---|---|---|
| 7.1 | `daily_discovery_repository.dart` | `feeds.bbci.co.uk/zhongwen/simp/rss.xml` | **ZH** (Simplified Chinese) | BBC Chinese news RSS — `/zhongwen/simp` is the Chinese-language feed |

---

## 8. Mandarin Bean RSS Feed (`mandarinbean.com`)

**Endpoint:** `GET` — used in tool/scratch scripts only (not in production `lib/`)

| # | Caller File | URL Pattern | Output Lang |
|---|---|---|---|
| 8.1 | `tool/scrape_mandarin_bean.dart` | `mandarinbean.com/feed/` | **ZH** (Chinese blog/story titles) |
| 8.2 | `scratch/download_mandarin_bean.dart` | `mandarinbean.com/feed/?paged=$page` | **ZH** |

---

## 9. Local (On-Device) ML Kit Models (no HTTP)

| # | Service | Model | Output Lang |
|---|---|---|---|
| 9.1 | `ocr_service.dart` | Delegates to Gemini Vision (see 1.5) | **ZH** |
| 9.2 | `vision_service.dart` | Google ML Kit Object Detection | **N/A** (class labels in EN) |
| 9.3 | `local_translation_service.dart` | Google ML Kit On-Device Translator | **target lang** |
| 9.4 | `speech_service.dart` | Device STT engine | **ZH** (listens for Chinese) |

---

## 10. Wikipedia / Wikimedia URLs (hardcoded, not actively fetched)

| # | File | URL | Notes |
|---|---|---|---|
| 10.1 | Various | `upload.wikimedia.org` | Hardcoded image URLs in assets / data |
| 10.2 | `story_fetcher_service.dart` | `zh.wikipedia.org` | Referenced in comments only |

---

## Summary Table (Production `lib/` code only)

| API / Endpoint | # Call Sites | EN Output | Other Language Output |
|---|---|---|---|
| **OpenRouter** (Gemini/DEEPSEEK) | 18 | 7 EN, 4 target-L1, 2 ZH, 3 MIXED, 2 varies | See §1 |
| **YouTube Data API v3** | 5 | 0 | ZH (titles/transcripts) |
| **Google Translate** | 2 | 0 (unless user L1=EN) | target L1 |
| **Azure TTS** | 1 | 0 | Chinese audio |
| **jsDelivr CDN** | 1 | 0 | stroke data (no language) |
| **BBC RSS** | 1 | 0 | ZH |

### Calls whose response is **always** English:
1. **`gemini_service.dart`:** `generateDeckTitle()` — no language instruction → model defaults to **EN**
2. **`gemini_service.dart`:** `generateDeckDescription()` — no language instruction → model defaults to **EN**
3. **`gemini_service.dart`:** `generateAddToDeck()` — "english" JSON key → model defaults to **EN**
4. **`echo_hall_service.dart`:** `getPronunciationFeedback()` — explicitly says **"in English"**
5. **`cultural_context_provider.dart`:** insight prompt — explicitly says **"Write primarily in English"**

### Calls whose response **could be English** (if user's L1 is English):
1. **`gemini_service.dart`:** `getFlashcardContext()` — uses `$targetLanguage`
2. **`gemini_service.dart`:** `getTranslation()` — targets user's L1
3. **`gemini_service.dart`:** `generateStory()` — targets user's L1
4. **`local_translation_service.dart`:** both translate calls go to user's L1
5. **`echo_hall_service.dart`:** `getConversationResponse()` — mixed output includes English