import 'package:lpinyin/lpinyin.dart';
void main() {
  print(ChineseHelper.containsChinese('你好'));
  print(ChineseHelper.isTraditionalChinese('體'));
  print(ChineseHelper.isTraditionalChinese('体'));
}
