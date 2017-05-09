//
//  VHSimpleCircleButtonInfo.m
//  VHBoomMenuExample
//
//  Created by Nightonke on 16/7/31.
//  Copyright © 2016 Nightonke. All rights reserved.
//

#import "VHSimpleCircleButtonBuilder.h"
#import "VHSimpleCircleButton.h"
#import "VHBoomButton_protected.h"
#import "VHBoomButtonBuilder_protected.h"

@implementation VHSimpleCircleButtonBuilder

#pragma mark - Private Methods

- (instancetype)init
{
    if (self = [super init])
    {
        _radius = 40;
        _round = YES;
        self.shadowPathRect = CGRectMake(2, 2, _radius + _radius - 4, _radius + _radius - 4);
    }
    return self;
}

#pragma mark - Public Methods

+ (VHSimpleCircleButtonBuilder *)builder
{
    return [[VHSimpleCircleButtonBuilder alloc] init];
}

#pragma mark - In-BMB-Only Methods

- (VHSimpleCircleButton *)innerBuild
{
    VHSimpleCircleButton *button = [[VHSimpleCircleButton alloc] initWithBuilder:self];
    self.button = button;
    return button;
}

- (VHButtonEnum)innerType
{
    return VHButtonSimpleCircle;
}

#pragma mark - Setters

- (void)setRadius:(CGFloat)radius
{
    if (_radius == radius)
    {
        return;
    }
    self.button.radius = _radius = radius;
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
