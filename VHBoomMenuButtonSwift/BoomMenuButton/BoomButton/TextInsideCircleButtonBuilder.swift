//
//  TextInsideCircleButtonBuilder.swift
//  BoomMenuButton
//
//  Created by viktorhuang on 2017/5/3.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

import UIKit

public class TextInsideCircleButtonBuilder: BoomButtonWithTextBuilder {

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
