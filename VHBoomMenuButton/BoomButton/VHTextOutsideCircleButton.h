//
//  VHTextOutsideCircleButton.h
//  VHBoomMenuButton
//
//  Created by 黄伟平 on 16/8/3.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import "VHBoomButton.h"

@interface VHTextOutsideCircleButton : VHBoomButton

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

@property (nonatomic, strong) UIImageView     *image;
@property (nonatomic, strong) UILabel         *text;
@property (nonatomic, strong) CAShapeLayer    *buttonCircle;

- (instancetype)initWithImage:(NSString *)imageNormal
                 pressedImage:(NSString *)imagePressed
                  normalColor:(UIColor *)normalColor
                 pressedColor:(UIColor *)pressedColor
         imageNormalTintColor:(UIColor *)imageNormalTintColor
        imagePressedTintColor:(UIColor *)imagePressedTintColor
              textNormalColor:(UIColor *)textNormalColor
             textPressedColor:(UIColor *)textPressedColor
                   imageFrame:(CGRect)imageFrame
                    textFrame:(CGRect)textFrame
                         text:(NSString *)textContent
                         font:(UIFont *)font
                lineBreakMode:(NSLineBreakMode)lineBreakMode
                        lines:(int)lines
                  rotateImage:(BOOL)rotateImage
                   rotateText:(BOOL)rotateText
                   shadowText:(BOOL)shadowText
                  buttonWidth:(CGFloat)buttonWidth
                 buttonHeight:(CGFloat)buttonHeight
                 shadowRadius:(CGFloat)shadowRadius
                 shadowOffset:(CGSize) shadowOffset
                shadowOpacity:(CGFloat)shadowOpacity
                  shadowColor:(UIColor *)shadowColor
             textShadowOffset:(CGSize)textShadowOffset
              textShadowColor:(UIColor *)textShadowColor
                 withDelegate:(id<VHButtonClickDelegate>) delegate
                           at:(int)index;

@end
