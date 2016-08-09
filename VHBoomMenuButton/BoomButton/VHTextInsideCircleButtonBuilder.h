//
//  VHTextInsideCircleButtonBuilder.h
//  VHBoomMenuButton
//
//  Created by 黄伟平 on 16/8/2.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VHButtonClickDelegate.h"
#import "VHDefaults.h"
#import "VHTextInsideCircleButton.h"
#import "VHBoomButtonBuilder.h"

@interface VHTextInsideCircleButtonBuilder : VHBoomButtonBuilder

@property (nonatomic, assign) CGFloat         shadowRadius;

@property (nonatomic, assign) CGFloat         buttonRadius;

@property (nonatomic, strong) UIColor         *textNormalColor;
@property (nonatomic, strong) UIColor         *textPressedColor;

@property (nonatomic, assign) CGRect          textFrame;
@property (nonatomic, copy  ) NSString        *textContent;
@property (nonatomic, strong) UIFont          *font;
@property (nonatomic, assign) NSLineBreakMode lineBreakMode;
@property (nonatomic, assign) int             lines;

@property (nonatomic, assign) BOOL            rotateImage;
@property (nonatomic, assign) BOOL            rotateText;

- (instancetype)init;

- (VHTextInsideCircleButton *)createButton;

@end
