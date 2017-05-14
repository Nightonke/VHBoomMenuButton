//
//  VHHamButtonBuilder.h
//  VHBoomMenuButton
//
//  Created by Nightonke on 16/8/7.
//  Copyright © 2016 Nightonke. All rights reserved.
//

#import "VHBoomButtonWithTextBuilder.h"

@interface VHHamButtonBuilder : VHBoomButtonWithTextBuilder

#pragma mark - Button

/**
 Width (in points) of the boom-button (including the text label).
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b 300 .
 */
@property (nonatomic, assign) CGFloat width;

/**
 Height (in points) of the boom-button (including the text label).
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b 60 .
 */
@property (nonatomic, assign) CGFloat height;

#pragma mark - Sub Text

/**
 Whether the boom-button contains a sub-text. All properties for sub-text only work when "containsSubText" is YES.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b YES .
 */
@property (nonatomic, assign) BOOL containsSubText;

/**
 The sub-text on boom-button at normal state.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b nil .
 */
@property (nonatomic, copy) NSString *normalSubText;

/**
 The sub-text on boom-button at highlighted state.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b nil .
 */
@property (nonatomic, copy) NSString *highlightedSubText;

/**
 The sub-text on boom-button at unable state.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b nil .
 */
@property (nonatomic, copy) NSString *unableSubText;

/**
 The attributed sub-text on boom-button at normal state.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b nil .
 */
@property (nonatomic, copy) NSAttributedString *normalAttributedSubText;

/**
 The attributed sub-text on boom-button at highlighted state.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b nil .
 */
@property (nonatomic, copy) NSAttributedString *highlightedAttributedSubText;

/**
 The attributed sub-text on boom-button at unable state.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b nil .
 */
@property (nonatomic, copy) NSAttributedString *unableAttributedSubText;

/**
 The color of sub-text on boom-button at normal state.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is [UIColor whiteColor].
 */
@property (nonatomic, strong) UIColor *normalSubTextColor;

/**
 The color of sub-text on boom-button at highlighted state.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is [UIColor whiteColor].
 */
@property (nonatomic, strong) UIColor *highlightedSubTextColor;

/**
 The color of sub-text on boom-button at unable state.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is [UIColor whiteColor].
 */
@property (nonatomic, strong) UIColor *unableSubTextColor;

/**
 The frame of sub-text on boom-button.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is CGRectMake(70, 35, boom-button width - 70 - 10, 15).
 */
@property (nonatomic, assign) CGRect subTextFrame;

/**
 The font of sub-text on boom-button.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is [UIFont systemFontOfSize:9].
 */
@property (nonatomic, strong) UIFont *subTextFont;

/**
 The alignment of sub-text on boom-button.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value depends on different type of boom-buttons. Check the init methods in builders of different boom-buttons for more information.
 */
@property (nonatomic, assign) NSTextAlignment subTextAlignment;

/**
 The line break mode of sub-text on boom-button.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b NSLineBreakByTruncatingTail .
 */
@property (nonatomic, assign) NSLineBreakMode subTextLineBreakMode;

/**
 The maximum number of lines to use for sub-text on boom-button.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b 1 .
 */
@property (nonatomic, assign) int subTextLines;

/**
 The color of shadow for sub-text on boom-button.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b nil .
 */
@property (nonatomic, strong) UIColor *subTextShadowColor;

/**
 The shadow offset (in points) on x axis for sub-text on boom-button.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b 0 .
 */
@property (nonatomic, assign) CGFloat subTextShadowOffsetX;

/**
 The shadow offset (in points) on y axis for sub-text on boom-button.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b 0 .
 */
@property (nonatomic, assign) CGFloat subTextShadowOffsetY;

#pragma mark - Public Methods

/**
 Get a builder instance with default properties.
 
 @return An instance of builder to build ham-button.
 */
+ (VHHamButtonBuilder *)builder;

@end
