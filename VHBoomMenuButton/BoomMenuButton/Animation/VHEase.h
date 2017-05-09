//
//  VHEase.h
//  VHMediaTimingFunction
//
//  Created by Nightonke on 16/7/22.
//  Copyright © 2016 Nightonke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VHTimeInterpolator.h"

/// Check https://github.com/Nightonke/VHBoomMenuButton/wiki/Ease-Animations-for-Buttons for more information about ease-animation.

/// Linear Timing Function.
FOUNDATION_EXPORT NSString *const VHEaseLinear;

/// In-Sine timing function.
FOUNDATION_EXPORT NSString *const VHEaseInSine;
/// Out-Sine timing function.
FOUNDATION_EXPORT NSString *const VHEaseOutSine;
/// In-Out-Sine timing function.
FOUNDATION_EXPORT NSString *const VHEaseInOutSine;

/// In-Quad timing function.
FOUNDATION_EXPORT NSString *const VHEaseInQuad;
/// Out-Quad timing function.
FOUNDATION_EXPORT NSString *const VHEaseOutQuad;
/// In-Out-Quad timing function.
FOUNDATION_EXPORT NSString *const VHEaseInOutQuad;

/// In-Cubic timing function.
FOUNDATION_EXPORT NSString *const VHEaseInCubic;
/// Out-Cubic timing function.
FOUNDATION_EXPORT NSString *const VHEaseOutCubic;
/// In-Out-Cubic timing function.
FOUNDATION_EXPORT NSString *const VHEaseInOutCubic;

/// In-Quart timing function.
FOUNDATION_EXPORT NSString *const VHEaseInQuart;
/// Out-Quart timing function.
FOUNDATION_EXPORT NSString *const VHEaseOutQuart;
/// In-Out-Quart timing function.
FOUNDATION_EXPORT NSString *const VHEaseInOutQuart;

/// In-Quint timing function.
FOUNDATION_EXPORT NSString *const VHEaseInQuint;
/// Out-Quint timing function.
FOUNDATION_EXPORT NSString *const VHEaseOutQuint;
/// In-Out-Quint timing function.
FOUNDATION_EXPORT NSString *const VHEaseInOutQuint;

/// In-Circ timing function.
FOUNDATION_EXPORT NSString *const VHEaseInCirc;
/// Out-Circ timing function.
FOUNDATION_EXPORT NSString *const VHEaseOutCirc;
/// In-Out-Circ timing function.
FOUNDATION_EXPORT NSString *const VHEaseInOutCirc;

/// In-Expo timing function.
FOUNDATION_EXPORT NSString *const VHEaseInExpo;
/// Out-Expo timing function.
FOUNDATION_EXPORT NSString *const VHEaseOutExpo;
/// In-Out-Expo timinig function.
FOUNDATION_EXPORT NSString *const VHEaseInOutExpo;

/// In-Back timing function.
FOUNDATION_EXPORT NSString *const VHEaseInBack;
/// Out-Back timing function.
FOUNDATION_EXPORT NSString *const VHEaseOutBack;
/// In-Out-Back timing function.
FOUNDATION_EXPORT NSString *const VHEaseInOutBack;

/// In-Elastic timing function.
FOUNDATION_EXPORT NSString *const VHEaseInElastic;
/// Out-Elastic timing function.
FOUNDATION_EXPORT NSString *const VHEaseOutElastic;
/// In-Out-Elastic timing function.
FOUNDATION_EXPORT NSString *const VHEaseInOutElastic;

/// In-Bounce timing function.
FOUNDATION_EXPORT NSString *const VHEaseInBounce;
/// Out-Bounce timing function.
FOUNDATION_EXPORT NSString *const VHEaseOutBounce;
/// In-Out-Bounce timing function.
FOUNDATION_EXPORT NSString *const VHEaseInOutBounce;

@interface VHEase : NSObject<VHTimeInterpolator>

+ (instancetype)easeWithName:(NSString *)name;

@end
