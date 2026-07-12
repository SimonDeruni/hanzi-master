import os
import re
import time
import requests
import json

API_KEY = "AIzaSyCvmm4uljoCyIFkBIoBybiishaWyyu2ROU"

def search_playlists(query, max_results=50):
    url = f"https://www.googleapis.com/youtube/v3/search?part=snippet&type=playlist&q={query}&maxResults={max_results}&key={API_KEY}"
    resp = requests.get(url)
    if resp.status_code != 200:
        print("Error searching:", resp.text)
        return []
    
    return resp.json().get('items', [])

def get_playlist_items(playlist_id):
    url = f"https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId={playlist_id}&maxResults=50&key={API_KEY}"
    resp = requests.get(url)
    if resp.status_code != 200:
        return []
    return resp.json().get('items', [])

def check_cc(video_id):
    url = f"https://www.googleapis.com/youtube/v3/captions?part=snippet&videoId={video_id}&key={API_KEY}"
    resp = requests.get(url)
    if resp.status_code == 200:
        items = resp.json().get('items', [])
        for item in items:
            lang = item['snippet']['language'].lower()
            if lang.startswith('zh') or lang in ['cmn', 'yue']:
                return True
    return False

def main():
    print("Searching for playlists...")
    playlists = search_playlists("chinese drama full episodes eng sub YOUKU Tencent", 50)
    
    with open('lib/features/media/data/repositories/shows_data.dart', 'r', encoding='utf-8') as f:
        content = f.read()

    new_entries = []
    added = 0
    
    for pl in playlists:
        if added >= 50:
            break
            
        pid = pl['id']['playlistId']
        if f"'{pid}'" in content:
            continue
            
        title = pl['snippet']['title'].replace("'", "\\'")
        channel = pl['snippet']['channelTitle'].replace("'", "\\'")
        
        items = get_playlist_items(pid)
        if len(items) < 10:
            continue
            
        first_video = items[0]['snippet']['resourceId']['videoId']
        # Try to get highres thumb
        thumb_obj = items[0]['snippet']['thumbnails']
        thumb = thumb_obj.get('maxres', thumb_obj.get('high', thumb_obj.get('default')))['url']
        
        # We assume hard if we can't fetch captions due to quotas, but we'll try CC
        has_cc = check_cc(first_video)
        subtitle_type = 'soft' if has_cc else 'hard'
        
        lines = []
        lines.append("    {")
        lines.append(f"      'id': '{pid}',")
        lines.append(f"      'title': '{title}',")
        lines.append(f"      'channelTitle': '{channel}',")
        lines.append(f"      'thumbnailUrl': '{thumb}',")
        lines.append(f"      'episodeCount': {len(items)},")
        lines.append("      'tags': ['Drama'],")
        lines.append(f"      'subtitleType': '{subtitle_type}',")
        lines.append("      'episodes': [")
        
        for i, item in enumerate(items):
            vid = item['snippet']['resourceId']['videoId']
            vthumb_obj = item['snippet']['thumbnails']
            if not vthumb_obj:
                vthumb = thumb
            else:
                vthumb = vthumb_obj.get('maxres', vthumb_obj.get('high', vthumb_obj.get('default')))['url']
                
            vtitle = f"EP{(i+1):02d}"
            lines.append("        {")
            lines.append(f"          'id': '{vid}',")
            lines.append(f"          'title': '{vtitle}',")
            lines.append(f"          'thumbnailUrl': '{vthumb}',")
            lines.append("        },")
            
        lines.append("      ],")
        lines.append("    },")
        
        new_entries.append("\n".join(lines))
        added += 1
        print(f"Added {added}: {title}")
        
    if new_entries:
        closing_idx = content.rfind("];")
        new_content = content[:closing_idx] + "\n".join(new_entries) + "\n  " + content[closing_idx:]
        with open('lib/features/media/data/repositories/shows_data.dart', 'w', encoding='utf-8') as f:
            f.write(new_content)
        print(f"Successfully added {len(new_entries)} shows.")
    else:
        print("No new shows added.")

if __name__ == "__main__":
    main()
