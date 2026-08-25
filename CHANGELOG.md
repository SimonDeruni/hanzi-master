# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]
- **Non-Chinese Utterance Handling in Call Summary**:
  - Automatically disabled the "Tap to review" prompt and sheet when an utterance is in English or contains no Chinese characters. Bumped build to `1.0.0+136`.
- **Real Acoustic Tone Assessment & Live Character Coloring**:
  - Connected live speech acoustic confidence and phoneme tone alignment to user bubbles, dynamically coloring each Hanzi character (Green / Orange / Red) with exact expected vs spoken tones.
  - Added dynamic score badges (`Tone Accurate • 88%`, `Tone Needs Work • 65%`) and preserved full round-by-round `PronunciationGrade` metrics for in-depth review sheets on the call summary screen. Bumped build to `1.0.0+135`.
- **Continuous Multi-Word Sentence Recognition**:
  - Enabled `ListenMode.dictation` in `SpeechListenOptions` so the speech recognizer listens for full sentences and multi-word conversational thoughts rather than cutting off after single words. Bumped build to `1.0.0+134`.
- **Instant AI Turn Processing & Non-Blocking Translation**:
  - Replaced blocking ML Kit model lookup with non-blocking timeout handling so Gemini and Azure Neural speech respond instantaneously upon user speech completion.
  - Set conversational speech pause timeout to 2.5s for snappy turn-taking, and guaranteed clean session reset in `SpeechService`. Bumped build to `1.0.0+133`.
- **Speech Recognition Robustness**:
  - Set `cancelOnError: false` in `SpeechListenOptions` within `SpeechService` so ambient acoustic glitches and non-fatal errors do not terminate active speech recognition sessions. Bumped build to `1.0.0+132`.
- **Optimized 5-Second Silence Timeout**:
  - Fine-tuned speech recognition pause timeout (`pauseFor`) to **5 seconds** in `SpeechService` and `LiveCallScreen` for optimal conversational rhythm without premature cutoffs. Bumped build to `1.0.0+131`.
- **Loud Audio Speaker Routing & Full Pronunciation Grade Structure**:
  - Enforced `AudioContextIOS` and `AudioContextAndroid` with `defaultToSpeaker: true` and `isSpeakerphoneOn: true` at volume `1.0` in `AudioService.playSentence` so Azure Neural voice plays loudly through phone loudspeakers.
  - Built complete `PronunciationGrade` model map with individual `wordScore`, tone metrics, and overall score for interactive live badges and full review report sheets on call summary. Bumped build to `1.0.0+129`.
- **Live Call Full Translation & Pinyin for Both Parties**:
  - Connected user speech transcription to `LocalTranslationService` and `PinyinHelper` so user bubbles display spoken Chinese, tone-marked Pinyin, English translation, and live tone badges.
  - Streamlined Gemini prompt to 3-part format (`Chinese|||Pinyin|||English`) ensuring 100% subtitle consistency across all turns with fail-safe local Pinyin generator. Bumped build to `1.0.0+128`.
- **Security & Secrets Cleanup**: Reverted all hardcoded fallback API keys in `ApiKeyPool` to strict environment variables / `.env` resolution.
- **Azure Cognitive Services Neural TTS Fixes**:
  - **High-Speed MP3 Audio Format**: Switched audio output from uncompressed PCM WAV to `audio-16khz-128kbitrate-mono-mp3`, reducing network payload size from 300KB+ to ~20KB for instantaneous streaming playback.
  - **Extended Connection Timeout & Headers**: Increased Azure HTTP timeout from 3s to 10s and included required `User-Agent: SinoSpark` header.
  - **Live Pronunciation Rating**: Added real-time tone extraction and accuracy grading for user utterances, rendering tone-colored character chips and live accuracy badges.
  - **Persistent Subtitles**: Fixed Gemini history formatting so four-part `|||` delimited responses are maintained across infinite conversation turns, with automatic `lpinyin` fallback. Bumped build to `1.0.0+125`.
