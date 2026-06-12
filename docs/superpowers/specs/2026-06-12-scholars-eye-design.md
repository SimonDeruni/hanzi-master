# 👁️ Spec: The Scholar's Eye (Hybrid Vision System)

## 🎯 Purpose
Extend the app's OCR capabilities to recognize real-world objects using a hybrid ML approach. This feature helps students connect their Chinese vocabulary to the physical world around them.

## 🎨 Visual Mandate (Zen & Ink)
- **Overlay:** A subtle "Rice Paper" texture over the camera feed.
- **Labels:** Carbon Ink text (`#1A1A1B`) on Xuan Paper backgrounds (`#FDFCF0`) with delicate borders.
- **Button:** A "Calligraphy Brush" (`🖌️`) FAB for deep scans.

## 🏗️ Architecture

### 1. Vision UI (`lib/features/vision`)
- `VisionScreen`: The main camera interface.
- `ObjectRadar`: An overlay widget that draws bounding boxes and labels for real-time detections.
- `DeepScanButton`: Triggers the high-fidelity Gemini Vision analysis.

### 2. ML Pipeline (`lib/core/services/vision_service.dart`)
- **Local Mode (ML Kit):**
    - Uses `google_mlkit_object_detection`.
    - High-frequency processing for 30+ FPS "Radar" effect.
    - Recognizes standard categories (cup, book, chair, etc.).
- **Deep Mode (Gemini 2.5 Flash Vision):**
    - Triggered by user tap (Brush button).
    - Sends high-res frame to Gemini API.
    - Handles complex scenes, rare objects, and multi-object analysis.

### 🔄 Data Flow
1. **Detection:** Frame -> `VisionService` -> List of English labels + bounding boxes.
2. **Translation:** 
    - `Label (English)` -> `FlashcardController` lookup -> `Flashcard (Hanzi)`.
    - **Fallback:** If not found in deck, `GeminiService.translateObject(label)` generates a temporary `Flashcard` model.
3. **Display:** Tapping a label or finishing a Deep Scan triggers `showQuickLook(context, hanzi)`.

## 🎮 Gamification
- **Scholar's Collection:** Successfully scanning an object for the first time grants **+5 Ink Points**.
- **Discovery Link:** A new "Open Eye" button in the `CourseScreen` header.

## 🧪 Success Criteria
- [ ] Stable camera feed with < 50ms latency for local labels.
- [ ] Successful fallback to Gemini for objects not in the HSK 1/2 list.
- [ ] Consistent "Zen & Ink" aesthetic across all vision overlays.
- [ ] Proper disposal of camera and ML resources to prevent memory leaks.

## 🛠️ Tech Stack
- `camera`: For live feed and frame capture.
- `google_mlkit_object_detection`: For local real-time labeling.
- `google_generative_ai`: For Deep Scan analysis.
- `QuickLookSheet`: Reused for result display.
