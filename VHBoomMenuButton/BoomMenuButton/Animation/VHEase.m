//
//  VHEase.m
//  VHMediaTimingFunction
//
//  Created by Nightonke on 16/7/22.
//  Copyright © 2016 Nightonke. All rights reserved.
//

#import "VHEase.h"

NSString *const VHEaseLinear = @"VHEaseLinear";

NSString *const VHEaseInSine = @"VHEaseInSine";
NSString *const VHEaseOutSine = @"VHEaseOutSine";
NSString *const VHEaseInOutSine = @"VHEaseInOutSine";

NSString *const VHEaseInQuad = @"VHEaseInQuad";
NSString *const VHEaseOutQuad = @"VHEaseOutQuad";
NSString *const VHEaseInOutQuad = @"VHEaseInOutQuad";

NSString *const VHEaseInCubic = @"VHEaseInCubic";
NSString *const VHEaseOutCubic = @"VHEaseOutCubic";
NSString *const VHEaseInOutCubic = @"VHEaseInOutCubic";

NSString *const VHEaseInQuart = @"VHEaseInQuart";
NSString *const VHEaseOutQuart = @"VHEaseOutQuart";
NSString *const VHEaseInOutQuart = @"VHEaseInOutQuart";

NSString *const VHEaseInQuint = @"VHEaseInQuint";
NSString *const VHEaseOutQuint = @"VHEaseOutQuint";
NSString *const VHEaseInOutQuint = @"VHEaseInOutQuint";

NSString *const VHEaseInCirc = @"VHEaseInCirc";
NSString *const VHEaseOutCirc = @"VHEaseOutCirc";
NSString *const VHEaseInOutCirc = @"VHEaseInOutCirc";

NSString *const VHEaseInExpo = @"VHEaseInExpo";
NSString *const VHEaseOutExpo = @"VHEaseOutExpo";
NSString *const VHEaseInOutExpo = @"VHEaseInOutExpo";

NSString *const VHEaseInBack = @"VHEaseInBack";
NSString *const VHEaseOutBack = @"VHEaseOutBack";
NSString *const VHEaseInOutBack = @"VHEaseInOutBack";

NSString *const VHEaseInElastic = @"VHEaseInElastic";
NSString *const VHEaseOutElastic = @"VHEaseOutElastic";
NSString *const VHEaseInOutElastic = @"VHEaseInOutElastic";

NSString *const VHEaseInBounce = @"VHEaseInBounce";
NSString *const VHEaseOutBounce = @"VHEaseOutBounce";
NSString *const VHEaseInOutBounce = @"VHEaseInOutBounce";

static NSMutableDictionary<NSString *, VHEase *> *eases;

@interface VHEase ()

@property (nonatomic, assign) CGPoint start;
@property (nonatomic, assign) CGPoint end;
@property (nonatomic, assign) CGPoint a;
@property (nonatomic, assign) CGPoint b;
@property (nonatomic, assign) CGPoint c;
@property (nonatomic, assign) BOOL ableToDefineWithControlPoints;
@property (nonatomic, strong) NSString *name;

@end

@implementation VHEase

#pragma mark - Public Methods

+ (instancetype)easeWithName:(NSString *)name
{
    if (!eases) eases = [NSMutableDictionary dictionary];
    VHEase *ease = [eases objectForKey:name];
    if (!ease)
    {
        ease = [VHEase innerEaseWithName:name];
        [eases setObject:ease forKey:name];
    }
    return ease;
}

#pragma mark - Private Methods

