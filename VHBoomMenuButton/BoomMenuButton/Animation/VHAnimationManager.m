//
//  VHAnimationManager.m
//  VHBoomMenuExample
//
//  Created by Nightonke on 16/7/28.
//  Copyright © 2016 Nightonke. All rights reserved.
//

#import "VHAnimationManager.h"

static CAMediaTimingFunction *showColorAnimationFunction;
static CAMediaTimingFunction *hideColorAnimationFunction;

@implementation VHAnimationManager

# pragma mark - Public Methods

+ (CAKeyframeAnimation *)animateKeyPath:(NSString *)keyPath
                                  delay:(CFTimeInterval)delay
                               duration:(CFTimeInterval)duration
                                 values:(NSArray *)values
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:keyPath];
    animation.beginTime = CACurrentMediaTime() + delay;
    animation.duration = duration;
    animation.values = values;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    return animation;
}

+ (CAKeyframeAnimation *)animateKeyPath:(NSString *)keyPath
                                  delay:(CFTimeInterval)delay
                               duration:(CFTimeInterval)duration
                                   ease:(id<VHTimeInterpolator>)ease
                                 frames:(int)frames
                                  start:(CGFloat)start
                                    end:(CGFloat)end
{
    return [VHAnimationManager animateKeyPath:keyPath
                                        delay:delay
                                     duration:duration
                                       values:[VHAnimationManager values:ease
                                                                  frames:frames
                                                                   start:start
                                                                     end:end]];
}

+ (CABasicAnimation *)boomColorAnimateKeyPath:(NSString *)keyPath
                                        delay:(CFTimeInterval)delay
                                     duration:(CFTimeInterval)duration
                                        start:(UIColor *)start
                                          end:(UIColor *)end
{
    CABasicAnimation *colorAnimation = [CABasicAnimation animationWithKeyPath:keyPath];
    colorAnimation.beginTime = CACurrentMediaTime() + delay;
    colorAnimation.duration = duration;
    colorAnimation.fromValue = (id)[start CGColor];
    colorAnimation.toValue = (id)[end CGColor];
    colorAnimation.removedOnCompletion = NO;
    colorAnimation.fillMode = kCAFillModeForwards;
    colorAnimation.timingFunction = [VHAnimationManager showColorAnimationFunction];
    return colorAnimation;
}

+ (CABasicAnimation *)reboomColorAnimateKeyPath:(NSString *)keyPath
                                          delay:(CFTimeInterval)delay
                                       duration:(CFTimeInterval)duration
                                          start:(UIColor *)start
                                            end:(UIColor *)end
{
    CABasicAnimation *colorAnimation = [CABasicAnimation animationWithKeyPath:keyPath];
    colorAnimation.beginTime = CACurrentMediaTime() + delay;
    colorAnimation.duration = duration;
    colorAnimation.fromValue = (id)[start CGColor];
    colorAnimation.toValue = (id)[end CGColor];
    colorAnimation.removedOnCompletion = NO;
    colorAnimation.fillMode = kCAFillModeForwards;
    colorAnimation.timingFunction = [VHAnimationManager hideColorAnimationFunction];
    return colorAnimation;
}

+ (CAAnimation *)fadeViewsOpacityAnimation:(BOOL)isBooming duration:(CFTimeInterval)duration
{
    CAKeyframeAnimation *opacityAnimation = [VHAnimationManager animateKeyPath:@"opacity"
                                                                         delay:0
                                                                      duration:duration
                                                                        values:isBooming ? @[@(1), @(0)] : @[@(0), @(1)]];
    opacityAnimation.timingFunction = isBooming ? [VHAnimationManager showColorAnimationFunction] : [VHAnimationManager hideColorAnimationFunction];
    return opacityAnimation;
}

+ (void)addAnimations:(UIView *)view forKey:(NSString *)key, ... NS_REQUIRES_NIL_TERMINATION
{
    if (view)
    {
        va_list animations;
        CAAnimation *animation;
        va_start(animations, key);
        int i = 0;
        while ((animation = va_arg(animations, CAAnimation *)))
        {
            [view.layer addAnimation:animation forKey:[NSString stringWithFormat:@"%@_%d", key, i]];
            i++;
        }
    }
}

