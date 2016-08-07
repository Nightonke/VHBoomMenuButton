//
//  VHButtonPlaceManager.m
//  VHBoomMenuExample
//
//  Created by 黄伟平 on 16/7/29.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import "VHButtonPlaceManager.h"

@implementation VHButtonPlaceManager

+ (instancetype)sharedManager
{
    static VHButtonPlaceManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init
{
    if (self = [super init])
    {
        
    }
    return self;
}

- (void)dealloc
{
    // Should never be called, but just here for clarity really.
}

- (NSMutableArray<NSValue *> *)positionsWithEnum:(VHButtonPlaceEnum)placeEnum
                                   withAlignment:(VHButtonPlaceAlignmentEnum)alignmentEnum
                                 withParentFrame:(CGRect)frame
                                 withButtonWidth:(CGFloat)width
                                withButtonHeight:(CGFloat)height
                                withButtonNumber:(long)buttonNumber
                      withButtonHorizontalMargin:(CGFloat)buttonHorizontalMargin
                        withButtonInclinedMargin:(CGFloat)buttonInclinedMargin
                        withButtonVerticalMargin:(CGFloat)buttonVerticalMargin
                             withButtonTopMargin:(CGFloat)buttonTopMargin
                          withButtonBottomMargin:(CGFloat)buttonBottomMargin
                            withButtonLeftMargin:(CGFloat)buttonLeftMargin
                           withButtonRightMargin:(CGFloat)buttonRightMargin
{
    NSMutableArray *positions = [NSMutableArray array];
    
    CGFloat minHeight = CGFLOAT_MAX;
    CGFloat maxHeight = CGFLOAT_MIN;
    CGFloat minWidth = CGFLOAT_MAX;
    CGFloat maxWidth = CGFLOAT_MIN;
    
    switch (placeEnum) {
        case VHButtonPlace_Horizontal:
        {
            if (buttonNumber % 2 == 0)
            {
                long half = buttonNumber / 2;
                for (long i = half - 1; i >= 0; i--)
                {
                    [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-width / 2 - buttonHorizontalMargin / 2 - i * (width + buttonHorizontalMargin),
                                                                               0)]];
                }
                for (int i = 0; i < half; i++)
                {
                    [positions addObject:[NSValue valueWithCGPoint:CGPointMake(width / 2 + buttonHorizontalMargin / 2 + i * (width + buttonHorizontalMargin),
                                                                               0)]];
                }
            }
            else
            {
                long half = buttonNumber / 2;
                for (long i = half - 1; i >= 0; i--)
                {
                    [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-width - buttonHorizontalMargin - i * (width + buttonHorizontalMargin),
                                                                               0)]];
                }
                [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                           0)]];
                for (int i = 0; i < half; i++)
                {
                    [positions addObject:[NSValue valueWithCGPoint:CGPointMake(width + buttonHorizontalMargin + i * (width + buttonHorizontalMargin),
                                                                               0)]];
                }
            }
        }
            break;
        case VHButtonPlace_Vertical:
        {
            if (buttonNumber % 2 == 0)
            {
                long half = buttonNumber / 2;
                for (long i = half - 1; i >= 0; i--)
                {
                    [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                               -height / 2 - buttonHorizontalMargin / 2 - i * (height + buttonHorizontalMargin))]];
                }
                for (int i = 0; i < half; i++)
                {
                    [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                               height / 2 + buttonHorizontalMargin / 2 + i * (height + buttonHorizontalMargin))]];
                }
            }
            else
            {
                long half = buttonNumber / 2;
                for (long i = half - 1; i >= 0; i--)
                {
                    [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                               -height - buttonHorizontalMargin - i * (height + buttonHorizontalMargin))]];
                }
                [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                           0)]];
                for (int i = 0; i < half; i++)
                {
                    [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                               height + buttonHorizontalMargin + i * (height + buttonHorizontalMargin))]];
                }
            }
        }
            break;
        case VHButtonPlace_SC_1:
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       0)]];
            break;
        case VHButtonPlace_SC_2_1:
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - width / 2,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + width / 2,
                                                                       0)]];
            break;
        case VHButtonPlace_SC_2_2:
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -buttonVerticalMargin / 2 - height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       buttonVerticalMargin / 2 + height / 2)]];
            break;
        case VHButtonPlace_SC_3_1:
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - width,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + width,
                                                                       0)]];
            break;
        case VHButtonPlace_SC_3_2:
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -buttonVerticalMargin - height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       buttonVerticalMargin + height)]];
            break;
        case VHButtonPlace_SC_3_3:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - width / 2,
                                                                       -buttonVerticalMargin / 2 - height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + width / 2,
                                                                       -buttonVerticalMargin / 2 - height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       buttonVerticalMargin / 2 + height / 2)]];
            CGFloat yOffset = [self calculateYOffsetToCenterWithHorizontalMargin:buttonHorizontalMargin
                                                                  verticalMargin:buttonVerticalMargin
                                                                           width:width
                                                                          height:height];
            [self adjustOffsetForPositions:positions withX:0 withY:yOffset];
        }
            break;
        case VHButtonPlace_SC_3_4:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -buttonVerticalMargin / 2 - height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - width / 2,
                                                                       buttonVerticalMargin / 2 + height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + width / 2,
                                                                       buttonVerticalMargin / 2 + height / 2)]];
            CGFloat yOffset = [self calculateYOffsetToCenterWithHorizontalMargin:buttonHorizontalMargin
                                                                  verticalMargin:buttonVerticalMargin
                                                                           width:width
                                                                          height:height];
            [self adjustOffsetForPositions:positions withX:0 withY:-yOffset];
        }
            break;
        case VHButtonPlace_SC_4_1:
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - width / 2,
                                                                       -buttonVerticalMargin / 2 - height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + width / 2,
                                                                       -buttonVerticalMargin / 2 - height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - width / 2,
                                                                       buttonVerticalMargin / 2 + height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + width / 2,
                                                                       buttonVerticalMargin / 2 + height / 2)]];
            break;
        case VHButtonPlace_SC_4_2:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -buttonVerticalMargin / 2 - height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + width,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       buttonVerticalMargin / 2 + height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - width,
                                                                       0)]];
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
        }
            break;
        case VHButtonPlace_SC_5_1:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - width,
                                                                       -buttonVerticalMargin / 2 - height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                      -buttonVerticalMargin / 2 - height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + width,
                                                                       -buttonVerticalMargin / 2 - height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - width / 2,
                                                                       buttonVerticalMargin / 2 + height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + width / 2,
                                                                       buttonVerticalMargin / 2 + height / 2)]];
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
        }
            break;
        case VHButtonPlace_SC_5_2:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - width / 2,
                                                                       -buttonVerticalMargin / 2 - height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + width / 2,
                                                                       -buttonVerticalMargin / 2 - height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - width,
                                                                       buttonVerticalMargin / 2 + height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       buttonVerticalMargin / 2 + height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + width,
                                                                       buttonVerticalMargin / 2 + height / 2)]];
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
        }
            break;
        case VHButtonPlace_SC_5_3:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -buttonVerticalMargin - height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - width,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + width,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       buttonVerticalMargin + height)]];
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
        }
            break;
        case VHButtonPlace_SC_5_4:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - width,
                                                                       -buttonVerticalMargin / 2 - height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + width,
                                                                       -buttonVerticalMargin / 2 - height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - width,
                                                                       buttonVerticalMargin / 2 + height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + width,
                                                                       buttonVerticalMargin / 2 + height / 2)]];
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
        }
            break;
        case VHButtonPlace_SC_6_1:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - width,
                                                                       -buttonVerticalMargin / 2 - height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -buttonVerticalMargin / 2 - height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + width,
                                                                       -buttonVerticalMargin / 2 - height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - width,
                                                                       buttonVerticalMargin / 2 + height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       buttonVerticalMargin / 2 + height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + width,
                                                                       buttonVerticalMargin / 2 + height / 2)]];
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
        }
            break;
        case VHButtonPlace_SC_6_2:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - width / 2,
                                                                       -buttonVerticalMargin - height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - width / 2,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - width / 2,
                                                                       buttonVerticalMargin + height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + width / 2,
                                                                       -buttonVerticalMargin - height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + width / 2,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + width / 2,
                                                                       buttonVerticalMargin + height)]];
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
        }
            break;
        case VHButtonPlace_SC_6_3:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - width / 2,
                                                                       -buttonVerticalMargin - height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + width / 2,
                                                                       -buttonVerticalMargin - height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - width,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + width,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - width / 2,
                                                                       buttonVerticalMargin + height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + width / 2,
                                                                       buttonVerticalMargin + height)]];
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
        }
            break;
        case VHButtonPlace_SC_6_4:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -buttonVerticalMargin - height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + width,
                                                                       -buttonVerticalMargin / 2 - height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + width,
                                                                       buttonVerticalMargin / 2 + height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       buttonVerticalMargin + height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - width,
                                                                       -buttonVerticalMargin / 2 - height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - width,
                                                                       buttonVerticalMargin / 2 + height / 2)]];
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
        }
            break;
        case VHButtonPlace_SC_6_5:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - width,
                                                                       -buttonVerticalMargin - height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -buttonVerticalMargin - height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + width,
                                                                       -buttonVerticalMargin - height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - width / 2,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + width / 2,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       +buttonVerticalMargin + height)]];
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
        }
            break;
        case VHButtonPlace_SC_6_6:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -buttonVerticalMargin - height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - width / 2,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + width / 2,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - width,
                                                                       buttonVerticalMargin + height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       buttonVerticalMargin + height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + width,
                                                                       buttonVerticalMargin + height)]];

            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
        }
            break;
        case VHButtonPlace_SC_7_1:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - width,
                                                                       -buttonHorizontalMargin - height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -buttonHorizontalMargin - height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + width,
                                                                       -buttonHorizontalMargin - height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - width,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + width,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       buttonHorizontalMargin + height)]];
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
        }
            break;
        case VHButtonPlace_SC_7_2:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -buttonHorizontalMargin - height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - width,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + width,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - width,
                                                                       buttonHorizontalMargin + height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       buttonHorizontalMargin + height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + width,
                                                                       buttonHorizontalMargin + height)]];
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
        }
            break;
        case VHButtonPlace_SC_7_3:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - width / 2,
                                                                       -buttonVerticalMargin - height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + width / 2,
                                                                       -buttonVerticalMargin - height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - width,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + width,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - width / 2,
                                                                       buttonVerticalMargin + height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + width / 2,
                                                                       buttonVerticalMargin + height)]];
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
        }
            break;
        case VHButtonPlace_SC_7_4:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -buttonVerticalMargin - height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + width,
                                                                       -buttonVerticalMargin / 2 - height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + width,
                                                                       buttonVerticalMargin / 2 + height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       buttonVerticalMargin + height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - width,
                                                                       -buttonVerticalMargin / 2 - height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - width,
                                                                       buttonVerticalMargin / 2 + height / 2)]];
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
        }
            break;
        case VHButtonPlace_SC_7_5:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin * 3 / 2 - width * 3 / 2,
                                                                       -buttonVerticalMargin / 2 - height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - width / 2,
                                                                       -buttonVerticalMargin / 2 - height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + width / 2,
                                                                       -buttonVerticalMargin / 2 - height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin * 3 / 2 + width * 3 / 2,
                                                                       -buttonVerticalMargin / 2 - height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - width,
                                                                       buttonVerticalMargin / 2 + height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       buttonVerticalMargin / 2 + height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + width,
                                                                       buttonVerticalMargin / 2 + height / 2)]];
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
        }
            break;
        case VHButtonPlace_SC_7_6:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - width,
                                                                       -buttonVerticalMargin / 2 - height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -buttonVerticalMargin / 2 - height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + width,
                                                                       -buttonVerticalMargin / 2 - height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin * 3 / 2 - width * 3 / 2,
                                                                       buttonVerticalMargin / 2 + height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - width / 2,
                                                                       buttonVerticalMargin / 2 + height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + width / 2,
                                                                       buttonVerticalMargin / 2 + height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin * 3 / 2 + width * 3 / 2,
                                                                       buttonVerticalMargin / 2 + height / 2)]];
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
        }
            break;
        case VHButtonPlace_SC_8_1:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - width,
                                                                       -buttonVerticalMargin - height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -buttonVerticalMargin - height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + width,
                                                                       -buttonVerticalMargin - height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - width / 2,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + width / 2,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - width,
                                                                       buttonVerticalMargin + height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       buttonVerticalMargin + height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + width,
                                                                       buttonVerticalMargin + height)]];
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
        }
            break;
        case VHButtonPlace_SC_8_2:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - width,
                                                                       -buttonVerticalMargin - height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - width,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - width,
                                                                       buttonVerticalMargin + height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -buttonVerticalMargin / 2 - height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       buttonVerticalMargin / 2 + height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + width,
                                                                       -buttonVerticalMargin - height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + width,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + width,
                                                                       buttonVerticalMargin + height)]];
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
        }
            break;
        case VHButtonPlace_SC_8_3:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - width,
                                                                       -buttonVerticalMargin - height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - width,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - width,
                                                                       buttonVerticalMargin + height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -buttonVerticalMargin - height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       buttonVerticalMargin + height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + width,
                                                                       -buttonVerticalMargin - height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + width,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + width,
                                                                       buttonVerticalMargin + height)]];
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
        }
            break;
        case VHButtonPlace_SC_8_4:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -buttonVerticalMargin * 2 - height * 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + width / 2,
                                                                       -buttonVerticalMargin - height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + width,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + width / 2,
                                                                       buttonVerticalMargin + height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       buttonVerticalMargin * 2 + height * 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - width / 2,
                                                                       buttonVerticalMargin + height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - width,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - width / 2,
                                                                       -buttonVerticalMargin - height)]];
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
        }
            break;
        case VHButtonPlace_SC_8_5:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -buttonVerticalMargin - height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + width,
                                                                       -buttonVerticalMargin / 2 - height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin * 2 + width * 2,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + width,
                                                                       buttonVerticalMargin / 2 + height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       buttonVerticalMargin + height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - width,
                                                                       buttonVerticalMargin / 2 + height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin * 2 - width * 2,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - width,
                                                                       -buttonVerticalMargin / 2 - height / 2)]];
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
        }
            break;
        case VHButtonPlace_SC_8_6:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin * 3 / 2 - width * 3 / 2,
                                                                       -buttonVerticalMargin / 2 - height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - width / 2,
                                                                       -buttonVerticalMargin / 2 - height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + width / 2,
                                                                       -buttonVerticalMargin / 2 - height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin * 3 / 2 + width * 3 / 2,
                                                                       -buttonVerticalMargin / 2 - height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin * 3 / 2 - width * 3 / 2,
                                                                       buttonVerticalMargin / 2 + height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - width / 2,
                                                                       buttonVerticalMargin / 2 + height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + width / 2,
                                                                       buttonVerticalMargin / 2 + height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin * 3 / 2 + width * 3 / 2,
                                                                       buttonVerticalMargin / 2 + height / 2)]];
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
        }
            break;
        case VHButtonPlace_SC_8_7:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - width / 2,
                                                                       -buttonVerticalMargin * 3 / 2 - height * 3 / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - width / 2,
                                                                       -buttonVerticalMargin / 2 - height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - width / 2,
                                                                       buttonVerticalMargin / 2 + height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - width / 2,
                                                                       buttonVerticalMargin * 3 / 2 + height * 3 / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + width / 2,
                                                                       -buttonVerticalMargin * 3 / 2 - height * 3 / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + width / 2,
                                                                       -buttonVerticalMargin / 2 - height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + width / 2,
                                                                       buttonVerticalMargin / 2 + height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + width / 2,
                                                                       buttonVerticalMargin * 3 / 2 + height * 3 / 2)]];
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
        }
            break;
        case VHButtonPlace_SC_9_1:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - width,
                                                                       -buttonVerticalMargin - height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - width,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - width,
                                                                       buttonVerticalMargin + height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -buttonVerticalMargin - height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       buttonVerticalMargin + height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + width,
                                                                       -buttonVerticalMargin - height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + width,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + width,
                                                                       buttonVerticalMargin + height)]];
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
        }
            break;
        case VHButtonPlace_SC_9_2:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -buttonVerticalMargin * 2 - height * 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + width / 2,
                                                                       -buttonVerticalMargin - height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + width,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + width / 2,
                                                                       buttonVerticalMargin + height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       buttonVerticalMargin * 2 + height * 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - width / 2,
                                                                       buttonVerticalMargin + height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - width,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - width / 2,
                                                                       -buttonVerticalMargin - height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       0)]];
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
        }
            break;
        case VHButtonPlace_SC_9_3:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -buttonVerticalMargin - height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + width,
                                                                       -buttonVerticalMargin / 2 - height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin * 2 + width * 2,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + width,
                                                                       buttonVerticalMargin / 2 + height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       buttonVerticalMargin + height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - width,
                                                                       buttonVerticalMargin / 2 + height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin * 2 - width * 2,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - width,
                                                                       -buttonVerticalMargin / 2 - height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       0)]];
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
        }
            break;
        default:
            NSAssert(NO, @"Button place enum not found!");
            break;
    }
    
    for (int i = 0; i < positions.count; i++)
    {
        CGPoint point = [[positions objectAtIndex:i] CGPointValue];
        [positions setObject:[NSValue valueWithCGPoint:CGPointMake(point.x + frame.size.width / 2, point.y + frame.size.height / 2) ] atIndexedSubscript:i];
    }
    
    for (NSValue *position in positions)
    {
        maxHeight = MAX(maxHeight, [position CGPointValue].y);
        minHeight = MIN(minHeight, [position CGPointValue].y);
        maxWidth = MAX(maxWidth, [position CGPointValue].x);
        minWidth = MIN(minWidth, [position CGPointValue].x);
    }
    
    CGFloat heightOffset = 0;
    CGFloat widthOffset = 0;
    switch (alignmentEnum) {
        case VHButtonPlaceAlignmentCenter:
            break;
        case VHButtonPlaceAlignmentTop:
            heightOffset = height / 2 + buttonTopMargin - minHeight;
            break;
        case VHButtonPlaceAlignmentBottom:
            heightOffset = frame.size.height - height / 2 - maxHeight - buttonBottomMargin;
            break;
        case VHButtonPlaceAlignmentLeft:
            widthOffset = width / 2 + buttonLeftMargin - minWidth;
            break;
        case VHButtonPlaceAlignmentRight:
            widthOffset = frame.size.width - width / 2 - maxWidth - buttonRightMargin;
            break;
        case VHButtonPlaceAlignmentTL:
            heightOffset = height / 2 + buttonTopMargin - minHeight;
            widthOffset = width / 2 + buttonLeftMargin - minWidth;
            break;
        case VHButtonPlaceAlignmentTR:
            heightOffset = height / 2 + buttonTopMargin - minHeight;
            widthOffset = frame.size.width - width / 2 - maxWidth - buttonRightMargin;
            break;
        case VHButtonPlaceAlignmentBL:
            heightOffset = frame.size.height - height / 2 - maxHeight - buttonBottomMargin;
            widthOffset = width / 2 + buttonLeftMargin - minWidth;
            break;
        case VHButtonPlaceAlignmentBR:
            heightOffset = frame.size.height - height / 2 - maxHeight - buttonBottomMargin;
            widthOffset = frame.size.width - width / 2 - maxWidth - buttonRightMargin;
            break;
    }
    for (int i = 0; i < positions.count; i++)
    {
        CGPoint point = [[positions objectAtIndex:i] CGPointValue];
        [positions setObject:[NSValue valueWithCGPoint:CGPointMake(point.x + widthOffset, point.y + heightOffset)] atIndexedSubscript:i];
    }
    
    return positions;

}

