//
//  VHAnimationManager.h
//  VHBoomMenuExample
//
//  Created by Nightonke on 16/7/28.
//  Copyright © 2016 Nightonke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VHBoomEnum.h"
#import "VHEase.h"
#import "VHOrderEnum.h"
#import "VHTimeInterpolator.h"

@interface VHAnimationManager : NSObject

+ (CAKeyframeAnimation *)animateKeyPath:(NSString *)keyPath
                                  delay:(CFTimeInterval)delay
                               duration:(CFTimeInterval)duration
                                 values:(NSArray *)values;

+ (CAKeyframeAnimation *)animateKeyPath:(NSString *)keyPath
                                  delay:(CFTimeInterval)delay
                               duration:(CFTimeInterval)duration
                                   ease:(id<VHTimeInterpolator>)ease
                                 frames:(int)frames
                                  start:(CGFloat)start
                                    end:(CGFloat)end;

+ (CABasicAnimation *)boomColorAnimateKeyPath:(NSString *)keyPath
                                        delay:(CFTimeInterval)delay
                                     duration:(CFTimeInterval)duration
                                        start:(UIColor *)start
                                          end:(UIColor *)end;

+ (CABasicAnimation *)reboomColorAnimateKeyPath:(NSString *)keyPath
                                          delay:(CFTimeInterval)delay
                                       duration:(CFTimeInterval)duration
                                          start:(UIColor *)start
                                            end:(UIColor *)end;

+ (CAAnimation *)fadeViewsOpacityAnimation:(BOOL)isBooming duration:(CFTimeInterval)duration;

+ (void)addAnimations:(UIView *)view forKey:(NSString *)key, ... NS_REQUIRES_NIL_TERMINATION;

+ (void)addAnimation:(CAAnimation *)animation forKey:(NSString *)key toViews:(NSArray<UIView *> *)views;

+ (NSMutableArray<NSNumber *> *)values:(id<VHTimeInterpolator>)ease
                                frames:(int)frames
                                 start:(float)start
                                   end:(float)end;

+ (void)calculateBoomXY:(VHBoomEnum)boomEnum
             parentSize:(CGSize)parentSize
                   ease:(id<VHTimeInterpolator>)ease
                 frames:(int)frames
          startPosition:(CGPoint)startPosition
            endPosition:(CGPoint)endPosition
                xValues:(NSMutableArray *)xs
                yValues:(NSMutableArray *)ys;

+ (void)calculateReboomXY:(VHBoomEnum)boomEnum
               parentSize:(CGSize)parentSize
                     ease:(id<VHTimeInterpolator>)ease
                   frames:(int)frames
            startPosition:(CGPoint)startPosition
              endPosition:(CGPoint)endPosition
                  xValues:(NSMutableArray *)xs
                  yValues:(NSMutableArray *)ys;

+ (NSMutableArray<NSNumber *> *)orderIndexes:(VHOrderEnum)orderEnum inSize:(NSUInteger)size;

+ (CAKeyframeAnimation *)rotateXAnimationFromFrames:(int)frames startY:(CGFloat)startY endY:(CGFloat)endY delay:(CFTimeInterval)delay duration:(CFTimeInterval)duration;

+ (CAKeyframeAnimation *)rotateYAnimationFromFrames:(int)frames startX:(CGFloat)startX endX:(CGFloat)endX delay:(CFTimeInterval)delay duration:(CFTimeInterval)duration;

+ (CAKeyframeAnimation *)rotateXAnimationFromVelocity:(NSMutableArray *)ys delay:(CFTimeInterval)delay duration:(CFTimeInterval)duration;

+ (CAKeyframeAnimation *)rotateYAnimationFromVelocity:(NSMutableArray *)xs delay:(CFTimeInterval)delay duration:(CFTimeInterval)duration;

@end
