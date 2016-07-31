//
//  VHUtils.h
//  VHBoomMenuExample
//
//  Created by 黄伟平 on 16/7/28.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]
#define UIColorFromARGB(argbValue) [UIColor colorWithRed:((float)((argbValue & 0x00FF0000) >> 16)) / 255.0 green:((float)((argbValue & 0x0000FF00) >> 8)) / 255.0 blue:((float)(argbValue & 0x000000FF)) / 255.0 alpha:((float)((argbValue & 0xFF000000) >> 24)) / 255.0]

@interface VHUtils : NSObject

@end
