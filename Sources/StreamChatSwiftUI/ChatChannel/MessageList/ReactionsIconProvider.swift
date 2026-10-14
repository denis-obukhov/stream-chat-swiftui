//
// Copyright © 2026 Stream.io Inc. All rights reserved.
//

import StreamChat
import SwiftUI
import UIKit

class ReactionsIconProvider {
    static var colors: ColorPalette { InjectedValues[\.colors] }
    static var images: Images { InjectedValues[\.images] }

    static func icon(for reaction: MessageReactionType, useLargeIcons: Bool) -> UIImage? {
        if let emoji = emoji(for: reaction),
           let emojiImage = image(from: emoji, useLargeIcons: useLargeIcons) {
            return emojiImage
        }
        if useLargeIcons {
            return images.availableReactions[reaction]?.largeIcon
        } else {
            return images.availableReactions[reaction]?.smallIcon
        }
    }

    static func color(for reaction: MessageReactionType, userReactionIDs: Set<MessageReactionType>) -> Color? {
        // Emoji bitmaps keep their own colors. A foreground tint flattens them.
        if emoji(for: reaction) != nil {
            return nil
        }
        let containsUserReaction = userReactionIDs.contains(reaction)
        var colors = colors
        let color = containsUserReaction ? colors.reactionCurrentUserColor : colors.reactionOtherUserColor

        if let color = color {
            return Color(color)
        } else {
            return nil
        }
    }

    static func emoji(for reaction: MessageReactionType) -> String? {
        if let emoji = images.availableMessagesReactionEmojis[reaction] {
            return emoji
        }
        return images.availableEmojis.first { $0["key"] == reaction.rawValue }?["value"]
    }
}

private extension ReactionsIconProvider {
    static func image(from emoji: String, useLargeIcons: Bool) -> UIImage? {
        let fontSize: CGFloat = useLargeIcons ? 28 : 22
        let font = UIFont.systemFont(ofSize: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        let text = emoji as NSString
        var size = text.size(withAttributes: attributes)
        size.width = ceil(size.width)
        size.height = ceil(size.height)

        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            UIColor.clear.set()
            text.draw(at: .zero, withAttributes: attributes)
        }
    }
}
