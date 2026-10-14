//
// Copyright © 2026 Stream.io Inc. All rights reserved.
//

import Foundation
import StreamChat
import UIKit

/// Provides access to the images used in the SDK.
public class Images {
    public init() {
        // Public init.
    }
    
    /// A private internal function that will safely load an image from the bundle or return a circle image as backup
    /// - Parameter imageName: The required image name to load from the bundle
    /// - Returns: A UIImage that is either the correct image from the bundle or backup circular image
    private static func loadImageSafely(with imageName: String) -> UIImage {
        if let image = UIImage(named: imageName, in: .streamChatUI) {
            return image
        } else {
            log.error(
                """
                \(imageName) image has failed to load from the bundle please make sure it's included in your assets folder.
                A default 'red' circle image has been added.
                """
            )
            return UIImage.circleImage
        }
    }
    
    // MARK: - General

    public var loadingIndicator: UIImage = loadImageSafely(with: "loading_indicator")
    public var close: UIImage = UIImage(systemName: "xmark")!
    public var closeFilled: UIImage = UIImage(systemName: "xmark.circle.fill")!

    public var closeCircleTransparent: UIImage = loadImageSafely(with: "close_circle_transparent")
    public var discardAttachment: UIImage = loadImageSafely(with: "close_circle_filled")
    public var back: UIImage = loadImageSafely(with: "icn_back")
    public var onlyVisibleToCurrentUser = loadImageSafely(with: "eye")
    public var more = loadImageSafely(with: "icn_more")
    public var share: UIImage = UIImage(systemName: "square.and.arrow.up")!

    public var commands: UIImage = loadImageSafely(with: "bolt")
    public var smallBolt: UIImage = loadImageSafely(with: "bolt_small")
    public var openAttachments: UIImage = loadImageSafely(with: "clip")
    public var shrinkInputArrow: UIImage = loadImageSafely(with: "arrow_shrink_input")
    public var sendArrow: UIImage = loadImageSafely(with: "arrow_send")
    public var scrollDownArrow: UIImage = loadImageSafely(with: "arrow_down")
    public var messageSent: UIImage = loadImageSafely(with: "checkmark_grey")
    public var whiteCheckmark: UIImage = loadImageSafely(with: "checkmark_white")
    public var readByAll: UIImage = loadImageSafely(with: "checkmark_double")
    public var messageReceiptSending: UIImage = loadImageSafely(with: "message_receipt_sending")
    public var confirmCheckmark: UIImage = loadImageSafely(with: "checkmark_confirm")
    public var bigConfirmCheckmark: UIImage = loadImageSafely(with: "checkmark_confirm_big")
    public var folder: UIImage = loadImageSafely(with: "folder")
    public var restart: UIImage = loadImageSafely(with: "restart")
    public var download: UIImage = UIImage(systemName: "icloud.and.arrow.down")!
    public var muted: UIImage = UIImage(systemName: "speaker.slash")!
    public var snapshot: UIImage = UIImage(systemName: "photo")!
    public var eye: UIImage = UIImage(systemName: "eye")!
    public var videoIndicator: UIImage = UIImage(systemName: "video.fill")!
    public var gallery: UIImage = UIImage(systemName: "square.grid.3x3.fill")!
    public var photoDefault: UIImage = UIImage(systemName: "photo")!
    public var pin: UIImage = loadImageSafely(with: "icn_pin")
    
    // MARK: - Recording
    
    public var sliderThumb: UIImage = loadImageSafely(with: "sliderThumb")

    // MARK: - Reactions

    public var reactionLoveSmall: UIImage = loadImageSafely(with: "reaction_love_small")
    public var reactionLoveBig: UIImage = loadImageSafely(with: "reaction_love_big")
    public var reactionLolSmall: UIImage = loadImageSafely(with: "reaction_lol_small")
    public var reactionLolBig: UIImage = loadImageSafely(with: "reaction_lol_big")
    public var reactionThumgsUpSmall: UIImage = loadImageSafely(with: "reaction_thumbsup_small")
    public var reactionThumgsUpBig: UIImage = loadImageSafely(with: "reaction_thumbsup_big")
    public var reactionThumgsDownSmall: UIImage = loadImageSafely(with: "reaction_thumbsdown_small")
    public var reactionThumgsDownBig: UIImage = loadImageSafely(with: "reaction_thumbsdown_big")
    public var reactionWutSmall: UIImage = loadImageSafely(with: "reaction_wut_small")
    public var reactionWutBig: UIImage = loadImageSafely(with: "reaction_wut_big")

