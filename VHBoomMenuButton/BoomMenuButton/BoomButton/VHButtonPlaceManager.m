//
//  VHButtonPlaceManager.m
//  VHBoomMenuExample
//
//  Created by Nightonke on 16/7/29.
//  Copyright © 2016年 Nightonke. All rights reserved.
//

#import "VHButtonPlaceManager.h"

#define ADD_POINT(a, b) [positions addObject:[NSValue valueWithCGPoint:CGPointMake(a, b)]];

@implementation VHButtonPlaceManager

+ (NSMutableArray<NSValue *> *)positionsWithEnum:(VHButtonPlaceEnum)placeEnum
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
        case VHButtonPlaceHorizontal:
        {
            if (buttonNumber % 2 == 0)
            {
                long half = buttonNumber / 2;
                for (long i = half - 1; i >= 0; i--)
                {
                    ADD_POINT(-width / 2 - buttonHorizontalMargin / 2 - i * (width + buttonHorizontalMargin), 0);
                }
                for (int i = 0; i < half; i++)
                {
                    ADD_POINT(width / 2 + buttonHorizontalMargin / 2 + i * (width + buttonHorizontalMargin), 0);
                }
            }
            else
            {
                long half = buttonNumber / 2;
                for (long i = half - 1; i >= 0; i--)
                {
                    ADD_POINT(-width - buttonHorizontalMargin - i * (width + buttonHorizontalMargin), 0);
                }
                ADD_POINT(0,     0);
                for (int i = 0; i < half; i++)
                {
                    ADD_POINT(width + buttonHorizontalMargin + i * (width + buttonHorizontalMargin), 0);
                }
                break;
            }
        }
        case VHButtonPlaceVertical:
        {
            if (buttonNumber % 2 == 0)
            {
                long half = buttonNumber / 2;
                for (long i = half - 1; i >= 0; i--)
                {
                    ADD_POINT(0, -height / 2 - buttonVerticalMargin / 2 - i * (height + buttonVerticalMargin));
                }
                for (int i = 0; i < half; i++)
                {
                    ADD_POINT(0, height / 2 + buttonVerticalMargin / 2 + i * (height + buttonVerticalMargin));
                }
            }
            else
            {
                long half = buttonNumber / 2;
                for (long i = half - 1; i >= 0; i--)
                {
                    ADD_POINT(0, -height - buttonVerticalMargin - i * (height + buttonVerticalMargin));
                }
                ADD_POINT(0, 0);
                for (int i = 0; i < half; i++)
                {
                    ADD_POINT(0, height + buttonVerticalMargin + i * (height + buttonVerticalMargin));
                }
                break;
            }
        }
        case VHButtonPlaceSC_1:
            ADD_POINT(0, 0);
            break;
        case VHButtonPlaceSC_2_1:
            ADD_POINT(-buttonHorizontalMargin / 2 - width / 2, 0);
            ADD_POINT(buttonHorizontalMargin / 2 + width / 2, 0);
            break;
        case VHButtonPlaceSC_2_2:
            ADD_POINT(0, -buttonVerticalMargin / 2 - height / 2);
            ADD_POINT(0, buttonVerticalMargin / 2 + height / 2);
            break;
        case VHButtonPlaceSC_3_1:
            ADD_POINT(-buttonHorizontalMargin - width, 0);
            ADD_POINT(0, 0);
            ADD_POINT(buttonHorizontalMargin + width, 0);
            break;
        case VHButtonPlaceSC_3_2:
            ADD_POINT(0, -buttonVerticalMargin - height);
            ADD_POINT(0, 0);
            ADD_POINT(0, buttonVerticalMargin + height);
            break;
        case VHButtonPlaceSC_3_3:
        {
            ADD_POINT(-buttonHorizontalMargin / 2 - width / 2, -buttonVerticalMargin / 2 - height / 2);
            ADD_POINT(buttonHorizontalMargin / 2 + width / 2, -buttonVerticalMargin / 2 - height / 2);
            ADD_POINT(0, buttonVerticalMargin / 2 + height / 2);
            CGFloat yOffset = [VHButtonPlaceManager calculateYOffsetToCenterWithHorizontalMargin:buttonHorizontalMargin
                                                                                  verticalMargin:buttonVerticalMargin
                                                                                           width:width
                                                                                          height:height];
            [self adjustOffsetForPositions:positions withX:0 withY:yOffset];
            break;
        }
        case VHButtonPlaceSC_3_4:
        {
            ADD_POINT(0, -buttonVerticalMargin / 2 - height / 2);
            ADD_POINT(-buttonHorizontalMargin / 2 - width / 2, buttonVerticalMargin / 2 + height / 2);
            ADD_POINT(buttonHorizontalMargin / 2 + width / 2, buttonVerticalMargin / 2 + height / 2);
            CGFloat yOffset = [self calculateYOffsetToCenterWithHorizontalMargin:buttonHorizontalMargin
                                                                  verticalMargin:buttonVerticalMargin
                                                                           width:width
                                                                          height:height];
            [self adjustOffsetForPositions:positions withX:0 withY:-yOffset];
            break;
        }
        case VHButtonPlaceSC_4_1:
            ADD_POINT(-buttonHorizontalMargin / 2 - width / 2, -buttonVerticalMargin / 2 - height / 2);
            ADD_POINT(buttonHorizontalMargin / 2 + width / 2, -buttonVerticalMargin / 2 - height / 2);
            ADD_POINT(-buttonHorizontalMargin / 2 - width / 2, buttonVerticalMargin / 2 + height / 2);
            ADD_POINT(buttonHorizontalMargin / 2 + width / 2, buttonVerticalMargin / 2 + height / 2);
            break;
        case VHButtonPlaceSC_4_2:
        {
            ADD_POINT(0, -buttonVerticalMargin / 2 - height / 2);
            ADD_POINT(buttonHorizontalMargin + width, 0);
            ADD_POINT(0, buttonVerticalMargin / 2 + height / 2);
            ADD_POINT(-buttonHorizontalMargin - width, 0);
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
            break;
        }
        case VHButtonPlaceSC_5_1:
        {
            ADD_POINT(-buttonHorizontalMargin - width, -buttonVerticalMargin / 2 - height / 2);
            ADD_POINT(0, -buttonVerticalMargin / 2 - height / 2);
            ADD_POINT(buttonHorizontalMargin + width, -buttonVerticalMargin / 2 - height / 2);
            ADD_POINT(-buttonHorizontalMargin / 2 - width / 2, buttonVerticalMargin / 2 + height / 2);
            ADD_POINT(buttonHorizontalMargin / 2 + width / 2, buttonVerticalMargin / 2 + height / 2);
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
            break;
        }
        case VHButtonPlaceSC_5_2:
        {
            ADD_POINT(-buttonHorizontalMargin / 2 - width / 2, -buttonVerticalMargin / 2 - height / 2);
            ADD_POINT(buttonHorizontalMargin / 2 + width / 2, -buttonVerticalMargin / 2 - height / 2);
            ADD_POINT(-buttonHorizontalMargin - width, buttonVerticalMargin / 2 + height / 2);
            ADD_POINT(0, buttonVerticalMargin / 2 + height / 2);
            ADD_POINT(buttonHorizontalMargin + width, buttonVerticalMargin / 2 + height / 2);
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
            break;
        }
        case VHButtonPlaceSC_5_3:
        {
            ADD_POINT(0, -buttonVerticalMargin - height);
            ADD_POINT(-buttonHorizontalMargin - width, 0);
            ADD_POINT(0, 0);
            ADD_POINT(buttonHorizontalMargin + width, 0);
            ADD_POINT(0, buttonVerticalMargin + height);
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
            break;
        }
        case VHButtonPlaceSC_5_4:
        {
            ADD_POINT(-buttonHorizontalMargin - width, -buttonVerticalMargin / 2 - height / 2);
            ADD_POINT(buttonHorizontalMargin + width, -buttonVerticalMargin / 2 - height / 2);
            ADD_POINT(0, 0);
            ADD_POINT(-buttonHorizontalMargin - width, buttonVerticalMargin / 2 + height / 2);
            ADD_POINT(buttonHorizontalMargin + width, buttonVerticalMargin / 2 + height / 2);
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
            break;
        }
        case VHButtonPlaceSC_6_1:
        {
            ADD_POINT(-buttonHorizontalMargin - width, -buttonVerticalMargin / 2 - height / 2);
            ADD_POINT(0, -buttonVerticalMargin / 2 - height / 2);
            ADD_POINT(buttonHorizontalMargin + width, -buttonVerticalMargin / 2 - height / 2);
            ADD_POINT(-buttonHorizontalMargin - width, buttonVerticalMargin / 2 + height / 2);
            ADD_POINT(0, buttonVerticalMargin / 2 + height / 2);
            ADD_POINT(buttonHorizontalMargin + width, buttonVerticalMargin / 2 + height / 2);
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
            break;
        }
        case VHButtonPlaceSC_6_2:
        {
            ADD_POINT(-buttonHorizontalMargin / 2 - width / 2, -buttonVerticalMargin - height);
            ADD_POINT(-buttonHorizontalMargin / 2 - width / 2, 0);
            ADD_POINT(-buttonHorizontalMargin / 2 - width / 2, buttonVerticalMargin + height);
            ADD_POINT(buttonHorizontalMargin / 2 + width / 2, -buttonVerticalMargin - height);
            ADD_POINT(buttonHorizontalMargin / 2 + width / 2, 0);
            ADD_POINT(buttonHorizontalMargin / 2 + width / 2, buttonVerticalMargin + height);
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
            break;
        }
        case VHButtonPlaceSC_6_3:
        {
            ADD_POINT(-buttonHorizontalMargin / 2 - width / 2, -buttonVerticalMargin - height);
            ADD_POINT(buttonHorizontalMargin / 2 + width / 2, -buttonVerticalMargin - height);
            ADD_POINT(-buttonHorizontalMargin - width, 0);
            ADD_POINT(buttonHorizontalMargin + width, 0);
            ADD_POINT(-buttonHorizontalMargin / 2 - width / 2, buttonVerticalMargin + height);
            ADD_POINT(buttonHorizontalMargin / 2 + width / 2, buttonVerticalMargin + height);
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
            break;
        }
        case VHButtonPlaceSC_6_4:
        {
            ADD_POINT(0, -buttonVerticalMargin - height);
            ADD_POINT(buttonHorizontalMargin + width, -buttonVerticalMargin / 2 - height / 2);
            ADD_POINT(buttonHorizontalMargin + width, buttonVerticalMargin / 2 + height / 2);
            ADD_POINT(0, buttonVerticalMargin + height);
            ADD_POINT(-buttonHorizontalMargin - width, -buttonVerticalMargin / 2 - height / 2);
            ADD_POINT(-buttonHorizontalMargin - width, buttonVerticalMargin / 2 + height / 2);
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
            break;
        }
        case VHButtonPlaceSC_6_5:
        {
            ADD_POINT(-buttonHorizontalMargin - width, -buttonVerticalMargin - height);
            ADD_POINT(0, -buttonVerticalMargin - height);
            ADD_POINT(buttonHorizontalMargin + width, -buttonVerticalMargin - height);
            ADD_POINT(-buttonHorizontalMargin / 2 - width / 2, 0);
            ADD_POINT(buttonHorizontalMargin / 2 + width / 2, 0);
            ADD_POINT(0, buttonVerticalMargin + height);
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
            break;
        }
        case VHButtonPlaceSC_6_6:
        {
            ADD_POINT(0, -buttonVerticalMargin - height);
            ADD_POINT(-buttonHorizontalMargin / 2 - width / 2, 0);
            ADD_POINT(buttonHorizontalMargin / 2 + width / 2, 0);
            ADD_POINT(-buttonHorizontalMargin - width, buttonVerticalMargin + height);
            ADD_POINT(0, buttonVerticalMargin + height);
            ADD_POINT(buttonHorizontalMargin + width, buttonVerticalMargin + height);
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
            break;
        }
        case VHButtonPlaceSC_7_1:
        {
            ADD_POINT(-buttonHorizontalMargin - width, -buttonVerticalMargin - height);
            ADD_POINT(0, -buttonHorizontalMargin - height);
            ADD_POINT(buttonHorizontalMargin + width, -buttonVerticalMargin - height);
            ADD_POINT(-buttonHorizontalMargin - width, 0);
            ADD_POINT(0, 0);
            ADD_POINT(buttonHorizontalMargin + width, 0);
            ADD_POINT(0, buttonHorizontalMargin + height);
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
            break;
        }
        case VHButtonPlaceSC_7_2:
        {
            ADD_POINT(0, -buttonHorizontalMargin - height);
            ADD_POINT(-buttonHorizontalMargin - width, 0);
            ADD_POINT(0, 0);
            ADD_POINT(buttonHorizontalMargin + width, 0);
            ADD_POINT(-buttonHorizontalMargin - width, buttonVerticalMargin + height);
            ADD_POINT(0, buttonHorizontalMargin + height);
            ADD_POINT(buttonHorizontalMargin + width, buttonVerticalMargin + height);
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
            break;
        }
        case VHButtonPlaceSC_7_3:
        {
            ADD_POINT(-buttonHorizontalMargin / 2 - width / 2, -buttonVerticalMargin - height);
            ADD_POINT(buttonHorizontalMargin / 2 + width / 2, -buttonVerticalMargin - height);
            ADD_POINT(-buttonHorizontalMargin - width, 0);
            ADD_POINT(0, 0);
            ADD_POINT(buttonHorizontalMargin + width, 0);
            ADD_POINT(-buttonHorizontalMargin / 2 - width / 2, buttonVerticalMargin + height);
            ADD_POINT(buttonHorizontalMargin / 2 + width / 2, buttonVerticalMargin + height);
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
            break;
        }
        case VHButtonPlaceSC_7_4:
        {
            ADD_POINT(0, -buttonVerticalMargin - height);
            ADD_POINT(buttonHorizontalMargin + width, -buttonVerticalMargin / 2 - height / 2);
            ADD_POINT(buttonHorizontalMargin + width, buttonVerticalMargin / 2 + height / 2);
            ADD_POINT(0, 0);
            ADD_POINT(0, buttonVerticalMargin + height);
            ADD_POINT(-buttonHorizontalMargin - width, -buttonVerticalMargin / 2 - height / 2);
            ADD_POINT(-buttonHorizontalMargin - width, buttonVerticalMargin / 2 + height / 2);
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
            break;
        }
        case VHButtonPlaceSC_7_5:
        {
            ADD_POINT(-buttonHorizontalMargin * 3 / 2 - width * 3 / 2, -buttonVerticalMargin / 2 - height / 2);
            ADD_POINT(-buttonHorizontalMargin / 2 - width / 2, -buttonVerticalMargin / 2 - height / 2);
            ADD_POINT(buttonHorizontalMargin / 2 + width / 2, -buttonVerticalMargin / 2 - height / 2);
            ADD_POINT(buttonHorizontalMargin * 3 / 2 + width * 3 / 2, -buttonVerticalMargin / 2 - height / 2);
            ADD_POINT(-buttonHorizontalMargin - width, buttonVerticalMargin / 2 + height / 2);
            ADD_POINT(0, buttonVerticalMargin / 2 + height / 2);
            ADD_POINT(buttonHorizontalMargin + width, buttonVerticalMargin / 2 + height / 2);
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
            break;
        }
        case VHButtonPlaceSC_7_6:
        {
            ADD_POINT(-buttonHorizontalMargin - width, -buttonVerticalMargin / 2 - height / 2);
            ADD_POINT(0, -buttonVerticalMargin / 2 - height / 2);
            ADD_POINT(buttonHorizontalMargin + width, -buttonVerticalMargin / 2 - height / 2);
            ADD_POINT(-buttonHorizontalMargin * 3 / 2 - width * 3 / 2, buttonVerticalMargin / 2 + height / 2);
            ADD_POINT(-buttonHorizontalMargin / 2 - width / 2, buttonVerticalMargin / 2 + height / 2);
            ADD_POINT(buttonHorizontalMargin / 2 + width / 2, buttonVerticalMargin / 2 + height / 2);
            ADD_POINT(buttonHorizontalMargin * 3 / 2 + width * 3 / 2, buttonVerticalMargin / 2 + height / 2);
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
            break;
        }
        case VHButtonPlaceSC_8_1:
        {
            ADD_POINT(-buttonHorizontalMargin - width, -buttonVerticalMargin - height);
            ADD_POINT(0, -buttonVerticalMargin - height);
            ADD_POINT(buttonHorizontalMargin + width, -buttonVerticalMargin - height);
            ADD_POINT(-buttonHorizontalMargin / 2 - width / 2, 0);
            ADD_POINT(buttonHorizontalMargin / 2 + width / 2, 0);
            ADD_POINT(-buttonHorizontalMargin - width, buttonVerticalMargin + height);
            ADD_POINT(0, buttonVerticalMargin + height);
            ADD_POINT(buttonHorizontalMargin + width, buttonVerticalMargin + height);
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
            break;
        }
        case VHButtonPlaceSC_8_2:
        {
            ADD_POINT(-buttonHorizontalMargin - width, -buttonVerticalMargin - height);
            ADD_POINT(-buttonHorizontalMargin - width, 0);
            ADD_POINT(-buttonHorizontalMargin - width, buttonVerticalMargin + height);
            ADD_POINT(0, -buttonVerticalMargin / 2 - height / 2);
            ADD_POINT(0, buttonVerticalMargin / 2 + height / 2);
            ADD_POINT(buttonHorizontalMargin + width, -buttonVerticalMargin - height);
            ADD_POINT(buttonHorizontalMargin + width, 0);
            ADD_POINT(buttonHorizontalMargin + width, buttonVerticalMargin + height);
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
            break;
        }
        case VHButtonPlaceSC_8_3:
        {
            ADD_POINT(-buttonHorizontalMargin - width, -buttonVerticalMargin - height);
            ADD_POINT(-buttonHorizontalMargin - width, 0);
            ADD_POINT(-buttonHorizontalMargin - width, buttonVerticalMargin + height);
            ADD_POINT(0, -buttonVerticalMargin - height);
            ADD_POINT(0, buttonVerticalMargin + height);
            ADD_POINT(buttonHorizontalMargin + width, -buttonVerticalMargin - height);
            ADD_POINT(buttonHorizontalMargin + width, 0);
            ADD_POINT(buttonHorizontalMargin + width, buttonVerticalMargin + height);
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
            break;
        }
        case VHButtonPlaceSC_8_4:
        {
            ADD_POINT(0, -buttonVerticalMargin * 2 - height * 2);
            ADD_POINT(buttonHorizontalMargin / 2 + width / 2, -buttonVerticalMargin - height);
            ADD_POINT(buttonHorizontalMargin + width, 0);
            ADD_POINT(buttonHorizontalMargin / 2 + width / 2, buttonVerticalMargin + height);
            ADD_POINT(0, buttonVerticalMargin * 2 + height * 2);
            ADD_POINT(-buttonHorizontalMargin / 2 - width / 2, buttonVerticalMargin + height);
            ADD_POINT(-buttonHorizontalMargin - width, 0);
            ADD_POINT(-buttonHorizontalMargin / 2 - width / 2, -buttonVerticalMargin - height);
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
            break;
        }
        case VHButtonPlaceSC_8_5:
        {
            ADD_POINT(0, -buttonVerticalMargin - height);
            ADD_POINT(buttonHorizontalMargin + width, -buttonVerticalMargin / 2 - height / 2);
            ADD_POINT(buttonHorizontalMargin * 2 + width * 2, 0);
            ADD_POINT(buttonHorizontalMargin + width, buttonVerticalMargin / 2 + height / 2);
            ADD_POINT(0, buttonVerticalMargin + height);
            ADD_POINT(-buttonHorizontalMargin - width, buttonVerticalMargin / 2 + height / 2);
            ADD_POINT(-buttonHorizontalMargin * 2 - width * 2, 0);
            ADD_POINT(-buttonHorizontalMargin - width, -buttonVerticalMargin / 2 - height / 2);
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
            break;
        }
        case VHButtonPlaceSC_8_6:
        {
            ADD_POINT(-buttonHorizontalMargin * 3 / 2 - width * 3 / 2, -buttonVerticalMargin / 2 - height / 2);
            ADD_POINT(-buttonHorizontalMargin / 2 - width / 2, -buttonVerticalMargin / 2 - height / 2);
            ADD_POINT(buttonHorizontalMargin / 2 + width / 2, -buttonVerticalMargin / 2 - height / 2);
            ADD_POINT(buttonHorizontalMargin * 3 / 2 + width * 3 / 2, -buttonVerticalMargin / 2 - height / 2);
            ADD_POINT(-buttonHorizontalMargin * 3 / 2 - width * 3 / 2, buttonVerticalMargin / 2 + height / 2);
            ADD_POINT(-buttonHorizontalMargin / 2 - width / 2, buttonVerticalMargin / 2 + height / 2);
            ADD_POINT(buttonHorizontalMargin / 2 + width / 2, buttonVerticalMargin / 2 + height / 2);
            ADD_POINT(buttonHorizontalMargin * 3 / 2 + width * 3 / 2, buttonVerticalMargin / 2 + height / 2);
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
            break;
        }
        case VHButtonPlaceSC_8_7:
        {
            ADD_POINT(-buttonHorizontalMargin / 2 - width / 2, -buttonVerticalMargin * 3 / 2 - height * 3 / 2);
            ADD_POINT(-buttonHorizontalMargin / 2 - width / 2, -buttonVerticalMargin / 2 - height / 2);
            ADD_POINT(-buttonHorizontalMargin / 2 - width / 2, buttonVerticalMargin / 2 + height / 2);
            ADD_POINT(-buttonHorizontalMargin / 2 - width / 2, buttonVerticalMargin * 3 / 2 + height * 3 / 2);
            ADD_POINT(buttonHorizontalMargin / 2 + width / 2, -buttonVerticalMargin * 3 / 2 - height * 3 / 2);
            ADD_POINT(buttonHorizontalMargin / 2 + width / 2, -buttonVerticalMargin / 2 - height / 2);
            ADD_POINT(buttonHorizontalMargin / 2 + width / 2, buttonVerticalMargin / 2 + height / 2);
            ADD_POINT(buttonHorizontalMargin / 2 + width / 2, buttonVerticalMargin * 3 / 2 + height * 3 / 2);
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
            break;
        }
        case VHButtonPlaceSC_9_1:
        {
            ADD_POINT(-buttonHorizontalMargin - width, -buttonVerticalMargin - height);
            ADD_POINT(-buttonHorizontalMargin - width, 0);
            ADD_POINT(-buttonHorizontalMargin - width, buttonVerticalMargin + height);
            ADD_POINT(0, -buttonVerticalMargin - height);
            ADD_POINT(0, 0);
            ADD_POINT(0, buttonVerticalMargin + height);
            ADD_POINT(buttonHorizontalMargin + width, -buttonVerticalMargin - height);
            ADD_POINT(buttonHorizontalMargin + width, 0);
            ADD_POINT(buttonHorizontalMargin + width, buttonVerticalMargin + height);
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
            break;
        }
        case VHButtonPlaceSC_9_2:
        {
            ADD_POINT(0, -buttonVerticalMargin * 2 - height * 2);
            ADD_POINT(buttonHorizontalMargin / 2 + width / 2, -buttonVerticalMargin - height);
            ADD_POINT(buttonHorizontalMargin + width, 0);
            ADD_POINT(buttonHorizontalMargin / 2 + width / 2, buttonVerticalMargin + height);
            ADD_POINT(0, buttonVerticalMargin * 2 + height * 2);
            ADD_POINT(-buttonHorizontalMargin / 2 - width / 2, buttonVerticalMargin + height);
            ADD_POINT(-buttonHorizontalMargin - width, 0);
            ADD_POINT(-buttonHorizontalMargin / 2 - width / 2, -buttonVerticalMargin - height);
            ADD_POINT(0, 0);
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
            break;
        }
        case VHButtonPlaceSC_9_3:
        {
            ADD_POINT(0, -buttonVerticalMargin - height);
            ADD_POINT(buttonHorizontalMargin + width, -buttonVerticalMargin / 2 - height / 2);
            ADD_POINT(buttonHorizontalMargin * 2 + width * 2, 0);
            ADD_POINT(buttonHorizontalMargin + width, buttonVerticalMargin / 2 + height / 2);
            ADD_POINT(0, buttonVerticalMargin + height);
            ADD_POINT(-buttonHorizontalMargin - width, buttonVerticalMargin / 2 + height / 2);
            ADD_POINT(-buttonHorizontalMargin * 2 - width * 2, 0);
            ADD_POINT(-buttonHorizontalMargin - width, -buttonVerticalMargin / 2 - height / 2);
            ADD_POINT(0, 0);
            [self adjustOffsetForPositions:positions withX:0 withY:(height - width) / 2];
            break;
        }
        default:
            NSAssert(NO, @"Button place enum not found!");
            break;
    }
    
    for (int i = 0; i < positions.count; i++)
    {
        CGPoint point = [[positions objectAtIndex:i] CGPointValue];
        [positions setObject:[NSValue valueWithCGPoint:CGPointMake(point.x + frame.size.width / 2,
                                                                   point.y + frame.size.height / 2)] atIndexedSubscript:i];
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
        case VHButtonPlaceAlignmentTopLeft:
            heightOffset = height / 2 + buttonTopMargin - minHeight;
            widthOffset = width / 2 + buttonLeftMargin - minWidth;
            break;
        case VHButtonPlaceAlignmentTopRight:
            heightOffset = height / 2 + buttonTopMargin - minHeight;
            widthOffset = frame.size.width - width / 2 - maxWidth - buttonRightMargin;
            break;
        case VHButtonPlaceAlignmentBottomLeft:
            heightOffset = frame.size.height - height / 2 - maxHeight - buttonBottomMargin;
            widthOffset = width / 2 + buttonLeftMargin - minWidth;
            break;
        case VHButtonPlaceAlignmentBottomRight:
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

+ (NSMutableArray<NSValue *> *)positionsWithEnum:(VHButtonPlaceEnum)placeEnum
                                   withAlignment:(VHButtonPlaceAlignmentEnum)alignmentEnum
                                 withParentFrame:(CGRect)parentFrame
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
        case VHButtonPlaceHorizontal:
        {
            if (buttonNumber % 2 == 0)
            {
                long half = buttonNumber / 2;
                for (long i = half - 1; i >= 0; i--)
                {
                    ADD_POINT(-radius - buttonHorizontalMargin / 2 - i * (2 * radius + buttonHorizontalMargin), 0);
                }
                for (int i = 0; i < half; i++)
                {
                    ADD_POINT(radius + buttonHorizontalMargin / 2 + i * (2 * radius + buttonHorizontalMargin), 0);
                }
            }
            else
            {
                long half = buttonNumber / 2;
                for (long i = half - 1; i >= 0; i--)
                {
                    ADD_POINT(-2 * radius - buttonHorizontalMargin - i * (2 * radius + buttonHorizontalMargin), 0);
                }
                ADD_POINT(0, 0);
                for (int i = 0; i < half; i++)
                {
                    ADD_POINT(2 * radius + buttonHorizontalMargin + i * (2 * radius + buttonHorizontalMargin), 0);
                }
            }
            break;
        }
        case VHButtonPlaceVertical:
        {
            if (buttonNumber % 2 == 0)
            {
                long half = buttonNumber / 2;
                for (long i = half - 1; i >= 0; i--)
                {
                    ADD_POINT(0, -radius - buttonVerticalMargin / 2 - i * (2 * radius + buttonVerticalMargin));
                }
                for (int i = 0; i < half; i++)
                {
                    ADD_POINT(0, radius + buttonVerticalMargin / 2 + i * (2 * radius + buttonVerticalMargin));
                }
            }
            else
            {
                long half = buttonNumber / 2;
                for (long i = half - 1; i >= 0; i--)
                {
                    ADD_POINT(0, -2 * radius - buttonVerticalMargin - i * (2 * radius + buttonVerticalMargin));
                }
                ADD_POINT(0, 0);
                for (int i = 0; i < half; i++)
                {
                    ADD_POINT(0, 2 * radius + buttonVerticalMargin + i * (2 * radius + buttonVerticalMargin));
                }
            }
            break;
        }
        case VHButtonPlaceSC_1:
            ADD_POINT(0, 0);
            break;
        case VHButtonPlaceSC_2_1:
            ADD_POINT(-buttonHorizontalMargin / 2 - radius, 0);
            ADD_POINT(buttonHorizontalMargin / 2 + radius, 0);
            break;
        case VHButtonPlaceSC_2_2:
            ADD_POINT(0, -buttonVerticalMargin / 2 - radius);
            ADD_POINT(0, buttonVerticalMargin / 2 + radius);
            break;
        case VHButtonPlaceSC_3_1:
            ADD_POINT(-buttonHorizontalMargin - 2 * radius, 0);
            ADD_POINT(0, 0);
            ADD_POINT(buttonHorizontalMargin + 2 * radius, 0);
            break;
        case VHButtonPlaceSC_3_2:
            ADD_POINT(0, -buttonVerticalMargin - 2 * radius);
            ADD_POINT(0, 0);
            ADD_POINT(0, buttonVerticalMargin + 2 * radius);
            break;
        case VHButtonPlaceSC_3_3:
        {
            CGFloat a, b, c;
            b = buttonHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            ADD_POINT(-b, -a);
            ADD_POINT(b, -a);
            ADD_POINT(0, c);
            break;
        }
        case VHButtonPlaceSC_3_4:
        {
            CGFloat a, b, c;
            b = buttonHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            ADD_POINT(0, -c);
            ADD_POINT(-b, a);
            ADD_POINT(b, a);
            break;
        }
        case VHButtonPlaceSC_4_1:
            ADD_POINT(-buttonHorizontalMargin / 2 - radius, -buttonVerticalMargin / 2 - radius);
            ADD_POINT(buttonHorizontalMargin / 2 + radius, -buttonVerticalMargin / 2 - radius);
            ADD_POINT(-buttonHorizontalMargin / 2 - radius, buttonVerticalMargin / 2 + radius);
            ADD_POINT(buttonHorizontalMargin / 2 + radius, buttonVerticalMargin / 2 + radius);
            break;
        case VHButtonPlaceSC_4_2:
        {
            CGFloat a = (2 * radius + buttonInclinedMargin) / sqrt(2);
            ADD_POINT(0, -a);
            ADD_POINT(a, 0);
            ADD_POINT(0, a);
            ADD_POINT(-a, 0);
            break;
        }
        case VHButtonPlaceSC_5_1:
        {
            CGFloat a, b, c;
            b = buttonHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            ADD_POINT(-2 * b, -c);
            ADD_POINT(0, -c);
            ADD_POINT(2 * b, -c);
            ADD_POINT(-buttonHorizontalMargin / 2 - radius, a);
            ADD_POINT(buttonHorizontalMargin / 2 + radius, a);
            break;
        }
        case VHButtonPlaceSC_5_2:
        {
            CGFloat a, b, c;
            b = buttonHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            ADD_POINT(-buttonHorizontalMargin / 2 - radius, -a);
            ADD_POINT(buttonHorizontalMargin / 2 + radius, -a);
            ADD_POINT(-2 * b, c);
            ADD_POINT(0, c);
            ADD_POINT(2 * b, c);
            break;
        }
        case VHButtonPlaceSC_5_3:
        {
            ADD_POINT(0, 0);
            ADD_POINT(0, -buttonVerticalMargin - 2 * radius);
            ADD_POINT(buttonHorizontalMargin + 2 * radius, 0);
            ADD_POINT(0, buttonVerticalMargin + 2 * radius);
            ADD_POINT(-buttonHorizontalMargin - 2 * radius, 0);
            break;
        }
        case VHButtonPlaceSC_5_4:
        {
            CGFloat a = (2 * radius + buttonInclinedMargin) / sqrt(2);
            ADD_POINT(0, 0);
            ADD_POINT(a, -a);
            ADD_POINT(a, a);
            ADD_POINT(-a, a);
            ADD_POINT(-a, -a);
            break;
        }
        case VHButtonPlaceSC_6_1:
        {
            ADD_POINT(-buttonHorizontalMargin - 2 * radius, -buttonVerticalMargin / 2 - radius);
            ADD_POINT(0, -buttonVerticalMargin / 2 - radius);
            ADD_POINT(buttonHorizontalMargin + 2 * radius, -buttonVerticalMargin / 2 - radius);
            ADD_POINT(-buttonHorizontalMargin - 2 * radius, buttonVerticalMargin / 2 + radius);
            ADD_POINT(0, buttonVerticalMargin / 2 + radius);
            ADD_POINT(buttonHorizontalMargin + 2 * radius, buttonVerticalMargin / 2 + radius);
            break;
        }
        case VHButtonPlaceSC_6_2:
        {
            ADD_POINT(-buttonHorizontalMargin / 2 - radius, -buttonVerticalMargin - 2 * radius);
            ADD_POINT(-buttonHorizontalMargin / 2 - radius, 0);
            ADD_POINT(-buttonHorizontalMargin / 2 - radius, buttonVerticalMargin + 2 * radius);
            ADD_POINT(buttonHorizontalMargin / 2 + radius, -buttonVerticalMargin - 2 * radius);
            ADD_POINT(buttonHorizontalMargin / 2 + radius, 0);
            ADD_POINT(buttonHorizontalMargin / 2 + radius, buttonVerticalMargin + 2 * radius);
            break;
        }
        case VHButtonPlaceSC_6_3:
        {
            CGFloat a, b, c;
            b = buttonHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            ADD_POINT(-b, -a - c);
            ADD_POINT(b, -a - c);
            ADD_POINT(2 * b, 0);
            ADD_POINT(b, a + c);
            ADD_POINT(-b, a + c);
            ADD_POINT(-2 * b, 0);
            break;
        }
        case VHButtonPlaceSC_6_4:
        {
            CGFloat a, b, c;
            b = buttonHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            ADD_POINT(0, -2 * b);
            ADD_POINT(a + c, -b);
            ADD_POINT(a + c, b);
            ADD_POINT(0, 2 * b);
            ADD_POINT(-a - c, b);
            ADD_POINT(-a - c, -b);
        }
            break;
        case VHButtonPlaceSC_6_5:
        {
            CGFloat a, b, c, yOffset;
            b = buttonHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            yOffset = c - a;
            ADD_POINT(-2 * b, -a - c + yOffset);
            ADD_POINT(0, -a - c + yOffset);
            ADD_POINT(2 * b, -a - c + yOffset);
            ADD_POINT(-buttonHorizontalMargin / 2 - radius, 0 + yOffset);
            ADD_POINT(buttonHorizontalMargin / 2 + radius, 0 + yOffset);
            ADD_POINT(0, a + c + yOffset);
            break;
        }
        case VHButtonPlaceSC_6_6:
        {
            CGFloat a, b, c, yOffset;
            b = buttonHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            yOffset = c - a;
            ADD_POINT(0, -a - c - yOffset);
            ADD_POINT(-buttonHorizontalMargin / 2 - radius, 0 - yOffset);
            ADD_POINT(buttonHorizontalMargin / 2 + radius, 0 - yOffset);
            ADD_POINT(-2 * b, a + c - yOffset);
            ADD_POINT(0, a + c - yOffset);
            ADD_POINT(2 * b, a + c - yOffset);
            break;
        }
        case VHButtonPlaceSC_7_1:
        {
            ADD_POINT(-buttonHorizontalMargin - 2 * radius, -buttonVerticalMargin - 2 * radius);
            ADD_POINT(0, -buttonVerticalMargin - 2 * radius);
            ADD_POINT(buttonHorizontalMargin + 2 * radius, -buttonVerticalMargin - 2 * radius);
            ADD_POINT(-buttonHorizontalMargin - 2 * radius, 0);
            ADD_POINT(0, 0);
            ADD_POINT(buttonHorizontalMargin + 2 * radius, 0);
            ADD_POINT(0, buttonVerticalMargin + 2 * radius);
            break;
        }
        case VHButtonPlaceSC_7_2:
        {
            ADD_POINT(0, -buttonVerticalMargin - 2 * radius);
            ADD_POINT(-buttonHorizontalMargin - 2 * radius, 0);
            ADD_POINT(0, 0);
            ADD_POINT(buttonHorizontalMargin + 2 * radius, 0);
            ADD_POINT(-buttonHorizontalMargin - 2 * radius, buttonVerticalMargin + 2 * radius);
            ADD_POINT(0, buttonVerticalMargin + 2 * radius);
            ADD_POINT(buttonHorizontalMargin + 2 * radius, buttonVerticalMargin + 2 * radius);
            break;
        }
        case VHButtonPlaceSC_7_3:
        {
            CGFloat a, b, c;
            b = buttonHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            ADD_POINT(0, 0);
            ADD_POINT(-b, -a - c);
            ADD_POINT(b, -a - c);
            ADD_POINT(2 * b, 0);
            ADD_POINT(b, a + c);
            ADD_POINT(-b, a + c);
            ADD_POINT(-2 * b, 0);
            break;
        }
        case VHButtonPlaceSC_7_4:
        {
            CGFloat a, b, c;
            b = buttonHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            ADD_POINT(0, 0);
            ADD_POINT(0, -2 * b);
            ADD_POINT(a + c, -b);
            ADD_POINT(a + c, b);
            ADD_POINT(0, 2 * b);
            ADD_POINT(-a - c, b);
            ADD_POINT(-a - c, -b);
            break;
        }
        case VHButtonPlaceSC_7_5:
        {
            CGFloat a, b, c;
            b = buttonHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            ADD_POINT(-3 * b, -a);
            ADD_POINT(-b, -a);
            ADD_POINT(b, -a);
            ADD_POINT(3 * b, -a);
            ADD_POINT(-2 * b, c);
            ADD_POINT(0, c);
            ADD_POINT(2 * b, c);
            break;
        }
        case VHButtonPlaceSC_7_6:
        {
            CGFloat a, b, c;
            b = buttonHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            ADD_POINT(-2 * b, -c);
            ADD_POINT(0, -c);
            ADD_POINT(2 * b, -c);
            ADD_POINT(-3 * b, a);
            ADD_POINT(-b, a);
            ADD_POINT(b, a);
            ADD_POINT(3 * b, a);
            break;
        }
        case VHButtonPlaceSC_8_1:
        {
            CGFloat a, b, c;
            b = buttonHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            ADD_POINT(-2 * b, -a - c);
            ADD_POINT(0, -a - c);
            ADD_POINT(2 * b, -a - c);
            ADD_POINT(-buttonHorizontalMargin / 2 - radius, 0);
            ADD_POINT(buttonHorizontalMargin / 2 + radius, 0);
            ADD_POINT(-2 * b, a + c);
            ADD_POINT(0, a + c);
            ADD_POINT(2 * b, a + c);
            break;
        }
        case VHButtonPlaceSC_8_2:
        {
            CGFloat a, b, c;
            b = buttonVerticalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            ADD_POINT(-a - c, -2 * b);
            ADD_POINT(-a - c, 0);
            ADD_POINT(-a - c, 2 * b);
            ADD_POINT(0, -buttonVerticalMargin / 2 - radius);
            ADD_POINT(0, buttonVerticalMargin / 2 + radius);
            ADD_POINT(a + c, -2 * b);
            ADD_POINT(a + c, 0);
            ADD_POINT(a + c, 2 * b);
            break;
        }
        case VHButtonPlaceSC_8_3:
        {
            ADD_POINT(-buttonHorizontalMargin - 2 * radius, -buttonVerticalMargin - 2 * radius);
            ADD_POINT(0, -buttonVerticalMargin - 2 * radius);
            ADD_POINT(buttonHorizontalMargin + 2 * radius, -buttonVerticalMargin - 2 * radius);
            ADD_POINT(-buttonHorizontalMargin - 2 * radius, 0);
            ADD_POINT(buttonHorizontalMargin + 2 * radius, 0);
            ADD_POINT(-buttonHorizontalMargin - 2 * radius, buttonVerticalMargin + 2 * radius);
            ADD_POINT(0, buttonVerticalMargin + 2 * radius);
            ADD_POINT(buttonHorizontalMargin + 2 * radius, buttonVerticalMargin + 2 * radius);
            break;
        }
        case VHButtonPlaceSC_8_4:
        {
            CGFloat a, b, c;
            b = buttonHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            ADD_POINT(0, -2 * a - 2 * c);
            ADD_POINT(-buttonHorizontalMargin / 2 - radius, -a - c);
            ADD_POINT(buttonHorizontalMargin / 2 + radius, -a - c);
            ADD_POINT(-2 * b, 0);
            ADD_POINT(2 * b, 0);
            ADD_POINT(-buttonHorizontalMargin / 2 - radius, a + c);
            ADD_POINT(buttonHorizontalMargin / 2 + radius, a + c);
            ADD_POINT(0, 2 * a + 2 * c);
            break;
        }
        case VHButtonPlaceSC_8_5:
        {
            CGFloat a = (2 * radius + buttonInclinedMargin) / sqrt(2);
            ADD_POINT(0, -2 * a);
            ADD_POINT(a, -a);
            ADD_POINT(2 * a, 0);
            ADD_POINT(a, a);
            ADD_POINT(0, 2 * a);
            ADD_POINT(-a, a);
            ADD_POINT(-2 * a, 0);
            ADD_POINT(-a, -a);
            break;
        }
        case VHButtonPlaceSC_8_6:
        {
            ADD_POINT(-buttonHorizontalMargin * 3 / 2 - 3 * radius, -buttonVerticalMargin / 2 - radius);
            ADD_POINT(-buttonHorizontalMargin / 2 - radius, -buttonVerticalMargin / 2 - radius);
            ADD_POINT(buttonHorizontalMargin / 2 + radius, -buttonVerticalMargin / 2 - radius);
            ADD_POINT(buttonHorizontalMargin * 3 / 2 + 3 * radius, -buttonVerticalMargin / 2 - radius);
            ADD_POINT(-buttonHorizontalMargin * 3 / 2 - 3 * radius, buttonVerticalMargin / 2 + radius);
            ADD_POINT(-buttonHorizontalMargin / 2 - radius, buttonVerticalMargin / 2 + radius);
            ADD_POINT(buttonHorizontalMargin / 2 + radius, buttonVerticalMargin / 2 + radius);
            ADD_POINT(buttonHorizontalMargin * 3 / 2 + 3 * radius, buttonVerticalMargin / 2 + radius);
            break;
        }
        case VHButtonPlaceSC_8_7:
        {
            ADD_POINT(-buttonHorizontalMargin / 2 - radius, -buttonVerticalMargin * 3 / 2 - 3 * radius);
            ADD_POINT(buttonHorizontalMargin / 2 + radius, -buttonVerticalMargin * 3 / 2 - 3 * radius);
            ADD_POINT(-buttonHorizontalMargin / 2 - radius, -buttonVerticalMargin / 2 - radius);
            ADD_POINT(buttonHorizontalMargin / 2 + radius, -buttonVerticalMargin / 2 - radius);
            ADD_POINT(-buttonHorizontalMargin / 2 - radius, buttonVerticalMargin / 2 + radius);
            ADD_POINT(buttonHorizontalMargin / 2 + radius, buttonVerticalMargin / 2 + radius);
            ADD_POINT(-buttonHorizontalMargin / 2 - radius, buttonVerticalMargin * 3 / 2 + 3 * radius);
            ADD_POINT(buttonHorizontalMargin / 2 + radius, buttonVerticalMargin * 3 / 2 + 3 * radius);
            break;
        }
        case VHButtonPlaceSC_9_1:
        {
            ADD_POINT(-buttonHorizontalMargin - 2 * radius, -buttonVerticalMargin - 2 * radius);
            ADD_POINT(0, -buttonVerticalMargin - 2 * radius);
            ADD_POINT(buttonHorizontalMargin + 2 * radius, -buttonVerticalMargin - 2 * radius);
            ADD_POINT(-buttonHorizontalMargin - 2 * radius, 0);
            ADD_POINT(0, 0);
            ADD_POINT(buttonHorizontalMargin + 2 * radius, 0);
            ADD_POINT(-buttonHorizontalMargin - 2 * radius, buttonVerticalMargin + 2 * radius);
            ADD_POINT(0, buttonVerticalMargin + 2 * radius);
            ADD_POINT(buttonHorizontalMargin + 2 * radius, buttonVerticalMargin + 2 * radius);
            break;
        }
        case VHButtonPlaceSC_9_2:
        {
            CGFloat a, b, c;
            b = buttonHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            ADD_POINT(0, -2 * a - 2 * c);
            ADD_POINT(-buttonHorizontalMargin / 2 - radius, -a - c);
            ADD_POINT(buttonHorizontalMargin / 2 + radius, -a - c);
            ADD_POINT(-2 * b, 0);
            ADD_POINT(0, 0);
            ADD_POINT(2 * b, 0);
            ADD_POINT(-buttonHorizontalMargin / 2 - radius, a + c);
            ADD_POINT(buttonHorizontalMargin / 2 + radius, a + c);
            ADD_POINT(0, 2 * a + 2 * c);
            break;
        }
        case VHButtonPlaceSC_9_3:
        {
            CGFloat a = (2 * radius + buttonInclinedMargin) / sqrt(2);
            ADD_POINT(0, -2 * a);
            ADD_POINT(a, -a);
            ADD_POINT(2 * a, 0);
            ADD_POINT(a, a);
            ADD_POINT(0, 0);
            ADD_POINT(0, 2 * a);
            ADD_POINT(-a, a);
            ADD_POINT(-2 * a, 0);
            ADD_POINT(-a, -a);
            break;
        }
        default:
            NSAssert(NO, @"Button place enum not found!");
            break;
    }

    for (int i = 0; i < positions.count; i++)
    {
        CGPoint point = [[positions objectAtIndex:i] CGPointValue];
        [positions setObject:[NSValue valueWithCGPoint:CGPointMake(point.x + parentFrame.size.width / 2,
                                                                   point.y + parentFrame.size.height / 2)] atIndexedSubscript:i];
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
            heightOffset = parentFrame.size.height - radius - maxHeight - buttonBottomMargin;
            break;
        case VHButtonPlaceAlignmentLeft:
            widthOffset = radius + buttonLeftMargin - minWidth;
            break;
        case VHButtonPlaceAlignmentRight:
            widthOffset = parentFrame.size.width - radius - maxWidth - buttonRightMargin;
            break;
        case VHButtonPlaceAlignmentTopLeft:
            heightOffset = radius + buttonTopMargin - minHeight;
            widthOffset = radius + buttonLeftMargin - minWidth;
            break;
        case VHButtonPlaceAlignmentTopRight:
            heightOffset = radius + buttonTopMargin - minHeight;
            widthOffset = parentFrame.size.width - radius - maxWidth - buttonRightMargin;
            break;
        case VHButtonPlaceAlignmentBottomLeft:
            heightOffset = parentFrame.size.height - radius - maxHeight - buttonBottomMargin;
            widthOffset = radius + buttonLeftMargin - minWidth;
            break;
        case VHButtonPlaceAlignmentBottomRight:
            heightOffset = parentFrame.size.height - radius - maxHeight - buttonBottomMargin;
            widthOffset = parentFrame.size.width - radius - maxWidth - buttonRightMargin;
            break;
    }
    for (int i = 0; i < positions.count; i++)
    {
        CGPoint point = [[positions objectAtIndex:i] CGPointValue];
        [positions setObject:[NSValue valueWithCGPoint:CGPointMake(point.x + widthOffset, point.y + heightOffset)] atIndexedSubscript:i];
    }
    
    return positions;
}

