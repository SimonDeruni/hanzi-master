import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hanzi_master/core/services/audio_quota_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AudioQuotaService Weekly 4-Hour Fair Use Engine', () {
    late AudioQuotaService quotaService;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      quotaService = AudioQuotaService();
      quotaService.resetQuotaForTesting();
    });

    test('ISO 8601 week key is accurately formatted', () {
      final monday = DateTime(2026, 8, 24); // Week 35
      final sunday = DateTime(2026, 8, 30); // Week 35
      final nextMonday = DateTime(2026, 8, 31); // Week 36

      expect(AudioQuotaService.getIsoWeekKey(monday), equals('2026-W35'));
      expect(AudioQuotaService.getIsoWeekKey(sunday), equals('2026-W35'));
      expect(AudioQuotaService.getIsoWeekKey(nextMonday), equals('2026-W36'));
    });

    test('Initial quota is 4.0 hours remaining', () {
      expect(quotaService.hasQuotaRemaining, isTrue);
      expect(quotaService.remainingHours, equals(4.0));
      expect(quotaService.remainingMinutes, equals(240));
      expect(quotaService.usedSeconds, equals(0));
    });

    test('Recording speech deducts quota accurately', () async {
      // 100 Chinese characters @ 0.315s/char = 32 seconds
      final text = '齐天大圣孙悟空因大闹天宫被压于五行山下五百年后受观音菩萨点化与猪八戒沙悟净一同护送大唐高僧玄奘法师西天取经的宏大传奇师徒四人跋涉十万八千里历经九九八十一难一路斩妖除魔不仅战胜了诸多妖魔更在心性磨砺中完成了从凡俗到成佛的灵性蜕变构筑了一座世界文学史上无可逾越的奇幻神魔史诗';
      await quotaService.recordSpeech(text);

      expect(quotaService.usedSeconds, greaterThan(0));
      expect(quotaService.remainingHours, lessThan(4.0));
      expect(quotaService.hasQuotaRemaining, isTrue);
    });

    test('Quota exhaustion triggers hasQuotaRemaining false', () {
      // Add 4.1 hours (14,760 seconds)
      quotaService.addUsedSecondsForTesting(14760);

      expect(quotaService.hasQuotaRemaining, isFalse);
      expect(quotaService.remainingHours, equals(0.0));
      expect(quotaService.remainingMinutes, equals(0));
    });
  });
}
