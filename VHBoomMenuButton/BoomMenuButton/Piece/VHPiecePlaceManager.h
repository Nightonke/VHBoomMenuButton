//
//  VHDotPlaceManager.h
//  VHBoomMenuExample
//
//  Created by Nightonke on 16/7/28.
//  Copyright © 2016年 Nightonke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VHPiecePlaceEnum.h"

@interface VHPiecePlaceManager : NSObject

+ (NSMutableArray<NSValue *> *)positionsWithEnum:(VHPiecePlaceEnum)placeEnum
                                 withParentFrame:(CGRect)frame
                                   withDotRadius:(CGFloat)radius
                            withHorizontalMargin:(CGFloat)dotHorizontalMargin
                              withVerticalMargin:(CGFloat)dotVerticalMargin
                              withInclinedMargin:(CGFloat)dotInclinedMargin;

+ (NSMutableArray<NSValue *> *)positionsWithEnum:(VHPiecePlaceEnum)placeEnum
                                 withParentFrame:(CGRect)frame
                                    withHamWidth:(CGFloat)width
                                   withHamHeight:(CGFloat)height
                            withHorizontalMargin:(CGFloat)dotHorizontalMargin
                              withVerticalMargin:(CGFloat)dotVerticalMargin;

+ (NSMutableArray<NSValue *> *)positionsForShareStyleWithParentFrame:(CGRect)frame
                                                       withDotRadius:(CGFloat)radius
                                                       withDotNumber:(NSUInteger)dotNumber
                                                 withShareLineLength:(CGFloat)shareLineLength;

+ (NSInteger)pieceNumber:(VHPiecePlaceEnum)placeEnum;

+ (NSInteger)minPieceNumber:(VHPiecePlaceEnum)placeEnum;

+ (NSInteger)maxPieceNumber:(VHPiecePlaceEnum)placeEnum;

@end
