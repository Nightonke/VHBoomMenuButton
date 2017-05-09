//
//  HamButton.swift
//  BoomMenuButton
//
//  Created by Nightonke on 2017/5/4.
//  Copyright © 2017 Nightonke. All rights reserved.
//

class HamButton: BoomButtonWithText {

    // MARK: Initialize
    
    override init(builder: BoomButtonBuilder) {
        super.init(builder: builder)
        
        if let hamButtonBuilder = builder as? HamButtonBuilder {
            containsSubText = hamButtonBuilder.containsSubText
            
            normalSubText = hamButtonBuilder.normalSubText
            highlightedSubText = hamButtonBuilder.highlightedSubText
            unableSubText = hamButtonBuilder.unableSubText
            
            normalAttributedText = hamButtonBuilder.normalAttributedSubText
            highlightedAttributedSubText = hamButtonBuilder.highlightedAttributedSubText
            unableAttributedSubText = hamButtonBuilder.unableAttributedSubText
            
            normalSubTextColor = hamButtonBuilder.normalSubTextColor
            highlightedSubTextColor = hamButtonBuilder.highlightedSubTextColor
            unableSubTextColor = hamButtonBuilder.unableSubTextColor
            
            subTextFrame = hamButtonBuilder.subTextFrame
            subTextFont = hamButtonBuilder.subTextFont
            subTextAlignment = hamButtonBuilder.subTextAlignment
            subTextLineBreakMode = hamButtonBuilder.subTextLineBreakMode
            subTextLines = hamButtonBuilder.subTextLines
            
            subTextShadowColor = hamButtonBuilder.subTextShadowColor
            subTextShadowOffsetX = hamButtonBuilder.subTextShadowOffsetX
            subTextShadowOffsetY = hamButtonBuilder.subTextShadowOffsetY
            
            width = hamButtonBuilder.width
            height = hamButtonBuilder.height
            
            shadowPathRect = builder.shadowPathRect
            
            frame = CGRect.init(x: 0, y: 0, width: width, height: height)
            
            resetButtonLayer()
            resetNormalImage(builder: builder)
            resetHighlightedImage(builder: builder)
            resetUnableImage(builder: builder)
            resetImageView()
            resetLabel()
            resetSubLabel()
            
            if builder.unable {
                toUnable()
            } else {
                toNormal()
            }
            
            round = false
        } else {
            fatalError("The builder used to initialize ham-button should be ham-button-builder")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("BoomButton does not support NSCoding")
    }
    
    // MARK: - Override Methods
    
    override func toNormal() {
        toNormalImage()
        toNormalText()
        toNormalSubText()
        toNormalButton()
    }
    
    override func toHighlighted() {
        toHighlightedImage()
        toHighlightedText()
        toHighlightedSubText()
        toHighlightedButton()
    }
    
    override func toUnable() {
        toUnableImage()
        toUnableText()
        toUnableSubText()
        toUnableButton()
    }
    
    override func type() -> ButtonEnum {
        return .ham
    }
    
    override func goneViews() -> [UIView] {
        var goneViews = [UIView]()
        if imageView != nil {
            goneViews.append(imageView!)
        }
        if label != nil {
            goneViews.append(label!)
        }
        if subLabel != nil {
            goneViews.append(subLabel!)
        }
        return goneViews
    }
    
    override func rotateViews() -> [UIView] {
        var rotateViews = [UIView]()
        if imageView != nil && rotateImage {
            rotateViews.append(imageView!)
        }
        return rotateViews
    }
    
    override func buttonWidth() -> CGFloat {
        return width
    }
    
    override func buttonHeight() -> CGFloat {
        return height
    }
    
    override func setAnchorPointOfLayer() {
        Utils.setAnchorPoint(CGPoint.init(x: 0.5, y: 0.5), layer: layer)
    }
    
    override func rotateAnchorPoint() -> CGPoint {
        return CGPoint.init(x: imageFrame.origin.x + imageFrame.size.width / 2, y: imageFrame.origin.y + imageFrame.size.height / 2)
    }
    
    override func centerPoint() -> CGPoint {
        return CGPoint.init(x: width / 2, y: height / 2)
    }

}