    private var _availableReactions: [MessageReactionType: ChatMessageReactionAppearanceType]?
    public var availableReactions: [MessageReactionType: ChatMessageReactionAppearanceType] {
        get {
            _availableReactions ??
                [
                    .init(rawValue: "love"): ChatMessageReactionAppearance(
                        smallIcon: reactionLoveSmall,
                        largeIcon: reactionLoveBig
                    ),
                    .init(rawValue: "haha"): ChatMessageReactionAppearance(
                        smallIcon: reactionLolSmall,
                        largeIcon: reactionLolBig
                    ),
                    .init(rawValue: "like"): ChatMessageReactionAppearance(
                        smallIcon: reactionThumgsUpSmall,
                        largeIcon: reactionThumgsUpBig
                    ),
                    .init(rawValue: "sad"): ChatMessageReactionAppearance(
                        smallIcon: reactionThumgsDownSmall,
                        largeIcon: reactionThumgsDownBig
                    ),
                    .init(rawValue: "wow"): ChatMessageReactionAppearance(
                        smallIcon: reactionWutSmall,
                        largeIcon: reactionWutBig
                    )
                ]
        }
        set { _availableReactions = newValue }
    }

    private var _availableMessagesReactionEmojis: [MessageReactionType: String]?
    /// Emoji shown in the long-press reaction row. Keys match `availableReactions`.
    public var availableMessagesReactionEmojis: [MessageReactionType: String] {
        get {
            _availableMessagesReactionEmojis ?? [
                .init(rawValue: "haha"): "😂",
                .init(rawValue: "like"): "👍",
                .init(rawValue: "love"): "❤️",
                .init(rawValue: "sad"): "👎",
                .init(rawValue: "wow"): "😮"
            ]
        }
        set { _availableMessagesReactionEmojis = newValue }
    }

