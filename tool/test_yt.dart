import 'package:youtube_explode_dart/youtube_explode_dart.dart';

void main() async {
  final yt = YoutubeExplode();
  try {
    final uploads = yt.channels.getUploads('UCoC47do520osFaCG1YacMEA'); // Liziqi
    print('Found uploads stream. Reading...');
    int count = 0;
    await for (final video in uploads) {
      print('Video: ${video.title}');
      count++;
      if (count >= 3) break;
    }
    print('Done.');
  } catch (e, stack) {
    print('Error: $e');
    print(stack);
  } finally {
    yt.close();
  }
}
