//
//  BoomButtonWithTextBuilder.swift
//  BoomMenuButton
//
//  Created by Nightonke on 2017/5/2.
//  Copyright © 2017 Nightonke. All rights reserved.
//

public class BoomButtonWithTextBuilder: BoomButtonBuilder {

    /// The text on boom-button at normal state.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **nil**.
    public var normalText: String? {
        didSet {
            if normalText == oldValue {
                return
            }
            button?.normalText = normalText
            if button?.lastStateEnum == .normal {
                button?.toNormalText()
            }
        }
    }
    
    /// The text on boom-button at highlighted state.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **nil**.
    public var highlightedText: String? {
        didSet {
            if highlightedText == oldValue {
                return
            }
            button?.highlightedText = highlightedText
            if button?.lastStateEnum == .highlighted {
                button?.toHighlightedText()
            }
        }
    }
    
    /// The text on boom-button at unable state.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **nil**.
    public var unableText: String? {
        didSet {
            if unableText == oldValue {
                return
            }
            button?.unableText = unableText
            if button?.lastStateEnum == .unable {
                button?.toUnable()
            }
        }
    }
    
    /// The attributed text on boom-button at normal state.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **nil**.
    public var normalAttributedText: NSAttributedString? {
        didSet {
            if Utils.isSameAttributedString(normalAttributedText, oldValue) {
                return
            }
            button?.normalAttributedText = normalAttributedText
            if button?.lastStateEnum == .normal {
                button?.toNormalText()
            }
        }
    }
    
    /// The attributed text on boom-button at highlighted state.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **nil**.
    public var highlightedAttributedText: NSAttributedString? {
        didSet {
            if Utils.isSameAttributedString(highlightedAttributedText, oldValue) {
                return
            }
            button?.highlightedAttributedText = highlightedAttributedText
            if button?.lastStateEnum == .highlighted {
                button?.toHighlightedText()
            }
        }
    }
    
    /// The attributed text on boom-button at unable state.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **nil**.
    public var unableAttributedText: NSAttributedString? {
        didSet {
            if Utils.isSameAttributedString(unableAttributedText, oldValue) {
                return
            }
            button?.unableAttributedText = unableAttributedText
            if button?.lastStateEnum == .unable {
                button?.toUnable()
            }
        }
    }
    
    /// The color of text on boom-button at normal state.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **UIColor.white**.
    public var normalTextColor: UIColor = UIColor.white {
        didSet {
            if Utils.isSameColor(normalTextColor, oldValue) {
                return
            }
            button?.normalTextColor = normalTextColor
            if button?.lastStateEnum == .normal {
                button?.toNormalText()
            }
        }
    }
    
    /// The color of text on boom-button at highlighted state.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **nil**.
    public var highlightedTextColor: UIColor? {
        didSet {
            if Utils.isSameColor(highlightedTextColor, oldValue) {
                return
            }
            button?.highlightedTextColor = highlightedTextColor
            if button?.lastStateEnum == .highlighted {
                button?.toHighlightedText()
            }
        }
    }
    
    /// The color of text on boom-button at unable state.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **nil**.
    public var unableTextColor: UIColor? {
        didSet {
            if Utils.isSameColor(unableTextColor, oldValue) {
                return
            }
            button?.unableTextColor = unableTextColor
            if button?.lastStateEnum == .unable {
                button?.toUnableText()
            }
        }
    }
    
    /// The frame of text on boom-button.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value depends on different type of boom-buttons. Check the init methods in builders of different boom-buttons for more information.
    public var textFrame: CGRect {
        didSet {
            if textFrame.equalTo(oldValue) {
                return
            }
            button?.textFrame = textFrame
            button?.resetLabel()
        }
    }
    
    /// The font of text on boom-button.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value depends on different type of boom-buttons. Check the init methods in builders of different boom-buttons for more information.
    public var textFont: UIFont {
        didSet {
            if textFont.isEqual(oldValue) {
                return
            }
            button?.textFont = textFont
            button?.resetLabel()
        }
    }
    
    /// The alignment of text on boom-button.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value depends on different type of boom-buttons. Check the init methods in builders of different boom-buttons for more information.
    public var textAlignment: NSTextAlignment {
        didSet {
            if textAlignment == oldValue {
                return
            }
            button?.textAlignment = textAlignment
            button?.resetLabel()
        }
    }
    
    /// The line break mode of text on boom-button.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **NSLineBreakMode.byTruncatingTail**.
    public var textLineBreakMode: NSLineBreakMode = NSLineBreakMode.byTruncatingTail {
        didSet {
            if textLineBreakMode == oldValue {
                return
            }
            button?.textLineBreakMode = textLineBreakMode
            button?.resetLabel()
        }
    }
    
    /// The maximum number of lines to use for text on boom-button.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **1**.
    public var textLines: Int = 1 {
        didSet {
            if textLines == oldValue {
                return
            }
            button?.textLines = textLines
            button?.resetLabel()
        }
    }
    
    /// The color of shadow for text on boom-button.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **nil**.
    public var textShadowColor: UIColor? {
        didSet {
            if Utils.isSameColor(textShadowColor, oldValue) {
                return
            }
            button?.textShadowColor = textShadowColor
            button?.resetLabel()
        }
    }
    
    /// The shadow offset (in points) on x axis for text on boom-button.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **0**.
    public var textShadowOffsetX: CGFloat = 0 {
        didSet {
            if textShadowOffsetX == oldValue {
                return
            }
            button?.textShadowOffsetX = textShadowOffsetX
            button?.resetLabel()
        }
    }
    
    /// The shadow offset (in points) on y axis for text on boom-button.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **0**.
    public var textShadowOffsetY: CGFloat = 0 {
        didSet {
            if textShadowOffsetY == oldValue {
                return
            }
            button?.textShadowOffsetY = textShadowOffsetY
            button?.resetLabel()
        }
    }
    
    /// Whether the text plays rotation animation when booming and rebooming.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value depends on different type of boom-buttons. Check the init methods in builders of different boom-buttons for more information.
    public var rotateText: Bool {
        didSet {
            if rotateText == oldValue {
                return
            }
            button?.rotateText = rotateText
        }
    }
    
    public override init() {
        textFrame = CGRect.zero
        textFont = UIFont.systemFont(ofSize: 8)
        textAlignment = NSTextAlignment.center
        rotateText = true
        
        super.init()
    }
    
}
