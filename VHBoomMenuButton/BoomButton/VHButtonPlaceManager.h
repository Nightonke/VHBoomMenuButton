//
//  VHButtonPlaceManager.h
//  VHBoomMenuExample
//
//  Created by 黄伟平 on 16/7/29.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VHButtonPlaceEnum.h"
#import "VHDot.h"

@interface VHButtonPlaceManager : NSObject

+ (instancetype)sharedManager;

- (NSMutableArray<NSValue *> *)positionsWithEnum:(VHButtonPlaceEnum)placeEnum withParentFrame:(CGRect)frame withButtonRadius:(CGFloat)radius;

- (NSInteger)numbersWithEnum:(VHButtonPlaceEnum)placeEnum;

@end
