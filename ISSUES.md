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

## Open Issues

