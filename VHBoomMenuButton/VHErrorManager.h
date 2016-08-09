//
//  VHErrorManager.h
//  VHBoomMenuButton
//
//  Created by 黄伟平 on 16/8/2.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VHPiecePlaceManager.h"
#import "VHPiecePlaceEnum.h"
#import "VHButtonPlaceManager.h"
#import "VHButtonPlaceEnum.h"

@interface VHErrorManager : NSObject

+ (instancetype)sharedManager;

/**
 *  Judge whether the number of pieces and the number of builders are the same
 *
 *  @param pieceNumber   Number of pieces
 *  @param builderNumber Number of builders
 */
- (void)errorJudgeWithPieceNumber:(long)pieceNumber andBuilderNumber:(long)builderNumber;

- (void)errorJudgeWithPiecePlaceEnum:(VHPiecePlaceEnum)pieceEnum andButtonPlaceEnum:(VHButtonPlaceEnum)buttonEnum;

@end
