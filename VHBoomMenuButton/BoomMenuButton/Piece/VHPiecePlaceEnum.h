//
//  VHDotPlaceEnum.h
//  VHBoomMenuExample
//
//  Created by Nightonke on 16/7/28.
//  Copyright © 2016 Nightonke. All rights reserved.
//

#ifndef VHDotPlaceEnum_h
#define VHDotPlaceEnum_h

/**
 VHPiecePlaceEnum tells BMB how the pieces should be placed.
 
 All the piece-place-enums are in the following form:
 
 1. VHPiecePlaceDOT_M_A: M means the number of pieces in a dot or a small square shape. A means different type of placing.
 
 2. VHPiecePlaceHAM_M: M means the number of pieces in a ham shape.
 
 3. VHPiecePlaceShare: Share style.
 
 4. VHPiecePlaceCustom: Allows to customize the positions of pieces.
 
 Check https://github.com/Nightonke/VHBoomMenuButton/wiki for more information.
 */
typedef NS_ENUM(NSUInteger, VHPiecePlaceEnum)
{
    // Dots
    VHPiecePlaceDOT_1 = 0,
    VHPiecePlaceDOT_2_1,
    VHPiecePlaceDOT_2_2,
    VHPiecePlaceDOT_3_1,
    VHPiecePlaceDOT_3_2,
    VHPiecePlaceDOT_3_3,
    VHPiecePlaceDOT_3_4,
    VHPiecePlaceDOT_4_1,
    VHPiecePlaceDOT_4_2,
    VHPiecePlaceDOT_5_1,
    VHPiecePlaceDOT_5_2,
    VHPiecePlaceDOT_5_3,
    VHPiecePlaceDOT_5_4,
    VHPiecePlaceDOT_6_1,
    VHPiecePlaceDOT_6_2,
    VHPiecePlaceDOT_6_3,
    VHPiecePlaceDOT_6_4,
    VHPiecePlaceDOT_6_5,
    VHPiecePlaceDOT_6_6,
    VHPiecePlaceDOT_7_1,
    VHPiecePlaceDOT_7_2,
    VHPiecePlaceDOT_7_3,
    VHPiecePlaceDOT_7_4,
    VHPiecePlaceDOT_7_5,
    VHPiecePlaceDOT_7_6,
    VHPiecePlaceDOT_8_1,
    VHPiecePlaceDOT_8_2,
    VHPiecePlaceDOT_8_3,
    VHPiecePlaceDOT_8_4,
    VHPiecePlaceDOT_8_5,
    VHPiecePlaceDOT_8_6,
    VHPiecePlaceDOT_8_7,
    VHPiecePlaceDOT_9_1,
    VHPiecePlaceDOT_9_2,
    VHPiecePlaceDOT_9_3,

    // Hams
    VHPiecePlaceHAM_1,
    VHPiecePlaceHAM_2,
    VHPiecePlaceHAM_3,
    VHPiecePlaceHAM_4,
    VHPiecePlaceHAM_5,
    VHPiecePlaceHAM_6,
    
    VHPiecePlaceShare,
    
    VHPiecePlaceCustom,
    
    VHPiecePlaceEnumCount,
    
    VHPiecePlaceUnknown  = -1,
};

#endif /* VHDotPlaceEnum_h */
