//
//  VHTextInsideCircleButtonBuilder.m
//  VHBoomMenuButton
//
//  Created by Nightonke on 16/8/2.
//  Copyright © 2016 Nightonke. All rights reserved.
//

#import "VHTextInsideCircleButtonBuilder.h"
#import "VHTextInsideCircleButton.h"
#import "VHBoomButton_protected.h"
#import "VHBoomButtonBuilder_protected.h"

@implementation VHTextInsideCircleButtonBuilder

#pragma mark - Private Methods

- (instancetype)init
{
    if (self = [super init])
    {
        self.textFrame = CGRectMake(15, 52, 50, 20);
        self.textFont = [UIFont systemFontOfSize:8];
        
        _radius = 40;
        _round = YES;
        
        self.shadowPathRect = CGRectMake(2, 2, _radius * 2 - 4, _radius * 2 - 4);
    }
    return self;
}

#pragma mark - Public Methods

+ (VHTextInsideCircleButtonBuilder *)builder
{
    return [[VHTextInsideCircleButtonBuilder alloc] init];
}

#pragma mark - In-BMB-Only Methods

- (VHTextInsideCircleButton *)innerBuild
{
    VHTextInsideCircleButton *button = [[VHTextInsideCircleButton alloc] initWithBuilder:self];
    self.button = button;
    return button;
}

- (VHButtonEnum)innerType
{
    return VHButtonTextInsideCircle;
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
