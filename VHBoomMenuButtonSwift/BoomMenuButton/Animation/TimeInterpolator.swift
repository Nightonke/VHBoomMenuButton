//
//  TimeInterpolator.swift
//  BoomMenuButton
//
//  Created by Nightonke on 2017/4/26.
//  Copyright © 2017 Nightonke. All rights reserved.
//

public protocol TimeInterpolator {
    func interpolation(_ offset: CGFloat) -> CGFloat
}
