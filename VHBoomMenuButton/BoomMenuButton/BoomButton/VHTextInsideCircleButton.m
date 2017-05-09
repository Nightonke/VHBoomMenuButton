//
//  VHTextInsideCircleButton.m
//  VHBoomMenuButton
//
//  Created by Nightonke on 16/8/2.
//  Copyright © 2016 Nightonke. All rights reserved.
//

#import "VHTextInsideCircleButton.h"
#import "VHTextInsideCircleButtonBuilder.h"
#import "VHBoomButton_protected.h"
#import "VHUtils.h"

@interface VHTextInsideCircleButton ()

@end

@implementation VHTextInsideCircleButton

- (instancetype)initWithBuilder:(VHTextInsideCircleButtonBuilder *)builder
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
        [self innerSetLabel];
        
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

- (void)toNormal
{
    [self innerToNormalImage];
    [self innerToNormalText];
    [self innerToNormalButton];
}

- (void)toHighlighted
{
    [self innerToHighlightedImage];
    [self innerToHighlightedText];
    [self innerToHighlightedButton];
}

- (void)toUnable
{
    [self innerToUnableImage];
    [self innerToUnableText];
    [self innerToUnableButton];
}

#pragma mark - Override Method

- (VHButtonEnum)type
{
    return VHButtonTextInsideCircle;
}

- (NSArray<UIView *> *)goneViews
{
    NSMutableArray<UIView *> *goneViews = [NSMutableArray arrayWithCapacity:2];
    if (self.imageView)
    {
        [goneViews addObject:self.imageView];
    }
    if (self.label)
    {
        [goneViews addObject:self.label];
    }
    return goneViews;
}

- (NSArray<UIView *> *)rotateViews
{
    NSMutableArray<UIView *> *rotateViews = [NSMutableArray arrayWithCapacity:2];
    if (self.rotateImage)
    {
        [rotateViews addObject:self.imageView];
    }
    if (self.rotateText)
    {
        [rotateViews addObject:self.label];
    }
    return rotateViews;
}

- (CGFloat)buttonWidth
{
    return self.radius * 2;
}

- (CGFloat)buttonHeight
{
    return self.radius * 2;
}

- (void)setAnchorPointOfLayer
{
    [VHUtils setAnchorPoint:CGPointMake(0.5, 0.5) ofLayer:self.layer];
}

- (CGPoint)rotateAnchorPoint
{
    CGPoint center = CGPointMake(self.radius, self.radius);
    return center;
}

- (CGPoint)centerPoint
{
    CGPoint center = CGPointMake(self.radius, self.radius);
    return center;
}

@end
