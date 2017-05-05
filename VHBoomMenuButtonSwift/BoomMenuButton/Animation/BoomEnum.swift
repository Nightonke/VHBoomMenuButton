//
//  BoomEnum.swift
//  BoomMenuButton
//
//  Created by Nightonke on 2017/4/26.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

/// The trace of position animations of boom-buttons when booming or rebooming.
///
/// - straightLine: Boom-buttons boom in a straight line.
/// - parabola1: Boom-buttons boom in a parabola line that opens downward.
/// - parabola2: Boom-buttons boom in a parabola line that opens upward.
/// - parabola3: Boom-buttons boom in a parabola line that opens rightward.
/// - parabola4: Boom-buttons boom in a parabola line that opens leftward.
/// - horizontalThrow1: Boom-buttons boom in a horizontal-throw line that opens downward.
/// - horizontalThrow2: Boom-buttons boom in a horizontal-throw line that opens upward.
/// - random: Boom-buttons boom in a random line selected from straight, parabola1, parabola2, parabola3, parabola4, horizonal-throw1 and horizonal-throw2 lines.
public enum BoomEnum: UInt32 {
    
    case straightLine
    case parabola1
    case parabola2
    case parabola3
    case parabola4
    case horizontalThrow1
    case horizontalThrow2
    case random
    
    static var count: Int {
        return BoomEnum.random.hashValue + 1
    }
}
