//
//  VHSimpleCircleButtonInfo.m
//  VHBoomMenuExample
//
//  Created by 黄伟平 on 16/7/31.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import "VHSimpleCircleButtonBuilder.h"

@implementation VHSimpleCircleButtonBuilder

- (instancetype)init
{
    if (self = [super init])
    {
        self.buttonNormalColor = DEFAULT_SIMPLE_CIRCLE_BUTTON_NORMAL_COLOR;
        self.buttonPressedColor = DEFAULT_SIMPLE_CIRCLE_BUTTON_PRESSED_COLOR;
        self.imageNormalTintColor = nil;
        self.imagePressedTintColor = nil;
        self.buttonRadius = DEFAULT_SIMPLE_CIRCLE_BUTTON_RADIUS;
        self.shadowRadius = DEFAULT_SIMPLE_CIRCLE_BUTTON_RADIUS + DEFAULT_SIMPLE_CIRCLE_BUTTON_SHADOW_WIDTH;
        self.shadowOffset = CGSizeMake(DEFAULT_SIMPLE_CIRCLE_BUTTON_SHADOW_OFFSET_X, DEFAULT_SIMPLE_CIRCLE_BUTTON_SHADOW_OFFSET_Y);
        self.shadowOpacity = DEFAULT_SIMPLE_CIRCLE_BUTTON_SHADOW_OPACITY;
        self.shadowColor = DEFAULT_SIMPLE_CIRCLE_BUTTON_SHADOW_COLOR;
        self.index = -1;
    }
    return self;
}

- (instancetype)withShadowRadius:(CGFloat)shadowRadius
{
    self.shadowRadius = shadowRadius;
    return self;
}


- (instancetype)withButtonRadius:(CGFloat)buttonRadius
{
    self.buttonRadius = buttonRadius;
    return self;
}

- (VHSimpleCircleButton *)createButton
{
    if (self.imagePressed == nil)
    {
        self.imagePressed = self.imageNormal;
    }
    
    return [[VHSimpleCircleButton alloc] initWithImage:self.imageNormal
                                          pressedImage:self.imagePressed
                                           normalColor:self.buttonNormalColor
                                          pressedColor:self.buttonPressedColor
                                  imageNormalTintColor:self.imageNormalTintColor
                                 imagePressedTintColor:self.imagePressedTintColor
                                          buttonRadius:self.buttonRadius
                                          shadowRadius:self.shadowRadius
                                          shadowOffset:self.shadowOffset
                                         shadowOpacity:self.shadowOpacity
                                           shadowColor:self.shadowColor
                                          withDelegate:self.delegate
                                                    at:self.index];
}

@end
