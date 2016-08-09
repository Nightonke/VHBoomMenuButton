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
    if (startPosition.x == endPosition.x)
    {
        [self calculateXYInSameX:boomEnum ease:ease frames:frames startPosition:startPosition endPosition:endPosition xValues:xs yValues:ys];
        return;
    }
    
    CGFloat x1      = startPosition.x;
    CGFloat y1      = startPosition.y;
    CGFloat x2      = endPosition.x;
    CGFloat y2      = endPosition.y;
    CGFloat k;
    CGFloat b;
    CGFloat p       = 1.0f / frames;
    CGFloat xOffset = x2 - x1;
    CGFloat yOffset = y2 - y1;
    
    switch (boomEnum)
    {
        case VHBoomStraightLine:
            k = (y2 - y1) / (x2 - x1);
            b = y1 - x1 * k;
            for (int i = 0; i <= frames; i++)
            {
                CGFloat offset       = i * p;
                CGFloat offsetInFact = [[VHEaseManager easeWithEnum:ease] offset:offset];
                [xs setObject:[NSNumber numberWithFloat:x1 + offsetInFact * xOffset] atIndexedSubscript:i];
                [ys setObject:[NSNumber numberWithFloat:k * [[xs objectAtIndex:i] floatValue] + b] atIndexedSubscript:i];
            }
            break;
        case VHBoomParabola_1:
        {
            CGFloat x3 = (x1 + x2) / 2;
            CGFloat y3 = MIN(y1, y2) * 3 / 4;
            CGFloat a, b, c;
            a          = (y1 * (x2 - x3) + y2 * (x3 - x1) + y3 * (x1 - x2)) / (x1 * x1 * (x2 - x3) + x2 * x2 * (x3 - x1) + x3 * x3 * (x1 - x2));
            b          = (y1 - y2) / (x1 - x2) - a * (x1 + x2);
            c          = y1 - (x1 * x1) * a - x1 * b;
            for (int i = 0; i <= frames; i++)
            {
                CGFloat offset       = i * p;
                CGFloat offsetInFact = [[VHEaseManager easeWithEnum:ease] offset:offset];
                [xs setObject:[NSNumber numberWithFloat:x1 + offsetInFact * xOffset] atIndexedSubscript:i];
                CGFloat x            = [[xs objectAtIndex:i] floatValue];
                [ys setObject:[NSNumber numberWithFloat:a * x * x + b * x + c] atIndexedSubscript:i];
            }
        }
            break;
        case VHBoomParabola_2:
        {
            CGFloat x3 = (x1 + x2) / 2;
            CGFloat y3 = ([UIScreen mainScreen].bounds.size.height - MAX(y1, y2)) / 2 + MAX(y1, y2);
            CGFloat a, b, c;
            a          = (y1 * (x2 - x3) + y2 * (x3 - x1) + y3 * (x1 - x2)) / (x1 * x1 * (x2 - x3) + x2 * x2 * (x3 - x1) + x3 * x3 * (x1 - x2));
            b          = (y1 - y2) / (x1 - x2) - a * (x1 + x2);
            c          = y1 - (x1 * x1) * a - x1 * b;
            for (int i = 0; i <= frames; i++)
            {
                CGFloat offset       = i * p;
                CGFloat offsetInFact = [[VHEaseManager easeWithEnum:ease] offset:offset];
                [xs setObject:[NSNumber numberWithFloat:x1 + offsetInFact * xOffset] atIndexedSubscript:i];
                CGFloat x            = [[xs objectAtIndex:i] floatValue];
                [ys setObject:[NSNumber numberWithFloat:a * x * x + b * x + c] atIndexedSubscript:i];
            }
        }
            break;
        case VHBoomParabola_3:
        {
            CGFloat y3 = (y1 + y2) / 2;
            CGFloat x3 = MIN(x1, x2) / 2;
            CGFloat a, b, c;
            a          = (x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2)) / (y1 * y1 * (y2 - y3) + y2 * y2 * (y3 - y1) + y3 * y3 * (y1 - y2));
            b          = (x1 - x2) / (y1 - y2) - a * (y1 + y2);
            c          = x1 - (y1 * y1) * a - y1 * b;
            for (int i = 0; i <= frames; i++)
            {
                CGFloat offset       = i * p;
                CGFloat offsetInFact = [[VHEaseManager easeWithEnum:ease] offset:offset];
                [ys setObject:[NSNumber numberWithFloat:y1 + offsetInFact * yOffset] atIndexedSubscript:i];
                CGFloat y            = [[ys objectAtIndex:i] floatValue];
                [xs setObject:[NSNumber numberWithFloat:a * y * y + b * y + c] atIndexedSubscript:i];
            }
        }
            break;
        case VHBoomParabola_4:
        {
            CGFloat y3 = (y1 + y2) / 2;
            CGFloat x3 = ([UIScreen mainScreen].bounds.size.width - MAX(x1, x2)) / 2 + MAX(x1, x2);
            CGFloat a, b, c;
            a          = (x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2)) / (y1 * y1 * (y2 - y3) + y2 * y2 * (y3 - y1) + y3 * y3 * (y1 - y2));
            b          = (x1 - x2) / (y1 - y2) - a * (y1 + y2);
            c          = x1 - (y1 * y1) * a - y1 * b;
            for (int i = 0; i <= frames; i++)
            {
                CGFloat offset       = i * p;
                CGFloat offsetInFact = [[VHEaseManager easeWithEnum:ease] offset:offset];
                [ys setObject:[NSNumber numberWithFloat:y1 + offsetInFact * yOffset] atIndexedSubscript:i];
                CGFloat y            = [[ys objectAtIndex:i] floatValue];
                [xs setObject:[NSNumber numberWithFloat:a * y * y + b * y + c] atIndexedSubscript:i];
            }
        }
            break;
        case VHBoomHorizontalThrow_1:
        {
            CGFloat x3 = x2 * 2 - x1;
            CGFloat y3 = y1;
            CGFloat a, b, c;
            a          = (y1 * (x3 - x2) + y3 * (x2 - x1) + y2 * (x1 - x3)) / (x1 * x1 * (x3 - x2) + x3 * x3 * (x2 - x1) + x2 * x2 * (x1 - x3));
            b          = (y1 - y3) / (x1 - x3) - a * (x1 + x3);
            c          = y1 - (x1 * x1) * a - x1 * b;
            for (int i = 0; i <= frames; i++)
            {
                CGFloat offset       = i * p;
                CGFloat offsetInFact = [[VHEaseManager easeWithEnum:ease] offset:offset];
                [xs setObject:[NSNumber numberWithFloat:x1 + offsetInFact * xOffset] atIndexedSubscript:i];
                CGFloat x            = [[xs objectAtIndex:i] floatValue];
                [ys setObject:[NSNumber numberWithFloat:a * x * x + b * x + c] atIndexedSubscript:i];
            }
        }
            break;
        case VHBoomHorizontalThrow_2:
        {
            CGFloat x2 = startPosition.x;
            CGFloat y2 = startPosition.y;
            CGFloat x1 = endPosition.x;
            CGFloat y1 = endPosition.y;
            CGFloat x3 = x2 * 2 - x1;
            CGFloat y3 = y1;
            CGFloat a, b, c;
            a          = (y1 * (x3 - x2) + y3 * (x2 - x1) + y2 * (x1 - x3)) / (x1 * x1 * (x3 - x2) + x3 * x3 * (x2 - x1) + x2 * x2 * (x1 - x3));
            b          = (y1 - y3) / (x1 - x3) - a * (x1 + x3);
            c          = y1 - (x1 * x1) * a - x1 * b;
            for (int i = 0; i <= frames; i++)
            {
                CGFloat offset       = i * p;
                CGFloat offsetInFact = [[VHEaseManager easeWithEnum:ease] offset:offset];
                [xs setObject:[NSNumber numberWithFloat:x2 + offsetInFact * xOffset] atIndexedSubscript:i];
                CGFloat x            = [[xs objectAtIndex:i] floatValue];
                [ys setObject:[NSNumber numberWithFloat:a * x * x + b * x + c] atIndexedSubscript:i];
            }
        }
            break;
        case VHBoomRandom:
        {
            int r = arc4random() % VHBoomRandom;
            [self calculateShowXY:r ease:ease frames:frames startPosition:startPosition endPosition:endPosition xValues:xs yValues:ys];
        }
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
    if (startPosition.x == endPosition.x)
    {
        [self calculateXYInSameX:boomEnum ease:ease frames:frames startPosition:startPosition endPosition:endPosition xValues:xs yValues:ys];
        return;
    }
    
    CGFloat x1      = startPosition.x;
    CGFloat y1      = startPosition.y;
    CGFloat x2      = endPosition.x;
    CGFloat y2      = endPosition.y;
    CGFloat p       = 1.0f / frames;
    CGFloat xOffset = x2 - x1;
    CGFloat yOffset = y2 - y1;
    
    switch (boomEnum)
    {
        case VHBoomStraightLine:
            [self calculateShowXY:boomEnum ease:ease frames:frames startPosition:startPosition endPosition:endPosition xValues:xs yValues:ys];
            break;
        case VHBoomParabola_1:
        {
            CGFloat x3 = (x1 + x2) / 2;
            CGFloat y3 = MIN(y1, y2) * 3 / 4;
            CGFloat a, b, c;
            a          = (y1 * (x2 - x3) + y2 * (x3 - x1) + y3 * (x1 - x2)) / (x1 * x1 * (x2 - x3) + x2 * x2 * (x3 - x1) + x3 * x3 * (x1 - x2));
            b          = (y1 - y2) / (x1 - x2) - a * (x1 + x2);
            c          = y1 - (x1 * x1) * a - x1 * b;
            for (int i = 0; i <= frames; i++)
            {
                CGFloat offset       = i * p;
                CGFloat offsetInFact = [[VHEaseManager easeWithEnum:ease] offset:offset];
                [xs setObject:[NSNumber numberWithFloat:x1 + offsetInFact * xOffset] atIndexedSubscript:i];
                CGFloat x            = [[xs objectAtIndex:i] floatValue];
                [ys setObject:[NSNumber numberWithFloat:a * x * x + b * x + c] atIndexedSubscript:i];
            }
        }
            break;
        case VHBoomParabola_2:
        {
            CGFloat x3 = (x1 + x2) / 2;
            CGFloat y3 = ([UIScreen mainScreen].bounds.size.height - MAX(y1, y2)) / 2 + MAX(y1, y2);
            CGFloat a, b, c;
            a          = (y1 * (x2 - x3) + y2 * (x3 - x1) + y3 * (x1 - x2)) / (x1 * x1 * (x2 - x3) + x2 * x2 * (x3 - x1) + x3 * x3 * (x1 - x2));
            b          = (y1 - y2) / (x1 - x2) - a * (x1 + x2);
            c          = y1 - (x1 * x1) * a - x1 * b;
            for (int i = 0; i <= frames; i++)
            {
                CGFloat offset       = i * p;
                CGFloat offsetInFact = [[VHEaseManager easeWithEnum:ease] offset:offset];
                [xs setObject:[NSNumber numberWithFloat:x1 + offsetInFact * xOffset] atIndexedSubscript:i];
                CGFloat x            = [[xs objectAtIndex:i] floatValue];
                [ys setObject:[NSNumber numberWithFloat:a * x * x + b * x + c] atIndexedSubscript:i];
            }
        }
            break;
        case VHBoomParabola_3:
        {
            CGFloat y3 = (y1 + y2) / 2;
            CGFloat x3 = MIN(x1, x2) / 2;
            CGFloat a, b, c;
            a          = (x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2)) / (y1 * y1 * (y2 - y3) + y2 * y2 * (y3 - y1) + y3 * y3 * (y1 - y2));
            b          = (x1 - x2) / (y1 - y2) - a * (y1 + y2);
            c          = x1 - (y1 * y1) * a - y1 * b;
            for (int i = 0; i <= frames; i++)
            {
                CGFloat offset       = i * p;
                CGFloat offsetInFact = [[VHEaseManager easeWithEnum:ease] offset:offset];
                [ys setObject:[NSNumber numberWithFloat:y1 + offsetInFact * yOffset] atIndexedSubscript:i];
                CGFloat y            = [[ys objectAtIndex:i] floatValue];
                [xs setObject:[NSNumber numberWithFloat:a * y * y + b * y + c] atIndexedSubscript:i];
            }
        }
            break;
        case VHBoomParabola_4:
        {
            CGFloat y3 = (y1 + y2) / 2;
            CGFloat x3 = ([UIScreen mainScreen].bounds.size.width - MAX(x1, x2)) / 2 + MAX(x1, x2);
            CGFloat a, b, c;
            a          = (x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2)) / (y1 * y1 * (y2 - y3) + y2 * y2 * (y3 - y1) + y3 * y3 * (y1 - y2));
            b          = (x1 - x2) / (y1 - y2) - a * (y1 + y2);
            c          = x1 - (y1 * y1) * a - y1 * b;
            for (int i = 0; i <= frames; i++)
            {
                CGFloat offset       = i * p;
                CGFloat offsetInFact = [[VHEaseManager easeWithEnum:ease] offset:offset];
                [ys setObject:[NSNumber numberWithFloat:y1 + offsetInFact * yOffset] atIndexedSubscript:i];
                CGFloat y            = [[ys objectAtIndex:i] floatValue];
                [xs setObject:[NSNumber numberWithFloat:a * y * y + b * y + c] atIndexedSubscript:i];
            }
        }
            break;
        case VHBoomHorizontalThrow_1:
        {
            CGFloat x2 = startPosition.x;
            CGFloat y2 = startPosition.y;
            CGFloat x1 = endPosition.x;
            CGFloat y1 = endPosition.y;
            CGFloat x3 = x2 * 2 - x1;
            CGFloat y3 = y1;
            CGFloat a, b, c;
            a          = (y1 * (x3 - x2) + y3 * (x2 - x1) + y2 * (x1 - x3)) / (x1 * x1 * (x3 - x2) + x3 * x3 * (x2 - x1) + x2 * x2 * (x1 - x3));
            b          = (y1 - y3) / (x1 - x3) - a * (x1 + x3);
            c          = y1 - (x1 * x1) * a - x1 * b;
            for (int i = 0; i <= frames; i++)
            {
                CGFloat offset       = i * p;
                CGFloat offsetInFact = [[VHEaseManager easeWithEnum:ease] offset:offset];
                [xs setObject:[NSNumber numberWithFloat:x2 + offsetInFact * xOffset] atIndexedSubscript:i];
                CGFloat x            = [[xs objectAtIndex:i] floatValue];
                [ys setObject:[NSNumber numberWithFloat:a * x * x + b * x + c] atIndexedSubscript:i];
            }
        }
            break;
        case VHBoomHorizontalThrow_2:
        {
            CGFloat x3 = x2 * 2 - x1;
            CGFloat y3 = y1;
            CGFloat a, b, c;
            a          = (y1 * (x3 - x2) + y3 * (x2 - x1) + y2 * (x1 - x3)) / (x1 * x1 * (x3 - x2) + x3 * x3 * (x2 - x1) + x2 * x2 * (x1 - x3));
            b          = (y1 - y3) / (x1 - x3) - a * (x1 + x3);
            c          = y1 - (x1 * x1) * a - x1 * b;
            for (int i = 0; i <= frames; i++)
            {
                CGFloat offset       = i * p;
                CGFloat offsetInFact = [[VHEaseManager easeWithEnum:ease] offset:offset];
                [xs setObject:[NSNumber numberWithFloat:x1 + offsetInFact * xOffset] atIndexedSubscript:i];
                CGFloat x            = [[xs objectAtIndex:i] floatValue];
                [ys setObject:[NSNumber numberWithFloat:a * x * x + b * x + c] atIndexedSubscript:i];
            }
        }
            break;
        case VHBoomRandom:
        {
            int r = arc4random() % VHBoomRandom;
            [self calculateHideXY:r ease:ease frames:frames startPosition:startPosition endPosition:endPosition xValues:xs yValues:ys];
        }
            break;
    }
}

