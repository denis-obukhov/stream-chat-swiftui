//
// Copyright © 2026 Stream.io Inc. All rights reserved.
//

import SwiftUI

struct MoreReactionsView: View {
    @Injected(\.colors) private var colors
    @Injected(\.images) private var images

    private let columns: [GridItem] = Array(
        repeating: GridItem(.fixed(52), spacing: 12, alignment: .center),
        count: 6
    )

    private let emojiSize: CGFloat = 52

    var onEmojiTap: (String) -> Void

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(availableEmojis, id: \.key) { entry in
                    Button {
                        onEmojiTap(entry.key)
                    } label: {
                        Text(entry.value)
                            .font(.system(size: 30))
                            .frame(width: emojiSize, height: emojiSize)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel(entry.value)
                }
            }
            .padding(8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .accessibilityIdentifier("MoreReactionsView")
        .background(Color(colors.background).edgesIgnoringSafeArea(.all))
        .edgesIgnoringSafeArea(.bottom)
    }

    private var availableEmojis: [AvailableEmoji] {
        images.availableEmojis.compactMap { dictionary in
            guard let key = dictionary["key"], let value = dictionary["value"] else { return nil }
            return AvailableEmoji(key: key, value: value)
        }
    }
}

struct MoreReactionsDetentsModifier: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content.presentationDetents([.medium, .large])
        } else {
            content
        }
    }
}

struct AvailableEmoji {
    let key: String
    let value: String
}
