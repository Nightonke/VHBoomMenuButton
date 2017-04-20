//
//  OnButtonClickDelegate.h
//  VHBoomMenuExample
//
//  Created by Nightonke on 16/7/30.
//  Copyright © 2016年 Nightonke. All rights reserved.
//

@protocol VHButtonClickDelegate <NSObject>

@required

/**
 *  One button was clicked
 *
 *  @param index The index of the button
 */
- (void)onButtonClick:(int)index;

@end
