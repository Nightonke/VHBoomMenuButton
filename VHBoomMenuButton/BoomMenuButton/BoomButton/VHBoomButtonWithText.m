//
//  VHBoomButtonWithText.m
//  VHBoomMenuButton
//
//  Created by Nightonke on 2017/4/13.
//  Copyright © 2017 Nightonke. All rights reserved.
//

#import "VHBoomButtonWithText.h"
#import "VHBoomButton_protected.h"
#import "VHBoomButtonWithTextBuilder.h"

@implementation VHBoomButtonWithText

#pragma mark - In-BMB-Only Methods

- (instancetype)initWithBuilder:(VHBoomButtonWithTextBuilder *)builder
{
    if (self = [super initWithBuilder:builder])
    {
        self.normalText = builder.normalText;
        self.highlightedText = builder.highlightedText;
        self.unableText = builder.unableText;
        
        self.normalAttributedText = builder.normalAttributedText;
        self.highlightedAttributedText = builder.highlightedAttributedText;
        self.unableAttributedText = builder.unableAttributedText;
        
        self.normalTextColor = builder.normalTextColor;
        self.highlightedTextColor = builder.highlightedTextColor;
        self.unableTextColor = builder.unableTextColor;
        
        self.textFrame = builder.textFrame;
        self.textFont = builder.textFont;
        self.textAlignment = builder.textAlignment;
        self.textLineBreakMode = builder.textLineBreakMode;
        self.textLines = builder.textLines;
        
        self.textShadowColor = builder.textShadowColor;
        self.textShadowOffsetX = builder.textShadowOffsetX;
        self.textShadowOffsetY = builder.textShadowOffsetY;
        
        self.rotateText = builder.rotateText;
    }
    return self;
}

@end
