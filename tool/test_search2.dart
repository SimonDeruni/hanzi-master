import 'package:youtube_explode_dart/youtube_explode_dart.dart';

void main() async {
  final yt = YoutubeExplode();
  try {
    final searchList = await yt.search.search('李子柒 Liziqi');
    int count = 0;
    for (final video in searchList) {
      print('Video: ${video.title} by ${video.author}');
      count++;
      if (count >= 3) break;
    }
  } catch (e, stack) {
    print('Error: $e');
  } finally {
    yt.close();
  }
}
