//
//  VHDotPlaceManager.m
//  VHBoomMenuExample
//
//  Created by 黄伟平 on 16/7/28.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import "VHPiecePlaceManager.h"

@implementation VHPiecePlaceManager

+ (instancetype)sharedManager
{
    static VHPiecePlaceManager *sharedMyManager = nil;
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

- (NSMutableArray<NSValue *> *)positionsWithEnum:(VHPiecePlaceEnum)placeEnum
                                 withParentFrame:(CGRect)frame
                                   withDotRadius:(CGFloat)radius
                            withHorizontalMargin:(CGFloat)dotHorizontalMargin
                              withVerticalMargin:(CGFloat)dotVerticalMargin
                              withInclinedMargin:(CGFloat)dotInclinedMargin
{
    NSMutableArray *positions = [NSMutableArray array];
    
    switch (placeEnum) {
        case VHPiecePlace_DOT_1:
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       0)]];
            break;
        case VHPiecePlace_DOT_2_1:
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-dotHorizontalMargin / 2 - radius,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(dotHorizontalMargin / 2 + radius,
                                                                       0)]];
            break;
        case VHPiecePlace_DOT_2_2:
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -dotVerticalMargin / 2 - radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       dotVerticalMargin / 2 + radius)]];
            break;
        case VHPiecePlace_DOT_3_1:
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-dotHorizontalMargin - 2 * radius,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(dotHorizontalMargin + 2 * radius,
                                                                       0)]];
            break;
        case VHPiecePlace_DOT_3_2:
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -dotVerticalMargin - 2 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       dotVerticalMargin + 2 * radius)]];
            break;
        case VHPiecePlace_DOT_3_3:
        {
            CGFloat a, b, c;
            b = dotHorizontalMargin / 2 + radius;
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
        case VHPiecePlace_DOT_3_4:
        {
            CGFloat a, b, c;
            b = dotHorizontalMargin / 2 + radius;
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
        case VHPiecePlace_DOT_4_1:
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-dotHorizontalMargin / 2 - radius,
                                                                       -dotVerticalMargin / 2 - radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(dotHorizontalMargin / 2 + radius,
                                                                       -dotVerticalMargin / 2 - radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-dotHorizontalMargin / 2 - radius,
                                                                       dotVerticalMargin / 2 + radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(dotHorizontalMargin / 2 + radius,
                                                                       dotVerticalMargin / 2 + radius)]];
            break;
        case VHPiecePlace_DOT_4_2:
        {
            CGFloat a = (2 * radius + dotInclinedMargin) / sqrt(2);
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
        case VHPiecePlace_DOT_5_1:
        {
            CGFloat a, b, c;
            b = dotHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-2 * b,
                                                                       -a)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -a)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(2 * b,
                                                                       -a)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-dotHorizontalMargin / 2 - radius,
                                                                       c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(dotHorizontalMargin / 2 + radius,
                                                                       c)]];
        }
            break;
        case VHPiecePlace_DOT_5_2:
        {
            CGFloat a, b, c;
            b = dotHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-dotHorizontalMargin / 2 - radius,
                                                                       -c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(dotHorizontalMargin / 2 + radius,
                                                                       -c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-2 * b,
                                                                       a)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       a)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(2 * b,
                                                                       a)]];

        }
            break;
        case VHPiecePlace_DOT_5_3:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -dotVerticalMargin - 2 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(dotHorizontalMargin + 2 * radius,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       dotVerticalMargin + 2 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-dotHorizontalMargin - 2 * radius,
                                                                       0)]];
        }
            break;
        case VHPiecePlace_DOT_5_4:
        {
            CGFloat a = (2 * radius + dotInclinedMargin) / sqrt(2);
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
        case VHPiecePlace_DOT_6_1:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-dotHorizontalMargin - 2 * radius,
                                                                       -dotVerticalMargin / 2 - radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -dotVerticalMargin / 2 - radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(dotHorizontalMargin + 2 * radius,
                                                                       -dotVerticalMargin / 2 - radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-dotHorizontalMargin - 2 * radius,
                                                                       dotVerticalMargin / 2 + radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       dotVerticalMargin / 2 + radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(dotHorizontalMargin + 2 * radius,
                                                                       dotVerticalMargin / 2 + radius)]];
        }
            break;
        case VHPiecePlace_DOT_6_2:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-dotHorizontalMargin / 2 - radius,
                                                                       -dotVerticalMargin - 2 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-dotHorizontalMargin / 2 - radius,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-dotHorizontalMargin / 2 - radius,
                                                                       dotVerticalMargin + 2 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(dotHorizontalMargin / 2 + radius,
                                                                       -dotVerticalMargin - 2 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(dotHorizontalMargin / 2 + radius,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(dotHorizontalMargin / 2 + radius,
                                                                       dotVerticalMargin + 2 * radius)]];
        }
            break;
        case VHPiecePlace_DOT_6_3:
        {
            CGFloat a, b, c;
            b = dotHorizontalMargin / 2 + radius;
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
        case VHPiecePlace_DOT_6_4:
        {
            CGFloat a, b, c;
            b = dotHorizontalMargin / 2 + radius;
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
        case VHPiecePlace_DOT_6_5:
        {
            CGFloat a, b, c, yError;
            b = dotHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            yError = c - a;
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-2 * b,
                                                                       -a - c + yError)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -a - c + yError)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(2 * b,
                                                                       -a - c + yError)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-dotHorizontalMargin / 2 - radius,
                                                                       0 + yError)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(dotHorizontalMargin / 2 + radius,
                                                                       0 + yError)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       a + c + yError)]];
        }
            break;
        case VHPiecePlace_DOT_6_6:
        {
            CGFloat a, b, c, yError;
            b = dotHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            yError = c - a;
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -a - c - yError)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-dotHorizontalMargin / 2 - radius,
                                                                       0 - yError)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(dotHorizontalMargin / 2 + radius,
                                                                       0 - yError)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-2 * b,
                                                                       a + c - yError)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       a + c - yError)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(2 * b,
                                                                       a + c - yError)]];
        }
            break;
        case VHPiecePlace_DOT_7_1:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-dotHorizontalMargin - 2 * radius,
                                                                       -dotVerticalMargin - 2 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -dotVerticalMargin - 2 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(dotHorizontalMargin + 2 * radius,
                                                                       -dotVerticalMargin - 2 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-dotHorizontalMargin - 2 * radius,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(dotHorizontalMargin + 2 * radius,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       dotVerticalMargin + 2 * radius)]];
        }
            break;
        case VHPiecePlace_DOT_7_2:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -dotVerticalMargin - 2 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-dotHorizontalMargin - 2 * radius,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(dotHorizontalMargin + 2 * radius,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-dotHorizontalMargin - 2 * radius,
                                                                       dotVerticalMargin + 2 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       dotVerticalMargin + 2 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(dotHorizontalMargin + 2 * radius,
                                                                       dotVerticalMargin + 2 * radius)]];
        }
            break;
        case VHPiecePlace_DOT_7_3:
        {
            CGFloat a, b, c;
            b = dotHorizontalMargin / 2 + radius;
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
        case VHPiecePlace_DOT_7_4:
        {
            CGFloat a, b, c;
            b = dotHorizontalMargin / 2 + radius;
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
        case VHPiecePlace_DOT_7_5:
        {
            CGFloat a, b, c;
            b = dotHorizontalMargin / 2 + radius;
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
        case VHPiecePlace_DOT_7_6:
        {
            CGFloat a, b, c;
            b = dotHorizontalMargin / 2 + radius;
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
        case VHPiecePlace_DOT_8_1:
        {
            CGFloat a, b, c;
            b = dotHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-2 * b,
                                                                       -a - c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -a - c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(2 * b,
                                                                       -a - c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-dotHorizontalMargin / 2 - radius,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(dotHorizontalMargin / 2 + radius,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-2 * b,
                                                                       a + c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       a + c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(2 * b,
                                                                       a + c)]];
        }
            break;
        case VHPiecePlace_DOT_8_2:
        {
            CGFloat a, b, c;
            b = dotVerticalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-a - c,
                                                                       -2 * b)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-a - c,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-a - c,
                                                                       2 * b)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -dotVerticalMargin / 2 - radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       dotVerticalMargin / 2 + radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(a + c,
                                                                       -2 * b)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(a + c,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(a + c,
                                                                       2 * b)]];
        }
            break;
        case VHPiecePlace_DOT_8_3:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-dotHorizontalMargin - 2 * radius,
                                                                       -dotVerticalMargin - 2 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -dotVerticalMargin - 2 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(dotHorizontalMargin + 2 * radius,
                                                                       -dotVerticalMargin - 2 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-dotHorizontalMargin - 2 * radius,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(dotHorizontalMargin + 2 * radius,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-dotHorizontalMargin - 2 * radius,
                                                                       dotVerticalMargin + 2 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       dotVerticalMargin + 2 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(dotHorizontalMargin + 2 * radius,
                                                                       dotVerticalMargin + 2 * radius)]];
        }
            break;
        case VHPiecePlace_DOT_8_4:
        {
            CGFloat a, b, c;
            b = dotHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -2 * a - 2 * c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-dotHorizontalMargin / 2 - radius,
                                                                       -a - c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(dotHorizontalMargin / 2 + radius,
                                                                       -a - c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-2 * b,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(2 * b,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-dotHorizontalMargin / 2 - radius,
                                                                       a + c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(dotHorizontalMargin / 2 + radius,
                                                                       a + c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       2 * a + 2 * c)]];
        }
            break;
        case VHPiecePlace_DOT_8_5:
        {
            CGFloat a = (2 * radius + dotInclinedMargin) / sqrt(2);
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
        case VHPiecePlace_DOT_8_6:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-dotHorizontalMargin * 3 / 2 - 3 * radius,
                                                                       -dotVerticalMargin / 2 - radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-dotHorizontalMargin / 2 - radius,
                                                                       -dotVerticalMargin / 2 - radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(dotHorizontalMargin / 2 + radius,
                                                                       -dotVerticalMargin / 2 - radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(dotHorizontalMargin * 3 / 2 + 3 * radius,
                                                                       -dotVerticalMargin / 2 - radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-dotHorizontalMargin * 3 / 2 - 3 * radius,
                                                                       dotVerticalMargin / 2 + radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-dotHorizontalMargin / 2 - radius,
                                                                       dotVerticalMargin / 2 + radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(dotHorizontalMargin / 2 + radius,
                                                                       dotVerticalMargin / 2 + radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(dotHorizontalMargin * 3 / 2 + 3 * radius,
                                                                       dotVerticalMargin / 2 + radius)]];
        }
            break;
        case VHPiecePlace_DOT_8_7:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-dotHorizontalMargin / 2 - radius,
                                                                       -dotVerticalMargin * 3 / 2 - 3 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(dotHorizontalMargin / 2 + radius,
                                                                       -dotVerticalMargin * 3 / 2 - 3 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-dotHorizontalMargin / 2 - radius,
                                                                       -dotVerticalMargin / 2 - radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(dotHorizontalMargin / 2 + radius,
                                                                       -dotVerticalMargin / 2 - radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-dotHorizontalMargin / 2 - radius,
                                                                       dotVerticalMargin / 2 + radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(dotHorizontalMargin / 2 + radius,
                                                                       dotVerticalMargin / 2 + radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-dotHorizontalMargin / 2 - radius,
                                                                       dotVerticalMargin * 3 / 2 + 3 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(dotHorizontalMargin / 2 + radius,
                                                                       dotVerticalMargin * 3 / 2 + 3 * radius)]];
        }
            break;
        case VHPiecePlace_DOT_9_1:
        {
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-dotHorizontalMargin - 2 * radius,
                                                                       -dotVerticalMargin - 2 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -dotVerticalMargin - 2 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(dotHorizontalMargin + 2 * radius,
                                                                       -dotVerticalMargin - 2 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-dotHorizontalMargin - 2 * radius,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(dotHorizontalMargin + 2 * radius,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-dotHorizontalMargin - 2 * radius,
                                                                       dotVerticalMargin + 2 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       dotVerticalMargin + 2 * radius)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(dotHorizontalMargin + 2 * radius,
                                                                       dotVerticalMargin + 2 * radius)]];
        }
            break;
        case VHPiecePlace_DOT_9_2:
        {
            CGFloat a, b, c;
            b = dotHorizontalMargin / 2 + radius;
            c = b / (sqrt(3) / 2);
            a = c / 2;
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -2 * a - 2 * c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-dotHorizontalMargin / 2 - radius,
                                                                       -a - c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(dotHorizontalMargin / 2 + radius,
                                                                       -a - c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-2 * b,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(2 * b,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(-dotHorizontalMargin / 2 - radius,
                                                                       a + c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(dotHorizontalMargin / 2 + radius,
                                                                       a + c)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       2 * a + 2 * c)]];
        }
            break;
        case VHPiecePlace_DOT_9_3:
        {
            CGFloat a = (2 * radius + dotInclinedMargin) / sqrt(2);
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

- (NSMutableArray<NSValue *> *)positionsWithEnum:(VHPiecePlaceEnum)placeEnum
                                 withParentFrame:(CGRect)frame
                                    withHamWidth:(CGFloat)width
                                   withHamHeight:(CGFloat)height
                            withHorizontalMargin:(CGFloat)dotHorizontalMargin
                              withVerticalMargin:(CGFloat)dotVerticalMargin
{
    NSMutableArray *positions = [NSMutableArray array];
    
    switch (placeEnum) {
        case VHPiecePlace_HAM_1:
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       0)]];
            break;
        case VHPiecePlace_HAM_2:
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -dotVerticalMargin / 2 - height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       dotVerticalMargin / 2 + height / 2)]];
            break;
        case VHPiecePlace_HAM_3:
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -dotVerticalMargin - height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       dotVerticalMargin + height)]];
            break;
        case VHPiecePlace_HAM_4:
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -dotVerticalMargin * 3 / 2 - height * 3 / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -dotVerticalMargin / 2 - height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       dotVerticalMargin / 2 + height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       dotVerticalMargin * 3 / 2 + height * 3 / 2)]];
            break;
        case VHPiecePlace_HAM_5:
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -dotVerticalMargin * 2 - height * 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       -dotVerticalMargin - height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       0)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       dotVerticalMargin + height)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(0,
                                                                       dotVerticalMargin * 2 + height * 2)]];
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

