# 🚑 Crash Recovery & Stale Lock Standard

This standard defines how to handle sessions that were interrupted by an AI crash or context loss.

---

## 🕵️ 1. Detecting a Crash
During Onboarding (Step 1), if you see `[🔒 LOCKED]` claims in `SESSION_STATE.md` but no active agent is responding, check the **Timestamp**.
- **Stale Criteria:** If the lock is > 2 hours old or from a previous calendar day, it is considered a **Stale Lock**.

## 🛠️ 2. The Recovery Procedure
If a Stale Lock is detected, you MUST perform these steps before starting your own task:
1.  **Inspect:** Open the locked files and compare them to the last entry in `docs/CHANGELOG.md`.
2.  **Analyze:** Determine if the previous agent's work is:
    - **Finished but not unlocked:** (Sync docs and unlock).
    - **Half-finished:** (Finish the logic OR revert to a stable state).
    - **Broken:** (Fix the linter errors or revert).
3.  **Force Unlock:** Remove the stale lock.
4.  **Log:** Add a `[🚑 RECOVERY]` entry to the `CHANGELOG.md` explaining what you cleaned up.

## 🍞 3. The Breadcrumb Rule (Prevention)
To minimize data loss from future crashes:
- **Sync Early:** Update `SESSION_STATE.md` and `docs/CHANGELOG.md` immediately after any tool call that modifies a file. 
- **Do not wait for the end of the session.**
