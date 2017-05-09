//
//  VHButtonPlaceManager.h
//  VHBoomMenuExample
//
//  Created by Nightonke on 16/7/29.
//  Copyright © 2016 Nightonke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VHButtonPlaceEnum.h"
#import "VHButtonPlaceAlignmentEnum.h"
#import "VHBoomMenuButton.h"

@interface VHButtonPlaceManager : NSObject

+ (NSMutableArray<NSValue *> *)positionsWithParentFrame:(CGRect)parentFrame
                                        withButtonWidth:(CGFloat)buttonWidth
                                       withButtonHeight:(CGFloat)buttonHeight
                                       withButtonNumber:(long)buttonNumber
                                     withBoomMenuButton:(VHBoomMenuButton *)bmb;

+ (NSMutableArray<NSValue *> *)positionsWithParentFrame:(CGRect)parentFrame
                                       withButtonRadius:(CGFloat)radius
                                       withButtonNumber:(long)buttonNumber
                                     withBoomMenuButton:(VHBoomMenuButton *)bmb;

+ (int)buttonNumber:(VHButtonPlaceEnum)buttonPlaceEnum;

+ (int)minButtonNumber:(VHButtonPlaceEnum)buttonPlaceEnum;

+ (int)maxButtonNumber:(VHButtonPlaceEnum)buttonPlaceEnum;

@end
