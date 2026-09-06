import os
import sys
import json
import time
import urllib.request
import urllib.error

sys.stdout.reconfigure(encoding='utf-8')

# Target languages (13 non-English + English is source)
TARGET_LOCALES = {
    'fr': 'French',
    'es': 'Spanish',
    'de': 'German',
    'it': 'Italian',
    'pt': 'Portuguese',
    'ru': 'Russian',
    'ar': 'Arabic',
    'hi': 'Hindi',
    'ja': 'Japanese',
    'ko': 'Korean',
    'vi': 'Vietnamese',
    'th': 'Thai',
    'id': 'Indonesian',
}

SOURCE_STRINGS = {
    "beginFirstLesson": "Begin First Lesson",
    "onboardingLessonProgress": "YOUR FIRST LESSON  •  {current} OF {total}",
    "onboardingListenInstruction": "First, hear one of the best-known lines in Chinese literature. No memorizing yet.",
    "onboardingFromGrandLibrary": "From the Grand Library",
    "onboardingArtOfWarTitleAuthor": "The Art of War · Sun Tzu",
    "onboardingArtOfWarChapter": "谋攻篇 · Chapter 3",
    "onboardingClassicLineLabel": "A CLASSIC LINE",
    "onboardingArtOfWarTranslation": "“Know the enemy and know yourself, and you need not fear the result of a hundred battles.”",
    "onboardingNoticeMeaning": "Know the enemy and know yourself,",
    "onboardingShadowMeaning": "You will not be imperiled in a hundred battles.",
    "onboardingPracticeThisLabel": "YOU’LL PRACTICE THIS",
    "onboardingFromArtOfWarLabel": "FROM THE ART OF WAR",
    "onboardingYourPronunciationLabel": "YOUR PRONUNCIATION",
    "onboardingTapACharacter": "Tap a character",
    "onboardingWordAndPinyin": "{word} · {pinyin}",
    "onboardingToneMatched": "Matched",
    "onboardingCompareTones": "Compare tones",
    "onboardingToneOneHigh": "tone 1 · high",
    "onboardingToneTwoRising": "tone 2 · rising",
    "onboardingToneThreeDipping": "tone 3 · dipping",
    "onboardingToneFourFalling": "tone 4 · falling",
    "onboardingToneNotDetected": "not detected",
    "onboardingFeedbackGreatThirdTone": "Great dipping third tone.",
    "onboardingFeedbackFourthToneFall": "Let the fourth tone fall firmly and quickly.",
    "onboardingFeedbackClearFourthTone": "Clear falling fourth tone.",
    "onboardingFeedbackStrongFourthTone": "Strong falling fourth tone.",
    "onboardingTraceInstruction": "Trace {character} ({pinyin}, “{meaning}”). Follow the faint stroke guide.",
    "youActualTargetExpected": "You: {actual}  ·  Target: {expected}",
    "billingDays": "{count, plural, =1{1 day} other{{count} days}}",
    "billingWeeks": "{count, plural, =1{1 week} other{{count} weeks}}",
    "billingMonths": "{count, plural, =1{1 month} other{{count} months}}",
    "billingYears": "{count, plural, =1{1 year} other{{count} years}}",
    "startPeriodFreeTrial": "Start {period} free trial",
    "subscribeForPricePeriod": "Subscribe for {price} / {period}",
    "eligibleTrialRenewalNotice": "Your selected StoreKit product includes an eligible free trial. After the trial, it renews for {price} per {period} unless canceled.",
    "pricePerPeriod": "{price} / {period}",
    "learn": "Learn"
}

