//
//  VHButtonPlaceManager.m
//  VHBoomMenuExample
//
//  Created by Nightonke on 16/7/29.
//  Copyright © 2016 Nightonke. All rights reserved.
//

#import "VHButtonPlaceManager.h"

#define addPosition(a, b) [positions addObject:[NSValue valueWithCGPoint:CGPointMake(a, b)]];

@implementation VHButtonPlaceManager

+ (NSMutableArray<NSValue *> *)positionsWithParentFrame:(CGRect)parentFrame
                                        withButtonWidth:(CGFloat)buttonWidth
                                       withButtonHeight:(CGFloat)buttonHeight
                                       withButtonNumber:(long)buttonNumber
                                     withBoomMenuButton:(VHBoomMenuButton *)bmb
{
    NSMutableArray *positions = [NSMutableArray array];
    
    CGFloat hm = bmb.buttonHorizontalMargin;
    CGFloat hm_0_5 = hm / 2;
    CGFloat hm_1_5 = hm * 1.5;
    CGFloat hm_2_0 = hm * 2;
    
    CGFloat vm = bmb.buttonVerticalMargin;
    CGFloat vm_0_5 = vm / 2;
    CGFloat vm_1_5 = vm * 1.5;
    CGFloat vm_2_0 = vm * 2;
    
    CGFloat w = buttonWidth;
    CGFloat w_0_5 = w / 2;
    CGFloat w_1_5 = w * 1.5;
    CGFloat w_2_0 = w * 2;
    
    CGFloat h = buttonHeight;
    CGFloat h_0_5 = h / 2;
    CGFloat h_1_5 = h * 1.5;
    CGFloat h_2_0 = h * 2;
    
    long half = buttonNumber / 2;
    
    switch (bmb.buttonPlaceEnum) {
        case VHButtonPlaceHorizontal:
            if (buttonNumber % 2 == 0)
            {
                for (long i = half - 1; i >= 0; i--)
                {
                    addPosition(-w_0_5 - hm_0_5 - i * (w + hm), 0);
                }
                for (int i = 0; i < half; i++)
                {
                    addPosition(+w_0_5 + hm_0_5 + i * (w + hm), 0);
                }
            }
            else
            {
                for (long i = half - 1; i >= 0; i--)
                {
                    addPosition(-w - hm - i * (w + hm), 0);
                }
                addPosition(0,     0);
                for (int i = 0; i < half; i++)
                {
                    addPosition(+w + hm + i * (w + hm), 0);
                }
                break;
            }
        case VHButtonPlaceVertical:
        case VHButtonPlaceHAM_1:
        case VHButtonPlaceHAM_2:
        case VHButtonPlaceHAM_3:
        case VHButtonPlaceHAM_4:
        case VHButtonPlaceHAM_5:
        case VHButtonPlaceHAM_6:
            if (buttonNumber % 2 == 0)
            {
                for (long i = half - 1; i >= 0; i--)
                {
                    addPosition(0, -h_0_5 - vm_0_5 - i * (h + vm));
                }
                for (int i = 0; i < half; i++)
                {
                    addPosition(0, +h_0_5 + vm_0_5 + i * (h + vm));
                }
            }
            else
            {
                for (long i = half - 1; i >= 0; i--)
                {
                    addPosition(0, -h - vm - i * (h + vm));
                }
                addPosition(0, 0);
                for (int i = 0; i < half; i++)
                {
                    addPosition(0, +h + vm + i * (h + vm));
                }
            }
            break;
        case VHButtonPlaceSC_1:
            addPosition(0, 0);
            break;
        case VHButtonPlaceSC_2_1:
            addPosition(-hm_0_5 - w_0_5, 0);
            addPosition(+hm_0_5 + w_0_5, 0);
            break;
        case VHButtonPlaceSC_2_2:
            addPosition(0, -vm_0_5 - h_0_5);
            addPosition(0, +vm_0_5 + h_0_5);
            break;
        case VHButtonPlaceSC_3_1:
            addPosition(-hm - w, 0);
            addPosition(0, 0);
            addPosition(+hm + w, 0);
            break;
        case VHButtonPlaceSC_3_2:
            addPosition(0, -vm - h);
            addPosition(0, 0);
            addPosition(0, +vm + h);
            break;
        case VHButtonPlaceSC_3_3:
            addPosition(-hm_0_5 - w_0_5, -vm_0_5 - h_0_5);
            addPosition(+hm_0_5 + w_0_5, -vm_0_5 - h_0_5);
            addPosition(0, vm_0_5 + h_0_5);
            break;
        case VHButtonPlaceSC_3_4:
            addPosition(0, -vm_0_5 - h_0_5);
            addPosition(-hm_0_5 - w_0_5, vm_0_5 + h_0_5);
            addPosition(+hm_0_5 + w_0_5, vm_0_5 + h_0_5);
            break;
        case VHButtonPlaceSC_4_1:
            addPosition(-hm_0_5 - w_0_5, -vm_0_5 - h_0_5);
            addPosition(+hm_0_5 + w_0_5, -vm_0_5 - h_0_5);
            addPosition(-hm_0_5 - w_0_5, +vm_0_5 + h_0_5);
            addPosition(+hm_0_5 + w_0_5, +vm_0_5 + h_0_5);
            break;
        case VHButtonPlaceSC_4_2:
            addPosition(0, -vm_0_5 - h_0_5);
            addPosition(-hm - w, 0);
            addPosition(+hm + w, 0);
            addPosition(0, +vm_0_5 + h_0_5);
            break;
        case VHButtonPlaceSC_5_1:
            addPosition(-hm - w, -vm_0_5 - h_0_5);
            addPosition(0, -vm_0_5 - h_0_5);
            addPosition(+hm + w, -vm_0_5 - h_0_5);
            addPosition(-hm_0_5 - w_0_5, vm_0_5 + h_0_5);
            addPosition(+hm_0_5 + w_0_5, vm_0_5 + h_0_5);
            break;
        case VHButtonPlaceSC_5_2:
            addPosition(-hm_0_5 - w_0_5, -vm_0_5 - h_0_5);
            addPosition(+hm_0_5 + w_0_5, -vm_0_5 - h_0_5);
            addPosition(-hm - w, vm_0_5 + h_0_5);
            addPosition(0, vm_0_5 + h_0_5);
            addPosition(+hm + w, vm_0_5 + h_0_5);
            break;
        case VHButtonPlaceSC_5_3:
            addPosition(0, -vm - h);
            addPosition(-hm - w, 0);
            addPosition(0, 0);
            addPosition(+hm + w, 0);
            addPosition(0, +vm + h);
            break;
        case VHButtonPlaceSC_5_4:
            addPosition(-hm - w, -vm_0_5 - h_0_5);
            addPosition(+hm + w, -vm_0_5 - h_0_5);
            addPosition(0, 0);
            addPosition(-hm - w, vm_0_5 + h_0_5);
            addPosition(+hm + w, vm_0_5 + h_0_5);
            break;
        case VHButtonPlaceSC_6_1:
            addPosition(-hm - w, -vm_0_5 - h_0_5);
            addPosition(0, -vm_0_5 - h_0_5);
            addPosition(+hm + w, -vm_0_5 - h_0_5);
            addPosition(-hm - w, vm_0_5 + h_0_5);
            addPosition(0, vm_0_5 + h_0_5);
            addPosition(+hm + w, vm_0_5 + h_0_5);
            break;
        case VHButtonPlaceSC_6_2:
            addPosition(-hm_0_5 - w_0_5, -vm - h);
            addPosition(+hm_0_5 + w_0_5, -vm - h);
            addPosition(-hm_0_5 - w_0_5, 0);
            addPosition(+hm_0_5 + w_0_5, 0);
            addPosition(-hm_0_5 - w_0_5, +vm + h);
            addPosition(+hm_0_5 + w_0_5, +vm + h);
            break;
        case VHButtonPlaceSC_6_3:
            addPosition(-hm_0_5 - w_0_5, -vm - h);
            addPosition(+hm_0_5 + w_0_5, -vm - h);
            addPosition(-hm - w, 0);
            addPosition(+hm + w, 0);
            addPosition(-hm_0_5 - w_0_5, +vm + h);
            addPosition(+hm_0_5 + w_0_5, +vm + h);
            break;
        case VHButtonPlaceSC_6_4:
            addPosition(0, -vm - h);
            addPosition(-hm - w, -vm_0_5 - h_0_5);
            addPosition(+hm + w, -vm_0_5 - h_0_5);
            addPosition(-hm - w, +vm_0_5 + h_0_5);
            addPosition(+hm + w, +vm_0_5 + h_0_5);
            addPosition(0, +vm + h);
            break;
        case VHButtonPlaceSC_6_5:
            addPosition(-hm - w, -vm - h);
            addPosition(0, -vm - h);
            addPosition(+hm + w, -vm - h);
            addPosition(-hm_0_5 - w_0_5, 0);
            addPosition(+hm_0_5 + w_0_5, 0);
            addPosition(0, vm + h);
            break;
        case VHButtonPlaceSC_6_6:
            addPosition(0, -vm - h);
            addPosition(-hm_0_5 - w_0_5, 0);
            addPosition(+hm_0_5 + w_0_5, 0);
            addPosition(-hm - w, vm + h);
            addPosition(0, vm + h);
            addPosition(+hm + w, vm + h);
            break;
        case VHButtonPlaceSC_7_1:
            addPosition(-hm - w, -vm - h);
            addPosition(0, -hm - h);
            addPosition(+hm + w, -vm - h);
            addPosition(-hm - w, 0);
            addPosition(0, 0);
            addPosition(+hm + w, 0);
            addPosition(0, hm + h);
            break;
        case VHButtonPlaceSC_7_2:
            addPosition(0, -hm - h);
            addPosition(-hm - w, 0);
            addPosition(0, 0);
            addPosition(+hm + w, 0);
            addPosition(-hm - w, vm + h);
            addPosition(0, hm + h);
            addPosition(+hm + w, vm + h);
            break;
        case VHButtonPlaceSC_7_3:
            addPosition(-hm_0_5 - w_0_5, -vm - h);
            addPosition(+hm_0_5 + w_0_5, -vm - h);
            addPosition(-hm - w, 0);
            addPosition(0, 0);
            addPosition(hm + w, 0);
            addPosition(-hm_0_5 - w_0_5, vm + h);
            addPosition(+hm_0_5 + w_0_5, vm + h);
            break;
        case VHButtonPlaceSC_7_4:
            addPosition(0, -vm - h);
            addPosition(-hm - w, -vm_0_5 - h_0_5);
            addPosition(+hm + w, -vm_0_5 - h_0_5);
            addPosition(0, 0);
            addPosition(-hm - w, +vm_0_5 + h_0_5);
            addPosition(+hm + w, +vm_0_5 + h_0_5);
            addPosition(0, vm + h);
            break;
        case VHButtonPlaceSC_7_5:
            addPosition(-hm_1_5 - w_1_5, -vm_0_5 - h_0_5);
            addPosition(-hm_0_5 - w_0_5, -vm_0_5 - h_0_5);
            addPosition(+hm_0_5 + w_0_5, -vm_0_5 - h_0_5);
            addPosition(+hm_1_5 + w_1_5, -vm_0_5 - h_0_5);
            addPosition(-hm - w, vm_0_5 + h_0_5);
            addPosition(0, vm_0_5 + h_0_5);
            addPosition(+hm + w, vm_0_5 + h_0_5);
            break;
        case VHButtonPlaceSC_7_6:
            addPosition(-hm - w, -vm_0_5 - h_0_5);
            addPosition(0, -vm_0_5 - h_0_5);
            addPosition(+hm + w, -vm_0_5 - h_0_5);
            addPosition(-hm_1_5 - w_1_5, vm_0_5 + h_0_5);
            addPosition(-hm_0_5 - w_0_5, vm_0_5 + h_0_5);
            addPosition(+hm_0_5 + w_0_5, vm_0_5 + h_0_5);
            addPosition(+hm_1_5 + w_1_5, vm_0_5 + h_0_5);
            break;
        case VHButtonPlaceSC_8_1:
            addPosition(-hm - w, -vm - h);
            addPosition(0, -vm - h);
            addPosition(+hm + w, -vm - h);
            addPosition(-hm_0_5 - w_0_5, 0);
            addPosition(+hm_0_5 + w_0_5, 0);
            addPosition(-hm - w, vm + h);
            addPosition(0, vm + h);
            addPosition(+hm + w, vm + h);
            break;
        case VHButtonPlaceSC_8_2:
            addPosition(-hm - w, -vm - h);
            addPosition(+hm + w, -vm - h);
            addPosition(0, -vm_0_5 - h_0_5);
            addPosition(-hm - w, 0);
            addPosition(+hm + w, 0);
            addPosition(0, +vm_0_5 + h_0_5);
            addPosition(-hm - w, +vm + h);
            addPosition(+hm + w, +vm + h);
            break;
        case VHButtonPlaceSC_8_3:
            addPosition(-hm - w, -vm - h);
            addPosition(0, -vm - h);
            addPosition(+hm + w, -vm - h);
            addPosition(-hm - w, 0);
            addPosition(+hm + w, 0);
            addPosition(-hm - w, +vm + h);
            addPosition(0, +vm + h);
            addPosition(+hm + w, +vm + h);
            break;
        case VHButtonPlaceSC_8_4:
            addPosition(0, -vm_2_0 - h_2_0);
            addPosition(-hm_0_5 - w_0_5, -vm - h);
            addPosition(+hm_0_5 + w_0_5, -vm - h);
            addPosition(-hm - w, 0);
            addPosition(+hm + w, 0);
            addPosition(-hm_0_5 - w_0_5, +vm + h);
            addPosition(+hm_0_5 + w_0_5, +vm + h);
            addPosition(0, +vm_2_0 + h_2_0);
            break;
        case VHButtonPlaceSC_8_5:
            addPosition(0, -vm - h);
            addPosition(-hm - w, -vm_0_5 - h_0_5);
            addPosition(+hm + w, -vm_0_5 - h_0_5);
            addPosition(-hm_2_0 - w_2_0, 0);
            addPosition(+hm_2_0 + w_2_0, 0);
            addPosition(-hm - w, +vm_0_5 + h_0_5);
            addPosition(+hm + w, +vm_0_5 + h_0_5);
            addPosition(0, +vm + h);
            break;
        case VHButtonPlaceSC_8_6:
            addPosition(-hm_1_5 - w_1_5, -vm_0_5 - h_0_5);
            addPosition(-hm_0_5 - w_0_5, -vm_0_5 - h_0_5);
            addPosition(+hm_0_5 + w_0_5, -vm_0_5 - h_0_5);
            addPosition(+hm_1_5 + w_1_5, -vm_0_5 - h_0_5);
            addPosition(-hm_1_5 - w_1_5, +vm_0_5 + h_0_5);
            addPosition(-hm_0_5 - w_0_5, +vm_0_5 + h_0_5);
            addPosition(+hm_0_5 + w_0_5, +vm_0_5 + h_0_5);
            addPosition(+hm_1_5 + w_1_5, +vm_0_5 + h_0_5);
            break;
        case VHButtonPlaceSC_8_7:
            addPosition(-hm_0_5 - w_0_5, -vm_1_5 - h_1_5);
            addPosition(+hm_0_5 + w_0_5, -vm_1_5 - h_1_5);
            addPosition(-hm_0_5 - w_0_5, -vm_0_5 - h_0_5);
            addPosition(+hm_0_5 + w_0_5, -vm_0_5 - h_0_5);
            addPosition(-hm_0_5 - w_0_5, +vm_0_5 + h_0_5);
            addPosition(+hm_0_5 + w_0_5, +vm_0_5 + h_0_5);
            addPosition(-hm_0_5 - w_0_5, +vm_1_5 + h_1_5);
            addPosition(+hm_0_5 + w_0_5, +vm_1_5 + h_1_5);
            break;
        case VHButtonPlaceSC_9_1:
            addPosition(-hm - w, -vm - h);
            addPosition(0, -vm - h);
            addPosition(+hm + w, -vm - h);
            addPosition(-hm - w, 0);
            addPosition(0, 0);
            addPosition(+hm + w, 0);
            addPosition(-hm - w, +vm + h);
            addPosition(0, +vm + h);
            addPosition(+hm + w, +vm + h);
            break;
        case VHButtonPlaceSC_9_2:
            addPosition(0, -vm_2_0 - h_2_0);
            addPosition(-hm_0_5 - w_0_5, -vm - h);
            addPosition(+hm_0_5 + w_0_5, -vm - h);
            addPosition(-hm - w, 0);
            addPosition(0, 0);
            addPosition(+hm + w, 0);
            addPosition(-hm_0_5 - w_0_5, +vm + h);
            addPosition(+hm_0_5 + w_0_5, +vm + h);
            addPosition(0, +vm_2_0 + h_2_0);
            break;
        case VHButtonPlaceSC_9_3:
            addPosition(0, -vm - h);
            addPosition(-hm - w, -vm_0_5 - h_0_5);
            addPosition(+hm + w, -vm_0_5 - h_0_5);
            addPosition(-hm_2_0 - w_2_0, 0);
            addPosition(0, 0);
            addPosition(+hm_2_0 + w_2_0, 0);
            addPosition(-hm - w, +vm_0_5 + h_0_5);
            addPosition(+hm + w, +vm_0_5 + h_0_5);
            addPosition(0, vm + h);
            break;
        case VHButtonPlaceCustom:
            [positions addObjectsFromArray:bmb.customButtonPositions];
            break;
        default:
            NSAssert(NO, @"Button place enum not found!");
            break;
    }
    
    switch (bmb.buttonPlaceEnum) {
        case VHButtonPlaceSC_3_3:
            [VHButtonPlaceManager adjustPositions:positions withX:0 withY:+pow(hm_0_5 + w_0_5, 2) / (vm + h)];
            break;
        case VHButtonPlaceSC_3_4:
            [VHButtonPlaceManager adjustPositions:positions withX:0 withY:-pow(hm_0_5 + w_0_5, 2) / (vm + h)];
            break;
        case VHButtonPlaceSC_4_2:
        case VHButtonPlaceSC_5_1:
        case VHButtonPlaceSC_5_2:
        case VHButtonPlaceSC_5_3:
        case VHButtonPlaceSC_5_4:
        case VHButtonPlaceSC_6_1:
        case VHButtonPlaceSC_6_2:
        case VHButtonPlaceSC_6_3:
        case VHButtonPlaceSC_6_4:
        case VHButtonPlaceSC_6_5:
        case VHButtonPlaceSC_6_6:
        case VHButtonPlaceSC_7_1:
        case VHButtonPlaceSC_7_2:
        case VHButtonPlaceSC_7_3:
        case VHButtonPlaceSC_7_4:
        case VHButtonPlaceSC_7_5:
        case VHButtonPlaceSC_7_6:
        case VHButtonPlaceSC_8_1:
        case VHButtonPlaceSC_8_2:
        case VHButtonPlaceSC_8_3:
        case VHButtonPlaceSC_8_4:
        case VHButtonPlaceSC_8_5:
        case VHButtonPlaceSC_8_6:
        case VHButtonPlaceSC_8_7:
        case VHButtonPlaceSC_9_1:
        case VHButtonPlaceSC_9_2:
        case VHButtonPlaceSC_9_3:
            [VHButtonPlaceManager adjustPositions:positions withX:0 withY:h_0_5 - w_0_5];
            break;
        default:
            if (buttonNumber >= 2
                && bmb.buttonEnum == VHButtonHam
                && bmb.bottomHamButtonTopMargin > 0
                && bmb.buttonPlaceEnum != VHButtonPlaceHorizontal)
            {
                CGPoint point = [positions.lastObject CGPointValue];
                [positions setObject:[NSValue valueWithCGPoint:CGPointMake(point.x,
                                                                           point.y + bmb.bottomHamButtonTopMargin - vm)]
                  atIndexedSubscript:buttonNumber - 1];
            }
            break;
    }
    
    [VHButtonPlaceManager adjustPositions:positions withX:parentFrame.size.width / 2 withY:parentFrame.size.height / 2];
    [VHButtonPlaceManager adjustAlignmentPositions:positions withParentFrame:parentFrame
                               withHalfButtonWidth:w_0_5 withHalfButtonHeight:h_0_5 withBoomMenuButton:bmb];
    
    return positions;
}

