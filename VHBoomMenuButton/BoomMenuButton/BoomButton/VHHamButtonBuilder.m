//
//  VHHamButtonBuilder.m
//  VHBoomMenuButton
//
//  Created by Nightonke on 16/8/7.
//  Copyright © 2016 Nightonke. All rights reserved.
//

#import "VHHamButtonBuilder.h"
#import "VHHamButton.h"
#import "VHBoomButton_protected.h"
#import "VHBoomButtonBuilder_protected.h"
#import "VHUtils.h"

@implementation VHHamButtonBuilder

- (instancetype)init
{
    if (self = [super init])
    {
        _width = 300;
        _height = 60;
        
        self.shadowPathRect = CGRectMake(2, 2, _width - 4, _height - 4);
        
        _containsSubText = YES;
        
        _normalSubText = nil;
        _highlightedSubText = nil;
        _unableSubText = nil;
        
        _normalAttributedSubText = nil;
        _highlightedAttributedSubText = nil;
        _unableAttributedSubText = nil;
        
        _normalSubTextColor = [UIColor whiteColor];
        _highlightedSubTextColor = [UIColor whiteColor];
        _unableSubTextColor = [UIColor whiteColor];
        
        _subTextFrame = CGRectMake(70, 35, _width - 70 - 10, 15);
        _subTextFont = [UIFont systemFontOfSize:9];
        _subTextAlignment = NSTextAlignmentLeft;
        _subTextLineBreakMode = NSLineBreakByTruncatingTail;
        _subTextLines = 1;
        
        _subTextShadowColor = nil;
        _subTextShadowOffsetX = 0;
        _subTextShadowOffsetY = 0;
        
        self.imageFrame = CGRectMake(0, 0, 60, 60);
        
        self.textFrame = CGRectMake(70, 15, _width - 70 - 10, 20);
        self.textFont = [UIFont systemFontOfSize:15];
        self.textAlignment = NSTextAlignmentLeft;
    }
    return self;
}

#pragma mark - Public Methods

+ (VHHamButtonBuilder *)builder
{
    return [[VHHamButtonBuilder alloc] init];
}

#pragma mark - In-BMB-Only Methods

- (VHHamButton *)innerBuild
{
    VHHamButton *button = [[VHHamButton alloc] initWithBuilder:self];
    self.button = button;
    return button;
}

- (VHButtonEnum)innerType
{
    return VHButtonHam;
}

#pragma mark - Setters

#pragma mark Button

- (void)setWidth:(CGFloat)width
{
    if (_width == width)
    {
        return;
    }
    self.button.width = _width = width;
    [self.button innerSetButtonLayer];
    [self.button innerSetShadow];
    if (self.button.lastStateEnum == VHButtonStateNormal)
    {
        [self.button innerToNormalButton];
    }
    else if (self.button.lastStateEnum == VHButtonStateHighlighted)
    {
        [self.button innerToHighlightedButton];
    }
    else if (self.button.lastStateEnum == VHButtonStateUnable)
    {
        [self.button innerToUnableButton];
    }
    self.button.rotateAnchorPointInitialized = NO;
    [self.button setRotateAnchorPoints];
}

- (void)setHeight:(CGFloat)height
{
    if (_height == height)
    {
        return;
    }
    self.button.height = _height = height;
    [self.button innerSetButtonLayer];
    [self.button innerSetShadow];
    if (self.button.lastStateEnum == VHButtonStateNormal)
    {
        [self.button innerToNormalButton];
    }
    else if (self.button.lastStateEnum == VHButtonStateHighlighted)
    {
        [self.button innerToHighlightedButton];
    }
    else if (self.button.lastStateEnum == VHButtonStateUnable)
    {
        [self.button innerToUnableButton];
    }
    self.button.rotateAnchorPointInitialized = NO;
    [self.button setRotateAnchorPoints];
}

#pragma mark Sub Text

- (void)setContainsSubText:(BOOL)containsSubText
{
    if (_containsSubText == containsSubText)
    {
        return;
    }
    self.button.containsSubText = _containsSubText = containsSubText;
    [self.button innerSetSubLabel];
}

- (void)setNormalSubText:(NSString *)normalSubText
{
    if ([_normalSubText isEqualToString:normalSubText])
    {
        return;
    }
    self.button.normalSubText = _normalSubText = normalSubText;
    if (self.button.lastStateEnum == VHButtonStateNormal)
    {
        [self.button innerToNormalSubText];
    }
}

- (void)setHighlightedSubText:(NSString *)highlightedSubText
{
    if ([_highlightedSubText isEqualToString:highlightedSubText])
    {
        return;
    }
    self.button.highlightedSubText = _highlightedSubText = highlightedSubText;
    if (self.button.lastStateEnum == VHButtonStateHighlighted)
    {
        [self.button innerToHighlightedSubText];
    }
}

- (void)setUnableSubText:(NSString *)unableSubText
{
    if ([_unableSubText isEqualToString:unableSubText])
    {
        return;
    }
    self.button.unableSubText = _unableSubText = unableSubText;
    if (self.button.lastStateEnum == VHButtonStateUnable)
    {
        [self.button innerToUnableSubText];
    }
}

