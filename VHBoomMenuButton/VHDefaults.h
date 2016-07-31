//
//  VHDefaults.h
//  VHBoomMenuExample
//
//  Created by 黄伟平 on 16/7/30.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VHUtils.h"
#import "VHOrderEnum.h"
#import "VHBoomEnum.h"
#import "VHEaseEnum.h"

// Default values for boom menu button

static const CGFloat DEFAULT_BOOM_MENU_BUTTON_SHADOW_WIDTH             = 5;
static const CGFloat DEFAULT_BOOM_MENU_BUTTON_SHADOW_OFFSET_X          = 0.0f;
static const CGFloat DEFAULT_BOOM_MENU_BUTTON_SHADOW_OFFSET_Y          = 3.0f;
static const CGFloat DEFAULT_BOOM_MENU_BUTTON_SHADOW_OPACITY           = 0.15f;
#define              DEFAULT_BOOM_MENU_BUTTON_SHADOW_COLOR  UIColorFromRGB(0x000000)
static const CGFloat DEFAULT_BOOM_MENU_BUTTON_RADIUS                   = 40.0f;
static const CGFloat DEFAULT_BOOM_MENU_BUTTON_DOT_RADIUS               = 2.0f;
static const CGFloat DEFAULT_BOOM_MENU_BUTTON_BAR_WIDTH                = 15.0f;
static const CGFloat DEFAULT_BOOM_MENU_BUTTON_BAR_HEIGHT               = 3.0f;
static const CGFloat DEFAULT_BOOM_MENU_BUTTON_BLOCK_WIDTH              = 4.0f;
static const CGFloat DEFAULT_BOOM_MENU_BUTTON_BLOCK_HEIGHT             = 4.0f;
#define              DEFAULT_BOOM_MENU_BUTTON_NORMAL_COLOR  UIColorFromRGB(0x2699ea)
#define              DEFAULT_BOOM_MENU_BUTTON_PRESSED_COLOR UIColorFromRGB(0x73bdf1)
static const VHOrderEnum DEFAULT_BOOM_MENU_BUTTON_SHOW_ORDER           = Random;
static const VHOrderEnum DEFAULT_BOOM_MENU_BUTTON_HIDE_ORDER           = Random;
static const VHBoomEnum DEFAULT_BOOM_MENU_BUTTON_BOOM_ENUM             = StraightLine;
#define              DEFAULT_BOOM_MENU_BUTTON_DIM_COLOR  UIColorFromARGB(0x33000000)
static const VHEaseEnum DEFAULT_BOOM_MENU_BUTTON_SHOW_MOVE_EASE_ENUM   = VHEaseOutBack;
static const VHEaseEnum DEFAULT_BOOM_MENU_BUTTON_SHOW_SCALE_EASE_ENUM  = VHEaseOutBack;
static const VHEaseEnum DEFAULT_BOOM_MENU_BUTTON_SHOW_ROTATE_EASE_ENUM = VHEaseOutBack;
static const VHEaseEnum DEFAULT_BOOM_MENU_BUTTON_HIDE_MOVE_EASE_ENUM   = VHEaseInBack;
static const VHEaseEnum DEFAULT_BOOM_MENU_BUTTON_HIDE_SCALE_EASE_ENUM  = VHEaseInBack;
static const VHEaseEnum DEFAULT_BOOM_MENU_BUTTON_HIDE_ROTATE_EASE_ENUM = VHEaseInBack;
static const BOOL DEFAULT_BOOM_MENU_BUTTON_AUTO_HIDE                   = YES;
static const BOOL DEFAULT_BOOM_MENU_BUTTON_CANCELABLE                  = YES;
static const int DEFAULT_BOOM_MENU_BUTTON_FRAMES                       = 80;
static const float DEFAULT_BOOM_MENU_BUTTON_DURATION                   = 0.7;
static const float DEFAULT_BOOM_MENU_BUTTON_DELAY                      = 0.1;
static const float DEFAULT_BOOM_MENU_BUTTON_ROTATION_DEGREE            = M_PI * 4;

// Default values for simple circle button
static const CGFloat DEFAULT_SIMPLE_CIRCLE_BUTTON_SHADOW_WIDTH = 5;
static const CGFloat DEFAULT_SIMPLE_CIRCLE_BUTTON_SHADOW_OFFSET_X = 0.0f;
static const CGFloat DEFAULT_SIMPLE_CIRCLE_BUTTON_SHADOW_OFFSET_Y = 3.0f;
static const CGFloat DEFAULT_SIMPLE_CIRCLE_BUTTON_SHADOW_OPACITY  = 0.15f;
#define              DEFAULT_SIMPLE_CIRCLE_BUTTON_SHADOW_COLOR  UIColorFromRGB(0x000000)
static const CGFloat DEFAULT_SIMPLE_CIRCLE_BUTTON_RADIUS   = 40.0f;
#define              DEFAULT_SIMPLE_CIRCLE_BUTTON_NORMAL_COLOR  UIColorFromRGB(0x2699ea)
#define              DEFAULT_SIMPLE_CIRCLE_BUTTON_PRESSED_COLOR UIColorFromRGB(0x73bdf1)

@interface VHDefaults : NSObject

@end