+ (NSMutableArray<NSValue *> *)positionsWithParentFrame:(CGRect)parentFrame
                                       withButtonRadius:(CGFloat)radius
                                       withButtonNumber:(long)buttonNumber
                                     withBoomMenuButton:(VHBoomMenuButton *)bmb
{
    NSMutableArray *positions = [NSMutableArray array];
    
    CGFloat hm = bmb.buttonHorizontalMargin;
    CGFloat hm_0_5 = hm / 2;
    CGFloat hm_1_5 = hm * 1.5;
    
    CGFloat vm = bmb.buttonVerticalMargin;
    CGFloat vm_0_5 = vm / 2;
    CGFloat vm_1_5 = hm * 1.5;
    
    CGFloat im = bmb.buttonInclinedMargin;
    
    CGFloat r = radius;
    CGFloat r_2_0 = r * 2;
    CGFloat r_3_0 = r * 3;
    
    CGFloat a, b, c, e;
    b = hm_0_5 + r;
    c = b / (sqrt(3) / 2);
    a = c / 2;
    e = c - a;
    switch (bmb.buttonPlaceEnum) {
        case VHButtonPlaceSC_4_2:
        case VHButtonPlaceSC_5_4:
        case VHButtonPlaceSC_8_5:
        case VHButtonPlaceSC_9_3:
            a = (r_2_0 + im) / sqrt(2);
            break;
        case VHButtonPlaceSC_8_2:
            b = vm_0_5 + r;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            e = c - a;
            break;
        default:
            break;
    }
    CGFloat a_2_0 = a * 2;
    CGFloat b_2_0 = b * 2;
    CGFloat b_3_0 = b * 3;
    CGFloat c_2_0 = c * 2;
    
    long half = buttonNumber / 2;
    
    switch (bmb.buttonPlaceEnum)
    {
        case VHButtonPlaceHorizontal:
        {
            if (buttonNumber % 2 == 0)
            {
                for (long i = half - 1; i >= 0; i--)
                {
                    addPosition(-r - hm_0_5 - i * (r_2_0 + hm), 0);
                }
                for (int i = 0; i < half; i++)
                {
                    addPosition(+r + hm_0_5 + i * (r_2_0 + hm), 0);
                }
            }
            else
            {
                for (long i = half - 1; i >= 0; i--)
                {
                    addPosition(-r_2_0 - hm - i * (r_2_0 + hm), 0);
                }
                addPosition(0, 0);
                for (int i = 0; i < half; i++)
                {
                    addPosition(+r_2_0 + hm + i * (r_2_0 + hm), 0);
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
                    addPosition(0, -radius - vm_0_5 - i * (2 * radius + vm));
                }
                for (int i = 0; i < half; i++)
                {
                    addPosition(0, radius + vm_0_5 + i * (2 * radius + vm));
                }
            }
            else
            {
                long half = buttonNumber / 2;
                for (long i = half - 1; i >= 0; i--)
                {
                    addPosition(0, -2 * radius - vm - i * (2 * radius + vm));
                }
                addPosition(0, 0);
                for (int i = 0; i < half; i++)
                {
                    addPosition(0, 2 * radius + vm + i * (2 * radius + vm));
                }
            }
            break;
        }
        case VHButtonPlaceSC_1:
            addPosition(0, 0);
            break;
        case VHButtonPlaceSC_2_1:
            addPosition(-hm_0_5 - r, 0);
            addPosition(+hm_0_5 + r, 0);
            break;
        case VHButtonPlaceSC_2_2:
            addPosition(0, -vm_0_5 - r);
            addPosition(0, +vm_0_5 + r);
            break;
        case VHButtonPlaceSC_3_1:
            addPosition(-hm - r_2_0, 0);
            addPosition(0, 0);
            addPosition(+hm + r_2_0, 0);
            break;
        case VHButtonPlaceSC_3_2:
            addPosition(0, -vm - r_2_0);
            addPosition(0, 0);
            addPosition(0, +vm + r_2_0);
            break;
        case VHButtonPlaceSC_3_3:
            addPosition(-b, -a);
            addPosition(+b, -a);
            addPosition(0, c);
            break;
        case VHButtonPlaceSC_3_4:
            addPosition(0, -c);
            addPosition(-b, a);
            addPosition(+b, a);
            break;
        case VHButtonPlaceSC_4_1:
            addPosition(-hm_0_5 - r, -vm_0_5 - r);
            addPosition(+hm_0_5 + r, -vm_0_5 - r);
            addPosition(-hm_0_5 - r, +vm_0_5 + r);
            addPosition(+hm_0_5 + r, +vm_0_5 + r);
            break;
        case VHButtonPlaceSC_4_2:
            addPosition(0, -a);
            addPosition(-a, 0);
            addPosition(+a, 0);
            addPosition(0, +a);
            break;
        case VHButtonPlaceSC_5_1:
            addPosition(-b_2_0, -c);
            addPosition(0, -c);
            addPosition(+b_2_0, -c);
            addPosition(-hm_0_5 - r, a);
            addPosition(+hm_0_5 + r, a);
            break;
        case VHButtonPlaceSC_5_2:
            addPosition(-hm_0_5 - r, -a);
            addPosition(+hm_0_5 + r, -a);
            addPosition(-b_2_0, c);
            addPosition(0, c);
            addPosition(+b_2_0, c);
            break;
        case VHButtonPlaceSC_5_3:
            addPosition(0, -vm - r_2_0);
            addPosition(-hm - r_2_0, 0);
            addPosition(0, 0);
            addPosition(+hm + r_2_0, 0);
            addPosition(0, +vm + r_2_0);
            break;
        case VHButtonPlaceSC_5_4:
            addPosition(-a, -a);
            addPosition(+a, -a);
            addPosition(0, 0);
            addPosition(-a, +a);
            addPosition(+a, +a);
            break;
        case VHButtonPlaceSC_6_1:
            addPosition(-hm - r_2_0, -vm_0_5 - r);
            addPosition(0, -vm_0_5 - r);
            addPosition(+hm + r_2_0, -vm_0_5 - r);
            addPosition(-hm - r_2_0, +vm_0_5 + r);
            addPosition(0, vm_0_5 + r);
            addPosition(+hm + r_2_0, +vm_0_5 + r);
            break;
        case VHButtonPlaceSC_6_2:
            addPosition(-hm_0_5 - radius, -vm - 2 * radius);
            addPosition(+hm_0_5 + radius, -vm - 2 * radius);
            addPosition(-hm_0_5 - radius, 0);
            addPosition(+hm_0_5 + radius, 0);
            addPosition(-hm_0_5 - radius, +vm + 2 * radius);
            addPosition(+hm_0_5 + radius, +vm + 2 * radius);
            break;
        case VHButtonPlaceSC_6_3:
            addPosition(-b, -a - c);
            addPosition(+b, -a - c);
            addPosition(-b_2_0, 0);
            addPosition(+b_2_0, 0);
            addPosition(-b, +a + c);
            addPosition(+b, +a + c);
            break;
        case VHButtonPlaceSC_6_4:
            addPosition(0, -b_2_0);
            addPosition(-a - c, -b);
            addPosition(+a + c, -b);
            addPosition(-a - c, +b);
            addPosition(+a + c, +b);
            addPosition(0, +b_2_0);
            break;
        case VHButtonPlaceSC_6_5:
            addPosition(-b_2_0, -a - c + e);
            addPosition(0, -a - c + e);
            addPosition(+b_2_0, -a - c + e);
            addPosition(-hm_0_5 - r, +e);
            addPosition(hm_0_5 + r, +e);
            addPosition(0, a + c + e);
            break;
        case VHButtonPlaceSC_6_6:
            addPosition(0, -a - c - e);
            addPosition(-hm_0_5 - r, -e);
            addPosition(+hm_0_5 + r, -e);
            addPosition(-b_2_0, +a + c - e);
            addPosition(0, +a + c - e);
            addPosition(+b_2_0, +a + c - e);
            break;
        case VHButtonPlaceSC_7_1:
            addPosition(-hm - r_2_0, -vm - r_2_0);
            addPosition(0, -vm - r_2_0);
            addPosition(+hm + r_2_0, -vm - r_2_0);
            addPosition(-hm - r_2_0, 0);
            addPosition(0, 0);
            addPosition(+hm + r_2_0, 0);
            addPosition(0, +vm + r_2_0);
            break;
        case VHButtonPlaceSC_7_2:
            addPosition(0, -vm - r_2_0);
            addPosition(-hm - r_2_0, 0);
            addPosition(0, 0);
            addPosition(+hm + r_2_0, 0);
            addPosition(-hm - r_2_0, +vm + r_2_0);
            addPosition(0, +vm + r_2_0);
            addPosition(+hm + r_2_0, +vm + r_2_0);
            break;
        case VHButtonPlaceSC_7_3:
            addPosition(-b, -a - c);
            addPosition(+b, -a - c);
            addPosition(-b_2_0, 0);
            addPosition(0, 0);
            addPosition(+b_2_0, 0);
            addPosition(-b, +a + c);
            addPosition(+b, +a + c);
            break;
        case VHButtonPlaceSC_7_4:
            addPosition(0, -b_2_0);
            addPosition(-a - c, -b);
            addPosition(+a + c, -b);
            addPosition(0, 0);
            addPosition(-a - c, +b);
            addPosition(+a + c, +b);
            addPosition(0, +b_2_0);
            break;
        case VHButtonPlaceSC_7_5:
            addPosition(-b_3_0, -a);
            addPosition(-b, -a);
            addPosition(+b, -a);
            addPosition(+b_3_0, -a);
            addPosition(-b_2_0, c);
            addPosition(0, c);
            addPosition(+b_2_0, c);
            break;
        case VHButtonPlaceSC_7_6:
            addPosition(-b_2_0, -c);
            addPosition(0, -c);
            addPosition(+b_2_0, -c);
            addPosition(-b_3_0, a);
            addPosition(-b, a);
            addPosition(+b, a);
            addPosition(+b_3_0, a);
            break;
        case VHButtonPlaceSC_8_1:
            addPosition(-b_2_0, -a - c);
            addPosition(0, -a - c);
            addPosition(+b_2_0, -a - c);
            addPosition(-hm_0_5 - r, 0);
            addPosition(+hm_0_5 + r, 0);
            addPosition(-b_2_0, a + c);
            addPosition(0, a + c);
            addPosition(+b_2_0, a + c);
            break;
        case VHButtonPlaceSC_8_2:
            addPosition(-a - c, -b_2_0);
            addPosition(+a + c, -b_2_0);
            addPosition(0, -vm_0_5 - r);
            addPosition(-a - c, 0);
            addPosition(+a + c, 0);
            addPosition(0, +vm_0_5 + r);
            addPosition(-a - c, +b_2_0);
            addPosition(+a + c, +b_2_0);
            break;
        case VHButtonPlaceSC_8_3:
            addPosition(-hm - r_2_0, -vm - r_2_0);
            addPosition(0, -vm - r_2_0);
            addPosition(+hm + r_2_0, -vm - r_2_0);
            addPosition(-hm - r_2_0, 0);
            addPosition(+hm + r_2_0, 0);
            addPosition(-hm - r_2_0, +vm + r_2_0);
            addPosition(0, vm + r_2_0);
            addPosition(+hm + r_2_0, +vm + r_2_0);
            break;
        case VHButtonPlaceSC_8_4:
            addPosition(0, -a_2_0 - c_2_0);
            addPosition(-hm_0_5 - r, -a - c);
            addPosition(+hm_0_5 + r, -a - c);
            addPosition(-b_2_0, 0);
            addPosition(+b_2_0, 0);
            addPosition(-hm_0_5 - r, a + c);
            addPosition(+hm_0_5 + r, a + c);
            addPosition(0, +a_2_0 + c_2_0);
            break;
        case VHButtonPlaceSC_8_5:
            addPosition(0, -a_2_0);
            addPosition(-a, -a);
            addPosition(+a, -a);
            addPosition(-a_2_0, 0);
            addPosition(+a_2_0, 0);
            addPosition(-a, +a);
            addPosition(+a, +a);
            addPosition(0, a_2_0);
            break;
        case VHButtonPlaceSC_8_6:
            addPosition(-hm_1_5 - r_3_0, -vm_0_5 - r);
            addPosition(-hm_0_5 - r, -vm_0_5 - r);
            addPosition(+hm_0_5 + r, -vm_0_5 - r);
            addPosition(+hm_1_5 + r_3_0, -vm_0_5 - r);
            addPosition(-hm_1_5 - r_3_0, vm_0_5 + r);
            addPosition(-hm_0_5 - r, vm_0_5 + r);
            addPosition(+hm_0_5 + r, vm_0_5 + r);
            addPosition(+hm_1_5 + r_3_0, vm_0_5 + r);
            break;
        case VHButtonPlaceSC_8_7:
            addPosition(-hm_0_5 - r, -vm_1_5 - r_3_0);
            addPosition(+hm_0_5 + r, -vm_1_5 - r_3_0);
            addPosition(-hm_0_5 - r, -vm_0_5 - r);
            addPosition(+hm_0_5 + r, -vm_0_5 - r);
            addPosition(-hm_0_5 - r, +vm_0_5 + r);
            addPosition(+hm_0_5 + r, +vm_0_5 + r);
            addPosition(-hm_0_5 - r, +vm_1_5 + r_3_0);
            addPosition(+hm_0_5 + r, +vm_1_5 + r_3_0);
            break;
        case VHButtonPlaceSC_9_1:
            addPosition(-hm - r_2_0, -vm - r_2_0);
            addPosition(0, -vm - r_2_0);
            addPosition(+hm + r_2_0, -vm - r_2_0);
            addPosition(-hm - r_2_0, 0);
            addPosition(0, 0);
            addPosition(+hm + r_2_0, 0);
            addPosition(-hm - r_2_0, +vm + r_2_0);
            addPosition(0, vm + r_2_0);
            addPosition(+hm + r_2_0, +vm + r_2_0);
            break;
        case VHButtonPlaceSC_9_2:
            addPosition(0, -a_2_0 - c_2_0);
            addPosition(-hm_0_5 - r, -a - c);
            addPosition(+hm_0_5 + r, -a - c);
            addPosition(-b_2_0, 0);
            addPosition(0, 0);
            addPosition(+b_2_0, 0);
            addPosition(-hm_0_5 - r, +a + c);
            addPosition(+hm_0_5 + r, +a + c);
            addPosition(0, +a_2_0 + c_2_0);
            break;
        case VHButtonPlaceSC_9_3:
            addPosition(0, -a_2_0);
            addPosition(-a, -a);
            addPosition(+a, -a);
            addPosition(-a_2_0, 0);
            addPosition(0, 0);
            addPosition(+a_2_0, 0);
            addPosition(-a, +a);
            addPosition(+a, +a);
            addPosition(0, +a_2_0);
            break;
        case VHButtonPlaceCustom:
            [positions addObjectsFromArray:bmb.customButtonPositions];
            break;
        default:
            NSAssert(NO, @"Button place enum not found!");
            break;
    }
    
    
    [VHButtonPlaceManager adjustPositions:positions withX:parentFrame.size.width / 2 withY:parentFrame.size.height / 2];
    [VHButtonPlaceManager adjustAlignmentPositions:positions withParentFrame:parentFrame
                               withHalfButtonWidth:r withHalfButtonHeight:r withBoomMenuButton:bmb];
    
    return positions;
}

