//
//  VHDotPlaceManager.m
//  VHBoomMenuExample
//
//  Created by Nightonke on 16/7/28.
//  Copyright © 2016 Nightonke. All rights reserved.
//

#import "VHPiecePlaceManager.h"

#define addPosition(a, b) [positions addObject:[NSValue valueWithCGPoint:CGPointMake(a, b)]];

@implementation VHPiecePlaceManager

+ (NSMutableArray<NSValue *> *)dotPositions:(VHBoomMenuButton *)bmb
{
    CGRect parentFrame = bmb.bounds;
    
    CGFloat hm = bmb.pieceHorizontalMargin;
    CGFloat hm_0_5 = hm / 2;
    CGFloat hm_1_5 = hm * 1.5;
    CGFloat vm = bmb.pieceVerticalMargin;
    CGFloat vm_0_5 = vm / 2;
    CGFloat vm_1_5 = vm * 1.5;
    CGFloat im = bmb.pieceInclinedMargin;
    CGFloat r = bmb.dotRadius;
    CGFloat r_2_0 = r * 2;
    CGFloat r_3_0 = r * 3;
    
    NSMutableArray *positions = [NSMutableArray array];
    
    CGFloat a, b, c, e;
    b = hm_0_5 + r;
    c = b / (sqrt(3) / 2);
    a = c / 2;
    e = c - a;
    switch (bmb.piecePlaceEnum)
    {
        case VHPiecePlaceDOT_4_2:
        case VHPiecePlaceDOT_5_4:
        case VHPiecePlaceDOT_8_5:
        case VHPiecePlaceDOT_9_3:
            a = (r_2_0 + im) / sqrt(2);
            break;
        case VHPiecePlaceDOT_8_2:
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
    
    switch (bmb.piecePlaceEnum)
    {
        case VHPiecePlaceDOT_1:
            addPosition(0, 0);
            break;
        case VHPiecePlaceDOT_2_1:
            addPosition(-hm_0_5 - r, 0);
            addPosition(+hm_0_5 + r, 0);
            break;
        case VHPiecePlaceDOT_2_2:
            addPosition(0, -vm_0_5 - r);
            addPosition(0, +vm_0_5 + r);
            break;
        case VHPiecePlaceDOT_3_1:
            addPosition(-hm - r_2_0, 0);
            addPosition(0, 0);
            addPosition(+hm + r_2_0, 0);
            break;
        case VHPiecePlaceDOT_3_2:
            addPosition(0, -vm - r_2_0);
            addPosition(0, 0);
            addPosition(0, +vm + r_2_0);
            break;
        case VHPiecePlaceDOT_3_3:
            addPosition(-b, -a);
            addPosition(+b, -a);
            addPosition(0, c);
            break;
        case VHPiecePlaceDOT_3_4:
            addPosition(0, -c);
            addPosition(-b, a);
            addPosition(+b, a);
            break;
        case VHPiecePlaceDOT_4_1:
            addPosition(-hm_0_5 - r, -vm_0_5 - r);
            addPosition(+hm_0_5 + r, -vm_0_5 - r);
            addPosition(-hm_0_5 - r, +vm_0_5 + r);
            addPosition(+hm_0_5 + r, +vm_0_5 + r);
            break;
        case VHPiecePlaceDOT_4_2:
            addPosition(0, -a);
            addPosition(+a, 0);
            addPosition(0, +a);
            addPosition(-a, 0);
            break;
        case VHPiecePlaceDOT_5_1:
            addPosition(-b_2_0, -a);
            addPosition(0, -a);
            addPosition(+b_2_0, -a);
            addPosition(-hm_0_5 - r, c);
            addPosition(+hm_0_5 + r, c);
            break;
        case VHPiecePlaceDOT_5_2:
            addPosition(-hm_0_5 - r, -c);
            addPosition(+hm_0_5 + r, -c);
            addPosition(-b_2_0, a);
            addPosition(0, a);
            addPosition(+b_2_0, a);
            break;
        case VHPiecePlaceDOT_5_3:
            addPosition(0, -vm - r_2_0);
            addPosition(-hm - r_2_0, 0);
            addPosition(0, 0);
            addPosition(+hm + r_2_0, 0);
            addPosition(0, +vm + r_2_0);
            break;
        case VHPiecePlaceDOT_5_4:
            addPosition(-a, -a);
            addPosition(+a, -a);
            addPosition(0, 0);
            addPosition(-a, +a);
            addPosition(+a, +a);
            break;
        case VHPiecePlaceDOT_6_1:
            addPosition(-hm - r_2_0, -vm_0_5 - r);
            addPosition(0, -vm_0_5 - r);
            addPosition(+hm + r_2_0, -vm_0_5 - r);
            addPosition(-hm - r_2_0, +vm_0_5 + r);
            addPosition(0, +vm_0_5 + r);
            addPosition(+hm + r_2_0, +vm_0_5 + r);
            break;
        case VHPiecePlaceDOT_6_2:
            addPosition(-hm_0_5 - r, -vm - r_2_0);
            addPosition(+hm_0_5 + r, -vm - r_2_0);
            addPosition(-hm_0_5 - r, 0);
            addPosition(+hm_0_5 + r, 0);
            addPosition(-hm_0_5 - r, +vm + r_2_0);
            addPosition(+hm_0_5 + r, +vm + r_2_0);
            break;
        case VHPiecePlaceDOT_6_3:
            addPosition(-b, -a - c);
            addPosition(+b, -a - c);
            addPosition(-b_2_0, 0);
            addPosition(+b_2_0, 0);
            addPosition(-b, +a + c);
            addPosition(+b, +a + c);
            break;
        case VHPiecePlaceDOT_6_4:
            addPosition(0, -b_2_0);
            addPosition(-a - c, -b);
            addPosition(+a + c, -b);
            addPosition(-a - c, +b);
            addPosition(+a + c, +b);
            addPosition(0, +b_2_0);
            break;
        case VHPiecePlaceDOT_6_5:
            addPosition(-b_2_0, -a - c + e);
            addPosition(0, -a - c + e);
            addPosition(+b_2_0, -a - c + e);
            addPosition(-hm_0_5 - r, e);
            addPosition(+hm_0_5 + r, e);
            addPosition(0, +a + c + e);
            break;
        case VHPiecePlaceDOT_6_6:
            addPosition(0, -a - c - e);
            addPosition(-hm_0_5 - r, -e);
            addPosition(+hm_0_5 + r, -e);
            addPosition(-b_2_0, a + c - e);
            addPosition(0, +a + c - e);
            addPosition(+b_2_0, a + c - e);
            break;
        case VHPiecePlaceDOT_7_1:
            addPosition(-hm - r_2_0, -vm - r_2_0);
            addPosition(0, -vm - r_2_0);
            addPosition(+hm + r_2_0, -vm - r_2_0);
            addPosition(-hm - r_2_0, 0);
            addPosition(0, 0);
            addPosition(+hm + r_2_0, 0);
            addPosition(0, +vm + r_2_0);
            break;
        case VHPiecePlaceDOT_7_2:
            addPosition(0, -vm - r_2_0);
            addPosition(-hm - r_2_0, 0);
            addPosition(0, 0);
            addPosition(+hm + r_2_0, 0);
            addPosition(-hm - r_2_0, +vm + r_2_0);
            addPosition(0, +vm + r_2_0);
            addPosition(+hm + r_2_0, +vm + r_2_0);
            break;
        case VHPiecePlaceDOT_7_3:
            addPosition(-b, -a - c);
            addPosition(+b, -a - c);
            addPosition(-b_2_0, 0);
            addPosition(0, 0);
            addPosition(+b_2_0, 0);
            addPosition(-b, +a + c);
            addPosition(+b, +a + c);
            break;
        case VHPiecePlaceDOT_7_4:
            addPosition(0, -b_2_0);
            addPosition(-a - c, -b);
            addPosition(+a + c, -b);
            addPosition(0, 0);
            addPosition(-a - c, +b);
            addPosition(+a + c, +b);
            addPosition(0, +b_2_0);
            break;
        case VHPiecePlaceDOT_7_5:
            addPosition(-b_3_0, -a);
            addPosition(-b, -a);
            addPosition(+b, -a);
            addPosition(+b_3_0, -a);
            addPosition(-b_2_0, +c);
            addPosition(0, c);
            addPosition(+b_2_0, +c);
            break;
        case VHPiecePlaceDOT_7_6:
            addPosition(-b_2_0, -c);
            addPosition(0, -c);
            addPosition(+b_2_0, -c);
            addPosition(-b_3_0, +a);
            addPosition(-b, a);
            addPosition(+b, a);
            addPosition(+b_3_0, +a);
            break;
        case VHPiecePlaceDOT_8_1:
            addPosition(-b_2_0, -a - c);
            addPosition(0, -a - c);
            addPosition(+b_2_0, -a - c);
            addPosition(-hm_0_5 - r, 0);
            addPosition(+hm_0_5 + r, 0);
            addPosition(-b_2_0, +a + c);
            addPosition(0, +a + c);
            addPosition(+b_2_0, +a + c);
            break;
        case VHPiecePlaceDOT_8_2:
            addPosition(-a - c, -b_2_0);
            addPosition(+a + c, -b_2_0);
            addPosition(0, -vm_0_5 - r);
            addPosition(-a - c, 0);
            addPosition(+a + c, 0);
            addPosition(0, +vm_0_5 + r);
            addPosition(-a - c, +b_2_0);
            addPosition(+a + c, +b_2_0);
            break;
        case VHPiecePlaceDOT_8_3:
            addPosition(-hm - r_2_0, -vm - r_2_0);
            addPosition(0, -vm - r_2_0);
            addPosition(+hm + r_2_0, -vm - r_2_0);
            addPosition(-hm - r_2_0, 0);
            addPosition(+hm + r_2_0, 0);
            addPosition(-hm - r_2_0, +vm + r_2_0);
            addPosition(0, +vm + r_2_0);
            addPosition(+hm + r_2_0, +vm + r_2_0);
            break;
        case VHPiecePlaceDOT_8_4:
            addPosition(0, -a_2_0 - c_2_0);
            addPosition(-hm_0_5 - r, -a - c);
            addPosition(+hm_0_5 + r, -a - c);
            addPosition(-b_2_0, 0);
            addPosition(+b_2_0, 0);
            addPosition(-hm_0_5 - r, +a + c);
            addPosition(+hm_0_5 + r, +a + c);
            addPosition(0, +a_2_0 + c_2_0);
            break;
        case VHPiecePlaceDOT_8_5:
            addPosition(0, -a_2_0);
            addPosition(-a, -a);
            addPosition(+a, -a);
            addPosition(-a_2_0, 0);
            addPosition(+a_2_0, 0);
            addPosition(-a, +a);
            addPosition(+a, +a);
            addPosition(0, +a_2_0);
            break;
        case VHPiecePlaceDOT_8_6:
            addPosition(-hm_1_5 - r_3_0, -vm_0_5 - r);
            addPosition(-hm_0_5 - r, -vm_0_5 - r);
            addPosition(+hm_0_5 + r, -vm_0_5 - r);
            addPosition(+hm_1_5 + r_3_0, -vm_0_5 - r);
            addPosition(-hm_1_5 - r_3_0, +vm_0_5 + r);
            addPosition(-hm_0_5 - r, +vm_0_5 + r);
            addPosition(+hm_0_5 + r, +vm_0_5 + r);
            addPosition(+hm_1_5 + r_3_0, +vm_0_5 + r);
            break;
        case VHPiecePlaceDOT_8_7:
            addPosition(-hm_0_5 - r, -vm_1_5 - r_3_0);
            addPosition(+hm_0_5 + r, -vm_1_5 - r_3_0);
            addPosition(-hm_0_5 - r, -vm_0_5 - r);
            addPosition(+hm_0_5 + r, -vm_0_5 - r);
            addPosition(-hm_0_5 - r, +vm_0_5 + r);
            addPosition(+hm_0_5 + r, +vm_0_5 + r);
            addPosition(-hm_0_5 - r, +vm_1_5 + r_3_0);
            addPosition(+hm_0_5 + r, +vm_1_5 + r_3_0);
            break;
        case VHPiecePlaceDOT_9_1:
            addPosition(-hm - r_2_0, -vm - r_2_0);
            addPosition(0, -vm - r_2_0);
            addPosition(+hm + r_2_0, -vm - r_2_0);
            addPosition(-hm - r_2_0, 0);
            addPosition(0, 0);
            addPosition(+hm + r_2_0, 0);
            addPosition(-hm - r_2_0, +vm + r_2_0);
            addPosition(0, +vm + r_2_0);
            addPosition(+hm + r_2_0, +vm + r_2_0);
            break;
        case VHPiecePlaceDOT_9_2:
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
        case VHPiecePlaceDOT_9_3:
            addPosition(0, -a_2_0);
            addPosition(+a, -a);
            addPosition(+a_2_0, 0);
            addPosition(+a, +a);
            addPosition(0, 0);
            addPosition(0, +a_2_0);
            addPosition(-a, +a);
            addPosition(-a_2_0, 0);
            addPosition(-a, -a);
            break;
        case VHPiecePlaceCustom:
            [positions addObjectsFromArray:bmb.customPiecePositions];
            break;
        default:
            NSAssert(NO, @"Piece place enum not found!");
            break;
    }
    
    [VHPiecePlaceManager adjustPositions:positions withX:parentFrame.size.width / 2 - r withY:parentFrame.size.height / 2 - r];
    for (int i = 0; i < positions.count; i++)
    {
        CGPoint point = [(NSValue *)[positions objectAtIndex:i] CGPointValue];
        [positions setObject:[NSValue valueWithCGRect:CGRectMake(point.x, point.y, r_2_0, r_2_0)] atIndexedSubscript:i];
    }
    
    return positions;
}

+ (NSMutableArray<NSValue *> *)hamPositions:(VHBoomMenuButton *)bmb
{
    CGRect parentFrame = bmb.bounds;
    
    int pn = (int)[VHPiecePlaceManager pieceNumber:bmb.piecePlaceEnum];
    int pn_0_5 = pn / 2;
    
    NSMutableArray *positions = [NSMutableArray array];
    
    CGFloat w = bmb.hamWidth;
    CGFloat w_0_5 = w / 2;
    CGFloat h = bmb.hamHeight;
    CGFloat h_0_5 = h / 2;
    
    CGFloat vm = bmb.pieceVerticalMargin;
    CGFloat vm_0_5 = vm / 2;
    
    if (bmb.piecePlaceEnum != VHPiecePlaceCustom)
    {
        if (pn % 2 == 0)
        {
            for (int i = pn_0_5 - 1; i >= 0; i--)
            {
                addPosition(0, -h_0_5 - vm_0_5 - i * (h + vm));
            }
            for (int i = 0; i < pn_0_5; i++)
            {
                addPosition(0, +h_0_5 + vm_0_5 + i * (h + vm));
            }
        }
        else
        {
            for (int i = pn_0_5 - 1; i >= 0; i--)
            {
                addPosition(0, -h - vm - i * (h + vm));
            }
            addPosition(0, 0)
            for (int i = 0; i < pn_0_5; i++)
            {
                addPosition(0, +h + vm + i * (h + vm));
            }
        }
    }
    else
    {
        [positions addObjectsFromArray:bmb.customPiecePositions];
    }
    
    [VHPiecePlaceManager adjustPositions:positions withX:parentFrame.size.width / 2 - w_0_5 withY:parentFrame.size.height / 2 - h_0_5];
    for (int i = 0; i < positions.count; i++)
    {
        CGPoint point = [(NSValue *)[positions objectAtIndex:i] CGPointValue];
        [positions setObject:[NSValue valueWithCGRect:CGRectMake(point.x, point.y, w, h)] atIndexedSubscript:i];
    }
    
    return positions;
}

+ (NSMutableArray<NSValue *> *)shareDotPositionsWithDotNumber:(NSUInteger)n withBoomMenuButton:(VHBoomMenuButton *)bmb
{
    CGRect parentFrame = bmb.bounds;
    
    NSMutableArray<NSValue *> *positions = [NSMutableArray array];
    
    CGFloat r = bmb.dotRadius;
    CGFloat h = bmb.shareLineLength * sqrt(3) / 3;
    CGFloat h_0_5 = h / 2;
    CGFloat l_0_5 = bmb.shareLineLength / 2;
    for (int i = 0; i < n; i++)
    {
        switch (i % 3)
        {
            case 0: addPosition(h_0_5, -l_0_5); break;
            case 1: addPosition(-h, 0); break;
            case 2: addPosition(h_0_5, +l_0_5); break;
        }
    }
    [positions sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        CGFloat y1 = [(NSValue *)obj1 CGPointValue].y;
        CGFloat y2 = [(NSValue *)obj2 CGPointValue].y;
        if (y1 < y2) return NSOrderedAscending;
        else if (y1 == y2) return NSOrderedSame;
        else return NSOrderedDescending;
    }];
    for (int i = 0; i < positions.count; i++)
    {
        CGPoint point = [(NSValue *)[positions objectAtIndex:i] CGPointValue];
        [positions setObject:[NSValue valueWithCGRect:CGRectMake(point.x + parentFrame.size.width / 2 - r,
                                                                 point.y + parentFrame.size.height / 2 - r,
                                                                 r + r,
                                                                 r + r)]
          atIndexedSubscript:i];
    }
    return positions;
}