+ (NSMutableArray<NSValue *> *)positionsForHamWithEnum:(VHButtonPlaceEnum)placeEnum
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
        case VHButtonPlaceHorizontal:
        {
            if (buttonNumber % 2 == 0)
            {
                long half = buttonNumber / 2;
                for (long i = half - 1; i >= 0; i--)
                {
                    ADD_POINT(-width / 2 - buttonHorizontalMargin / 2 - i * (width + buttonHorizontalMargin), 0);
                }
                for (int i = 0; i < half; i++)
                {
                    ADD_POINT(width / 2 + buttonHorizontalMargin / 2 + i * (width + buttonHorizontalMargin), 0);
                }
            }
            else
            {
                long half = buttonNumber / 2;
                for (long i = half - 1; i >= 0; i--)
                {
                    ADD_POINT(-width - buttonHorizontalMargin - i * (width + buttonHorizontalMargin), 0);
                }
                ADD_POINT(0,     0);
                for (int i = 0; i < half; i++)
                {
                    ADD_POINT(width + buttonHorizontalMargin + i * (width + buttonHorizontalMargin), 0);
                }
            }
            break;
        }
        case VHButtonPlaceVertical:
        {
            if (buttonNumber % 2 == 0)
            {
                long half = buttonNumber / 2;
                for (long i = half - 1; i >= 0; i--)
                {
                    ADD_POINT(0, -height / 2 - buttonHorizontalMargin / 2 - i * (height + buttonHorizontalMargin));
                }
                for (int i = 0; i < half; i++)
                {
                    ADD_POINT(0, height / 2 + buttonHorizontalMargin / 2 + i * (height + buttonHorizontalMargin));
                }
            }
            else
            {
                long half = buttonNumber / 2;
                for (long i = half - 1; i >= 0; i--)
                {
                    ADD_POINT(0, -height - buttonVerticalMargin - i * (height + buttonVerticalMargin));
                }
                ADD_POINT(0,     0);
                for (int i = 0; i < half; i++)
                {
                    ADD_POINT(0, height + buttonVerticalMargin + i * (height + buttonVerticalMargin));
                }
            }
            break;
        }
        case VHButtonPlaceHAM_1:
            ADD_POINT(0, 0);
            break;
        case VHButtonPlaceHAM_2:
            ADD_POINT(0, -buttonVerticalMargin / 2 - height / 2);
            ADD_POINT(0, buttonVerticalMargin / 2 + height / 2);
            break;
        case VHButtonPlaceHAM_3:
            ADD_POINT(0, -buttonVerticalMargin - height);
            ADD_POINT(0, 0);
            ADD_POINT(0, buttonVerticalMargin + height);
        case VHButtonPlaceHAM_4:
            ADD_POINT(0, -buttonVerticalMargin * 3 / 2 - height * 3 / 2);
            ADD_POINT(0, -buttonVerticalMargin / 2 - height / 2);
            ADD_POINT(0, buttonVerticalMargin / 2 + height / 2);
            ADD_POINT(0, buttonVerticalMargin * 3 / 2 + height * 3 / 2);
            break;
        case VHButtonPlaceHAM_5:
            ADD_POINT(0, -buttonVerticalMargin * 2 - height * 2);
            ADD_POINT(0, -buttonVerticalMargin - height);
            ADD_POINT(0, 0);
            ADD_POINT(0, buttonVerticalMargin + height);
            ADD_POINT(0, buttonVerticalMargin * 2 + height * 2);
            break;
        case VHButtonPlaceHAM_6:
            ADD_POINT(0, -buttonVerticalMargin * 5 / 2 - height * 5 / 2);
            ADD_POINT(0, -buttonVerticalMargin * 3 / 2 - height * 3 / 2);
            ADD_POINT(0, -buttonVerticalMargin / 2 - height / 2);
            ADD_POINT(0, buttonVerticalMargin / 2 + height / 2);
            ADD_POINT(0, buttonVerticalMargin * 3 / 2 + height * 3 / 2);
            ADD_POINT(0, buttonVerticalMargin * 5 / 2 + height * 5 / 2);
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
        case VHButtonPlaceAlignmentTopLeft:
            heightOffset = height / 2 + buttonTopMargin - minHeight;
            widthOffset = width / 2 + buttonLeftMargin - minWidth;
            break;
        case VHButtonPlaceAlignmentTopRight:
            heightOffset = height / 2 + buttonTopMargin - minHeight;
            widthOffset = frame.size.width - width / 2 - maxWidth - buttonRightMargin;
            break;
        case VHButtonPlaceAlignmentBottomLeft:
            heightOffset = frame.size.height - height / 2 - maxHeight - buttonBottomMargin;
            widthOffset = width / 2 + buttonLeftMargin - minWidth;
            break;
        case VHButtonPlaceAlignmentBottomRight:
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

