//
// Copyright © 2026 Stream.io Inc. All rights reserved.
//

import StreamChat
import SwiftUI

struct ReactionsOverlayContainer: View {
    @Injected(\.utils) private var utils
    @Injected(\.colors) private var colors
    @Injected(\.images) private var images

    let message: ChatMessage
    let contentRect: CGRect
    var onReactionTap: (MessageReactionType) -> Void
    var onMoreReactionsTap: () -> Void

    init(
        message: ChatMessage,
        contentRect: CGRect,
        onReactionTap: @escaping (MessageReactionType) -> Void,
        onMoreReactionsTap: @escaping () -> Void = { }
    ) {
        self.message = message
        self.contentRect = contentRect
        self.onReactionTap = onReactionTap
        self.onMoreReactionsTap = onMoreReactionsTap
    }

    var body: some View {
        VStack {
            ReactionsHStack(message: message) {
                ReactionsAnimatableView(
                    message: message,
                    useLargeIcons: true,
                    reactions: reactions,
                    onReactionTap: onReactionTap,
                    onMoreReactionsTap: onMoreReactionsTap
                )
            }

            Spacer()
        }
        .offset(
            x: message.reactionOffsetX(
                for: contentRect,
                reactionsSize: reactionsSize
            ),
            y: -20
        )
    }

    private var reactions: [MessageReactionType] {
        images.availableMessagesReactionEmojis.keys
            .map { $0 }
            .sorted(by: utils.sortReactions)
    }

    private var reactionsSize: CGFloat {
        let entrySize: CGFloat = 36
        let spacing: CGFloat = 12
        let count = CGFloat(reactions.count + 1)
        return count * entrySize + spacing * max(0, count - 1)
    }
}

public extension ChatMessage {
    func reactionOffsetX(
        for contentRect: CGRect,
        availableWidth: CGFloat = UIScreen.main.bounds.width,
        reactionsSize: CGFloat
    ) -> CGFloat {
        if isRightAligned {
            var originX = contentRect.origin.x - reactionsSize / 2
            let total = originX + reactionsSize
            if total > availableWidth {
                originX = availableWidth - reactionsSize
            }
            return -(contentRect.origin.x - originX)
        } else {
            if contentRect.width < reactionsSize {
                return (reactionsSize - contentRect.width) / 2
            }

            let originX = contentRect.origin.x - reactionsSize / 2
            return contentRect.origin.x - originX
        }
    }
}

public struct ReactionsAnimatableView: View {
    @Injected(\.colors) private var colors

    let message: ChatMessage
    var useLargeIcons = false
    var reactions: [MessageReactionType]
    var onReactionTap: (MessageReactionType) -> Void
    var onMoreReactionsTap: () -> Void

    @State var animationStates: [CGFloat]

    public init(
        message: ChatMessage,
        useLargeIcons: Bool = false,
        reactions: [MessageReactionType],
        onReactionTap: @escaping (MessageReactionType) -> Void,
        onMoreReactionsTap: @escaping () -> Void = { }
    ) {
        self.message = message
        self.useLargeIcons = useLargeIcons
        self.reactions = reactions
        self.onReactionTap = onReactionTap
        self.onMoreReactionsTap = onMoreReactionsTap
        _animationStates = State(
            initialValue: [CGFloat](repeating: 0, count: reactions.count)
        )
    }

    public var body: some View {
        HStack(spacing: 12) {
            ForEach(reactions) { reaction in
                ReactionAnimatableView(
                    message: message,
                    reaction: reaction,
                    useLargeIcons: useLargeIcons,
                    reactions: reactions,
                    animationStates: $animationStates,
                    onReactionTap: onReactionTap
                )
            }
            Button {
                onMoreReactionsTap()
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color(colors.text))
                    .padding(.all, 6)
            }
            .frame(width: 32, height: 32)
            .overlay(
                Circle().strokeBorder(Color(colors.innerBorder), lineWidth: 1)
            )
            .accessibilityLabel("More reactions")
            .accessibilityIdentifier("moreReactions")
        }
        .padding(.all, 6)
        .padding(.horizontal, 4)
        .reactionsBubble(for: message, background: colors.background8)
    }
}

public struct ReactionAnimatableView: View {
    @Injected(\.colors) private var colors

    let message: ChatMessage
    let reaction: MessageReactionType
    var useLargeIcons = false
    var reactions: [MessageReactionType]
    @Binding var animationStates: [CGFloat]
    var onReactionTap: (MessageReactionType) -> Void

    public init(
        message: ChatMessage,
        reaction: MessageReactionType,
        useLargeIcons: Bool = false,
        reactions: [MessageReactionType],
        animationStates: Binding<[CGFloat]>,
        onReactionTap: @escaping (MessageReactionType) -> Void
    ) {
        self.message = message
        self.reaction = reaction
        self.useLargeIcons = useLargeIcons
        self.reactions = reactions
        _animationStates = animationStates
        self.onReactionTap = onReactionTap
    }

    public var body: some View {
        if let image = iconProvider(for: reaction) {
            Button {
                onReactionTap(reaction)
            } label: {
                reactionImage(image)
            }
            .background(reactionSelectedBackgroundColor(for: reaction).cornerRadius(8))
            .scaleEffect(index(for: reaction) != nil ? animationStates[index(for: reaction)!] : 1)
            .onAppear {
                guard let index = index(for: reaction) else {
                    return
                }

                withAnimation(
                    .interpolatingSpring(
                        stiffness: 170,
                        damping: 8
                    )
                    .delay(0.1 * CGFloat(index + 1))
                ) {
                    animationStates[index] = 1
                }
            }
            .accessibilityElement(children: .contain)
            .accessibilityIdentifier("reaction-\(reaction.rawValue)")
        }
    }

    private func reactionSelectedBackgroundColor(for reaction: MessageReactionType) -> Color? {
        var colors = colors
        guard let color = colors.selectedReactionBackgroundColor else {
            return nil
        }

        let backgroundColor: Color? = userReactionIDs.contains(reaction) ? Color(color) : nil
        return backgroundColor
    }

    private func index(for reaction: MessageReactionType) -> Int? {
        let index = reactions.firstIndex(where: { type in
            type == reaction
        })

        return index
    }

    @ViewBuilder
    private func reactionImage(_ image: UIImage) -> some View {
        let imageView = Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .frame(width: useLargeIcons ? 25 : 20, height: useLargeIcons ? 27 : 20)
        if let tint = color(for: reaction) {
            imageView.foregroundColor(tint)
        } else {
            imageView
        }
    }

    private func iconProvider(for reaction: MessageReactionType) -> UIImage? {
        ReactionsIconProvider.icon(for: reaction, useLargeIcons: useLargeIcons)
    }

    private func color(for reaction: MessageReactionType) -> Color? {
        ReactionsIconProvider.color(for: reaction, userReactionIDs: userReactionIDs)
    }

    private var userReactionIDs: Set<MessageReactionType> {
        Set(message.currentUserReactions.map(\.type))
    }
}