+ (int)pieceNumber:(VHPiecePlaceEnum)placeEnum
{
    switch (placeEnum)
    {
        case VHPiecePlaceDOT_1:
        case VHPiecePlaceHAM_1:
            return 1;
        case VHPiecePlaceDOT_2_1:
        case VHPiecePlaceDOT_2_2:
        case VHPiecePlaceHAM_2:
            return 2;
        case VHPiecePlaceDOT_3_1:
        case VHPiecePlaceDOT_3_2:
        case VHPiecePlaceDOT_3_3:
        case VHPiecePlaceDOT_3_4:
        case VHPiecePlaceHAM_3:
            return 3;
        case VHPiecePlaceDOT_4_1:
        case VHPiecePlaceDOT_4_2:
        case VHPiecePlaceHAM_4:
            return 4;
        case VHPiecePlaceDOT_5_1:
        case VHPiecePlaceDOT_5_2:
        case VHPiecePlaceDOT_5_3:
        case VHPiecePlaceDOT_5_4:
        case VHPiecePlaceHAM_5:
            return 5;
        case VHPiecePlaceDOT_6_1:
        case VHPiecePlaceDOT_6_2:
        case VHPiecePlaceDOT_6_3:
        case VHPiecePlaceDOT_6_4:
        case VHPiecePlaceDOT_6_5:
        case VHPiecePlaceDOT_6_6:
        case VHPiecePlaceHAM_6:
            return 6;
        case VHPiecePlaceDOT_7_1:
        case VHPiecePlaceDOT_7_2:
        case VHPiecePlaceDOT_7_3:
        case VHPiecePlaceDOT_7_4:
        case VHPiecePlaceDOT_7_5:
        case VHPiecePlaceDOT_7_6:
            return 7;
        case VHPiecePlaceDOT_8_1:
        case VHPiecePlaceDOT_8_2:
        case VHPiecePlaceDOT_8_3:
        case VHPiecePlaceDOT_8_4:
        case VHPiecePlaceDOT_8_5:
        case VHPiecePlaceDOT_8_6:
        case VHPiecePlaceDOT_8_7:
            return 8;
        case VHPiecePlaceDOT_9_1:
        case VHPiecePlaceDOT_9_2:
        case VHPiecePlaceDOT_9_3:
            return 9;
        case VHPiecePlaceUnknown:
            return 0;
        case VHPiecePlaceShare:
        case VHPiecePlaceCustom:
        case VHPiecePlaceEnumCount:
            return -1;
    }
}

+ (int)minPieceNumber:(VHPiecePlaceEnum)placeEnum
{
    switch (placeEnum)
    {
        case VHPiecePlaceShare:
            return 3;
        case VHPiecePlaceCustom:
            return 1;
        case VHPiecePlaceUnknown:
            return 0;
        default:
            return -1;
    }
}

+ (int)maxPieceNumber:(VHPiecePlaceEnum)placeEnum
{
    switch (placeEnum)
    {
        case VHPiecePlaceShare:
        case VHPiecePlaceCustom:
            return INT_MAX;
            break;
        case VHPiecePlaceUnknown:
            return 0;
        default:
            return -1;
    }
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
