//
//  BoomButtonWithText.swift
//  BoomMenuButton
//
//  Created by Nightonke on 2017/5/2.
//  Copyright © 2017 Nightonke. All rights reserved.
//

import UIKit

class BoomButtonWithText: BoomButton {

    override init(builder: BoomButtonBuilder) {
        super.init(builder: builder)
        if let withTextBuilder = builder as? BoomButtonWithTextBuilder {
            normalText = withTextBuilder.normalText
            highlightedText = withTextBuilder.highlightedText
            unableText = withTextBuilder.unableText
            
            normalAttributedText = withTextBuilder.normalAttributedText
            highlightedAttributedText = withTextBuilder.highlightedAttributedText
            unableAttributedText = withTextBuilder.unableAttributedText
            
            normalTextColor = withTextBuilder.normalTextColor
            highlightedTextColor = withTextBuilder.highlightedTextColor
            unableTextColor = withTextBuilder.unableTextColor
            
            textFrame = withTextBuilder.textFrame
            textFont = withTextBuilder.textFont
            textAlignment = withTextBuilder.textAlignment
            textLineBreakMode = withTextBuilder.textLineBreakMode
            textLines = withTextBuilder.textLines
            
            textShadowColor = withTextBuilder.textShadowColor
            textShadowOffsetX = withTextBuilder.textShadowOffsetX
            textShadowOffsetY = withTextBuilder.textShadowOffsetY
            
            rotateText = withTextBuilder.rotateText
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("BoomButton does not support NSCoding")
    }

}
