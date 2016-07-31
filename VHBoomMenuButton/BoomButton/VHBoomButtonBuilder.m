//
//  VHBoomButtonBuilder.m
//  VHBoomMenuExample
//
//  Created by 黄伟平 on 16/7/31.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import "VHBoomButtonBuilder.h"

@implementation VHBoomButtonBuilder

- (VHBoomButton *)createButton
{
    return nil;
}

- (instancetype)withShadowOffset:(CGSize)shadowOffset
{
    self.shadowOffset = shadowOffset;
    return self;
}

- (instancetype)withShadowOpacity:(CGFloat)shadowOpacity
{
    self.shadowOpacity = shadowOpacity;
    return self;
}

- (instancetype)withShadowColor:(UIColor *)shadowColor
{
    self.shadowColor = shadowColor;
    return self;
}

- (instancetype)withImageNormal:(NSString *)imageNormal
{
    self.imageNormal = imageNormal;
    return self;
}

- (instancetype)withImagePressed:(NSString *)imagePressed
{
    self.imagePressed = imagePressed;
    return self;
}

- (instancetype)withButtonNormalColor:(UIColor *)buttonNormalColor
{
    self.buttonNormalColor = buttonNormalColor;
    return self;
}

- (instancetype)withButtonPressedColor:(UIColor *)buttonPressedColor
{
    self.buttonPressedColor = buttonPressedColor;
    return self;
}

- (instancetype)withImageNormalTintColor:(UIColor *)imageNormalTintColor
{
    self.imageNormalTintColor = imageNormalTintColor;
    return self;
}

- (instancetype)withImagePressedTintColor:(UIColor *)imagePressedTintColor
{
    self.imagePressedTintColor = imagePressedTintColor;
    return self;
}

- (instancetype)withDelegate:(id<VHButtonClickDelegate>)delegate
{
    self.delegate = delegate;
    return self;
}

- (instancetype)withIndex:(int)index
{
    self.index = index;
    return self;
}

@end