+ (void)addAnimation:(CAAnimation *)animation forKey:(NSString *)key toViews:(NSArray<UIView *> *)views
{
    for (UIView *view in views)
    {
        [view.layer addAnimation:animation forKey:key];
    }
}

+ (void)calculateBoomXY:(VHBoomEnum)boomEnum
             parentSize:(CGSize)parentSize
                   ease:(id<VHTimeInterpolator>)ease
                 frames:(int)frames
          startPosition:(CGPoint)startPosition
            endPosition:(CGPoint)endPosition
                xValues:(NSMutableArray *)xs
                yValues:(NSMutableArray *)ys
{
    if (startPosition.x == endPosition.x)
    {
        boomEnum = VHBoomStraightLine;
    }
    
    CGFloat x1      = startPosition.x;
    CGFloat y1      = startPosition.y;
    CGFloat x2      = endPosition.x;
    CGFloat y2      = endPosition.y;
    CGFloat p       = 1.0f / frames;
    CGFloat xOffset = x2 - x1;
    CGFloat yOffset = y2 - y1;
    CGFloat offset  = 0;
    CGFloat x, y, x3, y3, a, b, c, offsetInFact;
    
    switch (boomEnum)
    {
        case VHBoomStraightLine:
        {
            for (int i = 0; i <= frames; i++, offset += p)
            {
                offsetInFact = [ease interpolation:offset];
                [xs addObject:@(x1 + offsetInFact * xOffset)];
                [ys addObject:@(y1 + offsetInFact * yOffset)];
            }
            break;
        }
        case VHBoomParabola1:
        {
            x3 = (x1 + x2) / 2;
            y3 = MIN(y1, y2) * 3 / 4;
            a  = (y1 * (x2 - x3) + y2 * (x3 - x1) + y3 * (x1 - x2)) / (x1 * x1 * (x2 - x3) + x2 * x2 * (x3 - x1) + x3 * x3 * (x1 - x2));
            b  = (y1 - y2) / (x1 - x2) - a * (x1 + x2);
            c  = y1 - (x1 * x1) * a - x1 * b;
            for (int i = 0; i <= frames; i++, offset += p)
            {
                x = x1 + [ease interpolation:offset] * xOffset;
                [xs addObject:@(x)];
                [ys addObject:@(a * x * x + b * x + c)];
            }
            break;
        }
        case VHBoomParabola2:
        {
            x3 = (x1 + x2) / 2;
            y3 = (parentSize.height + MAX(y1, y2)) / 2;
            a  = (y1 * (x2 - x3) + y2 * (x3 - x1) + y3 * (x1 - x2)) / (x1 * x1 * (x2 - x3) + x2 * x2 * (x3 - x1) + x3 * x3 * (x1 - x2));
            b  = (y1 - y2) / (x1 - x2) - a * (x1 + x2);
            c  = y1 - (x1 * x1) * a - x1 * b;
            for (int i = 0; i <= frames; i++, offset += p)
            {
                x = x1 + [ease interpolation:offset] * xOffset;
                [xs addObject:@(x)];
                [ys addObject:@(a * x * x + b * x + c)];
            }
            break;
        }
        case VHBoomParabola3:
        {
            y3 = (y1 + y2) / 2;
            x3 = MIN(x1, x2) / 2;
            a  = (x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2)) / (y1 * y1 * (y2 - y3) + y2 * y2 * (y3 - y1) + y3 * y3 * (y1 - y2));
            b  = (x1 - x2) / (y1 - y2) - a * (y1 + y2);
            c  = x1 - (y1 * y1) * a - y1 * b;
            for (int i = 0; i <= frames; i++, offset += p)
            {
                y = y1 + [ease interpolation:offset] * yOffset;
                [ys addObject:@(y)];
                [xs addObject:@(a * y * y + b * y + c)];
            }
            break;
        }
        case VHBoomParabola4:
        {
            y3 = (y1 + y2) / 2;
            x3 = (parentSize.width + MAX(x1, x2)) / 2;
            a  = (x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2)) / (y1 * y1 * (y2 - y3) + y2 * y2 * (y3 - y1) + y3 * y3 * (y1 - y2));
            b  = (x1 - x2) / (y1 - y2) - a * (y1 + y2);
            c  = x1 - (y1 * y1) * a - y1 * b;
            for (int i = 0; i <= frames; i++, offset += p)
            {
                y = y1 + [ease interpolation:offset] * yOffset;
                [ys addObject:@(y)];
                [xs addObject:@(a * y * y + b * y + c)];
            }
            break;
        }
        case VHBoomHorizontalThrow1:
        {
            x3 = x2 * 2 - x1;
            y3 = y1;
            a  = (y1 * (x3 - x2) + y3 * (x2 - x1) + y2 * (x1 - x3)) / (x1 * x1 * (x3 - x2) + x3 * x3 * (x2 - x1) + x2 * x2 * (x1 - x3));
            b  = (y1 - y3) / (x1 - x3) - a * (x1 + x3);
            c  = y1 - (x1 * x1) * a - x1 * b;
            for (int i = 0; i <= frames; i++, offset += p)
            {
                x = x1 + [ease interpolation:offset] * xOffset;
                [xs addObject:@(x)];
                [ys addObject:@(a * x * x + b * x + c)];
            }
            break;
        }
        case VHBoomHorizontalThrow2:
        {
            x2 = startPosition.x;
            y2 = startPosition.y;
            x1 = endPosition.x;
            y1 = endPosition.y;
            x3 = x2 * 2 - x1;
            y3 = y1;
            a  = (y1 * (x3 - x2) + y3 * (x2 - x1) + y2 * (x1 - x3)) / (x1 * x1 * (x3 - x2) + x3 * x3 * (x2 - x1) + x2 * x2 * (x1 - x3));
            b  = (y1 - y3) / (x1 - x3) - a * (x1 + x3);
            c  = y1 - (x1 * x1) * a - x1 * b;
            for (int i = 0; i <= frames; i++, offset += p)
            {
                x = x2 + [ease interpolation:offset] * xOffset;
                [xs addObject:@(x)];
                [ys addObject:@(a * x * x + b * x + c)];
            }
            break;
        }
        case VHBoomRandom:
        {
            int r = arc4random() % VHBoomRandom;
            [self calculateBoomXY:r parentSize:parentSize ease:ease frames:frames startPosition:startPosition endPosition:endPosition xValues:xs yValues:ys];
            break;
        }
        case VHBoomEnumCount:
            break;
    }
}

