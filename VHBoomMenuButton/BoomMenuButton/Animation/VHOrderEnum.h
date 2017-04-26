//
//  VHOrderEnum.h
//  VHBoomMenuExample
//
//  Created by Nightonke on 16/7/29.
//  Copyright © 2016年 Nightonke. All rights reserved.
//

#ifndef VHOrderEnum_h
#define VHOrderEnum_h

/**
 The order of boom-buttons when booming or rebooming.

 - VHOrderDefault: In-order.
 - VHOrderReverse: Reverse.
 - VHOrderRandom: Random.
 */
typedef NS_ENUM(NSUInteger, VHOrderEnum)
{
    VHOrderDefault = 0,
    VHOrderReverse = 1,
    VHOrderRandom  = 2,
};

#endif /* VHOrderEnum_h */
