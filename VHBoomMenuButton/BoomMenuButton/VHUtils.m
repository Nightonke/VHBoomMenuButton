//
//  VHUtils.m
//  VHBoomMenuExample
//
//  Created by Nightonke on 16/7/28.
//  Copyright © 2016 Nightonke. All rights reserved.
//

#import "VHUtils.h"

static NSMutableArray<UIColor *> *colors;
static NSMutableArray *usedColors;

@implementation VHUtils

#pragma mark - Public Methods

+ (void)setAnchorPoint:(CGPoint)anchorPoint ofLayer:(CALayer *)layer
{
    CGRect originalFrame = layer.frame;
    [layer setAnchorPoint:anchorPoint];
    layer.frame = originalFrame;
}

+ (UIColor *)color
{
    NSMutableArray<UIColor *> *_colors = [self colors];
    NSMutableArray *_usedColors = [self usedColors];
    while (YES)
    {
        int colorIndex = arc4random() % _colors.count;
        if (![_usedColors containsObject:@(colorIndex)])
        {
            [_usedColors addObject:@(colorIndex)];
            while (_usedColors.count > 6)
            {
                [_usedColors removeObjectAtIndex:0];
            }
            return [_colors objectAtIndex:colorIndex];
        }
    }
}

+ (UIColor *)darkerColor:(UIColor *)color
{
    CGFloat hue, saturation, brightness, alpha;
    [color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    saturation *= 0.9;
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
}

+ (UIColor *)lighterColor:(UIColor *)color
{
    CGFloat hue, saturation, brightness, alpha;
    [color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    saturation *= 1.1;
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
}

+ (UIColor *)colorFromRGB:(int)color
{
    return [UIColor colorWithRed:((float)((color & 0xFF0000) >> 16)) / 255.0 green:((float)((color & 0xFF00) >> 8)) / 255.0 blue:((float)(color & 0xFF)) / 255.0 alpha:1.0];
}

+ (UIColor *)colorFromARGB:(int64_t)color
{
    return [UIColor colorWithRed:((float)((color & 0x00FF0000) >> 16)) / 255.0 green:((float)((color & 0x0000FF00) >> 8)) / 255.0 blue:((float)(color & 0x000000FF)) / 255.0 alpha:((float)((color & 0xFF000000) >> 24)) / 255.0];
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    if (!image)
    {
        return nil;
    }
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (BOOL)sameColor:(UIColor *)color1 asColor:(UIColor *)color2
{
    CGColorSpaceRef colorSpaceRGB = CGColorSpaceCreateDeviceRGB();
    
    UIColor *(^convertColorToRGBSpace)(UIColor*) = ^(UIColor *color) {
        if (CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) == kCGColorSpaceModelMonochrome) {
            const CGFloat *oldComponents = CGColorGetComponents(color.CGColor);
            CGFloat components[4] = {oldComponents[0], oldComponents[0], oldComponents[0], oldComponents[1]};
            CGColorRef colorRef = CGColorCreate(colorSpaceRGB, components);
            
            UIColor *color = [UIColor colorWithCGColor:colorRef];
            CGColorRelease(colorRef);
            return color;
        } else
            return color;
    };
    
    UIColor *rgbSpaceColor1 = convertColorToRGBSpace(color1);
    UIColor *rgbSpaceColor2 = convertColorToRGBSpace(color2);
    CGColorSpaceRelease(colorSpaceRGB);
    
    return [rgbSpaceColor1 isEqual:rgbSpaceColor2];
}

#pragma mark - Private Methods

+ (NSMutableArray<UIColor *> *)colors
{
    if (colors == nil)
    {
        colors = [NSMutableArray arrayWithCapacity:18];
        [colors addObject:[VHUtils colorFromRGB:0xF44336]];
        [colors addObject:[VHUtils colorFromRGB:0xE91E63]];
        [colors addObject:[VHUtils colorFromRGB:0x9C27B0]];
        [colors addObject:[VHUtils colorFromRGB:0x673AB7]];
        [colors addObject:[VHUtils colorFromRGB:0x3F51B5]];
        [colors addObject:[VHUtils colorFromRGB:0x2196F3]];
        [colors addObject:[VHUtils colorFromRGB:0x03A9F4]];
        [colors addObject:[VHUtils colorFromRGB:0x00BCD4]];
        [colors addObject:[VHUtils colorFromRGB:0x009688]];
        [colors addObject:[VHUtils colorFromRGB:0x4CAF50]];
        [colors addObject:[VHUtils colorFromRGB:0x009688]];
        [colors addObject:[VHUtils colorFromRGB:0xCDDC39]];
        [colors addObject:[VHUtils colorFromRGB:0xFFEB3B]];
        [colors addObject:[VHUtils colorFromRGB:0xFF9800]];
        [colors addObject:[VHUtils colorFromRGB:0xFF5722]];
        [colors addObject:[VHUtils colorFromRGB:0x795548]];
        [colors addObject:[VHUtils colorFromRGB:0x9E9E9E]];
        [colors addObject:[VHUtils colorFromRGB:0x607D8B]];
    }
    return colors;
}

+ (NSMutableArray *)usedColors
{
    if (usedColors == nil)
    {
        usedColors = [NSMutableArray arrayWithCapacity:7];
    }
    return usedColors;
}

@end
