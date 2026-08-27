import 'dart:convert';
import 'dart:io';

Future<String?> fetchUrl(String url) async {
  final client = HttpClient();
  client.userAgent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)';
  try {
    final req = await client.getUrl(Uri.parse(url));
    final resp = await req.close();
    if (resp.statusCode == 200) {
      return await resp.transform(utf8.decoder).join();
    }
    return null;
  } catch (e) {
    return null;
  } finally {
    client.close();
  }
}

void main() async {
  print('=== Testing Gutenberg Chinese Texts & GitHub Corpora ===');

  // Let's test a known Gutenberg Chinese book URL
  // Gutenberg #24264: 封神演義
  // Gutenberg #24225: 儒林外史
  // Gutenberg #24177: 東周列國志
  // Gutenberg #24051: 聊齋志異
  // Gutenberg #23956: 老殘遊記
  // Gutenberg #25332: 鏡花緣
  // Gutenberg #25301: 官場現形記
  // Gutenberg #25281: 二十年目睹之怪現狀
  // Gutenberg #25280: 孽海花
  // Gutenberg #25310: 醒世恆言
  // Gutenberg #25309: 警世通言
  // Gutenberg #25308: 喻世明言
  // Gutenberg #25307: 初刻拍案驚奇
  // Gutenberg #25306: 二刻拍案驚奇

  final testGutenberg = {
    'fengshen_yanyi': 'https://www.gutenberg.org/files/24264/24264-0.txt',
    'the_scholars': 'https://www.gutenberg.org/files/24225/24225-0.txt',
    'eastern_zhou_chronicles': 'https://www.gutenberg.org/files/24177/24177-0.txt',
    'liaozhai_zhiyi': 'https://www.gutenberg.org/files/24051/24051-0.txt',
    'lao_can_youji': 'https://www.gutenberg.org/files/23956/23956-0.txt',
    'flowers_in_the_mirror': 'https://www.gutenberg.org/files/25332/25332-0.txt',
    'officialdom_unmasked': 'https://www.gutenberg.org/files/25301/25301-0.txt',
    'bizarre_happenings': 'https://www.gutenberg.org/files/25281/25281-0.txt',
    'flower_in_sinful_sea': 'https://www.gutenberg.org/files/25280/25280-0.txt',
    'xingshi_hengyan': 'https://www.gutenberg.org/files/25310/25310-0.txt',
    'jingshi_tongyan': 'https://www.gutenberg.org/files/25309/25309-0.txt',
    'yushi_mingyan': 'https://www.gutenberg.org/files/25308/25308-0.txt',
    'chuke_paian': 'https://www.gutenberg.org/files/25307/25307-0.txt',
    'erke_paian': 'https://www.gutenberg.org/files/25306/25306-0.txt',
  };

  for (final entry in testGutenberg.entries) {
    final res = await fetchUrl(entry.value);
    if (res != null) {
      print('✅ SUCCESS: ${entry.key} -> downloaded ${res.length} chars (~${res.length ~/ 1024} KB)');
    } else {
      print('❌ FAILED: ${entry.key}');
    }
  }
}
