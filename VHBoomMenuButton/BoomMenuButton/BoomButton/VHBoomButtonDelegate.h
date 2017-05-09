//
//  VHBoomButtonDelegate.h
//  VHBoomMenuButton
//
//  Created by Nightonke on 2017/4/11.
//  Copyright © 2017 Nightonke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VHBoomButton.h"

@class VHBoomButton;

@protocol VHBoomButtonDelegate <NSObject>

@required
- (void)onButton:(VHBoomButton *)boomButton clickedAt:(int)index;

@end
