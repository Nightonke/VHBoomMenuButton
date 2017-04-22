//
//  VHBoomEnum.h
//  VHBoomMenuExample
//
//  Created by Nightonke on 16/7/28.
//  Copyright © 2016年 Nightonke. All rights reserved.
//

#ifndef VHBoomEnum_h
#define VHBoomEnum_h

/**
 The trace of position animations of boom-buttons when booming or rebooming.

 - VHBoomStraightLine: Boom-buttons boom in a straight line.
 - VHBoomParabola_1: Boom-buttons boom in a parabola line that opens downward.
 - VHBoomParabola_2: Boom-buttons boom in a parabola line that opens upward.
 - VHBoomParabola_3: Boom-buttons boom in a parabola line that opens rightward.
 - VHBoomParabola_4: Boom-buttons boom in a parabola line that opens leftward.
 - VHBoomHorizontalThrow_1: Boom-buttons boom in a horizontal-throw line that opens downward.
 - VHBoomHorizontalThrow_2: Boom-buttons boom in a horizontal-throw line that opens upward.
 - VHBoomRandom: Boom-buttons boom in a random line selected from straight, parabola1, parabola2, parabola3, parabola4, horizonal-throw1 and horizonal-throw2 lines.
 */
typedef NS_ENUM(NSUInteger, VHBoomEnum)
{
    VHBoomStraightLine = 0,
    VHBoomParabola_1,
    VHBoomParabola_2,
    VHBoomParabola_3,
    VHBoomParabola_4,
    VHBoomHorizontalThrow_1,
    VHBoomHorizontalThrow_2,
    VHBoomRandom,
    
    VHBoomEnumCount,
};

#endif /* VHBoomEnum_h */
