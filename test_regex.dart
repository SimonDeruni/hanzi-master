void main() {
  String text = '''请看这'你' (Nǐ) 字：
* 其左侧为**人字旁** (rénzìpáng),
此偏旁取自'人' (rén),
* 右侧为'尔' (ěr), 古时即作'你'之意,''';
  
  String s = text.replaceAllMapped(
    RegExp(r'(^|\n)[ \t]*[\*\-] ', multiLine: true),
    (m) => '${m.group(1) ?? ''}• ',
  );
  print(s);
}
