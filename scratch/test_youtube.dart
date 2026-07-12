import 'package:youtube_explode_dart/youtube_explode_dart.dart';

void main() async {
  final yt = YoutubeExplode();
  try {
    final manifest = await yt.videos.closedCaptions.getManifest('sQDbm84uTiA');
    print('Manifest tracks: ${manifest.tracks.length}');
  } catch (e) {
    print('Error: $e');
  } finally {
    yt.close();
  }
}
