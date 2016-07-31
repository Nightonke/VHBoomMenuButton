//
//  VHButtonPlaceManager.m
//  VHBoomMenuExample
//
//  Created by 黄伟平 on 16/7/29.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import "VHButtonPlaceManager.h"

static const CGFloat simpleCircleButtonHorizontalMargin = 5;
static const CGFloat simpleCircleButtonVerticalMargin = 5;

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

- (NSMutableArray<NSValue *> *)positionsWithEnum:(VHButtonPlaceEnum)placeEnum withParentFrame:(CGRect)frame withButtonRadius:(CGFloat)radius;
{
    NSMutableArray *positions = [NSMutableArray array];
    
    switch (placeEnum) {
        case SC_1:
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(frame.size.width / 2,
                                                                       frame.size.height / 2)]];
            break;
        case SC_2:
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(frame.size.width / 2 - simpleCircleButtonHorizontalMargin / 2 - radius,
                                                                       frame.size.height / 2)]];
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(frame.size.width / 2 + simpleCircleButtonHorizontalMargin / 2 + radius,
                                                                       frame.size.height / 2)]];
        default:
            break;
    }
    return positions;
}

- (NSInteger)numbersWithEnum:(VHButtonPlaceEnum)placeEnum
{
    switch (placeEnum) {
        case SC_1:
            return 1;
        case SC_2:
            return 2;
    }
}

@end
