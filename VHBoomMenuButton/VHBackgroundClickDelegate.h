//
//  OnBackgroundClickDelegate.h
//  VHBoomMenuExample
//
//  Created by 黄伟平 on 16/7/31.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

/**
 *  Delegate for background clicked.
 */
@protocol VHBackgroundClickDelegate <NSObject>

@required
- (void)onBackgroundClick;

@end
