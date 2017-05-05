//
//  HamButtonBuilder.swift
//  BoomMenuButton
//
//  Created by viktorhuang on 2017/5/4.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

public class HamButtonBuilder: BoomButtonWithTextBuilder {

    public var width: CGFloat = Utils.screenWidth() - 40 {
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
    
    public var containsSubText: Bool = true {
        didSet {
            if containsSubText == oldValue {
                return
            }
            button?.containsSubText = containsSubText
            button?.resetSubLabel()
        }
    }
    
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
    
    public var subTextFrame: CGRect = CGRect.init(x: 70, y: 35, width: Utils.screenWidth() - 80, height: 15) {
        didSet {
            if subTextFrame == oldValue {
                return
            }
            button?.subTextFrame = subTextFrame
            button?.resetSubLabel()
        }
    }
    
    public var subTextFont: UIFont = UIFont.systemFont(ofSize: 9) {
        didSet {
            if subTextFont.isEqual(oldValue) {
                return
            }
            button?.subTextFont = subTextFont
            button?.resetSubLabel()
        }
    }
    
    public var subTextAlignment: NSTextAlignment = NSTextAlignment.left {
        didSet {
            if subTextAlignment == oldValue {
                return
            }
            button?.subTextAlignment = subTextAlignment
            button?.resetSubLabel()
        }
    }
    
    public var subTextLineBreakMode: NSLineBreakMode = NSLineBreakMode.byTruncatingTail {
        didSet {
            if subTextLineBreakMode == oldValue {
                return
            }
            button?.subTextLineBreakMode = subTextLineBreakMode
            button?.resetSubLabel()
        }
    }
    
    public var subTextLines: Int = 1 {
        didSet {
            if subTextLines == oldValue {
                return
            }
            button?.subTextLines = subTextLines
            button?.resetSubLabel()
        }
    }
    
    public var subTextShadowColor: UIColor? {
        didSet {
            if Utils.isSameColor(subTextShadowColor, oldValue) {
                return
            }
            button?.subTextShadowColor = subTextShadowColor
            button?.resetSubLabel()
        }
    }
    
    public var subTextShadowOffsetX: CGFloat = 0 {
        didSet {
            if subTextShadowOffsetX == oldValue {
                return
            }
            button?.subTextShadowOffsetX = subTextShadowOffsetX
            button?.resetSubLabel()
        }
    }
    
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
