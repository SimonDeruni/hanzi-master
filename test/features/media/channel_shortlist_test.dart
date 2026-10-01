import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/media/data/channels_data.dart';

void main() {
  group('ChannelsData recommended channels shortlist', () {
    test('contains only verified channels with no placeholder entries', () {
      const entries = ChannelsData.entries;

      // Assert total count of curated recommended channels (was 14, now 11 after pruning placeholders)
      expect(entries.length, 11);

      // Channel named "One in a Billion" (which displayed as "One in a...." due to truncation) is removed
      final hasOneInABillion = entries.any(
        (e) =>
            e.displayName.toLowerCase().contains('one in a') ||
            e.handle == '@One-In-a-Billion',
      );
      expect(
        hasOneInABillion,
        isFalse,
        reason: 'One in a Billion must be removed from the channel shortlist',
      );

      // Generic placeholder named "Channel" is removed
      final hasPlaceholderChannel = entries.any(
        (e) => e.displayName == 'Channel',
      );
      expect(
        hasPlaceholderChannel,
        isFalse,
        reason: 'Entries with generic displayName "Channel" must be removed',
      );

      // No entries rely on temporary video resolution (SourceType.video)
      final hasVideoSourceType = entries.any(
        (e) => e.sourceType == SourceType.video,
      );
      expect(
        hasVideoSourceType,
        isFalse,
        reason: 'All recommended channels must resolve by handle or channelId',
      );
    });

    test('every channel has valid metadata, non-empty identifier, and description points', () {
      for (final entry in ChannelsData.entries) {
        expect(entry.displayName.trim().isNotEmpty, isTrue);
        expect(
          entry.displayName != 'Channel',
          isTrue,
          reason: '${entry.displayName} is not a valid channel name',
        );
        expect(
          entry.handle.isNotEmpty || entry.channelId.isNotEmpty,
          isTrue,
          reason: '${entry.displayName} must specify either a handle or channelId',
        );
        expect(entry.logoUrl.isNotEmpty, isTrue);
        expect(entry.descriptionPoints.length, 3);
      }
    });
  });
}
