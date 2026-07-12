import 'package:http/http.dart' as http;

void main() async {
  final res = await http.get(Uri.parse('https://www.youtube.com/feeds/videos.xml?channel_id=UCoC47do520osFaCG1YacMEA'));
  print(res.statusCode);
  if (res.statusCode == 200) {
    print(res.body.substring(0, 300));
  }
}
