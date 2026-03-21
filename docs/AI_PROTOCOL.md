# 🤖 Hanzi Master - AI Technical Protocol

This document defines the strict operational rules for AI agents, specifically **when** and **how** to update project management files using modular standards.

---

## 🏁 1. The "Definition of Done" (DoD)
A task is NOT complete until:
1.  **Code Quality:** Simple, readable, and teachable logic.
2.  **Logic & Comment Sync:** Every code change MUST include updated comments. Remove all dead code.
3.  **Total Hygiene:** `flutter analyze` must return 0 issues (including Warnings and Info/Hints). No exceptions.
4.  **Verification:** Logic verified via `flutter test` or manual simulation.

5.  **Active Remediation:** If auditing, you MUST attempt to fix the issues found and re-audit before generating the final report.
6.  **The Lean Sync:** All mandatory AND triggered files in the Matrix (Section 2) are updated **at the end of an objective**, not every turn.
7.  **📜 Self-Audit:** Perform a final sync audit against `docs/ai_update_guidelines/` before handover.
8.  **🏁 Session Seal:** Create a conclusion entry in `CHANGELOG.md` upon objective completion.
9.  **Baton Handover:** The `SESSION_STATE.md` is updated and locks are released.

---

## 🔄 2. Documentation Lifecycle Matrix

| File | Update Trigger | GUIDELINE Standard |
| :--- | :--- | :--- |
| **`docs/CHANGELOG.md`** | **Objective End** (Batch updates) | `CHANGELOG_STANDARD.md` |
| **`docs/ISSUES.md`** | **Objective End** (If bugs found/fixed) | `ISSUES_STANDARD.md` |
| **`SESSION_STATE.md`** | **Mandatory** (End of every session) | `SESSION_STATE_STANDARD.md` |
| **`docs/ROADMAP.MD`** | If a sub-task or Phase is finished. | `ROADMAP_STANDARD.md` |
| **`docs/FEATURE_MANIFEST.md`** | If a feature's behavior changes. | `FEATURE_MANIFEST_STANDARD.md` |
| **`audit/AUDIT_PLAN.md`** | If new scope/logic is added. | `AUDIT_PLAN_STANDARD.md` |
| **`docs/PROJECT_MAP.md`** | If folders or data flow changes. | `PROJECT_MAP_STANDARD.md` |
| **`docs/ARCHITECTURAL_DECISIONS.md`**| If tech stack or core algorithms change. | `ADR_STANDARD.md` |
| **`docs/ANTI_PATTERNS.md`** | If a rejected approach is identified. | `ANTI_PATTERNS_STANDARD.md` |
| **`docs/UI_UX_STANDARDS.md`** | If design system or branding changes. | `UI_UX_STANDARDS_STANDARD.md` |
| **`docs/COMMANDS_CHEATSHEET.md`** | If new tooling or build steps are added. | `COMMANDS_STANDARD.md` |

---

## ⚠️ 3. Technical "Gotchas" (The "Don't Forget" List)
*   **Build Runner:** Run `flutter pub run build_runner build --delete-conflicting-outputs` after model changes.
*   **Coordinate Trap:** All points are **1000x1000**. Use `CharacterLoader.transformPoint`.
*   **Write-Lock:** Never modify `assets/data/*.json` manually. Fix the `tooling/` script.

---

## 🛡️ 4. AI Guardrails & Context Efficiency
*   **No `ls -R`:** Use `grep_search` or `glob` instead.
*   **Search First:** Map dependencies before writing a plan.
*   **Linter Hygiene:** Clean Problems tab is mandatory. Every session must end with `flutter analyze`.
# 🤖 Hanzi Master - AI Technical Protocol

This document defines the strict operational rules for AI agents, specifically **when** and **how** to update project management files using modular standards.

---

## 🏁 1. The "Definition of Done" (DoD)
A task is NOT complete until:
1.  **Code Quality:** Simple, readable, and teachable logic.
2.  **Logic & Comment Sync:** Every code change MUST include updated comments. Remove all dead code.
3.  **Total Hygiene:** `flutter analyze` must return 0 issues (including Warnings and Info/Hints). No exceptions.
4.  **Verification:** Logic verified via `flutter test` or manual simulation.

