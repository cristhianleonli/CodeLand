//
//  GreatWidget.swift
//  GreatWidget
//
//  Created by Cristhian Leon on 19.03.21.
//

import WidgetKit
import SwiftUI

struct EmojiEntry: TimelineEntry {
    var date: Date
    let emoji: Emoji
}

struct Provider: TimelineProvider {
    
    @AppStorage("emoji", store: UserDefaults(suiteName: "group.replicatescreens"))
    var emojiData: Data = Data()
    
    func getSnapshot(in context: Context, completion: @escaping (EmojiEntry) -> Void) {
        guard let emoji = try? JSONDecoder().decode(Emoji.self, from: emojiData) else {
            return
        }

        let entry = EmojiEntry(date: Date(), emoji: emoji)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<EmojiEntry>) -> Void) {
        guard let emoji = try? JSONDecoder().decode(Emoji.self, from: emojiData) else {
            return
        }

        let entry = EmojiEntry(date: Date(), emoji: emoji)
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }
    
    func placeholder(in context: Context) -> EmojiEntry {
        EmojiEntry(date: Date(), emoji: Emoji(icon: "🧠", name: "smart", description: "smart people"))
    }
}

struct PlaceholderView: View {
    var body: some View {
        EmojiView(emoji: Emoji(icon: "🥰", name: "heart", description: "Love"))
    }
}

struct WidgetEntryView: View {
    let entry: Provider.Entry
    
    var body: some View {
        EmojiView(emoji: entry.emoji)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

@main
struct GreatWidget: Widget {
    let kind: String = "GreatWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: Provider()) { entry in
            WidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
