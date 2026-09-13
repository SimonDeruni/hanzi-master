# Hanzi Master · Desktop Web Audiobook Player (桌面听书)

A lightweight, dedicated desktop web player for Hanzi Master books, designed with authentic **Zen & Ink** aesthetics, live Azure Speech character-by-character recitation highlighting, ruby pinyin, floating dictionary popover, and desktop keyboard shortcuts.

---

## 🚀 How to Run

### Option 1: 1-Click Windows Launcher (Recommended)
Simply double-click the `start_audiobook.bat` file in the project root.
This starts the local web server and automatically opens `http://127.0.0.1:8088/web_audiobook/` in your default browser.

### Option 2: Python Command Line
From the terminal, run:
```bash
python web_audiobook/serve.py
```
This serves the complete Grand Library catalog (86 books) and the 4,994-word dictionary from `assets/data/`.

### Option 3: Offline / Standalone
Open `web_audiobook/index.html` directly in any modern browser (Chrome, Edge, Firefox, Safari).
* Pre-bundled with *Thirty-Six Stratagems* (三十六计) and *The Little Prince* (小王子).
* Supports drag-and-drop of any custom `.json` book file.

---

## 🎨 Key Features

* **Zen & Ink Aesthetics**: Warm Xuan Paper (`#FDFCF0`), Deep Carbon Ink (`#1A1A1B`), Chinese Cinnabar Red (`#8B0000`), and Emperor's Gold (`#D4AF37`).
* **Dark Mode**: Toggle to Ink Stone mode (`#121113`) anytime with the `D` key or header icon.
* **Synchronized Character Highlight**: Exact real-time golden highlight (`#D4AF37`) synchronized with Azure Neural Voice recitation via WebSocket word boundary metadata.
* **Ruby Pinyin**: Syllables positioned cleanly above each Hanzi character. Toggleable via `P`.
* **English Translation**: Toggleable sentence translations via `T`.
* **QuickLook Dictionary Popover**: Click any Hanzi character to open a floating definition card with pinyin, audio pronunciation, HSK level badge, and English meaning.
* **Multi-Voice Studio**:
  - `Yunxi (云希)`: Expressive Male Neural Voice (Default)
  - `Xiaoxiao (晓晓)`: Warm Female Neural Voice
  - `Yunjian (云健)`: Classical Storyteller Voice
  - `Xiaoyi (晓伊)`: Cheerful Female Voice
  - `Yunyang (云扬)`: Formal / News Voice
  - `Local`: Browser Web Speech API fallback
* **Grand Library Access**: Browse all 86 classical epics, philosophical texts, and literary works in the sidebar.

---

## ⌨️ Desktop Keyboard Shortcuts

| Shortcut | Action |
| :--- | :--- |
| <kbd>Space</kbd> | Play / Pause recitation |
| <kbd>←</kbd> | Previous sentence |
| <kbd>→</kbd> | Next sentence |
| <kbd>↑</kbd> | Previous chapter |
| <kbd>↓</kbd> | Next chapter |
| <kbd>P</kbd> | Toggle Ruby Pinyin on/off |
| <kbd>T</kbd> | Toggle English translations on/off |
| <kbd>D</kbd> | Toggle Dark / Light theme |
| <kbd>L</kbd> | Toggle Library Sidebar drawer |
| <kbd>Esc</kbd> | Dismiss dictionary popover / modal |