- (NSMutableArray<NSNumber *> *)calculateScale:(VHEaseEnum)ease
                                        frames:(int)frames
                                    startScale:(float)startScale
                                      endScale:(float)endScale
{
    NSMutableArray<NSNumber *> *values = [NSMutableArray arrayWithCapacity:frames + 1];
    CGFloat p                          = 1.0f / frames;
    CGFloat scaleOffset                = endScale - startScale;
    for (int i = 0; i <= frames; i++)
    {
        CGFloat offset       = i * p;
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
    CGFloat p                          = 1.0f / frames;
    CGFloat scaleOffset                = endRotate - startRotate;
    for (int i = 0; i <= frames; i++)
    {
        CGFloat offset       = i * p;
        CGFloat offsetInFact = [[VHEaseManager easeWithEnum:ease] offset:offset];
        [values addObject:[NSNumber numberWithFloat:startRotate + offsetInFact * scaleOffset]];
    }
    return values;
}

- (void)calculateXYInSameX:(VHBoomEnum)boomEnum
                      ease:(VHEaseEnum)ease
                    frames:(int)frames
             startPosition:(CGPoint)startPosition
               endPosition:(CGPoint)endPosition
                   xValues:(NSMutableArray<NSNumber *> *)xs
                   yValues:(NSMutableArray<NSNumber *> *)ys
{
    CGFloat x1      = startPosition.x;
    CGFloat y1      = startPosition.y;
    CGFloat x2      = endPosition.x;
    CGFloat y2      = endPosition.y;
    CGFloat p       = 1.0f / frames;
    CGFloat xOffset = x2 - x1;
    CGFloat yOffset = y2 - y1;
    for (int i = 0; i <= frames; i++)
    {
        CGFloat offset       = i * p;
        CGFloat offsetInFact = [[VHEaseManager easeWithEnum:ease] offset:offset];
        [xs setObject:[NSNumber numberWithFloat:x1 + offsetInFact * xOffset] atIndexedSubscript:i];
        [ys setObject:[NSNumber numberWithFloat:y1 + offsetInFact * yOffset] atIndexedSubscript:i];
    }
}

@end