    public var availableEmojis: [[String: String]] = [
        ["key": "grinning", "value": "😀"],
        ["key": "smiley", "value": "😃"],
        ["key": "smile", "value": "😄"],
        ["key": "grin", "value": "😁"],
        ["key": "laughing", "value": "😆"],
        ["key": "sweat_smile", "value": "😅"],
        ["key": "rofl", "value": "🤣"],
        ["key": "haha", "value": "😂"],
        ["key": "slightly_smiling_face", "value": "🙂"],
        ["key": "upside_down_face", "value": "🙃"],
        ["key": "wink", "value": "😉"],
        ["key": "blush", "value": "😊"],
        ["key": "innocent", "value": "😇"],
        ["key": "smiling_face_with_three_hearts", "value": "🥰"],
        ["key": "heart_eyes", "value": "😍"],
        ["key": "star_struck", "value": "🤩"],
        ["key": "kissing_heart", "value": "😘"],
        ["key": "kissing", "value": "😗"],
        ["key": "kissing_closed_eyes", "value": "😚"],
        ["key": "kissing_smiling_eyes", "value": "😙"],
        ["key": "yum", "value": "😋"],
        ["key": "stuck_out_tongue", "value": "😛"],
        ["key": "stuck_out_tongue_winking_eye", "value": "😜"],
        ["key": "zany_face", "value": "🤪"],
        ["key": "stuck_out_tongue_closed_eyes", "value": "😝"],
        ["key": "money_mouth_face", "value": "🤑"],
        ["key": "hugs", "value": "🤗"],
        ["key": "hand_over_mouth", "value": "🤭"],
        ["key": "shushing_face", "value": "🤫"],
        ["key": "thinking", "value": "🤔"],
        ["key": "zipper_mouth_face", "value": "🤐"],
        ["key": "raised_eyebrow", "value": "🤨"],
        ["key": "neutral_face", "value": "😐"],
        ["key": "expressionless", "value": "😑"],
        ["key": "no_mouth", "value": "😶"],
        ["key": "face_in_clouds", "value": "😶‍🌫️"],
        ["key": "smirk", "value": "😏"],
        ["key": "unamused", "value": "😒"],
        ["key": "roll_eyes", "value": "🙄"],
        ["key": "grimacing", "value": "😬"],
        ["key": "lying_face", "value": "🤥"],
        ["key": "relieved", "value": "😌"],
        ["key": "pensive", "value": "😔"],
        ["key": "sleepy", "value": "😪"],
        ["key": "drooling_face", "value": "🤤"],
        ["key": "sleeping", "value": "😴"],
        ["key": "mask", "value": "😷"],
        ["key": "face_with_thermometer", "value": "🤒"],
        ["key": "face_with_head_bandage", "value": "🤕"],
        ["key": "nauseated_face", "value": "🤢"],
        ["key": "vomiting_face", "value": "🤮"],
        ["key": "sneezing_face", "value": "🤧"],
        ["key": "hot_face", "value": "🥵"],
        ["key": "cold_face", "value": "🥶"],
        ["key": "woozy_face", "value": "🥴"],
        ["key": "face_with_spiral_eyes", "value": "😵‍💫"],
        ["key": "exploding_head", "value": "🤯"],
        ["key": "cowboy_hat_face", "value": "🤠"],
        ["key": "partying_face", "value": "🥳"],
        ["key": "sunglasses", "value": "😎"],
        ["key": "nerd_face", "value": "🤓"],
        ["key": "monocle_face", "value": "🧐"],
        ["key": "confused", "value": "😕"],
        ["key": "worried", "value": "😟"],
        ["key": "slightly_frowning_face", "value": "🙁"],
        ["key": "frowning_face", "value": "☹️"],
        ["key": "wow", "value": "😮"],
        ["key": "hushed", "value": "😯"],
        ["key": "astonished", "value": "😲"],
        ["key": "flushed", "value": "😳"],
        ["key": "pleading_face", "value": "🥺"],
        ["key": "frowning", "value": "😦"],
        ["key": "anguished", "value": "😧"],
        ["key": "fearful", "value": "😨"],
        ["key": "cold_sweat", "value": "😰"],
        ["key": "disappointed_relieved", "value": "😥"],
        ["key": "cry", "value": "😢"],
        ["key": "sob", "value": "😭"],
        ["key": "scream", "value": "😱"],
        ["key": "confounded", "value": "😖"],
        ["key": "persevere", "value": "😣"],
        ["key": "disappointed", "value": "😞"],
        ["key": "sweat", "value": "😓"],
        ["key": "weary", "value": "😩"],
        ["key": "tired_face", "value": "😫"],
        ["key": "yawning_face", "value": "🥱"],
        ["key": "triumph", "value": "😤"],
        ["key": "rage", "value": "😡"],
        ["key": "angry", "value": "😠"],
        ["key": "cursing_face", "value": "🤬"],
        ["key": "smiling_imp", "value": "😈"],
        ["key": "imp", "value": "👿"],
        ["key": "skull", "value": "💀"],
        ["key": "skull_and_crossbones", "value": "☠️"],
        ["key": "poop", "value": "💩"],
        ["key": "clown_face", "value": "🤡"],
        ["key": "japanese_ogre", "value": "👹"],
        ["key": "japanese_goblin", "value": "👺"],
        ["key": "ghost", "value": "👻"],
        ["key": "alien", "value": "👽"],
        ["key": "space_invader", "value": "👾"],
        ["key": "robot", "value": "🤖"],
        ["key": "jack_o_lantern", "value": "🎃"],
        ["key": "smiley_cat", "value": "😺"],
        ["key": "smile_cat", "value": "😸"],
        ["key": "joy_cat", "value": "😹"],
        ["key": "heart_eyes_cat", "value": "😻"],
        ["key": "smirk_cat", "value": "😼"],
        ["key": "kissing_cat", "value": "😽"],
        ["key": "scream_cat", "value": "🙀"],
        ["key": "crying_cat_face", "value": "😿"],
        ["key": "pouting_cat", "value": "😾"],
        ["key": "like", "value": "👍"],
        ["key": "sad", "value": "👎"],
        ["key": "ok_hand", "value": "👌"],
        ["key": "pinched_fingers", "value": "🤌"],
        ["key": "pinching_hand", "value": "🤏"],
        ["key": "v", "value": "✌️"],
        ["key": "crossed_fingers", "value": "🤞"],
        ["key": "love_you_gesture", "value": "🤟"],
        ["key": "metal", "value": "🤘"],
        ["key": "call_me_hand", "value": "🤙"],
        ["key": "point_left", "value": "👈"],
        ["key": "point_right", "value": "👉"],
        ["key": "point_up_2", "value": "👆"],
        ["key": "point_down", "value": "👇"],
        ["key": "point_up", "value": "☝️"],
        ["key": "raised_hand", "value": "✋"],
        ["key": "raised_back_of_hand", "value": "🤚"],
        ["key": "raised_hand_with_fingers_splayed", "value": "🖐️"],
        ["key": "vulcan_salute", "value": "🖖"],
        ["key": "wave", "value": "👋"],
        ["key": "handshake", "value": "🤝"],
        ["key": "pray", "value": "🙏"],
        ["key": "muscle", "value": "💪"],
        ["key": "footprints", "value": "👣"],
        ["key": "eyes", "value": "👀"],
        ["key": "brain", "value": "🧠"],
        ["key": "heart_hands", "value": "🫶"],
        ["key": "kiss", "value": "💋"],
        ["key": "love", "value": "❤️"],
        ["key": "orange_heart", "value": "🧡"],
        ["key": "yellow_heart", "value": "💛"],
        ["key": "green_heart", "value": "💚"],
        ["key": "blue_heart", "value": "💙"],
        ["key": "purple_heart", "value": "💜"],
        ["key": "black_heart", "value": "🖤"],
        ["key": "white_heart", "value": "🤍"],
        ["key": "brown_heart", "value": "🤎"],
        ["key": "broken_heart", "value": "💔"],
        ["key": "heart_exclamation", "value": "❣️"],
        ["key": "two_hearts", "value": "💕"],
        ["key": "revolving_hearts", "value": "💞"],
        ["key": "heartbeat", "value": "💓"],
        ["key": "growing_heart", "value": "💗"],
        ["key": "sparkling_heart", "value": "💖"],
        ["key": "cupid", "value": "💘"],
        ["key": "gift_heart", "value": "💝"]
    ]