+ (instancetype)innerEaseWithName:(NSString *)name
{
    if ([name isEqualToString:VHEaseLinear])
    {
        return [[VHEase alloc] initWithStartX:0.000 startY:0.000 endX:1.000 endY:1.000];
    }
    else if ([name isEqualToString:VHEaseInSine])
    {
        return [[VHEase alloc] initWithStartX:0.470 startY:0.000 endX:0.745 endY:0.715];
    }
    else if ([name isEqualToString:VHEaseOutSine])
    {
        return [[VHEase alloc] initWithStartX:0.390 startY:0.575 endX:0.565 endY:1.000];
    }
    else if ([name isEqualToString:VHEaseInOutSine])
    {
        return [[VHEase alloc] initWithStartX:0.445 startY:0.050 endX:0.550 endY:0.950];
    }
    else if ([name isEqualToString:VHEaseInQuad])
    {
        return [[VHEase alloc] initWithStartX:0.550 startY:0.085 endX:0.680 endY:0.530];
    }
    else if ([name isEqualToString:VHEaseOutQuad])
    {
        return [[VHEase alloc] initWithStartX:0.165 startY:0.840 endX:0.440 endY:1.000];
    }
    else if ([name isEqualToString:VHEaseInOutQuad])
    {
        return [[VHEase alloc] initWithStartX:0.455 startY:0.030 endX:0.515 endY:0.955];
    }
    else if ([name isEqualToString:VHEaseInCubic])
    {
        return [[VHEase alloc] initWithStartX:0.550 startY:0.055 endX:0.675 endY:0.190];
    }
    else if ([name isEqualToString:VHEaseOutCubic])
    {
        return [[VHEase alloc] initWithStartX:0.215 startY:0.610 endX:0.355 endY:1.000];
    }
    else if ([name isEqualToString:VHEaseInOutCubic])
    {
        return [[VHEase alloc] initWithStartX:0.645 startY:0.045 endX:0.335 endY:1.000];
    }
    else if ([name isEqualToString:VHEaseInQuart])
    {
        return [[VHEase alloc] initWithStartX:0.895 startY:0.030 endX:0.685 endY:0.220];
    }
    else if ([name isEqualToString:VHEaseOutQuart])
    {
        return [[VHEase alloc] initWithStartX:0.165 startY:0.840 endX:0.440 endY:1.000];
    }
    else if ([name isEqualToString:VHEaseInOutQuart])
    {
        return [[VHEase alloc] initWithStartX:0.770 startY:0.000 endX:0.175 endY:1.000];
    }
    else if ([name isEqualToString:VHEaseInQuint])
    {
        return [[VHEase alloc] initWithStartX:0.755 startY:0.050 endX:0.855 endY:0.060];
    }
    else if ([name isEqualToString:VHEaseOutQuint])
    {
        return [[VHEase alloc] initWithStartX:0.230 startY:1.000 endX:0.320 endY:1.000];
    }
    else if ([name isEqualToString:VHEaseInOutQuint])
    {
        return [[VHEase alloc] initWithStartX:0.860 startY:0.000 endX:0.070 endY:1.000];
    }
    else if ([name isEqualToString:VHEaseInCirc])
    {
        return [[VHEase alloc] initWithStartX:0.600 startY:0.040 endX:0.980 endY:0.335];
    }
    else if ([name isEqualToString:VHEaseOutCirc])
    {
        return [[VHEase alloc] initWithStartX:0.075 startY:0.820 endX:0.165 endY:1.000];
    }
    else if ([name isEqualToString:VHEaseInOutCirc])
    {
        return [[VHEase alloc] initWithStartX:0.785 startY:0.135 endX:0.150 endY:0.860];
    }
    else if ([name isEqualToString:VHEaseInExpo])
    {
        return [[VHEase alloc] initWithStartX:0.950 startY:0.050 endX:0.795 endY:0.035];
    }
    else if ([name isEqualToString:VHEaseOutExpo])
    {
        return [[VHEase alloc] initWithStartX:0.190 startY:1.000 endX:0.220 endY:1.000];
    }
    else if ([name isEqualToString:VHEaseInOutExpo])
    {
        return [[VHEase alloc] initWithStartX:1.000 startY:0.000 endX:0.000 endY:1.000];
    }
    else if ([name isEqualToString:VHEaseInBack])
    {
        return [[VHEase alloc] initWithStartX:0.600 startY:-0.20 endX:0.735 endY:0.045];
    }
    else if ([name isEqualToString:VHEaseOutBack])
    {
        return [[VHEase alloc] initWithStartX:0.174 startY:0.885 endX:0.320 endY:1.275];
    }
    else if ([name isEqualToString:VHEaseInOutBack])
    {
        return [[VHEase alloc] initWithStartX:0.680 startY:-0.55 endX:0.265 endY:1.550];
    }
    else return [[VHEase alloc] initWithName:name];
}

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

- (instancetype)initWithName:(NSString *)name
{
    self.ableToDefineWithControlPoints = NO;
    self.name = name;
    return self;
}

- (CGFloat)interpolation:(CGFloat)offset
{
    if (self.ableToDefineWithControlPoints)
    {
        return [self getBezierCoordinateY:offset];
    }
    else
    {
        if ([self.name isEqualToString:VHEaseInElastic])
        {
            return [self easeInElasticOffset:offset];
        }
        else if ([self.name isEqualToString:VHEaseInBounce])
        {
            return [self easeInBounceOffset:offset];
        }
        else if ([self.name isEqualToString:VHEaseOutElastic])
        {
            return [self easeOutElasticOffset:offset];
        }
        else if ([self.name isEqualToString:VHEaseOutBounce])
        {
            return [self easeOutBounceOffset:offset];
        }
        else if ([self.name isEqualToString:VHEaseInOutElastic])
        {
            return [self easeInOutElasticOffset:offset];
        }
        else if ([self.name isEqualToString:VHEaseInOutBounce])
        {
            return [self easeInOutBounceOffset:offset];
        }
        else
        {
            NSAssert(NO, @"Unknown ease name");
            return offset;
        }
    }
}

- (CGFloat)getBezierCoordinateY:(CGFloat)time
{
    if (self.start.x == 0 && self.start.y == 0 && self.end.x == 1 && self.end.y == 1)
    {
        return time;
    }
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
