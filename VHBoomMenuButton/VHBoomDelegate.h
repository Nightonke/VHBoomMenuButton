//
//  VHBoomClickDelegate.h
//  VHBoomMenuExample
//
//  Created by 黄伟平 on 16/7/31.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

@protocol VHBoomDelegate <NSObject>

@optional

/**
 *  When one of the sub button is clicked.
 *
 *  @param index Index of the clicked sub button.
 */
- (void)onBoomClick:(int)index;

/**
 *  When the background is clicked.
 */
- (void)onBoomBackgroundClick;

/**
 *  The reboom animation is going to start.
 */
- (void)onBoomWillHide;

/**
 *  The reboom animation is finished.
 */
- (void)onBoomDidHide;

/**
 *  The boom animation is going to start.
 */
- (void)onBoomWillShow;

/**
 *  The boom animation is finished.
 */
- (void)onBoomDidShow;

@end
