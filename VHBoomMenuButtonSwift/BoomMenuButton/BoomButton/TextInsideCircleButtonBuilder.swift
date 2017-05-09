//
//  TextInsideCircleButtonBuilder.swift
//  BoomMenuButton
//
//  Created by Nightonke on 2017/5/3.
//  Copyright © 2017 Nightonke. All rights reserved.
//

import UIKit

public class TextInsideCircleButtonBuilder: BoomButtonWithTextBuilder {

    /// The radius (in points) of the circular (or square) button.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **40**.
    public var radius: CGFloat = 40 {
        didSet {
            if radius == oldValue {
                return
            }
            button?.radius = radius
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
        textFrame = CGRect.init(x: 15, y: 52, width: 50, height: 20)
        textFont = UIFont.systemFont(ofSize: 8)
        shadowPathRect = CGRect.init(x: 2, y: 2, width: radius + radius - 4, height: radius + radius - 4)
    }
    
    override func build() -> TextInsideCircleButton {
        let button = TextInsideCircleButton.init(builder: self)
        self.button = button
        return button
    }
    
    override func type() -> ButtonEnum {
        return .textInsideCircle
    }
}
