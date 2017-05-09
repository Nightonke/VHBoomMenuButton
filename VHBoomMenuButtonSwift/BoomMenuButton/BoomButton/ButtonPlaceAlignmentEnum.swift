//
//  ButtonPlaceAlignmentEnum.swift
//  BoomMenuButton
//
//  Created by Nightonke on 2017/4/28.
//  Copyright © 2017 Nightonke. All rights reserved.
//

/// ButtonPlaceAlignmentEnum tells BMB the boom-buttons' alignment position.
///
/// - center: Center in the screen.
/// - top: Top.
/// - bottom: Bottom.
/// - left: Center-left.
/// - right: Center-right.
/// - topLeft: Top-left.
/// - topRight: Top-right.
/// - bottomLeft: Bottom-left.
/// - bottomRight: Bottom-right.
public enum ButtonPlaceAlignmentEnum {
    
    case center
    case top
    case bottom
    case left
    case right
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
    
    static var count: Int {
        return ButtonPlaceAlignmentEnum.bottomRight.hashValue + 1
    }
}