- (NSMutableArray<NSValue *> *)positionsWithEnum:(VHButtonPlaceEnum)placeEnum
                                   withAlignment:(VHButtonPlaceAlignmentEnum)alignmentEnum
                                 withParentFrame:(CGRect)frame
                                withButtonRadius:(CGFloat)radius
                                withButtonNumber:(long)buttonNumber
                      withButtonHorizontalMargin:(CGFloat)buttonHorizontalMargin
                        withButtonInclinedMargin:(CGFloat)buttonInclinedMargin
                        withButtonVerticalMargin:(CGFloat)buttonVerticalMargin
                             withButtonTopMargin:(CGFloat)buttonTopMargin
                          withButtonBottomMargin:(CGFloat)buttonBottomMargin
                            withButtonLeftMargin:(CGFloat)buttonLeftMargin
                           withButtonRightMargin:(CGFloat)buttonRightMargin
{
    NSMutableArray *positions = [NSMutableArray array];
    
    CGFloat minHeight = CGFLOAT_MAX;
    CGFloat maxHeight = CGFLOAT_MIN;
    CGFloat minWidth = CGFLOAT_MAX;
    CGFloat maxWidth = CGFLOAT_MIN;
    
    switch (placeEnum) {
        case VHButtonPlace_Horizontal:
        {
            if (buttonNumber % 2 == 0)
            {
                long half = buttonNumber / 2;
                for (long i = half - 1; i >= 0; i--)
                {
                    [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-radius - buttonHorizontalMargin / 2 - i * (2 * radius + buttonHorizontalMargin),
                                                                               0)]];
                }
                for (int i = 0; i < half; i++)
                {
                    [positions addObject:[NSValue valueWithCGPoint:CGPointMake(radius + buttonHorizontalMargin / 2 + i * (2 * radius + buttonHorizontalMargin),
                                                                               0)]];
                }
            }
            else
            {
                long half = buttonNumber / 2;
                for (long i = half - 1; i >= 0; i--)
                {
                    [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-2 * radius - buttonHorizontalMargin - i * (2 * radius + buttonHorizontalMargin),
                                                                               0)]];
                }
                [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                           0)]];
                for (int i = 0; i < half; i++)
                {
                    [positions addObject:[NSValue valueWithCGPoint:CGPointMake(2 * radius + buttonHorizontalMargin + i * (2 * radius + buttonHorizontalMargin),
                                                                               0)]];
                }
            }
        }
            break;
        case VHButtonPlace_Vertical:
        {
            if (buttonNumber % 2 == 0)
            {
                long half = buttonNumber / 2;
                for (long i = half - 1; i >= 0; i--)
                {
                    [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                               -radius - buttonHorizontalMargin / 2 - i * (2 * radius + buttonHorizontalMargin))]];
                }
                for (int i = 0; i < half; i++)
                {
                    [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                               radius + buttonHorizontalMargin / 2 + i * (2 * radius + buttonHorizontalMargin))]];
                }
            }
            else
            {
                long half = buttonNumber / 2;
                for (long i = half - 1; i >= 0; i--)
                {
                    [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                               -2 * radius - buttonHorizontalMargin - i * (2 * radius + buttonHorizontalMargin))]];
                }
                [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                           0)]];
                for (int i = 0; i < half; i++)
                {
                    [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                               2 * radius + buttonHorizontalMargin + i * (2 * radius + buttonHorizontalMargin))]];
                }
            }
        }
            break;
        case VHButtonPlace_SC_1:
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       0)]];
            break;
        case VHButtonPlace_SC_2_1:
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - radius,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + radius,
                                                                       0)]];
            break;
        case VHButtonPlace_SC_2_2:
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -buttonVerticalMargin / 2 - radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       buttonVerticalMargin / 2 + radius)]];
            break;
        case VHButtonPlace_SC_3_1:
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - 2 * radius,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + 2 * radius,
                                                                       0)]];
            break;
        case VHButtonPlace_SC_3_2:
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -buttonVerticalMargin - 2 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       buttonVerticalMargin + 2 * radius)]];
            break;
        case VHButtonPlace_SC_3_3:
        {
            CGFloat a, b, c;
            b = buttonHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-b,
                                                                       -a)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(b,
                                                                       -a)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       c)]];
        }
            break;
        case VHButtonPlace_SC_3_4:
        {
            CGFloat a, b, c;
            b = buttonHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-b,
                                                                       a)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(b,
                                                                       a)]];
        }
            break;
        case VHButtonPlace_SC_4_1:
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - radius,
                                                                       -buttonVerticalMargin / 2 - radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + radius,
                                                                       -buttonVerticalMargin / 2 - radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - radius,
                                                                       buttonVerticalMargin / 2 + radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + radius,
                                                                       buttonVerticalMargin / 2 + radius)]];
            break;
        case VHButtonPlace_SC_4_2:
        {
            CGFloat a = (2 * radius + buttonInclinedMargin) / sqrt(2);
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -a)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(a,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       a)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-a,
                                                                       0)]];
        }
            break;
        case VHButtonPlace_SC_5_1:
        {
            CGFloat a, b, c;
            b = buttonHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-2 * b,
                                                                       -c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(2 * b,
                                                                       -c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - radius,
                                                                       a)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + radius,
                                                                       a)]];
        }
            break;
        case VHButtonPlace_SC_5_2:
        {
            CGFloat a, b, c;
            b = buttonHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - radius,
                                                                       -a)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + radius,
                                                                       -a)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-2 * b,
                                                                       c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(2 * b,
                                                                       c)]];
        }
            break;
        case VHButtonPlace_SC_5_3:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -buttonVerticalMargin - 2 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + 2 * radius,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       buttonVerticalMargin + 2 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - 2 * radius,
                                                                       0)]];
        }
            break;
        case VHButtonPlace_SC_5_4:
        {
            CGFloat a = (2 * radius + buttonInclinedMargin) / sqrt(2);
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(a,
                                                                       -a)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(a,
                                                                       a)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-a,
                                                                       a)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-a,
                                                                       -a)]];
        }
            break;
        case VHButtonPlace_SC_6_1:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - 2 * radius,
                                                                       -buttonVerticalMargin / 2 - radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -buttonVerticalMargin / 2 - radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + 2 * radius,
                                                                       -buttonVerticalMargin / 2 - radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - 2 * radius,
                                                                       buttonVerticalMargin / 2 + radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       buttonVerticalMargin / 2 + radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + 2 * radius,
                                                                       buttonVerticalMargin / 2 + radius)]];
        }
            break;
        case VHButtonPlace_SC_6_2:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - radius,
                                                                       -buttonVerticalMargin - 2 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - radius,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - radius,
                                                                       buttonVerticalMargin + 2 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + radius,
                                                                       -buttonVerticalMargin - 2 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + radius,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + radius,
                                                                       buttonVerticalMargin + 2 * radius)]];
        }
            break;
        case VHButtonPlace_SC_6_3:
        {
            CGFloat a, b, c;
            b = buttonHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-b,
                                                                       -a - c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(b,
                                                                       -a - c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(2 * b,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(b,
                                                                       a + c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-b,
                                                                       a + c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-2 * b,
                                                                       0)]];
        }
            break;
        case VHButtonPlace_SC_6_4:
        {
            CGFloat a, b, c;
            b = buttonHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -2 * b)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(a + c,
                                                                       -b)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(a + c,
                                                                       b)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       2 * b)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-a - c,
                                                                       b)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-a - c,
                                                                       -b)]];
        }
            break;
        case VHButtonPlace_SC_6_5:
        {
            CGFloat a, b, c, yOffset;
            b = buttonHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            yOffset = c - a;
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-2 * b,
                                                                       -a - c + yOffset)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -a - c + yOffset)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(2 * b,
                                                                       -a - c + yOffset)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - radius,
                                                                       0 + yOffset)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + radius,
                                                                       0 + yOffset)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       a + c + yOffset)]];
        }
            break;
        case VHButtonPlace_SC_6_6:
        {
            CGFloat a, b, c, yOffset;
            b = buttonHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            yOffset = c - a;
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -a - c - yOffset)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - radius,
                                                                       0 - yOffset)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + radius,
                                                                       0 - yOffset)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-2 * b,
                                                                       a + c - yOffset)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       a + c - yOffset)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(2 * b,
                                                                       a + c - yOffset)]];
        }
            break;
        case VHButtonPlace_SC_7_1:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - 2 * radius,
                                                                       -buttonHorizontalMargin - 2 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -buttonHorizontalMargin - 2 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + 2 * radius,
                                                                       -buttonHorizontalMargin - 2 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - 2 * radius,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + 2 * radius,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       buttonHorizontalMargin + 2 * radius)]];
        }
            break;
        case VHButtonPlace_SC_7_2:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -buttonHorizontalMargin - 2 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - 2 * radius,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + 2 * radius,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - 2 * radius,
                                                                       buttonHorizontalMargin + 2 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       buttonHorizontalMargin + 2 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + 2 * radius,
                                                                       buttonHorizontalMargin + 2 * radius)]];
        }
            break;
        case VHButtonPlace_SC_7_3:
        {
            CGFloat a, b, c;
            b = buttonHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-b,
                                                                       -a - c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(b,
                                                                       -a - c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(2 * b,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(b,
                                                                       a + c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-b,
                                                                       a + c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-2 * b,
                                                                       0)]];
        }
            break;
        case VHButtonPlace_SC_7_4:
        {
            CGFloat a, b, c;
            b = buttonHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -2 * b)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(a + c,
                                                                       -b)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(a + c,
                                                                       b)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       2 * b)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-a - c,
                                                                       b)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-a - c,
                                                                       -b)]];
        }
            break;
        case VHButtonPlace_SC_7_5:
        {
            CGFloat a, b, c;
            b = buttonHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-3 * b,
                                                                       -a)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-b,
                                                                       -a)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(b,
                                                                       -a)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(3 * b,
                                                                       -a)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-2 * b,
                                                                       c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(2 * b,
                                                                       c)]];
        }
            break;
        case VHButtonPlace_SC_7_6:
        {
            CGFloat a, b, c;
            b = buttonHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-2 * b,
                                                                       -c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(2 * b,
                                                                       -c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-3 * b,
                                                                       a)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-b,
                                                                       a)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(b,
                                                                       a)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(3 * b,
                                                                       a)]];
        }
            break;
        case VHButtonPlace_SC_8_1:
        {
            CGFloat a, b, c;
            b = buttonHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-2 * b,
                                                                       -a - c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -a - c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(2 * b,
                                                                       -a - c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - radius,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + radius,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-2 * b,
                                                                       a + c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       a + c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(2 * b,
                                                                       a + c)]];
        }
            break;
        case VHButtonPlace_SC_8_2:
        {
            CGFloat a, b, c;
            b = buttonVerticalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-a - c,
                                                                       -2 * b)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-a - c,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-a - c,
                                                                       2 * b)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -buttonVerticalMargin / 2 - radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       buttonVerticalMargin / 2 + radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(a + c,
                                                                       -2 * b)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(a + c,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(a + c,
                                                                       2 * b)]];
        }
            break;
        case VHButtonPlace_SC_8_3:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - 2 * radius,
                                                                       -buttonVerticalMargin - 2 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -buttonVerticalMargin - 2 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + 2 * radius,
                                                                       -buttonVerticalMargin - 2 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - 2 * radius,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + 2 * radius,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - 2 * radius,
                                                                       buttonVerticalMargin + 2 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       buttonVerticalMargin + 2 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + 2 * radius,
                                                                       buttonVerticalMargin + 2 * radius)]];
        }
            break;
        case VHButtonPlace_SC_8_4:
        {
            CGFloat a, b, c;
            b = buttonHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -2 * a - 2 * c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - radius,
                                                                       -a - c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + radius,
                                                                       -a - c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-2 * b,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(2 * b,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - radius,
                                                                       a + c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + radius,
                                                                       a + c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       2 * a + 2 * c)]];
        }
            break;
        case VHButtonPlace_SC_8_5:
        {
            CGFloat a = (2 * radius + buttonInclinedMargin) / sqrt(2);
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -2 * a)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(a,
                                                                       -a)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(2 * a,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(a,
                                                                       a)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       2 * a)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-a,
                                                                       a)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-2 * a,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-a,
                                                                       -a)]];
        }
            break;
        case VHButtonPlace_SC_8_6:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin * 3 / 2 - 3 * radius,
                                                                       -buttonVerticalMargin / 2 - radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - radius,
                                                                       -buttonVerticalMargin / 2 - radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + radius,
                                                                       -buttonVerticalMargin / 2 - radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin * 3 / 2 + 3 * radius,
                                                                       -buttonVerticalMargin / 2 - radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin * 3 / 2 - 3 * radius,
                                                                       buttonVerticalMargin / 2 + radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - radius,
                                                                       buttonVerticalMargin / 2 + radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + radius,
                                                                       buttonVerticalMargin / 2 + radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin * 3 / 2 + 3 * radius,
                                                                       buttonVerticalMargin / 2 + radius)]];
        }
            break;
        case VHButtonPlace_SC_8_7:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - radius,
                                                                       -buttonVerticalMargin * 3 / 2 - 3 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + radius,
                                                                       -buttonVerticalMargin * 3 / 2 - 3 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - radius,
                                                                       -buttonVerticalMargin / 2 - radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + radius,
                                                                       -buttonVerticalMargin / 2 - radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - radius,
                                                                       buttonVerticalMargin / 2 + radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + radius,
                                                                       buttonVerticalMargin / 2 + radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - radius,
                                                                       buttonVerticalMargin * 3 / 2 + 3 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + radius,
                                                                       buttonVerticalMargin * 3 / 2 + 3 * radius)]];
        }
        case VHButtonPlace_SC_9_1:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - 2 * radius,
                                                                       -buttonVerticalMargin - 2 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -buttonVerticalMargin - 2 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + 2 * radius,
                                                                       -buttonVerticalMargin - 2 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - 2 * radius,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + 2 * radius,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin - 2 * radius,
                                                                       buttonVerticalMargin + 2 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       buttonVerticalMargin + 2 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin + 2 * radius,
                                                                       buttonVerticalMargin + 2 * radius)]];
        }
            break;
        case VHButtonPlace_SC_9_2:
        {
            CGFloat a, b, c;
            b = buttonHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -2 * a - 2 * c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - radius,
                                                                       -a - c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + radius,
                                                                       -a - c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-2 * b,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(2 * b,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-buttonHorizontalMargin / 2 - radius,
                                                                       a + c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(buttonHorizontalMargin / 2 + radius,
                                                                       a + c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       2 * a + 2 * c)]];
        }
            break;
        case VHButtonPlace_SC_9_3:
        {
            CGFloat a = (2 * radius + buttonInclinedMargin) / sqrt(2);
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -2 * a)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(a,
                                                                       -a)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(2 * a,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(a,
                                                                       a)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       2 * a)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-a,
                                                                       a)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-2 * a,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-a,
                                                                       -a)]];
        }
            break;
        default:
            NSAssert(NO, @"Button place enum not found!");
            break;
    }

    for (int i = 0; i < positions.count; i++)
    {
        CGPoint point = [[positions objectAtIndex:i] CGPointValue];
        [positions setObject:[NSValue valueWithCGPoint:CGPointMake(point.x + frame.size.width / 2, point.y + frame.size.height / 2) ] atIndexedSubscript:i];
    }
    
    for (NSValue *position in positions)
    {
        maxHeight = MAX(maxHeight, [position CGPointValue].y);
        minHeight = MIN(minHeight, [position CGPointValue].y);
        maxWidth = MAX(maxWidth, [position CGPointValue].x);
        minWidth = MIN(minWidth, [position CGPointValue].x);
    }
    
    CGFloat heightOffset = 0;
    CGFloat widthOffset = 0;
    switch (alignmentEnum) {
        case VHButtonPlaceAlignmentCenter:
            break;
        case VHButtonPlaceAlignmentTop:
            heightOffset = radius + buttonTopMargin - minHeight;
            break;
        case VHButtonPlaceAlignmentBottom:
            heightOffset = frame.size.height - radius - maxHeight - buttonBottomMargin;
            break;
        case VHButtonPlaceAlignmentLeft:
            widthOffset = radius + buttonLeftMargin - minWidth;
            break;
        case VHButtonPlaceAlignmentRight:
            widthOffset = frame.size.width - radius - maxWidth - buttonRightMargin;
            break;
        case VHButtonPlaceAlignmentTL:
            heightOffset = radius + buttonTopMargin - minHeight;
            widthOffset = radius + buttonLeftMargin - minWidth;
            break;
        case VHButtonPlaceAlignmentTR:
            heightOffset = radius + buttonTopMargin - minHeight;
            widthOffset = frame.size.width - radius - maxWidth - buttonRightMargin;
            break;
        case VHButtonPlaceAlignmentBL:
            heightOffset = frame.size.height - radius - maxHeight - buttonBottomMargin;
            widthOffset = radius + buttonLeftMargin - minWidth;
            break;
        case VHButtonPlaceAlignmentBR:
            heightOffset = frame.size.height - radius - maxHeight - buttonBottomMargin;
            widthOffset = frame.size.width - radius - maxWidth - buttonRightMargin;
            break;
    }
    for (int i = 0; i < positions.count; i++)
    {
        CGPoint point = [[positions objectAtIndex:i] CGPointValue];
        [positions setObject:[NSValue valueWithCGPoint:CGPointMake(point.x + widthOffset, point.y + heightOffset)] atIndexedSubscript:i];
    }
    
    return positions;
}

