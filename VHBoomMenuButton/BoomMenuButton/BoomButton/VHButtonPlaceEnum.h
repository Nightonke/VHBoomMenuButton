//
//  VHButtonPlaceEnum.h
//  VHBoomMenuExample
//
//  Created by Nightonke on 16/7/29.
//  Copyright © 2016 Nightonke. All rights reserved.
//

#ifndef VHButtonPlaceEnum_h
#define VHButtonPlaceEnum_h

/**
 VHButtonPlaceEnum tells BMB how the boom-buttons should be placed.
 
 All the button-place-enums are in the following form:
 
 1. VHButtonPlaceSC_M_A: M means the number of boom-buttons in a circle or a square shape. A means different type of placing.
 
 2. VHButtonPlaceHAM_M: M means the number of boom-buttons in a ham shape.
 
 3. VHButtonPlaceHorizontal: All the boom-buttons are placed horizontally.
 
 4. VHButtonPlaceVertical: All the boom-buttons are place vertically.
 
 5. VHButtonPlaceCustom: Allows to customize the positions of buttons.
 
 Check https://github.com/Nightonke/VHBoomMenuButton/wiki for more information.
 */
typedef NS_ENUM(NSUInteger, VHButtonPlaceEnum)
{
    // Simple Circles, Text Inside Dots and Text Outside Dots.
    VHButtonPlaceSC_1 = 0,
    VHButtonPlaceSC_2_1,
    VHButtonPlaceSC_2_2,
    VHButtonPlaceSC_3_1,
    VHButtonPlaceSC_3_2,
    VHButtonPlaceSC_3_3,
    VHButtonPlaceSC_3_4,
    VHButtonPlaceSC_4_1,
    VHButtonPlaceSC_4_2,
    VHButtonPlaceSC_5_1,
    VHButtonPlaceSC_5_2,
    VHButtonPlaceSC_5_3,
    VHButtonPlaceSC_5_4,
    VHButtonPlaceSC_6_1,
    VHButtonPlaceSC_6_2,
    VHButtonPlaceSC_6_3,
    VHButtonPlaceSC_6_4,
    VHButtonPlaceSC_6_5,
    VHButtonPlaceSC_6_6,
    VHButtonPlaceSC_7_1,
    VHButtonPlaceSC_7_2,
    VHButtonPlaceSC_7_3,
    VHButtonPlaceSC_7_4,
    VHButtonPlaceSC_7_5,
    VHButtonPlaceSC_7_6,
    VHButtonPlaceSC_8_1,
    VHButtonPlaceSC_8_2,
    VHButtonPlaceSC_8_3,
    VHButtonPlaceSC_8_4,
    VHButtonPlaceSC_8_5,
    VHButtonPlaceSC_8_6,
    VHButtonPlaceSC_8_7,
    VHButtonPlaceSC_9_1,
    VHButtonPlaceSC_9_2,
    VHButtonPlaceSC_9_3,

    // Hams.
    VHButtonPlaceHAM_1,
    VHButtonPlaceHAM_2,
    VHButtonPlaceHAM_3,
    VHButtonPlaceHAM_4,
    VHButtonPlaceHAM_5,
    VHButtonPlaceHAM_6,

    // Common
    VHButtonPlaceHorizontal,
    VHButtonPlaceVertical,
    
    VHButtonPlaceCustom,
    
    VHButtonPlaceEnumCount,
    
    VHButtonPlaceUnknown = -1,
    
};

#endif /* VHButtonPlaceEnum_h */