- **CI/CD Build Cupertino Import Fix**: Added explicit `package:flutter/cupertino.dart` import in `app_theme.dart` to resolve `CupertinoPageTransitionsBuilder` compilation error on Xcode CI/CD builders.
- **Live Call Ticker Provider Fix**: Switched `_LiveCallScreenState` from `SingleTickerProviderStateMixin` to `TickerProviderStateMixin` to resolve the Flutter runtime crash caused by multiple concurrent animation controllers (`_pulseController` and `_analyzePulseController`).
- **Paywall Legal Links & Restore Purchases Verification**: Verified `_restorePurchases()` calls `Purchases.restorePurchases()` with active state feedback and updated `_launchURL()` to use `LaunchMode.externalApplication` for seamless Safari opening of Terms & Privacy policies.
- **AI Tutor Guest & Logout Privacy Isolation**: Enforced strict authentication and `!isAnonymous` checks in `_getUserAddressingInstruction()` so logged-out or guest users are never addressed by name. Scoped AI chat caches by `userId` and added automatic cache clearing on `signOut()` in `AuthRepository`.
- **Notification Text Cleanup**: Removed legacy "Daily Spark" branding and "Video of the Day" references from `NotificationService` and onboarding permission screens, updating copy to "Daily Discovery Drop" (Word and Story of the Day).

### Added
- **Dynamic Custom Paywall Overhaul**: Rebuilt the paywall with comprehensive feature selling points (Precision Stroke Engine, AI Pronunciation Grading, Smart News & One-Tap Dictionary, Universal Camera & Photo Scanner, Live Translation & Travel Interpreter, Complete HSK 1-6 Tomes, adaptive spaced repetition and AI custom decks), dynamic pricing breakdowns computed directly from RevenueCat store product prices, Blinkist-style trial timeline, and direct legal links (`https://sinospark.app/terms.html`, `https://sinospark.app/privacy.html`).
- **Unified Dynamic Dark/Light Mode for Onboarding**: Ensured full contrast and color inversion across all onboarding selection cards, grid cards, and notification permissions, perfectly adhering to the Zen & Ink design guidelines.
- **Overhauled AI Curriculum Calibration Screen**: Replaced the static text card with an interactive, live-animated calibration experience featuring a dynamic percentage progress bar, step-by-step milestone checkmarks (Mastery Level, Focus Alignment, Daily Ritual, AI Neural SRS Decks), haptic tick feedback, and an active completion CTA button.

### Changed
- **Comprehensive Codebase Hygiene & Performance Optimization (`lib/`)**:
  - Achieved **0 errors and 0 warnings** across the entire application codebase (`lib/`).
  - Preserved 100% of dynamic Light/Dark theme rendering and color variables.
  - Eliminated dead fields, unreferenced variables, and unused imports across all features (`shadowing_studio_screen`, `smart_media_desk_screen`, `web_browser_screen`, `profile_screen`, `dashboard_screen`, `story_mode_screen`, `dictionary_screen`, etc.).
  - Added strict `context.mounted` safety guards across async boundary flows in UI sheets and screens to prevent crashes on pop.
  - Modernized deprecated APIs (`Color.withOpacity` ➔ `Color.withValues()`, `Purchases.purchasePackage` ➔ `Purchases.purchase(PurchaseParams.package())`, `onPopInvoked` ➔ `onPopInvokedWithResult`).
- **Onboarding Vertical Layout Balance**: Rebalanced vertical margins and pinned primary call-to-action buttons to the bottom of the screen across all onboarding steps to prevent top crowding and eliminate bottom voids.

### Fixed
- **Pronunciation Assessment — Character & Phoneme Score of Zero Fix**:
  - Fixed a JSON key discrepancy in `SyllableGrade.fromJson` where `wordScore` defaulted to `0` because Azure returned `accuracyScore`.
  - Added recursive syllable-to-phoneme parsing for Azure Chinese (`zh-CN`), ensuring phoneme sub-scores nested under `w['Syllables']` are accurately parsed rather than being lost.
  - Added automatic fallback to syllable/sentence accuracy whenever Azure omits sub-phoneme scores, ensuring characters rated above zero in the sentence are accurately scored in word cards and feedback sheets.
  - Extracted and populated `expectedTone` and `actualTone` for pronunciation feedback chips.