# ARB Metadata for app_en.arb
METADATA = {
    "@beginFirstLesson": {
        "description": "Button to launch the first mini lesson from onboarding calibration"
    },
    "@onboardingLessonProgress": {
        "description": "Progress header in onboarding mini lesson",
        "placeholders": {
            "current": {"type": "Object"},
            "total": {"type": "Object"}
        }
    },
    "@onboardingListenInstruction": {
        "description": "Instruction for step 0 listening in onboarding mini lesson"
    },
    "@onboardingFromGrandLibrary": {
        "description": "Eyebrow pill for source library excerpt"
    },
    "@onboardingArtOfWarTitleAuthor": {
        "description": "Book title and author for Sun Tzu Art of War excerpt"
    },
    "@onboardingArtOfWarChapter": {
        "description": "Chapter subtitle for Art of War excerpt"
    },
    "@onboardingClassicLineLabel": {
        "description": "Passage eyebrow tag in mini lesson"
    },
    "@onboardingArtOfWarTranslation": {
        "description": "Translation of the famous Art of War proverb"
    },
    "@onboardingNoticeMeaning": {
        "description": "Meaning of the first clause in Art of War excerpt"
    },
    "@onboardingShadowMeaning": {
        "description": "Meaning of the second clause in Art of War excerpt"
    },
    "@onboardingPracticeThisLabel": {
        "description": "Target practice pill in mini lesson"
    },
    "@onboardingFromArtOfWarLabel": {
        "description": "Attribution badge in shadow step"
    },
    "@onboardingYourPronunciationLabel": {
        "description": "Tone inspector card title"
    },
    "@onboardingTapACharacter": {
        "description": "Tone inspector card hint"
    },
    "@onboardingWordAndPinyin": {
        "description": "Word and pinyin display in tone inspector",
        "placeholders": {
            "word": {"type": "String"},
            "pinyin": {"type": "String"}
        }
    },
    "@onboardingToneMatched": {
        "description": "Tone match badge"
    },
    "@onboardingCompareTones": {
        "description": "Button to compare tones"
    },
    "@onboardingToneOneHigh": {
        "description": "Tone 1 high description"
    },
    "@onboardingToneTwoRising": {
        "description": "Tone 2 rising description"
    },
    "@onboardingToneThreeDipping": {
        "description": "Tone 3 dipping description"
    },
    "@onboardingToneFourFalling": {
        "description": "Tone 4 falling description"
    },
    "@onboardingToneNotDetected": {
        "description": "Tone not detected label"
    },
    "@onboardingFeedbackGreatThirdTone": {
        "description": "Feedback message for third tone"
    },
    "@onboardingFeedbackFourthToneFall": {
        "description": "Feedback message for fourth tone falling"
    },
    "@onboardingFeedbackClearFourthTone": {
        "description": "Feedback message for clear fourth tone"
    },
    "@onboardingFeedbackStrongFourthTone": {
        "description": "Feedback message for strong fourth tone"
    },
    "@onboardingTraceInstruction": {
        "description": "Instruction for tracing characters in onboarding mini-lesson",
        "placeholders": {
            "character": {"type": "String"},
            "pinyin": {"type": "String"},
            "meaning": {"type": "String"}
        }
    },
    "@youActualTargetExpected": {
        "description": "Comparison between user tone and target tone in onboarding",
        "placeholders": {
            "actual": {"type": "String"},
            "expected": {"type": "String"}
        }
    },
    "@billingDays": {
        "description": "Days duration plural",
        "placeholders": {
            "count": {"type": "int"}
        }
    },
    "@billingWeeks": {
        "description": "Weeks duration plural",
        "placeholders": {
            "count": {"type": "int"}
        }
    },
    "@billingMonths": {
        "description": "Months duration plural",
        "placeholders": {
            "count": {"type": "int"}
        }
    },
    "@billingYears": {
        "description": "Years duration plural",
        "placeholders": {
            "count": {"type": "int"}
        }
    },
    "@startPeriodFreeTrial": {
        "description": "Start free trial with period parameter",
        "placeholders": {
            "period": {"type": "String"}
        }
    },
    "@subscribeForPricePeriod": {
        "description": "Subscribe for price per period",
        "placeholders": {
            "price": {"type": "String"},
            "period": {"type": "String"}
        }
    },
    "@eligibleTrialRenewalNotice": {
        "description": "StoreKit trial terms explanation",
        "placeholders": {
            "price": {"type": "String"},
            "period": {"type": "String"}
        }
    },
    "@pricePerPeriod": {
        "description": "Price per period display",
        "placeholders": {
            "price": {"type": "String"},
            "period": {"type": "String"}
        }
    },
    "@learn": {
        "description": "Learn feature tab or category label"
    }
}

