# The Scholar's Eye Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implement a hybrid vision system that uses real-time local ML for object radar and Gemini Pro Vision for high-fidelity "Deep Scans", connecting physical objects to Chinese flashcards.

**Architecture:** A unified `VisionService` manages both `google_mlkit_object_detection` (30fps radar) and `google_generative_ai` (Deep Scan). The UI uses a custom `ObjectRadarOverlay` to draw Zen-style labels over the camera feed, with a "Brush" FAB for deep analysis.

**Tech Stack:** `camera`, `google_mlkit_object_detection`, `google_generative_ai`, `riverpod`, `QuickLookSheet`.

---

### Task 1: Environment & Dependencies

**Files:**
- Modify: `pubspec.yaml`
- Modify: `android/app/build.gradle.kts`

- [ ] **Step 1: Add required dependencies to `pubspec.yaml`**
Add `camera`, `google_mlkit_object_detection`, and `google_mlkit_commons` to the dependencies section.
- [ ] **Step 2: Run `flutter pub get`**
- [ ] **Step 3: Update Android dependencies in `build.gradle.kts`**
Add `implementation("com.google.mlkit:object-detection:17.0.2")` to the dependencies block.
- [ ] **Step 4: Commit**
```bash
git add pubspec.yaml android/app/build.gradle.kts
git commit -m "chore: add camera and ml-kit dependencies"
```

---

### Task 2: Gemini Service - Vision & Translation Fallback

**Files:**
- Modify: `lib/core/services/gemini_service.dart`

- [ ] **Step 1: Add `analyzeImage` method**
Implement a method that takes a byte array (image) and uses Gemini 2.5 Flash to identify objects and provide Chinese metadata.
```dart
Future<GeminiContext> analyzeImage(List<int> bytes) async {
  final prompt = 'Identify the main objects in this image. For each, provide mnemonic, sentences, and lookalikes in the standard JSON format.';
  final content = [Content.multi([TextPart(prompt), DataPart('image/jpeg', Uint8List.fromList(bytes))])];
  final response = await _model.generateContent(content);
  // ... parse JSON as GeminiContext
}
```
- [ ] **Step 2: Add `translateObject` method**
A quick helper to translate a local ML label (e.g., "Cup") into a `Flashcard` model if it's not in the deck.
- [ ] **Step 3: Commit**
```bash
git commit -am "feat: add vision analysis to GeminiService"
```

---

### Task 3: Vision Service - The Hybrid Core

**Files:**
- Create: `lib/core/services/vision_service.dart`

- [ ] **Step 1: Initialize Object Detector**
Setup `ObjectDetector` with `ObjectDetectorOptions` (mode: stream, multiple objects: true).
- [ ] **Step 2: Implement `processImage`**
Convert `InputImage` from the camera stream and return detected objects with English labels.
- [ ] **Step 3: Commit**
```bash
git add lib/core/services/vision_service.dart
git commit -m "feat: implement local VisionService with ML Kit"
```

---

### Task 4: Vision State Management

**Files:**
- Create: `lib/features/vision/presentation/providers/vision_provider.dart`

- [ ] **Step 1: Define `VisionState`**
Include `detectedObjects`, `isDeepScanning`, and `cameraController` status.
- [ ] **Step 2: Create `VisionNotifier`**
Manage the camera stream, feeding frames to `VisionService` and updating the state.
- [ ] **Step 3: Commit**
```bash
git add lib/features/vision/presentation/providers/vision_provider.dart
git commit -m "feat: add VisionState provider"
```

---

### Task 5: Vision Screen & UI Overlays

**Files:**
- Create: `lib/features/vision/presentation/screens/vision_screen.dart`
- Create: `lib/features/vision/presentation/widgets/object_radar_overlay.dart`

- [ ] **Step 1: Build `VisionScreen`**
Implement the `CameraPreview` with a "Rice Paper" texture overlay.
- [ ] **Step 2: Build `ObjectRadarOverlay`**
Draw floating labels using `CustomPainter` or positioned widgets. Use Xuan Paper (`#FDFCF0`) and Carbon Ink (`#1A1A1B`).
- [ ] **Step 3: Implement Deep Scan "Brush" FAB**
Animate the brush icon and trigger the `GeminiService.analyzeImage` call.
- [ ] **Step 4: Commit**
```bash
git add lib/features/vision/presentation/screens/vision_screen.dart lib/features/vision/presentation/widgets/object_radar_overlay.dart
git commit -m "ui: implement VisionScreen and Zen-style Radar overlay"
```

---

### Task 6: Integration & Collection

**Files:**
- Modify: `lib/features/vision/presentation/screens/vision_screen.dart`
- Modify: `lib/features/course/presentation/screens/course_screen.dart`

- [ ] **Step 1: Hook up `showQuickLook`**
Tapping a label in the vision screen should open the `QuickLookSheet`.
- [ ] **Step 2: Implement "Scholar's Collection" bonus**
Add +5 Ink Points to `ProgressionNotifier` when a new object is successfully "captured".
- [ ] **Step 3: Add "The Scholar's Eye" entry to `CourseScreen`**
Add an "Open Eye" icon in the header or map to launch `VisionScreen`.
- [ ] **Step 4: Commit**
```bash
git commit -am "feat: integrate Vision with Discovery and Ink Points"
```

---

### Task 7: Final Hygiene & Verification

- [ ] **Step 1: Run `flutter analyze`**
Ensure 0 issues.
- [ ] **Step 2: Manual Simulation**
Verify camera lifecycle (start/stop) and resource disposal.
- [ ] **Step 3: Update `SESSION_STATE.md` and `CHANGELOG.md`**
- [ ] **Step 4: Commit**
```bash
git commit -am "chore: finalize The Scholar's Eye and update docs"
```