+ (void)calculateReboomXY:(VHBoomEnum)boomEnum
               parentSize:(CGSize)parentSize
                     ease:(id<VHTimeInterpolator>)ease
                   frames:(int)frames
            startPosition:(CGPoint)startPosition
              endPosition:(CGPoint)endPosition
                  xValues:(NSMutableArray *)xs
                  yValues:(NSMutableArray *)ys
{
    if (startPosition.x == endPosition.x)
    {
        boomEnum = VHBoomStraightLine;
    }
    
    CGFloat x1      = startPosition.x;
    CGFloat y1      = startPosition.y;
    CGFloat x2      = endPosition.x;
    CGFloat y2      = endPosition.y;
    CGFloat p       = 1.0f / frames;
    CGFloat xOffset = x2 - x1;
    CGFloat offset  = 0;
    CGFloat x, x3, y3, a, b, c;
    
    switch (boomEnum)
    {
        case VHBoomStraightLine:
        case VHBoomParabola1:
        case VHBoomParabola2:
        case VHBoomParabola3:
        case VHBoomParabola4:
        case VHBoomRandom:
        {
            [self calculateBoomXY:boomEnum parentSize:parentSize ease:ease frames:frames startPosition:startPosition endPosition:endPosition xValues:xs yValues:ys];
            break;
        }
        case VHBoomHorizontalThrow1:
        {
            x2 = startPosition.x;
            y2 = startPosition.y;
            x1 = endPosition.x;
            y1 = endPosition.y;
            x3 = x2 * 2 - x1;
            y3 = y1;
            a  = (y1 * (x3 - x2) + y3 * (x2 - x1) + y2 * (x1 - x3)) / (x1 * x1 * (x3 - x2) + x3 * x3 * (x2 - x1) + x2 * x2 * (x1 - x3));
            b  = (y1 - y3) / (x1 - x3) - a * (x1 + x3);
            c  = y1 - (x1 * x1) * a - x1 * b;
            for (int i = 0; i <= frames; i++, offset += p)
            {
                x = x2 + [ease interpolation:offset] * xOffset;
                [xs addObject:@(x)];
                [ys addObject:@(a * x * x + b * x + c)];
            }
            break;
        }
        case VHBoomHorizontalThrow2:
        {
            x3 = x2 * 2 - x1;
            y3 = y1;
            a  = (y1 * (x3 - x2) + y3 * (x2 - x1) + y2 * (x1 - x3)) / (x1 * x1 * (x3 - x2) + x3 * x3 * (x2 - x1) + x2 * x2 * (x1 - x3));
            b  = (y1 - y3) / (x1 - x3) - a * (x1 + x3);
            c  = y1 - (x1 * x1) * a - x1 * b;
            for (int i = 0; i <= frames; i++, offset += p)
            {
                x = x1 + [ease interpolation:offset] * xOffset;
                [xs addObject:@(x)];
                [ys addObject:@(a * x * x + b * x + c)];
            }
            break;
        }
        case VHBoomEnumCount:
            break;
    }
}

