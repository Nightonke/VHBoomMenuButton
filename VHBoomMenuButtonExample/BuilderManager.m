//
//  BuilderManager.m
//  VHBoomMenuButton
//
//  Created by viktorhuang on 2017/4/11.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

#import "BuilderManager.h"

static NSMutableArray<NSString *> *imageNames;
static int imageNameIndex = 0;

@implementation BuilderManager

#pragma mark - Builder

+ (VHSimpleCircleButtonBuilder *)simpleCircleButtonBuilder
{
    VHSimpleCircleButtonBuilder *builder = [VHSimpleCircleButtonBuilder builder];
    builder.normalImageName = [BuilderManager imageName];
    return builder;
}

+ (VHSimpleCircleButtonBuilder *)squaresSimpleCircleButtonBuilder
{
    VHSimpleCircleButtonBuilder *builder = [BuilderManager simpleCircleButtonBuilder];
    builder.round = NO;
    builder.cornerRadius = 10;
    return builder;
}

+ (VHTextInsideCircleButtonBuilder *)textInsideCircleButtonBuilder
{
    VHTextInsideCircleButtonBuilder *builder = [VHTextInsideCircleButtonBuilder builder];
    builder.normalImageName = [BuilderManager imageName];
    builder.normalText = @"Text Inside";
    return builder;
}

+ (VHTextInsideCircleButtonBuilder *)squareTextInsideCircleButtonBuilder
{
    VHTextInsideCircleButtonBuilder *builder = [BuilderManager textInsideCircleButtonBuilder];
    builder.round = NO;
    builder.cornerRadius = 20;
    return builder;
}

+ (VHTextInsideCircleButtonBuilder *)textInsideCircleButtonBuilderWithDifferentPieceColor
{
    VHTextInsideCircleButtonBuilder *builder = [BuilderManager textInsideCircleButtonBuilder];
    builder.pieceColor = [UIColor whiteColor];
    return builder;
}

+ (VHTextOutsideCircleButtonBuilder *)textOutsideCircleButtonBuilder
{
    VHTextOutsideCircleButtonBuilder *builder = [VHTextOutsideCircleButtonBuilder builder];
    builder.normalImageName = [BuilderManager imageName];
    builder.normalText = @"Text Outside";
    return builder;
}

+ (VHTextOutsideCircleButtonBuilder *)squareTextOutsideCircleButtonBuilder
{
    VHTextOutsideCircleButtonBuilder *builder = [BuilderManager textOutsideCircleButtonBuilder];
    builder.rotateText = NO;
    builder.round = NO;
    return builder;
}

+ (VHTextOutsideCircleButtonBuilder *)textOutsideCircleButtonBuilderWithDifferentPieceColor
{
    VHTextOutsideCircleButtonBuilder *builder = [BuilderManager textOutsideCircleButtonBuilder];
    builder.pieceColor = [UIColor whiteColor];
    return builder;
}

+ (VHHamButtonBuilder *)hamButtonBuilder
{
    return [BuilderManager hamButtonBuilderWithText:@"Ham Button Text" withSubText:@"Ham Button Sub Text"];
}

+ (VHHamButtonBuilder *)hamButtonBuilderWithDifferentPieceColor
{
    VHHamButtonBuilder *builder = [BuilderManager hamButtonBuilder];
    builder.pieceColor = [UIColor whiteColor];
    return builder;
}

+ (VHHamButtonBuilder *)hamButtonBuilderWithText:(NSString *)text withSubText:(NSString *)subText
{
    VHHamButtonBuilder *builder = [VHHamButtonBuilder builder];
    builder.normalImageName = [BuilderManager imageName];
    builder.normalText = text;
    builder.normalSubText = subText;
    return builder;
}

#pragma mark - List Data

