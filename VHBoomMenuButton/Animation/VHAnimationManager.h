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

- (void)calculateShowXY:(VHBoomEnum)boomEnum
                   ease:(VHEaseEnum)ease
                 frames:(int)frames
          startPosition:(CGPoint)startPosition
            endPosition:(CGPoint)endPosition
                xValues:(NSMutableArray<NSNumber *> *)xs
                yValues:(NSMutableArray<NSNumber *> *)ys;

- (void)calculateHideXY:(VHBoomEnum)boomEnum
                   ease:(VHEaseEnum)ease
                 frames:(int)frames
          startPosition:(CGPoint)startPosition
            endPosition:(CGPoint)endPosition
                xValues:(NSMutableArray<NSNumber *> *)xs
                yValues:(NSMutableArray<NSNumber *> *)ys;

- (NSMutableArray<NSNumber *> *)calculateScale:(VHEaseEnum)ease
                                        frames:(int)frames
                                    startScale:(float)startScale
                                      endScale:(float)endScale;

- (NSMutableArray<NSNumber *> *)calculateRotate:(VHEaseEnum)ease
                                         frames:(int)frames
                                    startRotate:(float)startRotate
                                      endRotate:(float)endRotate;

@end
