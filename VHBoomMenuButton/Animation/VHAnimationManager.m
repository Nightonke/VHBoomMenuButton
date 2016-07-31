//
//  VHAnimationManager.m
//  VHBoomMenuExample
//
//  Created by 黄伟平 on 16/7/28.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import "VHAnimationManager.h"

@implementation VHAnimationManager

+ (instancetype)sharedManager
{
    static VHAnimationManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init
{
    if (self = [super init])
    {
        
    }
    return self;
}

- (void)dealloc
{
    // Should never be called, but just here for clarity really.
}

- (void)calculateShowXY:(VHBoomEnum)boomEnum
                   ease:(VHEaseEnum)ease
                 frames:(int)frames
          startPosition:(CGPoint)startPosition
            endPosition:(CGPoint)endPosition
                xValues:(NSMutableArray<NSNumber *> *)xs
                yValues:(NSMutableArray<NSNumber *> *)ys
{
    CGFloat x1 = startPosition.x;
    CGFloat y1 = startPosition.y;
    CGFloat x2 = endPosition.x;
    CGFloat y2 = endPosition.y;
    CGFloat k;
    CGFloat b;
    CGFloat p = 1.0f / frames;
    CGFloat xOffset = x2 - x1;
    
    switch (boomEnum)
    {
        case StraightLine:
            k = (y2 - y1) / (x2 - x1);
            b = y1 - x1 * k;
            for (int i = 0; i <= frames; i++)
            {
                CGFloat offset = i * p;
                CGFloat offsetInFact = [[VHEaseManager easeWithEnum:ease] offset:offset];
                [xs setObject:[NSNumber numberWithFloat:x1 + offsetInFact * xOffset] atIndexedSubscript:i];
                [ys setObject:[NSNumber numberWithFloat:k * [[xs objectAtIndex:i] floatValue] + b] atIndexedSubscript:i];
            }
            break;
        default:
            break;
    }
}

- (void)calculateHideXY:(VHBoomEnum)boomEnum
                   ease:(VHEaseEnum)ease
                 frames:(int)frames
          startPosition:(CGPoint)startPosition
            endPosition:(CGPoint)endPosition
                xValues:(NSMutableArray<NSNumber *> *)xs
                yValues:(NSMutableArray<NSNumber *> *)ys
{
    switch (boomEnum)
    {
        case StraightLine:
            [self calculateShowXY:boomEnum ease:ease frames:frames startPosition:startPosition endPosition:endPosition xValues:xs yValues:ys];
            break;
            
        default:
            break;
    }
}

- (NSMutableArray<NSNumber *> *)calculateScale:(VHEaseEnum)ease
                                        frames:(int)frames
                                    startScale:(float)startScale
                                      endScale:(float)endScale
{
    NSMutableArray<NSNumber *> *values = [NSMutableArray arrayWithCapacity:frames + 1];
    CGFloat p = 1.0f / frames;
    CGFloat scaleOffset = endScale - startScale;
    for (int i = 0; i <= frames; i++)
    {
        CGFloat offset = i * p;
        CGFloat offsetInFact = [[VHEaseManager easeWithEnum:ease] offset:offset];
        [values addObject:[NSNumber numberWithFloat:startScale + offsetInFact * scaleOffset]];
    }
    return values;
}

- (NSMutableArray<NSNumber *> *)calculateRotate:(VHEaseEnum)ease
                                         frames:(int)frames
                                    startRotate:(float)startRotate
                                      endRotate:(float)endRotate
{
    NSMutableArray<NSNumber *> *values = [NSMutableArray arrayWithCapacity:frames + 1];
    CGFloat p = 1.0f / frames;
    CGFloat scaleOffset = endRotate - startRotate;
    for (int i = 0; i <= frames; i++)
    {
        CGFloat offset = i * p;
        CGFloat offsetInFact = [[VHEaseManager easeWithEnum:ease] offset:offset];
        [values addObject:[NSNumber numberWithFloat:startRotate + offsetInFact * scaleOffset]];
    }
    return values;
}

@end
