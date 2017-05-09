//
//  VHSimpleCicleButton.m
//  VHBoomMenuExample
//
//  Created by Nightonke on 16/7/28.
//  Copyright © 2016 Nightonke. All rights reserved.
//

#import "VHSimpleCircleButton.h"
#import "VHSimpleCircleButtonBuilder.h"
#import "VHBoomButton_protected.h"
#import "VHUtils.h"

@interface VHSimpleCircleButton ()

@end

@implementation VHSimpleCircleButton

#pragma mark - Initialize

- (instancetype)initWithBuilder:(VHSimpleCircleButtonBuilder *)builder
{
    if (self = [super initWithBuilder:builder])
    {
        self.radius = builder.radius;
        self.round = builder.round;
        
        self.shadowPathRect = builder.shadowPathRect;
        
        [self setFrame:CGRectMake(0, 0, self.radius + self.radius, self.radius + self.radius)];
        
        [self innerSetButtonLayer];
        [self innerSetNormalImage:builder];
        [self innerSetHighlightedImage:builder];
        [self innerSetUnableImage:builder];
        [self innerSetImageView];
        
        if (builder.unable)
        {
            [self toUnable];
        }
        else
        {
            [self toNormal];
        }
    }
    return self;
}

#pragma mark - Override Methods

- (void)toNormal
{
    [self innerToNormalImage];
    [self innerToNormalButton];
}

- (void)toHighlighted
{
    [self innerToHighlightedImage];
    [self innerToHighlightedButton];
}

- (void)toUnable
{
    [self innerToUnableImage];
    [self innerToUnableButton];
}

- (VHButtonEnum)type
{
    return VHButtonSimpleCircle;
}

- (NSArray<UIView *> *)goneViews
{
    NSMutableArray<UIView *> *goneViews = [NSMutableArray arrayWithCapacity:2];
    if (self.imageView)
    {
        [goneViews addObject:self.imageView];
    }
    return goneViews;
}

- (NSArray<UIView *> *)rotateViews
{
    NSMutableArray<UIView *> *rotateViews = [NSMutableArray arrayWithCapacity:1];
    if (self.rotateImage)
    {
        [rotateViews addObject:self.imageView];
    }
    return rotateViews;
}

- (CGFloat)buttonWidth
{
    return self.radius + self.radius;
}

- (CGFloat)buttonHeight
{
    return self.radius + self.radius;
}

- (void)setAnchorPointOfLayer
{
    [VHUtils setAnchorPoint:CGPointMake(0.5, 0.5) ofLayer:self.layer];
}

- (CGPoint)rotateAnchorPoint
{
    return CGPointMake(self.radius, self.radius);
}

- (CGPoint)centerPoint
{
    return CGPointMake(self.radius, self.radius);
}

@end
