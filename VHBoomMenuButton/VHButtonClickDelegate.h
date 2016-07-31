//
//  OnButtonClickDelegate.h
//  VHBoomMenuExample
//
//  Created by 黄伟平 on 16/7/30.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

@protocol VHButtonClickDelegate <NSObject>

@required
- (void)onButtonClick:(int)index;

@end