- **Live Call — Audio Session, Microphone & Listening Loop Overhaul**:
  - **Phone Audio Route Fix**: Replaced `flutter_sound` with `audioplayers`, configured `AudioContextIOS` with `defaultToSpeaker: true` and `allowBluetooth: true`, and added audio session restoration upon call exit to prevent your phone sound from degrading or getting stuck in earpiece mode.
  - **Microphone Contention Fix**: Removed parallel `Record` package background recording during live speech recognition, giving `speech_to_text` 100% exclusive access to the microphone for crystal-clear voice capture without choppy/dropped words.
  - **5-Second Reconnect Loop Fix**: Extended listening duration to 60s, increased silence pause threshold to 3s, and introduced smooth background silence resumption so the screen stays calmly on "Listening..." without flickering or triggering reconnect loops.
  - **Speaker Toggle**: Connected the Speaker button to active native audio session routing (`defaultToSpeaker: true` vs earpiece).
  - **Hidden Mode & User Subtitles**: Removed `🔊` emoji in Hidden mode, added real-time Pinyin via `lpinyin`, and added Gemini English translations for user speech turns.
- **Universal Scanner — Aspect Ratio & Orientation Stabilization**: Fixed horizontal squishing and vertical stretching in camera previews by swapping out flawed FittedBox scaling for proportional `Transform.scale` and locking orientation during scans.
- **Library / Latest Discoveries**: Fixed an issue where older saved flashcards (like "吃") that were missing pinyin or definition metadata rendered as visually broken, "empty" UI cards in the library carousel and dictionary list. Converted `_LexiconMiniCard` and `_DictionaryItem` into stateful widgets that now automatically detect missing metadata upon render and asynchronously hydrate themselves from the bundled SQLite dictionary, restoring perfect visual consistency without requiring a full database migration.
- **AR Camera Permission/Soft-lock**: Fixed a complete UI crash when the AR feature was accessed without camera permissions. Added a fallback UI displaying a permission request and an "Open Settings" button, and wrapped the background to prevent it from shrinking to 0x0 size and showing a blank screen.
- **Universal Scanner Camera Permission**: Fixed a bug where the scanner failed to recognize granted camera permissions or trigger the native iOS prompt. Replaced the outdated beige error banner with a premium, floating toast notification that correctly guides users to settings if permission is permanently denied.
- **Shadowing Studio — Scoring Engine Accuracy**: Replaced Azure's holistic `PronScore` mapping with a pure, mathematical average of the `AccuracyScore` from explicitly spoken words. This prevents the score from plummeting to an absolute `0/100` when a user's microphone cuts off early, restoring parity between the visual breakdown (green/orange/red text) and the global score. Also introduced `Colors.grey` to render explicitly "Omitted" words.
- **Smart Media Desk — Overlay Event Bubbling & State Synchronization**: Hoisted internal state management from `FullscreenMediaOverlay` to the global parent controller (`_SmartMediaDeskScreenState`), eliminating the bug where entering fullscreen forcibly resets toggles to an "On" default state while maintaining actual values. Also applied `enabled: false` to the switch wrappers in `PremiumVideoTopBar` to prevent the `PopupMenuButton` from closing instantly when interacted with.

### Fixed
- **Universal Scanner Camera Permission**: Fixed a bug where the scanner failed to properly refresh the system's camera authorization status when returning from the OS Settings app. Completely bypassed the permission_handler plugin for camera access to circumvent iOS Podfile macro compilation bugs.
- **UI/UX Clarity**: Added an interactive tooltip and first-time onboarding modal for the ? AI Generated flashcard badge to clarify its source and advise on accuracy checks.
- **Privacy & Compliance**: Enforced Zero Data Retention (ZDR) across AI integrations. Added programmatic block flags to the OpenRouter payload to guarantee that chat history is never logged or used for model training, legally enforcing the app's privacy claims. The Universal Scanner now relies on the native camera package's internal authorization mechanisms, guaranteeing that the feed initializes instantly once OS-level permission is granted without false negative blockages.
- **AI Story Reader UI**: Refactored the story reader screens (StoryReaderScreen and StoryModeScreen) from paginated layouts to a continuous scrolling flow. Removed PageView and integrated all text into a SingleChildScrollView to eliminate reading friction and prevent wasted screen real estate, as per the layout enhancement request.
- **AI Hub**: Completely redesigned the layout of `AiHubScreen`. Replaced the massive, infinitely stretching vertical cards with a balanced, side-by-side square tile 2x2 grid layout (`AspectRatio` 1:1). Converted the solid bright colors into a premium dark glassmorphic design (`#1A1A1B`) featuring subtle neon borders, glowing drop shadows, and faded watermark background icons.