5.  **Active Remediation:** If auditing, you MUST attempt to fix the issues found and re-audit before generating the final report.
6.  **The Lean Sync:** All mandatory AND triggered files in the Matrix (Section 2) are updated **at the end of an objective**, not every turn.
7.  **📜 Self-Audit:** Perform a final sync audit against `docs/ai_update_guidelines/` before handover.
8.  **🏁 Session Seal:** Create a conclusion entry in `CHANGELOG.md` upon objective completion.
9.  **Baton Handover:** The `SESSION_STATE.md` is updated and locks are released.

---

## 🔄 2. Documentation Lifecycle Matrix

| File | Update Trigger | GUIDELINE Standard |
| :--- | :--- | :--- |
| **`docs/CHANGELOG.md`** | **Objective End** (Batch updates) | `CHANGELOG_STANDARD.md` |
| **`docs/ISSUES.md`** | **Objective End** (If bugs found/fixed) | `ISSUES_STANDARD.md` |
| **`SESSION_STATE.md`** | **Mandatory** (End of every session) | `SESSION_STATE_STANDARD.md` |
| **`docs/ROADMAP.MD`** | If a sub-task or Phase is finished. | `ROADMAP_STANDARD.md` |
| **`docs/FEATURE_MANIFEST.md`** | If a feature's behavior changes. | `FEATURE_MANIFEST_STANDARD.md` |
| **`audit/AUDIT_PLAN.md`** | If new scope/logic is added. | `AUDIT_PLAN_STANDARD.md` |
| **`docs/PROJECT_MAP.md`** | If folders or data flow changes. | `PROJECT_MAP_STANDARD.md` |
| **`docs/ARCHITECTURAL_DECISIONS.md`**| If tech stack or core algorithms change. | `ADR_STANDARD.md` |
| **`docs/ANTI_PATTERNS.md`** | If a rejected approach is identified. | `ANTI_PATTERNS_STANDARD.md` |
| **`docs/UI_UX_STANDARDS.md`** | If design system or branding changes. | `UI_UX_STANDARDS_STANDARD.md` |
| **`docs/COMMANDS_CHEATSHEET.md`** | If new tooling or build steps are added. | `COMMANDS_STANDARD.md` |

---

## ⚠️ 3. Technical "Gotchas" (The "Don't Forget" List)
*   **Build Runner:** Run `flutter pub run build_runner build --delete-conflicting-outputs` after model changes.
*   **Coordinate Trap:** All points are **1000x1000**. Use `CharacterLoader.transformPoint`.
*   **Write-Lock:** Never modify `assets/data/*.json` manually. Fix the `tooling/` script.

---

## 🛡️ 4. AI Guardrails & Context Efficiency
*   **No `ls -R`:** Use `grep_search` or `glob` instead.
*   **Search First:** Map dependencies before writing a plan.
*   **Linter Hygiene:** Clean Problems tab is mandatory. Every session must end with `flutter analyze`.
*   **Git Sync:** Perform a baseline commit at the end of every session. Use `chore: [Agent Name] Session Baseline` format.
*   **Rotation & Pruning:** You are responsible for keeping the project lean. Follow `docs/ai_update_guidelines/ROTATION_STANDARD.md` if any management file exceeds its size limit.
*   **Multi-Agent Coordination:** If multiple agents are active, you MUST follow `docs/ai_update_guidelines/COORDINATION_STANDARD.md`. Claim your files in `SESSION_STATE.md` before coding.

---

## 🤝 5. Surgical Sync Rule
When updating any document, you MUST:
1.  Identify the target section.
2.  Match the **exact indentation** and **line-spacing** of the existing document.

---

## 🧪 6. Hygienic Documentation Standard
To save tokens and keep the context window focused:
1.  **Surgical Bullet Points:** Limit changelog and status items to max 15 words.
2.  **Episodic Status:** Only describe the *current* objective in `SESSION_STATE.md`. Move older milestone summaries to the archive.
3.  **No Redundancy:** If a change is described in the code comments, keep the changelog entry high-level.
4.  **Implicit Context:** Avoid repeating folder structures or architectural rules if they haven't changed.
