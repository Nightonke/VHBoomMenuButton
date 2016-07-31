//
//  VHEase.h
//  VHMediaTimingFunction
//
//  Created by 黄伟平 on 16/7/22.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "VHEaseEnum.h"

@interface VHEase : NSObject

@property (nonatomic) BOOL ableToDefineWithControlPoints;
@property (nonatomic) VHEaseEnum vhEaseEnum;

- (instancetype)initWithStartX:(CGFloat)startX startY:(CGFloat)startY endX:(CGFloat)endX endY:(CGFloat)endY;

- (instancetype)initWithEnum:(VHEaseEnum) vhEaseEnum;

- (CGFloat)offset:(CGFloat)offset;

@end
