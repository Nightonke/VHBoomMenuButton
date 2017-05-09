//
//  VHButtonEnum.h
//  VHBoomMenuExample
//
//  Created by Nightonke on 16/7/28.
//  Copyright © 2016 Nightonke. All rights reserved.
//

#ifndef VHButtonEnum_h
#define VHButtonEnum_h

/**
 Button type supported by BMB.

 - VHButtonSimpleCircle: Boom-button with only an image in a circular or a square shape.
 - VHButtonTextInsideCircle: Boom-button with an image and a text inside in a circular or a square shape.
 - VHButtonTextOutsideCircle: Boom-button with an image and a text outside in a circular or a square shape.
 - VHButtonHam: Boom-button with an image, a text and a sub-text inside in a rectangle shape.
 - VHButtonUnknown: Boom-button unknown.
 */
typedef NS_ENUM(NSUInteger, VHButtonEnum)
{
    VHButtonSimpleCircle,
    VHButtonTextInsideCircle,
    VHButtonTextOutsideCircle,
    VHButtonHam,
    
    VHButtonUnknown = -1,
};

#endif /* VHButtonEnum_h */
