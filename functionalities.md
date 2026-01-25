# 🚀 Hanzi Master - Current Functionalities

## 🎨 Drawing & Writing System
- **Interactive Canvas:** High-performance drawing surface using Flutter's `CustomPainter` and `Path` rendering.
- **Two Learning Modes:**
    - **Guided Mode:** Stroke-by-stroke guidance with a blue ghost image and start/end indicators.
    - **Free Mode:** Open drawing for testing recall without visual aids.
- **Traditional Aesthetics:**
    - **Xuan Paper Texture:** Authentic rice paper background.
    - **Rice Grid (米字格):** Traditional red-ink guidelines for character structure.
    - **Ink Bloom Effect:** Subtle visual refinement when strokes are completed.
- **Line Smoothing:** Real-time weighted 5-point interpolation and "Tail Smoothing" for a professional calligraphy feel.
- **Brush Simulation:** Velocity-based variable stroke thickness (thin for fast flicks, thick for slow presses) and subtle tapering at the start and end of strokes.
- **Auto-Snap:** Successful strokes "snap" to the perfect vector representation for visual reinforcement.

## 🚀 Planned & Future Functionalities

### 🕹️ Gamification (The Experience)
- **XP System (Ink Points):** Reward progression with levels and titles.
- **Daily Streaks:** Visual motivation for consistent practice.
- **Unlockable Aesthetics:** Custom brush styles, paper textures, and ink colors.
- **Celebration Particle Effects:** Visual rewards for high-accuracy writing.

## 🚀 Planned & Future Functionalities

### 🕹️ Gamification (The Experience)
- **XP System (Ink Points):** Reward progression with levels and titles.
- **Mastery Rings:** Visual progress indicators in the character library.
- **Daily Quests:** Task-based rewards for consistency.
- **Reward Shop:** Unlockable brush styles, paper textures, and ink colors.
- **Celebration FX:** Particle effects for perfect characters.

### 🎓 Educational Ecosystem
- **Vocabulary Builder:** Multi-character words and example sentence integration.
- **Radical Explorer:** Deep-dive into character components and etymology.
- **Multi-Modal Learning:** Recognition (Multiple Choice) and Listening challenges.
- **Tone Mastery:** Dedicated focus on Pinyin tones.
- **Animated Hints:** Interactive "Show Me" brush animations.

### 🌐 Social & Scalability
- **The Scholar's Pavilion:** Weekly social leagues and leaderboards.
- **Cloud Sync:** Cross-platform progress backup and friend challenges.
- **Full HSK 1.0 Support:** Scaling data from Level 1 up to Level 6.

### 🛠️ Technical & Security
- **Cloud Build Support:** (Planned) Integration with CI/CD for automated iOS/Android store deployments.
- **Local-First Privacy:** 100% offline-capable storage for all personal learning progress.
- **Path Caching:** (Planned) Instant re-rendering of known characters via cached vector paths.
- **Background Isolates:** (Planned) Mathematical grading offloaded to secondary threads for 60+ FPS stability.
- **RepaintBoundary Optimization:** (Planned) Isolated rendering layers for maximum battery efficiency and smoothness.

### 🌐 Social & Scalability
- **Competitive Leagues:** Weekly rankings based on study performance.
- **Cloud Sync:** Cross-platform progress backup.
- **Multi-Level Support:** Complete HSK 1.0 (Level 1-6) data.

## 🧠 Intelligence & Feedback
- **Geometric Stroke Grading:** Mathematical comparison between user input and reference SVG paths using distance-based algorithms.
- **Immediate Feedback:**
    - **Visual:** Strokes turn Green (success) or Red (failure).
    - **Animation:** "Shake" effect on incorrect strokes.
    - **Haptics:** Vibration feedback for both success and error states.
- **Advanced Results Page:**
    - **Side-by-Side Comparison:** View "Your Work" directly next to the "Ideal Solution."
    - **Synced Previews:** Multi-character words cycle through characters in both views simultaneously.
    - **Calligraphy Scoring:** Grading based on linguistic calligraphy standards (Start/End points and direction).

## 📚 Data & Learning
- **HSK 3.0 Level 1 Data:** Full support for the initial 150 characters/words.
- **Multi-Character Support:** Intelligent handling of words with multiple characters, providing full-sized canvases for each.
- **SRS (Spaced Repetition System):** Integrated SM-2 algorithm to optimize review intervals based on performance.
- **Audio Support:** Text-to-Speech (TTS) integration for listening to correct Mandarin pronunciation.

## 📈 Tracking & Persistence
- **Performance History:** Tracks attempts, average scores, and success rates for every character.
- **Daily Streaks:** Built-in motivation system tracking consecutive days of practice.
- **Local Storage:** All progress is saved locally using `SharedPreferences` for offline support.

## 📱 App Essentials
- **Onboarding:** Tutorial flow for new users explaining how to use the drawing and feedback systems.
- **Native Integration:** Custom adaptive icons for Android/iOS and a dedicated splash screen.
- **Responsive UI:** Dynamic centering and scaling to ensure the canvas looks perfect on all device sizes.
