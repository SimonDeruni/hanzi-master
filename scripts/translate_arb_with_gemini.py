"""
================================================================================
scripts/translate_arb_with_gemini.py
Translates all missing ARB keys using the Gemini API (gemini-3.6-flash).

HOW TO RUN:
  1. Ensure your GEMINI_API_KEY is in .env (already done)
  2. Run from project root:
       python scripts/translate_arb_with_gemini.py

FREE TIER LIMITS (gemini-3.6-flash):
  15 requests/min, 1M tokens/day.
  This script batches 25 keys per request and auto-throttles.
================================================================================
"""
import json, os, re, sys, time, urllib.request, urllib.error

sys.stdout.reconfigure(encoding="utf-8")

# -- Load .env -----------------------------------------------------------------
def load_dotenv(path=".env"):
    if os.path.exists(path):
        with open(path, "r", encoding="utf-8") as f:
            for line in f:
                line = line.strip()
                if line and not line.startswith("#") and "=" in line:
                    k, _, v = line.partition("=")
                    os.environ.setdefault(k.strip(), v.strip())

load_dotenv()

# -- Config --------------------------------------------------------------------
GEMINI_API_KEY = os.environ.get("GEMINI_API_KEY", "")
GEMINI_MODEL   = "gemini-3.6-flash"
L10N_DIR       = "lib/l10n"
EN_ARB_PATH    = os.path.join(L10N_DIR, "app_en.arb")
BATCH_SIZE     = 25
RPM_LIMIT      = 12   # conservative, free tier is 15/min
SECONDS_PER_REQ = 60 / RPM_LIMIT

TARGET_LANGS = {
    "ar": "Arabic",
    "de": "German",
    "es": "Spanish",
    "fr": "French",
    "hi": "Hindi",
    "id": "Indonesian",
    "it": "Italian",
    "ja": "Japanese",
    "ko": "Korean",
    "pt": "Portuguese (Brazil)",
    "ru": "Russian",
    "th": "Thai",
    "vi": "Vietnamese",
}

APP_CONTEXT = """You are translating UI strings for "Hanzi Master" (also called SinoSpark),
a premium mobile app for learning Mandarin Chinese. The app features:
  - Flashcard decks, stroke-order drawing, spaced repetition (SRS)
  - A Grand Library of classical Chinese books and poetry
  - A live web overlay for reading Chinese websites in real time
  - HSK vocabulary (levels 1-6+), cultural context cards, AI tutoring

Translation rules:
  1. Keep translations SHORT and NATURAL. These are UI labels (buttons, tabs, tooltips,
     section headers). Match the length of the English as closely as possible.
  2. __PH0__, __PH1__, etc. are variable placeholders -- keep them EXACTLY as-is.
  3. Use a warm, calm, educational tone appropriate for a premium learning app.
  4. Technical terms like HSK, Pinyin, Hanzi, Stroke, Tone: use the standard
     target-language educational term if one exists, otherwise keep the English.
  5. Do NOT add extra punctuation, quotes, or explanations.
  6. Return ONLY a valid JSON object. No markdown fences, no extra text.
"""

# -- Helpers -------------------------------------------------------------------
def protect_placeholders(text):
    phs = re.findall(r"\{[a-zA-Z0-9_]+\}", text)
    tmap = {}
    for i, ph in enumerate(phs):
        token = f"__PH{i}__"
        tmap[token] = ph
        text = text.replace(ph, token)
    return text, tmap

def restore_placeholders(text, tmap):
    for token, ph in tmap.items():
        text = re.sub(re.escape(token), ph, text, flags=re.IGNORECASE)
    for ph in tmap.values():
        if ph not in text:
            text += f" {ph}"
    return text

def build_prompt(lang_name, batch):
    items = json.dumps({k: v for k, v in batch}, ensure_ascii=False, indent=2)
    return f"""{APP_CONTEXT}
Translate the following English UI strings into {lang_name}.

English strings to translate:
{items}
"""