+ (int)buttonNumber:(VHButtonPlaceEnum)buttonPlaceEnum
{
    switch (buttonPlaceEnum)
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
        case VHButtonPlaceCustom:
            return -1;
        default:
            return -1;
    }
}

+ (int)minButtonNumber:(VHButtonPlaceEnum)buttonPlaceEnum
{
    switch (buttonPlaceEnum)
    {
        case VHButtonPlaceHorizontal:
        case VHButtonPlaceVertical:
        case VHButtonPlaceCustom:
            return 1;
        case VHButtonPlaceUnknown:
            return 0;
        default:
            return -1;
    }
}

+ (int)maxButtonNumber:(VHButtonPlaceEnum)buttonPlaceEnum
{
    switch (buttonPlaceEnum)
    {
        case VHButtonPlaceHorizontal:
        case VHButtonPlaceVertical:
        case VHButtonPlaceCustom:
            return INT_MAX;
        case VHButtonPlaceUnknown:
            return 0;
        default:
            return -1;
    }
}

+ (CGFloat)calculateYOffsetToCenterWithHorizontalMargin:(CGFloat)hm verticalMargin:(CGFloat)vm width:(CGFloat)w height:(CGFloat)h
{
    return (hm / 2 + w / 2) * (hm / 2 + w / 2) / (vm + h);
}

