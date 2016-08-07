//
//  VHErrorManager.m
//  VHBoomMenuButton
//
//  Created by 黄伟平 on 16/8/2.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import "VHErrorManager.h"

@implementation VHErrorManager

+ (instancetype)sharedManager
{
    static VHErrorManager *sharedMyManager = nil;
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

- (void)errorJudgeWithPieceNumber:(long)pieceNumber andBuilderNumber:(long)builderNumber
{
    if (pieceNumber != builderNumber)
    {
        NSAssert(NO, @"The number of pieces(%ld) is not equal to button-builders'(%ld)! Please check the @piecePlaceEnum and size of @boomButtonBuilders of BMB!", pieceNumber, builderNumber);
    }
}

- (void)errorJudgeWithPiecePlaceEnum:(VHPiecePlaceEnum)pieceEnum andButtonPlaceEnum:(VHButtonPlaceEnum)buttonEnum
{
    long pieceNumber = [[VHPiecePlaceManager sharedManager] numbersWithEnum:pieceEnum];
    long buttonNumber = [[VHButtonPlaceManager sharedManager] numbersWithEnum:buttonEnum];
    if (buttonNumber == LONG_MAX)
    {
        return;
    }
    if (pieceNumber != buttonNumber)
    {
        NSAssert(NO, @"The number of pieces(%ld) is not equal to buttons'(%ld)! Please check the @piecePlaceEnum and @buttonPlaceEnum of BMB!", pieceNumber, buttonNumber);
    }
}

@end
