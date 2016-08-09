//
//  VHSimpleCicleButton.h
//  VHBoomMenuExample
//
//  Created by 黄伟平 on 16/7/28.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VHUtils.h"
#import "VHDefaults.h"
#import "VHBoomButton.h"

@interface VHSimpleCircleButton : VHBoomButton

@property (nonatomic, assign) CGFloat      shadowRadius;

@property (nonatomic, assign) CGFloat      buttonRadius;

@property (nonatomic, strong) UIImageView  *image;
@property (nonatomic, strong) CAShapeLayer *buttonCircle;

- (instancetype)initWithImage:(NSString *)imageNormal
                 pressedImage:(NSString *)imagePressed
                  normalColor:(UIColor *)normalColor
                 pressedColor:(UIColor *)pressedColor
         imageNormalTintColor:(UIColor *)imageNormalTintColor
        imagePressedTintColor:(UIColor *)imagePressedTintColor
                   imageFrame:(CGRect)imageFrame
                 buttonRadius:(CGFloat)buttonRadius
                 shadowRadius:(CGFloat)shadowRadius
                 shadowOffset:(CGSize) shadowOffset
                shadowOpacity:(CGFloat)shadowOpacity
                  shadowColor:(UIColor *)shadowColor
                 withDelegate:(id<VHButtonClickDelegate>) delegate
                           at:(int)index;
@end
