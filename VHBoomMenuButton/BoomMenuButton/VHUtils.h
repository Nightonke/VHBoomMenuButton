//
//  VHUtils.h
//  VHBoomMenuExample
//
//  Created by Nightonke on 16/7/28.
//  Copyright © 2016 Nightonke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VHUtils : NSObject

+ (void)setAnchorPoint:(CGPoint)anchorPoint ofLayer:(CALayer *)layer;

+ (UIColor *)color;

+ (UIColor *)darkerColor:(UIColor *)color;

+ (UIColor *)lighterColor:(UIColor *)color;

+ (UIColor *)colorFromRGB:(int)color;

+ (UIColor *)colorFromARGB:(int64_t)color;

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

+ (BOOL)sameColor:(UIColor *)color1 asColor:(UIColor *)color2;

@end
