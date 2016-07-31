//
//  VHDotPlaceManager.m
//  VHBoomMenuExample
//
//  Created by 黄伟平 on 16/7/28.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import "VHPiecePlaceManager.h"

static const CGFloat dotHorizontalMargin = 2;
static const CGFloat dotVerticalMargin = 2;

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

- (NSMutableArray<NSValue *> *)positionsWithEnum:(VHPiecePlaceEnum)placeEnum withParentFrame:(CGRect)frame withDotRadius:(CGFloat)radius;
{
    NSMutableArray *positions = [NSMutableArray array];
    
    switch (placeEnum) {
        case DOT_1:
            [positions addObject:[NSValue valueWithCGRect:CGRectMake(frame.size.width / 2 - radius,
                                                                     frame.size.height / 2 - radius,
                                                                     2 * radius,
                                                                     2 * radius)]];
            break;
        case DOT_2:
            [positions addObject:[NSValue valueWithCGRect:CGRectMake(frame.size.width / 2 - dotHorizontalMargin / 2 - 2 * radius,
                                                                     frame.size.height / 2 - radius,
                                                                     2 * radius,
                                                                     2 * radius)]];
            [positions addObject:[NSValue valueWithCGRect:CGRectMake(frame.size.width / 2 + dotHorizontalMargin / 2,
                                                                     frame.size.height / 2 - radius,
                                                                     2 * radius,
                                                                    2 * radius)]];
            break;
    }
    return positions;
}

- (NSInteger)numbersWithEnum:(VHPiecePlaceEnum)placeEnum
{
    switch (placeEnum) {
        case DOT_1:
            return 1;
        case DOT_2:
            return 2;
    }
}

@end
