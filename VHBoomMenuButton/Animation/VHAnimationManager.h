//
//  VHAnimationManager.h
//  VHBoomMenuExample
//
//  Created by 黄伟平 on 16/7/28.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VHBoomEnum.h"
#import "VHEaseEnum.h"
#import "VHEaseManager.h"

@interface VHAnimationManager : NSObject

+ (instancetype)sharedManager;

/**
 *  Calculate the x, y values for showing-animation
 *
 *  @param boomEnum      The boom type
 *  @param ease          Ease type
 *  @param frames        Frames, to control the performance
 *  @param startPosition Start position
 *  @param endPosition   End position
 *  @param xs            X values
 *  @param ys            Y values
 */
- (void)calculateShowXY:(VHBoomEnum)boomEnum
                   ease:(VHEaseEnum)ease
                 frames:(int)frames
          startPosition:(CGPoint)startPosition
            endPosition:(CGPoint)endPosition
                xValues:(NSMutableArray<NSNumber *> *)xs
                yValues:(NSMutableArray<NSNumber *> *)ys;

/**
 *  Calculate the x, y values for hiding-animation
 *
 *  @param boomEnum      The boom type
 *  @param ease          Ease type
 *  @param frames        Frames, to control the performance
 *  @param startPosition Start position
 *  @param endPosition   End position
 *  @param xs            X values
 *  @param ys            Y values
 */
- (void)calculateHideXY:(VHBoomEnum)boomEnum
                   ease:(VHEaseEnum)ease
                 frames:(int)frames
          startPosition:(CGPoint)startPosition
            endPosition:(CGPoint)endPosition
                xValues:(NSMutableArray<NSNumber *> *)xs
                yValues:(NSMutableArray<NSNumber *> *)ys;

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
- (NSMutableArray<NSNumber *> *)calculateScale:(VHEaseEnum)ease
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
- (NSMutableArray<NSNumber *> *)calculateRotate:(VHEaseEnum)ease
                                         frames:(int)frames
                                    startRotate:(float)startRotate
                                      endRotate:(float)endRotate;

@end
