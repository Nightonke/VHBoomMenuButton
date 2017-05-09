//
//  BuilderManager.m
//  VHBoomMenuButton
//
//  Created by Nightonke on 2017/4/11.
//  Copyright © 2017 Nightonke. All rights reserved.
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

+ (VHSimpleCircleButtonBuilder *)squareSimpleCircleButtonBuilder
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

+ (void)initializeDatasForSimpleCircleButton:(NSMutableArray<NSString *> *)datas
                            piecesAndButtons:(NSMutableArray<NSValue *> *)piecesAndButtons
{
    for (int p = 0; p < VHPiecePlaceEnumCount; p++)
    {
        for (int b = 0; b < VHButtonPlaceEnumCount; b++)
        {
            VHPiecePlaceEnum piecePlaceEnum = (VHPiecePlaceEnum)p;
            VHButtonPlaceEnum buttonPlaceEnum = (VHButtonPlaceEnum)b;
            if ([VHBoomMenuButton pieceNumber:piecePlaceEnum] == [VHBoomMenuButton buttonNumber:buttonPlaceEnum]
                || buttonPlaceEnum == VHButtonPlaceHorizontal
                || buttonPlaceEnum == VHButtonPlaceVertical)
            {
                [datas addObject:[NSString stringWithFormat:@"%@ %@", VHPiecePlaceEnumStrings[piecePlaceEnum], VHButtonPlaceEnumStrings[buttonPlaceEnum]]];
                [piecesAndButtons addObject:[NSValue valueWithCGPoint:CGPointMake(piecePlaceEnum, buttonPlaceEnum)]];
                if (piecePlaceEnum == VHPiecePlaceHAM_1
                    || piecePlaceEnum == VHPiecePlaceHAM_2
                    || piecePlaceEnum == VHPiecePlaceHAM_3
                    || piecePlaceEnum == VHPiecePlaceHAM_4
                    || piecePlaceEnum == VHPiecePlaceHAM_5
                    || piecePlaceEnum == VHPiecePlaceHAM_6
                    || piecePlaceEnum == VHPiecePlaceShare
                    || piecePlaceEnum == VHPiecePlaceCustom
                    || buttonPlaceEnum == VHButtonPlaceHAM_1
                    || buttonPlaceEnum == VHButtonPlaceHAM_2
                    || buttonPlaceEnum == VHButtonPlaceHAM_3
                    || buttonPlaceEnum == VHButtonPlaceHAM_4
                    || buttonPlaceEnum == VHButtonPlaceHAM_5
                    || buttonPlaceEnum == VHButtonPlaceHAM_6
                    || buttonPlaceEnum == VHButtonPlaceCustom)
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
                || buttonPlaceEnum == VHButtonPlaceHorizontal
                || buttonPlaceEnum == VHButtonPlaceVertical)
            {
                [datas addObject:[NSString stringWithFormat:@"%@ %@", VHPiecePlaceEnumStrings[piecePlaceEnum], VHButtonPlaceEnumStrings[buttonPlaceEnum]]];
                [piecesAndButtons addObject:[NSValue valueWithCGPoint:CGPointMake(piecePlaceEnum, buttonPlaceEnum)]];
                if (piecePlaceEnum < VHPiecePlaceHAM_1
                    || piecePlaceEnum == VHPiecePlaceShare
                    || piecePlaceEnum == VHPiecePlaceCustom
                    || buttonPlaceEnum < VHButtonPlaceHAM_1
                    || buttonPlaceEnum == VHButtonPlaceCustom)
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
    [VHPiecePlaceDOT_1] = @"DOT_1",
    [VHPiecePlaceDOT_2_1] = @"DOT_2_1",
    [VHPiecePlaceDOT_2_2] = @"DOT_2_2",
    [VHPiecePlaceDOT_3_1] = @"DOT_3_1",
    [VHPiecePlaceDOT_3_2] = @"DOT_3_2",
    [VHPiecePlaceDOT_3_3] = @"DOT_3_3",
    [VHPiecePlaceDOT_3_4] = @"DOT_3_4",
    [VHPiecePlaceDOT_4_1] = @"DOT_4_1",
    [VHPiecePlaceDOT_4_2] = @"DOT_4_2",
    [VHPiecePlaceDOT_5_1] = @"DOT_5_1",
    [VHPiecePlaceDOT_5_2] = @"DOT_5_2",
    [VHPiecePlaceDOT_5_3] = @"DOT_5_3",
    [VHPiecePlaceDOT_5_4] = @"DOT_5_4",
    [VHPiecePlaceDOT_6_1] = @"DOT_6_1",
    [VHPiecePlaceDOT_6_2] = @"DOT_6_2",
    [VHPiecePlaceDOT_6_3] = @"DOT_6_3",
    [VHPiecePlaceDOT_6_4] = @"DOT_6_4",
    [VHPiecePlaceDOT_6_5] = @"DOT_6_5",
    [VHPiecePlaceDOT_6_6] = @"DOT_6_6",
    [VHPiecePlaceDOT_7_1] = @"DOT_7_1",
    [VHPiecePlaceDOT_7_2] = @"DOT_7_2",
    [VHPiecePlaceDOT_7_3] = @"DOT_7_3",
    [VHPiecePlaceDOT_7_4] = @"DOT_7_4",
    [VHPiecePlaceDOT_7_5] = @"DOT_7_5",
    [VHPiecePlaceDOT_7_6] = @"DOT_7_6",
    [VHPiecePlaceDOT_8_1] = @"DOT_8_1",
    [VHPiecePlaceDOT_8_2] = @"DOT_8_2",
    [VHPiecePlaceDOT_8_3] = @"DOT_8_3",
    [VHPiecePlaceDOT_8_4] = @"DOT_8_4",
    [VHPiecePlaceDOT_8_5] = @"DOT_8_5",
    [VHPiecePlaceDOT_8_6] = @"DOT_8_6",
    [VHPiecePlaceDOT_8_7] = @"DOT_8_7",
    [VHPiecePlaceDOT_9_1] = @"DOT_9_1",
    [VHPiecePlaceDOT_9_2] = @"DOT_9_2",
    [VHPiecePlaceDOT_9_3] = @"DOT_9_3",
    [VHPiecePlaceHAM_1] = @"HAM_1",
    [VHPiecePlaceHAM_2] = @"HAM_2",
    [VHPiecePlaceHAM_3] = @"HAM_3",
    [VHPiecePlaceHAM_4] = @"HAM_4",
    [VHPiecePlaceHAM_5] = @"HAM_5",
    [VHPiecePlaceHAM_6] = @"HAM_6",
};

NSString * const VHButtonPlaceEnumStrings[] = {
    [VHButtonPlaceSC_1] = @"SC_1",
    [VHButtonPlaceSC_2_1] = @"SC_2_1",
    [VHButtonPlaceSC_2_2] = @"SC_2_2",
    [VHButtonPlaceSC_3_1] = @"SC_3_1",
    [VHButtonPlaceSC_3_2] = @"SC_3_2",
    [VHButtonPlaceSC_3_3] = @"SC_3_3",
    [VHButtonPlaceSC_3_4] = @"SC_3_4",
    [VHButtonPlaceSC_4_1] = @"SC_4_1",
    [VHButtonPlaceSC_4_2] = @"SC_4_2",
    [VHButtonPlaceSC_5_1] = @"SC_5_1",
    [VHButtonPlaceSC_5_2] = @"SC_5_2",
    [VHButtonPlaceSC_5_3] = @"SC_5_3",
    [VHButtonPlaceSC_5_4] = @"SC_5_4",
    [VHButtonPlaceSC_6_1] = @"SC_6_1",
    [VHButtonPlaceSC_6_2] = @"SC_6_2",
    [VHButtonPlaceSC_6_3] = @"SC_6_3",
    [VHButtonPlaceSC_6_4] = @"SC_6_4",
    [VHButtonPlaceSC_6_5] = @"SC_6_5",
    [VHButtonPlaceSC_6_6] = @"SC_6_6",
    [VHButtonPlaceSC_7_1] = @"SC_7_1",
    [VHButtonPlaceSC_7_2] = @"SC_7_2",
    [VHButtonPlaceSC_7_3] = @"SC_7_3",
    [VHButtonPlaceSC_7_4] = @"SC_7_4",
    [VHButtonPlaceSC_7_5] = @"SC_7_5",
    [VHButtonPlaceSC_7_6] = @"SC_7_6",
    [VHButtonPlaceSC_8_1] = @"SC_8_1",
    [VHButtonPlaceSC_8_2] = @"SC_8_2",
    [VHButtonPlaceSC_8_3] = @"SC_8_3",
    [VHButtonPlaceSC_8_4] = @"SC_8_4",
    [VHButtonPlaceSC_8_5] = @"SC_8_5",
    [VHButtonPlaceSC_8_6] = @"SC_8_6",
    [VHButtonPlaceSC_8_7] = @"SC_8_7",
    [VHButtonPlaceSC_9_1] = @"SC_9_1",
    [VHButtonPlaceSC_9_2] = @"SC_9_2",
    [VHButtonPlaceSC_9_3] = @"SC_9_3",
    [VHButtonPlaceHAM_1] = @"HAM_1",
    [VHButtonPlaceHAM_2] = @"HAM_2",
    [VHButtonPlaceHAM_3] = @"HAM_3",
    [VHButtonPlaceHAM_4] = @"HAM_4",
    [VHButtonPlaceHAM_5] = @"HAM_5",
    [VHButtonPlaceHAM_6] = @"HAM_6",
    [VHButtonPlaceHorizontal] = @"Horizontal",
    [VHButtonPlaceVertical] = @"Vertical",
};

@end
