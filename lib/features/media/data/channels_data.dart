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
    // ── Direct @handle channels ──
    ChannelEntry(
      displayName: '小Lin说',
      handle: '@xiao_lin_shuo',
      logoUrl:
          'https://yt3.googleusercontent.com/ytc/APkrFKbXJ4ZJ4ZJ4ZJ4ZJ4ZJ4ZJ4ZJ4ZJ4ZJ4ZJ4ZJ4=s176-c-k-c0x00ffffff-no-rj',
      sourceType: SourceType.handle,
      descriptionPoints: [
        'Engaging macroeconomic and business breakdowns explained through lively storytelling.',
        'Explores world economies, banking histories, and global industry dynamics.',
        'Clear, articulate Mandarin perfect for intermediate and advanced learners.',
      ],
    ),
    ChannelEntry(
      displayName: 'Chef Wang',
      handle: '@chefwang',
      logoUrl:
          'https://yt3.googleusercontent.com/ytc/APkrFKaGfGfGfGfGfGfGfGfGfGfGfGfGfGfGfGfGfGf=s176-c-k-c0x00ffffff-no-rj',
      sourceType: SourceType.handle,
      descriptionPoints: [
        'Master Sichuan culinary techniques taught directly by a professional head chef.',
        'Step-by-step authentic Chinese recipes with wok control and knife work.',
        'Concise culinary vocabulary and clear instruction in natural Mandarin.',
      ],
    ),
    ChannelEntry(
      displayName: '媒体风暴',
      handle: '@mediastorm6801',
      logoUrl:
          'https://yt3.googleusercontent.com/ytc/APkrFKbBkBkBkBkBkBkBkBkBkBkBkBkBkBkBkBkBkBkBk=s176-c-k-c0x00ffffff-no-rj',
      sourceType: SourceType.handle,
      descriptionPoints: [
        'Cinematography, cutting-edge camera tech, and deep digital media evaluations.',
        'High-production documentary style exploring video creation and AI innovations.',
        'Rich technical Mandarin with crystal-clear pronunciation and visual captions.',
      ],
    ),
    ChannelEntry(
      displayName: '王志安',
      handle: '@wangzhian',
      logoUrl:
          'https://yt3.googleusercontent.com/ytc/APkrFKYmYmYmYmYmYmYmYmYmYmYmYmYmYmYmYmYmYmY=s176-c-k-c0x00ffffff-no-rj',
      sourceType: SourceType.handle,
      descriptionPoints: [
        'In-depth investigative journalism and current affairs commentary.',
        'Critical perspectives on social phenomena, world news, and history.',
        'Formal investigative discourse ideal for advanced listening comprehension.',
      ],
    ),
    ChannelEntry(
      displayName: '柴知道Chai...',
      handle: '@chaiknowsofficialchannel982',
      logoUrl:
          'https://yt3.googleusercontent.com/ytc/APkrFKd1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1=s176-c-k-c0x00ffffff-no-rj',
      sourceType: SourceType.handle,
      descriptionPoints: [
        'Bite-sized animated science documentaries answering everyday questions.',
        'Explores physics, biology, and everyday curiosities with fun infographics.',
        'Standard Beijing Mandarin with well-paced narration and clear subtitles.',
      ],
    ),
    ChannelEntry(
      displayName: '盗月社',
      handle: '@DaoYueShe',
      logoUrl:
          'https://yt3.googleusercontent.com/ytc/APkrFKbWbWbWbWbWbWbWbWbWbWbWbWbWbWbWbWbWbWbW=s176-c-k-c0x00ffffff-no-rj',
      sourceType: SourceType.handle,
      descriptionPoints: [
        'Heartwarming street food adventures and genuine conversations across China.',
        'Explores regional human stories, family traditions, and local delicacies.',
        'Natural conversational Mandarin with daily slang and emotional warmth.',
      ],
    ),
    ChannelEntry(
      displayName: 'TESTV',
      handle: '@testvcn',
      logoUrl:
          'https://yt3.googleusercontent.com/ytc/APkrFKY6Y6Y6Y6Y6Y6Y6Y6Y6Y6Y6Y6Y6Y6Y6Y6Y6Y6Y6Y=s176-c-k-c0x00ffffff-no-rj',
      sourceType: SourceType.handle,
      descriptionPoints: [
        'Humorous and honest consumer electronics reviews from real-life experience.',
        'Testing smartphones, smart home gadgets, and tech lifestyle gear.',
        'Relaxed, humorous conversational dialogue with modern colloquialisms.',
      ],
    ),
    ChannelEntry(
      displayName: 'Sean Kitchen',
      handle: '@SeanKitchen',
      logoUrl:
          'https://yt3.googleusercontent.com/ytc/APkrFKYKYKYKYKYKYKYKYKYKYKYKYKYKYKYKYKYKYKYK=s176-c-k-c0x00ffffff-no-rj',
      sourceType: SourceType.handle,
      descriptionPoints: [
        'Delicious home-cooked Chinese dishes and street snack recreation.',
        'Easy-to-follow kitchen tips for cooking authentic Asian comfort food.',
        'Warm, inviting commentary with practical kitchen vocabulary.',
      ],
    ),
    ChannelEntry(
      displayName: 'Chinese Channel',
      channelId: 'UCjSFDgRCzh_1ZPhxChVgK7Q',
      logoUrl:
          'https://yt3.googleusercontent.com/ytc/APkrFKbSbSbSbSbSbSbSbSbSbSbSbSbSbSbSbSbSbS=s176-c-k-c0x00ffffff-no-rj',
      sourceType: SourceType.channelId,
      descriptionPoints: [
        'Structured Chinese language lessons and cultural discovery tutorials.',
        'Grammar points, HSK vocabulary building, and conversational patterns.',
        'Clear educational pacing tailored specifically for Chinese learners.',
      ],
    ),
    ChannelEntry(
      displayName: 'Vicky Soup',
      handle: '@VickySoupsss',
      logoUrl:
          'https://yt3.googleusercontent.com/ytc/APkrFKYpYpYpYpYpYpYpYpYpYpYpYpYpYpYpYpYpY=s176-c-k-c0x00ffffff-no-rj',
      sourceType: SourceType.handle,
      descriptionPoints: [
        'Aesthetic lifestyle vlogs, fashion styling, and daily routines.',
        'Travel diaries and cozy life moments documented with cinematic warmth.',
        'Natural casual Mandarin spoken at a comfortable, expressive pace.',
      ],
    ),
    ChannelEntry(
      displayName: 'TED-Ed Mandarin',
      handle: '@TEDEdMandarin',
      logoUrl:
          'https://yt3.googleusercontent.com/ytc/APkrFKZRZRZRZRZRZRZRZRZRZRZRZRZRZRZRZRZRZRZ=s176-c-k-c0x00ffffff-no-rj',
      sourceType: SourceType.handle,
      descriptionPoints: [
        'High-quality animated educational lessons on science, philosophy, and history.',
        'Thought-provoking riddles, classic literature, and psychology mysteries.',
        'Impeccable voice-over Mandarin with synchronized bilingual subtitles.',
      ],
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

  /// 3 concise sentences explaining what the channel is about.
  final List<String> descriptionPoints;

  const ChannelEntry({
    required this.displayName,
    this.handle = '',
    this.channelId = '',
    this.resolveVideoId = '',
    required this.logoUrl,
    required this.sourceType,
    this.descriptionPoints = const [],
  });
}