### Fixed
- **Universal Scanner Camera Permission**: Fixed a bug where the scanner failed to properly refresh the system's camera authorization status when returning from the OS Settings app. Completely bypassed the permission_handler plugin for camera access to circumvent iOS Podfile macro compilation bugs.
- **UI/UX Clarity**: Added an interactive tooltip and first-time onboarding modal for the ? AI Generated flashcard badge to clarify its source and advise on accuracy checks.
- **Privacy & Compliance**: Enforced Zero Data Retention (ZDR) across AI integrations. Added programmatic block flags to the OpenRouter payload to guarantee that chat history is never logged or used for model training, legally enforcing the app's privacy claims. The Universal Scanner now relies on the native camera package's internal authorization mechanisms, guaranteeing that the feed initializes instantly once OS-level permission is granted without false negative blockages.
- **AI Story Reader UI**: Refactored the story reader screens (StoryReaderScreen and StoryModeScreen) from paginated layouts to a continuous scrolling flow. Removed PageView and integrated all text into a SingleChildScrollView to eliminate reading friction and prevent wasted screen real estate, as per the layout enhancement request.
- **Translation Hub / Live Translate**: Completely redesigned the layout of `TranslationHubScreen`. Replaced the massive, infinitely stretching vertical cards with a balanced, side-by-side square tile layout (`AspectRatio` 1:1). Converted the solid bright colors into a premium dark glassmorphic design (`#1A1A1B`) featuring subtle neon borders, glowing drop shadows, and faded watermark background icons.

### Fixed
- **Universal Scanner Camera Permission**: Fixed a bug where the scanner failed to properly refresh the system's camera authorization status when returning from the OS Settings app. Completely bypassed the permission_handler plugin for camera access to circumvent iOS Podfile macro compilation bugs.
- **UI/UX Clarity**: Added an interactive tooltip and first-time onboarding modal for the ? AI Generated flashcard badge to clarify its source and advise on accuracy checks.
- **Privacy & Compliance**: Enforced Zero Data Retention (ZDR) across AI integrations. Added programmatic block flags to the OpenRouter payload to guarantee that chat history is never logged or used for model training, legally enforcing the app's privacy claims. The Universal Scanner now relies on the native camera package's internal authorization mechanisms, guaranteeing that the feed initializes instantly once OS-level permission is granted without false negative blockages.
- **AI Story Reader UI**: Refactored the story reader screens (StoryReaderScreen and StoryModeScreen) from paginated layouts to a continuous scrolling flow. Removed PageView and integrated all text into a SingleChildScrollView to eliminate reading friction and prevent wasted screen real estate, as per the layout enhancement request.
- **Library Story Audio Playback**: Fixed a bug in `StoryReaderScreen` where the audio reader only played one out of three sentences per page and failed to highlight spoken words correctly. The text is now properly chunked and concatenated per page, and local offsets are mapped to the global chunk, restoring fluid playback and highlighting.
- **HSK 0 UI Clutter**: Added conditional rendering to hide "HSK 0" labels and badges globally for custom generated stories (which do not inherently have an HSK level).
- **AI Hub Layout Misalignment**: Fixed an issue where the `AiHubScreen` header appeared misaligned compared to other tabs by removing an erroneous `SafeArea` wrapper around its `CustomScrollView`, allowing `GlobalSliverAppBar` to manage the status bar padding correctly.