def load_api_keys():
    env_path = '.env'
    keys = {'gemini': None, 'openrouter': None}
    if os.path.exists(env_path):
        with open(env_path, encoding='utf-8') as f:
            for line in f:
                if line.startswith('GEMINI_API_KEY='):
                    keys['gemini'] = line.strip().split('=', 1)[1].strip()
                elif line.startswith('OPENROUTER_API_KEY='):
                    keys['openrouter'] = line.strip().split('=', 1)[1].strip()
    return keys

def call_gemini(keys, target_code, target_name, source_dict):
    gemini_key = keys.get('gemini')
    openrouter_key = keys.get('openrouter')
    
    prompt = f"""You are a master calligraphic translator for "Hanzi Master" (SinoSpark), a premium Chinese learning application inspired by the Zen & Ink aesthetic (warm xuan paper, deep carbon ink, calm, poetic, and professional).

Translate the following JSON dictionary of UI strings from English into {target_name} (language code: "{target_code}").

CRITICAL LOCALIZATION RULES:
1. STRICTLY PRESERVE all ICU placeholders exactly as formatted, including braces:
   - {{character}}, {{pinyin}}, {{meaning}}
   - {{current}}, {{total}}
   - {{word}}
   - {{actual}}, {{expected}}
   - {{price}}, {{period}}, {{count}}
2. For ICU plural strings (billingDays, billingWeeks, billingMonths, billingYears):
   - You MUST adapt the plural cases to the correct ICU grammar of {target_name}.
   - Example for English: "{{count, plural, =1{{1 day}} other{{{{count}} days}}}}"
   - If {target_name} has multiple plural forms (e.g. Russian one/few/many/other, Arabic zero/one/two/few/many/other), provide correct standard ICU cases.
   - If {target_name} does not inflect for plurals (Japanese, Korean, Thai, Vietnamese, Indonesian), use "{{count, plural, other{{...}}}}".
3. Maintain the refined, elegant tone of Chinese scholarship.
4. Return ONLY a valid JSON object matching the input keys, with values translated into {target_name}.

INPUT JSON:
{json.dumps(source_dict, ensure_ascii=False, indent=2)}
"""

    # First try Direct Google Gemini API
    if gemini_key:
        url = f"https://generativelanguage.googleapis.com/v1beta/models/gemini-3.6-flash:generateContent?key={gemini_key}"
        payload = {
            "contents": [{"parts": [{"text": prompt}]}],
            "generationConfig": {
                "responseMimeType": "application/json",
                "temperature": 0.2
            }
        }
        req = urllib.request.Request(
            url,
            data=json.dumps(payload).encode('utf-8'),
            headers={'Content-Type': 'application/json'}
        )

        for attempt in range(4):
            try:
                with urllib.request.urlopen(req, timeout=35) as response:
                    res_body = json.loads(response.read().decode('utf-8'))
                    raw_text = res_body['candidates'][0]['content']['parts'][0]['text']
                    return json.loads(raw_text)
            except Exception as e:
                print(f"  [Google Attempt {attempt+1}] {target_code}: {e}", flush=True)
                time.sleep(2 * (attempt + 1))

    # Fallback to OpenRouter with gemini-3.6-flash
    if openrouter_key:
        print(f"  -> Trying OpenRouter fallback for {target_name} ({target_code})...", flush=True)
        or_url = "https://openrouter.ai/api/v1/chat/completions"
        or_payload = {
            "model": "google/gemini-3.6-flash",
            "messages": [
                {"role": "system", "content": "You are a professional translator and output valid JSON only."},
                {"role": "user", "content": prompt}
            ],
            "response_format": {"type": "json_object"}
        }
        or_req = urllib.request.Request(
            or_url,
            data=json.dumps(or_payload).encode('utf-8'),
            headers={
                'Content-Type': 'application/json',
                'Authorization': f"Bearer {openrouter_key}"
            }
        )
        for attempt in range(3):
            try:
                with urllib.request.urlopen(or_req, timeout=40) as response:
                    res_body = json.loads(response.read().decode('utf-8'))
                    raw_text = res_body['choices'][0]['message']['content']
                    return json.loads(raw_text)
            except Exception as e:
                print(f"  [OpenRouter Attempt {attempt+1}] {target_code}: {e}", flush=True)
                time.sleep(2 * (attempt + 1))

    raise RuntimeError(f"Failed to translate {target_code} after all attempts on both Google and OpenRouter")

