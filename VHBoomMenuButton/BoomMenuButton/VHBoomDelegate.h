//
//  VHBoomClickDelegate.h
//  VHBoomMenuExample
//
//  Created by Nightonke on 16/7/31.
//  Copyright © 2016 Nightonke. All rights reserved.
//

#import "VHBoomButtonBuilder.h"
#import "VHBoomMenuButton.h"

@class VHBoomMenuButton;

@protocol VHBoomDelegate <NSObject>

@optional

/**
 When one of the sub button was clicked.

 @param bmb The BMB
 @param builder The builder of the clicked BoomButton
 @param index Index of the clicked sub button
 */
- (void)boomMenuButton:(VHBoomMenuButton *)bmb didClickBoomButtonOfBuilder:(VHBoomButtonBuilder *)builder at:(int)index;

/**
 When the background was clicked.

 @param bmb The BMB
 */
- (void)boomMenuButtonDidClickBackground:(VHBoomMenuButton *)bmb;

/**
 The reboom animation is going to start.

 @param bmb The BMB
 */
- (void)boomMenuButtonWillReboom:(VHBoomMenuButton *)bmb;

/**
 The reboom animation is finished.

 @param bmb The BMB
 */
- (void)boomMenuButtonDidReboom:(VHBoomMenuButton *)bmb;

/**
 The boom animation is going to start.

 @param bmb The BMB
 */
- (void)boomMenuButtonWillBoom:(VHBoomMenuButton *)bmb;

/**
 The boom animation is finished.

 @param bmb The BMB
 */
- (void)boomMenuButtonDidBoom:(VHBoomMenuButton *)bmb;

@end
