# 📑 Audit Plan Update Standard

The `audit/AUDIT_PLAN.md` is a living document. It must be updated whenever the project's technical scope expands.

## 📅 When to Update
- **New Feature:** If a feature is added to `docs/FEATURE_MANIFEST.md`.
- **New Architecture:** If a new library or design pattern is introduced.
- **HSK Scaling:** When moving to a new HSK level.

## 📝 Entry Template
New audits must follow this format in the plan:
```markdown
## [ID]. [Title] Audit
**Goal:** [What are we preventing?]
- **Check 1:** [Specific technical verification]
- **Check 2:** [Edge case check]
- **Dependency:** [Link to related code/docs]
```

## 🚀 Roadmap Sync
- When adding a new audit to the plan, ensure a corresponding "Phase" exists in the `ROADMAP.MD` to execute it.
