//
//  VHErrorManager.m
//  VHBoomMenuButton
//
//  Created by Nightonke on 16/8/2.
//  Copyright © 2016 Nightonke. All rights reserved.
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
    NSAssert(builders.count > 0, @"[BMB] Empty builders!");
    
    int pieceNumber = bmb.pieceNumber;
    int minPieceNumber = bmb.minPieceNumber;
    int maxPieceNumber = bmb.maxPieceNumber;
    int customPiecePositionsNumber = (int)bmb.customPiecePositions.count;
    
    int buttonNumber = bmb.buttonNumber;
    int minButtonNumber = bmb.minButtonNumber;
    int maxButtonNumber = bmb.maxButtonNumber;
    int customButtonPositionsNumber = (int)bmb.customButtonPositions.count;
    
    int builderNumber = (int)builders.count;
    
    if (pieceNumber == -1)
    {
        // The piece number is in a range
        if (buttonNumber != -1 && !(minPieceNumber <= buttonNumber && buttonNumber <= maxPieceNumber))
        {
            // The button-place-enum has a certain number of buttons, then it must be in the range
            NSAssert(NO, @"[BMB] The number(%d) of buttons of button-place-enum(%lu) is not in the range([%d, %d]) of the piece-place-enum(%lu)", buttonNumber, (unsigned long)bmb.buttonPlaceEnum, minPieceNumber, maxPieceNumber, (unsigned long)bmb.piecePlaceEnum);
        }
        if (!(minPieceNumber <= builderNumber && builderNumber <= maxPieceNumber))
        {
            // The number of builders must be in the range
            NSAssert(NO, @"[BMB] The number of builders(%d) is not in the range([%d, %d]) of the piece-place-enum(%lu)", builderNumber, minPieceNumber, maxPieceNumber, (unsigned long)bmb.piecePlaceEnum);
        }
    }
    else
    {
        if (buttonNumber != -1)
        {
            // The piece-place-enum and button-place-enum both have a certain number of pieces and buttons. They must be the same
            NSAssert(pieceNumber == buttonNumber, @"[BMB] The number of piece(%d) is not equal to buttons'(%d)", pieceNumber, buttonNumber);
            NSAssert(pieceNumber == builderNumber, @"[BMB] The number of piece(%d) is not equal to builders'(%d)", pieceNumber, builderNumber);
        }
    }
    
    if (bmb.piecePlaceEnum == VHPiecePlaceCustom)
    {
        NSAssert(customPiecePositionsNumber > 0, @"[BMB] When the positions of pieces is customized, the custom-piece-place-positions array is empty");
        if (buttonNumber == -1)
        {
            // The button number is in a range
            NSAssert(minButtonNumber <= customPiecePositionsNumber && customPiecePositionsNumber <= maxButtonNumber,
                     @"[BMB] When the positions of pieces is customized, the length(%d) of custom-piece-place-positions array is not in the range([%d, %d])", customPiecePositionsNumber, minButtonNumber, maxButtonNumber);
        }
        else
        {
            NSAssert(customPiecePositionsNumber == buttonNumber, @"[BMB] The number of piece(%d) is not equal to buttons'(%d)",
                     customPiecePositionsNumber, buttonNumber);
        }
        NSAssert(customPiecePositionsNumber == builderNumber, @"[BMB] The number of piece(%d) is not equal to builders'(%d)",
                 customPiecePositionsNumber, builderNumber);
    }
    
    if (bmb.buttonPlaceEnum == VHButtonPlaceCustom)
    {
        NSAssert(customButtonPositionsNumber > 0, @"[BMB] When the positions of buttons is customized, the custom-button-place-positions array is empty");
        if (pieceNumber == -1)
        {
            // The piece number is in a range
            NSAssert(minPieceNumber <= customButtonPositionsNumber && customButtonPositionsNumber <= maxPieceNumber,
                     @"[BMB] When the positions of buttons is customized, the length(%d) of custom-button-place-positions array is not in the range([%d, %d])", customButtonPositionsNumber, minPieceNumber, maxPieceNumber);
        }
        else
        {
            NSAssert(customButtonPositionsNumber == pieceNumber, @"[BMB] The number of button(%d) is not equal to pieces'(%d)",
                     customButtonPositionsNumber, pieceNumber);
        }
        NSAssert(customButtonPositionsNumber == builderNumber, @"[BMB] The number of button(%d) is not equal to builders'(%d)",
                 customButtonPositionsNumber, builderNumber);
    }
}


@end
