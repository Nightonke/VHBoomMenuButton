//
//  VHSimpleCircleButtonInfo.h
//  VHBoomMenuExample
//
//  Created by 黄伟平 on 16/7/31.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VHButtonClickDelegate.h"
#import "VHDefaults.h"
#import "VHSimpleCircleButton.h"
#import "VHBoomButtonBuilder.h"

@interface VHSimpleCircleButtonBuilder : VHBoomButtonBuilder

@property (nonatomic, assign) CGFloat shadowRadius;

@property (nonatomic, assign) CGFloat buttonRadius;

- (instancetype)init;

- (VHSimpleCircleButton *)createButton;

@end
