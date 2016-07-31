//
//  VHEaseManager.m
//  VHMediaTimingFunction
//
//  Created by 黄伟平 on 16/7/22.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import "VHEaseManager.h"

@implementation VHEaseManager

+ (VHEase *)easeWithEnum:(VHEaseEnum)ease
{
    switch (ease)
    {
        case VHEaseInBack:
            return [[VHEase alloc] initWithStartX:0.600
                                           startY:-0.280
                                             endX:0.735
                                             endY:0.045];
            break;
        case VHEaseInCirc:
            return [[VHEase alloc] initWithStartX:0.600
                                           startY:0.040
                                             endX:0.980
                                             endY:0.335];
            break;
        case VHEaseInCubic:
            return [[VHEase alloc] initWithStartX:0.550
                                           startY:0.055
                                             endX:0.675
                                             endY:0.190];
            break;
        case VHEaseInExpo:
            return [[VHEase alloc] initWithStartX:0.950
                                           startY:0.050
                                             endX:0.795
                                             endY:0.035];
            break;
        case VHEaseOutBack:
            return [[VHEase alloc] initWithStartX:0.175
                                           startY:0.885
                                             endX:0.320
                                             endY:1.275];
            break;
        case VHEaseOutCirc:
            return [[VHEase alloc] initWithStartX:0.075
                                           startY:0.820
                                             endX:0.165
                                             endY:1.000];
            break;
        case VHEaseOutCubic:
            return [[VHEase alloc] initWithStartX:0.215
                                           startY:0.610
                                             endX:0.355
                                             endY:1.000];
            break;
        case VHEaseOutExpo:
            return [[VHEase alloc] initWithStartX:0.190
                                           startY:1.000
                                             endX:0.220
                                             endY:1.000];
            break;
        case VHEaseInOutBack:
            return [[VHEase alloc] initWithStartX:0.680
                                           startY:-0.550
                                             endX:0.265
                                             endY:1.550];
            break;
        case VHEaseInOutCirc:
            return [[VHEase alloc] initWithStartX:0.785
                                           startY:0.135
                                             endX:0.150
                                             endY:0.860];
            break;
        case VHEaseInOutCubic:
            return [[VHEase alloc] initWithStartX:0.645
                                           startY:0.045
                                             endX:0.335
                                             endY:1.000];
            break;
        case VHEaseInOutExpo:
            return [[VHEase alloc] initWithStartX:1.000
                                           startY:0.000
                                             endX:0.000
                                             endY:1.000];
            break;
        case VHEaseInElastic:
        case VHEaseInOutBounce:
        case VHEaseOutElastic:
        case VHEaseOutBounce:
        case VHEaseInOutElastic:
        case VHEaseInBounce:
            return [[VHEase alloc] initWithEnum:ease];
        case VHEaseLinear:
        default:
            return [[VHEase alloc] initWithStartX:0.000
                                           startY:0.000
                                             endX:1.000
                                             endY:1.000];
            break;
    }
}

+ (VHEase *)easeWithX1:(CGFloat)x1 Y1:(CGFloat)y1 X2:(CGFloat)x2 Y2:(CGFloat)y2
{
    return [[VHEase alloc] initWithStartX:x1 startY:y1 endX:x2 endY:y2];
}

@end
