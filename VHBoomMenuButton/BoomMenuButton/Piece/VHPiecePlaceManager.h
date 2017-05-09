//
//  VHDotPlaceManager.h
//  VHBoomMenuExample
//
//  Created by Nightonke on 16/7/28.
//  Copyright © 2016 Nightonke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VHPiecePlaceEnum.h"
#import "VHBoomMenuButton.h"

@interface VHPiecePlaceManager : NSObject

+ (NSMutableArray<NSValue *> *)dotPositions:(VHBoomMenuButton *)bmb;

+ (NSMutableArray<NSValue *> *)hamPositions:(VHBoomMenuButton *)bmb;

+ (NSMutableArray<NSValue *> *)shareDotPositionsWithDotNumber:(NSUInteger)n withBoomMenuButton:(VHBoomMenuButton *)bmb;

+ (int)pieceNumber:(VHPiecePlaceEnum)placeEnum;

+ (int)minPieceNumber:(VHPiecePlaceEnum)placeEnum;

+ (int)maxPieceNumber:(VHPiecePlaceEnum)placeEnum;

@end
