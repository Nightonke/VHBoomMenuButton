//
//  VHSimpleCircleButtonInfo.h
//  VHBoomMenuExample
//
//  Created by Nightonke on 16/7/31.
//  Copyright © 2016 Nightonke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VHBoomButtonBuilder.h"

@interface VHSimpleCircleButtonBuilder : VHBoomButtonBuilder

/**
 The radius (in points) of the circular (or square) button.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b 40 .
 */
@property (nonatomic, assign) CGFloat radius;

/**
 Whether the boom-button is in a circular shape. If not, then the simple-circle-button looks like a simple-square-button. Only after the 'round' property is false does the corner-radius property work.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b YES .
 */
@property (nonatomic, assign) BOOL round;

#pragma mark - Public Methods

/**
 Get a builder instance with default properties.
 
 @return An instance of builder to build simple-circle-button.
 */
+ (VHSimpleCircleButtonBuilder *)builder;

@end
