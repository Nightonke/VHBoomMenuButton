//
//  VHSimpleCircleButtonInfo.h
//  VHBoomMenuExample
//
//  Created by Nightonke on 16/7/31.
//  Copyright © 2016年 Nightonke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VHBoomButtonBuilder.h"

@interface VHSimpleCircleButtonBuilder : VHBoomButtonBuilder

@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) BOOL round;

#pragma mark - Public Methods

+ (VHSimpleCircleButtonBuilder *)builder;

@end
