//
//  TextOutsideCircleButtonBuilder.swift
//  BoomMenuButton
//
//  Created by Nightonke on 2017/5/3.
//  Copyright © 2017 Nightonke. All rights reserved.
//

public class TextOutsideCircleButtonBuilder: BoomButtonWithTextBuilder {

    /// Width (in points) of the boom-button (including the text label).
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **80**.
    public var width: CGFloat = 80 {
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
    /// The default value is **96**.
    public var height: CGFloat = 96 {
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
    
    /// Whether the boom-button is in a circular shape. If not, then the simple-circle-button looks like a simple-square-button. Only after the 'round' property is false does the corner-radius property work.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **true**.
    public var round: Bool = true {
        didSet {
            if round == oldValue {
                return
            }
            button?.round = round
            button?.resetButtonLayer()
            button?.resetShadow()
            if button?.lastStateEnum == .normal {
                button?.toNormalButton()
            } else if button?.lastStateEnum == .highlighted {
                button?.toHighlightedButton()
            } else if button?.lastStateEnum == .unable {
                button?.toUnableButton()
            }
        }
    }
    
    // MARK: - Initialize
    
    public override init() {
        super.init()
        textFrame = CGRect.init(x: 5, y: 86, width: 70, height: 10)
        textFont = UIFont.systemFont(ofSize: 10)
        shadowPathRect = CGRect.init(x: CGFloat(2), y: CGFloat(2), width: width - CGFloat(4), height: width - CGFloat(4))
    }
    
    override func build() -> TextOutsideCircleButton {
        let button = TextOutsideCircleButton.init(builder: self)
        self.button = button
        return button
    }
    
    override func type() -> ButtonEnum {
        return .textOutsideCircle
    }
}
