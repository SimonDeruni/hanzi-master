import 'package:lpinyin/lpinyin.dart';

void main() {
  String text = "哈喽哈喽！又见到老铁你啦！今天也想跟我唠嗑点啥不？";
  String pinyin = PinyinHelper.getPinyinE(text, separator: " ", defPinyin: '', format: PinyinFormat.WITH_TONE_MARK);
  print(pinyin);
}
