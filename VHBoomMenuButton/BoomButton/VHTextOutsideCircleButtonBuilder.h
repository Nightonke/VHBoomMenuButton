//
//  VHTextOutsideCircleButtonBuilder.h
//  VHBoomMenuButton
//
//  Created by Nightonke on 16/8/3.
//  Copyright © 2016年 Nightonke. All rights reserved.
//

#import "VHBoomButtonWithTextBuilder.h"

@interface VHTextOutsideCircleButtonBuilder : VHBoomButtonWithTextBuilder

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) BOOL round;

#pragma mark - Public Methods

+ (VHTextOutsideCircleButtonBuilder *)builder;

@end
