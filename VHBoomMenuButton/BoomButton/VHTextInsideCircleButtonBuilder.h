//
//  VHTextInsideCircleButtonBuilder.h
//  VHBoomMenuButton
//
//  Created by Nightonke on 16/8/2.
//  Copyright © 2016年 Nightonke. All rights reserved.
//

#import "VHBoomButtonWithTextBuilder.h"

@interface VHTextInsideCircleButtonBuilder : VHBoomButtonWithTextBuilder

@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) BOOL round;

#pragma mark - Public Methods

+ (VHTextInsideCircleButtonBuilder *)builder;

@end
