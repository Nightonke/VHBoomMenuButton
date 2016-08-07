//
//  VHTextOutsideCircleButtonBuilder.h
//  VHBoomMenuButton
//
//  Created by 黄伟平 on 16/8/3.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import "VHBoomButtonBuilder.h"
#import "VHTextOutsideCircleButton.h"

@interface VHTextOutsideCircleButtonBuilder : VHBoomButtonBuilder

@property (nonatomic, assign) CGFloat         shadowRadius;

@property (nonatomic, assign) CGSize          textShadowOffset;
@property (nonatomic, strong) UIColor         *textShadowColor;

@property (nonatomic, assign) CGFloat         buttonWidth;
@property (nonatomic, assign) CGFloat         buttonHeight;

@property (nonatomic, strong) UIColor         *textNormalColor;
@property (nonatomic, strong) UIColor         *textPressedColor;

@property (nonatomic, assign) CGRect          textFrame;
@property (nonatomic, copy  ) NSString        *textContent;
@property (nonatomic, strong) UIFont          *font;
@property (nonatomic, assign) NSLineBreakMode lineBreakMode;
@property (nonatomic, assign) int             lines;

@property (nonatomic, assign) BOOL            rotateImage;
@property (nonatomic, assign) BOOL            rotateText;
@property (nonatomic, assign) BOOL            shadowText;

- (instancetype)init;

- (VHTextOutsideCircleButton *)createButton;

@end
