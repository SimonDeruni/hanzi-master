import 'package:lpinyin/lpinyin.dart';

void main() {
  final list = ["人", "亻", "木", "氵", "心", "忄", "手", "扌"];
  for (var r in list) {
    print("$r -> ${PinyinHelper.getPinyin(r, separator: ' ', format: PinyinFormat.WITH_TONE_MARK)}");
  }
}
