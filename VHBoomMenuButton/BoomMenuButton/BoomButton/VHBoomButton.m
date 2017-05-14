//
//  VHBoomButton.m
//  VHBoomMenuExample
//
//  Created by Nightonke on 16/7/29.
//  Copyright © 2016 Nightonke. All rights reserved.
//

#import "VHBoomButton.h"
#import "VHUtils.h"
#import "VHBoomButtonBuilder.h"
#import "VHBoomButton_protected.h"

@implementation VHBoomButton

#pragma mark - In-BMB-Only Methods

- (instancetype)initWithBuilder:(VHBoomButtonBuilder *)builder
{
    self = [super init];
    if (self)
    {
        self.innerIndex = builder.innerIndex;
        self.innerListener = builder.innerListener;
        self.clickedBlock = builder.clickedBlock;
        self.unable = builder.unable;
        self.lastStateEnum = VHButtonStateUnknown;
        
        self.pieceColor = builder.pieceColor;
        
        self.hasShadow = builder.hasShadow;
        self.shadowRadius = builder.shadowRadius;
        self.shadowOffsetX = builder.shadowOffsetX;
        self.shadowOffsetY = builder.shadowOffsetY;
        self.shadowColor = builder.shadowColor;
        
        self.normalImageName = builder.normalImageName;
        self.normalImage = builder.normalImage;
        self.highlightedImageName = builder.highlightedImageName;
        self.highlightedImage = builder.highlightedImage;
        self.unableImageName = builder.unableImageName;
        self.unableImage = builder.unableImage;
        self.normalImageTintColor = builder.normalImageTintColor;
        self.highlightedImageTintColor = builder.highlightedImageTintColor;
        self.unableImageTintColor = builder.unableImageTintColor;
        self.imageFrame = builder.imageFrame;
        self.imageSize = builder.imageSize;
        self.rotateImage = builder.rotateImage;
        
        self.normalColor = builder.normalColor;
        self.highlightedColor = builder.highlightedColor;
        self.unableColor = builder.unableColor;
        self.cornerRadius = builder.cornerRadius;
        
        self.rotateAnchorPointInitialized = NO;
        
        self.exclusiveTouch = YES;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)willBoom
{
    
}

- (void)didBoom
{
    [_buttonLayer removeAllAnimations];
}

- (void)willReboom
{
    
}

- (void)didReboom
{
    [_buttonLayer removeAllAnimations];
}

- (void)clearListener
{
    
}

- (BOOL)innerNeedsColorAnimation
{
    if (self.pieceColor == nil)
    {
        return NO;
    }
    else
    {
        if (self.unable)
        {
            return ![VHUtils sameColor:self.pieceColor asColor:self.unableColor];
        }
        else
        {
            return ![VHUtils sameColor:self.pieceColor asColor:self.normalColor];
        }
    }
}

- (CAShapeLayer *)innerButtonLayer
{
    return _buttonLayer;
}

- (UIColor *)innerPieceColor
{
    return _pieceColor;
}

- (UIColor *)innerButtonColor
{
    if (self.unable)
    {
        return self.unableColor;
    }
    else
    {
        return self.normalColor;
    }
}

- (void)innerStopAnimations
{
    [self.layer removeAllAnimations];
    [self.buttonLayer removeAllAnimations];
    [self.imageView.layer removeAllAnimations];
    [self.label.layer removeAllAnimations];
    [self.subLabel.layer removeAllAnimations];
}

- (void)innerShowAllGoneViews
{
    for (UIView *view in self.goneViews)
    {
        view.alpha = 1;
    }
}

- (void)innerHideAllGoneViews
{
    for (UIView *view in self.goneViews)
    {
        view.alpha = 0;
    }
}

#pragma mark Setters

- (void)innerSetImageView
{
    if (!self.imageView)
    {
        self.imageView = [[UIImageView alloc] init];
        [self addSubview:self.imageView];
    }
    self.imageView.frame = self.imageFrame;
    self.imageView.contentMode = UIViewContentModeCenter;
}

- (void)innerSetLabel
{
    if (!self.label)
    {
        self.label = [[UILabel alloc] init];
        [self addSubview:self.label];
    }
    self.label.frame = self.textFrame;
    self.label.font = self.textFont;
    self.label.textAlignment = self.textAlignment;
    self.label.lineBreakMode = self.textLineBreakMode;
    self.label.numberOfLines = self.textLines;
    self.label.shadowColor = self.shadowColor;
    self.label.shadowOffset = CGSizeMake(self.textShadowOffsetX, self.textShadowOffsetY);
}

- (void)innerSetSubLabel
{
    if (!self.containsSubText)
    {
        if (self.subLabel)
        {
            [self.subLabel removeFromSuperview];
            self.subLabel = nil;
        }
        return;
    }
    if (!self.subLabel)
    {
        self.subLabel = [[UILabel alloc] init];
        [self addSubview:self.subLabel];
    }
    self.subLabel.frame = self.subTextFrame;
    self.subLabel.font = self.subTextFont;
    self.subLabel.textAlignment = self.subTextAlignment;
    self.subLabel.lineBreakMode = self.subTextLineBreakMode;
    self.subLabel.numberOfLines = self.subTextLines;
    self.subLabel.shadowColor = self.subTextShadowColor;
    self.subLabel.shadowOffset = CGSizeMake(self.subTextShadowOffsetX, self.subTextShadowOffsetY);
}

- (void)innerSetButtonLayer
{
    [self.buttonLayer removeFromSuperlayer];
    self.buttonLayer = [CAShapeLayer layer];
    switch ([self type])
    {
        case VHButtonSimpleCircle:
        case VHButtonTextInsideCircle:
        {
            if (self.round)
            {
                [self.buttonLayer setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.radius + self.radius, self.radius + self.radius)] CGPath]];
            }
            else
            {
                [self.buttonLayer setPath:[[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.radius + self.radius, self.radius + self.radius) cornerRadius:self.cornerRadius] CGPath]];
            }
            [self.buttonLayer setFrame:self.bounds];
            break;
        }
        case VHButtonTextOutsideCircle:
        {
            if (self.round)
            {
                [self.buttonLayer setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.width, self.width)] CGPath]];
            }
            else
            {
                [self.buttonLayer setPath:[[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.width, self.width) cornerRadius:self.cornerRadius] CGPath]];
            }
            [self.buttonLayer setFrame:CGRectMake(0, 0, self.width, self.width)];
            break;
        }
        case VHButtonHam:
        {
            [self.buttonLayer setPath:[[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.width, self.height) cornerRadius:self.cornerRadius] CGPath]];
            [self.buttonLayer setFrame:CGRectMake(0, 0, self.width, self.height)];
            break;
        }
        default:
            break;
    }
    [self.layer insertSublayer:self.buttonLayer atIndex:0];
}

