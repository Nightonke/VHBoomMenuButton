//
//  VHBoomButtonWithTextBuilder.h
//  VHBoomMenuButton
//
//  Created by Nightonke on 2017/4/13.
//  Copyright © 2017 Nightonke. All rights reserved.
//

#import "VHBoomButtonBuilder.h"

@interface VHBoomButtonWithTextBuilder : VHBoomButtonBuilder

/**
 The text on boom-button at normal state.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b nil .
 */
@property (nonatomic, copy) NSString *normalText;

/**
 The text on boom-button at highlighted state.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b nil .
 */
@property (nonatomic, copy) NSString *highlightedText;

/**
 The text on boom-button at unable state.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b nil .
 */
@property (nonatomic, copy) NSString *unableText;

/**
 The attributed text on boom-button at normal state.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b nil .
 */
@property (nonatomic, copy) NSAttributedString *normalAttributedText;

/**
 The attributed text on boom-button at highlighted state.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b nil .
 */
@property (nonatomic, copy) NSAttributedString *highlightedAttributedText;

/**
 The attributed text on boom-button at unable state.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b nil .
 */
@property (nonatomic, copy) NSAttributedString *unableAttributedText;

/**
 The color of text on boom-button at normal state.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is [UIColor whiteColor].
 */
@property (nonatomic, strong) UIColor *normalTextColor;

/**
 The color of text on boom-button at highlighted state.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is [UIColor whiteColor].
 */
@property (nonatomic, strong) UIColor *highlightedTextColor;

/**
 The color of text on boom-button at unable state.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is [UIColor whiteColor].
 */
@property (nonatomic, strong) UIColor *unableTextColor;

/**
 The frame of text on boom-button.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value depends on different type of boom-buttons. Check the init methods in builders of different boom-buttons for more information.
 */
@property (nonatomic, assign) CGRect textFrame;

/**
 The font of text on boom-button.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value depends on different type of boom-buttons. Check the init methods in builders of different boom-buttons for more information.
 */
@property (nonatomic, strong) UIFont *textFont;

/**
 The alignment of text on boom-button.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value depends on different type of boom-buttons. Check the init methods in builders of different boom-buttons for more information.
 */
@property (nonatomic, assign) NSTextAlignment textAlignment;

/**
 The line break mode of text on boom-button.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b NSLineBreakByTruncatingTail .
 */
@property (nonatomic, assign) NSLineBreakMode textLineBreakMode;

/**
 The maximum number of lines to use for text on boom-button.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b 1 .
 */
@property (nonatomic, assign) int textLines;

/**
 The color of shadow for text on boom-button.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b nil .
 */
@property (nonatomic, strong) UIColor *textShadowColor;

/**
 The shadow offset (in points) on x axis for text on boom-button.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b 0 .
 */
@property (nonatomic, assign) CGFloat textShadowOffsetX;

/**
 The shadow offset (in points) on y axis for text on boom-button.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b 0 .
 */
@property (nonatomic, assign) CGFloat textShadowOffsetY;

/**
 Whether the text plays rotation animation when booming and rebooming.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value depends on different type of boom-buttons. Check the init methods in builders of different boom-buttons for more information.
 */
@property (nonatomic, assign) BOOL rotateText;

@end
