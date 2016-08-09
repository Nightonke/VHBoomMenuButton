//
//  VHDot.m
//  VHBoomMenuExample
//
//  Created by 黄伟平 on 16/7/28.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import "VHDot.h"
#import <QuartzCore/QuartzCore.h>

@implementation VHDot

- (instancetype)initWithFrame:(CGRect)frame withColor:(UIColor *)color
{
    if (self = [super initWithFrame:frame])
    {
        self.layer.allowsEdgeAntialiasing = YES;
        self.layer.cornerRadius           = frame.size.width / 2;
        self.layer.masksToBounds          = YES;
        self.layer.backgroundColor        = color.CGColor;
    }
    return self;
}

@end
