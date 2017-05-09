//
//  VHBoomEnum.h
//  VHBoomMenuExample
//
//  Created by Nightonke on 16/7/28.
//  Copyright © 2016 Nightonke. All rights reserved.
//

#ifndef VHBoomEnum_h
#define VHBoomEnum_h

/**
 The trace of position animations of boom-buttons when booming or rebooming.

 - VHBoomStraightLine: Boom-buttons boom in a straight line.
 - VHBoomParabola1: Boom-buttons boom in a parabola line that opens downward.
 - VHBoomParabola2: Boom-buttons boom in a parabola line that opens upward.
 - VHBoomParabola3: Boom-buttons boom in a parabola line that opens rightward.
 - VHBoomParabola4: Boom-buttons boom in a parabola line that opens leftward.
 - VHBoomHorizontalThrow1: Boom-buttons boom in a horizontal-throw line that opens downward.
 - VHBoomHorizontalThrow2: Boom-buttons boom in a horizontal-throw line that opens upward.
 - VHBoomRandom: Boom-buttons boom in a random line selected from straight, parabola1, parabola2, parabola3, parabola4, horizonal-throw1 and horizonal-throw2 lines.
 */
typedef NS_ENUM(NSUInteger, VHBoomEnum)
{
    VHBoomStraightLine = 0,
    VHBoomParabola1,
    VHBoomParabola2,
    VHBoomParabola3,
    VHBoomParabola4,
    VHBoomHorizontalThrow1,
    VHBoomHorizontalThrow2,
    VHBoomRandom,
    
    VHBoomEnumCount,
};

#endif /* VHBoomEnum_h */
