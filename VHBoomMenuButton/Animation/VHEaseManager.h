//
//  VHEaseManager.h
//  VHMediaTimingFunction
//
//  Created by 黄伟平 on 16/7/22.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import "VHEase.h"
#include "VHEaseEnum.h"

@interface VHEaseManager : NSObject

+ (VHEase *)easeWithEnum:(VHEaseEnum)ease;
+ (VHEase *)easeWithX1:(CGFloat)x1 Y1:(CGFloat)y1 X2:(CGFloat)x2 Y2:(CGFloat)y2;

@end
