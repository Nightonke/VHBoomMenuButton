//
//  PiecePlaceEnum.swift
//  BoomMenuButton
//
//  Created by Nightonke on 2017/4/27.
//  Copyright © 2017 Nightonke. All rights reserved.
//

///  VHPiecePlaceEnum tells BMB how the pieces should be placed.

///  All the piece-place-enums are in the following form:

///  1. VHPiecePlaceDOT_M_A: M means the number of pieces in a dot or a small square shape. A means different type of placing.

///  2. VHPiecePlaceHAM_M: M means the number of pieces in a ham shape.

///  3. VHPiecePlaceShare: Share style.

///  4. VHPiecePlaceCustom: Allows to customize the positions of pieces.
///
///  Check https://github.com/Nightonke/VHBoomMenuButton/wiki for more information.
public enum PiecePlaceEnum: Int {
    
    // Dots
    case dot_1
    case dot_2_1
    case dot_2_2
    case dot_3_1
    case dot_3_2
    case dot_3_3
    case dot_3_4
    case dot_4_1
    case dot_4_2
    case dot_5_1
    case dot_5_2
    case dot_5_3
    case dot_5_4
    case dot_6_1
    case dot_6_2
    case dot_6_3
    case dot_6_4
    case dot_6_5
    case dot_6_6
    case dot_7_1
    case dot_7_2
    case dot_7_3
    case dot_7_4
    case dot_7_5
    case dot_7_6
    case dot_8_1
    case dot_8_2
    case dot_8_3
    case dot_8_4
    case dot_8_5
    case dot_8_6
    case dot_8_7
    case dot_9_1
    case dot_9_2
    case dot_9_3
    
    // Hams
    case ham_1
    case ham_2
    case ham_3
    case ham_4
    case ham_5
    case ham_6
    
    case share
    
    case custom
    
    case unknown
    
    public static var count: Int {
        return PiecePlaceEnum.custom.hashValue + 1
    }
    
    public func pieceNumber() -> Int {
        switch self {
        case .dot_1, .ham_1:
            return 1
        case .dot_2_1, .dot_2_2, .ham_2:
            return 2
        case .dot_3_1, .dot_3_2, .dot_3_3, .dot_3_4, .ham_3:
            return 3
        case .dot_4_1, .dot_4_2, .ham_4:
            return 4
        case .dot_5_1, .dot_5_2, .dot_5_3, .dot_5_4, .ham_5:
            return 5
        case .dot_6_1, .dot_6_2, .dot_6_3, .dot_6_4, .dot_6_5, .dot_6_6, .ham_6:
            return 6
        case .dot_7_1, .dot_7_2, .dot_7_3, .dot_7_4, .dot_7_5, .dot_7_6:
            return 7
        case .dot_8_1, .dot_8_2, .dot_8_3, .dot_8_4, .dot_8_5, .dot_8_6, .dot_8_7:
            return 8
        case .dot_9_1, .dot_9_2, .dot_9_3:
            return 9
        case .share, .custom:
            return -1
        case .unknown:
            return 0
        }
    }
    
    public func minPieceNumber() -> Int {
        switch self {
        case .share:
            return 3
        case .custom:
            return 1
        case .unknown:
            return 0
        default:
            return -1
        }
    }
    
    public func maxPieceNumber() -> Int {
        switch self {
        case .share, .custom:
            return Int.max
        case .unknown:
            return 0
        default:
            return -1
        }
    }
    
}
