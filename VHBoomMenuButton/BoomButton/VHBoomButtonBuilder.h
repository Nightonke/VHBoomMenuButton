//
//  VHBoomButtonBuilder.h
//  VHBoomMenuExample
//
//  Created by 黄伟平 on 16/7/31.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VHBoomButton.h"
#import "VHButtonClickDelegate.h"
#import "VHDefaults.h"
#import "VHSimpleCircleButton.h"
#import "VHBoomButtonBuilder.h"

@interface VHBoomButtonBuilder : NSObject

@property (nonatomic        ) CGSize                shadowOffset;
@property (nonatomic        ) CGFloat               shadowOpacity;
@property (nonatomic, strong) UIColor               *shadowColor;

@property (nonatomic, copy  ) NSString              *imageNormal;
@property (nonatomic, copy  ) NSString              *imagePressed;
@property (nonatomic, strong) UIColor               *buttonNormalColor;
@property (nonatomic, strong) UIColor               *buttonPressedColor;
@property (nonatomic, strong) UIColor               *imageNormalTintColor;
@property (nonatomic, strong) UIColor               *imagePressedTintColor;
@property (nonatomic, strong) UIImageView           *image;
@property (nonatomic,       ) CGRect                imageFrame;

@property (nonatomic        ) int                   index;

@property (nonatomic, weak  ) id<VHButtonClickDelegate> delegate;

- (VHBoomButton *)createButton;

@end
