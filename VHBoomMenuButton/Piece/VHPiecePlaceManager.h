//
//  VHDotPlaceManager.h
//  VHBoomMenuExample
//
//  Created by 黄伟平 on 16/7/28.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VHPiecePlaceEnum.h"
#import "VHDot.h"

@interface VHPiecePlaceManager : NSObject

+ (instancetype)sharedManager;

- (NSMutableArray<NSValue *> *)positionsWithEnum:(VHPiecePlaceEnum)placeEnum withParentFrame:(CGRect)frame withDotRadius:(CGFloat)radius;

- (NSInteger)numbersWithEnum:(VHPiecePlaceEnum)placeEnum;

@end
