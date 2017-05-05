//
//  SimpleCircleButtonBuilder.swift
//  BoomMenuButton
//
//  Created by viktorhuang on 2017/4/28.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

public class SimpleCircleButtonBuilder: BoomButtonBuilder {

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
    
    public var round = true {
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
        shadowPathRect = CGRect.init(x: 2, y: 2, width: radius + radius - 4, height: radius + radius - 4)
    }
    
    override func build() -> SimpleCircleButton {
        let button = SimpleCircleButton.init(builder: self)
        self.button = button
        return button
    }
    
    override func type() -> ButtonEnum {
        return .simpleCircle
    }
    
}
