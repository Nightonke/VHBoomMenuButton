//
//  VHHamButton.h
//  VHBoomMenuButton
//
//  Created by 黄伟平 on 16/8/7.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import "VHBoomButton.h"

@interface VHHamButton : VHBoomButton

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

@property (nonatomic        ) UIImageView    *image;
@property (nonatomic, strong) UILabel         *title;
@property (nonatomic, strong) UILabel         *subTitle;
@property (nonatomic, strong) CAShapeLayer    *buttonRect;

- (instancetype)initWithImage:(NSString *)imageNormal
                 pressedImage:(NSString *)imagePressed
                  normalColor:(UIColor *)normalColor
                 pressedColor:(UIColor *)pressedColor
         imageNormalTintColor:(UIColor *)imageNormalTintColor
        imagePressedTintColor:(UIColor *)imagePressedTintColor
             titleNormalColor:(UIColor *)titleNormalColor
            titlePressedColor:(UIColor *)titlePressedColor
          subTitleNormalColor:(UIColor *)subTitleNormalColor
         subTitlePressedColor:(UIColor *)subTitlePressedColor
                   imageFrame:(CGRect)imageFrame
                   titleFrame:(CGRect)titleFrame
                subTitleFrame:(CGRect)subTitleFrame
                        title:(NSString *)titleContent
                     subTitle:(NSString *)subTitleContent
                    titleFont:(UIFont *)titleFont
                 subTitleFont:(UIFont *)subTitleFont
           titleLineBreakMode:(NSLineBreakMode)titleLineBreakMode
            subTitleBreakMode:(NSLineBreakMode)subTitleLineBreakMode
                   titleLines:(int)titleLines
                subTitleLines:(int)subTitleLines
               titleAlignment:(NSTextAlignment)titleAlignment
            subTitleAlignment:(NSTextAlignment)subTitleAlignment
                  rotateImage:(BOOL)rotateImage
                 containImage:(BOOL)containImage
                  buttonWidth:(CGFloat)buttonWidth
                 buttonHeight:(CGFloat)buttonHeight
           buttonCornerRadius:(CGFloat)buttonCornerRadius
                  shadowWidth:(CGFloat)shadowWidth
                 shadowHeight:(CGFloat)shadowHeight
           shadowCornerRadius:(CGFloat)shadowCornerRadius
                 shadowOffset:(CGSize) shadowOffset
                shadowOpacity:(CGFloat)shadowOpacity
                  shadowColor:(UIColor *)shadowColor
                 withDelegate:(id<VHButtonClickDelegate>) delegate
                           at:(int)index;

@end
