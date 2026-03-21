# 🤝 Session State (Baton) Standard

The `SESSION_STATE.md` is the most critical file for agent-to-agent communication. It MUST be updated at the end of every session.

## 📝 Template (Mandatory)
```markdown
### 🤝 SESSION STATE
**Last Updated:** [YYYY-MM-DD]
**Agent:** [Your Name / Identity]

#### 📍 Current Status
[High-level summary]
**Hygiene Status:** [🟢 Total Hygiene (0 Issues) / 🟡 Issues Pending]

#### 🔐 Active Claims (Locks)
- [List any files/features currently being worked on by ANY agent]
- *Format: [🔒 LOCKED] [FilePath] - [Agent Name] - [YYYY-MM-DD HH:MM]*

#### 🎯 Active Objectives
- [Immediate task for the next agent]
- [Secondary goal]

#### ⚠️ Warnings & Blockers
- [Critical technical warnings, e.g., "Don't run script X yet"]
- [Missing data or API keys]

#### ⏭️ Next Step for Agent
[A single, clear instruction for the next agent's first move]
```
