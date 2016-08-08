//
//  VHBackgroundView.h
//  VHBoomMenuExample
//
//  Created by 黄伟平 on 16/7/31.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VHBackgroundClickDelegate.h"

/**
 *  Background of BMB.
 */
@interface VHBackgroundView : UIView

@property (nonatomic, weak) id<VHBackgroundClickDelegate> delegate;

@end