import 'package:lpinyin/lpinyin.dart';

void main() {
  String simp = "爱 爸爸 杯子 北京 电脑";
  print("Simplified: $simp");
  try {
    String trad = ChineseHelper.convertToTraditionalChinese(simp);
    print("Traditional: $trad");
  } catch (e) {
    print("Error: $e");
  }
}
