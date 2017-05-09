//
//  VHHamButton.m
//  VHBoomMenuButton
//
//  Created by Nightonke on 16/8/7.
//  Copyright © 2016 Nightonke. All rights reserved.
//

#import "VHHamButton.h"
#import "VHHamButtonBuilder.h"
#import "VHBoomButton_protected.h"
#import "VHUtils.h"

@interface VHHamButton ()

@end

@implementation VHHamButton

- (instancetype)initWithBuilder:(VHHamButtonBuilder *)builder
{
    if (self = [super initWithBuilder:builder])
    {
        self.containsSubText = builder.containsSubText;
        
        self.normalSubText = builder.normalSubText;
        self.highlightedSubText = builder.highlightedSubText;
        self.unableSubText = builder.unableSubText;
        
        self.normalAttributedSubText = builder.normalAttributedSubText;
        self.highlightedAttributedSubText = builder.highlightedAttributedSubText;
        self.unableAttributedSubText = builder.unableAttributedSubText;
        
        self.normalSubTextColor = builder.normalSubTextColor;
        self.highlightedSubTextColor = builder.highlightedSubTextColor;
        self.unableSubTextColor = builder.unableSubTextColor;
        
        self.subTextFrame = builder.subTextFrame;
        self.subTextFont = builder.subTextFont;
        self.subTextAlignment = builder.subTextAlignment;
        self.subTextLineBreakMode = builder.subTextLineBreakMode;
        self.subTextLines = builder.subTextLines;
        
        self.subTextShadowColor = builder.subTextShadowColor;
        self.subTextShadowOffsetX = builder.subTextShadowOffsetX;
        self.subTextShadowOffsetY = builder.subTextShadowOffsetY;
        
        self.width = builder.width;
        self.height = builder.height;
        
        self.shadowPathRect = builder.shadowPathRect;
        
        [self setFrame:CGRectMake(0, 0, self.width, self.height)];
        
        [self innerSetButtonLayer];
        [self innerSetNormalImage:builder];
        [self innerSetHighlightedImage:builder];
        [self innerSetUnableImage:builder];
        [self innerSetImageView];
        [self innerSetLabel];
        [self innerSetSubLabel];
        
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
    [self innerToNormalSubText];
    [self innerToNormalButton];
}

- (void)toHighlighted
{
    [self innerToHighlightedImage];
    [self innerToHighlightedText];
    [self innerToHighlightedSubText];
    [self innerToHighlightedButton];
}

- (void)toUnable
{
    [self innerToUnableImage];
    [self innerToUnableText];
    [self innerToUnableSubText];
    [self innerToUnableButton];
}

#pragma mark - Override Method

- (VHButtonEnum)type
{
    return VHButtonHam;
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
    if (self.subLabel)
    {
        [goneViews addObject:self.subLabel];
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
    return rotateViews;
}

- (CGFloat)buttonWidth
{
    return self.width;
}

- (CGFloat)buttonHeight
{
    return self.height;
}

- (void)setAnchorPointOfLayer
{
    [VHUtils setAnchorPoint:CGPointMake(0.5, 0.5) ofLayer:self.layer];
}

- (CGPoint)rotateAnchorPoint
{
    CGPoint center = CGPointMake(self.imageFrame.origin.x + self.imageFrame.size.width / 2,
                                 self.imageFrame.origin.y + self.imageFrame.size.height / 2);
    return center;
}

- (CGPoint)centerPoint
{
    CGPoint center = CGPointMake(self.width / 2, self.height / 2);
    return center;
}

@end
