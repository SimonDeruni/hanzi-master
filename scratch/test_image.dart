import 'dart:io';

void main() async {
  final url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c8/Sun_Wukong_and_Jade_Emperor.jpg/800px-Sun_Wukong_and_Jade_Emperor.jpg';
  
  try {
    final request = await HttpClient().getUrl(Uri.parse(url));
    final response = await request.close();
    print('Status code no headers: ${response.statusCode}');
  } catch (e) {
    print('Error no headers: $e');
  }
}
