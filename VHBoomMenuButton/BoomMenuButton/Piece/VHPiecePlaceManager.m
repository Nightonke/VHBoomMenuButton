//
//  VHDotPlaceManager.m
//  VHBoomMenuExample
//
//  Created by Nightonke on 16/7/28.
//  Copyright © 2016年 Nightonke. All rights reserved.
//

#import "VHPiecePlaceManager.h"

#define ADD_POINT(a, b) [positions addObject:[NSValue valueWithCGPoint:CGPointMake(a, b)]];

@implementation VHPiecePlaceManager

+ (NSMutableArray<NSValue *> *)positionsWithEnum:(VHPiecePlaceEnum)placeEnum
                                 withParentFrame:(CGRect)frame
                                   withDotRadius:(CGFloat)radius
                            withHorizontalMargin:(CGFloat)dotHorizontalMargin
                              withVerticalMargin:(CGFloat)dotVerticalMargin
                              withInclinedMargin:(CGFloat)dotInclinedMargin
{
    NSMutableArray *positions = [NSMutableArray arrayWithCapacity:[VHPiecePlaceManager pieceNumber:placeEnum]];
    
    switch (placeEnum) {
        case VHPiecePlaceDOT_1:
            ADD_POINT(0, 0);
            break;
        case VHPiecePlaceDOT_2_1:
            ADD_POINT(-dotHorizontalMargin / 2 - radius, 0);
            ADD_POINT(+dotHorizontalMargin / 2 + radius, 0);
            break;
        case VHPiecePlaceDOT_2_2:
            ADD_POINT(0, -dotVerticalMargin / 2 - radius);
            ADD_POINT(0, +dotVerticalMargin / 2 + radius);
            break;
        case VHPiecePlaceDOT_3_1:
            ADD_POINT(-dotHorizontalMargin - 2 * radius, 0);
            ADD_POINT(0, 0);
            ADD_POINT(+dotHorizontalMargin + 2 * radius, 0);
            break;
        case VHPiecePlaceDOT_3_2:
            ADD_POINT(0, -dotVerticalMargin - 2 * radius);
            ADD_POINT(0, 0);
            ADD_POINT(0, +dotVerticalMargin + 2 * radius);
            break;
        case VHPiecePlaceDOT_3_3:
        {
            CGFloat a, b, c;
            b = dotHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            ADD_POINT(-b, -a);
            ADD_POINT(+b, -a);
            ADD_POINT(0, c);
        }
            break;
        case VHPiecePlaceDOT_3_4:
        {
            CGFloat a, b, c;
            b = dotHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            ADD_POINT(0, -c);
            ADD_POINT(-b, a);
            ADD_POINT(+b, a);
        }
            break;
        case VHPiecePlaceDOT_4_1:
            ADD_POINT(-dotHorizontalMargin / 2 - radius, -dotVerticalMargin / 2 - radius);
            ADD_POINT(+dotHorizontalMargin / 2 + radius, -dotVerticalMargin / 2 - radius);
            ADD_POINT(-dotHorizontalMargin / 2 - radius, +dotVerticalMargin / 2 + radius);
            ADD_POINT(+dotHorizontalMargin / 2 + radius, +dotVerticalMargin / 2 + radius);
            break;
        case VHPiecePlaceDOT_4_2:
        {
            CGFloat a = (2 * radius + dotInclinedMargin) / sqrt(2);
            ADD_POINT(0, -a);
            ADD_POINT(+a, 0);
            ADD_POINT(0, +a);
            ADD_POINT(-a, 0);
        }
            break;
        case VHPiecePlaceDOT_5_1:
        {
            CGFloat a, b, c;
            b = dotHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            ADD_POINT(-2 * b, -a);
            ADD_POINT(0, -a);
            ADD_POINT(+2 * b, -a);
            ADD_POINT(-dotHorizontalMargin / 2 - radius, c);
            ADD_POINT(+dotHorizontalMargin / 2 + radius, c);
        }
            break;
        case VHPiecePlaceDOT_5_2:
        {
            CGFloat a, b, c;
            b = dotHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            ADD_POINT(-dotHorizontalMargin / 2 - radius, -c);
            ADD_POINT(+dotHorizontalMargin / 2 + radius, -c);
            ADD_POINT(-2 * b, a);
            ADD_POINT(0, a);
            ADD_POINT(+2 * b, a);

        }
            break;
        case VHPiecePlaceDOT_5_3:
        {
            ADD_POINT(0, 0);
            ADD_POINT(0, -dotVerticalMargin - 2 * radius);
            ADD_POINT(+dotHorizontalMargin + 2 * radius, 0);
            ADD_POINT(0, +dotVerticalMargin + 2 * radius);
            ADD_POINT(-dotHorizontalMargin - 2 * radius, 0);
        }
            break;
        case VHPiecePlaceDOT_5_4:
        {
            CGFloat a = (2 * radius + dotInclinedMargin) / sqrt(2);
            ADD_POINT(0, 0);
            ADD_POINT(+a, -a);
            ADD_POINT(+a, +a);
            ADD_POINT(-a, +a);
            ADD_POINT(-a, -a);
        }
            break;
        case VHPiecePlaceDOT_6_1:
        {
            ADD_POINT(-dotHorizontalMargin - 2 * radius, -dotVerticalMargin / 2 - radius);
            ADD_POINT(0, -dotVerticalMargin / 2 - radius);
            ADD_POINT(+dotHorizontalMargin + 2 * radius, -dotVerticalMargin / 2 - radius);
            ADD_POINT(-dotHorizontalMargin - 2 * radius, +dotVerticalMargin / 2 + radius);
            ADD_POINT(0, +dotVerticalMargin / 2 + radius);
            ADD_POINT(+dotHorizontalMargin + 2 * radius, +dotVerticalMargin / 2 + radius);
        }
            break;
        case VHPiecePlaceDOT_6_2:
        {
            ADD_POINT(-dotHorizontalMargin / 2 - radius, -dotVerticalMargin - 2 * radius);
            ADD_POINT(-dotHorizontalMargin / 2 - radius, 0);
            ADD_POINT(-dotHorizontalMargin / 2 - radius, +dotVerticalMargin + 2 * radius);
            ADD_POINT(+dotHorizontalMargin / 2 + radius, -dotVerticalMargin - 2 * radius);
            ADD_POINT(+dotHorizontalMargin / 2 + radius, 0);
            ADD_POINT(+dotHorizontalMargin / 2 + radius, +dotVerticalMargin + 2 * radius);
        }
            break;
        case VHPiecePlaceDOT_6_3:
        {
            CGFloat a, b, c;
            b = dotHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            ADD_POINT(-b, -a - c);
            ADD_POINT(+b, -a - c);
            ADD_POINT(+2 * b, 0);
            ADD_POINT(+b, a + c);
            ADD_POINT(-b, a + c);
            ADD_POINT(-2 * b, 0);
        }
            break;
        case VHPiecePlaceDOT_6_4:
        {
            CGFloat a, b, c;
            b = dotHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            ADD_POINT(0, -2 * b);
            ADD_POINT(+a + c, -b);
            ADD_POINT(+a + c, +b);
            ADD_POINT(0, +2 * b);
            ADD_POINT(-a - c, +b);
            ADD_POINT(-a - c, -b);
        }
            break;
        case VHPiecePlaceDOT_6_5:
        {
            CGFloat a, b, c, e;
            b = dotHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            e = c - a;
            ADD_POINT(-2 * b, -a - c + e);
            ADD_POINT(0, -a - c + e);
            ADD_POINT(+2 * b, -a - c + e);
            ADD_POINT(-dotHorizontalMargin / 2 - radius, e);
            ADD_POINT(+dotHorizontalMargin / 2 + radius, e);
            ADD_POINT(0, +a + c + e);
        }
            break;
        case VHPiecePlaceDOT_6_6:
        {
            CGFloat a, b, c, e;
            b = dotHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            e = c - a;
            ADD_POINT(0, -a - c - e);
            ADD_POINT(-dotHorizontalMargin / 2 - radius, -e);
            ADD_POINT(+dotHorizontalMargin / 2 + radius, -e);
            ADD_POINT(-2 * b, a + c - e);
            ADD_POINT(0, +a + c - e);
            ADD_POINT(+2 * b, a + c - e);
        }
            break;
        case VHPiecePlaceDOT_7_1:
        {
            ADD_POINT(-dotHorizontalMargin - 2 * radius, -dotVerticalMargin - 2 * radius);
            ADD_POINT(0, -dotVerticalMargin - 2 * radius);
            ADD_POINT(+dotHorizontalMargin + 2 * radius, -dotVerticalMargin - 2 * radius);
            ADD_POINT(-dotHorizontalMargin - 2 * radius, 0);
            ADD_POINT(0, 0);
            ADD_POINT(+dotHorizontalMargin + 2 * radius, 0);
            ADD_POINT(0, +dotVerticalMargin + 2 * radius);
        }
            break;
        case VHPiecePlaceDOT_7_2:
        {
            ADD_POINT(0, -dotVerticalMargin - 2 * radius);
            ADD_POINT(-dotHorizontalMargin - 2 * radius, 0);
            ADD_POINT(0, 0);
            ADD_POINT(+dotHorizontalMargin + 2 * radius, 0);
            ADD_POINT(-dotHorizontalMargin - 2 * radius, dotVerticalMargin + 2 * radius);
            ADD_POINT(0, +dotVerticalMargin + 2 * radius);
            ADD_POINT(+dotHorizontalMargin + 2 * radius, dotVerticalMargin + 2 * radius);
        }
            break;
        case VHPiecePlaceDOT_7_3:
        {
            CGFloat a, b, c;
            b = dotHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            ADD_POINT(0, 0);
            ADD_POINT(-b, -a - c);
            ADD_POINT(+b, -a - c);
            ADD_POINT(+2 * b, 0);
            ADD_POINT(+b, a + c);
            ADD_POINT(-b, a + c);
            ADD_POINT(-2 * b, 0);
        }
            break;
        case VHPiecePlaceDOT_7_4:
        {
            CGFloat a, b, c;
            b = dotHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            ADD_POINT(0, 0);
            ADD_POINT(0, -2 * b);
            ADD_POINT(a + c, -b);
            ADD_POINT(a + c, +b);
            ADD_POINT(0, +2 * b);
            ADD_POINT(-a - c, +b);
            ADD_POINT(-a - c, -b);
        }
            break;
        case VHPiecePlaceDOT_7_5:
        {
            CGFloat a, b, c;
            b = dotHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            ADD_POINT(-3 * b, -a);
            ADD_POINT(-b, -a);
            ADD_POINT(+b, -a);
            ADD_POINT(+3 * b, -a);
            ADD_POINT(-2 * b, c);
            ADD_POINT(0, c);
            ADD_POINT(+2 * b, c);
        }
            break;
        case VHPiecePlaceDOT_7_6:
        {
            CGFloat a, b, c;
            b = dotHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            ADD_POINT(-2 * b, -c);
            ADD_POINT(0, -c);
            ADD_POINT(+2 * b, -c);
            ADD_POINT(-3 * b, a);
            ADD_POINT(-b, a);
            ADD_POINT(+b, a);
            ADD_POINT(+3 * b, a);
        }
            break;
        case VHPiecePlaceDOT_8_1:
        {
            CGFloat a, b, c;
            b = dotHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            ADD_POINT(-2 * b, -a - c);
            ADD_POINT(0, -a - c);
            ADD_POINT(+2 * b, -a - c);
            ADD_POINT(-dotHorizontalMargin / 2 - radius, 0);
            ADD_POINT(+dotHorizontalMargin / 2 + radius, 0);
            ADD_POINT(-2 * b, a + c);
            ADD_POINT(0, +a + c);
            ADD_POINT(+2 * b, a + c);
        }
            break;
        case VHPiecePlaceDOT_8_2:
        {
            CGFloat a, b, c;
            b = dotVerticalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            ADD_POINT(-a - c, -2 * b);
            ADD_POINT(-a - c, 0);
            ADD_POINT(-a - c, +2 * b);
            ADD_POINT(0, -dotVerticalMargin / 2 - radius);
            ADD_POINT(0, +dotVerticalMargin / 2 + radius);
            ADD_POINT(+a + c, -2 * b);
            ADD_POINT(+a + c, 0);
            ADD_POINT(+a + c, +2 * b);
        }
            break;
        case VHPiecePlaceDOT_8_3:
        {
            ADD_POINT(-dotHorizontalMargin - 2 * radius, -dotVerticalMargin - 2 * radius);
            ADD_POINT(0, -dotVerticalMargin - 2 * radius);
            ADD_POINT(+dotHorizontalMargin + 2 * radius, -dotVerticalMargin - 2 * radius);
            ADD_POINT(-dotHorizontalMargin - 2 * radius, 0);
            ADD_POINT(+dotHorizontalMargin + 2 * radius, 0);
            ADD_POINT(-dotHorizontalMargin - 2 * radius, +dotVerticalMargin + 2 * radius);
            ADD_POINT(0, +dotVerticalMargin + 2 * radius);
            ADD_POINT(+dotHorizontalMargin + 2 * radius, +dotVerticalMargin + 2 * radius);
        }
            break;
        case VHPiecePlaceDOT_8_4:
        {
            CGFloat a, b, c;
            b = dotHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            ADD_POINT(0, -2 * a - 2 * c);
            ADD_POINT(-dotHorizontalMargin / 2 - radius, -a - c);
            ADD_POINT(+dotHorizontalMargin / 2 + radius, -a - c);
            ADD_POINT(-2 * b, 0);
            ADD_POINT(+2 * b, 0);
            ADD_POINT(-dotHorizontalMargin / 2 - radius, +a + c);
            ADD_POINT(+dotHorizontalMargin / 2 + radius, +a + c);
            ADD_POINT(0, +2 * a + 2 * c);
        }
            break;
        case VHPiecePlaceDOT_8_5:
        {
            CGFloat a = (2 * radius + dotInclinedMargin) / sqrt(2);
            ADD_POINT(0, -2 * a);
            ADD_POINT(+a, -a);
            ADD_POINT(+2 * a, 0);
            ADD_POINT(+a, +a);
            ADD_POINT(0, +2 * a);
            ADD_POINT(-a, +a);
            ADD_POINT(-2 * a, 0);
            ADD_POINT(-a, -a);
        }
            break;
        case VHPiecePlaceDOT_8_6:
        {
            ADD_POINT(-dotHorizontalMargin * 3 / 2 - 3 * radius, -dotVerticalMargin / 2 - radius);
            ADD_POINT(-dotHorizontalMargin / 2 - radius, -dotVerticalMargin / 2 - radius);
            ADD_POINT(+dotHorizontalMargin / 2 + radius, -dotVerticalMargin / 2 - radius);
            ADD_POINT(+dotHorizontalMargin * 3 / 2 + 3 * radius, -dotVerticalMargin / 2 - radius);
            ADD_POINT(-dotHorizontalMargin * 3 / 2 - 3 * radius, +dotVerticalMargin / 2 + radius);
            ADD_POINT(-dotHorizontalMargin / 2 - radius, +dotVerticalMargin / 2 + radius);
            ADD_POINT(+dotHorizontalMargin / 2 + radius, +dotVerticalMargin / 2 + radius);
            ADD_POINT(+dotHorizontalMargin * 3 / 2 + 3 * radius, +dotVerticalMargin / 2 + radius);
        }
            break;
        case VHPiecePlaceDOT_8_7:
        {
            ADD_POINT(-dotHorizontalMargin / 2 - radius, -dotVerticalMargin * 3 / 2 - 3 * radius);
            ADD_POINT(+dotHorizontalMargin / 2 + radius, -dotVerticalMargin * 3 / 2 - 3 * radius);
            ADD_POINT(-dotHorizontalMargin / 2 - radius, -dotVerticalMargin / 2 - radius);
            ADD_POINT(+dotHorizontalMargin / 2 + radius, -dotVerticalMargin / 2 - radius);
            ADD_POINT(-dotHorizontalMargin / 2 - radius, +dotVerticalMargin / 2 + radius);
            ADD_POINT(+dotHorizontalMargin / 2 + radius, +dotVerticalMargin / 2 + radius);
            ADD_POINT(-dotHorizontalMargin / 2 - radius, +dotVerticalMargin * 3 / 2 + 3 * radius);
            ADD_POINT(+dotHorizontalMargin / 2 + radius, +dotVerticalMargin * 3 / 2 + 3 * radius);
        }
            break;
        case VHPiecePlaceDOT_9_1:
        {
            ADD_POINT(-dotHorizontalMargin - 2 * radius, -dotVerticalMargin - 2 * radius);
            ADD_POINT(0, -dotVerticalMargin - 2 * radius);
            ADD_POINT(+dotHorizontalMargin + 2 * radius, -dotVerticalMargin - 2 * radius);
            ADD_POINT(-dotHorizontalMargin - 2 * radius, 0);
            ADD_POINT(0, 0);
            ADD_POINT(+dotHorizontalMargin + 2 * radius, 0);
            ADD_POINT(-dotHorizontalMargin - 2 * radius, +dotVerticalMargin + 2 * radius);
            ADD_POINT(0, +dotVerticalMargin + 2 * radius);
            ADD_POINT(+dotHorizontalMargin + 2 * radius, +dotVerticalMargin + 2 * radius);
        }
            break;
        case VHPiecePlaceDOT_9_2:
        {
            CGFloat a, b, c;
            b = dotHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            ADD_POINT(0, -2 * a - 2 * c);
            ADD_POINT(-dotHorizontalMargin / 2 - radius, -a - c);
            ADD_POINT(+dotHorizontalMargin / 2 + radius, -a - c);
            ADD_POINT(-2 * b, 0);
            ADD_POINT(0, 0);
            ADD_POINT(+2 * b, 0);
            ADD_POINT(-dotHorizontalMargin / 2 - radius, +a + c);
            ADD_POINT(+dotHorizontalMargin / 2 + radius, +a + c);
            ADD_POINT(0, +2 * a + 2 * c);
        }
            break;
        case VHPiecePlaceDOT_9_3:
        {
            CGFloat a = (2 * radius + dotInclinedMargin) / sqrt(2);
            ADD_POINT(0, -2 * a);
            ADD_POINT(+a, -a);
            ADD_POINT(+2 * a, 0);
            ADD_POINT(+a, +a);
            ADD_POINT(0, 0);
            ADD_POINT(0, +2 * a);
            ADD_POINT(-a, +a);
            ADD_POINT(-2 * a, 0);
            ADD_POINT(-a, -a);
        }
            break;
        default:
            NSAssert(NO, @"Piece place enum not found!");
            break;
    }
    
    for (int i = 0; i < positions.count; i++)
    {
        CGPoint point = [(NSValue *)[positions objectAtIndex:i] CGPointValue];
        [positions setObject:[NSValue valueWithCGRect:CGRectMake(point.x + frame.size.width / 2 - radius,
                                                                 point.y + frame.size.height / 2 - radius,
                                                                 2 * radius,
                                                                 2 * radius)]
          atIndexedSubscript:i];
    }
    
    return positions;
}

