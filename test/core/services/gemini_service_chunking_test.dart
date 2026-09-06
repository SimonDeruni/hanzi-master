import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';

void main() {
  group('GeminiService.splitArticleIntoChunks', () {
    test('keeps the entire article in its original order', () {
      final source = List.generate(
        12,
        (index) => '第$index段。${List.filled(25, '这是需要保留的文章内容。').join()}',
      ).join('\n\n');

      final chunks = GeminiService.splitArticleIntoChunks(
        source,
        maxCharacters: 300,
      );

      expect(chunks.length, greaterThan(1));
      expect(chunks.every((chunk) => chunk.length <= 300), isTrue);
      expect(
        chunks.join('\n\n').replaceAll(RegExp(r'\s+'), ''),
        source.replaceAll(RegExp(r'\s+'), ''),
      );
    });

    test('splits a long paragraph at sentence boundaries when possible', () {
      final source = List.filled(40, '这是一个完整句子。').join();

      final chunks = GeminiService.splitArticleIntoChunks(
        source,
        maxCharacters: 120,
      );

      expect(chunks.length, greaterThan(1));
      expect(chunks.every((chunk) => chunk.endsWith('。')), isTrue);
      expect(chunks.join(), source);
    });
  });
}
