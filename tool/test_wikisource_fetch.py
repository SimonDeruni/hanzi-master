import urllib.request
import json
import re

def fetch_wikisource_page(title):
    url = f"https://zh.wikisource.org/w/api.php?action=parse&page={urllib.parse.quote(title)}&format=json&prop=wikitext"
    req = urllib.request.Request(url, headers={'User-Agent': 'HanziMasterIngestionBot/1.0 (educational research)'})
    try:
        with urllib.request.urlopen(req, timeout=10) as resp:
            data = json.loads(resp.read().decode('utf-8'))
            if 'parse' in data and 'wikitext' in data['parse']:
                wikitext = data['parse']['wikitext']['*']
                return wikitext
            else:
                return None
    except Exception as e:
        print(f"Error fetching {title}: {e}")
        return None

def search_wikisource(query):
    url = f"https://zh.wikisource.org/w/api.php?action=query&list=search&srsearch={urllib.parse.quote(query)}&format=json"
    req = urllib.request.Request(url, headers={'User-Agent': 'HanziMasterIngestionBot/1.0'})
    try:
        with urllib.request.urlopen(req, timeout=10) as resp:
            data = json.loads(resp.read().decode('utf-8'))
            return [item['title'] for item in data['query']['search']]
    except Exception as e:
        print(f"Error searching {query}: {e}")
        return []

if __name__ == '__main__':
    print("Testing Wikisource Search & Fetch:")
    test_queries = ['小王子', '老人与海', '变形记', '三十六计', '封神演义', '安徒生童话', '格林童话', '聊斋志异', '儒林外史']
    for q in test_queries:
        results = search_wikisource(q)
        print(f"Search '{q}': {results[:3]}")
