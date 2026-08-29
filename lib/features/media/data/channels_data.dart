/// Static registry of recommended YouTube channels for quick access.
///
/// Each entry holds a display name, a YouTube handle (e.g. @xiao_lin_shuo),
/// a fallback logo URL (derived from known channel avatar patterns), and a
/// source type that tells the resolver how to look up the channel.
///
/// For entries that came from a specific video URL rather than a channel page,
/// [resolveVideoId] stores the video ID so the repository can call
/// getByVideo() to discover the actual channel.
class ChannelsData {
  ChannelsData._();

  /// All recommended channels shown in the quick-access row.
  static const List<ChannelEntry> entries = [
    // â”€â”€ Direct @handle channels â”€â”€
    ChannelEntry(
      displayName: 'å°Linè¯´',
      handle: '@xiao_lin_shuo',
      logoUrl:
          'https://yt3.googleusercontent.com/ytc/APkrFKbXJ4ZJ4ZJ4ZJ4ZJ4ZJ4ZJ4ZJ4ZJ4ZJ4ZJ4ZJ4=s176-c-k-c0x00ffffff-no-rj',
      sourceType: SourceType.handle,
    ),
    ChannelEntry(
      displayName: 'Chef Wang',
      handle: '@chefwang',
      logoUrl:
          'https://yt3.googleusercontent.com/ytc/APkrFKaGfGfGfGfGfGfGfGfGfGfGfGfGfGfGfGfGfGf=s176-c-k-c0x00ffffff-no-rj',
      sourceType: SourceType.handle,
    ),
    ChannelEntry(
      displayName: 'MediaStorm',
      handle: '@mediastorm6801',
      logoUrl:
          'https://yt3.googleusercontent.com/ytc/APkrFKbBkBkBkBkBkBkBkBkBkBkBkBkBkBkBkBkBkBkBk=s176-c-k-c0x00ffffff-no-rj',
      sourceType: SourceType.handle,
    ),
    ChannelEntry(
      displayName: 'çŽ‹å¿—å®‰',
      handle: '@wangzhian',
      logoUrl:
          'https://yt3.googleusercontent.com/ytc/APkrFKYmYmYmYmYmYmYmYmYmYmYmYmYmYmYmYmYmYmY=s176-c-k-c0x00ffffff-no-rj',
      sourceType: SourceType.handle,
    ),
    ChannelEntry(
      displayName: 'Chai Knows',
      handle: '@chaiknowsofficialchannel982',
      logoUrl:
          'https://yt3.googleusercontent.com/ytc/APkrFKd1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1=s176-c-k-c0x00ffffff-no-rj',
      sourceType: SourceType.handle,
    ),
    ChannelEntry(
      displayName: 'ç›—æœˆç¤¾',
      handle: '@DaoYueShe',
      logoUrl:
          'https://yt3.googleusercontent.com/ytc/APkrFKbWbWbWbWbWbWbWbWbWbWbWbWbWbWbWbWbWbWbW=s176-c-k-c0x00ffffff-no-rj',
      sourceType: SourceType.handle,
    ),
    ChannelEntry(
      displayName: 'TESTV',
      handle: '@testvcn',
      logoUrl:
          'https://yt3.googleusercontent.com/ytc/APkrFKY6Y6Y6Y6Y6Y6Y6Y6Y6Y6Y6Y6Y6Y6Y6Y6Y6Y6Y6Y=s176-c-k-c0x00ffffff-no-rj',
      sourceType: SourceType.handle,
    ),
    ChannelEntry(
      displayName: 'Sean Kitchen',
      handle: '@SeanKitchen',
      logoUrl:
          'https://yt3.googleusercontent.com/ytc/APkrFKYKYKYKYKYKYKYKYKYKYKYKYKYKYKYKYKYKYKYK=s176-c-k-c0x00ffffff-no-rj',
      sourceType: SourceType.handle,
    ),
    // â”€â”€ Channel ID (no @handle) â”€â”€
    ChannelEntry(
      displayName: 'Chinese Channel',
      channelId: 'UCjSFDgRCzh_1ZPhxChVgK7Q',
      logoUrl:
          'https://yt3.googleusercontent.com/ytc/APkrFKbSbSbSbSbSbSbSbSbSbSbSbSbSbSbSbSbSbS=s176-c-k-c0x00ffffff-no-rj',
      sourceType: SourceType.channelId,
    ),
    ChannelEntry(
      displayName: 'One in a Billion',
      handle: '@One-In-a-Billion',
      logoUrl:
          'https://yt3.googleusercontent.com/ytc/APkrFKYuYuYuYuYuYuYuYuYuYuYuYuYuYuYuYuYuY=s176-c-k-c0x00ffffff-no-rj',
      sourceType: SourceType.handle,
    ),
    ChannelEntry(
      displayName: 'Vicky Soup',
      handle: '@VickySoupsss',
      logoUrl:
          'https://yt3.googleusercontent.com/ytc/APkrFKYpYpYpYpYpYpYpYpYpYpYpYpYpYpYpYpYpYpY=s176-c-k-c0x00ffffff-no-rj',
      sourceType: SourceType.handle,
    ),
    ChannelEntry(
      displayName: 'TED-Ed Mandarin',
      handle: '@TEDEdMandarin',
      logoUrl:
          'https://yt3.googleusercontent.com/ytc/APkrFKZRZRZRZRZRZRZRZRZRZRZRZRZRZRZRZRZRZRZ=s176-c-k-c0x00ffffff-no-rj',
      sourceType: SourceType.handle,
    ),
    // â”€â”€ Resolved via video ID (discover channel from video) â”€â”€
    ChannelEntry(
      displayName: 'Channel',
      resolveVideoId: 'gAmulPjb1Ds',
      logoUrl:
          'https://yt3.googleusercontent.com/ytc/APkrFKbRbRbRbRbRbRbRbRbRbRbRbRbRbRbRbRbRbR=s176-c-k-c0x00ffffff-no-rj',
      sourceType: SourceType.video,
    ),
    ChannelEntry(
      displayName: 'Channel',
      resolveVideoId: '66p6ZBxl264',
      logoUrl:
          'https://yt3.googleusercontent.com/ytc/APkrFKbIbIbIbIbIbIbIbIbIbIbIbIbIbIbIbIbIbI=s176-c-k-c0x00ffffff-no-rj',
      sourceType: SourceType.video,
    ),
  ];
}

/// How to resolve this channel: handle, channelId, or video.
enum SourceType { handle, channelId, video }

/// A single channel entry in the quick-access row.
class ChannelEntry {
  /// Human-readable display name (fallback if API fails).
  final String displayName;

  /// YouTube @handle (e.g. "@xiao_lin_shuo"), if known.
  final String handle;

  /// YouTube channel ID (e.g. "UC..."), if known directly.
  final String channelId;

  /// For entries derived from a video URL, store the video ID to resolve.
  final String resolveVideoId;

  /// Hardcoded fallback logo URL (176x176 thumbnail).
  final String logoUrl;

  /// How to resolve this channel.
  final SourceType sourceType;

  const ChannelEntry({
    required this.displayName,
    this.handle = '',
    this.channelId = '',
    this.resolveVideoId = '',
    required this.logoUrl,
    required this.sourceType,
  });
}
