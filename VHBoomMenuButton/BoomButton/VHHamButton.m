//
//  VHHamButton.m
//  VHBoomMenuButton
//
//  Created by 黄伟平 on 16/8/7.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import "VHHamButton.h"

@implementation VHHamButton

- (instancetype)initWithImage:(NSString *)imageNormal
                 pressedImage:(NSString *)imagePressed
                  normalColor:(UIColor *)normalColor
                 pressedColor:(UIColor *)pressedColor
         imageNormalTintColor:(UIColor *)imageNormalTintColor
        imagePressedTintColor:(UIColor *)imagePressedTintColor
             titleNormalColor:(UIColor *)titleNormalColor
            titlePressedColor:(UIColor *)titlePressedColor
          subTitleNormalColor:(UIColor *)subTitleNormalColor
         subTitlePressedColor:(UIColor *)subTitlePressedColor
                   imageFrame:(CGRect)imageFrame
                   titleFrame:(CGRect)titleFrame
                subTitleFrame:(CGRect)subTitleFrame
                        title:(NSString *)titleContent
                     subTitle:(NSString *)subTitleContent
                    titleFont:(UIFont *)titleFont
                 subTitleFont:(UIFont *)subTitleFont
           titleLineBreakMode:(NSLineBreakMode)titleLineBreakMode
            subTitleBreakMode:(NSLineBreakMode)subTitleLineBreakMode
                   titleLines:(int)titleLines
                subTitleLines:(int)subTitleLines
               titleAlignment:(NSTextAlignment)titleAlignment
            subTitleAlignment:(NSTextAlignment)subTitleAlignment
                  rotateImage:(BOOL)rotateImage
                 containImage:(BOOL)containImage
                  buttonWidth:(CGFloat)buttonWidth
                 buttonHeight:(CGFloat)buttonHeight
           buttonCornerRadius:(CGFloat)buttonCornerRadius
                  shadowWidth:(CGFloat)shadowWidth
                 shadowHeight:(CGFloat)shadowHeight
           shadowCornerRadius:(CGFloat)shadowCornerRadius
                 shadowOffset:(CGSize) shadowOffset
                shadowOpacity:(CGFloat)shadowOpacity
                  shadowColor:(UIColor *)shadowColor
                 withDelegate:(id<VHButtonClickDelegate>) delegate
                           at:(int)index
{
    CGRect frame = CGRectMake(0, 0, buttonWidth, buttonHeight);
    
    if (self = [super initWithFrame:frame])
    {
        self.imageNormal           = imageNormal;
        self.imagePressed          = imagePressed;
        self.buttonNormalColor     = normalColor;
        self.buttonPressedColor    = pressedColor;
        self.imageNormalTintColor  = imageNormalTintColor;
        self.imagePressedTintColor = imagePressedTintColor;
        self.titleNormalColor      = titleNormalColor;
        self.titlePressedColor     = titlePressedColor;
        self.subTitleNormalColor   = subTitleNormalColor;
        self.subTitlePressedColor  = subTitlePressedColor;
        self.titleContent          = titleContent;
        self.titleFont             = titleFont;
        self.titleLineBreakMode    = titleLineBreakMode;
        self.titlelines            = titleLines;
        self.subTitleContent       = subTitleContent;
        self.subTitleFont          = subTitleFont;
        self.subTitleLineBreakMode = subTitleLineBreakMode;
        self.subTitlelines         = subTitleLines;
        self.rotateImage           = rotateImage;
        self.containImage          = containImage;
        self.buttonWidth           = buttonWidth;
        self.buttonHeight          = buttonHeight;
        self.buttonCornerRadius    = buttonCornerRadius;
        self.shadowWidth           = shadowWidth;
        self.shadowHeight          = shadowHeight;
        self.shadowCornerRadius    = shadowCornerRadius;
        self.shadowOffset          = shadowOffset;
        self.shadowOpacity         = shadowOpacity;
        self.shadowColor           = shadowColor;
        self.delegate              = delegate;
        self.index                 = index;
        
        if (CGRectIsNull(imageFrame))
        {
            if (containImage)
            {
                self.imageFrame = CGRectMake(0, 0, buttonHeight, buttonHeight);
            }
            else
            {
                self.imageFrame = CGRectMake(0, 0, 0, 0);
            }
        }
        else
        {
            self.imageFrame = imageFrame;
        }
        
        if (subTitleContent == nil)
        {
            // only show title
            if (CGRectIsNull(titleFrame))
            {
                self.titleFrame = CGRectMake(self.imageFrame.origin.x + self.imageFrame.size.width + 5,
                                                          5,
                                                          self.frame.size.width - self.imageFrame.origin.x - self.imageFrame.size.width - 5,
                                                          buttonHeight - 5);
            }
            else
            {
                self.titleFrame = titleFrame;
            }
        }
        else
        {
            if (CGRectIsNull(subTitleFrame))
            {
                self.subTitleFrame = CGRectMake(self.imageFrame.origin.x + self.imageFrame.size.width + 5,
                                                          buttonHeight - 5 - 20,
                                                          self.frame.size.width - self.imageFrame.origin.x - self.imageFrame.size.width - 5,
                                                          20);
            }
            else
            {
                self.subTitleFrame = subTitleFrame;
            }
            
            if (CGRectIsNull(titleFrame))
            {
                self.titleFrame = CGRectMake(self.imageFrame.origin.x + self.imageFrame.size.width + 5,
                                                          5,
                                                          self.frame.size.width - self.imageFrame.origin.x - self.imageFrame.size.width - 5,
                                                          buttonHeight - 5 - subTitleFrame.size.height - 5 - 10);
            }
            else
            {
                self.titleFrame = titleFrame;
            }
        }
        
        self.buttonRect = [CAShapeLayer layer];
        [self.buttonRect setPath:[[UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:self.buttonCornerRadius] CGPath]];
        [self.buttonRect setFillColor:self.buttonNormalColor.CGColor];
        [[self layer] addSublayer:self.buttonRect];
        
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
        self.image                  = [[UIImageView alloc] initWithImage:self.imageNormalContent];
        self.image.frame            = self.imageFrame;
        if (self.imageNormalTintColor != nil)
        {
            [self.image setTintColor:self.imageNormalTintColor];
        }
        [self addSubview:self.image];
        
        self.title                   = [[UILabel alloc] initWithFrame:self.titleFrame];
        self.title.text              = self.titleContent;
        self.title.font              = self.titleFont;
        self.title.lineBreakMode     = self.titleLineBreakMode;
        self.title.numberOfLines     = self.titlelines;
        self.title.textAlignment     = titleAlignment;
        self.title.textColor         = self.titleNormalColor;
        self.title.backgroundColor   = [UIColor clearColor];
        [self addSubview:self.title];
        
        self.subTitle                   = [[UILabel alloc] initWithFrame:self.subTitleFrame];
        self.subTitle.text              = self.subTitleContent;
        self.subTitle.font              = self.subTitleFont;
        self.subTitle.lineBreakMode     = self.subTitleLineBreakMode;
        self.subTitle.numberOfLines     = self.subTitlelines;
        self.subTitle.textAlignment     = subTitleAlignment;
        self.subTitle.textColor         = self.subTitleNormalColor;
        self.subTitle.backgroundColor   = [UIColor clearColor];
        [self addSubview:self.subTitle];
        
        self.backgroundColor        = [UIColor clearColor];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGRect shadowRect        = CGRectMake(0, 0, self.shadowWidth, self.shadowHeight);
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRoundedRect:shadowRect cornerRadius:self.shadowCornerRadius];
    self.layer.masksToBounds = NO;
    self.layer.shadowColor   = self.shadowColor.CGColor;
    CGSize shadowOffset      = CGSizeMake(self.shadowOffset.width - (self.shadowWidth / 2 - self.frame.size.width / 2),
                                          self.shadowOffset.height - (self.shadowHeight / 2 - self.frame.size.height / 2));
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

- (void)click
{
    if ([self.delegate respondsToSelector:@selector(onButtonClick:)])
    {
        [self.delegate onButtonClick:self.index];
    }
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
    [self.buttonRect setFillColor:self.buttonNormalColor.CGColor];
    [self.title setTextColor:self.titleNormalColor];
    [self.subTitle setTextColor:self.subTitleNormalColor];
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
    [self.buttonRect setFillColor:self.buttonPressedColor.CGColor];
    [self.title setTextColor:self.titlePressedColor];
    [self.subTitle setTextColor:self.subTitlePressedColor];
}

#pragma mark - Override Method

- (VHButtonEnum)type
{
    return VHButtonHam;
}

- (NSMutableArray<UIView *> *)goneViews
{
    return [NSMutableArray arrayWithObjects:self.image, self.title, self.subTitle, nil];
}

- (NSMutableArray<UIView *> *)rotateViews
{
    NSMutableArray<UIView *> *views = [NSMutableArray arrayWithCapacity:2];
    if (self.rotateImage)
    {
        [views addObject:self.image];
    }
    return views;
}

- (CGPoint)rotateAnchorPoint
{
    CGPoint center = CGPointMake(self.imageFrame.origin.x + self.imageFrame.size.width / 2, self.imageFrame.origin.y + self.imageFrame.size.height / 2);
    return center;
}

@end
