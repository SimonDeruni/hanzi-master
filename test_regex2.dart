void main() {
  String text = "Line 1\n* Line 2\n*Line 3\n- Line 4";
  
  String s = text.replaceAllMapped(
    RegExp(r'^[ \t]*[\*\-]( |$)', multiLine: true),
    (m) => '• ',
  );
  print(s);
}
