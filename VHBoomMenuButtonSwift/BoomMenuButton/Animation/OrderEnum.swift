//
//  OrderEnum.swift
//  BoomMenuButton
//
//  Created by viktorhuang on 2017/4/27.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

/// The order of boom-buttons when booming or rebooming.
///
/// - inOrder: In-order.
/// - reverse: Reverse.
/// - random: Random.
public enum OrderEnum {
    
    case inOrder
    case reverse
    case random
    
    static var count: Int {
        return OrderEnum.random.hashValue + 1
    }
}
