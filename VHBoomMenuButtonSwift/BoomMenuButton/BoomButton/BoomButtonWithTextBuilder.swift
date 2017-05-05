//
//  BoomButtonWithTextBuilder.swift
//  BoomMenuButton
//
//  Created by viktorhuang on 2017/5/2.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

public class BoomButtonWithTextBuilder: BoomButtonBuilder {

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
    
    public var textFrame: CGRect {
        didSet {
            if textFrame.equalTo(oldValue) {
                return
            }
            button?.textFrame = textFrame
            button?.resetLabel()
        }
    }
    
    public var textFont: UIFont {
        didSet {
            if textFont.isEqual(oldValue) {
                return
            }
            button?.textFont = textFont
            button?.resetLabel()
        }
    }
    
    public var textAlignment: NSTextAlignment {
        didSet {
            if textAlignment == oldValue {
                return
            }
            button?.textAlignment = textAlignment
            button?.resetLabel()
        }
    }
    
    public var textLineBreakMode: NSLineBreakMode = NSLineBreakMode.byTruncatingTail {
        didSet {
            if textLineBreakMode == oldValue {
                return
            }
            button?.textLineBreakMode = textLineBreakMode
            button?.resetLabel()
        }
    }
    
    public var textLines: Int = 1 {
        didSet {
            if textLines == oldValue {
                return
            }
            button?.textLines = textLines
            button?.resetLabel()
        }
    }
    
    public var textShadowColor: UIColor? {
        didSet {
            if Utils.isSameColor(textShadowColor, oldValue) {
                return
            }
            button?.textShadowColor = textShadowColor
            button?.resetLabel()
        }
    }
    
    public var textShadowOffsetX: CGFloat = 0 {
        didSet {
            if textShadowOffsetX == oldValue {
                return
            }
            button?.textShadowOffsetX = textShadowOffsetX
            button?.resetLabel()
        }
    }
    
    public var textShadowOffsetY: CGFloat = 0 {
        didSet {
            if textShadowOffsetY == oldValue {
                return
            }
            button?.textShadowOffsetY = textShadowOffsetY
            button?.resetLabel()
        }
    }
    
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
