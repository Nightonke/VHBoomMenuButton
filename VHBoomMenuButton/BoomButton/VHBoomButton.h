//
//  VHBoomButton.h
//  VHBoomMenuExample
//
//  Created by 黄伟平 on 16/7/29.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VHButtonEnum.h"

@interface VHBoomButton : UIView

- (VHButtonEnum)type;
- (NSMutableArray<UIView *> *)goneViews;
- (NSMutableArray<UIView *> *)rotateViews;

@end