def main():
    keys = load_api_keys()
    if not keys.get('gemini') and not keys.get('openrouter'):
        print("ERROR: Neither GEMINI_API_KEY nor OPENROUTER_API_KEY found in .env", flush=True)
        sys.exit(1)

    print("=== Starting Gemini 3.6 Flash Translation Pipeline ===", flush=True)
    print(f"Translating {len(SOURCE_STRINGS)} keys into 13 languages...", flush=True)

    os.makedirs("tool", exist_ok=True)
    checkpoint_file = "tool/onboarding_translations_gemini36.json"
    all_translations = {}
    if os.path.exists(checkpoint_file):
        try:
            with open(checkpoint_file, encoding='utf-8') as f:
                all_translations = json.load(f)
            print(f"Loaded existing checkpoint with {len(all_translations)} languages: {list(all_translations.keys())}", flush=True)
        except Exception:
            all_translations = {}

    all_translations['en'] = SOURCE_STRINGS

    total_langs = len(TARGET_LOCALES)
    for idx, (code, name) in enumerate(TARGET_LOCALES.items(), 1):
        if code in all_translations and len(all_translations[code]) == len(SOURCE_STRINGS):
            print(f"[{idx}/{total_langs}] [{code.upper()}] {name}: Already cached in checkpoint. Skipping.", flush=True)
            continue
        print(f"[{idx}/{total_langs}] [{code.upper()}] {name}: Querying Gemini 3.6 Flash...", flush=True)
        t0 = time.time()
        translated = call_gemini(keys, code, name, SOURCE_STRINGS)
        duration = time.time() - t0
        # verify all keys are present
        missing = [k for k in SOURCE_STRINGS if k not in translated]
        if missing:
            print(f"  WARNING: missing keys in {code}: {missing}", flush=True)
            for m in missing:
                translated[m] = SOURCE_STRINGS[m]
        all_translations[code] = translated
        # save checkpoint
        with open(checkpoint_file, 'w', encoding='utf-8') as f:
            json.dump(all_translations, f, ensure_ascii=False, indent=2)
        print(f"  -> SUCCESS: [{code.upper()}] {name} translated ({len(translated)} keys in {duration:.1f}s).", flush=True)
        time.sleep(0.5)

    print("\n=== Injecting Translated Keys into ARB Files ===", flush=True)

    # 1. Update app_en.arb
    en_path = "lib/l10n/app_en.arb"
    with open(en_path, encoding='utf-8') as f:
        en_arb = json.load(f)

    for k, v in SOURCE_STRINGS.items():
        en_arb[k] = v
        if f"@{k}" in METADATA:
            en_arb[f"@{k}"] = METADATA[f"@{k}"]

    with open(en_path, 'w', encoding='utf-8') as f:
        json.dump(en_arb, f, ensure_ascii=False, indent=2)
    print("Updated lib/l10n/app_en.arb with all keys and metadata.", flush=True)

    # 2. Update each app_<lang>.arb
    for code in TARGET_LOCALES:
        arb_path = f"lib/l10n/app_{code}.arb"
        if not os.path.exists(arb_path):
            print(f"ERROR: {arb_path} does not exist!", flush=True)
            continue
        with open(arb_path, encoding='utf-8') as f:
            target_arb = json.load(f)

        trans_dict = all_translations.get(code, {})
        for k, v in trans_dict.items():
            target_arb[k] = v

        with open(arb_path, 'w', encoding='utf-8') as f:
            json.dump(target_arb, f, ensure_ascii=False, indent=2)
        print(f"Updated {arb_path} with {len(trans_dict)} translated keys.", flush=True)

    print("\n=== Translation & ARB Update Complete ===", flush=True)

if __name__ == '__main__':
    main()
