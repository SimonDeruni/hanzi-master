# Hanzi Master - Known Issues & Feedback

## Resolved
- [x] **Bug**: Haptic feedback and stroke grading bug reported by user.
- [x] **Story Length**: Increased custom story requirement to 8-12 sentences for more substantial reading material.
- [x] Fixed "No stories found" bug when navigating back to the Reading Room.
- [x] Fixed broken Wikipedia image links by adding User-Agent headers.
- [x] **Bug**: Fixed `FormatException: Invalid radix-10 number` crash on Media Search queries due to `youtube_explode_dart` parsing failures on live streams. Gracefully skip problematic videos while showing valid results.
- [x] Fixed Pinyin-only subtitle rendering on videos lacking a Chinese Hanzi track.
- [x] Added localized translation languages to replace subtitle placeholders.
- [x] Implemented seek-on-tap gesture on subtitle blocks.
- [x] Added AI explanation button for specific sentences.
- [x] **Bug**: Fixed total loss of audio output during media playback caused by iframe muting.
- [x] **Bug**: Fixed "0/100" and Tone Graph glitches in Shadowing Studio grading by passing raw byte arrays to pitch extractor and dynamically scaling rendering coordinates.
- [x] **Bug**: Fixed `MediaSearchScreen` empty state crash and video fetch failures. Implemented live API key rotation to intercept 403 quota errors and seamlessly cycle through backup keys before falling back to the local database, guaranteeing live videos fetch successfully.
- [x] **Bug**: Fixed Roleplay Chat Keyboard trapping (added scroll-to-dismiss and tap-to-dismiss).
- [x] **Bug**: Fixed Roleplay Chat "Hide Translation" toggle button (resolved state logic issue).
- [x] **Bug**: Fixed Roleplay Chat Pinyin formatting (converted raw numeric tone output from AI to standard diacritic marks).
- [x] **Bug**: Fixed infinite reconnection loop in Travel Interpreter caused by invalid `realtimeInput` WebSocket payload crashing the server connection.
- [x] **Bug**: Fixed Gemini Live Call severe echo and self-interruption loop by migrating from a software muting hack to OS-level hardware echo cancellation.
- [x] **Bug**: Fixed invisible AI transcript in Live Call by changing API modality to fetch both TEXT and AUDIO.
- [x] **Bug**: Replaced Live Call AI text with `TappableMarkdownHanziText` to allow quicklook dictionary access on spoken words.
- [x] **Bug**: Fixed Dart compilation syntax error (`Target kernel_snapshot_program failed`) causing iOS builds to fail.
- [x] **Bug**: Fixed Shadowing Studio always returning 0/100 for pronunciation grading. Stripped Chinese punctuation from the `ReferenceText` passed to the Azure Speech Pronunciation Assessment API to prevent alignment failures.
- [x] **Bug**: Fixed Gemini Live Call connection crash (WebSocket 1007 Error) by removing `"TEXT"` from the `responseModalities` payload, which is unsupported by the current model version. Improved error UI to catch WebSocket disconnections gracefully.
- [x] **UI/UX**: Added "TRAILER" and "HIGHLIGHT" conditional overlay badges to Media Cards in the Shows & Dramas catalog to distinguish content types.
- [x] **Bug**: Fixed Smart Media Desk data bleed where YouTube API failures caused all video categories to incorrectly display hardcoded historical dramas. Categories will now correctly display a "Failed to load content" state.

## Open Issues

