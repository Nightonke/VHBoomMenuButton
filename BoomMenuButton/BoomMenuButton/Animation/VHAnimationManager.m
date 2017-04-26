//
//  VHAnimationManager.m
//  VHBoomMenuExample
//
//  Created by Nightonke on 16/7/28.
//  Copyright © 2016年 Nightonke. All rights reserved.
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
                                   ease:(VHEase *)ease
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

+ (CABasicAnimation *)showColorAnimateKeyPath:(NSString *)keyPath
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

+ (CABasicAnimation *)hideColorAnimateKeyPath:(NSString *)keyPath
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

+ (void)addAnimations:(UIView *)view, ... NS_REQUIRES_NIL_TERMINATION
{
    if (view)
    {
        va_list animations;
        CAAnimation *animation;
        va_start(animations, view);
        while ((animation = va_arg(animations, CAAnimation *)))
        {
            [view.layer addAnimation:animation forKey:nil];
        }
    }
}

+ (void)addAnimation:(CAAnimation *)animation toViews:(NSArray<UIView *> *)views
{
    for (UIView *view in views)
    {
        [view.layer addAnimation:animation forKey:nil];
    }
}

+ (void)calculateShowXY:(VHBoomEnum)boomEnum
             parentSize:(CGSize)parentSize
                   ease:(VHEase *)ease
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
        case VHBoomParabola_1:
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
        case VHBoomParabola_2:
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
        case VHBoomParabola_3:
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
        case VHBoomParabola_4:
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
        case VHBoomHorizontalThrow_1:
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
        case VHBoomHorizontalThrow_2:
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
            [self calculateShowXY:r parentSize:parentSize ease:ease frames:frames startPosition:startPosition endPosition:endPosition xValues:xs yValues:ys];
            break;
        }
        case VHBoomEnumCount:
            break;
    }
}

+ (void)calculateHideXY:(VHBoomEnum)boomEnum
             parentSize:(CGSize)parentSize
                   ease:(VHEase *)ease
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
        case VHBoomParabola_1:
        case VHBoomParabola_2:
        case VHBoomParabola_3:
        case VHBoomParabola_4:
        case VHBoomRandom:
        {
            [self calculateShowXY:boomEnum parentSize:parentSize ease:ease frames:frames startPosition:startPosition endPosition:endPosition xValues:xs yValues:ys];
            break;
        }
        case VHBoomHorizontalThrow_1:
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
        case VHBoomHorizontalThrow_2:
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
    NSMutableArray<NSNumber *> *indexs = [NSMutableArray arrayWithCapacity:size];
    
    switch (orderEnum)
    {
        case VHOrderDefault:
            for (int i = 0; i < size; i++)
            {
                [indexs addObject:[NSNumber numberWithInteger:i]];
            }
            break;
        case VHOrderReverse:
            for (int i = 0; i < size; i++)
            {
                [indexs addObject:[NSNumber numberWithInteger:size - i - 1]];
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
                    [indexs addObject:[NSNumber numberWithInteger:r]];
                    count++;
                }
            }
        }
            break;
    }
    return indexs;
}

+ (NSMutableArray<NSNumber *> *)values:(VHEase *)ease
                                frames:(int)frames
                                 start:(float)start
                                   end:(float)end
{
    NSMutableArray<NSNumber *> *values = [NSMutableArray arrayWithCapacity:frames + 1];
    CGFloat p                          = 1.0f / frames;
    CGFloat scaleOffset                = end - start;
    for (int i = 0; i <= frames; i++)
    {
        CGFloat offset       = i * p;
        CGFloat offsetInFact = [ease interpolation:offset];
        [values addObject:[NSNumber numberWithFloat:start + offsetInFact * scaleOffset]];
    }
    return values;
}

+ (NSMutableArray<NSNumber *> *)calculateScale:(VHEase *)ease
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
        CGFloat offsetInFact = [ease interpolation:offset];
        [values addObject:[NSNumber numberWithFloat:startScale + offsetInFact * scaleOffset]];
    }
    return values;
}

- (NSMutableArray<NSNumber *> *)calculateRotate:(VHEase *)ease
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
        CGFloat offsetInFact = [ease interpolation:offset];
        [values addObject:[NSNumber numberWithFloat:startRotate + offsetInFact * scaleOffset]];
    }
    return values;
}

- (void)calculateXYInSameX:(VHBoomEnum)boomEnum
                      ease:(VHEase *)ease
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
        CGFloat offsetInFact = [ease interpolation:offset];
        [xs setObject:[NSNumber numberWithFloat:x1 + offsetInFact * xOffset] atIndexedSubscript:i];
        [ys setObject:[NSNumber numberWithFloat:y1 + offsetInFact * yOffset] atIndexedSubscript:i];
    }
}

+ (CAKeyframeAnimation *)rotateXAnimationFromFrames:(int)frames startY:(CGFloat)startY endY:(CGFloat)endY delay:(CFTimeInterval)delay duration:(CFTimeInterval)duration
{
    NSMutableArray<NSNumber *> *values = [VHAnimationManager values:[VHEase easeWithName:VHEaseInOutCubic] frames:frames start:startY end:endY];
    NSMutableArray *rotateXs = [NSMutableArray arrayWithCapacity:frames];
    __block CGFloat previousY = startY;
    CGFloat maxRotate = M_PI_4;
    [values enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx != 0)
        {
            CGFloat velocity = [obj floatValue] - previousY;
            [rotateXs addObject:@([VHAnimationManager clamp:-velocity / 12 between:-maxRotate and:maxRotate])];
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
    CGFloat maxRotate = M_PI_4;
    [values enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx != 0)
        {
            CGFloat velocity = [obj floatValue] - previousX;
            [rotateYs addObject:@([VHAnimationManager clamp:velocity / 12 between:-maxRotate and:maxRotate])];
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