def call_gemini(prompt, retries=5):
    url = (
        f"https://generativelanguage.googleapis.com/v1beta/models/"
        f"{GEMINI_MODEL}:generateContent?key={GEMINI_API_KEY}"
    )
    payload = json.dumps({
        "contents": [{"parts": [{"text": prompt}]}],
        "generationConfig": {
            "temperature": 0.1,
            "maxOutputTokens": 4096,
            "responseMimeType": "application/json",
        }
    }).encode("utf-8")

    req = urllib.request.Request(
        url, data=payload,
        headers={"Content-Type": "application/json"},
        method="POST"
    )

    for attempt in range(retries):
        try:
            with urllib.request.urlopen(req, timeout=60) as resp:
                data = json.loads(resp.read().decode("utf-8"))
                # Handle thinking models -- content may be empty if thought tokens maxed out
                candidates = data.get("candidates", [])
                if not candidates:
                    print(f"      No candidates in response, attempt {attempt+1}")
                    time.sleep(3)
                    continue
                parts = candidates[0].get("content", {}).get("parts", [])
                if not parts:
                    print(f"      Empty parts (thinking model exhausted tokens?), attempt {attempt+1}")
                    time.sleep(3)
                    continue
                text = parts[0].get("text", "").strip()
                # Strip any accidental markdown fences
                text = re.sub(r"^```(?:json)?\s*", "", text)
                text = re.sub(r"\s*```$", "", text)
                return json.loads(text)
        except urllib.error.HTTPError as e:
            body = e.read().decode("utf-8", errors="ignore")
            if e.code == 429:
                wait = 65 * (attempt + 1)
                print(f"      Rate limited (429), waiting {wait}s...")
                time.sleep(wait)
            elif e.code in (400, 403):
                print(f"      Fatal HTTP {e.code}: {body[:300]}")
                return {}
            else:
                print(f"      HTTP {e.code}: {body[:150]}, retrying...")
                time.sleep(5 * (attempt + 1))
        except json.JSONDecodeError as je:
            print(f"      JSON parse error attempt {attempt+1}: {je}")
            time.sleep(3)
        except Exception as ex:
            print(f"      Error attempt {attempt+1}: {ex}")
            time.sleep(5 * (attempt + 1))
    return {}

# -- Main ----------------------------------------------------------------------
def main():
    if not GEMINI_API_KEY:
        print("ERROR: GEMINI_API_KEY not set. Add it to your .env file.")
        sys.exit(1)

    print("Verifying Gemini API key with gemini-3.6-flash...")
    test = call_gemini('Translate "Start" to French. Return JSON: {"start": "<translation>"}')
    if not test:
        print("ERROR: API verification failed. Check your key.")
        sys.exit(1)
    print(f"  API OK! Test: {test}\n")

    with open(EN_ARB_PATH, "r", encoding="utf-8") as f:
        en_arb = json.load(f)

    en_keys = {k: v for k, v in en_arb.items() if not k.startswith("@") and isinstance(v, str)}
    print(f"Loaded {len(en_keys):,} English keys from app_en.arb\n")

    grand_total = 0
    start_time = time.time()

    for lang_code, lang_name in TARGET_LANGS.items():
        arb_file = os.path.join(L10N_DIR, f"app_{lang_code}.arb")
        if not os.path.exists(arb_file):
            print(f"WARNING: {arb_file} not found, skipping.")
            continue

        with open(arb_file, "r", encoding="utf-8") as f:
            target_arb = json.load(f)

        missing = [(k, en_keys[k]) for k in en_keys if k not in target_arb]
        print(f"[{lang_code.upper()}] {lang_name} -- {len(missing)} keys to translate")

        if not missing:
            print("  Already 100% translated!\n")
            continue

        # Protect placeholders
        protected = []
        token_maps = {}
        for k, v in missing:
            pv, tmap = protect_placeholders(v)
            protected.append((k, pv))
            token_maps[k] = tmap

        batches = [protected[i:i + BATCH_SIZE] for i in range(0, len(protected), BATCH_SIZE)]
        translated_count = 0

        for b_idx, batch in enumerate(batches):
            prompt = build_prompt(lang_name, batch)
            t0 = time.time()
            result = call_gemini(prompt)
            elapsed = time.time() - t0

            for k, _ in batch:
                if k in result:
                    val = str(result[k])
                    target_arb[k] = restore_placeholders(val, token_maps[k])
                    translated_count += 1
                else:
                    # Fallback: keep English
                    target_arb[k] = en_keys[k]

            pct = (b_idx + 1) / len(batches) * 100
            print(
                f"  Batch {b_idx+1}/{len(batches)} ({pct:.0f}%) "
                f"-- {translated_count}/{len(missing)} [{elapsed:.1f}s]",
                flush=True
            )

            # Save incrementally every 5 batches (crash-safe)
            if (b_idx + 1) % 5 == 0 or b_idx == len(batches) - 1:
                with open(arb_file, "w", encoding="utf-8") as f:
                    json.dump(target_arb, f, ensure_ascii=False, indent=2)
                    f.write("\n")

            sleep_needed = SECONDS_PER_REQ - elapsed
            if sleep_needed > 0:
                time.sleep(sleep_needed)

        # Final save
        with open(arb_file, "w", encoding="utf-8") as f:
            json.dump(target_arb, f, ensure_ascii=False, indent=2)
            f.write("\n")

        grand_total += translated_count
        elapsed_total = time.time() - start_time
        print(f"  Saved {translated_count} translations to app_{lang_code}.arb "
              f"[{elapsed_total:.0f}s total]\n")

    print("=" * 65)
    print(f"DONE! {grand_total:,} total translations written.")
    print("Run: flutter gen-l10n   to regenerate Dart localizations.")
    print("=" * 65)

if __name__ == "__main__":
    main()