- (void)setNormalAttributedSubText:(NSAttributedString *)normalAttributedSubText
{
    if ([_normalAttributedSubText isEqualToAttributedString:normalAttributedSubText])
    {
        return;
    }
    self.button.normalAttributedSubText = _normalAttributedSubText = normalAttributedSubText;
    if (self.button.lastStateEnum == VHButtonStateNormal)
    {
        [self.button innerToNormalSubText];
    }
}

- (void)setHighlightedAttributedSubText:(NSAttributedString *)highlightedAttributedSubText
{
    if ([_highlightedAttributedSubText isEqualToAttributedString:highlightedAttributedSubText])
    {
        return;
    }
    self.button.highlightedAttributedSubText = _highlightedAttributedSubText = highlightedAttributedSubText;
    if (self.button.lastStateEnum == VHButtonStateHighlighted)
    {
        [self.button innerToHighlightedSubText];
    }
}

- (void)setUnableAttributedSubText:(NSAttributedString *)unableAttributedSubText
{
    if ([_unableAttributedSubText isEqualToAttributedString:unableAttributedSubText])
    {
        return;
    }
    self.button.unableAttributedSubText = _unableAttributedSubText = unableAttributedSubText;
    if (self.button.lastStateEnum == VHButtonStateUnable)
    {
        [self.button innerToUnableSubText];
    }
}

- (void)setNormalSubTextColor:(UIColor *)normalSubTextColor
{
    if ([VHUtils sameColor:_normalSubTextColor asColor:normalSubTextColor])
    {
        return;
    }
    self.button.normalSubTextColor = _normalSubTextColor = normalSubTextColor;
    if (self.button.lastStateEnum == VHButtonStateNormal)
    {
        [self.button innerToNormalSubText];
    }
}

- (void)setHighlightedSubTextColor:(UIColor *)highlightedSubTextColor
{
    if ([VHUtils sameColor:_highlightedSubTextColor asColor:highlightedSubTextColor])
    {
        return;
    }
    self.button.highlightedSubTextColor = _highlightedSubTextColor = highlightedSubTextColor;
    if (self.button.lastStateEnum == VHButtonStateHighlighted)
    {
        [self.button innerToHighlightedSubText];
    }
}

- (void)setUnableSubTextColor:(UIColor *)unableSubTextColor
{
    if ([VHUtils sameColor:_unableSubTextColor asColor:unableSubTextColor])
    {
        return;
    }
    self.button.unableSubTextColor = _unableSubTextColor = unableSubTextColor;
    if (self.button.lastStateEnum == VHButtonStateUnable)
    {
        [self.button innerToUnableSubText];
    }
}

- (void)setSubTextFrame:(CGRect)subTextFrame
{
    if (CGRectEqualToRect(_subTextFrame, subTextFrame))
    {
        return;
    }
    self.button.subTextFrame = _subTextFrame = subTextFrame;
    [self.button innerSetSubLabel];
}

- (void)setSubTextFont:(UIFont *)subTextFont
{
    if ([_subTextFont isEqual:subTextFont])
    {
        return;
    }
    self.button.subTextFont = _subTextFont = subTextFont;
    [self.button innerSetSubLabel];
}

- (void)setSubTextAlignment:(NSTextAlignment)subTextAlignment
{
    if (_subTextAlignment == subTextAlignment)
    {
        return;
    }
    self.button.subTextAlignment = _subTextAlignment = subTextAlignment;
    [self.button innerSetSubLabel];
}

- (void)setSubTextLineBreakMode:(NSLineBreakMode)subTextLineBreakMode
{
    if (_subTextLineBreakMode == subTextLineBreakMode)
    {
        return;
    }
    self.button.subTextLineBreakMode = _subTextLineBreakMode = subTextLineBreakMode;
    [self.button innerSetSubLabel];
}

- (void)setSubTextLines:(int)subTextLines
{
    if (_subTextLines == subTextLines)
    {
        return;
    }
    self.button.subTextLines = _subTextLines = subTextLines;
    [self.button innerSetSubLabel];
}

- (void)setSubTextShadowColor:(UIColor *)subTextShadowColor
{
    if ([VHUtils sameColor:_subTextShadowColor asColor:subTextShadowColor])
    {
        return;
    }
    self.button.subTextShadowColor = _subTextShadowColor = subTextShadowColor;
    [self.button innerSetSubLabel];
}

- (void)setSubTextShadowOffsetX:(CGFloat)subTextShadowOffsetX
{
    if (_subTextShadowOffsetX == subTextShadowOffsetX)
    {
        return;
    }
    self.button.subTextShadowOffsetX = _subTextShadowOffsetX = subTextShadowOffsetX;
    [self.button innerSetSubLabel];
}

- (void)setSubTextShadowOffsetY:(CGFloat)subTextShadowOffsetY
{
    if (_subTextShadowOffsetY == subTextShadowOffsetY)
    {
        return;
    }
    self.button.subTextShadowOffsetY = _subTextShadowOffsetY = subTextShadowOffsetY;
    [self.button innerSetSubLabel];
}

@end