+ (void)initializeDatasForSimpleCircleButton:(NSMutableArray<NSString *> *)datas piecesAndButtons:(NSMutableArray<NSValue *> *)piecesAndButtons
{
    for (int p = 0; p < VHPiecePlaceEnumCount; p++)
    {
        for (int b = 0; b < VHButtonPlaceEnumCount; b++)
        {
            VHPiecePlaceEnum piecePlaceEnum = (VHPiecePlaceEnum)p;
            VHButtonPlaceEnum buttonPlaceEnum = (VHButtonPlaceEnum)b;
            if ([VHBoomMenuButton pieceNumber:piecePlaceEnum] == [VHBoomMenuButton buttonNumber:buttonPlaceEnum]
                || buttonPlaceEnum == VHButtonPlace_Horizontal
                || buttonPlaceEnum == VHButtonPlace_Vertical)
            {
                [datas addObject:[NSString stringWithFormat:@"%@ %@", VHPiecePlaceEnumStrings[piecePlaceEnum], VHButtonPlaceEnumStrings[buttonPlaceEnum]]];
                [piecesAndButtons addObject:[NSValue valueWithCGPoint:CGPointMake(piecePlaceEnum, buttonPlaceEnum)]];
                if (piecePlaceEnum == VHPiecePlace_HAM_1
                    || piecePlaceEnum == VHPiecePlace_HAM_2
                    || piecePlaceEnum == VHPiecePlace_HAM_3
                    || piecePlaceEnum == VHPiecePlace_HAM_4
                    || piecePlaceEnum == VHPiecePlace_HAM_5
                    || piecePlaceEnum == VHPiecePlace_HAM_6
                    || piecePlaceEnum == VHPiecePlaceShare
                    || buttonPlaceEnum == VHButtonPlace_HAM_1
                    || buttonPlaceEnum == VHButtonPlace_HAM_2
                    || buttonPlaceEnum == VHButtonPlace_HAM_3
                    || buttonPlaceEnum == VHButtonPlace_HAM_4
                    || buttonPlaceEnum == VHButtonPlace_HAM_5
                    || buttonPlaceEnum == VHButtonPlace_HAM_6)
                {
                    [datas removeLastObject];
                    [piecesAndButtons removeLastObject];
                }
            }
        }
    }
}

+ (void)initializeDatasForTextInsideCircleButton:(NSMutableArray<NSString *> *)datas piecesAndButtons:(NSMutableArray<NSValue *> *)piecesAndButtons
{
    [BuilderManager initializeDatasForSimpleCircleButton:datas piecesAndButtons:piecesAndButtons];
}

+ (void)initializeDatasForTextOutsideCircleButton:(NSMutableArray<NSString *> *)datas piecesAndButtons:(NSMutableArray<NSValue *> *)piecesAndButtons
{
    [BuilderManager initializeDatasForSimpleCircleButton:datas piecesAndButtons:piecesAndButtons];
}

+ (void)initializeDatasForHamButton:(NSMutableArray<NSString *> *)datas piecesAndButtons:(NSMutableArray<NSValue *> *)piecesAndButtons
{
    for (int p = 0; p < VHPiecePlaceEnumCount; p++)
    {
        for (int b = 0; b < VHButtonPlaceEnumCount; b++)
        {
            VHPiecePlaceEnum piecePlaceEnum = (VHPiecePlaceEnum)p;
            VHButtonPlaceEnum buttonPlaceEnum = (VHButtonPlaceEnum)b;
            if ([VHBoomMenuButton pieceNumber:piecePlaceEnum] == [VHBoomMenuButton buttonNumber:buttonPlaceEnum]
                || buttonPlaceEnum == VHButtonPlace_Horizontal
                || buttonPlaceEnum == VHButtonPlace_Vertical)
            {
                [datas addObject:[NSString stringWithFormat:@"%@ %@", VHPiecePlaceEnumStrings[piecePlaceEnum], VHButtonPlaceEnumStrings[buttonPlaceEnum]]];
                [piecesAndButtons addObject:[NSValue valueWithCGPoint:CGPointMake(piecePlaceEnum, buttonPlaceEnum)]];
                if (piecePlaceEnum < VHPiecePlace_HAM_1
                    || piecePlaceEnum == VHPiecePlaceShare
                    || buttonPlaceEnum < VHButtonPlace_HAM_1)
                {
                    [datas removeLastObject];
                    [piecesAndButtons removeLastObject];
                }
            }
        }
    }
}

