//
//  VHTextOutsideCircleButtonBuilder.m
//  VHBoomMenuButton
//
//  Created by Nightonke on 16/8/3.
//  Copyright © 2016 Nightonke. All rights reserved.
//

#import "VHTextOutsideCircleButtonBuilder.h"
#import "VHTextOutsideCircleButton.h"
#import "VHBoomButton_protected.h"
#import "VHBoomButtonBuilder_protected.h"

@implementation VHTextOutsideCircleButtonBuilder

#pragma mark - Private Methods

- (instancetype)init
{
    if (self = [super init])
    {
        self.textFrame = CGRectMake(5, 86, 70, 10);
        self.textFont = [UIFont systemFontOfSize:10];
        
        _width = 80;
        _height = 96;
        
        _round = YES;
        
        self.shadowPathRect = CGRectMake(2, 2, _width - 4, _width - 4);
    }
    return self;
}

#pragma mark - Public Methods

+ (VHTextOutsideCircleButtonBuilder *)builder
{
    return [[VHTextOutsideCircleButtonBuilder alloc] init];
}

#pragma mark - In-BMB-Only Methods

- (VHTextOutsideCircleButton *)innerBuild
{
    VHTextOutsideCircleButton *button = [[VHTextOutsideCircleButton alloc] initWithBuilder:self];
    self.button = button;
    return button;
}

- (VHButtonEnum)innerType
{
    return VHButtonTextOutsideCircle;
}

#pragma mark - Setters

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

- (void)setRound:(BOOL)round
{
    if (_round == round)
    {
        return;
    }
    self.button.round = _round = round;
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
}

@end