+ (NSMutableArray<NSNumber *> *)orderIndexes:(VHOrderEnum)orderEnum inSize:(NSUInteger)size
{
    NSMutableArray<NSNumber *> *indexes = [NSMutableArray arrayWithCapacity:size];
    
    switch (orderEnum)
    {
        case VHOrderInOrder:
            for (int i = 0; i < size; i++)
            {
                [indexes addObject:[NSNumber numberWithInteger:i]];
            }
            break;
        case VHOrderReverse:
            for (int i = 0; i < size; i++)
            {
                [indexes addObject:[NSNumber numberWithInteger:size - i - 1]];
            }
            break;
        case VHOrderRandom:
        {
            BOOL used[size];
            for (int i = 0; i < size; i++)
            {
                used[i] = NO;
            }
            int count = 0;
            while (count < size)
            {
                int r = arc4random() % size;
                if (used[r] == NO)
                {
                    used[r] = YES;
                    [indexes addObject:[NSNumber numberWithInteger:r]];
                    count++;
                }
            }
            break;
        }
    }
    return indexes;
}

+ (NSMutableArray<NSNumber *> *)values:(id<VHTimeInterpolator>)ease
                                frames:(int)frames
                                 start:(float)start
                                   end:(float)end
{
    NSMutableArray<NSNumber *> *values = [NSMutableArray arrayWithCapacity:frames + 1];
    CGFloat p = 1.0f / frames;
    CGFloat totalOffset = end - start;
    CGFloat offset = 0;
    for (int i = 0; i <= frames; i++)
    {
        CGFloat offsetInFact = [ease interpolation:offset];
        [values addObject:[NSNumber numberWithFloat:start + offsetInFact * totalOffset]];
        offset += p;
    }
    return values;
}

+ (CAKeyframeAnimation *)rotateXAnimationFromFrames:(int)frames startY:(CGFloat)startY endY:(CGFloat)endY delay:(CFTimeInterval)delay duration:(CFTimeInterval)duration
{
    NSMutableArray<NSNumber *> *values = [VHAnimationManager values:[VHEase easeWithName:VHEaseInOutCubic] frames:frames start:startY end:endY];
    NSMutableArray *rotateXs = [NSMutableArray arrayWithCapacity:frames];
    __block CGFloat previousY = startY;
    CGFloat maxDegree = M_PI_4;
    [values enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx != 0)
        {
            CGFloat velocity = [obj floatValue] - previousY;
            [rotateXs addObject:@([VHAnimationManager clamp:-velocity / 12 between:-maxDegree and:maxDegree])];
        }
        previousY = [obj floatValue];
    }];
    [VHAnimationManager addBufferValues:rotateXs];
    return [VHAnimationManager animateKeyPath:@"transform.rotation.x" delay:delay duration:duration values:rotateXs];
}

