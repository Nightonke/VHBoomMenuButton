//
//  VHTextOutsideCircleButtonBuilder.m
//  VHBoomMenuButton
//
//  Created by 黄伟平 on 16/8/3.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import "VHTextOutsideCircleButtonBuilder.h"

@implementation VHTextOutsideCircleButtonBuilder

- (instancetype)init
{
    if (self = [super init])
    {
        self.imageNormal           = nil;
        self.imagePressed          = nil;
        self.buttonNormalColor     = DEFAULT_TEXT_OUTSIDE_CIRCLE_BUTTON_NORMAL_COLOR;
        self.buttonPressedColor    = DEFAULT_TEXT_OUTSIDE_CIRCLE_BUTTON_PRESSED_COLOR;
        self.imageNormalTintColor  = nil;
        self.imagePressedTintColor = nil;
        self.textNormalColor       = DEFAULT_TEXT_OUTSIDE_CIRCLE_BUTTON_TEXT_NORMAL_COLOR;
        self.textPressedColor      = DEFAULT_TEXT_OUTSIDE_CIRCLE_BUTTON_TEXT_PRESSED_COLOR;
        self.imageFrame            = CGRectNull;
        self.textFrame             = CGRectNull;
        self.textContent           = @"";
        self.font                  = [UIFont systemFontOfSize:DEFAULT_TEXT_OUTSIDE_CIRCLE_BUTTON_TEXT_SIZE];
        self.lineBreakMode         = DEFAULT_TEXT_OUTSIDE_CIRCLE_BUTTON_TEXT_LINE_BREAK_MODE;
        self.lines                 = DEFAULT_TEXT_OUTSIDE_CIRCLE_BUTTON_TEXT_LINES;
        self.rotateImage           = DEFAULT_TEXT_OUTSIDE_CIRCLE_BUTTON_ROTATE_IMAGE;
        self.rotateText            = DEFAULT_TEXT_OUTSIDE_CIRCLE_BUTTON_ROTATE_TEXT;
        self.shadowText            = DEFAULT_TEXT_OUTSIDE_CIRCLE_BUTTON_SHADOW_TEXT;
        self.buttonWidth           = DEFAULT_TEXT_OUTSIDE_CIRCLE_BUTTON_WIDTH;
        self.buttonHeight          = DEFAULT_TEXT_OUTSIDE_CIRCLE_BUTTON_HEIGHT;
        self.shadowRadius          = DEFAULT_TEXT_OUTSIDE_CIRCLE_BUTTON_WIDTH / 2 + DEFAULT_TEXT_OUTSIDE_CIRCLE_BUTTON_SHADOW_WIDTH;
        self.shadowOffset          = CGSizeMake(DEFAULT_TEXT_OUTSIDE_CIRCLE_BUTTON_TEXT_SHADOW_OFFSET_X, DEFAULT_TEXT_OUTSIDE_CIRCLE_BUTTON_TEXT_SHADOW_OFFSET_Y);
        self.shadowOpacity         = DEFAULT_TEXT_OUTSIDE_CIRCLE_BUTTON_SHADOW_OPACITY;
        self.shadowColor           = DEFAULT_TEXT_OUTSIDE_CIRCLE_BUTTON_SHADOW_COLOR;
        self.textShadowOffset      = CGSizeMake(DEFAULT_TEXT_OUTSIDE_CIRCLE_BUTTON_TEXT_SHADOW_OFFSET_X, DEFAULT_TEXT_OUTSIDE_CIRCLE_BUTTON_TEXT_SHADOW_OFFSET_Y);
        self.textShadowColor       = DEFAULT_TEXT_OUTSIDE_CIRCLE_BUTTON_TEXT_SHADOW_COLOR;
        self.index                 = -1;
    }
    return self;
}

- (VHTextOutsideCircleButton *)createButton
{
    if (self.imagePressed == nil)
    {
        self.imagePressed = self.imageNormal;
    }
    
    return [[VHTextOutsideCircleButton alloc] initWithImage:self.imageNormal
                                               pressedImage:self.imagePressed
                                                normalColor:self.buttonNormalColor
                                               pressedColor:self.buttonPressedColor
                                       imageNormalTintColor:self.imageNormalTintColor
                                      imagePressedTintColor:self.imagePressedTintColor
                                            textNormalColor:self.textNormalColor
                                           textPressedColor:self.textPressedColor
                                                 imageFrame:self.imageFrame
                                                  textFrame:self.textFrame
                                                       text:self.textContent
                                                       font:self.font
                                              lineBreakMode:self.lineBreakMode
                                                      lines:self.lines
                                                rotateImage:self.rotateImage
                                                 rotateText:self.rotateText
                                                 shadowText:self.shadowText
                                                buttonWidth:self.buttonWidth
                                               buttonHeight:self.buttonHeight
                                               shadowRadius:self.shadowRadius
                                               shadowOffset:self.shadowOffset
                                              shadowOpacity:self.shadowOpacity
                                                shadowColor:self.shadowColor
                                           textShadowOffset:self.textShadowOffset
                                            textShadowColor:self.textShadowColor
                                               withDelegate:self.delegate
                                                         at:self.index];
}

@end
