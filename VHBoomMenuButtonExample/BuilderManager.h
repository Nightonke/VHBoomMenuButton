//
//  BuilderManager.h
//  VHBoomMenuButton
//
//  Created by viktorhuang on 2017/4/11.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VHBoomMenuButton.h"

@interface BuilderManager : NSObject

extern NSString * const VHPiecePlaceEnumStrings[];

extern NSString * const VHButtonPlaceEnumStrings[];

#pragma mark - Builder

+ (VHSimpleCircleButtonBuilder *)simpleCircleButtonBuilder;

+ (VHSimpleCircleButtonBuilder *)squaresSimpleCircleButtonBuilder;

+ (VHTextInsideCircleButtonBuilder *)textInsideCircleButtonBuilder;

+ (VHTextInsideCircleButtonBuilder *)squareTextInsideCircleButtonBuilder;

+ (VHTextInsideCircleButtonBuilder *)textInsideCircleButtonBuilderWithDifferentPieceColor;

+ (VHTextOutsideCircleButtonBuilder *)textOutsideCircleButtonBuilder;

+ (VHTextOutsideCircleButtonBuilder *)squareTextOutsideCircleButtonBuilder;

+ (VHTextOutsideCircleButtonBuilder *)textOutsideCircleButtonBuilderWithDifferentPieceColor;

+ (VHHamButtonBuilder *)hamButtonBuilder;

+ (VHHamButtonBuilder *)hamButtonBuilderWithDifferentPieceColor;

+ (VHHamButtonBuilder *)hamButtonBuilderWithText:(NSString *)text withSubText:(NSString *)subText;

+ (NSString *)imageName;

#pragma mark - List Data

+ (void)initializeDatasForSimpleCircleButton:(NSMutableArray<NSString *> *)datas piecesAndButtons:(NSMutableArray<NSValue *> *)piecesAndButtons;

+ (void)initializeDatasForTextInsideCircleButton:(NSMutableArray<NSString *> *)datas piecesAndButtons:(NSMutableArray<NSValue *> *)piecesAndButtons;

+ (void)initializeDatasForTextOutsideCircleButton:(NSMutableArray<NSString *> *)datas piecesAndButtons:(NSMutableArray<NSValue *> *)piecesAndButtons;

+ (void)initializeDatasForHamButton:(NSMutableArray<NSString *> *)datas piecesAndButtons:(NSMutableArray<NSValue *> *)piecesAndButtons;

@end