+ (void)adjustAlignmentPositions:(NSMutableArray<NSValue *> *)positions
                 withParentFrame:(CGRect)parentFrame
             withHalfButtonWidth:(CGFloat)halfWidth
            withHalfButtonHeight:(CGFloat)halfHeight
              withBoomMenuButton:(VHBoomMenuButton *)bmb {
    CGFloat minY = CGFLOAT_MAX;
    CGFloat maxY = CGFLOAT_MIN;
    CGFloat minX = CGFLOAT_MAX;
    CGFloat maxX = CGFLOAT_MIN;
    
    for (NSValue *position in positions)
    {
        maxY = MAX(maxY, [position CGPointValue].y);
        minY = MIN(minY, [position CGPointValue].y);
        maxX = MAX(maxX, [position CGPointValue].x);
        minX = MIN(minX, [position CGPointValue].x);
    }
    
    CGFloat yOffset = 0;
    CGFloat xOffset = 0;
    switch (bmb.buttonPlaceAlignmentEnum)
    {
        case VHButtonPlaceAlignmentCenter:
            break;
        case VHButtonPlaceAlignmentTop:
            yOffset = halfHeight + bmb.buttonTopMargin - minY;
            break;
        case VHButtonPlaceAlignmentBottom:
            yOffset = parentFrame.size.height - halfHeight - maxY - bmb.buttonBottomMargin;
            break;
        case VHButtonPlaceAlignmentLeft:
            xOffset = halfWidth + bmb.buttonLeftMargin - minX;
            break;
        case VHButtonPlaceAlignmentRight:
            xOffset = parentFrame.size.width - halfHeight - maxX - bmb.buttonRightMargin;
            break;
        case VHButtonPlaceAlignmentTopLeft:
            yOffset = halfHeight + bmb.buttonTopMargin - minY;
            xOffset = halfWidth + bmb.buttonLeftMargin - minX;
            break;
        case VHButtonPlaceAlignmentTopRight:
            yOffset = halfHeight + bmb.buttonTopMargin - minY;
            xOffset = parentFrame.size.width - halfWidth - maxX - bmb.buttonRightMargin;
            break;
        case VHButtonPlaceAlignmentBottomLeft:
            yOffset = parentFrame.size.height - halfHeight - maxY - bmb.buttonBottomMargin;
            xOffset = halfWidth + bmb.buttonLeftMargin - minX;
            break;
        case VHButtonPlaceAlignmentBottomRight:
            yOffset = parentFrame.size.height - halfHeight - maxY - bmb.buttonBottomMargin;
            xOffset = parentFrame.size.width - halfWidth - maxX - bmb.buttonRightMargin;
            break;
    }
    [VHButtonPlaceManager adjustPositions:positions withX:xOffset withY:yOffset];
}

+ (void)adjustPositions:(NSMutableArray<NSValue *> *)positions withX:(CGFloat)x withY:(CGFloat)y
{
    for (int i = 0; i < positions.count; i++)
    {
        CGPoint point = [[positions objectAtIndex:i] CGPointValue];
        [positions setObject:[NSValue valueWithCGPoint:CGPointMake(point.x + x, point.y + y)] atIndexedSubscript:i];
    }
}

@end
