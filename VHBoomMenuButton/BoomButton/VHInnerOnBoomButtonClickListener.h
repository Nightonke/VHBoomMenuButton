//
//  VHInnerOnBoomButtonClickListener.h
//  VHBoomMenuButton
//
//  Created by viktorhuang on 2017/4/11.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VHBoomButton.h"

@class VHBoomButton;

@protocol VHInnerOnBoomButtonClickListener <NSObject>

@required
- (void)onButton:(VHBoomButton *)boomButton clickedAt:(int)index;

@end
