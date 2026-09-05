import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/services/local_tts_voice.dart';

void main() {
  group('selectBestLocalMandarinVoice', () {
    test('prefers an installed premium Mandarin voice', () {
      final voice = selectBestLocalMandarinVoice([
        {
          'name': 'Tingting',
          'locale': 'zh-CN',
          'quality': 'default',
          'identifier': 'compact',
        },
        {
          'name': 'Yu-shu',
          'locale': 'zh-CN',
          'quality': 'premium',
          'identifier': 'premium',
        },
        {'name': 'Samantha', 'locale': 'en-US', 'quality': 'premium'},
      ]);

      expect(voice?.name, 'Yu-shu');
      expect(voice?.qualityLabel, 'Premium');
      expect(voice?.platformArguments['identifier'], 'premium');
    });

    test('prefers enhanced over the default voice', () {
      final voice = selectBestLocalMandarinVoice([
        {'name': 'Compact', 'locale': 'zh_CN', 'quality': 'default'},
        {'name': 'Enhanced', 'locale': 'zh-CN', 'quality': 'enhanced'},
      ]);

      expect(voice?.name, 'Enhanced');
      expect(voice?.qualityLabel, 'Enhanced');
    });

    test('excludes network-required and non-mainland voices', () {
      final voice = selectBestLocalMandarinVoice([
        {
          'name': 'Online',
          'locale': 'zh-CN',
          'quality': 500,
          'network_required': true,
        },
        {'name': 'Taiwan', 'locale': 'zh-TW', 'quality': 'premium'},
      ]);

      expect(voice, isNull);
    });

    test('supports Android numeric quality values', () {
      final voice = selectBestLocalMandarinVoice([
        {'name': 'Low', 'locale': 'zh-CN', 'quality': 200},
        {'name': 'High', 'locale': 'zh-CN', 'quality': 500},
      ]);

      expect(voice?.name, 'High');
      expect(voice?.qualityLabel, 'Standard');
    });
  });
}
