import 'package:hive/hive.dart';

class SavedArticle {
  final String title;
  final String url;
  final String extractedText;
  final DateTime timestamp;

  SavedArticle({
    required this.title,
    required this.url,
    required this.extractedText,
    required this.timestamp,
  });
}

class SavedArticleAdapter extends TypeAdapter<SavedArticle> {
  @override
  final int typeId = 3;

  @override
  SavedArticle read(BinaryReader reader) {
    return SavedArticle(
      title: reader.readString(),
      url: reader.readString(),
      extractedText: reader.readString(),
      timestamp: DateTime.fromMillisecondsSinceEpoch(reader.readInt()),
    );
  }

  @override
  void write(BinaryWriter writer, SavedArticle obj) {
    writer.writeString(obj.title);
    writer.writeString(obj.url);
    writer.writeString(obj.extractedText);
    writer.writeInt(obj.timestamp.millisecondsSinceEpoch);
  }
}