+ (NSString *)imageName
{
    NSMutableArray<NSString *> *_imageNames = [self imageNames];
    if (imageNameIndex >= _imageNames.count) imageNameIndex = 0;
    return [_imageNames objectAtIndex:imageNameIndex++];
}

#pragma mark - Private Methods

+ (NSMutableArray<NSString *> *)imageNames
{
    if (!imageNames)
    {
        imageNames = [NSMutableArray arrayWithCapacity:16];
        [imageNames addObject:@"butterfly"];
        [imageNames addObject:@"peacock"];
        [imageNames addObject:@"rat"];
        [imageNames addObject:@"jellyFish"];
        [imageNames addObject:@"horse"];
        [imageNames addObject:@"dolphin"];
        [imageNames addObject:@"deer"];
        [imageNames addObject:@"cat"];
        [imageNames addObject:@"bear"];
        [imageNames addObject:@"snake"];
        [imageNames addObject:@"pig"];
        [imageNames addObject:@"eagle"];
        [imageNames addObject:@"bat"];
        [imageNames addObject:@"bee"];
        [imageNames addObject:@"owl"];
        [imageNames addObject:@"squirrel"];
    }
    return imageNames;
}

NSString * const VHPiecePlaceEnumStrings[] = {
    [VHPiecePlace_DOT_1] = @"DOT_1",
    [VHPiecePlace_DOT_2_1] = @"DOT_2_1",
    [VHPiecePlace_DOT_2_2] = @"DOT_2_2",
    [VHPiecePlace_DOT_3_1] = @"DOT_3_1",
    [VHPiecePlace_DOT_3_2] = @"DOT_3_2",
    [VHPiecePlace_DOT_3_3] = @"DOT_3_3",
    [VHPiecePlace_DOT_3_4] = @"DOT_3_4",
    [VHPiecePlace_DOT_4_1] = @"DOT_4_1",
    [VHPiecePlace_DOT_4_2] = @"DOT_4_2",
    [VHPiecePlace_DOT_5_1] = @"DOT_5_1",
    [VHPiecePlace_DOT_5_2] = @"DOT_5_2",
    [VHPiecePlace_DOT_5_3] = @"DOT_5_3",
    [VHPiecePlace_DOT_5_4] = @"DOT_5_4",
    [VHPiecePlace_DOT_6_1] = @"DOT_6_1",
    [VHPiecePlace_DOT_6_2] = @"DOT_6_2",
    [VHPiecePlace_DOT_6_3] = @"DOT_6_3",
    [VHPiecePlace_DOT_6_4] = @"DOT_6_4",
    [VHPiecePlace_DOT_6_5] = @"DOT_6_5",
    [VHPiecePlace_DOT_6_6] = @"DOT_6_6",
    [VHPiecePlace_DOT_7_1] = @"DOT_7_1",
    [VHPiecePlace_DOT_7_2] = @"DOT_7_2",
    [VHPiecePlace_DOT_7_3] = @"DOT_7_3",
    [VHPiecePlace_DOT_7_4] = @"DOT_7_4",
    [VHPiecePlace_DOT_7_5] = @"DOT_7_5",
    [VHPiecePlace_DOT_7_6] = @"DOT_7_6",
    [VHPiecePlace_DOT_8_1] = @"DOT_8_1",
    [VHPiecePlace_DOT_8_2] = @"DOT_8_2",
    [VHPiecePlace_DOT_8_3] = @"DOT_8_3",
    [VHPiecePlace_DOT_8_4] = @"DOT_8_4",
    [VHPiecePlace_DOT_8_5] = @"DOT_8_5",
    [VHPiecePlace_DOT_8_6] = @"DOT_8_6",
    [VHPiecePlace_DOT_8_7] = @"DOT_8_7",
    [VHPiecePlace_DOT_9_1] = @"DOT_9_1",
    [VHPiecePlace_DOT_9_2] = @"DOT_9_2",
    [VHPiecePlace_DOT_9_3] = @"DOT_9_3",
    [VHPiecePlace_HAM_1] = @"HAM_1",
    [VHPiecePlace_HAM_2] = @"HAM_2",
    [VHPiecePlace_HAM_3] = @"HAM_3",
    [VHPiecePlace_HAM_4] = @"HAM_4",
    [VHPiecePlace_HAM_5] = @"HAM_5",
    [VHPiecePlace_HAM_6] = @"HAM_6",
};

