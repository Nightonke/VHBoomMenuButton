//
//  TextOutsideCircleButton.swift
//  BoomMenuButton
//
//  Created by Nightonke on 2017/5/3.
//  Copyright © 2017 Nightonke. All rights reserved.
//

class TextOutsideCircleButton: BoomButtonWithText {

    // MARK: Initialize
    
    override init(builder: BoomButtonBuilder) {
        super.init(builder: builder)
        
        if let textOutsideButtonBuilder = builder as? TextOutsideCircleButtonBuilder {
            width = textOutsideButtonBuilder.width
            height = textOutsideButtonBuilder.height
            round = textOutsideButtonBuilder.round
            
            shadowPathRect = builder.shadowPathRect
            
            frame = CGRect.init(x: 0, y: 0, width: width, height: height)
            
            resetButtonLayer()
            resetNormalImage(builder: builder)
            resetHighlightedImage(builder: builder)
            resetUnableImage(builder: builder)
            resetImageView()
            resetLabel()
            
            if builder.unable {
                toUnable()
            } else {
                toNormal()
            }
        } else {
            fatalError("The builder used to initialize text-outside-circle-button should be text-outside-circle-button-builder")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("BoomButton does not support NSCoding")
    }
    
    // MARK: - Override Methods
    
    override func toNormal() {
        toNormalImage()
        toNormalText()
        toNormalButton()
    }
    
    override func toHighlighted() {
        toHighlightedImage()
        toHighlightedText()
        toHighlightedButton()
    }
    
    override func toUnable() {
        toUnableImage()
        toUnableText()
        toUnableButton()
    }
    
    override func type() -> ButtonEnum {
        return .textOutsideCircle
    }
    
    override func goneViews() -> [UIView] {
        var goneViews = [UIView]()
        if imageView != nil {
            goneViews.append(imageView!)
        }
        if label != nil {
            goneViews.append(label!)
        }
        return goneViews
    }
    
    override func rotateViews() -> [UIView] {
        var rotateViews = [UIView]()
        if imageView != nil && rotateImage {
            rotateViews.append(imageView!)
        }
        if label != nil && rotateText {
            rotateViews.append(label!)
        }
        return rotateViews
    }
    
    override func buttonWidth() -> CGFloat {
        return width
    }
    
    override func buttonHeight() -> CGFloat {
        return width
    }
    
    override func setAnchorPointOfLayer() {
        Utils.setAnchorPoint(CGPoint.init(x: 0.5, y: width / 2 / height), layer: layer)
    }
    
    override func rotateAnchorPoint() -> CGPoint {
        return CGPoint.init(x: width / 2, y: width / 2)
    }
    
    override func centerPoint() -> CGPoint {
        return CGPoint.init(x: width / 2, y: width / 2)
    }

}
