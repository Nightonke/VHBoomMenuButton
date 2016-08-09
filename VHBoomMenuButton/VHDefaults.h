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
#import "VHButtonPlaceAlignmentEnum.h"

// Default values for boom menu button

static const CGFloat DEFAULT_BOOM_MENU_BUTTON_SHADOW_WIDTH                       = 5;
static const CGFloat DEFAULT_BOOM_MENU_BUTTON_SHADOW_OFFSET_X                    = 0.0f;
static const CGFloat DEFAULT_BOOM_MENU_BUTTON_SHADOW_OFFSET_Y                    = 3.0f;
static const CGFloat DEFAULT_BOOM_MENU_BUTTON_SHADOW_OPACITY                     = 0.15f;
#define              DEFAULT_BOOM_MENU_BUTTON_SHADOW_COLOR  UIColorFromRGB(0x000000)
static const CGFloat DEFAULT_BOOM_MENU_BUTTON_RADIUS                             = 40.0f;
static const CGFloat DEFAULT_BOOM_MENU_BUTTON_DOT_RADIUS                         = 3.0f;
static const CGFloat DEFAULT_BOOM_MENU_BUTTON_HAM_WIDTH                          = 15.0f;
static const CGFloat DEFAULT_BOOM_MENU_BUTTON_HAM_HEIGHT                         = 3.0f;
static const CGFloat DEFAULT_BOOM_MENU_BUTTON_BLOCK_WIDTH                        = 4.0f;
static const CGFloat DEFAULT_BOOM_MENU_BUTTON_BLOCK_HEIGHT                       = 4.0f;
#define              DEFAULT_BOOM_MENU_BUTTON_NORMAL_COLOR  UIColorFromRGB(0x2699ea)
#define              DEFAULT_BOOM_MENU_BUTTON_PRESSED_COLOR UIColorFromRGB(0x73bdf1)
static const VHButtonPlaceAlignmentEnum DEFAULT_BOOM_MENU_BUTTON_PLACE_ALIGNMENT = VHButtonPlaceAlignmentCenter;
static const VHOrderEnum DEFAULT_BOOM_MENU_BUTTON_SHOW_ORDER                     = VHOrderRandom;
static const VHOrderEnum DEFAULT_BOOM_MENU_BUTTON_HIDE_ORDER                     = VHOrderRandom;
static const VHBoomEnum DEFAULT_BOOM_MENU_BUTTON_BOOM_ENUM                       = VHBoomStraightLine;
#define              DEFAULT_BOOM_MENU_BUTTON_DIM_COLOR  UIColorFromARGB(0x33000000)
static const VHEaseEnum DEFAULT_BOOM_MENU_BUTTON_SHOW_MOVE_EASE_ENUM             = VHEaseOutBack;
static const VHEaseEnum DEFAULT_BOOM_MENU_BUTTON_SHOW_SCALE_EASE_ENUM            = VHEaseOutBack;
static const VHEaseEnum DEFAULT_BOOM_MENU_BUTTON_SHOW_ROTATE_EASE_ENUM           = VHEaseOutBack;
static const VHEaseEnum DEFAULT_BOOM_MENU_BUTTON_HIDE_MOVE_EASE_ENUM             = VHEaseInBack;
static const VHEaseEnum DEFAULT_BOOM_MENU_BUTTON_HIDE_SCALE_EASE_ENUM            = VHEaseInBack;
static const VHEaseEnum DEFAULT_BOOM_MENU_BUTTON_HIDE_ROTATE_EASE_ENUM           = VHEaseInBack;
static const BOOL DEFAULT_BOOM_MENU_BUTTON_AUTO_HIDE                             = YES;
static const BOOL DEFAULT_BOOM_MENU_BUTTON_CANCELABLE                            = YES;
static const BOOL DEFAULT_BOOM_MENU_BUTTON_NO_BACKGROUND                         = NO;
static const BOOL DEFAULT_BOOM_MENU_BUTTON_DRAGGABLE                             = NO;
static const int DEFAULT_BOOM_MENU_BUTTON_FRAMES                                 = 80;
static const float DEFAULT_BOOM_MENU_BUTTON_DURATION                             = 0.7;
static const float DEFAULT_BOOM_MENU_BUTTON_DELAY                                = 0.1;
static const float DEFAULT_BOOM_MENU_BUTTON_ROTATION_DEGREE                      = M_PI * 4;
static const float DEFAULT_BOOM_MENU_BUTTON_HORIZONTAL_MARGIN                    = 10;
static const float DEFAULT_BOOM_MENU_BUTTON_VERTICAL_MARGIN                      = 10;
static const float DEFAULT_BOOM_MENU_BUTTON_INCLINED_MARGIN                      = 10;
static const float DEFAULT_BOOM_MENU_BUTTON_TOP_MARGIN                           = 20;
static const float DEFAULT_BOOM_MENU_BUTTON_BOTTOM_MARGIN                        = 20;
static const float DEFAULT_BOOM_MENU_BUTTON_LEFT_MARGIN                          = 20;
static const float DEFAULT_BOOM_MENU_BUTTON_RIGHT_MARGIN                         = 20;
static const float DEFAULT_BOOM_MENU_BUTTON_PIECE_HORIZONTAL_MARGIN              = 2;
static const float DEFAULT_BOOM_MENU_BUTTON_PIECE_VERTICAL_MARGIN                = 2;
static const float DEFAULT_BOOM_MENU_BUTTON_PIECE_INCLINED_MARGIN                = 2;
static const float DEFAULT_BOOM_MENU_BUTTON_LAST_HAM_BUTTON_MARGIN_MORE_TOP      = YES;
static const float DEFAULT_BOOM_MENU_BUTTON_LAST_HAM_BUTTOM_TOP_MARGIN           = 30;

