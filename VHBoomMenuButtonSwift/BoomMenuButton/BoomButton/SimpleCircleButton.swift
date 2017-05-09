//
//  SimpleCircleButton.swift
//  BoomMenuButton
//
//  Created by Nightonke on 2017/4/28.
//  Copyright © 2017 Nightonke. All rights reserved.
//

class SimpleCircleButton: BoomButton {

    // MARK: Initialize
    
    override init(builder: BoomButtonBuilder) {
        super.init(builder: builder)
        
        if let simpleCircleButtonBuilder = builder as? SimpleCircleButtonBuilder {
            radius = simpleCircleButtonBuilder.radius
            round = simpleCircleButtonBuilder.round
            
            shadowPathRect = builder.shadowPathRect
            
            frame = CGRect.init(x: 0, y: 0, width: radius + radius, height: radius + radius)
            
            resetButtonLayer()
            resetNormalImage(builder: builder)
            resetHighlightedImage(builder: builder)
            resetUnableImage(builder: builder)
            resetImageView()
            
            if builder.unable {
                toUnable()
            } else {
                toNormal()
            }
        } else {
            fatalError("The builder used to initialize simple-circle-button should be simple-circle-button-builder")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("BoomButton does not support NSCoding")
    }
    
    // MARK: - Override Methods
    
    override func toNormal() {
        toNormalImage()
        toNormalButton()
    }
    
    override func toHighlighted() {
        toHighlightedImage()
        toHighlightedButton()
    }
    
    override func toUnable() {
        toUnableImage()
        toUnableButton()
    }
    
    override func type() -> ButtonEnum {
        return .simpleCircle
    }
    
    override func goneViews() -> [UIView] {
        var goneViews = [UIView]()
        if imageView != nil {
            goneViews.append(imageView!)
        }
        return goneViews
    }
    
    override func rotateViews() -> [UIView] {
        var rotateViews = [UIView]()
        if imageView != nil {
            rotateViews.append(imageView!)
        }
        return rotateViews
    }
    
    override func buttonWidth() -> CGFloat {
        return radius + radius
    }
    
    override func buttonHeight() -> CGFloat {
        return radius + radius
    }
    
    override func setAnchorPointOfLayer() {
        Utils.setAnchorPoint(CGPoint.init(x: 0.5, y: 0.5), layer: layer)
    }
    
    override func rotateAnchorPoint() -> CGPoint {
        return CGPoint.init(x: radius, y: radius)
    }
    
    override func centerPoint() -> CGPoint {
        return CGPoint.init(x: radius, y: radius)
    }

}
