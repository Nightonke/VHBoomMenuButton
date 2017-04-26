//
//  VHButtonPlaceManager.h
//  VHBoomMenuExample
//
//  Created by Nightonke on 16/7/29.
//  Copyright © 2016年 Nightonke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VHButtonPlaceEnum.h"
#import "VHButtonPlaceAlignmentEnum.h"

@interface VHButtonPlaceManager : NSObject

+ (NSMutableArray<NSValue *> *)positionsWithEnum:(VHButtonPlaceEnum)placeEnum
                                   withAlignment:(VHButtonPlaceAlignmentEnum)alignmentEnum
                                 withParentFrame:(CGRect)frame
                                 withButtonWidth:(CGFloat)width
                                withButtonHeight:(CGFloat)height
                                withButtonNumber:(long)buttonNumber
                      withButtonHorizontalMargin:(CGFloat)buttonHorizontalMargin
                        withButtonInclinedMargin:(CGFloat)buttonInclinedMargin
                        withButtonVerticalMargin:(CGFloat)buttonVerticalMargin
                             withButtonTopMargin:(CGFloat)buttonTopMargin
                          withButtonBottomMargin:(CGFloat)buttonBottomMargin
                            withButtonLeftMargin:(CGFloat)buttonLeftMargin
                           withButtonRightMargin:(CGFloat)buttonRightMargin;

+ (NSMutableArray<NSValue *> *)positionsWithEnum:(VHButtonPlaceEnum)placeEnum
                                   withAlignment:(VHButtonPlaceAlignmentEnum)alignmentEnum
                                 withParentFrame:(CGRect)frame
                                withButtonRadius:(CGFloat)radius
                                withButtonNumber:(long)buttonNumber
                      withButtonHorizontalMargin:(CGFloat)buttonHorizontalMargin
                        withButtonInclinedMargin:(CGFloat)buttonInclinedMargin
                        withButtonVerticalMargin:(CGFloat)buttonVerticalMargin
                             withButtonTopMargin:(CGFloat)buttonTopMargin
                          withButtonBottomMargin:(CGFloat)buttonBottomMargin
                            withButtonLeftMargin:(CGFloat)buttonLeftMargin
                           withButtonRightMargin:(CGFloat)buttonRightMargin;

+ (NSMutableArray<NSValue *> *)positionsForHamWithEnum:(VHButtonPlaceEnum)placeEnum
                                         withAlignment:(VHButtonPlaceAlignmentEnum)alignmentEnum
                                       withParentFrame:(CGRect)frame
                                       withButtonWidth:(CGFloat)width
                                      withButtonHeight:(CGFloat)height
                                      withButtonNumber:(long)buttonNumber
                            withButtonHorizontalMargin:(CGFloat)buttonHorizontalMargin
                              withButtonVerticalMargin:(CGFloat)buttonVerticalMargin
                                   withButtonTopMargin:(CGFloat)buttonTopMargin
                                withButtonBottomMargin:(CGFloat)buttonBottomMargin
                                  withButtonLeftMargin:(CGFloat)buttonLeftMargin
                                 withButtonRightMargin:(CGFloat)buttonRightMargin
                           withLastButtonMarginMoreTop:(BOOL)lastButtonMarginMoreTop
                               withLastButtonTopMargin:(CGFloat)lastButtonTopMargin;

+ (NSInteger)buttonNumber:(VHButtonPlaceEnum)placeEnum;

@end