+ (CAKeyframeAnimation *)rotateYAnimationFromFrames:(int)frames startX:(CGFloat)startX endX:(CGFloat)endX delay:(CFTimeInterval)delay duration:(CFTimeInterval)duration
{
    NSMutableArray<NSNumber *> *values = [VHAnimationManager values:[VHEase easeWithName:VHEaseInOutCubic] frames:frames start:startX end:endX];
    NSMutableArray *rotateYs = [NSMutableArray arrayWithCapacity:frames];
    __block CGFloat previousX = startX;
    CGFloat maxDegree = M_PI_4;
    [values enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx != 0)
        {
            CGFloat velocity = [obj floatValue] - previousX;
            [rotateYs addObject:@([VHAnimationManager clamp:velocity / 12 between:-maxDegree and:maxDegree])];
        }
        previousX = [obj floatValue];
    }];
    [VHAnimationManager addBufferValues:rotateYs];
    return [VHAnimationManager animateKeyPath:@"transform.rotation.y" delay:delay duration:duration values:rotateYs];
}

+ (CAKeyframeAnimation *)rotateXAnimationFromVelocity:(NSMutableArray *)ys delay:(CFTimeInterval)delay duration:(CFTimeInterval)duration
{
    NSMutableArray *rotateXs = [NSMutableArray arrayWithCapacity:ys.count];
    __block CGFloat previousY = 0;
    CGFloat maxRotate = M_PI_4;
    [ys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx != 0)
        {
            CGFloat velocity = [obj floatValue] - previousY;
            [rotateXs addObject:@([VHAnimationManager clamp:velocity / 12 between:-maxRotate and:maxRotate])];
        }
        previousY = [obj floatValue];
    }];
    [VHAnimationManager addBufferValues:rotateXs];
    return [VHAnimationManager animateKeyPath:@"transform.rotation.x" delay:delay duration:duration values:rotateXs];
}

+ (CAKeyframeAnimation *)rotateYAnimationFromVelocity:(NSMutableArray *)xs delay:(CFTimeInterval)delay duration:(CFTimeInterval)duration
{
    NSMutableArray *rotateYs = [NSMutableArray arrayWithCapacity:xs.count];
    __block CGFloat previousX = 0;
    CGFloat maxRotate = M_PI_4;
    [xs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx != 0)
        {
            CGFloat velocity = [obj floatValue] - previousX;
            [rotateYs addObject:@([VHAnimationManager clamp:-velocity / 12 between:-maxRotate and:maxRotate])];
//            [rotateYs addObject:@(maxRotate)];
        }
        previousX = [obj floatValue];
    }];
    [VHAnimationManager addBufferValues:rotateYs];
    return [VHAnimationManager animateKeyPath:@"transform.rotation.y" delay:delay duration:duration values:rotateYs];
}

# pragma mark - Private Methods

+ (CAMediaTimingFunction *)showColorAnimationFunction
{
    if (!showColorAnimationFunction)
    {
        showColorAnimationFunction = [CAMediaTimingFunction functionWithControlPoints:0.78 :1.04 :0.12 :0.99];
    }
    return showColorAnimationFunction;
}

+ (CAMediaTimingFunction *)hideColorAnimationFunction
{
    if (!hideColorAnimationFunction)
    {
        hideColorAnimationFunction = [CAMediaTimingFunction functionWithControlPoints:1 :0 :0.32 :0];
    }
    return hideColorAnimationFunction;
}

+ (CGFloat)clamp:(CGFloat)v between:(CGFloat)min and:(CGFloat)max
{
    return v < min ? min : (v > max ? max : v);
}

+ (void)addBufferValues:(NSMutableArray<NSNumber *> *)values
{
    if ([[values lastObject] floatValue] == 0)
    {
        return;
    }
    [values addObject:@([[values lastObject] floatValue] * 0.5)];
    [values addObject:@([[values lastObject] floatValue] * 0.5)];
    [values addObject:@([[values lastObject] floatValue] * 0.5)];
    [values addObject:@(0)];
}

@end
