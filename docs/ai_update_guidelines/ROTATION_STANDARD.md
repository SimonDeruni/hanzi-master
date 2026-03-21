# 📦 Rotation & Archiving Standard

To prevent context bloat, documentation must be rotated according to these rules.

---

## 📅 1. Changelog Rotation
- **Limit:** If `docs/CHANGELOG.md` exceeds **300 lines**.
- **Action:** Move entries older than 6 months to `docs/archive/CHANGELOG_[YEAR].md`.
- **Note:** Always keep at least the last 5 entries in the main file.

## 🐛 2. Issue Pruning
- **Limit:** If `docs/ISSUES.md` has more than **20 ✅ FIXED** rows.
- **Action:** Move the oldest fixed rows to `docs/archive/RESOLVED_ISSUES_VOL_[X].md`.
- **Note:** Only "Active" (🔴) and "Recently Fixed" (last 14 days) issues should stay in the main table.

## 🕵️ 3. Audit Result Flattening
- **Limit:** If any status folder (`pass/`, `failed/`, `average/`) exceeds **15 files**.
- **Action:** 
    1. Create a `SUMMARY_AUDIT_[PHASE_X].md` in the folder.
    2. Move the individual audit files to `audit/audit_results/archive/`.
- **Note:** The `audit_changelog.md` MUST remain as the permanent ledger of all history.

## 🏗️ 4. Tooling & Script Archiving
- **Action:** If a script in `tooling/` is a "one-off" (e.g., a specific migration), move it to `tooling/archive/` after use.
