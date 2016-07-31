//
//  VHEase.m
//  VHMediaTimingFunction
//
//  Created by 黄伟平 on 16/7/22.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import "VHEase.h"

@interface VHEase ()

@property (nonatomic) CGPoint start;
@property (nonatomic) CGPoint end;
@property (nonatomic) CGPoint a;
@property (nonatomic) CGPoint b;
@property (nonatomic) CGPoint c;

@end

@implementation VHEase

- (instancetype)initWithStartX:(CGFloat)startX startY:(CGFloat)startY endX:(CGFloat)endX endY:(CGFloat)endY
{
    self.ableToDefineWithControlPoints = YES;
    
    self.start = CGPointMake(startX, startY);
    self.end = CGPointMake(endX, endY);
    self.a = CGPointMake(0, 0);
    self.b = CGPointMake(0, 0);
    self.c = CGPointMake(0, 0);
    return self;
}

- (instancetype)initWithEnum:(VHEaseEnum)vhEaseEnum
{
    self.ableToDefineWithControlPoints = NO;
    self.vhEaseEnum = vhEaseEnum;
    return self;
}

- (CGFloat)offset:(CGFloat)offset
{
    if (self.ableToDefineWithControlPoints)
    {
        return [self getBezierCoordinateY:offset];
    }
    else
    {
        switch (self.vhEaseEnum) {
            case VHEaseInBounce:
                return [self easeInBounceOffset:offset];
                break;
            case VHEaseInElastic:
                return [self easeInElasticOffset:offset];
                break;
            case VHEaseOutBounce:
                return [self easeOutBounceOffset:offset];
                break;
            case VHEaseOutElastic:
                return [self easeOutElasticOffset:offset];
                break;
            case VHEaseInOutBounce:
                return [self easeInOutBounceOffset:offset];
                break;
            case VHEaseInOutElastic:
                return [self easeInOutElasticOffset:offset];
                break;
            default:
                NSAssert(YES, @"There are no VHEaseEnum to match the given one!");
                return 0;
                break;
        }
    }
}

- (CGFloat)getBezierCoordinateY:(CGFloat)time
{
    self.c = CGPointMake(self.c.x, 3 * self.start.y);
    self.b = CGPointMake(self.b.x, 3 * (self.end.y - self.start.y) - self.c.y);
    self.a = CGPointMake(self.a.x, 1 - self.c.y - self.b.y);
    return time * (self.c.y + time * (self.b.y + time * self.a.y));
}

- (CGFloat)getXForTime:(CGFloat)time
{
    CGFloat x = time;
    CGFloat z;
    for (int i = 0; i < 14; i++)
    {
        z = [self getBezierCoordinateX:x] - time;
        if (fabs(z) < 0.001)
        {
            break;
        }
        x -= z / [self getXDerivate:x];
    }
    return x;
}

- (CGFloat)getXDerivate:(CGFloat)t
{
    return self.c.x + t * (2 * self.b.x + 3 * self.a.x * t);
}

- (CGFloat)getBezierCoordinateX:(CGFloat)time
{
    self.c = CGPointMake(3 * self.start.x, self.c.y);
    self.b = CGPointMake(3 * (self.end.x - self.start.x) - self.c.x, self.b.y);
    self.a = CGPointMake(1 - self.c.x - self.b.x, self.a.y);
    return time * (self.c.x + time * (self.b.x + time * self.a.x));
}

- (CGFloat)easeInBounceOffset:(CGFloat)offset
{
    CGFloat b = 0;
    CGFloat c = 1;
    CGFloat d = 1;
    return c - [self easeBounceOffsetHelper2:d - offset b:0 c:c d:d] + b;
}

- (CGFloat)easeBounceOffsetHelper1:(CGFloat)t b:(CGFloat)b c:(CGFloat)c d:(CGFloat)d
{
    return c - [self easeBounceOffsetHelper2:d - t b:0 c:c d:d] + b;
}

