//
//  VHHamButtonBuilder.h
//  VHBoomMenuButton
//
//  Created by 黄伟平 on 16/8/7.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import "VHBoomButtonBuilder.h"
#import "VHHamButton.h"

@interface VHHamButtonBuilder : VHBoomButtonBuilder

@property (nonatomic, assign) CGFloat         shadowWidth;
@property (nonatomic, assign) CGFloat         shadowHeight;
@property (nonatomic, assign) CGFloat         shadowCornerRadius;

@property (nonatomic, assign) CGFloat         buttonWidth;
@property (nonatomic, assign) CGFloat         buttonHeight;
@property (nonatomic, assign) CGFloat         buttonCornerRadius;

@property (nonatomic, strong) UIColor         *titleNormalColor;
@property (nonatomic, strong) UIColor         *titlePressedColor;
@property (nonatomic, strong) UIColor         *subTitleNormalColor;
@property (nonatomic, strong) UIColor         *subTitlePressedColor;

@property (nonatomic, assign) CGRect          titleFrame;
@property (nonatomic, copy  ) NSString        *titleContent;
@property (nonatomic, strong) UIFont          *titleFont;
@property (nonatomic, assign) NSLineBreakMode titleLineBreakMode;
@property (nonatomic, assign) int             titlelines;
@property (nonatomic, assign) NSTextAlignment titleAlignment;

@property (nonatomic, assign) CGRect          subTitleFrame;
@property (nonatomic, copy  ) NSString        *subTitleContent;
@property (nonatomic, strong) UIFont          *subTitleFont;
@property (nonatomic, assign) NSLineBreakMode subTitleLineBreakMode;
@property (nonatomic, assign) int             subTitlelines;
@property (nonatomic, assign) NSTextAlignment subTitleAlignment;

@property (nonatomic, assign) BOOL            rotateImage;
@property (nonatomic, assign) BOOL            containImage;

- (instancetype)init;

- (VHHamButton *)createButton;

@end
