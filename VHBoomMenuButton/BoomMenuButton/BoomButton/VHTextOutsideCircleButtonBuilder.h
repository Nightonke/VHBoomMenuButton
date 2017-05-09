//
//  VHTextOutsideCircleButtonBuilder.h
//  VHBoomMenuButton
//
//  Created by Nightonke on 16/8/3.
//  Copyright © 2016 Nightonke. All rights reserved.
//

#import "VHBoomButtonWithTextBuilder.h"

@interface VHTextOutsideCircleButtonBuilder : VHBoomButtonWithTextBuilder

/**
 Width (in points) of the boom-button (including the text label).
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b 80 .
 */
@property (nonatomic, assign) CGFloat width;

/**
 Height (in points) of the boom-button (including the text label).
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b 96 .
 */
@property (nonatomic, assign) CGFloat height;

/**
 Whether the boom-button is in a circular shape. If not, then the simple-circle-button looks like a simple-square-button. Only after the 'round' property is false does the corner-radius property work.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b YES .
 */
@property (nonatomic, assign) BOOL round;

#pragma mark - Public Methods

/**
 Get a builder instance with default properties.
 
 @return An instance of builder to build text-outside-circle-button.
 */
+ (VHTextOutsideCircleButtonBuilder *)builder;

@end
