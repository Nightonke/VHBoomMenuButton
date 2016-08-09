//
//  VHBoomButton.h
//  VHBoomMenuExample
//
//  Created by 黄伟平 on 16/7/29.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VHButtonEnum.h"
#import "VHButtonClickDelegate.h"

@interface VHBoomButton : UIView

@property (nonatomic, assign) CGSize                shadowOffset;
@property (nonatomic, assign) CGFloat               shadowOpacity;
@property (nonatomic, strong) UIColor               *shadowColor;

@property (nonatomic, copy  ) NSString              *imageNormal;
@property (nonatomic, copy  ) NSString              *imagePressed;
@property (nonatomic, strong) UIColor               *buttonNormalColor;
@property (nonatomic, strong) UIColor               *buttonPressedColor;
@property (nonatomic, strong) UIColor               *imageNormalTintColor;
@property (nonatomic, strong) UIColor               *imagePressedTintColor;

@property (nonatomic, strong) UIImage               *imageNormalContent;
@property (nonatomic, strong) UIImage               *imagePressedContent;

@property (nonatomic, assign) CGRect                imageFrame;

@property (nonatomic, assign) int                   index;

@property (nonatomic, weak  ) id<VHButtonClickDelegate> delegate;

- (VHButtonEnum)type;
- (NSMutableArray<UIView *> *)goneViews;
- (NSMutableArray<UIView *> *)rotateViews;
- (CGPoint)rotateAnchorPoint;

@end
