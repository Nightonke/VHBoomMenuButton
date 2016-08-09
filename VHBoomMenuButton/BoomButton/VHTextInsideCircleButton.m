//
//  VHTextInsideCircleButton.m
//  VHBoomMenuButton
//
//  Created by 黄伟平 on 16/8/2.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import "VHTextInsideCircleButton.h"

@implementation VHTextInsideCircleButton

- (instancetype)initWithImage:(NSString *)imageNormal
                 pressedImage:(NSString *)imagePressed
                  normalColor:(UIColor *)normalColor
                 pressedColor:(UIColor *)pressedColor
         imageNormalTintColor:(UIColor *)imageNormalTintColor
        imagePressedTintColor:(UIColor *)imagePressedTintColor
              textNormalColor:(UIColor *)textNormalColor
             textPressedColor:(UIColor *)textPressedColor
                   imageFrame:(CGRect)imageFrame
                    textFrame:(CGRect)textFrame
                         text:(NSString *)textContent
                         font:(UIFont *)font
                lineBreakMode:(NSLineBreakMode)lineBreakMode
                        lines:(int)lines
                  rotateImage:(BOOL)rotateImage
                   rotateText:(BOOL)rotateText
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
        self.textNormalColor        = textNormalColor;
        self.textPressedColor       = textPressedColor;
        if (CGRectIsNull(imageFrame))
        {
        self.imageFrame             = frame;
        }
        else
        {
        self.imageFrame             = imageFrame;
        }
        if (CGRectIsNull(textFrame))
        {
        self.textFrame              = CGRectMake(10, self.frame.size.height * 5.5 / 8, self.frame.size.width - 20, 20);
        }
        else
        {
        self.textFrame              = textFrame;
        }
        self.textContent            = textContent;
        self.font                   = font;
        self.lineBreakMode          = lineBreakMode;
        self.lines                  = lines;
        self.rotateImage            = rotateImage;
        self.rotateText             = rotateText;
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

        if (imageNormal != nil)
        {
            self.imageNormalContent = [UIImage imageNamed:self.imageNormal];
            if (self.imageNormalTintColor != nil && self.imagePressedTintColor != nil)
            {
                self.imageNormalContent = [self.imageNormalContent imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            }
        }
        if (imagePressed != nil)
        {
            self.imagePressedContent = [UIImage imageNamed:self.imagePressed];
            if (self.imageNormalTintColor != nil && self.imagePressedTintColor != nil)
            {
                self.imagePressedContent = [self.imagePressedContent imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            }
        }

        self.image = [[UIImageView alloc] initWithImage:self.imageNormalContent];
        if (CGRectIsNull(imageFrame))
        {
            imageFrame = frame;
        }
        self.image.frame = imageFrame;
        if (self.imageNormalTintColor != nil)
        {
            [self.image setTintColor:self.imageNormalTintColor];
        }
        [self addSubview:self.image];

        self.text                   = [[UILabel alloc] initWithFrame:self.textFrame];
        self.text.text              = self.textContent;
        self.text.font              = self.font;
        self.text.lineBreakMode     = self.lineBreakMode;
        self.text.numberOfLines     = self.lines;
        self.text.textAlignment     = NSTextAlignmentCenter;
        self.text.textColor         = self.textNormalColor;
        self.text.backgroundColor   = [UIColor clearColor];
        [self addSubview:self.text];

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
        [self toPressed];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self toNormal];
    
    UITouch *anyTouch     = [touches anyObject];
    CGPoint touchLocation = [anyTouch locationInView:self];
    CGRect selfRect       = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    if (CGRectContainsPoint(selfRect, touchLocation))
    {
        [self click];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self toNormal];
}

- (void)toNormal
{
    if (self.imageNormalTintColor != nil)
    {
        [self.image setTintColor:self.imageNormalTintColor];
    }
    if (self.imageNormalContent != nil)
    {
        self.image.image = self.imageNormalContent;
    }
    [self.buttonCircle setFillColor:self.buttonNormalColor.CGColor];
    [self.text setTextColor:self.textNormalColor];
}

- (void)toPressed
{
    if (self.imagePressedTintColor != nil)
    {
        [self.image setTintColor:self.imagePressedTintColor];
    }
    if (self.imagePressedContent != nil)
    {
        self.image.image = self.imagePressedContent;
    }
    [self.buttonCircle setFillColor:self.buttonPressedColor.CGColor];
    [self.text setTextColor:self.textPressedColor];
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
    return VHButtonTextInsideCircle;
}

- (NSMutableArray<UIView *> *)goneViews
{
    return [NSMutableArray arrayWithObjects:self.image, self.text, nil];
}

- (NSMutableArray<UIView *> *)rotateViews
{
    NSMutableArray<UIView *> *views = [NSMutableArray arrayWithCapacity:2];
    if (self.rotateImage)
    {
        [views addObject:self.image];
    }
    if (self.rotateText)
    {
        [views addObject:self.text];
    }
    return views;
}

- (CGPoint)rotateAnchorPoint
{
    CGPoint center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    return center;
}

@end