    // MARK: - MessageList

    public var messageListErrorIndicator: UIImage = loadImageSafely(with: "error_indicator")

    // MARK: - FileIcons

    public var file7z: UIImage = loadImageSafely(with: "7z")
    public var fileAac: UIImage = loadImageSafely(with: "aac")
    public var fileCsv: UIImage = loadImageSafely(with: "csv")
    public var fileDoc: UIImage = loadImageSafely(with: "doc")
    public var fileDocx: UIImage = loadImageSafely(with: "docx")
    public var fileHtml: UIImage = loadImageSafely(with: "html")
    public var fileMd: UIImage = loadImageSafely(with: "md")
    public var fileMp3: UIImage = loadImageSafely(with: "mp3")
    public var fileOdt: UIImage = loadImageSafely(with: "odt")
    public var filePdf: UIImage = loadImageSafely(with: "pdf")
    public var filePpt: UIImage = loadImageSafely(with: "ppt")
    public var filePptx: UIImage = loadImageSafely(with: "pptx")
    public var fileRar: UIImage = loadImageSafely(with: "rar")
    public var fileRtf: UIImage = loadImageSafely(with: "rtf")
    public var fileTargz: UIImage = loadImageSafely(with: "tar.gz")
    public var fileTxt: UIImage = loadImageSafely(with: "txt")
    public var fileXls: UIImage = loadImageSafely(with: "xls")
    public var fileXlsx: UIImage = loadImageSafely(with: "xlsx")
    public var filezip: UIImage = loadImageSafely(with: "zip")
    public var fileFallback: UIImage = loadImageSafely(with: "generic")

    private var _documentPreviews: [String: UIImage]?

    public var documentPreviews: [String: UIImage] {
        get { _documentPreviews ??
            [
                "7z": file7z,
                "csv": fileCsv,
                "doc": fileDoc,
                "docx": fileDocx,
                "html": fileHtml,
                "md": fileMd,
                "mp3": fileMp3,
                "odt": fileOdt,
                "pdf": filePdf,
                "ppt": filePpt,
                "pptx": filePptx,
                "rar": fileRar,
                "rtf": fileRtf,
                "tar.gz": fileTargz,
                "txt": fileTxt,
                "xls": fileXls,
                "xlsx": fileXlsx,
                "zip": filezip
            ]
        }
        set { _documentPreviews = newValue }
    }

    private var _fileIcons: [AttachmentFileType: UIImage]?
    public var fileIcons: [AttachmentFileType: UIImage] {
        get { _fileIcons ??
            [AttachmentFileType: UIImage](
                uniqueKeysWithValues: AttachmentFileType.allCases.compactMap {
                    guard let icon = UIImage(named: $0.rawValue, in: .streamChatUI) else { return nil }
                    return ($0, icon)
                }
            )
        }
        set { _fileIcons = newValue }
    }

    // MARK: - Message Actions

    public var messageActionInlineReply: UIImage = loadImageSafely(with: "icn_inline_reply")
    public var messageActionThreadReply: UIImage = loadImageSafely(with: "icn_thread_reply")
    public var messageActionEdit: UIImage = loadImageSafely(with: "icn_edit")
    public var messageActionCopy: UIImage = loadImageSafely(with: "icn_copy")
    public var messageActionBlockUser: UIImage = loadImageSafely(with: "icn_block_user")
    public var messageActionMuteUser: UIImage = loadImageSafely(with: "icn_mute_user")
    public var messageActionDelete: UIImage = loadImageSafely(with: "icn_delete")
    public var messageActionResend: UIImage = loadImageSafely(with: "icn_resend")

