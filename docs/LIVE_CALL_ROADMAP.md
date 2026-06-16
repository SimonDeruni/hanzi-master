# 📞 Live Call Roadmap - Hanzi Master

This document outlines the strategic progression for the **Immersive Live Call** feature, transforming it from a UI shell into a world-class AI conversation partner.

---

## 🎯 Phase 1: Real-Time Transcription & Connection Stability (Current)
*   **Objective:** Give the user a visual anchor by displaying a live transcript of both the AI and User. Resolve connection drop issues.
*   **Tech:** Enable `input_audio_transcription` and `output_audio_transcription` in the Gemini Live WebSocket protocol.
*   **UI:** Implement an elegant, semi-transparent scrolling overlay for the text bubbles.

## 🧠 Phase 2: Asynchronous Real-Time Grading
*   **Objective:** Provide syllable-level color-coded feedback during the call without increasing latency.
*   **Tech:** 
    *   Buffer user audio locally in 16kHz PCM chunks.
    *   On "Turn Complete" (VAD), dispatch the audio segment to a secondary `gradeAudio` AI task.
*   **UI:** Transition user text from "Active/Gray" to "Graded" (Green/Yellow/Red) within 1.5s of speaking.

## 📝 Phase 3: Post-Call Summary & Verdict
*   **Objective:** Give the user a tangible report card and linguistic goal-setting after the conversation.
*   **Tech:** Aggregate all session data and use Gemini to perform a **Linguistic Pattern Analysis**.
*   **UI:** Launch a `PostCallSummarySheet` upon "End Call" showing:
    *   Top 3 phonological struggles (e.g., "3rd tone sandhi errors").
    *   Full scrollable, interactive graded transcript.
    *   "Scholar's Verdict" - personalized coaching tips.

## 🚀 Phase 4: Low-Latency Optimization
*   **Objective:** Perfect the "Interruptible" (Full-Duplex) experience.
*   **Tech:** Optimize Voice Activity Detection (VAD) thresholds and implement a local Audio-Queue manager to prevent "jitter" or gaps in AI speech playback.

---
*Created: June 15, 2026*
