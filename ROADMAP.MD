# 🗺️ Project Roadmap: Hanzi Master

## Phase 1: The Core Engine (✅ COMPLETE)
- [x] **Basic Canvas:** Set up Flutter CustomPainter for touch input.
- [x] **Stroke Validation:** Implement `StrokeGrader` logic (Coordinate comparison).
- [x] **Visual Feedback:** Turn stroke Green (Correct) or Red (Wrong).
- [x] **Error Animation:** Add "Shake" effect on bad strokes.
- [x] **Ghost Overlay:** Show the "Blue Guide Stroke" (reference path).
- [x] **Snap-to-Grid:** Auto-correct the user's line to the perfect vector on success.

## Phase 2: Data & Persistence (✅ COMPLETE)
- [x] **Data Import:** Real HK 150 character list JSON integration.
- [x] **Parser Logic:** `CharacterLoader` for SVG paths to Flutter Paths.
- [x] **Local Storage:** SM-2 SRS Algorithm with `SharedPreferences`.
- [x] **Progress Tracking:** Persistence for scores, attempts, and mastery levels.

## Phase 3: Aesthetic & Polish (🚧 IN PROGRESS)
- [x] **Calligraphy Aesthetics:** Xuan Paper texture and Rice Grid lines.
- [x] **Advanced Smoothing:** Weighted 5-point moving average interpolation.
- [x] **Brush Simulation:** Velocity-based variable thickness and tapering.
- [x] **Comparison View:** Side-by-side results with synchronized character cycling.
- [ ] **Dynamic Audio:**
    * [ ] **Auto-Pronounce:** Trigger TTS immediately upon correct character completion.
    * [ ] **Sound FX:** Add a subtle "paper scratching" sound during active drawing.
- [ ] **Haptic Immersion:** Refine vibrations to feel like a brush hitting paper.

## Phase 4: Beyond the Stroke (🚧 PLANNED)
- [ ] **Vocabulary Builder:**
    * [ ] **Word Mastery:** Learn multi-character words (e.g., 朋友, 谢谢) as cohesive units.
    * [ ] **Example Sentences:** Interactive cards showing characters in real HSK 1 context.
- [ ] **Linguistic Deep-Dive:**
    * [ ] **Radical Explorer:** Tap characters to see component radicals and meanings.
    * [ ] **Etymology Snippets:** Brief pictograph origin stories to aid memory.
- [ ] **Tone Master:** Exercises for Pinyin tone visualization and recognition.

## Phase 5: Gamification & "The Experience" (🚧 PLANNED)
- [ ] **XP & Leveling System:**
    * [ ] Earn "Ink Points" (XP) and level up your "Calligraphy Rank" (Novice to Grandmaster).
- [ ] **Daily Quests:** "Master 5 new characters" or "Maintain a 90% accuracy streak."
- [ ] **Mastery Rings:** Add circular progress indicators around cards in the library.
- [ ] **Reward Shop:** Unlock "Antique Paper Skins," "Imperial Ink," and "Custom Brushes."
- [ ] **Celebration FX:** Golden sparkles/confetti for 100% "Perfect" characters.

## Phase 6: Multi-Modal Learning (🚧 PLANNED)
- [ ] **Recognition Mode:** Match Hanzi to Pinyin/English in multiple-choice grids.
- [ ] **Listening Mode:** Hear a word and select the correct character from a grid.
- [ ] **Flashcard Mode:** Rapid-fire recognition testing without writing.
- [ ] **"Show Me" Hint System:** Animated "perfect" drawing of the current stroke.

## Phase 7: The "Hanzi Ecosystem" (🚧 PLANNED)
- [ ] **Social Leagues:** Weekly "Scholar's Pavilion" leaderboards.
- [ ] **Friend Challenges:** Send characters to friends to beat your accuracy score.
- [ ] **Cloud Sync:** Cross-device backup via Supabase/Firebase.

## Phase 8: Security & Data Integrity (🚧 PLANNED)
- [ ] **Database Encryption:** Implement Hive AES-256 encryption for all local learning data.
- [ ] **Local Backups:** Create a JSON Export/Import system for user progress and custom cards.
- [ ] **Asset Validation:** Implement checksums/validation for the HSK 1 local data assets to prevent corruption.
- [ ] **Secure Parsing:** Harden the SVG/JSON parsers against malicious payloads (ReDoS protection).
- [ ] **Privacy Audit:** Ensure zero data leakage to external services beyond essential stroke fetching.

## Phase 8: UI/UX & Technical Excellence (🚧 PLANNED)
- [ ] **RepaintBoundary Isolation:** Wrap the drawing canvas to prevent full-screen repaints during active drawing.
- [ ] **Background Isolates:** Move mathematical stroke grading (StrokeGrader) to a background thread to prevent UI jank.
- [ ] **Path Caching:** Implement a caching layer in `CharacterLoader` to avoid redundant SVG-to-Path parsing.
- [ ] **Material 3 Migration:** Adopt dynamic colors and modern M3 typography.
- [ ] **Dark Mode:** Implement a "Midnight Ink" theme.
- [ ] **Transitions:** "Hero" animations from library to drawing canvas.
- [ ] **Security:** Encrypted local data and JSON progress Export/Import.

## Phase 9: Brainstorming & R&D (♾️ CONTINUOUS)

- [ ] **AI Style Analysis:** Analyze the "soul" and balance of user handwriting.

- [ ] **AR Mode:** Draw characters in 3D space using the camera.

- [ ] **Dynamic Difficulty:** Adjust grading strictness based on user skill level.



## Phase 10: Production & Store Launch (🚀 FINAL)



- [ ] **Legal:** Draft and host a Privacy Policy and Terms of Service.



- [ ] **Cloud CI/CD:** Set up **Codemagic** or GitHub Actions to build iOS versions without a Mac.



- [ ] **TestFlight:** Distribute the iOS beta to your iPhone via Apple TestFlight.



- [ ] **Android Production:** Set up ProGuard/R8 and generate signed `.aab` for Play Store.



- [ ] **Metadata:** Create high-quality App Store screenshots and promotional videos.



- [ ] **Apple Production:** Configure App Store Connect and distribution certificates.




