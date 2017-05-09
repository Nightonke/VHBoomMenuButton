//
//  VHBoomButtonWithTextBuilder.m
//  VHBoomMenuButton
//
//  Created by Nightonke on 2017/4/13.
//  Copyright © 2017 Nightonke. All rights reserved.
//

#import "VHBoomButtonWithTextBuilder.h"
#import "VHBoomButton_protected.h"
#import "VHBoomButtonBuilder_protected.h"
#import "VHUtils.h"

@implementation VHBoomButtonWithTextBuilder

#pragma mark - Private Methods

- (instancetype)init
{
    if (self = [super init])
    {
        _normalText = nil;
        _highlightedText = nil;
        _unableText = nil;
        
        _normalAttributedText = nil;
        _highlightedAttributedText = nil;
        _unableAttributedText = nil;
        
        _normalTextColor = [UIColor whiteColor];
        _highlightedTextColor = [UIColor whiteColor];
        _unableTextColor = [UIColor whiteColor];
        
        _textFrame = CGRectNull;
        _textFont = nil;
        _textAlignment = NSTextAlignmentCenter;
        _textLineBreakMode = NSLineBreakByTruncatingTail;
        _textLines = 1;
        
        _textShadowColor = nil;
        _textShadowOffsetX = 0;
        _textShadowOffsetY = 0;
        
        _rotateText = YES;
    }
    return self;
}

#pragma mark - Setters

#pragma mark Text

- (void)setNormalText:(NSString *)normalText
{
    if ([_normalText isEqualToString:normalText])
    {
        return;
    }
    self.button.normalText = _normalText = normalText;
    if (self.button.lastStateEnum == VHButtonStateNormal)
    {
        [self.button innerToNormalText];
    }
}

- (void)setHighlightedText:(NSString *)highlightedText
{
    if ([_highlightedText isEqualToString:highlightedText])
    {
        return;
    }
    self.button.highlightedText = _highlightedText = highlightedText;
    if (self.button.lastStateEnum == VHButtonStateHighlighted)
    {
        [self.button innerToHighlightedText];
    }
}

- (void)setUnableText:(NSString *)unableText
{
    if ([_unableText isEqualToString:unableText])
    {
        return;
    }
    self.button.unableText = _unableText = unableText;
    if (self.button.lastStateEnum == VHButtonStateUnable)
    {
        [self.button innerToUnableText];
    }
}

- (void)setNormalAttributedText:(NSAttributedString *)normalAttributedText
{
    if ([_normalAttributedText isEqualToAttributedString:normalAttributedText])
    {
        return;
    }
    self.button.normalAttributedText = _normalAttributedText = normalAttributedText;
    if (self.button.lastStateEnum == VHButtonStateNormal)
    {
        [self.button innerToNormalText];
    }
}

- (void)setHighlightedAttributedText:(NSAttributedString *)highlightedAttributedText
{
    if ([_highlightedAttributedText isEqualToAttributedString:highlightedAttributedText])
    {
        return;
    }
    self.button.highlightedAttributedText = _highlightedAttributedText = highlightedAttributedText;
    if (self.button.lastStateEnum == VHButtonStateHighlighted)
    {
        [self.button innerToHighlightedText];
    }
}

- (void)setUnableAttributedText:(NSAttributedString *)unableAttributedText
{
    if ([_unableAttributedText isEqualToAttributedString:unableAttributedText])
    {
        return;
    }
    self.button.unableAttributedText = _unableAttributedText = unableAttributedText;
    if (self.button.lastStateEnum == VHButtonStateUnable)
    {
        [self.button innerToUnableText];
    }
}

- (void)setNormalTextColor:(UIColor *)normalTextColor
{
    if ([VHUtils sameColor:_normalTextColor asColor:normalTextColor])
    {
        return;
    }
    self.button.normalTextColor = _normalTextColor = normalTextColor;
    if (self.button.lastStateEnum == VHButtonStateNormal)
    {
        [self.button innerToNormalText];
    }
}

- (void)setHighlightedTextColor:(UIColor *)highlightedTextColor
{
    if ([VHUtils sameColor:_highlightedTextColor asColor:highlightedTextColor])
    {
        return;
    }
    self.button.highlightedTextColor = _highlightedTextColor = highlightedTextColor;
    if (self.button.lastStateEnum == VHButtonStateHighlighted)
    {
        [self.button innerToHighlightedText];
    }
}

- (void)setUnableTextColor:(UIColor *)unableTextColor
{
    if ([VHUtils sameColor:_unableTextColor asColor:unableTextColor])
    {
        return;
    }
    self.button.unableTextColor = _unableTextColor = unableTextColor;
    if (self.button.lastStateEnum == VHButtonStateUnable)
    {
        [self.button innerToUnableText];
    }
}

- (void)setTextFrame:(CGRect)textFrame
{
    if (CGRectEqualToRect(_textFrame, textFrame))
    {
        return;
    }
    self.button.textFrame = _textFrame = textFrame;
    [self.button innerSetLabel];
}

- (void)setTextFont:(UIFont *)textFont
{
    if ([_textFont isEqual:textFont])
    {
        return;
    }
    self.button.textFont = _textFont = textFont;
    [self.button innerSetLabel];
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    if (_textAlignment == textAlignment)
    {
        return;
    }
    self.button.textAlignment = _textAlignment = textAlignment;
    [self.button innerSetLabel];
}

- (void)setTextLineBreakMode:(NSLineBreakMode)textLineBreakMode
{
    if (_textLineBreakMode == textLineBreakMode)
    {
        return;
    }
    self.button.textLineBreakMode = _textLineBreakMode = textLineBreakMode;
    [self.button innerSetLabel];
}

- (void)setTextLines:(int)textLines
{
    if (_textLines == textLines)
    {
        return;
    }
    self.button.textLines = _textLines = textLines;
    [self.button innerSetLabel];
}

- (void)setTextShadowColor:(UIColor *)textShadowColor
{
    if (_textShadowColor == textShadowColor)
    {
        return;
    }
    self.button.textShadowColor = _textShadowColor = textShadowColor;
    [self.button innerSetLabel];
}

- (void)setTextShadowOffsetX:(CGFloat)textShadowOffsetX
{
    if (_textShadowOffsetX == textShadowOffsetX)
    {
        return;
    }
    self.button.textShadowOffsetX = _textShadowOffsetX = textShadowOffsetX;
    [self.button innerSetLabel];
}

- (void)setTextShadowOffsetY:(CGFloat)textShadowOffsetY
{
    if (_textShadowOffsetY == textShadowOffsetY)
    {
        return;
    }
    self.button.textShadowOffsetY = _textShadowOffsetY = textShadowOffsetY;
    [self.button innerSetLabel];
}

- (void)setRotateText:(BOOL)rotateText
{
    if (_rotateText == rotateText)
    {
        return;
    }
    self.button.rotateText = _rotateText = rotateText;
}

@end