- (void)innerSetShadow
{
    if (self.hasShadow)
    {
        UIBezierPath *shadowPath;
        if (self.round)
        {
            shadowPath = [UIBezierPath bezierPathWithOvalInRect:self.shadowPathRect];
        }
        else
        {
            shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.shadowPathRect
                                                    cornerRadius:self.cornerRadius];
        }
        self.layer.masksToBounds = NO;
        self.layer.shadowPath = shadowPath.CGPath;
        self.layer.shadowOffset = CGSizeMake(self.shadowOffsetX, self.shadowOffsetY);
        self.layer.shadowRadius = self.shadowRadius;
        self.layer.shadowColor = self.shadowColor.CGColor;
        self.layer.shadowOpacity = 1;
    }
    else
    {
        self.layer.shadowOpacity = 0;
    }
}

- (void)innerSetNormalImage:(VHBoomButtonBuilder *)builder
{
    self.normalImage = builder.normalImage;
    self.normalImageName = builder.normalImageName;
    if (!self.normalImage)
    {
        if (self.normalImageName)
        {
            self.normalImage = [UIImage imageNamed:self.normalImageName];
        }
    }
    self.normalImage = [VHUtils imageWithImage:self.normalImage scaledToSize:self.imageSize];
    if (self.normalImageTintColor || self.highlightedImageTintColor || self.unableImageTintColor)
    {
        self.normalImage = [self.normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
}

- (void)innerSetHighlightedImage:(VHBoomButtonBuilder *)builder
{
    self.highlightedImage = builder.highlightedImage;
    self.highlightedImageName = builder.highlightedImageName;
    if (!self.highlightedImage)
    {
        if (self.highlightedImageName)
        {
            self.highlightedImage = [UIImage imageNamed:self.highlightedImageName];
        }
    }
    self.highlightedImage = [VHUtils imageWithImage:self.highlightedImage scaledToSize:self.imageSize];
    if (self.normalImageTintColor || self.highlightedImageTintColor || self.unableImageTintColor)
    {
        self.highlightedImage = [self.highlightedImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
}

- (void)innerSetUnableImage:(VHBoomButtonBuilder *)builder
{
    self.unableImage = builder.unableImage;
    self.unableImageName = builder.unableImageName;
    if (!self.unableImage)
    {
        if (self.unableImageName)
        {
            self.unableImage = [UIImage imageNamed:self.unableImageName];
        }
    }
    self.unableImage = [VHUtils imageWithImage:self.unableImage scaledToSize:self.imageSize];
    if (self.normalImageTintColor || self.highlightedImageTintColor || self.unableImageTintColor)
    {
        self.unableImage = [self.unableImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
}

#pragma mark States

- (void)innerToNormalButton
{
    self.lastStateEnum = VHButtonStateNormal;
    [self.buttonLayer setFillColor:self.normalColor.CGColor];
}

- (void)innerToHighlightedButton
{
    self.lastStateEnum = VHButtonStateHighlighted;
    [self.buttonLayer setFillColor:self.highlightedColor.CGColor];
}

- (void)innerToUnableButton
{
    self.lastStateEnum = VHButtonStateUnable;
    [self.buttonLayer setFillColor:self.unableColor.CGColor];
}

- (void)innerToNormalImage
{
    [self.imageView setTintColor:self.normalImageTintColor];
    if (self.normalImage)
    {
        self.imageView.image = self.normalImage;
    }
}

- (void)innerToHighlightedImage
{
    [self.imageView setTintColor:self.highlightedImageTintColor];
    if (self.highlightedImage)
    {
        self.imageView.image = self.highlightedImage;
    }
}

- (void)innerToUnableImage
{
    [self.imageView setTintColor:self.unableImageTintColor];
    if (self.unableImage)
    {
        self.imageView.image = self.unableImage;
    }
}

- (void)innerToNormalText
{
    if (self.normalText)
    {
        [self.label setText:self.normalText];
    }
    if (self.normalAttributedText)
    {
        [self.label setAttributedText:self.normalAttributedText];
    }
    if (self.normalTextColor)
    {
        [self.label setTextColor:self.normalTextColor];
    }
}

- (void)innerToHighlightedText
{
    if (self.highlightedText)
    {
        [self.label setText:self.highlightedText];
    }
    if (self.highlightedAttributedText)
    {
        [self.label setAttributedText:self.highlightedAttributedText];
    }
    if (self.highlightedTextColor)
    {
        [self.label setTextColor:self.highlightedTextColor];
    }
}

- (void)innerToUnableText
{
    if (self.unableText)
    {
        [self.label setText:self.unableText];
    }
    if (self.unableAttributedText)
    {
        [self.label setAttributedText:self.unableAttributedText];
    }
    if (self.unableTextColor)
    {
        [self.label setTextColor:self.unableTextColor];
    }
}

- (void)innerToNormalSubText
{
    if (self.normalSubText)
    {
        [self.subLabel setText:self.normalSubText];
    }
    if (self.normalAttributedSubText)
    {
        [self.subLabel setAttributedText:self.normalAttributedSubText];
    }
    if (self.normalSubTextColor)
    {
        [self.subLabel setTextColor:self.normalSubTextColor];
    }
}

- (void)innerToHighlightedSubText
{
    if (self.highlightedSubText)
    {
        [self.subLabel setText:self.highlightedSubText];
    }
    if (self.highlightedAttributedSubText)
    {
        [self.subLabel setAttributedText:self.highlightedAttributedSubText];
    }
    if (self.highlightedSubTextColor)
    {
        [self.subLabel setTextColor:self.highlightedSubTextColor];
    }
}

- (void)innerToUnableSubText
{
    if (self.unableSubText)
    {
        [self.subLabel setText:self.unableSubText];
    }
    if (self.unableAttributedSubText)
    {
        [self.subLabel setAttributedText:self.unableAttributedSubText];
    }
    if (self.unableSubTextColor)
    {
        [self.subLabel setTextColor:self.unableSubTextColor];
    }
}

#pragma mark - Private Methods

- (void)drawRect:(CGRect)rect
{
    [self innerSetShadow];
}

#pragma mark - Touch Action

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *anyTouch = [touches anyObject];
    CGPoint touchLocation = [anyTouch locationInView:self];
    if (CGRectContainsPoint(self.buttonLayer.frame, touchLocation))
    {
        if (!self.unable)
        {
            [self toHighlighted];
        }
    }
    else
    {
        [super touchesBegan:touches withEvent:event];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *anyTouch = [touches anyObject];
    CGPoint touchLocation = [anyTouch locationInView:self];
    if (!CGRectContainsPoint(self.buttonLayer.frame, touchLocation) && !self.unable)
    {
        [self toNormal];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *anyTouch = [touches anyObject];
    CGPoint touchLocation = [anyTouch locationInView:self];
    if (CGRectContainsPoint(self.buttonLayer.frame, touchLocation) && !self.unable)
    {
        [self click];
    }
    
    if (!self.unable)
    {
        [self toNormal];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!self.unable)
    {
        [self toNormal];
    }
}

- (void)click
{
    if (self.clickedBlock)
    {
        self.clickedBlock(self.innerIndex);
    }
    if (self.innerListener && [self.innerListener respondsToSelector:@selector(onButton:clickedAt:)])
    {
        [self.innerListener onButton:self clickedAt:self.innerIndex];
    }
}

#pragma mark - Abstract Methods

- (VHButtonEnum)type
{
    NSAssert(NO, @"Method type should be overrided in child class");
    return VHButtonUnknown;
}

- (NSArray<UIView *> *)goneViews
{
    NSAssert(NO, @"Method goneViews should be overrided in child class");
    return nil;
}

- (NSArray<UIView *> *)rotateViews
{
    NSAssert(NO, @"Method rotateViews should be overrided in child class");
    return nil;
}

- (CGFloat)buttonWidth
{
    NSAssert(NO, @"Method width should be overrided in child class");
    return 0;
}

- (CGFloat)buttonHeight
{
    NSAssert(NO, @"Method contentHeight should be overrided in child class");
    return 0;
}

- (void)toUnable
{
    NSAssert(NO, @"Method toUnable should be overrided in child class");
}

- (void)toHighlighted
{
    NSAssert(NO, @"Method toHighlighted should be overrided in child class");
}

- (void)toNormal
{
    NSAssert(NO, @"Method toNormal should be overrided in child class");
}

- (void)setRotateAnchorPoints
{
    if (self.rotateAnchorPointInitialized) return;
    self.rotateAnchorPointInitialized = YES;
    
    CGFloat x = [self rotateAnchorPoint].x;
    CGFloat y = [self rotateAnchorPoint].y;
    for (UIView *view in [self rotateViews])
    {
        // http://joeshang.github.io/2014/12/19/understand-anchorpoint-position-frame/
        CGFloat anchorPointX = (x - view.frame.origin.x) / view.frame.size.width;
        CGFloat anchorPointY = (y - view.frame.origin.y) / view.frame.size.height;
        [VHUtils setAnchorPoint:CGPointMake(anchorPointX, anchorPointY) ofLayer:view.layer];
    }
}

- (CGPoint)rotateAnchorPoint
{
    NSAssert(NO, @"Method rotateAnchorPoint should be overrided in child class");
    return CGPointZero;
}

- (void)setAnchorPointOfLayer
{
    NSAssert(NO, @"Method setAnchorPointOfLayer should be overrided in child class");
}

- (CGPoint)centerPoint
{
    NSAssert(NO, @"Method centerPoint should be overrided in child class");
    return CGPointZero;
}

#pragma mark - Public Methods

- (UIImageView *)imageView
{
    return _imageView;
}

- (UILabel *)label
{
    return _label;
}

- (UILabel *)subLabel
{
    return _subLabel;
}

- (CAShapeLayer *)buttonLayer
{
    return _buttonLayer;
}

@end
