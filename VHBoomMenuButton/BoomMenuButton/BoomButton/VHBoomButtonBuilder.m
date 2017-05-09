//
//  VHBoomButtonBuilder.m
//  VHBoomMenuExample
//
//  Created by Nightonke on 16/7/31.
//  Copyright © 2016 Nightonke. All rights reserved.
//

#import "VHBoomButtonBuilder.h"
#import "VHBoomButton_protected.h"
#import "VHBoomButtonBuilder_protected.h"
#import "VHUtils.h"

@implementation VHBoomButtonBuilder

#pragma mark - Private Methods

- (instancetype)init
{
    if (self = [super init])
    {
        _innerIndex = -1;
        _innerListener = nil;
        _clickedBlock = nil;
        _unable = NO;
        _rotateImage = YES;
        
        _pieceColor = nil;
        
        _hasShadow = YES;
        _shadowOffsetX = 0;
        _shadowOffsetY = 8;
        _shadowRadius = 4;
        _shadowColor = [VHUtils colorFromARGB:0x44000000];
        
        _normalImageName = nil;
        _normalImage = nil;
        _highlightedImageName = nil;
        _highlightedImage = nil;
        _unableImageName = nil;
        _unableImage = nil;
        _normalImageTintColor = nil;
        _highlightedImageTintColor = nil;
        _unableImageTintColor = nil;
        _imageFrame = CGRectMake(10, 10, 60, 60);
        _imageSize = CGSizeMake(60, 60);
        
        _normalColor = [VHUtils color];
        _highlightedColor = [VHUtils color];
        _unableColor = [VHUtils color];
        _cornerRadius = 5;
    }
    return self;
}

#pragma mark - Public Methods

+ (VHBoomButtonBuilder *)builder
{
    NSAssert(NO, @"Method builder should be overrided in child class");
    return nil;
}

#pragma mark - In-BMB-Only Methods

- (VHBoomButton *)innerBuild
{
    NSAssert(NO, @"Method build should be overrided in child class");
    return nil;
}

- (UIColor *)innerPieceColor
{
    if (self.pieceColor)
    {
        return self.pieceColor;
    }
    else
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
}

- (VHButtonEnum)innerType
{
    NSAssert(NO, @"Method type should be overrided in child class");
    return VHButtonUnknown;
}

#pragma mark - Setters

#pragma mark Basic

- (void)setClickedBlock:(BoomButtonDidClickBlock)clickedBlock
{
    if (_clickedBlock == clickedBlock)
    {
        return;
    }
    self.button.clickedBlock = _clickedBlock = clickedBlock;
}

- (void)setUnable:(BOOL)unable
{
    if (_unable == unable)
    {
        return;
    }
    self.button.unable = _unable = unable;
    [self.piece innerSetColor:[self innerPieceColor]];
    if (_unable)
    {
        [self.button toUnable];
    }
    else
    {
        [self.button toNormal];
    }
}

- (void)setRotateImage:(BOOL)rotateImage
{
    if (_rotateImage == rotateImage)
    {
        return;
    }
    self.button.rotateImage = _rotateImage = rotateImage;
}

#pragma mark Piece

- (void)setPieceColor:(UIColor *)pieceColor
{
    if ([VHUtils sameColor:_pieceColor asColor:pieceColor])
    {
        return;
    }
    self.button.pieceColor = _pieceColor = pieceColor;
    [self.piece innerSetColor:[self innerPieceColor]];
}

#pragma mark Shadow

- (void)setHasShadow:(BOOL)hasShadow
{
    if (_hasShadow == hasShadow)
    {
        return;
    }
    self.button.hasShadow = _hasShadow = hasShadow;
    [self.button setNeedsDisplay];
}

- (void)setShadowPathRect:(CGRect)shadowPathRect
{
    if (CGRectEqualToRect(_shadowPathRect, shadowPathRect))
    {
        return;
    }
    self.button.shadowPathRect = _shadowPathRect = shadowPathRect;
    [self.button setNeedsDisplay];
}