// Default values for simple circle button

static const CGFloat DEFAULT_SIMPLE_CIRCLE_BUTTON_SHADOW_WIDTH    = 5;
static const CGFloat DEFAULT_SIMPLE_CIRCLE_BUTTON_SHADOW_OFFSET_X = 0.0f;
static const CGFloat DEFAULT_SIMPLE_CIRCLE_BUTTON_SHADOW_OFFSET_Y = 3.0f;
static const CGFloat DEFAULT_SIMPLE_CIRCLE_BUTTON_SHADOW_OPACITY  = 0.15f;
#define              DEFAULT_SIMPLE_CIRCLE_BUTTON_SHADOW_COLOR  UIColorFromRGB(0x000000)
static const CGFloat DEFAULT_SIMPLE_CIRCLE_BUTTON_RADIUS          = 40.0f;
#define              DEFAULT_SIMPLE_CIRCLE_BUTTON_NORMAL_COLOR  UIColorFromRGB(0x2699ea)
#define              DEFAULT_SIMPLE_CIRCLE_BUTTON_PRESSED_COLOR UIColorFromRGB(0x73bdf1)

// Default values for text inside circle button

static const CGFloat DEFAULT_TEXT_INSIDE_CIRCLE_BUTTON_SHADOW_WIDTH                 = 5;
static const CGFloat DEFAULT_TEXT_INSIDE_CIRCLE_BUTTON_SHADOW_OFFSET_X              = 0.0f;
static const CGFloat DEFAULT_TEXT_INSIDE_CIRCLE_BUTTON_SHADOW_OFFSET_Y              = 3.0f;
static const CGFloat DEFAULT_TEXT_INSIDE_CIRCLE_BUTTON_SHADOW_OPACITY               = 0.15f;
#define              DEFAULT_TEXT_INSIDE_CIRCLE_BUTTON_SHADOW_COLOR  UIColorFromRGB(0x000000)
static const CGFloat DEFAULT_TEXT_INSIDE_CIRCLE_BUTTON_RADIUS                       = 40.0f;
#define              DEFAULT_TEXT_INSIDE_CIRCLE_BUTTON_NORMAL_COLOR  UIColorFromRGB(0x2699ea)
#define              DEFAULT_TEXT_INSIDE_CIRCLE_BUTTON_PRESSED_COLOR UIColorFromRGB(0x73bdf1)
#define              DEFAULT_TEXT_INSIDE_CIRCLE_BUTTON_TEXT_NORMAL_COLOR  UIColorFromRGB(0xffffff)
#define              DEFAULT_TEXT_INSIDE_CIRCLE_BUTTON_TEXT_PRESSED_COLOR UIColorFromRGB(0xffffff)
static const CGFloat DEFAULT_TEXT_INSIDE_CIRCLE_BUTTON_TEXT_SIZE                    = 10;
static const NSLineBreakMode DEFAULT_TEXT_INSIDE_CIRCLE_BUTTON_TEXT_LINE_BREAK_MODE = NSLineBreakByWordWrapping;
static const int DEFAULT_TEXT_INSIDE_CIRCLE_BUTTON_TEXT_LINES                       = 1;
static const BOOL DEFAULT_TEXT_INSIDE_CIRCLE_BUTTON_ROTATE_IMAGE                    = YES;
static const BOOL DEFAULT_TEXT_INSIDE_CIRCLE_BUTTON_ROTATE_TEXT                     = YES;

// Default values for text outside circle button

