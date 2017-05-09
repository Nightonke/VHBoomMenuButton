//
//  VHTextOutsideCircleButton.m
//  VHBoomMenuButton
//
//  Created by Nightonke on 16/8/3.
//  Copyright © 2016 Nightonke. All rights reserved.
//

#import "VHTextOutsideCircleButton.h"
#import "VHTextOutsideCircleButtonBuilder.h"
#import "VHBoomButton_protected.h"
#import "VHUtils.h"

@interface VHTextOutsideCircleButton ()

@end

@implementation VHTextOutsideCircleButton

- (instancetype)initWithBuilder:(VHTextOutsideCircleButtonBuilder *)builder
{
    if (self = [super initWithBuilder:builder])
    {
        self.width = builder.width;
        self.height = builder.height;
        self.round = builder.round;
        
        self.shadowPathRect = builder.shadowPathRect;
        
        [self setFrame:CGRectMake(0, 0, self.width, self.height)];
        
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
    return VHButtonTextOutsideCircle;
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
    return self.width;
}

- (CGFloat)buttonHeight
{
    return self.width;
}

- (void)setAnchorPointOfLayer
{
    [VHUtils setAnchorPoint:CGPointMake(0.5, self.width / 2 / self.height) ofLayer:self.layer];
}

- (CGPoint)rotateAnchorPoint
{
    CGPoint center = CGPointMake(self.width / 2, self.width / 2);
    return center;
}

- (CGPoint)centerPoint
{
    CGPoint center = CGPointMake(self.width / 2, self.width / 2);
    return center;
}

@end
