"""
Pre-generate 4-sentence English summaries for all Chinese drama shows
in shows_data.dart using deepseek/deepseek-chat via OpenRouter.

Each summary covers:
1. The premise / setting
2. The main character(s) and their goal
3. The central conflict or romance
4. The tone / what makes it worth watching

Writes show_summaries.dart as a Dart Map<String, String>.
"""
import json, re, time, os, sys
from http.client import HTTPSConnection

def extract_shows(shows_data_path: str):
    """Extract show entries from shows_data.dart."""
    with open(shows_data_path, encoding='utf-8') as f:
        text = f.read()
    lines = text.split('\n')
    shows = []
    i = 0
    while i < len(lines):
        line = lines[i]
        if "'id': 'PL" in line:
            id_match = re.search(r"'id':\s*'([^']+)'", line)
            show_id = id_match.group(1) if id_match else ""
            title_match = re.search(r"'title':\s*'([^']+)'", lines[i + 1])
            title = title_match.group(1) if title_match else ""
            channel_match = re.search(r"'channelTitle':\s*'([^']+)'", lines[i + 2])
            channel = channel_match.group(1) if channel_match else ""
            tags = []
            for j in range(i, min(i + 15, len(lines))):
                if "'tags':" in lines[j]:
                    tag_line = lines[j]
                    tags = re.findall(r"'([^']+)'", tag_line)
                    break
                elif "'tags': [" in lines[j]:
                    tag_line = lines[j]
                    tags = re.findall(r"'([^']+)'", tag_line)
                    if not tags:
                        for k in range(j + 1, min(j + 5, len(lines))):
                            tag_match = re.findall(r"'([^']+)'", lines[k])
                            tags.extend(tag_match)
                            if ']' in lines[k]:
                                break
                    break
            shows.append({
                'id': show_id,
                'title': title,
                'channel': channel,
                'tags': tags,
            })
        i += 1
    return shows

def load_env(path: str):
    """Load .env file."""
    env = {}
    if not os.path.exists(path):
        path = os.path.join(os.path.dirname(path), '..', '.env')
    if os.path.exists(path):
        with open(path, encoding='utf-8') as f:
            for line in f:
                line = line.strip()
                if line and not line.startswith('#') and '=' in line:
                    key, value = line.split('=', 1)
                    env[key.strip()] = value.strip().strip('"').strip("'")
    return env

def call_openrouter(prompt: str, api_key: str, model: str = 'deepseek/deepseek-chat') -> str:
    """Call OpenRouter API and return the response text."""
    conn = HTTPSConnection('openrouter.ai', timeout=60)
    body = json.dumps({
        'model': model,
        'messages': [
            {
                'role': 'system',
                'content': 'You are a knowledgeable expert on Chinese television dramas. Write concise, engaging summaries. Respond ONLY with a 4-sentence summary, no prefixes or labels.'
            },
            {'role': 'user', 'content': prompt}
        ],
        'temperature': 0.7,
        'max_tokens': 300,
    })
    headers = {
        'Content-Type': 'application/json',
        'Authorization': f'Bearer {api_key}',
        'HTTP-Referer': 'https://hanzi-master.app',
        'X-Title': 'Hanzi Master Show Summary Generator',
    }
    try:
        conn.request('POST', '/api/v1/chat/completions', body, headers)
        response = conn.getresponse()
        data = json.loads(response.read().decode('utf-8'))
        conn.close()
        if 'choices' in data and len(data['choices']) > 0:
            return data['choices'][0]['message']['content'].strip()
        else:
            print(f"  API error: {json.dumps(data, indent=2)[:500]}")
            return ""
    except Exception as e:
        print(f"  API call failed: {e}")
        return ""