- (NSInteger)numbersWithEnum:(VHPiecePlaceEnum)placeEnum
{
    switch (placeEnum) {
        case VHPiecePlace_DOT_1:
        case VHPiecePlace_HAM_1:
            return 1;
        case VHPiecePlace_DOT_2_1:
        case VHPiecePlace_DOT_2_2:
        case VHPiecePlace_HAM_2:
            return 2;
        case VHPiecePlace_DOT_3_1:
        case VHPiecePlace_DOT_3_2:
        case VHPiecePlace_DOT_3_3:
        case VHPiecePlace_DOT_3_4:
        case VHPiecePlace_HAM_3:
            return 3;
        case VHPiecePlace_DOT_4_1:
        case VHPiecePlace_DOT_4_2:
        case VHPiecePlace_HAM_4:
            return 4;
        case VHPiecePlace_DOT_5_1:
        case VHPiecePlace_DOT_5_2:
        case VHPiecePlace_DOT_5_3:
        case VHPiecePlace_DOT_5_4:
        case VHPiecePlace_HAM_5:
            return 5;
        case VHPiecePlace_DOT_6_1:
        case VHPiecePlace_DOT_6_2:
        case VHPiecePlace_DOT_6_3:
        case VHPiecePlace_DOT_6_4:
        case VHPiecePlace_DOT_6_5:
        case VHPiecePlace_DOT_6_6:
            return 6;
        case VHPiecePlace_DOT_7_1:
        case VHPiecePlace_DOT_7_2:
        case VHPiecePlace_DOT_7_3:
        case VHPiecePlace_DOT_7_4:
        case VHPiecePlace_DOT_7_5:
        case VHPiecePlace_DOT_7_6:
            return 7;
        case VHPiecePlace_DOT_8_1:
        case VHPiecePlace_DOT_8_2:
        case VHPiecePlace_DOT_8_3:
        case VHPiecePlace_DOT_8_4:
        case VHPiecePlace_DOT_8_5:
        case VHPiecePlace_DOT_8_6:
        case VHPiecePlace_DOT_8_7:
            return 8;
        case VHPiecePlace_DOT_9_1:
        case VHPiecePlace_DOT_9_2:
        case VHPiecePlace_DOT_9_3:
            return 9;
    }
}

@end
