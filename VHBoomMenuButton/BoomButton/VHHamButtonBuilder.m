//
//  VHHamButtonBuilder.m
//  VHBoomMenuButton
//
//  Created by 黄伟平 on 16/8/7.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import "VHHamButtonBuilder.h"

@implementation VHHamButtonBuilder

- (instancetype)init
{
    if (self = [super init])
    {
        self.imageNormal           = nil;
        self.imagePressed          = nil;
        self.buttonNormalColor     = DEFAULT_HAM_BUTTON_NORMAL_COLOR;
        self.buttonPressedColor    = DEFAULT_HAM_BUTTON_PRESSED_COLOR;
        self.imageNormalTintColor  = nil;
        self.imagePressedTintColor = nil;
        self.titleNormalColor      = DEFAULT_HAM_BUTTON_TITLE_NORMAL_COLOR;
        self.titlePressedColor     = DEFAULT_HAM_BUTTON_TITLE_PRESSED_COLOR;
        self.subTitleNormalColor   = DEFAULT_HAM_BUTTON_SUB_TITLE_NORMAL_COLOR;
        self.subTitlePressedColor  = DEFAULT_HAM_BUTTON_SUB_TITLE_PRESSED_COLOR;
        self.imageFrame            = CGRectNull;
        self.titleFrame            = CGRectNull;
        self.subTitleFrame         = CGRectNull;
        self.titleContent          = @"";
        self.titleFont             = [UIFont systemFontOfSize:DEFAULT_HAM_BUTTON_TITLE_SIZE];
        self.titleLineBreakMode    = DEFAULT_HAM_BUTTON_TITLE_LINE_BREAK_MODE;
        self.titlelines            = DEFAULT_HAM_BUTTON_TITLE_LINES;
        self.titleAlignment        = DEFAULT_HAM_BUTTON_TITLE_ALIGNMENT;
        self.subTitleContent       = nil;
        self.subTitleFont          = [UIFont systemFontOfSize:DEFAULT_HAM_BUTTON_SUB_TITLE_SIZE];
        self.subTitleLineBreakMode = DEFAULT_HAM_BUTTON_SUB_TITLE_LINE_BREAK_MODE;
        self.subTitlelines         = DEFAULT_HAM_BUTTON_SUB_TITLE_LINES;
        self.subTitleAlignment     = DEFAULT_HAM_BUTTON_SUB_TITLE_ALIGNMENT;
        self.rotateImage           = DEFAULT_HAM_BUTTON_ROTATE_IMAGE;
        self.containImage          = DEFAULT_HAM_BUTTON_CONTAIN_IMAGE;
        self.buttonWidth           = [UIScreen mainScreen].bounds.size.width - 40;
        self.buttonHeight          = DEFAULT_HAM_BUTTON_HEIGHT;
        self.buttonCornerRadius    = DEFAULT_HAM_BUTTON_CORNER_RADIUS;
        self.shadowWidth           = self.buttonWidth + DEFAULT_HAM_BUTTON_SHADOW_WIDTH;
        self.shadowHeight          = self.buttonHeight + DEFAULT_HAM_BUTTON_SHADOW_HEIGHT;
        self.shadowCornerRadius    = DEFAULT_HAM_BUTTON_CORNER_RADIUS;
        self.shadowOffset          = CGSizeMake(DEFAULT_HAM_BUTTON_SHADOW_OFFSET_X, DEFAULT_HAM_BUTTON_SHADOW_OFFSET_Y);
        self.shadowOpacity         = DEFAULT_HAM_BUTTON_SHADOW_OPACITY;
        self.shadowColor           = DEFAULT_HAM_BUTTON_SHADOW_COLOR;
        self.index                 = -1;
    }
    return self;
}

- (VHHamButton *)createButton
{
    return [[VHHamButton alloc] initWithImage:self.imageNormal
                                 pressedImage:self.imagePressed
                                  normalColor:self.buttonNormalColor
                                 pressedColor:self.buttonPressedColor
                         imageNormalTintColor:self.imageNormalTintColor
                        imagePressedTintColor:self.imagePressedTintColor
                             titleNormalColor:self.titleNormalColor
                            titlePressedColor:self.titlePressedColor
                          subTitleNormalColor:self.subTitleNormalColor
                         subTitlePressedColor:self.subTitlePressedColor
                                   imageFrame:self.imageFrame
                                   titleFrame:self.titleFrame
                                subTitleFrame:self.subTitleFrame
                                        title:self.titleContent
                                     subTitle:self.subTitleContent
                                    titleFont:self.titleFont
                                 subTitleFont:self.subTitleFont
                           titleLineBreakMode:self.titleLineBreakMode
                            subTitleBreakMode:self.subTitleLineBreakMode
                                   titleLines:self.titlelines
                                subTitleLines:self.subTitlelines
                               titleAlignment:(NSTextAlignment)self.titleAlignment
                            subTitleAlignment:(NSTextAlignment)self.subTitleAlignment
                                  rotateImage:self.rotateImage
                                 containImage:self.containImage
                                  buttonWidth:self.buttonWidth
                                 buttonHeight:self.buttonHeight
                           buttonCornerRadius:self.buttonCornerRadius
                                  shadowWidth:self.shadowWidth
                                 shadowHeight:self.shadowHeight
                           shadowCornerRadius:self.shadowCornerRadius
                                 shadowOffset:self.shadowOffset
                                shadowOpacity:self.shadowOpacity
                                  shadowColor:self.shadowColor
                                 withDelegate:self.delegate
                                           at:self.index];
}

@end