def generate_summaries(shows, api_key):
    """Generate summaries for all shows, returning a title->summary map."""
    import sys as _sys
    _sys.stdout.reconfigure(encoding='utf-8') if hasattr(_sys.stdout, 'reconfigure') else None
    summaries = {}
    skip_patterns = [
        'Members Premiere', 'Get APP Now', '[ENG SUB]', 'ENGSUB [',
        '【FULL】', '【Limited', 'EP16', '周年版', '特别版', '甜宠版',
        '剧场版', 'FULL正片', 'FULL EP', 'Full Version', 'Download',
        'Hot Trending', 'Reborn Chinese Drama', 'iQIYI', 'YOUKU',
        'Mini Drama', 'In no particular order',
    ]
    # TEST: only first 10 non-skipped
    count = 0
    for idx, show in enumerate(shows):
        title = show['title']
        if any(p.lower() in title.lower() for p in skip_patterns):
            print(f"  [{idx+1}/{len(shows)}] SKIP: {title[:80]}")
            summaries[title] = ""
            continue
        count += 1
        if count > 10:
            summaries[title] = ""
            continue
        channel = show['channel']
        tags = ', '.join(show['tags']) if show['tags'] else ''
        prompt = f'Write a 4-sentence English summary for the Chinese drama: "{title}"'
        if tags:
            prompt += f" (Genre tags: {tags})"
        if channel:
            prompt += f" (From channel: {channel})"
        prompt += (
            "\n\nSentence 1: Set up the world and premise."
            "\nSentence 2: Introduce the main character(s)."
            "\nSentence 3: Describe the central conflict or romance."
            "\nSentence 4: Note the tone or what makes it unique."
        )
        print(f"  [{idx+1}/{len(shows)}] {title[:80]}")
        summary = call_openrouter(prompt, api_key)
        if summary:
            summaries[title] = summary
            print(f"    OK: {summary[:100]}...")
        else:
            summaries[title] = ""
            print("    FAILED")
        time.sleep(1)
    return summaries


def write_dart_file(summaries, output_path):
    """Write the summaries as a Dart map."""
    escaped = {}
    for title, summary in summaries.items():
        if not summary:
            continue
        escaped_title = title.replace('\\', '\\\\').replace("'", "\\'")
        escaped_summary = summary.replace('\\', '\\\\').replace("'", "\\'").replace('\n', ' ')
        escaped[escaped_title] = escaped_summary

    lines = [
        '// GENERATED FILE - do not edit manually',
        '// Generated by tools/generate_show_summaries.py',
        '',
        '/// Pre-generated 4-sentence English summaries for each show.',
        '/// Maps show title (exact string from shows_data.dart) -> summary.',
        'const Map<String, String> showSummaries = {',
    ]
    for title in sorted(escaped.keys()):
        lines.append(f"  '{title}': '{escaped[title]}',")
    lines.append('};')
    lines.append('')

    with open(output_path, 'w', encoding='utf-8') as f:
        f.write('\n'.join(lines))
    print(f"Written {len(escaped)} entries to {output_path}")


def main():
    import sys as _sys
    _sys.stdout.reconfigure(encoding='utf-8') if hasattr(_sys.stdout, 'reconfigure') else None
    base_dir = os.path.dirname(os.path.abspath(__file__))
    project_dir = os.path.dirname(base_dir)
    shows_data_path = os.path.join(
        project_dir, 'lib', 'features', 'media', 'data', 'repositories',
        'shows_data.dart')
    output_path = os.path.join(
        project_dir, 'lib', 'features', 'media', 'data', 'repositories',
        'show_summaries.dart')
    env_path = os.path.join(project_dir, '.env')

    env = load_env(env_path)
    api_key = env.get('OPENROUTER_API_KEY', '')
    if not api_key:
        print("ERROR: OPENROUTER_API_KEY not found in .env file")
        sys.exit(1)

    print("Extracting shows from shows_data.dart...")
    shows = extract_shows(shows_data_path)
    print(f"Found {len(shows)} show entries")

    print("Generating summaries...")
    summaries = generate_summaries(shows, api_key)

    success = sum(1 for v in summaries.values() if v)
    print(f"Generated {success}/{len(summaries)} summaries")

    write_dart_file(summaries, output_path)


if __name__ == '__main__':
    main()