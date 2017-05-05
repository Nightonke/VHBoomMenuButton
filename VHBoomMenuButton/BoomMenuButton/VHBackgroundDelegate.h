//
//  VHBackgroundDelegate.h
//  VHBoomMenuExample
//
//  Created by Nightonke on 16/7/31.
//  Copyright © 2016年 Nightonke. All rights reserved.
//

/**
 *  Delegate for background clicked.
 */
@protocol VHBackgroundDelegate <NSObject>

@required
- (void)backgroundDidClick;

@end