+ (NSInteger)buttonNumber:(VHButtonPlaceEnum)placeEnum
{
    switch (placeEnum)
    {
        case VHButtonPlaceSC_1:
        case VHButtonPlaceHAM_1:
            return 1;
        case VHButtonPlaceSC_2_1:
        case VHButtonPlaceSC_2_2:
        case VHButtonPlaceHAM_2:
            return 2;
        case VHButtonPlaceSC_3_1:
        case VHButtonPlaceSC_3_2:
        case VHButtonPlaceSC_3_3:
        case VHButtonPlaceSC_3_4:
        case VHButtonPlaceHAM_3:
            return 3;
        case VHButtonPlaceSC_4_1:
        case VHButtonPlaceSC_4_2:
        case VHButtonPlaceHAM_4:
            return 4;
        case VHButtonPlaceSC_5_1:
        case VHButtonPlaceSC_5_2:
        case VHButtonPlaceSC_5_3:
        case VHButtonPlaceSC_5_4:
        case VHButtonPlaceHAM_5:
            return 5;
        case VHButtonPlaceSC_6_1:
        case VHButtonPlaceSC_6_2:
        case VHButtonPlaceSC_6_3:
        case VHButtonPlaceSC_6_4:
        case VHButtonPlaceSC_6_5:
        case VHButtonPlaceSC_6_6:
        case VHButtonPlaceHAM_6:
            return 6;
        case VHButtonPlaceSC_7_1:
        case VHButtonPlaceSC_7_2:
        case VHButtonPlaceSC_7_3:
        case VHButtonPlaceSC_7_4:
        case VHButtonPlaceSC_7_5:
        case VHButtonPlaceSC_7_6:
            return 7;
        case VHButtonPlaceSC_8_1:
        case VHButtonPlaceSC_8_2:
        case VHButtonPlaceSC_8_3:
        case VHButtonPlaceSC_8_4:
        case VHButtonPlaceSC_8_5:
        case VHButtonPlaceSC_8_6:
        case VHButtonPlaceSC_8_7:
            return 8;
        case VHButtonPlaceSC_9_1:
        case VHButtonPlaceSC_9_2:
        case VHButtonPlaceSC_9_3:
            return 9;
        case VHButtonPlaceHorizontal:
        case VHButtonPlaceVertical:
            return LONG_MAX;
        default:
            return -1;
    }
}

+ (CGFloat)calculateYOffsetToCenterWithHorizontalMargin:(CGFloat)hm verticalMargin:(CGFloat)vm width:(CGFloat)w height:(CGFloat)h
{
    return (hm / 2 + w / 2) * (hm / 2 + w / 2) / (vm + h);
}

+ (void)adjustOffsetForPositions:(NSMutableArray<NSValue *> *)positions withX:(CGFloat)x withY:(CGFloat)y
{
    for (int i = 0; i < positions.count; i++)
    {
        CGPoint point = [[positions objectAtIndex:i] CGPointValue];
        [positions setObject:[NSValue valueWithCGPoint:CGPointMake(point.x + x, point.y + y)] atIndexedSubscript:i];
    }
}

@end
