//
//  TimeInterpolator.swift
//  BoomMenuButton
//
//  Created by viktorhuang on 2017/4/26.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

public protocol TimeInterpolator {
    func interpolation(_ offset: CGFloat) -> CGFloat
}