- (CGFloat)easeBounceOffsetHelper2:(CGFloat)t b:(CGFloat)b c:(CGFloat)c d:(CGFloat)d
{
    if ((t /= d) < (1 / 2.75))
    {
        return c * (7.5625 * t * t) + b;
    }
    else if (t < (2 / 2.75))
    {
        t -= 1.5 / 2.75;
        return c * (7.5625 * t * t + 0.75) + b;
    }
    else if (t < (2 / 2.75))
    {
        t -= 1.5 / 2.75;
        return c * (7.5625 * t * t + 0.9375) + b;
    }
    else
    {
        t -= 2.625 / 2.75;
        return c * (7.5625 * t * t + 0.984375) + b;
    }
}

- (CGFloat)easeOutBounceOffset:(CGFloat)offset
{
    CGFloat b = 0;
    CGFloat c = 1;
    CGFloat d = 1;
    if ((offset /= d) < (1 / 2.75))
    {
        return c * (7.5625 * offset * offset) + b;
    }
    else if (offset < (2 / 2.75))
    {
        offset -= (1.5 / 2.75);
        return c * (7.5625 * offset * offset + 0.75) + b;
    }
    else if (offset < (2.5 / 2.75))
    {
        offset -= (2.25 / 2.75);
        return c * (7.5625 * offset * offset + 0.9375) + b;
    }
    else
    {
        offset -= 2.625 / 2.75;
        return c * (7.5625 * offset * offset + 0.984375) + b;
    }
}

- (CGFloat)easeInOutBounceOffset:(CGFloat)offset
{
    CGFloat b = 0;
    CGFloat c = 1;
    CGFloat d = 1;
    if (offset < d / 2)
    {
        return [self easeBounceOffsetHelper1:offset * 2 b:0 c:c d:d] * 0.5 + b;
    }
    else
    {
        return [self easeBounceOffsetHelper2:offset * 2 - d b:0 c:c d:d] * 0.5 + c * 0.5 + b;
    }
}

- (CGFloat)easeInElasticOffset:(CGFloat)offset
{
    CGFloat b = 0;
    CGFloat c = 1;
    CGFloat d = 1;
    if (offset == 0)
    {
        return b;
    }
    if ((offset /= d) == 1)
    {
        return b + c;
    }
    CGFloat p = d * 0.3;
    CGFloat a = c;
    CGFloat s = p / 4;
    offset -= 1;
    return - (a * (CGFloat)pow(2, 10 * offset) * (CGFloat)sin((offset * d - s) * (2 * (CGFloat)M_PI) / p)) + b;
}

- (CGFloat)easeOutElasticOffset:(CGFloat)offset
{
    CGFloat b = 0;
    CGFloat c = 1;
    CGFloat d = 1;
    if (offset == 0)
    {
        return b;
    }
    if ((offset /= d) == 1)
    {
        return b + c;
    }
    CGFloat p = d * 0.3;
    CGFloat a = c;
    CGFloat s = p / 4;
    return (a * (CGFloat)pow(2, -10 * offset) * (CGFloat)sin((offset * d - s) * (2 * (CGFloat)M_PI) / p) + c + b);
}

- (CGFloat)easeInOutElasticOffset:(CGFloat)offset
{
    CGFloat b = 0;
    CGFloat c = 1;
    CGFloat d = 1;
    if (offset == 0)
    {
        return b;
    }
    if ((offset /= d / 2) == 2)
    {
        return b + c;
    }
    CGFloat p = d * (0.3 * 1.5);
    CGFloat a = c;
    CGFloat s = p / 4;
    if (offset < 1)
    {
        offset -= 1;
        return -0.5 * (a * (CGFloat)pow(2, 10 * offset) * (CGFloat)sin((offset * d - s) * (2 * (CGFloat)M_PI) / p)) + b;
    }
    else
    {
        offset -= 1;
        return a * (CGFloat)pow(2, -10 * offset) * (CGFloat)sin((offset * d - s) * (2 * (CGFloat)M_PI) / p) * 0.5 + c + b;
    }
}

@end
