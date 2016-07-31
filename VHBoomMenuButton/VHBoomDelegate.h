//
//  VHBoomClickDelegate.h
//  VHBoomMenuExample
//
//  Created by 黄伟平 on 16/7/31.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

@protocol VHBoomDelegate <NSObject>

@optional
- (void)onBoomClick:(int)index;
- (void)onBoomBackgroundClick;
- (void)onBoomHiding:(float)process;
- (void)onBoomShowing:(float)process;

@end
