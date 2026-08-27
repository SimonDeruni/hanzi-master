import 'dart:convert';
import 'dart:io';

Future<List<String>> getRepoTree(String repo) async {
  final client = HttpClient();
  client.userAgent = 'HanziMasterApp/1.0';
  final uri = Uri.parse('https://api.github.com/repos/$repo/git/trees/master?recursive=1');
  try {
    final req = await client.getUrl(uri);
    final resp = await req.close();
    final body = await resp.transform(utf8.decoder).join();
    final json = jsonDecode(body) as Map<String, dynamic>;
    final tree = (json['tree'] as List<dynamic>?) ?? [];
    return tree.map((e) => e['path'] as String).toList();
  } catch (e) {
    return [];
  } finally {
    client.close();
  }
}

void main() async {
  print('=== Searching All Repositories for Remaining Partial Books ===\n');

  final repos = [
    'BlankRain/ebooks',
    'memxz/Ref_Book',
    'xp44mm/hanchuancaolu',
    'chinese-poetry/chinese-poetry',
    'VeejaLiu/ScienceFictionCollection',
  ];

  final Map<String, List<String>> repoTrees = {};
  for (final r in repos) {
    final tree = await getRepoTree(r);
    repoTrees[r] = tree;
    print('Loaded $r: ${tree.length} files');
  }

  final searchTargets = [
    '火枪手', '爱丽丝', '汤姆', '金银岛', '化身博士', '格林童话', '安徒生',
    '木偶奇遇记', '神曲', '君主论', '老实人', '菜根潭', '传习录', '西厢记',
    '牡丹亭', '窦娥冤', '长生殿', '桃花扇', '阅微草堂', '酉阳杂俎', '笑林广记',
    '少年维特', '德米安', '查拉图斯特拉', '轮下', '悲剧的诞生', '强盗',
    '威廉·退尔', '胡桃夹子', '吹牛大王', '复活', '钦差大臣', '变色龙',
    '樱桃园', '欧根·奥涅金', '项链', '恶之花', '伪君子', '守财奴', '忏悔录',
    '雷雨', '日出', '子夜', '湘行散记', '寄小读者'
  ];

  print('\n=== Search Results across 5 Repositories ===');
  for (final target in searchTargets) {
    final found = <String>[];
    for (final entry in repoTrees.entries) {
      final matches = entry.value.where((path) => path.contains(target) && (path.endsWith('.txt') || path.endsWith('.md') || path.endsWith('.json') || path.endsWith('.epub'))).toList();
      for (final m in matches) {
        found.add('${entry.key}: $m');
      }
    }
    if (found.isNotEmpty) {
      print('✅ FOUND "$target" (${found.length} matches):');
      for (final f in found.take(3)) {
        print('   - $f');
      }
    } else {
      print('❌ NOT FOUND: "$target"');
    }
  }
}