- (NSMutableArray<NSValue *> *)positionsForHamWithEnum:(VHButtonPlaceEnum)placeEnum
                                         withAlignment:(VHButtonPlaceAlignmentEnum)alignmentEnum
                                       withParentFrame:(CGRect)frame
                                       withButtonWidth:(CGFloat)width
                                      withButtonHeight:(CGFloat)height
                                      withButtonNumber:(long)buttonNumber
                            withButtonHorizontalMargin:(CGFloat)buttonHorizontalMargin
                              withButtonVerticalMargin:(CGFloat)buttonVerticalMargin
                                   withButtonTopMargin:(CGFloat)buttonTopMargin
                                withButtonBottomMargin:(CGFloat)buttonBottomMargin
                                  withButtonLeftMargin:(CGFloat)buttonLeftMargin
                                 withButtonRightMargin:(CGFloat)buttonRightMargin
                           withLastButtonMarginMoreTop:(BOOL)lastButtonMarginMoreTop
                               withLastButtonTopMargin:(CGFloat)lastButtonTopMargin

{
    NSMutableArray *positions = [NSMutableArray array];
    
    CGFloat minHeight = CGFLOAT_MAX;
    CGFloat maxHeight = CGFLOAT_MIN;
    CGFloat minWidth = CGFLOAT_MAX;
    CGFloat maxWidth = CGFLOAT_MIN;
    
    switch (placeEnum)
    {
        case VHButtonPlace_Horizontal:
        {
            if (buttonNumber % 2 == 0)
            {
                long half = buttonNumber / 2;
                for (long i = half - 1; i >= 0; i--)
                {
                    [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-width / 2 - buttonHorizontalMargin / 2 - i * (width + buttonHorizontalMargin),
                                                                               0)]];
                }
                for (int i = 0; i < half; i++)
                {
                    [positions addObject:[NSValue valueWithCGPoint:CGPointMake(width / 2 + buttonHorizontalMargin / 2 + i * (width + buttonHorizontalMargin),
                                                                               0)]];
                }
            }
            else
            {
                long half = buttonNumber / 2;
                for (long i = half - 1; i >= 0; i--)
                {
                    [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-width - buttonHorizontalMargin - i * (width + buttonHorizontalMargin),
                                                                               0)]];
                }
                [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                           0)]];
                for (int i = 0; i < half; i++)
                {
                    [positions addObject:[NSValue valueWithCGPoint:CGPointMake(width + buttonHorizontalMargin + i * (width + buttonHorizontalMargin),
                                                                               0)]];
                }
            }
        }
            break;
        case VHButtonPlace_Vertical:
        {
            if (buttonNumber % 2 == 0)
            {
                long half = buttonNumber / 2;
                for (long i = half - 1; i >= 0; i--)
                {
                    [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                               -height / 2 - buttonHorizontalMargin / 2 - i * (height + buttonHorizontalMargin))]];
                }
                for (int i = 0; i < half; i++)
                {
                    [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                               height / 2 + buttonHorizontalMargin / 2 + i * (height + buttonHorizontalMargin))]];
                }
            }
            else
            {
                long half = buttonNumber / 2;
                for (long i = half - 1; i >= 0; i--)
                {
                    [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                               -height - buttonHorizontalMargin - i * (height + buttonHorizontalMargin))]];
                }
                [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                           0)]];
                for (int i = 0; i < half; i++)
                {
                    [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                               height + buttonHorizontalMargin + i * (height + buttonHorizontalMargin))]];
                }
            }
        }
            break;
        case VHButtonPlace_HAM_1:
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       0)]];
            break;
        case VHButtonPlace_HAM_2:
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -buttonVerticalMargin / 2 - height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       buttonVerticalMargin / 2 + height / 2)]];
            break;
        case VHButtonPlace_HAM_3:
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -buttonVerticalMargin - height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       buttonVerticalMargin + height)]];
        case VHButtonPlace_HAM_4:
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -buttonVerticalMargin * 3 / 2 - height * 3 / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -buttonVerticalMargin / 2 - height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       buttonVerticalMargin / 2 + height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       buttonVerticalMargin * 3 / 2 + height * 3 / 2)]];
            break;
        case VHButtonPlace_HAM_5:
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -buttonVerticalMargin * 2 - height * 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -buttonVerticalMargin - height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       buttonVerticalMargin + height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       buttonVerticalMargin * 2 + height * 2)]];
            break;
        default:
            NSAssert(NO, @"Button place enum not found!");
            break;
    }
    
    if (buttonNumber >= 2 && lastButtonMarginMoreTop)
    {
        CGPoint point = [[positions objectAtIndex:buttonNumber - 1] CGPointValue];
        [positions setObject:[NSValue valueWithCGPoint:CGPointMake(point.x, point.y + lastButtonTopMargin - buttonVerticalMargin)] atIndexedSubscript:buttonNumber - 1];
    }
    
    for (int i = 0; i < positions.count; i++)
    {
        CGPoint point = [[positions objectAtIndex:i] CGPointValue];
        [positions setObject:[NSValue valueWithCGPoint:CGPointMake(point.x + frame.size.width / 2, point.y + frame.size.height / 2) ] atIndexedSubscript:i];
    }
    
    for (NSValue *position in positions)
    {
        maxHeight = MAX(maxHeight, [position CGPointValue].y);
        minHeight = MIN(minHeight, [position CGPointValue].y);
        maxWidth = MAX(maxWidth, [position CGPointValue].x);
        minWidth = MIN(minWidth, [position CGPointValue].x);
    }
    
    CGFloat heightOffset = 0;
    CGFloat widthOffset = 0;
    switch (alignmentEnum) {
        case VHButtonPlaceAlignmentCenter:
            break;
        case VHButtonPlaceAlignmentTop:
            heightOffset = height / 2 + buttonTopMargin - minHeight;
            break;
        case VHButtonPlaceAlignmentBottom:
            heightOffset = frame.size.height - height / 2 - maxHeight - buttonBottomMargin;
            break;
        case VHButtonPlaceAlignmentLeft:
            widthOffset = width / 2 + buttonLeftMargin - minWidth;
            break;
        case VHButtonPlaceAlignmentRight:
            widthOffset = frame.size.width - width / 2 - maxWidth - buttonRightMargin;
            break;
        case VHButtonPlaceAlignmentTL:
            heightOffset = height / 2 + buttonTopMargin - minHeight;
            widthOffset = width / 2 + buttonLeftMargin - minWidth;
            break;
        case VHButtonPlaceAlignmentTR:
            heightOffset = height / 2 + buttonTopMargin - minHeight;
            widthOffset = frame.size.width - width / 2 - maxWidth - buttonRightMargin;
            break;
        case VHButtonPlaceAlignmentBL:
            heightOffset = frame.size.height - height / 2 - maxHeight - buttonBottomMargin;
            widthOffset = width / 2 + buttonLeftMargin - minWidth;
            break;
        case VHButtonPlaceAlignmentBR:
            heightOffset = frame.size.height - height / 2 - maxHeight - buttonBottomMargin;
            widthOffset = frame.size.width - width / 2 - maxWidth - buttonRightMargin;
            break;
    }
    for (int i = 0; i < positions.count; i++)
    {
        CGPoint point = [[positions objectAtIndex:i] CGPointValue];
        [positions setObject:[NSValue valueWithCGPoint:CGPointMake(point.x + widthOffset, point.y + heightOffset)] atIndexedSubscript:i];
    }

    
    return positions;
}