NSString * const VHButtonPlaceEnumStrings[] = {
    [VHButtonPlace_SC_1] = @"SC_1",
    [VHButtonPlace_SC_2_1] = @"SC_2_1",
    [VHButtonPlace_SC_2_2] = @"SC_2_2",
    [VHButtonPlace_SC_3_1] = @"SC_3_1",
    [VHButtonPlace_SC_3_2] = @"SC_3_2",
    [VHButtonPlace_SC_3_3] = @"SC_3_3",
    [VHButtonPlace_SC_3_4] = @"SC_3_4",
    [VHButtonPlace_SC_4_1] = @"SC_4_1",
    [VHButtonPlace_SC_4_2] = @"SC_4_2",
    [VHButtonPlace_SC_5_1] = @"SC_5_1",
    [VHButtonPlace_SC_5_2] = @"SC_5_2",
    [VHButtonPlace_SC_5_3] = @"SC_5_3",
    [VHButtonPlace_SC_5_4] = @"SC_5_4",
    [VHButtonPlace_SC_6_1] = @"SC_6_1",
    [VHButtonPlace_SC_6_2] = @"SC_6_2",
    [VHButtonPlace_SC_6_3] = @"SC_6_3",
    [VHButtonPlace_SC_6_4] = @"SC_6_4",
    [VHButtonPlace_SC_6_5] = @"SC_6_5",
    [VHButtonPlace_SC_6_6] = @"SC_6_6",
    [VHButtonPlace_SC_7_1] = @"SC_7_1",
    [VHButtonPlace_SC_7_2] = @"SC_7_2",
    [VHButtonPlace_SC_7_3] = @"SC_7_3",
    [VHButtonPlace_SC_7_4] = @"SC_7_4",
    [VHButtonPlace_SC_7_5] = @"SC_7_5",
    [VHButtonPlace_SC_7_6] = @"SC_7_6",
    [VHButtonPlace_SC_8_1] = @"SC_8_1",
    [VHButtonPlace_SC_8_2] = @"SC_8_2",
    [VHButtonPlace_SC_8_3] = @"SC_8_3",
    [VHButtonPlace_SC_8_4] = @"SC_8_4",
    [VHButtonPlace_SC_8_5] = @"SC_8_5",
    [VHButtonPlace_SC_8_6] = @"SC_8_6",
    [VHButtonPlace_SC_8_7] = @"SC_8_7",
    [VHButtonPlace_SC_9_1] = @"SC_9_1",
    [VHButtonPlace_SC_9_2] = @"SC_9_2",
    [VHButtonPlace_SC_9_3] = @"SC_9_3",
    [VHButtonPlace_HAM_1] = @"HAM_1",
    [VHButtonPlace_HAM_2] = @"HAM_2",
    [VHButtonPlace_HAM_3] = @"HAM_3",
    [VHButtonPlace_HAM_4] = @"HAM_4",
    [VHButtonPlace_HAM_5] = @"HAM_5",
    [VHButtonPlace_HAM_6] = @"HAM_6",
    [VHButtonPlace_Horizontal] = @"Horizontal",
    [VHButtonPlace_Vertical] = @"Vertical",
};

@end