- (void)setShadowOffsetX:(CGFloat)shadowOffsetX
{
    if (_shadowOffsetX == shadowOffsetX)
    {
        return;
    }
    self.button.shadowOffsetX = _shadowOffsetX = shadowOffsetX;
    [self.button setNeedsDisplay];
}

- (void)setShadowOffsetY:(CGFloat)shadowOffsetY
{
    if (_shadowOffsetY == shadowOffsetY)
    {
        return;
    }
    self.button.shadowOffsetY = _shadowOffsetY = shadowOffsetY;
    [self.button setNeedsDisplay];
}

- (void)setShadowRadius:(CGFloat)shadowRadius
{
    if (_shadowRadius == shadowRadius)
    {
        return;
    }
    self.button.shadowRadius = _shadowRadius = shadowRadius;
    [self.button setNeedsDisplay];
}

- (void)setShadowColor:(UIColor *)shadowColor
{
    if ([VHUtils sameColor:_shadowColor asColor:shadowColor])
    {
        return;
    }
    self.button.shadowColor = _shadowColor = shadowColor;
    [self.button setNeedsDisplay];
}

#pragma mark Image

- (void)setNormalImageName:(NSString *)normalImageName
{
    if ([_normalImageName isEqualToString:normalImageName])
    {
        return;
    }
    _normalImageName = normalImageName;
    [self.button innerSetNormalImage:self];
    if (self.button.lastStateEnum == VHButtonStateNormal)
    {
        [self.button innerToNormalImage];
    }
}

- (void)setNormalImage:(UIImage *)normalImage
{
    if ([_normalImage isEqual:normalImage])
    {
        return;
    }
    _normalImage = normalImage;
    [self.button innerSetNormalImage:self];
    if (self.button.lastStateEnum == VHButtonStateNormal)
    {
        [self.button innerToNormalImage];
    }
}

- (void)setHighlightedImageName:(NSString *)highlightedImageName
{
    if ([_highlightedImageName isEqualToString:highlightedImageName])
    {
        return;
    }
    _highlightedImageName = highlightedImageName;
    [self.button innerSetHighlightedImage:self];
    if (self.button.lastStateEnum == VHButtonStateHighlighted)
    {
        [self.button innerToHighlightedImage];
    }
}

- (void)setHighlightedImage:(UIImage *)highlightedImage
{
    if ([_highlightedImage isEqual:highlightedImage])
    {
        return;
    }
    _highlightedImage = highlightedImage;
    [self.button innerSetHighlightedImage:self];
    if (self.button.lastStateEnum == VHButtonStateHighlighted)
    {
        [self.button innerToHighlightedImage];
    }
}

- (void)setUnableImageName:(NSString *)unableImageName
{
    if ([_unableImageName isEqualToString:unableImageName])
    {
        return;
    }
    _unableImageName = unableImageName;
    [self.button innerSetUnableImage:self];
    if (self.button.lastStateEnum == VHButtonStateUnable)
    {
        [self.button innerToUnableImage];
    }
}

- (void)setUnableImage:(UIImage *)unableImage
{
    if ([_unableImage isEqual:unableImage])
    {
        return;
    }
    _unableImage = unableImage;
    [self.button innerSetUnableImage:self];
    if (self.button.lastStateEnum == VHButtonStateUnable)
    {
        [self.button innerToUnableImage];
    }
}

- (void)setNormalImageTintColor:(UIColor *)normalImageTintColor
{
    if ([VHUtils sameColor:_normalImageTintColor asColor:normalImageTintColor])
    {
        return;
    }
    self.button.normalImageTintColor = _normalImageTintColor = normalImageTintColor;
    [self.button innerSetNormalImage:self];
    if (self.button.lastStateEnum == VHButtonStateNormal)
    {
        [self.button innerToNormalImage];
    }
}

