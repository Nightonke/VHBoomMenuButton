//
//  VHEase.h
//  VHMediaTimingFunction
//
//  Created by Nightonke on 16/7/22.
//  Copyright © 2016年 Nightonke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VHTimeInterpolator.h"

FOUNDATION_EXPORT NSString *const VHEaseLinear;

FOUNDATION_EXPORT NSString *const VHEaseInSine;
FOUNDATION_EXPORT NSString *const VHEaseOutSine;
FOUNDATION_EXPORT NSString *const VHEaseInOutSine;

FOUNDATION_EXPORT NSString *const VHEaseInQuad;
FOUNDATION_EXPORT NSString *const VHEaseOutQuad;
FOUNDATION_EXPORT NSString *const VHEaseInOutQuad;

FOUNDATION_EXPORT NSString *const VHEaseInCubic;
FOUNDATION_EXPORT NSString *const VHEaseOutCubic;
FOUNDATION_EXPORT NSString *const VHEaseInOutCubic;

FOUNDATION_EXPORT NSString *const VHEaseInQuart;
FOUNDATION_EXPORT NSString *const VHEaseOutQuart;
FOUNDATION_EXPORT NSString *const VHEaseInOutQuart;

FOUNDATION_EXPORT NSString *const VHEaseInQuint;
FOUNDATION_EXPORT NSString *const VHEaseOutQuint;
FOUNDATION_EXPORT NSString *const VHEaseInOutQuint;

FOUNDATION_EXPORT NSString *const VHEaseInCirc;
FOUNDATION_EXPORT NSString *const VHEaseOutCirc;
FOUNDATION_EXPORT NSString *const VHEaseInOutCirc;

FOUNDATION_EXPORT NSString *const VHEaseInExpo;
FOUNDATION_EXPORT NSString *const VHEaseOutExpo;
FOUNDATION_EXPORT NSString *const VHEaseInOutExpo;

FOUNDATION_EXPORT NSString *const VHEaseInBack;
FOUNDATION_EXPORT NSString *const VHEaseOutBack;
FOUNDATION_EXPORT NSString *const VHEaseInOutBack;

FOUNDATION_EXPORT NSString *const VHEaseInElastic;
FOUNDATION_EXPORT NSString *const VHEaseOutElastic;
FOUNDATION_EXPORT NSString *const VHEaseInOutElastic;

FOUNDATION_EXPORT NSString *const VHEaseInBounce;
FOUNDATION_EXPORT NSString *const VHEaseOutBounce;
FOUNDATION_EXPORT NSString *const VHEaseInOutBounce;

@interface VHEase : NSObject<VHTimeInterpolator>

+ (instancetype)easeWithName:(NSString *)name;

@end
