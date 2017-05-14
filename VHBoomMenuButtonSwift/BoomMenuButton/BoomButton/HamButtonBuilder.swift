//
//  HamButtonBuilder.swift
//  BoomMenuButton
//
//  Created by Nightonke on 2017/5/4.
//  Copyright © 2017 Nightonke. All rights reserved.
//

public class HamButtonBuilder: BoomButtonWithTextBuilder {

    /// Width (in points) of the boom-button (including the text label).
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **300**.
    public var width: CGFloat = 300 {
        didSet {
            if width == oldValue {
                return
            }
            button?.width = width
            button?.resetButtonLayer()
            button?.resetShadow()
            if button?.lastStateEnum == .normal {
                button?.toNormalButton()
            } else if button?.lastStateEnum == .highlighted {
                button?.toHighlightedButton()
            } else if button?.lastStateEnum == .unable {
                button?.toUnableButton()
            }
            button?.rotateAnchorPointInitialized = false
            button?.setRotateAnchorPoints()
        }
    }
    
    /// Height (in points) of the boom-button (including the text label).
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **60**.
    public var height: CGFloat = 60 {
        didSet {
            if height == oldValue {
                return
            }
            button?.height = height
            button?.resetButtonLayer()
            button?.resetShadow()
            if button?.lastStateEnum == .normal {
                button?.toNormalButton()
            } else if button?.lastStateEnum == .highlighted {
                button?.toHighlightedButton()
            } else if button?.lastStateEnum == .unable {
                button?.toUnableButton()
            }
            button?.rotateAnchorPointInitialized = false
            button?.setRotateAnchorPoints()
        }
    }
    
    /// Whether the boom-button contains a sub-text. All properties for sub-text only work when "containsSubText" is true.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **true**.
    public var containsSubText: Bool = true {
        didSet {
            if containsSubText == oldValue {
                return
            }
            button?.containsSubText = containsSubText
            button?.resetSubLabel()
        }
    }
    
    /// The sub-text on boom-button at normal state.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **nil**.
    public var normalSubText: String? {
        didSet {
            if normalSubText == oldValue {
                return
            }
            button?.normalSubText = normalSubText
            if button?.lastStateEnum == .normal {
                button?.toNormalSubText()
            }
        }
    }
    
    /// The sub-text on boom-button at highlighted state.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **nil**.
    public var highlightedSubText: String? {
        didSet {
            if highlightedSubText == oldValue {
                return
            }
            button?.highlightedSubText = highlightedSubText
            if button?.lastStateEnum == .highlighted {
                button?.toHighlightedSubText()
            }
        }
    }
    
    /// The sub-text on boom-button at unable state.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **nil**.
    public var unableSubText: String? {
        didSet {
            if unableSubText == oldValue {
                return
            }
            button?.unableSubText = unableSubText
            if button?.lastStateEnum == .unable {
                button?.toUnableSubText()
            }
        }
    }
    
    /// The attributed sub-text on boom-button at normal state.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **nil**.
    public var normalAttributedSubText: NSAttributedString? {
        didSet {
            if Utils.isSameAttributedString(normalAttributedSubText, oldValue) {
                return
            }
            button?.normalAttributedSubText = normalAttributedSubText
            if button?.lastStateEnum == .normal {
                button?.toNormalSubText()
            }
        }
    }
    
    /// The attributed sub-text on boom-button at highlighted state.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **nil**.
    public var highlightedAttributedSubText: NSAttributedString? {
        didSet {
            if Utils.isSameAttributedString(highlightedAttributedSubText, oldValue) {
                return
            }
            button?.highlightedAttributedSubText = highlightedAttributedSubText
            if button?.lastStateEnum == .highlighted {
                button?.toHighlightedSubText()
            }
        }
    }
    
    /// The attributed sub-text on boom-button at unable state.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **nil**.
    public var unableAttributedSubText: NSAttributedString? {
        didSet {
            if Utils.isSameAttributedString(unableAttributedSubText, oldValue) {
                return
            }
            button?.unableAttributedSubText = unableAttributedSubText
            if button?.lastStateEnum == .unable {
                button?.toUnableSubText()
            }
        }
    }
    
    /// The color of sub-text on boom-button at normal state.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **UIColor.white**.
    public var normalSubTextColor: UIColor = UIColor.white {
        didSet {
            if Utils.isSameColor(normalSubTextColor, oldValue) {
                return
            }
            button?.normalSubTextColor = normalSubTextColor
            if button?.lastStateEnum == .normal {
                button?.toNormalSubText()
            }
        }
    }
    