- (NSInteger)numbersWithEnum:(VHButtonPlaceEnum)placeEnum
{
    switch (placeEnum)
    {
        case VHButtonPlace_SC_1:
        case VHButtonPlace_HAM_1:
            return 1;
        case VHButtonPlace_SC_2_1:
        case VHButtonPlace_SC_2_2:
        case VHButtonPlace_HAM_2:
            return 2;
        case VHButtonPlace_SC_3_1:
        case VHButtonPlace_SC_3_2:
        case VHButtonPlace_SC_3_3:
        case VHButtonPlace_SC_3_4:
        case VHButtonPlace_HAM_3:
            return 3;
        case VHButtonPlace_SC_4_1:
        case VHButtonPlace_SC_4_2:
        case VHButtonPlace_HAM_4:
            return 4;
        case VHButtonPlace_SC_5_1:
        case VHButtonPlace_SC_5_2:
        case VHButtonPlace_SC_5_3:
        case VHButtonPlace_SC_5_4:
        case VHButtonPlace_HAM_5:
            return 5;
        case VHButtonPlace_SC_6_1:
        case VHButtonPlace_SC_6_2:
        case VHButtonPlace_SC_6_3:
        case VHButtonPlace_SC_6_4:
        case VHButtonPlace_SC_6_5:
        case VHButtonPlace_SC_6_6:
            return 6;
        case VHButtonPlace_SC_7_1:
        case VHButtonPlace_SC_7_2:
        case VHButtonPlace_SC_7_3:
        case VHButtonPlace_SC_7_4:
        case VHButtonPlace_SC_7_5:
        case VHButtonPlace_SC_7_6:
            return 7;
        case VHButtonPlace_SC_8_1:
        case VHButtonPlace_SC_8_2:
        case VHButtonPlace_SC_8_3:
        case VHButtonPlace_SC_8_4:
        case VHButtonPlace_SC_8_5:
        case VHButtonPlace_SC_8_6:
        case VHButtonPlace_SC_8_7:
            return 8;
        case VHButtonPlace_SC_9_1:
        case VHButtonPlace_SC_9_2:
        case VHButtonPlace_SC_9_3:
            return 9;
        case VHButtonPlace_Horizontal:
        case VHButtonPlace_Vertical:
            return LONG_MAX;
    }
}

- (CGFloat)calculateYOffsetToCenterWithHorizontalMargin:(CGFloat)hm verticalMargin:(CGFloat)vm width:(CGFloat)w height:(CGFloat)h
{
    return (hm / 2 + w / 2) * (hm / 2 + w / 2) / (vm + h);
}

- (void)adjustOffsetForPositions:(NSMutableArray<NSValue *> *)positions withX:(CGFloat)x withY:(CGFloat)y
{
    for (int i = 0; i < positions.count; i++)
    {
        CGPoint point = [[positions objectAtIndex:i] CGPointValue];
        [positions setObject:[NSValue valueWithCGPoint:CGPointMake(point.x + x, point.y + y)] atIndexedSubscript:i];
    }
}

@end