+ (NSMutableArray<NSValue *> *)positionsWithEnum:(VHPiecePlaceEnum)placeEnum
                                 withParentFrame:(CGRect)frame
                                    withHamWidth:(CGFloat)width
                                   withHamHeight:(CGFloat)height
                            withHorizontalMargin:(CGFloat)dotHorizontalMargin
                              withVerticalMargin:(CGFloat)dotVerticalMargin
{
    NSMutableArray *positions = [NSMutableArray arrayWithCapacity:[VHPiecePlaceManager pieceNumber:placeEnum]];
    
    switch (placeEnum) {
        case VHPiecePlaceHAM_1:
            ADD_POINT(0, 0);
            break;
        case VHPiecePlaceHAM_2:
            ADD_POINT(0, -dotVerticalMargin / 2 - height / 2);
            ADD_POINT(0, dotVerticalMargin / 2 + height / 2);
            break;
        case VHPiecePlaceHAM_3:
            ADD_POINT(0, -dotVerticalMargin - height);
            ADD_POINT(0, 0);
            ADD_POINT(0, dotVerticalMargin + height);
            break;
        case VHPiecePlaceHAM_4:
            ADD_POINT(0, -dotVerticalMargin * 3 / 2 - height * 3 / 2);
            ADD_POINT(0, -dotVerticalMargin / 2 - height / 2);
            ADD_POINT(0, dotVerticalMargin / 2 + height / 2);
            ADD_POINT(0, dotVerticalMargin * 3 / 2 + height * 3 / 2);
            break;
        case VHPiecePlaceHAM_5:
            ADD_POINT(0, -dotVerticalMargin * 2 - height * 2);
            ADD_POINT(0, -dotVerticalMargin - height);
            ADD_POINT(0, 0);
            ADD_POINT(0, dotVerticalMargin + height);
            ADD_POINT(0, dotVerticalMargin * 2 + height * 2);
            break;
        case VHPiecePlaceHAM_6:
            ADD_POINT(0, -dotVerticalMargin * 5 / 2 - height * 5 / 2);
            ADD_POINT(0, -dotVerticalMargin * 3 / 2 - height * 3 / 2);
            ADD_POINT(0, -dotVerticalMargin / 2 - height / 2);
            ADD_POINT(0, dotVerticalMargin / 2 + height / 2);
            ADD_POINT(0, dotVerticalMargin * 3 / 2 + height * 3 / 2);
            ADD_POINT(0, dotVerticalMargin * 5 / 2 + height * 5 / 2);
            break;
        default:
            NSAssert(NO, @"Piece place enum not found!");
            break;
    }
    
    for (int i = 0; i < positions.count; i++)
    {
        CGPoint point = [(NSValue *)[positions objectAtIndex:i] CGPointValue];
        [positions setObject:[NSValue valueWithCGRect:CGRectMake(point.x + frame.size.width / 2 - width / 2,
                                                                 point.y + frame.size.height / 2 - height / 2,
                                                                 width,
                                                                 height)]
          atIndexedSubscript:i];
    }
    
    return positions;
}

