#!/usr/bin/env python3
"""
Builder script to generate the standalone web_audiobook/index.html.
Embeds classic sample books (Thirty-Six Stratagems and The Little Prince sample)
so the player works out of the box both offline via file:// and over HTTP.
"""

import json
import os

def main():
    root = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
    
    # Load Thirty-Six Stratagems as default embedded book
    stratagems_path = os.path.join(root, 'assets', 'data', 'books', 'thirty_six_stratagems.json')
    with open(stratagems_path, 'r', encoding='utf-8') as f:
        stratagems_data = json.load(f)

    # Load first 5 chapters of Little Prince as second embedded book
    prince_path = os.path.join(root, 'assets', 'data', 'books', 'the_little_prince.json')
    with open(prince_path, 'r', encoding='utf-8') as f:
        prince_data = json.load(f)[:5]

    embedded_books = {
        "thirty_six_stratagems": {
            "id": "thirty_six_stratagems",
            "title": "三十六计",
            "titleEn": "Thirty-Six Stratagems",
            "author": "未知",
            "authorEn": "Unknown",
            "category": "Ancient Classics",
            "dynastyOrEra": "Ming/Qing Dynasty",
            "hskLevel": 5,
            "coverEmoji": "📜",
            "chapters": stratagems_data
        },
        "the_little_prince": {
            "id": "the_little_prince",
            "title": "小王子",
            "titleEn": "The Little Prince",
            "author": "安托万·德·圣-埃克苏佩里",
            "authorEn": "Antoine de Saint-Exupéry",
            "category": "World Classics",
            "dynastyOrEra": "Modern",
            "hskLevel": 3,
            "coverEmoji": "👑",
            "chapters": prince_data
        }
    }

    embedded_json = json.dumps(embedded_books, ensure_ascii=False)

    html_template = f'''<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Hanzi Master · 汉字大师 · Desktop Audiobook</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Ma+Shan+Zheng&family=Noto+Serif+SC:wght@400;500;600;700&family=Noto+Sans+SC:wght@400;500;600&display=swap" rel="stylesheet">
  <style>
    :root {{
      --bg-primary: #FDFCF0;
      --bg-secondary: #F6F2E2;
      --bg-card: #FFFFFF;
      --bg-card-elevated: #FAF8F0;
      --bg-active-sentence: rgba(212, 175, 55, 0.09);
      --border-subtle: rgba(140, 120, 100, 0.15);
      --border-focus: rgba(212, 175, 55, 0.6);
      --text-primary: #1A1A1B;
      --text-secondary: #5A5248;
      --text-tertiary: #8E8478;
      --accent-red: #8B0000;
      --accent-red-hover: #A00000;
      --accent-gold: #D4AF37;
      --accent-gold-glow: rgba(212, 175, 55, 0.35);
      --highlight-char-bg: rgba(212, 175, 55, 0.28);
      --highlight-char-border: #D4AF37;
      --highlight-char-text: #8B0000;
      --selected-char-bg: rgba(99, 102, 241, 0.18);
      --selected-char-border: #6366F1;
      --shadow-sm: 0 2px 6px rgba(0,0,0,0.05);
      --shadow-md: 0 4px 14px rgba(0,0,0,0.08);
      --shadow-lg: 0 10px 30px rgba(0,0,0,0.12);
      --header-height: 64px;
      --player-height: 96px;
      --font-hanzi: 'Noto Serif SC', 'Songti SC', 'SimSun', serif;
      --font-ui: 'Noto Sans SC', system-ui, -apple-system, sans-serif;
      --font-calligraphy: 'Ma Shan Zheng', 'Noto Serif SC', cursive, serif;
    }}

    [data-theme="dark"] {{
      --bg-primary: #121113;
      --bg-secondary: #19181B;
      --bg-card: #1D1C21;
      --bg-card-elevated: #242329;
      --bg-active-sentence: rgba(245, 158, 11, 0.12);
      --border-subtle: rgba(255, 255, 255, 0.08);
      --border-focus: rgba(251, 191, 36, 0.6);
      --text-primary: #FDFCF0;
      --text-secondary: #A8A196;
      --text-tertiary: #6E6860;
      --accent-red: #E05252;
      --accent-red-hover: #F87171;
      --accent-gold: #FBBF24;
      --accent-gold-glow: rgba(251, 191, 36, 0.35);
      --highlight-char-bg: rgba(245, 158, 11, 0.32);
      --highlight-char-border: #FBBF24;
      --highlight-char-text: #FDE68A;
      --selected-char-bg: rgba(129, 140, 248, 0.25);
      --selected-char-border: #818CF8;
      --shadow-sm: 0 2px 6px rgba(0,0,0,0.3);
      --shadow-md: 0 4px 14px rgba(0,0,0,0.4);
      --shadow-lg: 0 10px 30px rgba(0,0,0,0.6);
    }}

    * {{
      box-sizing: border-box;
      margin: 0;
      padding: 0;
      -webkit-font-smoothing: antialiased;
    }}

    body {{
      font-family: var(--font-ui);
      background-color: var(--bg-primary);
      color: var(--text-primary);
      overflow-x: hidden;
      display: flex;
      flex-direction: column;
      height: 100vh;
      user-select: text;
      transition: background-color 0.3s ease, color 0.3s ease;
    }}

    /* Top Ambient Glow */
    .ambient-glow {{
      position: fixed;
      top: -120px;
      left: 15%;
      right: 15%;
      height: 280px;
      background: radial-gradient(ellipse at center, var(--accent-gold-glow) 0%, rgba(139,0,0,0.06) 50%, transparent 80%);
      pointer-events: none;
      z-index: 0;
    }}

    /* Top Header Bar */
    header.app-header {{
      height: var(--header-height);
      background: var(--bg-primary);
      border-bottom: 1px solid var(--border-subtle);
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 0 24px;
      z-index: 20;
      position: relative;
    }}

    .header-left {{
      display: flex;
      align-items: center;
      gap: 16px;
    }}

    .btn-icon {{
      background: none;
      border: 1px solid var(--border-subtle);
      color: var(--text-primary);
      width: 38px;
      height: 38px;
      border-radius: 10px;
      cursor: pointer;
      display: inline-flex;
      align-items: center;
      justify-content: center;
      font-size: 16px;
      transition: all 0.18s ease;
    }}

    .btn-icon:hover {{
      background: var(--bg-secondary);
      border-color: var(--accent-gold);
      transform: translateY(-1px);
    }}

    .brand-title {{
      display: flex;
      align-items: baseline;
      gap: 8px;
      font-family: var(--font-hanzi);
      cursor: pointer;
    }}

    .brand-title .seal {{
      background: var(--accent-red);
      color: #FFF;
      font-size: 14px;
      font-weight: bold;
      padding: 2px 7px;
      border-radius: 6px;
      font-family: var(--font-hanzi);
    }}

    .brand-title .title-text {{
      font-size: 18px;
      font-weight: 700;
      letter-spacing: 0.5px;
    }}

    .current-book-badge {{
      background: var(--bg-secondary);
      border: 1px solid var(--border-subtle);
      padding: 4px 12px;
      border-radius: 20px;
      font-size: 13px;
      display: flex;
      align-items: center;
      gap: 8px;
      color: var(--text-secondary);
    }}

    .header-right {{
      display: flex;
      align-items: center;
      gap: 10px;
    }}

    .toolbar-toggle {{
      background: var(--bg-secondary);
      border: 1px solid var(--border-subtle);
      color: var(--text-secondary);
      padding: 6px 12px;
      border-radius: 10px;
      font-size: 13px;
      font-weight: 500;
      cursor: pointer;
      display: flex;
      align-items: center;
      gap: 6px;
      transition: all 0.15s ease;
    }}

    .toolbar-toggle.active {{
      background: rgba(212, 175, 55, 0.15);
      border-color: var(--accent-gold);
      color: var(--accent-gold);
      font-weight: 600;
    }}

    .toolbar-toggle:hover {{
      border-color: var(--accent-gold);
    }}

    /* App Main Layout: Sidebar + Reader */
    .app-layout {{
      display: flex;
      flex: 1;
      overflow: hidden;
      position: relative;
    }}

    /* Sidebar / Library Drawer */
    aside.sidebar {{
      width: 340px;
      background: var(--bg-secondary);
      border-right: 1px solid var(--border-subtle);
      display: flex;
      flex-direction: column;
      transition: transform 0.25s ease, margin-left 0.25s ease;
      z-index: 15;
    }}

    aside.sidebar.collapsed {{
      margin-left: -340px;
    }}

    .sidebar-header {{
      padding: 16px;
      border-bottom: 1px solid var(--border-subtle);
    }}

    .sidebar-search {{
      position: relative;
      width: 100%;
    }}

    .sidebar-search input {{
      width: 100%;
      padding: 10px 14px 10px 36px;
      border-radius: 10px;
      border: 1px solid var(--border-subtle);
      background: var(--bg-card);
      color: var(--text-primary);
      font-size: 13px;
      outline: none;
      transition: border-color 0.2s ease;
    }}

    .sidebar-search input:focus {{
      border-color: var(--accent-gold);
    }}

    .sidebar-search .search-icon {{
      position: absolute;
      left: 12px;
      top: 50%;
      transform: translateY(-50%);
      font-size: 14px;
      color: var(--text-tertiary);
    }}

    .sidebar-tabs {{
      display: flex;
      border-bottom: 1px solid var(--border-subtle);
      padding: 0 16px;
      background: var(--bg-secondary);
    }}

    .sidebar-tab {{
      flex: 1;
      padding: 10px 0;
      text-align: center;
      font-size: 13px;
      font-weight: 600;
      color: var(--text-tertiary);
      border-bottom: 2px solid transparent;
      cursor: pointer;
      transition: all 0.2s ease;
    }}

    .sidebar-tab.active {{
      color: var(--text-primary);
      border-color: var(--accent-gold);
    }}

    .sidebar-content {{
      flex: 1;
      overflow-y: auto;
      padding: 12px;
    }}

    /* Book Catalog Cards */
    .book-card {{
      background: var(--bg-card);
      border: 1px solid var(--border-subtle);
      border-radius: 12px;
      padding: 12px;
      margin-bottom: 10px;
      cursor: pointer;
      display: flex;
      gap: 12px;
      transition: all 0.18s ease;
    }}

    .book-card:hover {{
      border-color: var(--accent-gold);
      transform: translateY(-2px);
      box-shadow: var(--shadow-sm);
    }}

    .book-card.active {{
      border-color: var(--accent-gold);
      background: var(--bg-active-sentence);
    }}

    .book-card .book-emoji {{
      font-size: 32px;
      line-height: 1;
      display: flex;
      align-items: center;
      justify-content: center;
      width: 48px;
      height: 60px;
      background: var(--bg-secondary);
      border-radius: 8px;
      border: 1px solid var(--border-subtle);
      flex-shrink: 0;
    }}

    .book-card .book-info {{
      flex: 1;
      min-width: 0;
    }}

    .book-card .book-title {{
      font-family: var(--font-hanzi);
      font-size: 15px;
      font-weight: 700;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
      color: var(--text-primary);
    }}

    .book-card .book-title-en {{
      font-size: 12px;
      color: var(--text-secondary);
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
      margin-bottom: 4px;
    }}

    .book-card .book-meta {{
      display: flex;
      align-items: center;
      gap: 6px;
      font-size: 11px;
    }}

    .badge-hsk {{
      background: rgba(139, 0, 0, 0.12);
      color: var(--accent-red);
      font-weight: 700;
      padding: 1px 6px;
      border-radius: 4px;
      font-size: 10px;
    }}

    .badge-dynasty {{
      color: var(--text-tertiary);
    }}

    /* Chapter List in Sidebar */
    .chapter-item {{
      padding: 10px 14px;
      border-radius: 10px;
      cursor: pointer;
      margin-bottom: 4px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      font-size: 13px;
      transition: all 0.15s ease;
      color: var(--text-secondary);
    }}

    .chapter-item:hover {{
      background: var(--bg-card);
      color: var(--text-primary);
    }}

    .chapter-item.active {{
      background: var(--bg-card);
      border-left: 3px solid var(--accent-gold);
      color: var(--text-primary);
      font-weight: 600;
    }}

    .custom-book-dropzone {{
      border: 2px dashed var(--border-subtle);
      border-radius: 12px;
      padding: 20px;
      text-align: center;
      margin-top: 12px;
      cursor: pointer;
      background: var(--bg-card);
      transition: all 0.2s ease;
    }}

    .custom-book-dropzone:hover {{
      border-color: var(--accent-gold);
      background: var(--bg-active-sentence);
    }}

    /* Main Reader Area */
    main.reader-arena {{
      flex: 1;
      overflow-y: auto;
      scroll-behavior: smooth;
      padding: 36px 20px calc(var(--player-height) + 40px) 20px;
      position: relative;
    }}

    .reader-container {{
      max-width: 820px;
      margin: 0 auto;
    }}

    /* Chapter Header in Reader */
    .reader-chapter-hero {{
      text-align: center;
      margin-bottom: 40px;
      padding-bottom: 24px;
      border-bottom: 1px solid var(--border-subtle);
      position: relative;
    }}

    .chapter-badge {{
      display: inline-block;
      padding: 3px 14px;
      background: var(--bg-secondary);
      border: 1px solid var(--border-subtle);
      border-radius: 20px;
      font-size: 12px;
      font-weight: 600;
      color: var(--accent-gold);
      letter-spacing: 1px;
      margin-bottom: 12px;
      text-transform: uppercase;
    }}

    .chapter-hero-title {{
      font-family: var(--font-calligraphy);
      font-size: 34px;
      font-weight: 400;
      letter-spacing: 2px;
      color: var(--text-primary);
      margin-bottom: 6px;
    }}

    .chapter-hero-en {{
      font-size: 15px;
      color: var(--text-secondary);
      font-style: italic;
    }}

    /* Sentences List */
    .sentences-stream {{
      display: flex;
      flex-direction: column;
      gap: 16px;
    }}

    .sentence-card {{
      background: var(--bg-card);
      border: 1px solid var(--border-subtle);
      border-radius: 16px;
      padding: 18px 22px;
      cursor: pointer;
      transition: all 0.22s cubic-bezier(0.16, 1, 0.3, 1);
      position: relative;
      box-shadow: var(--shadow-sm);
    }}

    .sentence-card:hover {{
      border-color: var(--border-focus);
      transform: translateY(-1px);
      box-shadow: var(--shadow-md);
    }}

    .sentence-card.active {{
      background: var(--bg-active-sentence);
      border: 1.5px solid var(--accent-gold);
      box-shadow: 0 6px 20px var(--accent-gold-glow);
    }}

    .sentence-card .sentence-meta {{
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 12px;
      font-size: 11px;
      color: var(--text-tertiary);
      font-weight: 600;
      letter-spacing: 0.5px;
    }}

    .sentence-card.active .sentence-meta {{
      color: var(--accent-gold);
    }}

    .playing-indicator {{
      display: none;
      align-items: center;
      gap: 3px;
    }}

    .sentence-card.active .playing-indicator {{
      display: flex;
    }}

    .playing-indicator span {{
      width: 3px;
      height: 12px;
      background: var(--accent-gold);
      border-radius: 2px;
      animation: wave 1s infinite ease-in-out;
    }}

    .playing-indicator span:nth-child(2) {{ animation-delay: 0.2s; height: 16px; }}
    .playing-indicator span:nth-child(3) {{ animation-delay: 0.4s; height: 10px; }}

    @keyframes wave {{
      0%, 100% {{ transform: scaleY(0.4); }}
      50% {{ transform: scaleY(1); }}
    }}

    /* Chinese Text Line with Ruby Pinyin */
    .chinese-line {{
      display: flex;
      flex-wrap: wrap;
      align-items: flex-end;
      gap: 2px 2px;
      line-height: 1.4;
      margin-bottom: 8px;
    }}

    /* Individual Character Container */
    .ruby-char {{
      display: inline-flex;
      flex-direction: column;
      align-items: center;
      justify-content: flex-end;
      text-align: center;
      min-width: 1.25em;
      padding: 3px 3px;
      border-radius: 6px;
      border: 1px solid transparent;
      cursor: pointer;
      transition: all 0.12s ease;
      position: relative;
    }}

    .ruby-char:hover {{
      background: rgba(140, 120, 100, 0.1);
      border-color: var(--border-subtle);
    }}

    .ruby-char .pinyin {{
      font-family: var(--font-ui);
      font-size: calc(var(--base-font-size, 20px) * 0.58);
      font-weight: 500;
      color: var(--text-tertiary);
      line-height: 1.1;
      margin-bottom: 2px;
      letter-spacing: 0.2px;
      user-select: none;
      text-align: center;
      width: 100%;
      white-space: nowrap;
      transition: color 0.15s ease;
    }}

    .hide-pinyin .ruby-char .pinyin {{
      display: none;
    }}

    .ruby-char .hanzi {{
      font-family: var(--font-hanzi);
      font-size: var(--base-font-size, 22px);
      font-weight: 600;
      color: var(--text-primary);
      line-height: 1.15;
      text-align: center;
      width: 100%;
      transition: color 0.15s ease, transform 0.15s ease;
    }}

    .punct-char {{
      display: inline-flex;
      align-items: flex-end;
      padding: 3px 2px;
      font-family: var(--font-hanzi);
      font-size: var(--base-font-size, 22px);
      color: var(--text-tertiary);
      line-height: 1.15;
    }}

    /* Active Spoken Character Highlight */
    .ruby-char.is-spoken {{
      background: var(--highlight-char-bg) !important;
      border-color: var(--highlight-char-border) !important;
      box-shadow: 0 0 10px var(--accent-gold-glow);
      transform: scale(1.08);
      z-index: 2;
    }}

    .ruby-char.is-spoken .pinyin {{
      color: var(--highlight-char-text) !important;
      font-weight: 700;
    }}

    .ruby-char.is-spoken .hanzi {{
      color: var(--highlight-char-text) !important;
      font-weight: 700;
    }}

    /* QuickLook Selected Character */
    .ruby-char.is-selected {{
      background: var(--selected-char-bg) !important;
      border-color: var(--selected-char-border) !important;
      box-shadow: 0 0 12px rgba(99, 102, 241, 0.4);
    }}

    /* English Sentence Translation */
    .english-line {{
      font-size: 14px;
      color: var(--text-secondary);
      line-height: 1.5;
      padding-top: 8px;
      border-top: 1px dashed var(--border-subtle);
      font-style: normal;
    }}

    .hide-translations .english-line {{
      display: none;
    }}

    /* Bottom Fixed Console / Player Bar */
    footer.player-console {{
      position: fixed;
      bottom: 0;
      left: 0;
      right: 0;
      height: var(--player-height);
      background: var(--bg-card-elevated);
      border-top: 1px solid var(--border-subtle);
      box-shadow: var(--shadow-lg);
      display: flex;
      flex-direction: column;
      justify-content: center;
      padding: 0 28px;
      z-index: 30;
      backdrop-filter: blur(12px);
    }}

    /* Progress Scrubber Bar */
    .scrubber-container {{
      width: 100%;
      display: flex;
      align-items: center;
      gap: 12px;
      margin-bottom: 6px;
    }}

    .scrubber-slider {{
      flex: 1;
      height: 4px;
      -webkit-appearance: none;
      appearance: none;
      background: var(--border-subtle);
      border-radius: 2px;
      outline: none;
      cursor: pointer;
      transition: height 0.15s ease;
    }}

    .scrubber-slider:hover {{
      height: 6px;
    }}

    .scrubber-slider::-webkit-slider-thumb {{
      -webkit-appearance: none;
      appearance: none;
      width: 12px;
      height: 12px;
      border-radius: 50%;
      background: var(--accent-gold);
      cursor: pointer;
      box-shadow: 0 0 6px var(--accent-gold-glow);
      transition: transform 0.15s ease;
    }}

    .scrubber-slider::-webkit-slider-thumb:hover {{
      transform: scale(1.3);
    }}

    .scrubber-label {{
      font-size: 11px;
      font-weight: 600;
      color: var(--text-tertiary);
      min-width: 90px;
      text-align: right;
    }}

    /* Console Controls Row */
    .console-row {{
      display: flex;
      align-items: center;
      justify-content: space-between;
    }}

    .console-left {{
      display: flex;
      align-items: center;
      gap: 14px;
      width: 260px;
    }}

    .console-book-info {{
      min-width: 0;
    }}

    .console-book-title {{
      font-family: var(--font-hanzi);
      font-size: 14px;
      font-weight: 700;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
    }}

    .console-chapter-title {{
      font-size: 12px;
      color: var(--text-secondary);
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
    }}

    /* Center Transport Buttons */
    .console-center {{
      display: flex;
      align-items: center;
      gap: 16px;
    }}

    .btn-transport {{
      background: none;
      border: none;
      color: var(--text-primary);
      cursor: pointer;
      display: flex;
      align-items: center;
      justify-content: center;
      transition: all 0.15s ease;
    }}

    .btn-transport:hover {{
      color: var(--accent-gold);
      transform: scale(1.1);
    }}

    .btn-transport:disabled {{
      opacity: 0.3;
      cursor: not-allowed;
      transform: none;
    }}

    .btn-play-pause {{
      width: 52px;
      height: 52px;
      border-radius: 50%;
      background: linear-gradient(135deg, var(--accent-red), #5e0000);
      color: #FFF;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 22px;
      box-shadow: 0 4px 14px rgba(139, 0, 0, 0.4);
      cursor: pointer;
      border: none;
      transition: all 0.18s ease;
    }}

    [data-theme="dark"] .btn-play-pause {{
      background: linear-gradient(135deg, #FBBF24, #D97706);
      color: #121113;
      box-shadow: 0 4px 14px rgba(251, 191, 36, 0.4);
    }}

    .btn-play-pause:hover {{
      transform: scale(1.06);
    }}

    /* Console Right Controls: Speed, Voice, Sleep */
    .console-right {{
      display: flex;
      align-items: center;
      gap: 12px;
      width: 320px;
      justify-content: flex-end;
    }}

    .select-pill {{
      background: var(--bg-secondary);
      border: 1px solid var(--border-subtle);
      color: var(--text-primary);
      padding: 6px 10px;
      border-radius: 8px;
      font-size: 12px;
      outline: none;
      cursor: pointer;
      font-weight: 500;
    }}

    .select-pill:focus {{
      border-color: var(--accent-gold);
    }}

    .btn-speed {{
      background: var(--bg-secondary);
      border: 1px solid var(--border-subtle);
      color: var(--accent-gold);
      padding: 6px 10px;
      border-radius: 8px;
      font-size: 12px;
      font-weight: bold;
      cursor: pointer;
      min-width: 44px;
      text-align: center;
    }}

    .btn-speed:hover {{
      border-color: var(--accent-gold);
    }}

    /* Floating QuickLook Dictionary Popover */
    .quicklook-popover {{
      position: fixed;
      width: 320px;
      background: var(--bg-card-elevated);
      border: 1px solid var(--accent-gold);
      border-radius: 16px;
      padding: 20px;
      box-shadow: var(--shadow-lg), 0 0 20px var(--accent-gold-glow);
      z-index: 50;
      display: none;
      animation: popIn 0.18s cubic-bezier(0.16, 1, 0.3, 1);
    }}

    @keyframes popIn {{
      from {{ opacity: 0; transform: scale(0.92) translateY(8px); }}
      to {{ opacity: 1; transform: scale(1) translateY(0); }}
    }}

    .quicklook-header {{
      display: flex;
      align-items: flex-start;
      justify-content: space-between;
      margin-bottom: 12px;
    }}

    .ql-char-row {{
      display: flex;
      align-items: baseline;
      gap: 12px;
    }}

    .ql-char {{
      font-family: var(--font-hanzi);
      font-size: 46px;
      font-weight: 700;
      color: var(--text-primary);
      line-height: 1;
    }}

    .ql-pinyin-wrap {{
      display: flex;
      flex-direction: column;
    }}

    .ql-pinyin {{
      font-size: 18px;
      font-weight: 700;
      color: var(--accent-gold);
    }}

    .ql-speak-btn {{
      background: none;
      border: none;
      color: var(--text-secondary);
      cursor: pointer;
      font-size: 14px;
      margin-top: 4px;
      display: inline-flex;
      align-items: center;
      gap: 4px;
    }}

    .ql-speak-btn:hover {{
      color: var(--accent-red);
    }}

    .ql-close-btn {{
      background: none;
      border: none;
      color: var(--text-tertiary);
      font-size: 20px;
      cursor: pointer;
      line-height: 1;
      padding: 2px 6px;
      border-radius: 4px;
    }}

    .ql-close-btn:hover {{
      background: var(--bg-secondary);
      color: var(--text-primary);
    }}

    .ql-meta {{
      display: flex;
      gap: 8px;
      margin-bottom: 12px;
    }}

    .ql-def-box {{
      font-size: 13px;
      color: var(--text-secondary);
      line-height: 1.5;
      padding: 10px;
      background: var(--bg-secondary);
      border-radius: 10px;
      border: 1px solid var(--border-subtle);
      max-height: 140px;
      overflow-y: auto;
    }}

    .ql-actions {{
      margin-top: 14px;
      display: flex;
      justify-content: flex-end;
      gap: 8px;
    }}

    .ql-btn {{
      background: var(--bg-secondary);
      border: 1px solid var(--border-subtle);
      color: var(--text-secondary);
      padding: 5px 12px;
      border-radius: 8px;
      font-size: 12px;
      cursor: pointer;
      font-weight: 600;
      transition: all 0.15s ease;
    }}

    .ql-btn:hover {{
      border-color: var(--accent-gold);
      color: var(--text-primary);
    }}

    /* Shortcuts Help Modal */
    .modal-overlay {{
      position: fixed;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: rgba(0,0,0,0.55);
      backdrop-filter: blur(4px);
      z-index: 60;
      display: none;
      align-items: center;
      justify-content: center;
    }}

    .modal-card {{
      background: var(--bg-card);
      border: 1px solid var(--border-subtle);
      border-radius: 20px;
      padding: 28px;
      width: 480px;
      max-width: 90%;
      box-shadow: var(--shadow-lg);
    }}

    .modal-title {{
      font-family: var(--font-hanzi);
      font-size: 20px;
      font-weight: 700;
      margin-bottom: 18px;
      display: flex;
      align-items: center;
      justify-content: space-between;
    }}

    .shortcut-list {{
      display: flex;
      flex-direction: column;
      gap: 12px;
    }}

    .shortcut-item {{
      display: flex;
      align-items: center;
      justify-content: space-between;
      font-size: 13.5px;
      color: var(--text-secondary);
    }}

    .key-badge {{
      background: var(--bg-secondary);
      border: 1px solid var(--border-subtle);
      padding: 4px 10px;
      border-radius: 6px;
      font-family: monospace;
      font-size: 12px;
      color: var(--text-primary);
      box-shadow: 0 1px 3px rgba(0,0,0,0.1);
    }}

    /* Custom Scrollbar */
    ::-webkit-scrollbar {{
      width: 6px;
      height: 6px;
    }}
    ::-webkit-scrollbar-track {{
      background: transparent;
    }}
    ::-webkit-scrollbar-thumb {{
      background: var(--border-subtle);
      border-radius: 3px;
    }}
    ::-webkit-scrollbar-thumb:hover {{
      background: var(--accent-gold);
    }}
  </style>
</head>
<body data-theme="light">
  <div class="ambient-glow"></div>

  <!-- Top Application Header -->
  <header class="app-header">
    <div class="header-left">
      <button class="btn-icon" id="btnToggleSidebar" title="Toggle Library Sidebar (L)">
        ☰
      </button>
      <div class="brand-title" id="brandHome">
        <span class="seal">墨</span>
        <span class="title-text">Hanzi Master · 听书</span>
      </div>
      <div class="current-book-badge" id="headerBookBadge">
        <span id="headerBookEmoji">📜</span>
        <strong id="headerBookTitle">三十六计</strong>
        <span id="headerChapterIndex">第 1 计</span>
      </div>
    </div>

    <div class="header-right">
      <button class="toolbar-toggle active" id="btnTogglePinyin" title="Toggle Pinyin (P)">
        🔤 Pinyin
      </button>
      <button class="toolbar-toggle active" id="btnToggleTrans" title="Toggle Translation (T)">
        🌐 English
      </button>
      <button class="toolbar-toggle active" id="btnToggleAutoScroll" title="Toggle Smooth Auto-Scroll">
        📜 Auto-Scroll
      </button>
      <button class="btn-icon" id="btnFontMinus" title="Decrease Font Size">A-</button>
      <button class="btn-icon" id="btnFontPlus" title="Increase Font Size">A+</button>
      <button class="btn-icon" id="btnThemeToggle" title="Toggle Dark/Light Mode (D)">🌓</button>
      <button class="btn-icon" id="btnShortcuts" title="Keyboard Shortcuts (?)">⌨️</button>
    </div>
  </header>

  <!-- Main Layout -->
  <div class="app-layout">
    <!-- Collapsible Sidebar -->
    <aside class="sidebar" id="sidebar">
      <div class="sidebar-header">
        <div class="sidebar-search">
          <span class="search-icon">🔍</span>
          <input type="text" id="searchBooks" placeholder="Search 86 classical books...">
        </div>
      </div>

      <div class="sidebar-tabs">
        <div class="sidebar-tab active" id="tabBooks">Library (86)</div>
        <div class="sidebar-tab" id="tabChapters">Chapters</div>
      </div>

      <div class="sidebar-content" id="sidebarContent">
        <!-- Dynamic Book List / Chapters List injected via JS -->
      </div>
    </aside>

    <!-- Main Reader Arena -->
    <main class="reader-arena" id="readerArena">
      <div class="reader-container">
        <!-- Hero Header -->
        <div class="reader-chapter-hero">
          <span class="chapter-badge" id="heroBadge">Chapter 1</span>
          <h1 class="chapter-hero-title" id="heroTitleZh">胜战计·瞒天过海</h1>
          <p class="chapter-hero-en" id="heroTitleEn">Chapter 1: Deceive the heavens to cross the sea</p>
        </div>

        <!-- Sentences Stream -->
        <div class="sentences-stream" id="sentencesStream">
          <!-- Rendered dynamically -->
        </div>
      </div>
    </main>
  </div>

  <!-- Bottom Player Console -->
  <footer class="player-console">
    <div class="scrubber-container">
      <input type="range" class="scrubber-slider" id="scrubber" min="0" max="100" value="0">
      <span class="scrubber-label" id="scrubberLabel">Sentence 1/3</span>
    </div>

    <div class="console-row">
      <!-- Left: Book & Chapter Preview -->
      <div class="console-left">
        <div class="console-book-info">
          <div class="console-book-title" id="consoleBookTitle">三十六计</div>
          <div class="console-chapter-title" id="consoleChapterTitle">第 1 计 · 胜战计·瞒天过海</div>
        </div>
      </div>

      <!-- Center: Playback Transport Controls -->
      <div class="console-center">
        <button class="btn-transport" id="btnPrevSentence" title="Previous Sentence (←)">
          <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor"><path d="M6 6h2v12H6zm3.5 6l8.5 6V6z"/></svg>
        </button>

        <button class="btn-play-pause" id="btnPlayPause" title="Play / Pause (Space)">
          <span id="playIcon">▶</span>
        </button>

        <button class="btn-transport" id="btnNextSentence" title="Next Sentence (→)">
          <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor"><path d="M6 18l8.5-6L6 6v12zM16 6v12h2V6h-2z"/></svg>
        </button>
      </div>

      <!-- Right: Speed, Voice, Sleep, Mode -->
      <div class="console-right">
        <button class="btn-speed" id="btnSpeed" title="Playback Speed">1.0x</button>

        <select class="select-pill" id="selectVoice" title="Audio Voice">
          <option value="zh-CN-YunxiNeural">Yunxi (云希 · Male HD)</option>
          <option value="zh-CN-XiaoxiaoNeural">Xiaoxiao (晓晓 · Female HD)</option>
          <option value="zh-CN-YunjianNeural">Yunjian (云健 · Storyteller)</option>
          <option value="zh-CN-XiaoyiNeural">Xiaoyi (晓伊 · Cheerful)</option>
          <option value="zh-CN-YunyangNeural">Yunyang (云扬 · News)</option>
          <option value="local">Local Browser Voice (Web Speech)</option>
        </select>

        <select class="select-pill" id="selectSleep" title="Sleep Timer">
          <option value="0">Timer: Off</option>
          <option value="15">15 mins</option>
          <option value="30">30 mins</option>
          <option value="45">45 mins</option>
          <option value="chapter">End of Chapter</option>
        </select>
      </div>
    </div>
  </footer>

  <!-- Floating QuickLook Dictionary Popover -->
  <div class="quicklook-popover" id="quicklookPopover">
    <div class="quicklook-header">
      <div class="ql-char-row">
        <span class="ql-char" id="qlChar">计</span>
        <div class="ql-pinyin-wrap">
          <span class="ql-pinyin" id="qlPinyin">jì</span>
          <button class="ql-speak-btn" id="qlSpeakBtn">🔊 Pronounce</button>
        </div>
      </div>
      <button class="ql-close-btn" id="qlCloseBtn">×</button>
    </div>

    <div class="ql-meta">
      <span class="badge-hsk" id="qlHsk">HSK 3</span>
      <span class="badge-dynasty" id="qlRadical">Radical: 讠</span>
    </div>

    <div class="ql-def-box" id="qlDef">
      to calculate; to compute; to count; strategy; plan
    </div>

    <div class="ql-actions">
      <button class="ql-btn" id="qlCopyBtn">📋 Copy Char</button>
    </div>
  </div>

  <!-- Keyboard Shortcuts Modal -->
  <div class="modal-overlay" id="shortcutsModal">
    <div class="modal-card">
      <div class="modal-title">
        <span>⌨️ Keyboard Shortcuts</span>
        <button class="ql-close-btn" id="closeShortcutsModal">×</button>
      </div>
      <div class="shortcut-list">
        <div class="shortcut-item"><span>Play / Pause</span><span class="key-badge">Space</span></div>
        <div class="shortcut-item"><span>Previous / Next Sentence</span><span class="key-badge">← / →</span></div>
        <div class="shortcut-item"><span>Previous / Next Chapter</span><span class="key-badge">↑ / ↓</span></div>
        <div class="shortcut-item"><span>Toggle Pinyin</span><span class="key-badge">P</span></div>
        <div class="shortcut-item"><span>Toggle Translation</span><span class="key-badge">T</span></div>
        <div class="shortcut-item"><span>Toggle Dark / Light Mode</span><span class="key-badge">D</span></div>
        <div class="shortcut-item"><span>Toggle Library Sidebar</span><span class="key-badge">L</span></div>
        <div class="shortcut-item"><span>Close Dictionary Popover</span><span class="key-badge">Esc</span></div>
      </div>
    </div>
  </div>

  <!-- Audio Element for Playback -->
  <audio id="htmlAudio" preload="auto"></audio>

  <!-- Embedded Books & Application Logic -->
  <script>
    const EMBEDDED_BOOKS = {embedded_json};

    const AZURE_KEY = 'AnZ5l470hrJMMOqPYYH085lWbpFHjRH8nZCkryg0TWFF8yaVzDdOJQQJ99CGACPV0roXJ3w3AAAYACOGk7C0';
    const AZURE_REGION = 'germanywestcentral';

    const NON_SPOKEN_SET = new Set([
      '，', '。', '！', '？', '、', '“', '”', '‘', '’', '：', '；',
      '《', '》', '（', '）', '—', '…', ' ', '\\n', '\\r', '\\t',
      ',', '!', '?', '.', ':', ';', "'", '"', '(', ')', '[', ']', '{{', '}}'
    ]);

    // Application State
    const state = {{
      catalog: [],
      currentBook: EMBEDDED_BOOKS["thirty_six_stratagems"],
      currentChapterIndex: 0,
      currentSentenceIndex: 0,
      isPlaying: false,
      playbackSpeed: 1.0,
      currentVoice: 'zh-CN-YunxiNeural',
      pinyinVisible: true,
      translationsVisible: true,
      autoScroll: true,
      theme: 'light',
      baseFontSize: 22,
      activeTimings: [],
      currentSpokenHanziIndex: -1,
      dictionary: {{}},
      sleepSecondsRemaining: null,
      stopAtEndOfChapter: false,
      currentTab: 'books',
      searchQuery: ''
    }};

    // DOM Elements Cache
    const el = {{
      sidebar: document.getElementById('sidebar'),
      btnToggleSidebar: document.getElementById('btnToggleSidebar'),
      tabBooks: document.getElementById('tabBooks'),
      tabChapters: document.getElementById('tabChapters'),
      sidebarContent: document.getElementById('sidebarContent'),
      searchBooks: document.getElementById('searchBooks'),
      headerBookBadge: document.getElementById('headerBookBadge'),
      headerBookEmoji: document.getElementById('headerBookEmoji'),
      headerBookTitle: document.getElementById('headerBookTitle'),
      headerChapterIndex: document.getElementById('headerChapterIndex'),
      heroBadge: document.getElementById('heroBadge'),
      heroTitleZh: document.getElementById('heroTitleZh'),
      heroTitleEn: document.getElementById('heroTitleEn'),
      sentencesStream: document.getElementById('sentencesStream'),
      readerArena: document.getElementById('readerArena'),
      scrubber: document.getElementById('scrubber'),
      scrubberLabel: document.getElementById('scrubberLabel'),
      consoleBookTitle: document.getElementById('consoleBookTitle'),
      consoleChapterTitle: document.getElementById('consoleChapterTitle'),
      btnPrevSentence: document.getElementById('btnPrevSentence'),
      btnNextSentence: document.getElementById('btnNextSentence'),
      btnPlayPause: document.getElementById('btnPlayPause'),
      playIcon: document.getElementById('playIcon'),
      btnSpeed: document.getElementById('btnSpeed'),
      selectVoice: document.getElementById('selectVoice'),
      selectSleep: document.getElementById('selectSleep'),
      btnTogglePinyin: document.getElementById('btnTogglePinyin'),
      btnToggleTrans: document.getElementById('btnToggleTrans'),
      btnToggleAutoScroll: document.getElementById('btnToggleAutoScroll'),
      btnFontMinus: document.getElementById('btnFontMinus'),
      btnFontPlus: document.getElementById('btnFontPlus'),
      btnThemeToggle: document.getElementById('btnThemeToggle'),
      btnShortcuts: document.getElementById('btnShortcuts'),
      shortcutsModal: document.getElementById('shortcutsModal'),
      closeShortcutsModal: document.getElementById('closeShortcutsModal'),
      quicklookPopover: document.getElementById('quicklookPopover'),
      qlChar: document.getElementById('qlChar'),
      qlPinyin: document.getElementById('qlPinyin'),
      qlHsk: document.getElementById('qlHsk'),
      qlRadical: document.getElementById('qlRadical'),
      qlDef: document.getElementById('qlDef'),
      qlSpeakBtn: document.getElementById('qlSpeakBtn'),
      qlCopyBtn: document.getElementById('qlCopyBtn'),
      qlCloseBtn: document.getElementById('qlCloseBtn'),
      htmlAudio: document.getElementById('htmlAudio')
    }};

    // UUID Generator for Azure connection
    function generateUuid() {{
      return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {{
        const r = Math.random() * 16 | 0, v = c === 'x' ? r : (r & 0x3 | 0x8);
        return v.toString(16);
      }});
    }}

    // Path resolver for local dev server vs GitLab Pages root
    function resolveAssetPath(path) {{
      if (window.location.protocol === 'file:') return path;
      if (window.location.pathname.includes('/web_audiobook/')) {{
        return path.startsWith('/') ? path : '/' + path;
      }}
      return './' + path.replace(/^\\/+/, '');
    }}

    // Pinyin & Ruby Tokenizer
    function parseRubyTokens(chinese, pinyinStr) {{
      const rawList = (pinyinStr || '').trim().split(/\\s+/).filter(Boolean);
      // Filter out punctuation marks and non-word tokens so pinyinList aligns 1:1 with spoken Hanzi
      const pinyinList = rawList.filter(token => !NON_SPOKEN_SET.has(token) && !/^[\\p{{P}}\\p{{S}}\\d]+$/u.test(token));
      const tokens = [];
      let pinyinIdx = 0;
      let hanziIdx = 0;

      for (const char of chinese) {{
        const isPunctuation = NON_SPOKEN_SET.has(char) || /^\\d+$/.test(char);
        if (isPunctuation) {{
          tokens.push({{ char, pinyin: '', isPunctuation: true, hanziIndex: -1 }});
        }} else {{
          const py = pinyinIdx < pinyinList.length ? pinyinList[pinyinIdx] : '';
          tokens.push({{ char, pinyin: py, isPunctuation: false, hanziIndex: hanziIdx }});
          pinyinIdx++;
          hanziIdx++;
        }}
      }}
      return tokens;
    }}

    // Construct SpokenCharTiming list aligning boundaries with characters
    function buildSpokenCharTimings(text, boundaries) {{
      if (!text || !boundaries || boundaries.length === 0) return [];

      const hanziIndexByOffset = new Map();
      let hanziCounter = 0;
      let offset = 0;
      for (const c of text) {{
        const isNonSpoken = NON_SPOKEN_SET.has(c) || /^\\d+$/.test(c);
        if (!isNonSpoken) {{
          hanziIndexByOffset.set(offset, hanziCounter);
          hanziCounter++;
        }}
        offset += c.length;
      }}

      const timings = [];
      let searchPos = 0;

      for (const b of boundaries) {{
        const word = (b.Word || (b.text && b.text.Text) || '').toString();
        const boundaryType = (b.BoundaryType || (b.text && b.text.BoundaryType) || b.Type || '').toString();
        if (!word) continue;

        // Skip full-sentence boundary so searchPos does not jump to end of sentence
        if (boundaryType === 'SentenceBoundary') continue;

        const offsetMs = Number(b.OffsetMs || (b.Offset / 10000.0) || 0);
        const durMs = Number(b.DurationMs || (b.Duration / 10000.0) || 0);

        const foundAt = text.indexOf(word, searchPos);
        if (foundAt === -1) continue;
        searchPos = foundAt + word.length;

        if (boundaryType === 'PunctuationBoundary') continue;

        const wordHanziOffsets = [];
        let wOffset = foundAt;
        for (const c of word) {{
          if (hanziIndexByOffset.has(wOffset)) {{
            wordHanziOffsets.add ? wordHanziOffsets.add(wOffset) : wordHanziOffsets.push(wOffset);
          }}
          wOffset += c.length;
        }}

        if (wordHanziOffsets.length === 0) continue;

        const charDuration = durMs / wordHanziOffsets.length;
        for (let i = 0; i < wordHanziOffsets.length; i++) {{
          const charOffset = wordHanziOffsets[i];
          const charStr = text.substr(charOffset, 1);
          const hanziIdx = hanziIndexByOffset.get(charOffset);
          const cStart = offsetMs + (i * charDuration);
          const cEnd = offsetMs + ((i + 1) * charDuration);
          timings.push({{
            hanziIndex: hanziIdx,
            char: charStr,
            startMs: cStart,
            endMs: cEnd
          }});
        }}
      }}

      return timings;
    }}

    // Find active spoken timing for current playback position
    function findActiveTiming(timings, positionMs) {{
      if (!timings || timings.length === 0) return null;
      if (positionMs <= timings[0].startMs) return timings[0];
      if (positionMs >= timings[timings.length - 1].endMs) return timings[timings.length - 1];

      for (let i = 0; i < timings.length; i++) {{
        const t = timings[i];
        if (positionMs >= t.startMs && positionMs < t.endMs) {{
          return t;
        }}
        if (i + 1 < timings.length && positionMs >= t.endMs && positionMs < timings[i + 1].startMs) {{
          return t;
        }}
      }}
      return timings[timings.length - 1];
    }}

    // Audio Engine
    class AudioEngine {{
      constructor() {{
        this.currentWs = null;
        this.currentAudioUrl = null;
        this.activeGeneration = 0;
        this.isSynthesizing = false;
        this.initListeners();
      }}

      initListeners() {{
        el.htmlAudio.addEventListener('timeupdate', () => {{
          if (!state.isPlaying) return;
          const posMs = el.htmlAudio.currentTime * 1000;
          if (state.activeTimings && state.activeTimings.length > 0) {{
            const active = findActiveTiming(state.activeTimings, posMs);
            if (active && active.hanziIndex !== state.currentSpokenHanziIndex) {{
              state.currentSpokenHanziIndex = active.hanziIndex;
              updateCharacterHighlights();
            }}
          }} else {{
            const curChap = state.currentBook && state.currentBook.chapters[state.currentChapterIndex];
            const curSent = curChap && curChap.sentences[state.currentSentenceIndex];
            const durMs = (el.htmlAudio.duration || 0) * 1000;
            if (durMs > 0 && curSent) {{
              const tokens = parseRubyTokens(curSent.chinese, curSent.pinyin);
              const hanziCount = tokens.filter(t => !t.isPunctuation).length;
              if (hanziCount > 0) {{
                const fraction = Math.min(1.0, Math.max(0.0, posMs / durMs));
                const targetIdx = Math.min(hanziCount - 1, Math.floor(fraction * hanziCount));
                if (targetIdx !== state.currentSpokenHanziIndex) {{
                  state.currentSpokenHanziIndex = targetIdx;
                  updateCharacterHighlights();
                }}
              }}
            }}
          }}
        }});

        el.htmlAudio.addEventListener('ended', () => {{
          onSentenceAudioEnded();
        }});

        el.htmlAudio.addEventListener('error', (e) => {{
          console.warn('Audio playback error, falling back to Web Speech:', e);
          this.playWebSpeechFallback();
        }});
      }}

      async playSentence(chapterIndex, sentenceIndex) {{
        const gen = ++this.activeGeneration;
        this.stop();

        const chapter = state.currentBook.chapters[chapterIndex];
        if (!chapter || !chapter.sentences[sentenceIndex]) return;

        const sentence = chapter.sentences[sentenceIndex];
        state.currentChapterIndex = chapterIndex;
        state.currentSentenceIndex = sentenceIndex;
        state.currentSpokenHanziIndex = -1;
        state.activeTimings = [];
        state.isPlaying = true;

        updatePlaybackUI();
        renderActiveSentenceCard();

        if (state.currentVoice === 'local') {{
          this.playWebSpeechFallback(sentence.chinese);
          return;
        }}

        try {{
          await this.streamAzureTTS(sentence.chinese, gen);
        }} catch (err) {{
          console.warn('Azure TTS synthesis failed, fallback to local Web Speech:', err);
          if (gen === this.activeGeneration) {{
            this.playWebSpeechFallback(sentence.chinese);
          }}
        }}
      }}

      streamAzureTTS(text, generation) {{
        return new Promise((resolve, reject) => {{
          const connectionId = generateUuid().replace(/-/g, '');
          const reqId = generateUuid().replace(/-/g, '');
          const wsUrl = `wss://${{AZURE_REGION}}.tts.speech.microsoft.com/cognitiveservices/websocket/v1?Ocp-Apim-Subscription-Key=${{AZURE_KEY}}&X-ConnectionId=${{connectionId}}`;

          const ws = new WebSocket(wsUrl);
          ws.binaryType = 'arraybuffer';
          this.currentWs = ws;

          const audioChunks = [];
          const boundaries = [];
          const now = new Date().toISOString();

          ws.onopen = () => {{
            if (generation !== this.activeGeneration) {{
              ws.close();
              return;
            }}

            // 1. speech.config
            const cfg = JSON.stringify({{
              context: {{
                system: {{ name: 'SpeechSDK', version: '1.30.0', build: 'JavaScript', lang: 'JavaScript' }},
                os: {{ platform: 'Browser', name: 'WebAudiobook' }}
              }}
            }});
            ws.send(`Path: speech.config\\r\\nX-Timestamp: ${{now}}\\r\\nContent-Type: application/json; charset=utf-8\\r\\n\\r\\n${{cfg}}`);

            // 2. synthesis.context
            const ctx = JSON.stringify({{
              synthesis: {{
                audio: {{
                  outputFormat: 'audio-24khz-48kbitrate-mono-mp3',
                  metadataOptions: {{ bookmarkEnabled: true, wordBoundaryEnabled: true, sentenceBoundaryEnabled: true }}
                }}
              }}
            }});
            ws.send(`Path: synthesis.context\\r\\nX-RequestId: ${{reqId}}\\r\\nX-Timestamp: ${{now}}\\r\\nContent-Type: application/json; charset=utf-8\\r\\n\\r\\n${{ctx}}`);

            // 3. ssml
            const speedPct = Math.round((state.playbackSpeed - 1.0) * 100);
            const rateStr = speedPct >= 0 ? `+${{speedPct}}%` : `${{speedPct}}%`;
            const escapedText = text.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
            const ssml = `<speak version="1.0" xmlns="http://www.w3.org/2001/10/synthesis" xml:lang="zh-CN"><voice name="${{state.currentVoice}}"><prosody rate="${{rateStr}}">${{escapedText}}</prosody></voice></speak>`;
            ws.send(`Path: ssml\\r\\nX-RequestId: ${{reqId}}\\r\\nX-Timestamp: ${{now}}\\r\\nContent-Type: application/ssml+xml\\r\\n\\r\\n${{ssml}}`);
          }};

          ws.onmessage = (evt) => {{
            if (generation !== this.activeGeneration) {{
              ws.close();
              return;
            }}

            if (typeof evt.data === 'string') {{
              if (evt.data.includes('audio.metadata')) {{
                try {{
                  const body = evt.data.split('\\r\\n\\r\\n')[1];
                  const data = JSON.parse(body);
                  if (data && data.Metadata) {{
                    for (const m of data.Metadata) {{
                      const bType = m.Type || (m.Data && (m.Data.BoundaryType || (m.Data.text && m.Data.text.BoundaryType)));
                      if (bType === 'WordBoundary') {{
                        boundaries.push(m.Data);
                      }}
                    }}
                  }}
                }} catch (e) {{
                  console.error('Metadata parse error:', e);
                }}
              }} else if (evt.data.includes('turn.end')) {{
                ws.close();
                if (audioChunks.length === 0) {{
                  reject(new Error('No audio chunks received'));
                  return;
                }}

                state.activeTimings = buildSpokenCharTimings(text, boundaries);

                const blob = new Blob(audioChunks, {{ type: 'audio/mp3' }});
                if (this.currentAudioUrl) URL.revokeObjectURL(this.currentAudioUrl);
                this.currentAudioUrl = URL.createObjectURL(blob);

                el.htmlAudio.src = this.currentAudioUrl;
                el.htmlAudio.playbackRate = state.playbackSpeed;
                el.htmlAudio.play().then(resolve).catch(reject);
              }}
            }} else if (evt.data instanceof ArrayBuffer) {{
              const view = new DataView(evt.data);
              const headerLen = view.getUint16(0, false);
              const audioPayload = evt.data.slice(2 + headerLen);
              audioChunks.push(audioPayload);
            }}
          }};

          ws.onerror = (err) => {{
            reject(err);
          }};
        }});
      }}

      playWebSpeechFallback(text) {{
        if (!('speechSynthesis' in window)) return;
        window.speechSynthesis.cancel();

        const curText = text || state.currentBook.chapters[state.currentChapterIndex].sentences[state.currentSentenceIndex].chinese;
        const utter = new SpeechSynthesisUtterance(curText);
        utter.lang = 'zh-CN';
        utter.rate = state.playbackSpeed;

        utter.onboundary = (e) => {{
          if (e.name === 'word') {{
            // Approximation for local WebSpeech boundaries
            const charIdx = e.charIndex;
            state.currentSpokenHanziIndex = charIdx;
            updateCharacterHighlights();
          }}
        }};

        utter.onend = () => {{
          onSentenceAudioEnded();
        }};

        window.speechSynthesis.speak(utter);
      }}

      stop() {{
        ++this.activeGeneration;
        if (this.currentWs) {{
          try {{ this.currentWs.close(); }} catch(e) {{}}
          this.currentWs = null;
        }}
        el.htmlAudio.pause();
        el.htmlAudio.currentTime = 0;
        if ('speechSynthesis' in window) {{
          window.speechSynthesis.cancel();
        }}
        state.isPlaying = false;
        state.currentSpokenHanziIndex = -1;
        updateCharacterHighlights();
        updatePlaybackUI();
      }}

      pause() {{
        el.htmlAudio.pause();
        if ('speechSynthesis' in window) {{
          window.speechSynthesis.pause();
        }}
        state.isPlaying = false;
        updatePlaybackUI();
      }}

      resume() {{
        if (el.htmlAudio.src) {{
          el.htmlAudio.play();
          state.isPlaying = true;
          updatePlaybackUI();
        }} else {{
          this.playSentence(state.currentChapterIndex, state.currentSentenceIndex);
        }}
      }}
    }}

    const audioEngine = new AudioEngine();

    // Navigation and Progression
    function onSentenceAudioEnded() {{
      const chapter = state.currentBook.chapters[state.currentChapterIndex];
      if (state.currentSentenceIndex + 1 < chapter.sentences.length) {{
        audioEngine.playSentence(state.currentChapterIndex, state.currentSentenceIndex + 1);
      }} else {{
        // End of chapter
        if (state.stopAtEndOfChapter) {{
          audioEngine.stop();
          state.stopAtEndOfChapter = false;
          el.selectSleep.value = '0';
          return;
        }}
        if (state.currentChapterIndex + 1 < state.currentBook.chapters.length) {{
          selectChapter(state.currentChapterIndex + 1, 0, true);
        }} else {{
          audioEngine.stop();
        }}
      }}
    }}

    function nextSentence() {{
      const chapter = state.currentBook.chapters[state.currentChapterIndex];
      if (state.currentSentenceIndex + 1 < chapter.sentences.length) {{
        audioEngine.playSentence(state.currentChapterIndex, state.currentSentenceIndex + 1);
      }}
    }}

    function prevSentence() {{
      if (state.currentSentenceIndex > 0) {{
        audioEngine.playSentence(state.currentChapterIndex, state.currentSentenceIndex - 1);
      }}
    }}

    function togglePlayPause() {{
      if (state.isPlaying) {{
        audioEngine.pause();
      }} else {{
        audioEngine.resume();
      }}
    }}

    function selectChapter(chapIdx, sentIdx = 0, autoplay = false) {{
      if (chapIdx < 0 || chapIdx >= state.currentBook.chapters.length) return;
      state.currentChapterIndex = chapIdx;
      state.currentSentenceIndex = sentIdx;
      renderCurrentChapter();
      updateChapterListUI();
      updateHeaderAndConsole();

      if (autoplay) {{
        audioEngine.playSentence(chapIdx, sentIdx);
      }} else {{
        audioEngine.stop();
      }}
    }}

    function selectBook(book) {{
      state.currentBook = book;
      state.currentChapterIndex = 0;
      state.currentSentenceIndex = 0;
      audioEngine.stop();
      renderCurrentChapter();
      renderSidebarTabs();
      updateHeaderAndConsole();
    }}

    // Render Methods
    function renderCurrentChapter() {{
      const chapter = state.currentBook.chapters[state.currentChapterIndex];
      if (!chapter) return;

      el.heroBadge.textContent = `Chapter ${{state.currentChapterIndex + 1}} of ${{state.currentBook.chapters.length}}`;
      el.heroTitleZh.textContent = chapter.title || `第 ${{state.currentChapterIndex + 1}} 章`;
      el.heroTitleEn.textContent = chapter.titleEn || '';

      el.sentencesStream.innerHTML = '';

      chapter.sentences.forEach((s, idx) => {{
        const card = document.createElement('div');
        card.className = `sentence-card ${{idx === state.currentSentenceIndex ? 'active' : ''}}`;
        card.dataset.sentenceIndex = idx;

        // Meta header
        const meta = document.createElement('div');
        meta.className = 'sentence-meta';
        meta.innerHTML = `
          <span>SENTENCE ${{String(idx + 1).padStart(2, '0')}}</span>
          <div class="playing-indicator">
            <span></span><span></span><span></span>
          </div>
        `;
        card.appendChild(meta);

        // Chinese Line with Ruby Tokens
        const chineseLine = document.createElement('div');
        chineseLine.className = 'chinese-line';

        const tokens = parseRubyTokens(s.chinese, s.pinyin);
        tokens.forEach(t => {{
          if (t.isPunctuation) {{
            const punct = document.createElement('span');
            punct.className = 'punct-char';
            punct.textContent = t.char;
            chineseLine.appendChild(punct);
          }} else {{
            const ruby = document.createElement('div');
            ruby.className = 'ruby-char';
            ruby.dataset.char = t.char;
            ruby.dataset.pinyin = t.pinyin;
            ruby.dataset.hanziIndex = t.hanziIndex;
            ruby.dataset.sentenceIndex = idx;

            const pinyinEl = document.createElement('span');
            pinyinEl.className = 'pinyin';
            pinyinEl.textContent = t.pinyin;

            const hanziEl = document.createElement('span');
            hanziEl.className = 'hanzi';
            hanziEl.textContent = t.char;

            ruby.appendChild(pinyinEl);
            ruby.appendChild(hanziEl);

            ruby.addEventListener('click', (e) => {{
              e.stopPropagation();
              openQuickLook(t.char, t.pinyin, ruby);
            }});

            chineseLine.appendChild(ruby);
          }}
        }});

        card.appendChild(chineseLine);

        // English Translation Line
        if (s.english) {{
          const eng = document.createElement('div');
          eng.className = 'english-line';
          eng.textContent = s.english;
          card.appendChild(eng);
        }}

        // Card Click -> Play
        card.addEventListener('click', () => {{
          audioEngine.playSentence(state.currentChapterIndex, idx);
        }});

        el.sentencesStream.appendChild(card);
      }});

      updateScrubber();
    }}

    function renderActiveSentenceCard() {{
      const cards = el.sentencesStream.querySelectorAll('.sentence-card');
      cards.forEach((c, idx) => {{
        if (idx === state.currentSentenceIndex) {{
          c.classList.add('active');
          if (state.autoScroll) {{
            c.scrollIntoView({{ behavior: 'smooth', block: 'center' }});
          }}
        }} else {{
          c.classList.remove('active');
        }}
      }});
      updateScrubber();
    }}

    function updateCharacterHighlights() {{
      const activeCard = el.sentencesStream.querySelector(`.sentence-card[data-sentence-index="${{state.currentSentenceIndex}}"]`);
      if (!activeCard) return;

      const rubyChars = activeCard.querySelectorAll('.ruby-char');
      rubyChars.forEach(r => {{
        const hIdx = parseInt(r.dataset.hanziIndex, 10);
        if (hIdx === state.currentSpokenHanziIndex) {{
          r.classList.add('is-spoken');
        }} else {{
          r.classList.remove('is-spoken');
        }}
      }});
    }}

    function updatePlaybackUI() {{
      el.playIcon.textContent = state.isPlaying ? '⏸' : '▶';
      el.btnPlayPause.title = state.isPlaying ? 'Pause (Space)' : 'Play (Space)';

      const chapter = state.currentBook.chapters[state.currentChapterIndex];
      const maxSent = chapter ? chapter.sentences.length : 0;
      el.btnPrevSentence.disabled = state.currentSentenceIndex <= 0;
      el.btnNextSentence.disabled = state.currentSentenceIndex >= maxSent - 1;
    }}

    function updateHeaderAndConsole() {{
      const chapter = state.currentBook.chapters[state.currentChapterIndex];
      const chapterTitle = chapter ? (chapter.title || `Chapter ${{state.currentChapterIndex + 1}}`) : '';

      el.headerBookEmoji.textContent = state.currentBook.coverEmoji || '📖';
      el.headerBookTitle.textContent = state.currentBook.title;
      el.headerChapterIndex.textContent = `第 ${{state.currentChapterIndex + 1}} 章`;

      el.consoleBookTitle.textContent = state.currentBook.title;
      el.consoleChapterTitle.textContent = `第 ${{state.currentChapterIndex + 1}} 章 · ${{chapterTitle}}`;
      updateScrubber();
    }}

    function updateScrubber() {{
      const chapter = state.currentBook.chapters[state.currentChapterIndex];
      const count = chapter ? chapter.sentences.length : 1;
      const current = state.currentSentenceIndex + 1;
      const pct = Math.round((current / count) * 100);

      el.scrubber.value = pct;
      el.scrubberLabel.textContent = `Sentence ${{current}}/${{count}} (${{pct}}%)`;
    }}

    // Sidebar: Tabs & Catalogs
    function renderSidebarTabs() {{
      if (state.currentTab === 'books') {{
        renderBookCatalog();
      }} else {{
        renderChapterList();
      }}
    }}

    function renderBookCatalog() {{
      el.sidebarContent.innerHTML = '';

      const query = (state.searchQuery || '').toLowerCase();
      const booksToDisplay = state.catalog.length > 0 ? state.catalog : Object.values(EMBEDDED_BOOKS);

      const filtered = booksToDisplay.filter(b => {{
        return (b.title && b.title.toLowerCase().includes(query)) ||
               (b.titleEn && b.titleEn.toLowerCase().includes(query)) ||
               (b.author && b.author.toLowerCase().includes(query));
      }});

      filtered.forEach(b => {{
        const card = document.createElement('div');
        card.className = `book-card ${{state.currentBook.id === b.id ? 'active' : ''}}`;
        card.innerHTML = `
          <div class="book-emoji">${{b.coverEmoji || '📖'}}</div>
          <div class="book-info">
            <div class="book-title">${{b.title}}</div>
            <div class="book-title-en">${{b.titleEn || ''}}</div>
            <div class="book-meta">
              <span class="badge-hsk">HSK ${{b.hskLevel || 4}}</span>
              <span class="badge-dynasty">${{b.dynastyOrEra || ''}} · ${{b.totalChapters || (b.chapters ? b.chapters.length : '')}} ch</span>
            </div>
          </div>
        `;

        card.addEventListener('click', async () => {{
          if (b.chapters) {{
            selectBook(b);
          }} else {{
            // Fetch book chapters from server
            try {{
              const resp = await fetch(resolveAssetPath(`/assets/data/books/${{b.id}}.json`));
              if (resp.ok) {{
                const chaps = await resp.json();
                b.chapters = chaps;
                selectBook(b);
              }}
            }} catch (err) {{
              console.error('Failed to load book JSON:', err);
            }}
          }}
        }});

        el.sidebarContent.appendChild(card);
      }});

      // Drag & Drop Box for Custom Book JSON
      const dropzone = document.createElement('div');
      dropzone.className = 'custom-book-dropzone';
      dropzone.innerHTML = `
        <div style="font-size:24px; margin-bottom:6px;">📂</div>
        <strong style="font-size:13px;">Load Custom Book JSON</strong>
        <p style="font-size:11px; color:var(--text-tertiary); margin-top:4px;">Drag & drop any book JSON file here or click to browse</p>
        <input type="file" id="fileInputCustom" accept=".json" style="display:none">
      `;

      const fileInput = dropzone.querySelector('#fileInputCustom');
      dropzone.addEventListener('click', () => fileInput.click());
      dropzone.addEventListener('dragover', (e) => {{ e.preventDefault(); dropzone.style.borderColor = 'var(--accent-gold)'; }});
      dropzone.addEventListener('dragleave', () => {{ dropzone.style.borderColor = 'var(--border-subtle)'; }});
      dropzone.addEventListener('drop', (e) => {{
        e.preventDefault();
        if (e.dataTransfer.files.length > 0) {{
          handleCustomFile(e.dataTransfer.files[0]);
        }}
      }});

      fileInput.addEventListener('change', (e) => {{
        if (e.target.files.length > 0) {{
          handleCustomFile(e.target.files[0]);
        }}
      }});

      el.sidebarContent.appendChild(dropzone);
    }}

    function handleCustomFile(file) {{
      const reader = new FileReader();
      reader.onload = (e) => {{
        try {{
          const chapters = JSON.parse(e.target.result);
          const customBook = {{
            id: 'custom_' + Date.now(),
            title: file.name.replace('.json', ''),
            titleEn: 'Custom Uploaded Book',
            coverEmoji: '📑',
            hskLevel: 4,
            dynastyOrEra: 'Custom',
            chapters: chapters
          }};
          selectBook(customBook);
        }} catch(err) {{
          alert('Error parsing JSON file: ' + err.message);
        }}
      }};
      reader.readAsText(file, 'utf-8');
    }}

    function renderChapterList() {{
      el.sidebarContent.innerHTML = '';
      if (!state.currentBook.chapters) return;

      state.currentBook.chapters.forEach((chap, idx) => {{
        const item = document.createElement('div');
        item.className = `chapter-item ${{idx === state.currentChapterIndex ? 'active' : ''}}`;
        item.innerHTML = `
          <span>第 ${{idx + 1}} 章 · ${{chap.title || chap.titleEn}}</span>
          <span style="font-size:11px; color:var(--text-tertiary);">${{chap.sentences.length}} sentences</span>
        `;
        item.addEventListener('click', () => {{
          selectChapter(idx, 0, false);
        }});
        el.sidebarContent.appendChild(item);
      }});
    }}

    function updateChapterListUI() {{
      if (state.currentTab === 'chapters') {{
        renderChapterList();
      }}
    }}

    // QuickLook Dictionary Popover
    function openQuickLook(char, pinyin, anchorEl) {{
      // Deselect existing
      document.querySelectorAll('.ruby-char.is-selected').forEach(c => c.classList.remove('is-selected'));
      anchorEl.classList.add('is-selected');

      el.qlChar.textContent = char;
      el.qlPinyin.textContent = pinyin || '';

      const dictEntry = state.dictionary[char];
      if (dictEntry) {{
        el.qlHsk.textContent = `HSK ${{dictEntry.level || 1}}`;
        el.qlDef.textContent = dictEntry.en || 'Definition available.';
      }} else {{
        el.qlHsk.textContent = 'Character';
        el.qlDef.textContent = 'Classical character used in context.';
      }}

      // Positioning near anchorEl
      const rect = anchorEl.getBoundingClientRect();
      const popoverWidth = 320;
      let left = rect.left + window.scrollX - (popoverWidth / 2) + (rect.width / 2);
      let top = rect.bottom + window.scrollY + 10;

      // Screen boundary check
      if (left < 10) left = 10;
      if (left + popoverWidth > window.innerWidth - 20) left = window.innerWidth - popoverWidth - 20;

      el.quicklookPopover.style.left = `${{left}}px`;
      el.quicklookPopover.style.top = `${{top}}px`;
      el.quicklookPopover.style.display = 'block';

      // Speak Single Char
      el.qlSpeakBtn.onclick = () => {{
        if ('speechSynthesis' in window) {{
          const utter = new SpeechSynthesisUtterance(char);
          utter.lang = 'zh-CN';
          utter.rate = 0.8;
          window.speechSynthesis.speak(utter);
        }}
      }};

      // Copy Char
      el.qlCopyBtn.onclick = () => {{
        navigator.clipboard.writeText(char).then(() => {{
          el.qlCopyBtn.textContent = '✅ Copied!';
          setTimeout(() => el.qlCopyBtn.textContent = '📋 Copy Char', 1500);
        }});
      }};
    }}

    function closeQuickLook() {{
      el.quicklookPopover.style.display = 'none';
      document.querySelectorAll('.ruby-char.is-selected').forEach(c => c.classList.remove('is-selected'));
    }}

    // Global Event Listeners & Shortcuts
    function initListeners() {{
      // Sidebar Toggle
      el.btnToggleSidebar.addEventListener('click', () => {{
        el.sidebar.classList.toggle('collapsed');
      }});

      // Sidebar Tabs
      el.tabBooks.addEventListener('click', () => {{
        state.currentTab = 'books';
        el.tabBooks.classList.add('active');
        el.tabChapters.classList.remove('active');
        renderBookCatalog();
      }});

      el.tabChapters.addEventListener('click', () => {{
        state.currentTab = 'chapters';
        el.tabChapters.classList.add('active');
        el.tabBooks.classList.remove('active');
        renderChapterList();
      }});

      // Search Books
      el.searchBooks.addEventListener('input', (e) => {{
        state.searchQuery = e.target.value;
        if (state.currentTab === 'books') {{
          renderBookCatalog();
        }}
      }});

      // Header Toolbar Toggles
      el.btnTogglePinyin.addEventListener('click', () => {{
        state.pinyinVisible = !state.pinyinVisible;
        el.btnTogglePinyin.classList.toggle('active', state.pinyinVisible);
        document.body.classList.toggle('hide-pinyin', !state.pinyinVisible);
      }});

      el.btnToggleTrans.addEventListener('click', () => {{
        state.translationsVisible = !state.translationsVisible;
        el.btnToggleTrans.classList.toggle('active', state.translationsVisible);
        document.body.classList.toggle('hide-translations', !state.translationsVisible);
      }});

      el.btnToggleAutoScroll.addEventListener('click', () => {{
        state.autoScroll = !state.autoScroll;
        el.btnToggleAutoScroll.classList.toggle('active', state.autoScroll);
      }});

      // Font Size Controls
      el.btnFontMinus.addEventListener('click', () => {{
        state.baseFontSize = Math.max(16, state.baseFontSize - 2);
        document.documentElement.style.setProperty('--base-font-size', `${{state.baseFontSize}}px`);
      }});

      el.btnFontPlus.addEventListener('click', () => {{
        state.baseFontSize = Math.min(36, state.baseFontSize + 2);
        document.documentElement.style.setProperty('--base-font-size', `${{state.baseFontSize}}px`);
      }});

      // Theme Toggle
      el.btnThemeToggle.addEventListener('click', () => {{
        state.theme = state.theme === 'light' ? 'dark' : 'light';
        document.body.dataset.theme = state.theme;
      }});

      // Playback Controls
      el.btnPlayPause.addEventListener('click', togglePlayPause);
      el.btnPrevSentence.addEventListener('click', prevSentence);
      el.btnNextSentence.addEventListener('click', nextSentence);

      // Speed Preset Cycle
      const speeds = [0.75, 1.0, 1.25, 1.5, 2.0];
      el.btnSpeed.addEventListener('click', () => {{
        const nextIdx = (speeds.indexOf(state.playbackSpeed) + 1) % speeds.length;
        state.playbackSpeed = speeds[nextIdx];
        el.btnSpeed.textContent = `${{state.playbackSpeed}}x`;
        el.htmlAudio.playbackRate = state.playbackSpeed;
      }});

      // Voice Selector
      el.selectVoice.addEventListener('change', (e) => {{
        state.currentVoice = e.target.value;
        if (state.isPlaying) {{
          audioEngine.playSentence(state.currentChapterIndex, state.currentSentenceIndex);
        }}
      }});

      // Sleep Timer Selector
      el.selectSleep.addEventListener('change', (e) => {{
        const val = e.target.value;
        if (val === '0') {{
          state.sleepSecondsRemaining = null;
          state.stopAtEndOfChapter = false;
        }} else if (val === 'chapter') {{
          state.stopAtEndOfChapter = true;
          state.sleepSecondsRemaining = null;
        }} else {{
          state.sleepSecondsRemaining = parseInt(val, 10) * 60;
          state.stopAtEndOfChapter = false;
        }}
      }});

      // Sleep Timer Interval
      setInterval(() => {{
        if (state.sleepSecondsRemaining !== null && state.sleepSecondsRemaining > 0) {{
          state.sleepSecondsRemaining--;
          if (state.sleepSecondsRemaining <= 0) {{
            audioEngine.stop();
            state.sleepSecondsRemaining = null;
            el.selectSleep.value = '0';
          }}
        }}
      }}, 1000);

      // Scrubber Seek
      el.scrubber.addEventListener('input', (e) => {{
        const chapter = state.currentBook.chapters[state.currentChapterIndex];
        if (!chapter) return;
        const targetIdx = Math.floor((e.target.value / 100) * chapter.sentences.length);
        const clamped = Math.min(targetIdx, chapter.sentences.length - 1);
        audioEngine.playSentence(state.currentChapterIndex, clamped);
      }});

      // QuickLook Close
      el.qlCloseBtn.addEventListener('click', closeQuickLook);
      document.addEventListener('click', (e) => {{
        if (!el.quicklookPopover.contains(e.target) && !e.target.closest('.ruby-char')) {{
          closeQuickLook();
        }}
      }});

      // Keyboard Shortcuts Dialog
      el.btnShortcuts.addEventListener('click', () => el.shortcutsModal.style.display = 'flex');
      el.closeShortcutsModal.addEventListener('click', () => el.shortcutsModal.style.display = 'none');
      el.shortcutsModal.addEventListener('click', (e) => {{
        if (e.target === el.shortcutsModal) el.shortcutsModal.style.display = 'none';
      }});

      // Global Keydown Handler
      document.addEventListener('keydown', (e) => {{
        if (e.target.tagName === 'INPUT' || e.target.tagName === 'SELECT') return;

        switch (e.code) {{
          case 'Space':
            e.preventDefault();
            togglePlayPause();
            break;
          case 'ArrowLeft':
            e.preventDefault();
            prevSentence();
            break;
          case 'ArrowRight':
            e.preventDefault();
            nextSentence();
            break;
          case 'ArrowUp':
            e.preventDefault();
            if (state.currentChapterIndex > 0) selectChapter(state.currentChapterIndex - 1, 0, state.isPlaying);
            break;
          case 'ArrowDown':
            e.preventDefault();
            if (state.currentChapterIndex + 1 < state.currentBook.chapters.length) selectChapter(state.currentChapterIndex + 1, 0, state.isPlaying);
            break;
          case 'KeyP':
            el.btnTogglePinyin.click();
            break;
          case 'KeyT':
            el.btnToggleTrans.click();
            break;
          case 'KeyD':
            el.btnThemeToggle.click();
            break;
          case 'KeyL':
            el.btnToggleSidebar.click();
            break;
          case 'Escape':
            closeQuickLook();
            el.shortcutsModal.style.display = 'none';
            break;
        }}
      }});
    }}

    // Initial Data Fetcher for Server Mode
    async function loadServerAssets() {{
      try {{
        // Load Grand Library Catalog (86 books)
        const catResp = await fetch(resolveAssetPath('/assets/data/grand_library_catalog.json'));
        if (catResp.ok) {{
          state.catalog = await catResp.json();
          renderBookCatalog();
        }}
      }} catch (e) {{
        console.log('Running in offline/embedded mode. Embedded catalog loaded.');
      }}

      try {{
        // Load Core Dictionary Master
        const dictResp = await fetch(resolveAssetPath('/assets/data/l10n/core_dictionary_master.json'));
        if (dictResp.ok) {{
          state.dictionary = await dictResp.json();
          console.log('Dictionary loaded successfully with', Object.keys(state.dictionary).length, 'entries');
        }}
      }} catch (e) {{
        console.log('Dictionary running with contextual fallback.');
      }}
    }}

    // Bootstrap
    function init() {{
      document.documentElement.style.setProperty('--base-font-size', `${{state.baseFontSize}}px`);
      initListeners();
      renderCurrentChapter();
      renderSidebarTabs();
      updateHeaderAndConsole();
      updatePlaybackUI();
      loadServerAssets();
    }}

    window.addEventListener('DOMContentLoaded', init);
  </script>
</body>
</html>
'''

    out_path = os.path.join(root, 'web_audiobook', 'index.html')
    with open(out_path, 'w', encoding='utf-8') as f:
        f.write(html_template)

    print(f"Successfully built web_audiobook/index.html ({len(html_template)} bytes)")

if __name__ == '__main__':
    main()
