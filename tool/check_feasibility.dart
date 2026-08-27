import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  // Let's test if we can find Three Musketeers, Alice, Tom Sawyer, Jekyll, etc. in Haodoo or BlankRain
  print('=== Checking Feasibility for Remaining Books ===');
  final testBooks = [
    '三个火枪手',
    '爱丽丝',
    '汤姆·索亚',
    '金银岛',
    '化身博士',
    '格林童话',
    '安徒生童话',
    '木偶奇遇记',
    '神曲',
    '君主论',
    '老实人',
    '菜根潭',
    '传习录',
    '西厢记',
    '牡丹亭',
    '窦娥冤',
  ];

  for (final b in testBooks) {
    print('Checking: $b ...');
  }
}