- (void)setHighlightedImageTintColor:(UIColor *)highlightedImageTintColor
{
    if ([VHUtils sameColor:_highlightedImageTintColor asColor:highlightedImageTintColor])
    {
        return;
    }
    self.button.highlightedImageTintColor = _highlightedImageTintColor = highlightedImageTintColor;
    [self.button innerSetHighlightedImage:self];
    if (self.button.lastStateEnum == VHButtonStateHighlighted)
    {
        [self.button innerToHighlightedImage];
    }
}

- (void)setUnableImageTintColor:(UIColor *)unableImageTintColor
{
    if ([VHUtils sameColor:_unableImageTintColor asColor:unableImageTintColor])
    {
        return;
    }
    self.button.unableImageTintColor = _unableImageTintColor = unableImageTintColor;
    [self.button innerSetUnableImage:self];
    if (self.button.lastStateEnum == VHButtonStateUnable)
    {
        [self.button innerToUnableImage];
    }
}

- (void)setImageFrame:(CGRect)imageFrame
{
    if (CGRectEqualToRect(_imageFrame, imageFrame))
    {
        return;
    }
    self.button.rotateAnchorPointInitialized = NO;
    self.button.imageFrame = _imageFrame = imageFrame;
    [self.button innerSetImageView];
}

- (void)setImageSize:(CGSize)imageSize
{
    if (CGSizeEqualToSize(_imageSize, imageSize))
    {
        return;
    }
    self.button.rotateAnchorPointInitialized = NO;
    self.button.imageSize = _imageSize = imageSize;
    [self.button innerSetNormalImage:self];
    [self.button innerSetHighlightedImage:self];
    [self.button innerSetUnableImage:self];
    if (self.button.lastStateEnum == VHButtonStateNormal)
    {
        [self.button innerToNormalImage];
    }
    else if (self.button.lastStateEnum == VHButtonStateHighlighted)
    {
        [self.button innerToHighlightedImage];
    }
    else if (self.button.lastStateEnum == VHButtonStateUnable)
    {
        [self.button innerToUnableImage];
    }
}

#pragma mark Button

- (void)setNormalColor:(UIColor *)normalColor
{
    if ([_normalColor isEqual:normalColor])
    {
        return;
    }
    self.button.normalColor = _normalColor = normalColor;
    if (self.button.lastStateEnum == VHButtonStateNormal)
    {
        [self.button innerToNormalButton];
    }
    [self.piece innerSetColor:[self innerPieceColor]];
}

- (void)setHighlightedColor:(UIColor *)highlightedColor
{
    if ([_highlightedColor isEqual:highlightedColor])
    {
        return;
    }
    self.button.highlightedColor = _highlightedColor = highlightedColor;
    if (self.button.lastStateEnum == VHButtonStateHighlighted)
    {
        [self.button innerToHighlightedButton];
    }
    [self.piece innerSetColor:[self innerPieceColor]];
}

- (void)setUnableColor:(UIColor *)unableColor
{
    if ([_unableColor isEqual:unableColor])
    {
        return;
    }
    self.button.unableColor = _unableColor = unableColor;
    if (self.button.lastStateEnum == VHButtonStateUnable)
    {
        [self.button innerToUnableButton];
    }
    [self.piece innerSetColor:[self innerPieceColor]];
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    if (_cornerRadius == cornerRadius)
    {
        return;
    }
    self.button.cornerRadius = _cornerRadius = cornerRadius;
    [self.button innerSetButtonLayer];
    [self.button innerSetShadow];
    if (self.button.lastStateEnum == VHButtonStateNormal)
    {
        [self.button innerToNormalButton];
    }
    else if (self.button.lastStateEnum == VHButtonStateHighlighted)
    {
        [self.button innerToHighlightedButton];
    }
    else if (self.button.lastStateEnum == VHButtonStateUnable)
    {
        [self.button innerToUnableButton];
    }
}

@end
