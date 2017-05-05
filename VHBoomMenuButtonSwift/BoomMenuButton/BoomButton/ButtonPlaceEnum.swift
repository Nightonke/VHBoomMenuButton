//
//  ButtonPlaceEnum.swift
//  BoomMenuButton
//
//  Created by viktorhuang on 2017/4/28.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

public enum ButtonPlaceEnum: Int {
    
    case sc_1
    case sc_2_1
    case sc_2_2
    case sc_3_1
    case sc_3_2
    case sc_3_3
    case sc_3_4
    case sc_4_1
    case sc_4_2
    case sc_5_1
    case sc_5_2
    case sc_5_3
    case sc_5_4
    case sc_6_1
    case sc_6_2
    case sc_6_3
    case sc_6_4
    case sc_6_5
    case sc_6_6
    case sc_7_1
    case sc_7_2
    case sc_7_3
    case sc_7_4
    case sc_7_5
    case sc_7_6
    case sc_8_1
    case sc_8_2
    case sc_8_3
    case sc_8_4
    case sc_8_5
    case sc_8_6
    case sc_8_7
    case sc_9_1
    case sc_9_2
    case sc_9_3
    
    case ham_1
    case ham_2
    case ham_3
    case ham_4
    case ham_5
    case ham_6
    
    case horizontal
    case vertical
    
    case unknown
    
    public static var count: Int {
        return ButtonPlaceEnum.vertical.hashValue + 1
    }
    
    public func buttonNumber() -> Int {
        switch self {
        case .sc_1, .ham_1:
            return 1
        case .sc_2_1, .sc_2_2, .ham_2:
            return 2
        case .sc_3_1, .sc_3_2, .sc_3_3, .sc_3_4, .ham_3:
            return 3
        case .sc_4_1, .sc_4_2, .ham_4:
            return 4
        case .sc_5_1, .sc_5_2, .sc_5_3, .sc_5_4, .ham_5:
            return 5
        case .sc_6_1, .sc_6_2, .sc_6_3, .sc_6_4, .sc_6_5, .sc_6_6, .ham_6:
            return 6
        case .sc_7_1, .sc_7_2, .sc_7_3, .sc_7_4, .sc_7_5, .sc_7_6:
            return 7
        case .sc_8_1, .sc_8_2, .sc_8_3, .sc_8_4, .sc_8_5, .sc_8_6, .sc_8_7:
            return 8
        case .sc_9_1, .sc_9_2, .sc_9_3:
            return 9
        case .horizontal, .vertical:
            return -1
        case .unknown:
            return 0
        }
    }
    
    public func minButtonNumber() -> Int {
        switch self {
        case .horizontal, .vertical:
            return 1
        case .unknown:
            return 0
        default:
            return -1
        }
    }
    
    public func maxButtonNumber() -> Int {
        switch self {
        case .horizontal, .vertical:
            return 9
        case .unknown:
            return 0
        default:
            return -1
        }
    }
    
}
