//
//  VHBoomButton.m
//  VHBoomMenuExample
//
//  Created by 黄伟平 on 16/7/29.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import "VHBoomButton.h"

@implementation VHBoomButton

- (VHButtonEnum)type
{
    return VHUNKNOWN;
}

- (NSMutableArray<UIView *> *)goneViews
{
    return [NSMutableArray arrayWithCapacity:0];
}

- (NSMutableArray<UIView *> *)rotateViews
{
    return [NSMutableArray arrayWithCapacity:0];
}

- (CGPoint)rotateAnchorPoint
{
    return CGPointZero;
}

@end
