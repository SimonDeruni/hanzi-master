# 🤝 Multi-Agent Coordination Standard

This standard ensures that multiple AI agents can work on Hanzi Master without colliding or overwriting each other's work.

---

## 🔒 1. The "Claim" System (Locking)
Before modifying any code, you MUST check the **"Active Claims"** section in `SESSION_STATE.md`.

- **To Lock:** Add your name and the file/feature path to the claims list.
  *Example: `[🔒 LOCKED] StrokeMatcher.dart - Agent: Gemini-1.5-Pro`*
- **To Unlock:** Remove the entry once your task is 100% finished and synced.

## 🧱 2. Atomic Scoping
- **Independent Folders:** Favor working in independent feature folders (e.g., `lib/features/quiz/`) to avoid colliding with an agent working on `lib/features/course/`.
- **Global File Warning:** If you must edit `main.dart`, `pubspec.yaml`, or `GEMINI.md`, keep your changes as small as possible and release the lock immediately.

## 🔄 3. Heartbeat Sync
- **The rule:** AI agents MUST re-read `SESSION_STATE.md` immediately before executing any `write_file` or `replace` command if the session has lasted more than 5 turns. This ensures they see any new locks added by parallel agents.

## 🚑 4. Deadlock Prevention
- If an agent is "stuck" because of a stale lock (>2 hours old), they MUST ask the user for permission to "Force Unlock" the file.
- Once permitted, follow the `RECOVERY_STANDARD.md` to ensure the half-finished code is stabilized.

## 🛑 5. Collision Resolution
- If you find a file you need is 🔒 LOCKED, do not proceed. Inform the user and ask for a different task or wait for the lock to be released.
