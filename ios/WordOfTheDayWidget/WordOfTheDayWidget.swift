import SwiftUI
import WidgetKit

private let appGroupId = "group.com.sinospark.hanzimaster"
private let vocabulary = [
  ("你好", "nǐ hǎo", "hello"),
  ("学习", "xué xí", "to study · to learn"),
  ("朋友", "péng you", "friend"),
  ("发现", "fā xiàn", "to discover"),
  ("坚持", "jiān chí", "to persist"),
  ("勇气", "yǒng qì", "courage"),
  ("智慧", "zhì huì", "wisdom"),
  ("成长", "chéng zhǎng", "to grow"),
  ("平静", "píng jìng", "calm · peaceful"),
  ("希望", "xī wàng", "hope"),
  ("理解", "lǐ jiě", "to understand"),
  ("习惯", "xí guàn", "habit"),
  ("温暖", "wēn nuǎn", "warmth · warm"),
  ("专注", "zhuān zhù", "to focus")
]

struct WordEntry: TimelineEntry {
  let date: Date
  let hanzi: String
  let pinyin: String
  let meaning: String
  let url: URL

  static let placeholder = WordEntry(
    date: Date(),
    hanzi: "学习",
    pinyin: "xué xí",
    meaning: "to study · to learn",
    url: URL(string: "sinospark://word?hanzi=%E5%AD%A6%E4%B9%A0")!
  )
}

struct WordProvider: TimelineProvider {
  func placeholder(in context: Context) -> WordEntry { .placeholder }

  func getSnapshot(in context: Context, completion: @escaping (WordEntry) -> Void) {
    completion(context.isPreview ? .placeholder : currentEntry())
  }

  func getTimeline(in context: Context, completion: @escaping (Timeline<WordEntry>) -> Void) {
    let entry = currentEntry()
    let nextMidnight = Calendar.current.nextDate(
      after: Date(),
      matching: DateComponents(hour: 0, minute: 1),
      matchingPolicy: .nextTime
    ) ?? Date().addingTimeInterval(60 * 60 * 24)
    completion(Timeline(entries: [entry], policy: .after(nextMidnight)))
  }

  private func currentEntry() -> WordEntry {
    let defaults = UserDefaults(suiteName: appGroupId)
    let calendar = Calendar.current
    let start = calendar.startOfDay(for: Date())
    let epoch = calendar.date(from: DateComponents(year: 2024, month: 1, day: 1))!
    let dayNumber = calendar.dateComponents([.day], from: epoch, to: start).day ?? 0
    let bundled = vocabulary[dayNumber % vocabulary.count]

    let formatter = DateFormatter()
    formatter.calendar = calendar
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = "yyyy-MM-dd"
    let sharedIsCurrent = defaults?.string(forKey: "wotd_date") == formatter.string(from: start)
    let hanzi = sharedIsCurrent ? (defaults?.string(forKey: "wotd_hanzi") ?? bundled.0) : bundled.0
    let urlString = defaults?.string(forKey: "wotd_url")
      ?? "sinospark://word?hanzi=\(hanzi.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? hanzi)"

    return WordEntry(
      date: Date(),
      hanzi: hanzi,
      pinyin: sharedIsCurrent ? (defaults?.string(forKey: "wotd_pinyin") ?? bundled.1) : bundled.1,
      meaning: sharedIsCurrent ? (defaults?.string(forKey: "wotd_meaning") ?? bundled.2) : bundled.2,
      url: URL(string: sharedIsCurrent ? urlString : "sinospark://word?hanzi=\(hanzi.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? hanzi)") ?? WordEntry.placeholder.url
    )
  }
}

struct WordOfTheDayView: View {
  @Environment(\.widgetFamily) private var family
  @Environment(\.colorScheme) private var colorScheme
  let entry: WordEntry

  private var ink: Color {
    colorScheme == .dark ? Color(red: 0.96, green: 0.94, blue: 0.86) : Color(red: 0.10, green: 0.10, blue: 0.11)
  }

  var body: some View {
    Group {
      if family == .systemMedium {
        mediumLayout
      } else {
        smallLayout
      }
    }
    .foregroundStyle(ink)
    .widgetURL(entry.url)
    .modifier(PaperBackground(colorScheme: colorScheme))
  }

  private var smallLayout: some View {
    VStack(alignment: .leading, spacing: 4) {
      label
      Spacer(minLength: 2)
      Text(entry.hanzi)
        .font(.system(size: entry.hanzi.count > 2 ? 44 : 54, weight: .semibold, design: .serif))
        .minimumScaleFactor(0.7)
        .lineLimit(1)
      Text(entry.pinyin)
        .font(.system(size: 14, weight: .semibold))
        .foregroundStyle(Color.orange)
        .lineLimit(1)
      Text(entry.meaning)
        .font(.caption)
        .foregroundStyle(ink.opacity(0.72))
        .lineLimit(2)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
  }

  private var mediumLayout: some View {
    HStack(spacing: 18) {
      VStack(alignment: .leading, spacing: 5) {
        label
        Spacer(minLength: 4)
        Text(entry.pinyin)
          .font(.headline)
          .foregroundStyle(Color.orange)
        Text(entry.meaning)
          .font(.subheadline)
          .foregroundStyle(ink.opacity(0.75))
          .lineLimit(2)
        Text("Tap to explore")
          .font(.caption2.weight(.semibold))
          .foregroundStyle(ink.opacity(0.48))
      }
      Spacer(minLength: 0)
      Text(entry.hanzi)
        .font(.system(size: entry.hanzi.count > 2 ? 58 : 72, weight: .semibold, design: .serif))
        .minimumScaleFactor(0.7)
        .lineLimit(1)
    }
  }

  private var label: some View {
    HStack(spacing: 5) {
      Circle().fill(Color.orange).frame(width: 6, height: 6)
      Text("WORD OF THE DAY")
        .font(.system(size: 10, weight: .bold))
        .tracking(0.8)
        .foregroundStyle(ink.opacity(0.6))
    }
  }
}

private struct PaperBackground: ViewModifier {
  let colorScheme: ColorScheme

  private var color: Color {
    Color(colorScheme == .dark
      ? UIColor(red: 0.10, green: 0.10, blue: 0.11, alpha: 1)
      : UIColor(red: 0.99, green: 0.98, blue: 0.91, alpha: 1))
  }

  @ViewBuilder
  func body(content: Content) -> some View {
    if #available(iOSApplicationExtension 17.0, *) {
      content.containerBackground(for: .widget) { color }
    } else {
      content.background(color)
    }
  }
}

@main
struct WordOfTheDayWidget: Widget {
  let kind = "WordOfTheDayWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: WordProvider()) { entry in
      WordOfTheDayView(entry: entry)
    }
    .configurationDisplayName("Word of the Day")
    .description("Learn a fresh Chinese word every day.")
    .supportedFamilies([.systemSmall, .systemMedium])
  }
}
