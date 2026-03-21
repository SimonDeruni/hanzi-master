# 🕵️ Audit Guidelines Update Standard

The `audit/AUDIT_GUIDELINES.md` defines the **HOW**. It must be updated whenever a new technical domain is added to the project.

## 📅 When to Update
- **New Technical Domain:** If we add OCR, Audio Processing, or complex animations that require manual/automated testing steps.

## 📝 Entry Template
```markdown
## [ID]. [Audit Title] Procedure
**Objective:** [What specific failure are we preventing?]

### Step-by-Step Procedure:
1.  **[Step 1]**: [Specific command or file read]
2.  **[Step 2]**: [Specific logic check/verification]
3.  **[Step 3]**: [Conflict check]
```

## ⚖️ Quality Rule
- Steps MUST be executable by an AI agent (use `grep_search`, `flutter analyze`, or specific file paths).
