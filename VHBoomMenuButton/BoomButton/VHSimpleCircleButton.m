//
//  VHSimpleCicleButton.m
//  VHBoomMenuExample
//
//  Created by 黄伟平 on 16/7/28.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import "VHSimpleCircleButton.h"

@implementation VHSimpleCircleButton

- (instancetype)initWithImage:(NSString *)imageNormal
                 pressedImage:(NSString *)imagePressed
                  normalColor:(UIColor *)normalColor
                 pressedColor:(UIColor *)pressedColor
         imageNormalTintColor:(UIColor *)imageNormalTintColor
        imagePressedTintColor:(UIColor *)imagePressedTintColor
                 buttonRadius:(CGFloat)buttonRadius
                 shadowRadius:(CGFloat)shadowRadius
                 shadowOffset:(CGSize) shadowOffset
                shadowOpacity:(CGFloat)shadowOpacity
                  shadowColor:(UIColor *)shadowColor
                 withDelegate:(id<VHButtonClickDelegate>) delegate
                           at:(int)index
{
    CGRect frame = CGRectMake(0, 0, buttonRadius * 2, buttonRadius * 2);
    if (self = [super initWithFrame:frame])
    {
        self.imageNormal            = imageNormal;
        self.imagePressed           = imagePressed;
        self.buttonNormalColor      = normalColor;
        self.buttonPressedColor     = pressedColor;
        self.imageNormalTintColor   = imageNormalTintColor;
        self.imagePressedTintColor  = imagePressedTintColor;
        self.buttonRadius           = buttonRadius;
        self.shadowRadius           = shadowRadius;
        self.shadowOffset           = shadowOffset;
        self.shadowOpacity          = shadowOpacity;
        self.shadowColor            = shadowColor;
        self.delegate               = delegate;
        self.index                  = index;

        self.buttonCircle           = [CAShapeLayer layer];
        [self.buttonCircle setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0,
                                                                                      0,
                                                                                      frame.size.width,
                                                                                      frame.size.height)] CGPath]];
        [self.buttonCircle setFillColor:self.buttonNormalColor.CGColor];
        [[self layer] addSublayer:self.buttonCircle];

        UIImage *imageContent       = [UIImage imageNamed:self.imageNormal];
        if (self.imageNormalTintColor != nil && self.imagePressedTintColor != nil)
        {
            imageContent            = [imageContent imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        }
        self.image                  = [[UIImageView alloc] initWithImage:imageContent];
        self.image.frame            = frame;
        if (self.imagePressedTintColor != nil)
        {
            [self.image setTintColor:self.imagePressedTintColor];
        }
        [self addSubview:self.image];

        self.backgroundColor        = [UIColor clearColor];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGRect shadowRect        = CGRectMake(0, 0, self.shadowRadius * 2, self.shadowRadius * 2);
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithOvalInRect:shadowRect];
    self.layer.masksToBounds = NO;
    self.layer.shadowColor   = self.shadowColor.CGColor;
    CGSize shadowOffset      = CGSizeMake(self.shadowOffset.width - (self.shadowRadius - self.frame.size.width / 2),
                                     self.shadowOffset.height - (self.shadowRadius - self.frame.size.height / 2));
    self.layer.shadowOffset  = shadowOffset;
    self.layer.shadowOpacity = self.shadowOpacity;
    self.layer.shadowPath    = shadowPath.CGPath;
}

#pragma mark - Touch Action

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *anyTouch     = [touches anyObject];
    CGPoint touchLocation = [anyTouch locationInView:self];
    CGRect selfRect       = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    if (CGRectContainsPoint(selfRect, touchLocation))
    {
        [self.buttonCircle setFillColor:self.buttonPressedColor.CGColor];
        if (self.imageNormalTintColor != nil)
        {
            [self.image setTintColor:self.imageNormalTintColor];
        }
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *anyTouch     = [touches anyObject];
    CGPoint touchLocation = [anyTouch locationInView:self];
    CGRect selfRect       = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self.buttonCircle setFillColor:self.buttonNormalColor.CGColor];
    if (self.imagePressedTintColor != nil)
    {
        [self.image setTintColor:self.imagePressedTintColor];
    }
    if (CGRectContainsPoint(selfRect, touchLocation))
    {
        [self click];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.imagePressedTintColor != nil)
    {
        [self.image setTintColor:self.imagePressedTintColor];
    }
    [self.buttonCircle setFillColor:self.buttonNormalColor.CGColor];
}

- (void)click
{
    if ([self.delegate respondsToSelector:@selector(onButtonClick:)])
    {
        [self.delegate onButtonClick:self.index];
    }
}

#pragma mark - Override Method

- (VHButtonEnum)type
{
    return VHSimpleCircle;
}

- (NSMutableArray<UIView *> *)goneViews
{
    return [NSMutableArray arrayWithObjects:self.image, nil];
}

- (NSMutableArray<UIView *> *)rotateViews
{
    return [NSMutableArray arrayWithObjects:self.image, nil];
}

@end
