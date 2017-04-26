//
//  VHAnimationManager.h
//  VHBoomMenuExample
//
//  Created by Nightonke on 16/7/28.
//  Copyright © 2016年 Nightonke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VHBoomEnum.h"
#import "VHEase.h"
#import "VHOrderEnum.h"

@interface VHAnimationManager : NSObject

/**
 Create a key-frame-animation.

 @param keyPath KeyPath
 @param delay Delay
 @param duration Duration
 @param values Values
 @return Key-frame-animation
 */
+ (CAKeyframeAnimation *)animateKeyPath:(NSString *)keyPath
                                  delay:(CFTimeInterval)delay
                               duration:(CFTimeInterval)duration
                                 values:(NSArray *)values;

+ (CAKeyframeAnimation *)animateKeyPath:(NSString *)keyPath
                                  delay:(CFTimeInterval)delay
                               duration:(CFTimeInterval)duration
                                   ease:(VHEase *)ease
                                 frames:(int)frames
                                  start:(CGFloat)start
                                    end:(CGFloat)end;

+ (CABasicAnimation *)showColorAnimateKeyPath:(NSString *)keyPath
                                        delay:(CFTimeInterval)delay
                                     duration:(CFTimeInterval)duration
                                        start:(UIColor *)start
                                          end:(UIColor *)end;

+ (CABasicAnimation *)hideColorAnimateKeyPath:(NSString *)keyPath
                                        delay:(CFTimeInterval)delay
                                     duration:(CFTimeInterval)duration
                                        start:(UIColor *)start
                                          end:(UIColor *)end;

/**
 Add animations to a view.

 @param view The target view
 */
+ (void)addAnimations:(UIView *)view, ... NS_REQUIRES_NIL_TERMINATION;

+ (void)addAnimation:(CAAnimation *)animation toViews:(NSArray<UIView *> *)views;

+ (NSMutableArray<NSNumber *> *)values:(VHEase *)ease
                                frames:(int)frames
                                 start:(float)start
                                   end:(float)end;

/**
 *  Calculate the x, y values for showing-animation
 *
 *  @param boomEnum      The boom type
 *  @param parentSize    Size of parent view
 *  @param ease          Ease type
 *  @param frames        Frames, to control the performance
 *  @param startPosition Start position
 *  @param endPosition   End position
 *  @param xs            X values
 *  @param ys            Y values
 */
+ (void)calculateShowXY:(VHBoomEnum)boomEnum
             parentSize:(CGSize)parentSize
                   ease:(VHEase *)ease
                 frames:(int)frames
          startPosition:(CGPoint)startPosition
            endPosition:(CGPoint)endPosition
                xValues:(NSMutableArray *)xs
                yValues:(NSMutableArray *)ys;

/**
 *  Calculate the x, y values for hiding-animation
 *
 *  @param boomEnum      The boom type
 *  @param parentSize    Size of parent view
 *  @param ease          Ease type
 *  @param frames        Frames, to control the performance
 *  @param startPosition Start position
 *  @param endPosition   End position
 *  @param xs            X values
 *  @param ys            Y values
 */
+ (void)calculateHideXY:(VHBoomEnum)boomEnum
             parentSize:(CGSize)parentSize
                   ease:(VHEase *)ease
                 frames:(int)frames
          startPosition:(CGPoint)startPosition
            endPosition:(CGPoint)endPosition
                xValues:(NSMutableArray *)xs
                yValues:(NSMutableArray *)ys;

/**
 *  Get current button index in different order
 *
 *  @param orderEnum Order
 *  @param size      The number of buttons
 *
 *  @return The order for showing or hiding buttons
 */
+ (NSMutableArray<NSNumber *> *)orderIndexes:(VHOrderEnum)orderEnum inSize:(NSUInteger)size;

/**
 *  Calculate the scale values for animations
 *
 *  @param ease       Ease type
 *  @param frames     Frames, to control the performance
 *  @param startScale Start scale value
 *  @param endScale   End scale value
 *
 *  @return Scale values
 */
+ (NSMutableArray<NSNumber *> *)calculateScale:(VHEase *)ease
                                        frames:(int)frames
                                    startScale:(float)startScale
                                      endScale:(float)endScale;

/**
 *  Calculate the rotate values for animations
 *
 *  @param ease        Ease type
 *  @param frames      Frames, to control the performance
 *  @param startRotate Start rotate value
 *  @param endRotate   End rotate value
 *
 *  @return Rotate values
 */
- (NSMutableArray<NSNumber *> *)calculateRotate:(VHEase *)ease
                                         frames:(int)frames
                                    startRotate:(float)startRotate
                                      endRotate:(float)endRotate;

+ (CAKeyframeAnimation *)rotateXAnimationFromFrames:(int)frames startY:(CGFloat)startY endY:(CGFloat)endY delay:(CFTimeInterval)delay duration:(CFTimeInterval)duration;

+ (CAKeyframeAnimation *)rotateYAnimationFromFrames:(int)frames startX:(CGFloat)startX endX:(CGFloat)endX delay:(CFTimeInterval)delay duration:(CFTimeInterval)duration;

+ (CAKeyframeAnimation *)rotateXAnimationFromVelocity:(NSMutableArray *)ys delay:(CFTimeInterval)delay duration:(CFTimeInterval)duration;

+ (CAKeyframeAnimation *)rotateYAnimationFromVelocity:(NSMutableArray *)xs delay:(CFTimeInterval)delay duration:(CFTimeInterval)duration;

@end
