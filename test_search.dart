import 'package:youtube_explode_dart/youtube_explode_dart.dart';
void main() async {
  final yt = YoutubeExplode();
  final searchResults = await yt.search.search('chinese drama eng sub playlist');
  print('Total results: ${searchResults.length}');
  for (var r in searchResults) {
    print('${r.runtimeType} : ${r.id} - ${r.title}');
    if (r is SearchPlaylist) {
        print('Playlist found! ${r.id.value}');
    }
  }
  yt.close();
}