static const CGFloat DEFAULT_TEXT_OUTSIDE_CIRCLE_BUTTON_SHADOW_WIDTH                 = 5;
static const CGFloat DEFAULT_TEXT_OUTSIDE_CIRCLE_BUTTON_SHADOW_OFFSET_X              = 0.0f;
static const CGFloat DEFAULT_TEXT_OUTSIDE_CIRCLE_BUTTON_SHADOW_OFFSET_Y              = 3.0f;
static const CGFloat DEFAULT_TEXT_OUTSIDE_CIRCLE_BUTTON_SHADOW_OPACITY               = 0.15f;
#define              DEFAULT_TEXT_OUTSIDE_CIRCLE_BUTTON_SHADOW_COLOR  UIColorFromRGB(0x000000)
static const CGFloat DEFAULT_TEXT_OUTSIDE_CIRCLE_BUTTON_TEXT_SHADOW_OFFSET_X         = 0.0f;
static const CGFloat DEFAULT_TEXT_OUTSIDE_CIRCLE_BUTTON_TEXT_SHADOW_OFFSET_Y         = 0.5f;
#define              DEFAULT_TEXT_OUTSIDE_CIRCLE_BUTTON_TEXT_SHADOW_COLOR  UIColorFromARGB(0x33000000)
static const CGFloat DEFAULT_TEXT_OUTSIDE_CIRCLE_BUTTON_WIDTH                        = 80.0f;
static const CGFloat DEFAULT_TEXT_OUTSIDE_CIRCLE_BUTTON_HEIGHT                       = 100.0f;
#define              DEFAULT_TEXT_OUTSIDE_CIRCLE_BUTTON_NORMAL_COLOR  UIColorFromRGB(0x2699ea)
#define              DEFAULT_TEXT_OUTSIDE_CIRCLE_BUTTON_PRESSED_COLOR UIColorFromRGB(0x73bdf1)
#define              DEFAULT_TEXT_OUTSIDE_CIRCLE_BUTTON_TEXT_NORMAL_COLOR  UIColorFromRGB(0xffffff)
#define              DEFAULT_TEXT_OUTSIDE_CIRCLE_BUTTON_TEXT_PRESSED_COLOR UIColorFromRGB(0xffffff)
static const CGFloat DEFAULT_TEXT_OUTSIDE_CIRCLE_BUTTON_TEXT_SIZE                    = 14;
static const NSLineBreakMode DEFAULT_TEXT_OUTSIDE_CIRCLE_BUTTON_TEXT_LINE_BREAK_MODE = NSLineBreakByWordWrapping;
static const int DEFAULT_TEXT_OUTSIDE_CIRCLE_BUTTON_TEXT_LINES                       = 1;
static const BOOL DEFAULT_TEXT_OUTSIDE_CIRCLE_BUTTON_ROTATE_IMAGE                    = YES;
static const BOOL DEFAULT_TEXT_OUTSIDE_CIRCLE_BUTTON_ROTATE_TEXT                     = YES;
static const BOOL DEFAULT_TEXT_OUTSIDE_CIRCLE_BUTTON_SHADOW_TEXT                     = YES;

// Default values for ham button

static const CGFloat DEFAULT_HAM_BUTTON_SHADOW_WIDTH                      = 5;
static const CGFloat DEFAULT_HAM_BUTTON_SHADOW_HEIGHT                     = 5;
static const CGFloat DEFAULT_HAM_BUTTON_SHADOW_CORNER_RADIUS              = 5;
static const CGFloat DEFAULT_HAM_BUTTON_SHADOW_OFFSET_X                   = 0.0f;
static const CGFloat DEFAULT_HAM_BUTTON_SHADOW_OFFSET_Y                   = 3.0f;
static const CGFloat DEFAULT_HAM_BUTTON_SHADOW_OPACITY                    = 0.15f;
#define              DEFAULT_HAM_BUTTON_SHADOW_COLOR  UIColorFromRGB(0x000000)
static const CGFloat DEFAULT_HAM_BUTTON_HEIGHT                            = 60.0f;
static const CGFloat DEFAULT_HAM_BUTTON_CORNER_RADIUS                     = 5;
#define              DEFAULT_HAM_BUTTON_NORMAL_COLOR  UIColorFromRGB(0x2699ea)
#define              DEFAULT_HAM_BUTTON_PRESSED_COLOR UIColorFromRGB(0x73bdf1)
#define              DEFAULT_HAM_BUTTON_TITLE_NORMAL_COLOR  UIColorFromRGB(0xffffff)
#define              DEFAULT_HAM_BUTTON_TITLE_PRESSED_COLOR UIColorFromRGB(0xffffff)
#define              DEFAULT_HAM_BUTTON_SUB_TITLE_NORMAL_COLOR  UIColorFromRGB(0xffffff)
#define              DEFAULT_HAM_BUTTON_SUB_TITLE_PRESSED_COLOR UIColorFromRGB(0xffffff)
static const CGFloat DEFAULT_HAM_BUTTON_TITLE_SIZE                        = 20;
static const NSLineBreakMode DEFAULT_HAM_BUTTON_TITLE_LINE_BREAK_MODE     = NSLineBreakByWordWrapping;
static const int DEFAULT_HAM_BUTTON_TITLE_LINES                           = 1;
static const NSTextAlignment DEFAULT_HAM_BUTTON_TITLE_ALIGNMENT           = NSTextAlignmentLeft;
static const CGFloat DEFAULT_HAM_BUTTON_SUB_TITLE_SIZE                    = 12;
static const NSLineBreakMode DEFAULT_HAM_BUTTON_SUB_TITLE_LINE_BREAK_MODE = NSLineBreakByWordWrapping;
static const int DEFAULT_HAM_BUTTON_SUB_TITLE_LINES                       = 1;
static const NSTextAlignment DEFAULT_HAM_BUTTON_SUB_TITLE_ALIGNMENT       = NSTextAlignmentLeft;
static const BOOL DEFAULT_HAM_BUTTON_ROTATE_IMAGE                         = YES;
static const BOOL DEFAULT_HAM_BUTTON_CONTAIN_IMAGE                        = YES;

@interface VHDefaults : NSObject

@end
