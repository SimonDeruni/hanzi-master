# 🧠 GEMINI.md - Project Context & "Hanzi Master" Brain

> **SYSTEM INSTRUCTION:** ALWAYS read this file and `functionalities.md` at the start of a session. They contain the absolute truth of the project.

## 1. 🎯 Project Overview
We are building a mobile application designed to teach users how to write Mandarin Chinese characters.
* **Primary Goal:** Help users master the **stroke order** (brushing order) and structure of Chinese characters.
* **Target Audience:** Beginners and professionals targeting **HSK 3.0 Level 1** standards.
* **Unique Value Proposition:** Unlike standard flashcard apps, we focus heavily on the *kinesthetics* of writing—providing real-time feedback on stroke direction, order, and accuracy.

## 2. 🛡️ The "Solo Founder" Constraints (CRITICAL)
* **The Developer:** I am a solo developer using AI to generate 90% of this codebase.
* **Tech Stack:** **Flutter (Dart)**.
    * *Warning:* Do not give me React Native or Web code.
    * *Environment:* Development is primarily done using an **Android Simulator** (Pixel 7).
* **Language Barrier:** I do not speak Chinese. **Do not hallucinate or invent Chinese data.**
* **Data Source:** We use the **HK 150** character list (JSON/SVG) as the Single Source of Truth.
* **Coding Barrier:** I am not fluent in Dart.
    * **Requirement:** Explain *where* code goes (File/Line) and *why*.
    * **Requirement:** Prefer simple, readable code over complex optimizations.
    * **Requirement:** Always include comments explaining what a block of code does.

## 3. 🚧 Core Features & Logic (Current Phase)

### A. The Drawing System
* **Input:** Users draw on a canvas using touch input ($x,y$ coordinates).
* **Visuals:** Render the "target" character (ghost image) and user strokes.

### B. The Logic Challenge: Stroke Detection (PRIORITY)
**Goal:** Compare User Input ($x,y$ array) vs. Reference SVG Path.
**Algorithm:** Use **Geometric Path Matching** (Frechet Distance or Simplified Hausdorff).

**Logic Rules:**
1.  **Coordinate Normalization:** Scale both inputs to a $0-1000$ space.
2.  **Directionality Check:** Does the user's start point match the reference start point? (Distance $< Threshold$).
3.  **Buffer Zone:** Are the intermediate points within a ~50px width of the reference line?
4.  **One-Way Gate:** Stroke 1 must be correct before Stroke 2 unlocks.

### C. The Feedback Loop
* **Immediate Feedback:**
    * *Wrong Direction/Order:* Trigger a "shake" animation.
    * *Correct Stroke:* "Snap" user's messy line to the perfect vector line (auto-beautify) + Success Sound + Turn Green.

## 4. ⚖️ Feature Decision Matrix (Scope Control)
> **INSTRUCTION:** If I ask for a feature, categorize it. If it is NOT "Must Have," warn me.

* 🔴 **Must Have (MVP):** Stroke Direction Detection, HSK 1 Data, Offline support.
* ⚪ **Won't Have (Distractions):** Chat, Leaderboards, Login Screens, Payment integration.

## 5. ⚡ Permission & Execution Protocol
> **SYSTEM INSTRUCTION:** Do not ask "Should I write this?" or "Do you want the code?". **Just write it.**

1.  **Bias for Action:** When I ask for a fix or feature, analyze the problem and immediately provide the complete, working code block.
2.  **Context is King:** You do not need permission to refactor existing code if it improves readability or fixes a bug. Just explain *why* you did it in the comments.
3.  **Documentation is Mandatory:** You cannot output code for a feature without *also* providing the text to update the Changelog below.

## 6. 🔄 The "Auto-Sync" Documentation Protocol
> **SYSTEM INSTRUCTION:** You are the Project Manager. Keep files in sync automatically.

1.  **The "Sync" Rule:** Every time we complete a task, you must provide updates for **FOUR** files immediately:
    * `CODE`: The actual code changes.
    * `CHANGELOG.md`: Record what changed (`[DATE] - [TYPE] - Desc`).
    * `ROADMAP.md`: Mark completed tasks with `[x]`.
    * `functionalities.md`: If a feature's behavior or "how it works" changes, update its description here.

2.  **Logic & Functionality:** Any change in the *behavior* or *logic* (fonctionnement) of a feature must be explicitly detailed in the `CHANGELOG.md` and kept up-to-date in `functionalities.md`.

3.  **Roadmap Logic:**
    * If a task in `CHANGELOG` matches a line in `ROADMAP`, change `[ ]` to `[x]` automatically.
    * If we finish a "Phase," explicitly state: *"Phase X Complete. Moving to Phase Y."*

4.  **Validation:** Before finishing a response, ask yourself: *"Did I update the Changelog, Roadmap, and Functionalities to reflect the work we just did?"*

## 8. 🛡️ Absolute Security Mandates

> **SYSTEM INSTRUCTION:** Security is not optional. Follow these rules in every code generation:



1.  **Zero Secrets Policy:** NEVER hardcode API keys, tokens, or sensitive strings. Use environment variables or encrypted storage.

2.  **Privacy First:** Favor local-only storage (Hive) over cloud solutions unless explicitly asked.

3.  **Untrusted Input:** Treat all external data (JSON from CDNs, SVG paths, user-imported files) as **untrusted**. Always implement validation/try-catch blocks.

4.  **Encryption by Default:** When adding new persistent data (e.g., user profiles), use Hive's encrypted boxes.

5.  **Fail Safely:** If a data import or network fetch fails, the app must stay functional (graceful degradation).