+ (NSMutableArray<NSValue *> *)positionsForShareStyleWithParentFrame:(CGRect)frame
                                                       withDotRadius:(CGFloat)radius
                                                       withDotNumber:(NSUInteger)dotNumber
                                                 withShareLineLength:(CGFloat)shareLineLength
{
    NSMutableArray<NSValue *> *positions = [NSMutableArray arrayWithCapacity:dotNumber];
    CGFloat h = shareLineLength * sqrt(3) / 3;
    for (int i = 0; i < dotNumber; i++)
    {
        switch (i % 3)
        {
            case 0: ADD_POINT(h / 2, -shareLineLength / 2); break;
            case 1: ADD_POINT(-h, 0); break;
            case 2: ADD_POINT(h / 2, shareLineLength / 2); break;
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
        [positions setObject:[NSValue valueWithCGRect:CGRectMake(point.x + frame.size.width / 2 - radius,
                                                                 point.y + frame.size.height / 2 - radius,
                                                                 2 * radius,
                                                                 2 * radius)]
          atIndexedSubscript:i];
    }
    return positions;
}

+ (NSInteger)pieceNumber:(VHPiecePlaceEnum)placeEnum
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
        case VHPiecePlaceEnumCount:
            return -1;
    }
}

+ (NSInteger)minPieceNumber:(VHPiecePlaceEnum)placeEnum
{
    switch (placeEnum)
    {
        case VHPiecePlaceShare:
            return 3;
            break;
        case VHPiecePlaceUnknown:
            return 0;
        default:
            return -1;
    }
}

+ (NSInteger)maxPieceNumber:(VHPiecePlaceEnum)placeEnum
{
    switch (placeEnum)
    {
        case VHPiecePlaceShare:
            return 9;
            break;
        case VHPiecePlaceUnknown:
            return 0;
        default:
            return -1;
    }
}

@end
