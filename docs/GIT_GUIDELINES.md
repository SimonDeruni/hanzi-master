# 🌿 Git Guidelines - Hanzi Master

To maintain the **Zen & Ink** aesthetic and support multi-agent coordination, follow these standards for version control.

---

## 🖋️ 1. Commit Message Standard
Commit messages should be concise, professional, and follow the **Conventional Commits** format.

### **Format:**
`<type>: <description>`

### **Types:**
- `feat`: A new feature (e.g., `feat: Add HSK 3 stroke data`)
- `fix`: A bug fix (e.g., `fix: Resolve stroke matcher crash`)
- `refactor`: Code change that neither fixes a bug nor adds a feature
- `chore`: Maintenance tasks (e.g., `chore: Update .gitignore`)
- `docs`: Documentation changes
- `style`: Changes that do not affect the meaning of the code (formatting)

---

## 🔄 2. The Git-Agent Sync Rule
Every AI agent session MUST conclude with a **Baseline Commit**.
1.  **Stage:** `git add .` (Ensuring `.gitignore` is correct)
2.  **Commit:** `git commit -m "chore: [Agent Name] Session Baseline - [Task Summary]"`
3.  **Analyze:** Always run `flutter analyze` before committing.

---

## 🛡️ 3. Branching Strategy
- **`master`**: The stable branch. All "Zen & Ink" approved code lives here.
- **`feat/` / `fix/`**: Use short-lived branches for complex features or audits.

---

## 🧹 4. Hygiene
- Never commit large binaries (`.pdf`, `.zip`) unless they are part of the core assets.
- Use `git status` frequently to ensure no "junk" is being staged.
- Ensure the Problems tab in VS Code is empty before committing.