### Fixed
- **Universal Scanner Camera Permission**: Fixed a bug where the scanner failed to properly refresh the system's camera authorization status when returning from the OS Settings app. Completely bypassed the permission_handler plugin for camera access to circumvent iOS Podfile macro compilation bugs.
- **UI/UX Clarity**: Added an interactive tooltip and first-time onboarding modal for the ? AI Generated flashcard badge to clarify its source and advise on accuracy checks.
- **Privacy & Compliance**: Enforced Zero Data Retention (ZDR) across AI integrations. Added programmatic block flags to the OpenRouter payload to guarantee that chat history is never logged or used for model training, legally enforcing the app's privacy claims. The Universal Scanner now relies on the native camera package's internal authorization mechanisms, guaranteeing that the feed initializes instantly once OS-level permission is granted without false negative blockages.
- **AI Story Reader UI**: Refactored the story reader screens (StoryReaderScreen and StoryModeScreen) from paginated layouts to a continuous scrolling flow. Removed PageView and integrated all text into a SingleChildScrollView to eliminate reading friction and prevent wasted screen real estate, as per the layout enhancement request.
- **Smart Media Desk & Video of the Day — YouTube API Quota Migration**: Replaced all YouTube Data API v3 calls in `youtube_repository.dart` and `daily_discovery_repository.dart` with `youtube_explode_dart` (InnerTube scraping). The category carousels, user search, and daily video discovery no longer consume any API quota. Shows & Dramas is untouched (fully local). The fallback logic now uses ANY matching term (OR) instead of requiring ALL terms (AND), fixing the silent empty-result failure.

### Fixed
- **Universal Scanner Camera Permission**: Fixed a bug where the scanner failed to properly refresh the system's camera authorization status when returning from the OS Settings app. Completely bypassed the permission_handler plugin for camera access to circumvent iOS Podfile macro compilation bugs.
- **UI/UX Clarity**: Added an interactive tooltip and first-time onboarding modal for the ? AI Generated flashcard badge to clarify its source and advise on accuracy checks.
- **Privacy & Compliance**: Enforced Zero Data Retention (ZDR) across AI integrations. Added programmatic block flags to the OpenRouter payload to guarantee that chat history is never logged or used for model training, legally enforcing the app's privacy claims. The Universal Scanner now relies on the native camera package's internal authorization mechanisms, guaranteeing that the feed initializes instantly once OS-level permission is granted without false negative blockages.
- **AI Story Reader UI**: Refactored the story reader screens (StoryReaderScreen and StoryModeScreen) from paginated layouts to a continuous scrolling flow. Removed PageView and integrated all text into a SingleChildScrollView to eliminate reading friction and prevent wasted screen real estate, as per the layout enhancement request.
- **Shadowing Studio → Deck Export — Data Hydration Bug**: Cards saved after a shadowing session now have a complete `pinyin` and `definition` (English translation). Previously, `definition` was always `""` and `pinyin` was often empty. The fix calls `GlobalDictionaryRepository.getExact(hanzi)` for each saved word, pulling authoritative data from the bundled SQLite dictionary before writing the `Flashcard` to Hive.

### Added
- Rewrote `rebuild_shows_catalog.dart` to strictly fetch shows that possess soft-coded Chinese captions (using `youtube_explode_dart` `_hasCaps` verification).
- Successfully populated `shows_data.dart` with 10 new soft-captioned shows, yielding a total of 14 hardcoded shows for instant playback without live YouTube Data API overhead.
- Optimized AI text processing in `web_browser_screen.dart` by removing artificial 500ms delays, substituting the DB query with an in-memory cache, and capping the JS text extraction to 3000 chars.
- **Smart Media Desk Enhancements**:
    - Reconstructed Chinese Hanzi characters from Pinyin-only subtitle tracks using background Gemini processing.
    - Integrated background translation of transcripts into the user's selected `targetLanguage` (aligned with device language).
    - Enabled seeking the video timeline by tapping anywhere on a transcript line card.
    - Highlighted active spoken characters in premium blue (`#1976D2`).
    - Reintroduced the yellow AI micro-lesson button (`Icons.auto_awesome`) on the bottom-right of each transcript card.
- **Unified Graph Architecture (Phase 2 - Stealth Reviews)**:
    - Updated custom AI Story Generation to dynamically fetch due flashcards and weave them into the narrative alongside new vocabulary, reinforcing spaced repetition naturally.
- **Unified Graph Architecture (Phase 1)**:
    - Added `sourceSentence` and `sourceContext` to Flashcard entities to maintain origin context from Reading/Story modes.
    - Upgraded `WordDetailDialog` to include an interactive Micro-Calligraphy scratchpad, eliminating the need to navigate away to practice.
    - Updated `RecallModeWidget` to display the origin sentence as a context clue with the target character blanked out.
    - Integrated `CalligraphyCanvasSheet` into `QuickLookSheet` via a new "Trace" button for immediate character practice.
    - Added "Extract & Simplify" button to `WebBrowserScreen` to instantly convert complex web Chinese into HSK-leveled stories using Gemini.
