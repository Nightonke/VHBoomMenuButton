//
//  VHErrorManager.m
//  VHBoomMenuButton
//
//  Created by Nightonke on 16/8/2.
//  Copyright © 2016年 Nightonke. All rights reserved.
//

#import "VHErrorManager.h"
#import "VHPiecePlaceManager.h"

@class VHBoomMenuButton;

@implementation VHErrorManager

+ (void)judge:(VHBoomMenuButton *)bmb withBuilders:(NSMutableArray<VHBoomButtonBuilder *> *)builders
{
    NSAssert(bmb.buttonEnum != VHButtonUnknown, @"[BMB] Unknown button enum!");
    NSAssert(bmb.piecePlaceEnum < VHPiecePlaceEnumCount, @"[BMB] Unknown piece-place-enum!");
    NSAssert(bmb.buttonPlaceEnum < VHButtonPlaceEnumCount, @"[BMB] Unknown button-place-enum!");
    NSAssert(bmb.boomEnum < VHBoomEnumCount, @"[BMB] Unknown boom-enum!");
    NSAssert(builders.count, @"[BMB] Empty builders!");
    
    int pieceNumber = (int)bmb.pieceNumber;
    int buttonNumber = (int)bmb.buttonNumber;
    int builderNumber = (int)builders.count;
    
    if (pieceNumber == -1)
    {
        if (bmb.piecePlaceEnum == VHPiecePlaceShare)
        {
            int minPieceNumber = (int)[VHPiecePlaceManager minPieceNumber:bmb.piecePlaceEnum];
            int maxPieceNumber = (int)[VHPiecePlaceManager maxPieceNumber:bmb.piecePlaceEnum];
            if (buttonNumber < minPieceNumber)
            {
                NSAssert(NO, @"[BMB] In share style, button-place-enum(%zd) must have %d buttons at least!", bmb.buttonPlaceEnum, minPieceNumber);
            }
            else if (buttonNumber > maxPieceNumber)
            {
                NSAssert(NO, @"[BMB] In share style, button-place-enum(%zd) can only have %d buttons at most", bmb.buttonPlaceEnum, maxPieceNumber);
            }
            else if (builderNumber < minPieceNumber)
            {
                NSAssert(NO, @"[BMB] In share style, BMB must have %d builders at least!", minPieceNumber);
            }
            else if (builderNumber > maxPieceNumber)
            {
                NSAssert(NO, @"[BMB] In share style, BMB can only have %d buttons at most", maxPieceNumber);
            }
            else if (bmb.buttonEnum == VHButtonHam)
            {
                NSAssert(NO, @"[BMB] BMB in share style does NOT support ham-boom-buttons", maxPieceNumber);
            }
        }
    }
    
    if (pieceNumber != buttonNumber
        && bmb.buttonPlaceEnum != VHButtonPlaceHorizontal
        && bmb.buttonPlaceEnum != VHButtonPlaceVertical
        && bmb.piecePlaceEnum != VHPiecePlaceShare)
    {
        NSAssert(NO, @"[BMB] Number of pieces(%d) is not equal to buttons'(%d)!", pieceNumber, buttonNumber);
    }
    
    if (pieceNumber != builderNumber && bmb.piecePlaceEnum != VHPiecePlaceShare)
    {
        NSAssert(NO, @"[BMB] Number of pieces(%d) is not equal to builders'(%d)!", pieceNumber, builderNumber);
    }
}


@end
