//
//  VHBackgroundView.m
//  VHBoomMenuExample
//
//  Created by Nightonke on 16/7/31.
//  Copyright © 2016年 Nightonke. All rights reserved.
//

#import "VHBackgroundView.h"
#import "VHAnimationManager.h"

@interface VHBackgroundView ()

@property (nonatomic, strong) UIVisualEffectView *visualEffectView NS_AVAILABLE_IOS(8_0);

@end

@implementation VHBackgroundView

#pragma mark - In-BMB-Only Methods

- (void)dim:(CFTimeInterval)duration
 completion:(void (^ __nullable)(BOOL finished))completion
{
    self.hidden = NO;
    if (self.blurBackground && [UIVisualEffectView class])
    {
        self.visualEffectView.effect = nil;
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.visualEffectView.effect = self.blurEffect;
        } completion:completion];
    }
    else
    {
        self.backgroundColor = [UIColor clearColor];
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.backgroundColor = self.dimColor;
        } completion:completion];
    }
    
    CAKeyframeAnimation *opacityAnimation = [VHAnimationManager animateKeyPath:@"opacity"
                                                                         delay:0
                                                                      duration:duration
                                                                        values:@[@(0), @(1)]];
    [VHAnimationManager addAnimation:opacityAnimation toViews:self.goneViews];
}

- (void)light:(CFTimeInterval)duration
   completion:(void (^ __nullable)(BOOL finished))completion
{
    if (self.blurBackground && [UIVisualEffectView class])
    {
        self.visualEffectView.effect = self.blurEffect;
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.visualEffectView.effect = nil;
        } completion:completion];
    }
    else
    {
        self.backgroundColor = self.dimColor;
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.backgroundColor = [UIColor clearColor];
        } completion:completion];
    }
    
    CAKeyframeAnimation *opacityAnimation = [VHAnimationManager animateKeyPath:@"opacity"
                                                                         delay:0
                                                                      duration:duration
                                                                        values:@[@(1), @(0)]];
    [VHAnimationManager addAnimation:opacityAnimation toViews:self.goneViews];
}

- (void)removeAllSubViews
{
    if ([UIVisualEffectView class])
    {
        for (UIView *view in self.subviews)
        {
            if (view != self.visualEffectView)
            {
                [view removeFromSuperview];
            }
        }
    }
    else
    {
        for (UIView *view in self.subviews)
        {
            [view removeFromSuperview];
        }
    }
}

- (void)setBlurBackground:(BOOL)blurBackground
{
    _blurBackground = blurBackground;
    if ([UIVisualEffectView class])
    {
        if (blurBackground)
        {
            if (!self.visualEffectView)
            {
                self.visualEffectView = [[UIVisualEffectView alloc] initWithEffect:nil];
                self.visualEffectView.frame = self.bounds;
                [self addSubview:self.visualEffectView];
            }
        }
        else
        {
            [self.visualEffectView removeFromSuperview];
            self.visualEffectView = nil;
        }
    }
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    if ([UIVisualEffectView class])
    {
        self.visualEffectView.frame = self.bounds;
    }
}

#pragma mark - Private Methods

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([self.delegate respondsToSelector:@selector(onBackgroundClick)])
    {
        [self.delegate onBackgroundClick];
    }
}

- (NSArray<UIView *> *)goneViews
{
    NSMutableArray<UIView *> *goneViews = [self.subviews mutableCopy];
    if ([UIVisualEffectView class])
    {
        [goneViews removeObject:self.visualEffectView];
    }
    return goneViews;
}

@end