- **Live Call UI**:
    - Fixed Gemini Live Call connection crash (WebSocket 1007 Error) by removing `"TEXT"` from the `responseModalities` payload, which is unsupported by the current model version.
    - Improved error UI to gracefully catch 1000-level WebSocket disconnections and display localized messages instead of raw error codes.
    - Added a prominent "Return to menu" escape button for fallback UI states.
- **UI/UX Polish**:
    - **Premium AI Hub UI**: Completely redesigned the AI Hub layout into a strict, single-page, flexible dashboard (no scrolling) with deep ink aesthetics (`#131A29`) and textured Zen & Ink backgrounds for all action cards. Replaced the "Calligraphy" card with a focused "TODAY'S WORD" hero card, wired directly to `CharacterDetailScreen`.
    - Redesigned `TravelInterpreterScreen` layout for improved 180-degree split-screen visibility and dynamic state backgrounds.
    - **UI / UX**: Added conditional highly visible "TRAILER" and "HIGHLIGHT" badges to Media Cards in the Shows & Dramas catalog to clearly distinguish content types at a glance.
    - **Shows Catalog**: Tagged known trailer and highlight playlists (e.g. *Love Beyond the Grave*, *Legend of The Female General*, *The Princess's Gambit*) in the local database to properly trigger the new badges.
- **Bug Fix**: Fixed a data rendering issue in Smart Media Desk where an exhausted YouTube API quota caused all video categories (e.g., Lifestyle, Gaming) to be overwritten by historical dramas. Removed the aggressive fallback logic so that unrelated categories now gracefully fail with a "Failed to load content" UI rather than showing mismatched content.
- **Bug Fix**: Shadowing Studio always returning `0/100` fixed by stripping Chinese punctuation from the `ReferenceText` payload.
    - Replaced the conversational chat list with a new audio-first Mimicry UI (PageView).
    - Added Tinder-style swipe gestures with corresponding haptic feedback and scale animations to `ReviewScreen` flashcard grading.
    - Expanded Reading Room features with an anchored audio player, inline sentence translation toggle, and 3-mode Pinyin display (All, Ghost, None).
- **Performance**:
    - Implemented a persistent `Hive` cache for Gemini character origin queries to eliminate duplicate AI latency.

### Fixed
- **Universal Scanner Camera Permission**: Fixed a bug where the scanner failed to properly refresh the system's camera authorization status when returning from the OS Settings app. Completely bypassed the permission_handler plugin for camera access to circumvent iOS Podfile macro compilation bugs.
- **UI/UX Clarity**: Added an interactive tooltip and first-time onboarding modal for the ? AI Generated flashcard badge to clarify its source and advise on accuracy checks.
- **Privacy & Compliance**: Enforced Zero Data Retention (ZDR) across AI integrations. Added programmatic block flags to the OpenRouter payload to guarantee that chat history is never logged or used for model training, legally enforcing the app's privacy claims. The Universal Scanner now relies on the native camera package's internal authorization mechanisms, guaranteeing that the feed initializes instantly once OS-level permission is granted without false negative blockages.
- **AI Story Reader UI**: Refactored the story reader screens (StoryReaderScreen and StoryModeScreen) from paginated layouts to a continuous scrolling flow. Removed PageView and integrated all text into a SingleChildScrollView to eliminate reading friction and prevent wasted screen real estate, as per the layout enhancement request.
- **Media Desk Search Crash**:
    - Fixed a `FormatException: Invalid radix-10 number` issue when youtube_explode_dart parses video search metadata on streams (e.g. viewCount/duration). Implemented manual iteration in `YoutubeRepository.searchVideos` to skip corrupt items instead of failing the entire query.
- **Localization**:
    - Extracted hardcoded UI strings into `AppLocalizations` for Echo Hall Scenarios, Master Lin greeting, Reading Room titles/descriptions, and Custom Story Creator Dialog.
    - Generated translations for all new strings across the 12 supported languages.
- **Build Errors**:
    - Fixed `SettingsController` constructor malformation causing Gradle build failures.
    - Resolved `invalid_constant` and `const_eval_method_invocation` errors across multiple UI screens caused by `AppLocalizations` lookups inside `const` widgets.
    - Fixed missing `strokePaths` and `modeStats` arguments in `Flashcard` instantiations within `vision_provider.dart`.
    - Resolved a Dart compilation error causing the iOS build `Target kernel_snapshot_program` to fail by fixing a missing closing parenthesis and incorrect parameter (`keyboardDismissMode`) in `conversation_screen.dart`.
- **Media Playback**:
    - Fixed silent video bug during YouTube media playback by properly configuring the iframe player's unmute options.
- **Audio Processing**:
    - Resolved fragmented UI rendering of the user's pitch contour in the Shadowing Studio's Tone Graph by correctly scaling X/Y coordinates and continuously drawing the line despite zero-pitch pauses.
    - Fixed audio pitch extraction crash during Shadowing Studio grading by ensuring raw audio byte arrays are passed natively to the extraction tool instead of temporary file paths.
- **API Management**:
    - Implemented live API key rotation for YouTube Data API. Both `searchVideos` and `fetchEpisodes` now intercept 403 (Quota Exceeded) errors and automatically try the next keys in the pool before failing.
- Fixed an issue where `MediaSearchScreen` and other features would fail to fetch videos when the YouTube API quota was reached. Modified the local search fallback to return default content when exact tag matches are not found, preventing UI crashes and empty states.
- **Roleplay Chat Polish**:
    - Fixed a bug causing the keyboard to permanently trap users. Tapping the chat background or scrolling the message list now successfully dismisses the keyboard.
    - Fixed a component state failure where the "Hide Translation" toggle button was unresponsive for AI messages.
    - Improved Pinyin formatting by routing raw numeric tone outputs (e.g., `hao3`) through a utility to render standard Unicode diacritics (e.g., `hǎo`).
- **Gemini Live & Travel Interpreter Stability**:
    - Fixed an infinite WebSocket crash loop in Travel Interpreter caused by an invalid `realtimeInput` payload format. Audio streaming is now correctly chunked into `mediaChunks`.
    - Eliminated severe echo and interruption loops in Live Call by enabling OS-level hardware echo cancellation instead of software-based muting.
    - Fixed a bug where the AI's transcript was invisible by properly configuring `responseModalities` to request both `["TEXT", "AUDIO"]`.
    - Integrated `TappableMarkdownHanziText` into Live Call transcripts, allowing users to tap AI-generated Chinese for instant QuickLook dictionary definitions.
    - Added pre-flight API token validation and graceful degradation UI to stop runaway auto-reconnects when the WebSocket connection is permanently rejected.

## [1.2.0] - 2026-06-17

### Added
- **UI Animations**:
    - Added `flutter_animate` package for declarative, chained animations.
    - Implemented global `FadeUpwardsPageTransitionsBuilder` and `CupertinoPageTransitionsBuilder` for premium navigation.
    - Added staggered entry animations for Dashboard elements and subtle breathing animation for the mascot.
    - Introduced a reusable `BouncingButton` widget to add micro-interactions to flashcard grading buttons.
- **Advanced AI Curriculum Engine**:
    - Implemented a Two-Pass AI strategy for high-level syllabus planning and detailed unit execution.
    - Added Component-Based Clustering using radical and decomposition metadata.
    - Integrated "Anchor Word" (Sun node) selection to improve visual and conceptual hierarchy in the Path.
    - Added Prerequisite Mapping to ensure simpler building blocks appear before complex characters.

## [1.1.0] - 2026-06-12

### Changed
- **Cultural Reading Room UI**:
    - Completely overhauled `StoryReaderScreen` to use a rich, word-by-word interactive layout with integrated Pinyin and Audio.
    - Updated `GradedStory` local storage models to `graded_stories_v2` to support `AiSentence` structure.
    - Fixed image rendering issues for Wikipedia images by injecting proper User-Agent headers.
    - Repopulated local database with 96 default HSK 1-6 stories using the new structural JSON schema.

### Added
- **The Scholar's Eye (Hybrid Vision System)**:
    - Implemented `VisionService` using Google ML Kit for real-time local object detection.
    - Integrated `GeminiService` with Vision capabilities for high-fidelity "Deep Scans".
    - Created `VisionState` and `VisionNotifier` providers to manage camera life-cycle and object detection stream.
    - Added support for translating local ML labels into full `Flashcard` entities via Gemini.