    // MARK: - Placeholders

    public var userAvatarPlaceholder1: UIImage = loadImageSafely(with: "pattern1")
    public var userAvatarPlaceholder2: UIImage = loadImageSafely(with: "pattern2")
    public var userAvatarPlaceholder3: UIImage = loadImageSafely(with: "pattern3")
    public var userAvatarPlaceholder4: UIImage = loadImageSafely(with: "pattern4")
    public var userAvatarPlaceholder5: UIImage = loadImageSafely(with: "pattern5")

    public var avatarPlaceholders: [UIImage] {
        [
            userAvatarPlaceholder1,
            userAvatarPlaceholder2,
            userAvatarPlaceholder3,
            userAvatarPlaceholder4,
            userAvatarPlaceholder5
        ]
    }
    
    public var imagePlaceholder: UIImage = UIImage(systemName: "photo")!
    public var personPlaceholder: UIImage = UIImage(systemName: "person.circle")!

    // MARK: - FileAttachmentIcons

    private var _fileAttachmentActionIcons: [LocalAttachmentState?: UIImage]?
    public var fileAttachmentActionIcons: [LocalAttachmentState?: UIImage] {
        get { _fileAttachmentActionIcons ??
            [
                .uploaded: download,
                .uploadingFailed: restart,
                nil: folder
            ]
        }
        set { _fileAttachmentActionIcons = newValue }
    }
    
    public var attachmentPickerPhotos: UIImage = UIImage(systemName: "photo")!
    public var attachmentPickerFolder: UIImage = UIImage(systemName: "folder")!
    public var attachmentPickerCamera: UIImage = UIImage(systemName: "camera")!
    public var attachmentPickerPolls: UIImage = loadImageSafely(with: "attachment_picker_polls")
    
    public var camera: UIImage = loadImageSafely(with: "camera")
    public var bigPlay: UIImage = loadImageSafely(with: "play_big")
    
    public var play: UIImage = loadImageSafely(with: "play")
    public var playFilled: UIImage = UIImage(systemName: "play.fill")!
    public var pause: UIImage = loadImageSafely(with: "pause")
    public var pauseFilled: UIImage = UIImage(systemName: "pause.fill")!
    
    public var checkmarkFilled: UIImage = UIImage(systemName: "checkmark.circle.fill")!

    // MARK: - CommandIcons

    public var commandBan: UIImage = loadImageSafely(with: "command_ban")
    public var commandFlag: UIImage = loadImageSafely(with: "command_flag")
    public var commandGiphy: UIImage = loadImageSafely(with: "command_giphy")
    public var commandImgur: UIImage = loadImageSafely(with: "command_imgur")
    public var commandMention: UIImage = loadImageSafely(with: "command_mention")
    public var commandMute: UIImage = loadImageSafely(with: "command_mute")
    public var commandUnban: UIImage = loadImageSafely(with: "command_unban")
    public var commandUnmute: UIImage = loadImageSafely(with: "command_unmute")
    public var commandFallback: UIImage = loadImageSafely(with: "command_fallback")

    private var _commandIcons: [String: UIImage]?
    public var commandIcons: [String: UIImage] {
        get { _commandIcons ??
            [
                "ban": commandBan,
                "flag": commandFlag,
                "giphy": commandGiphy,
                "imgur": commandImgur,
                "mention": commandMention,
                "mute": commandMute,
                "unban": commandUnban,
                "unmute": commandUnmute
            ]
        }
        set { _commandIcons = newValue }
    }
    
    // MARK: - MessageSearch
    
    public var searchIcon: UIImage = loadImageSafely(with: "icn_search")
    public var searchCloseIcon: UIImage = UIImage(systemName: "multiply.circle")!

    // MARK: - Threads

    public var threadIcon: UIImage = UIImage(systemName: "text.bubble")!
    
    // MARK: - No Content Icons
    
    public var noContent: UIImage = UIImage(
        systemName: "message",
        withConfiguration: UIImage.SymbolConfiguration(pointSize: 100, weight: .regular)
    ) ?? UIImage.circleImage
    public var noMedia: UIImage = UIImage(
        systemName: "folder",
        withConfiguration: UIImage.SymbolConfiguration(pointSize: 100, weight: .regular)
    ) ?? UIImage.circleImage
    public var noThreads: UIImage = UIImage(
        systemName: "text.bubble",
        withConfiguration: UIImage.SymbolConfiguration(pointSize: 100, weight: .regular)
    ) ?? UIImage.circleImage
}