    /// The color of sub-text on boom-button at highlighted state.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **nil**.
    public var highlightedSubTextColor: UIColor? {
        didSet {
            if Utils.isSameColor(highlightedSubTextColor, oldValue) {
                return
            }
            button?.highlightedSubTextColor = highlightedSubTextColor
            if button?.lastStateEnum == .highlighted {
                button?.toHighlightedSubText()
            }
        }
    }
    
    /// The color of sub-text on boom-button at unable state.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **nil**.
    public var unableSubTextColor: UIColor? {
        didSet {
            if Utils.isSameColor(unableSubTextColor, oldValue) {
                return
            }
            button?.unableSubTextColor = unableSubTextColor
            if button?.lastStateEnum == .unable {
                button?.toUnableSubText()
            }
        }
    }
    
    /// The frame of sub-text on boom-button.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is CGRect.init(x: 70, y: 35, width: boom-button width - 80, height: 15).
    public var subTextFrame: CGRect = CGRect.init(x: 70, y: 35, width: 300 - 80, height: 15) {
        didSet {
            if subTextFrame == oldValue {
                return
            }
            button?.subTextFrame = subTextFrame
            button?.resetSubLabel()
        }
    }
    
    /// The font of sub-text on boom-button.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is UIFont.systemFont(ofSize: 9).
    public var subTextFont: UIFont = UIFont.systemFont(ofSize: 9) {
        didSet {
            if subTextFont.isEqual(oldValue) {
                return
            }
            button?.subTextFont = subTextFont
            button?.resetSubLabel()
        }
    }
    
    /// The alignment of sub-text on boom-button.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **NSTextAlignment.left**.
    public var subTextAlignment: NSTextAlignment = NSTextAlignment.left {
        didSet {
            if subTextAlignment == oldValue {
                return
            }
            button?.subTextAlignment = subTextAlignment
            button?.resetSubLabel()
        }
    }
    
    /// The line break mode of sub-text on boom-button.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **NSLineBreakMode.byTruncatingTail**.
    public var subTextLineBreakMode: NSLineBreakMode = NSLineBreakMode.byTruncatingTail {
        didSet {
            if subTextLineBreakMode == oldValue {
                return
            }
            button?.subTextLineBreakMode = subTextLineBreakMode
            button?.resetSubLabel()
        }
    }
    
    /// The maximum number of lines to use for sub-text on boom-button.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **1**.
    public var subTextLines: Int = 1 {
        didSet {
            if subTextLines == oldValue {
                return
            }
            button?.subTextLines = subTextLines
            button?.resetSubLabel()
        }
    }
    
    /// The color of shadow for sub-text on boom-button.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **nil**.
    public var subTextShadowColor: UIColor? {
        didSet {
            if Utils.isSameColor(subTextShadowColor, oldValue) {
                return
            }
            button?.subTextShadowColor = subTextShadowColor
            button?.resetSubLabel()
        }
    }
    
    /// The shadow offset (in points) on x axis for sub-text on boom-button.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **0**.
    public var subTextShadowOffsetX: CGFloat = 0 {
        didSet {
            if subTextShadowOffsetX == oldValue {
                return
            }
            button?.subTextShadowOffsetX = subTextShadowOffsetX
            button?.resetSubLabel()
        }
    }
    
    /// The shadow offset (in points) on y axis for sub-text on boom-button.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **0**.
    public var subTextShadowOffsetY: CGFloat = 0 {
        didSet {
            if subTextShadowOffsetY == oldValue {
                return
            }
            button?.subTextShadowOffsetY = subTextShadowOffsetY
            button?.resetSubLabel()
        }
    }
    
    // MARK: - Initialize
    
    public override init() {
        super.init()
        shadowPathRect = CGRect.init(x: CGFloat(2), y: CGFloat(2), width: width - CGFloat(4), height: height - CGFloat(4))
        imageFrame = CGRect.init(x: 0, y: 0, width: 60, height: 60)
        textFrame = CGRect.init(x: 70, y: 15, width: width - 80, height: 20)
        textFont = UIFont.systemFont(ofSize: 15)
        textAlignment = NSTextAlignment.left
    }
    
    override func build() -> HamButton {
        let button = HamButton.init(builder: self)
        self.button = button
        return button
    }
    
    override func type() -> ButtonEnum {
        return .ham
    }
    
}
