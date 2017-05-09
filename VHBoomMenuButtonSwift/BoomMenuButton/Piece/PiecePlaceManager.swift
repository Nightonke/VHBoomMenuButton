//
//  PiecePlaceManager.swift
//  BoomMenuButton
//
//  Created by Nightonke on 2017/4/27.
//  Copyright © 2017 Nightonke. All rights reserved.
//

class PiecePlaceManager: NSObject {
    
    static func dotPositions(boomMenuButton bmb: BoomMenuButton) -> [CGRect] {
        
        let parentFrame: CGRect = bmb.bounds
        
        let hm: CGFloat = bmb.pieceHorizontalMargin
        let hm_0_5: CGFloat = hm / 2
        let hm_1_5: CGFloat = hm * 1.5
        let vm: CGFloat = bmb.pieceVerticalMargin
        let vm_0_5: CGFloat = vm / 2
        let vm_1_5: CGFloat = vm * 1.5
        let im: CGFloat = bmb.pieceInclinedMargin
        let r: CGFloat = bmb.dotRadius
        let r_2_0: CGFloat = 2 * r
        let r_3_0: CGFloat = 3 * r
        
        var positions: [CGRect] = [CGRect]()
        var positionOrigins: [CGPoint] = [CGPoint]()
        
        var a: CGFloat, b: CGFloat, c: CGFloat, e: CGFloat
        b = hm_0_5 + r
        c = b / (sqrt(3) / 2)
        a = c / 2
        e = c - a
        switch bmb.piecePlaceEnum {
        case .dot_4_2, .dot_5_4, .dot_8_5, .dot_9_3:
            a = (r_2_0 + im) / sqrt(2)
        case .dot_8_2:
            b = vm_0_5 + r
            c = b / (sqrt(3) / 2)
            a = c / 2
            e = c - a
        default:
            break
        }
        let a_2_0: CGFloat = 2 * a
        let b_2_0: CGFloat = 2 * b
        let b_3_0: CGFloat = 3 * b
        let c_2_0: CGFloat = 2 * c
        
        switch bmb.piecePlaceEnum {
        case .dot_1:
            positionOrigins.append(CGPoint.init(x: 0, y: 0))
        case .dot_2_1:
            positionOrigins.append(CGPoint.init(x: -hm_0_5 - r, y: 0))
            positionOrigins.append(CGPoint.init(x: +hm_0_5 + r, y: 0))
        case .dot_2_2:
            positionOrigins.append(CGPoint.init(x: 0, y: -vm_0_5 - r))
            positionOrigins.append(CGPoint.init(x: 0, y: +vm_0_5 + r))
        case .dot_3_1:
            positionOrigins.append(CGPoint.init(x: -hm - r_2_0, y: 0))
            positionOrigins.append(CGPoint.init(x: 0, y: 0))
            positionOrigins.append(CGPoint.init(x: +hm + r_2_0, y: 0))
        case .dot_3_2:
            positionOrigins.append(CGPoint.init(x: 0, y: -vm - r_2_0))
            positionOrigins.append(CGPoint.init(x: 0, y: 0))
            positionOrigins.append(CGPoint.init(x: 0, y: +vm + r_2_0))
        case .dot_3_3:
            positionOrigins.append(CGPoint.init(x: -b, y: -a))
            positionOrigins.append(CGPoint.init(x: +b, y: -a))
            positionOrigins.append(CGPoint.init(x: 0, y: c))
        case .dot_3_4:
            positionOrigins.append(CGPoint.init(x: 0, y: -c))
            positionOrigins.append(CGPoint.init(x: -b, y: a))
            positionOrigins.append(CGPoint.init(x: +b, y: a))
        case .dot_4_1:
            positionOrigins.append(CGPoint.init(x: -hm_0_5 - r, y: -vm_0_5 - r))
            positionOrigins.append(CGPoint.init(x: +hm_0_5 + r, y: -vm_0_5 - r))
            positionOrigins.append(CGPoint.init(x: -hm_0_5 - r, y: +vm_0_5 + r))
            positionOrigins.append(CGPoint.init(x: +hm_0_5 + r, y: +vm_0_5 + r))
        case .dot_4_2:
            positionOrigins.append(CGPoint.init(x: 0, y: -a))
            positionOrigins.append(CGPoint.init(x: +a, y: 0))
            positionOrigins.append(CGPoint.init(x: 0, y: +a))
            positionOrigins.append(CGPoint.init(x: -a, y: 0))
        case .dot_5_1:
            positionOrigins.append(CGPoint.init(x: -b_2_0, y: -a))
            positionOrigins.append(CGPoint.init(x: 0, y: -a))
            positionOrigins.append(CGPoint.init(x: +b_2_0, y: -a))
            positionOrigins.append(CGPoint.init(x: -hm_0_5 - r, y: c))
            positionOrigins.append(CGPoint.init(x: +hm_0_5 + r, y: c))
        case .dot_5_2:
            positionOrigins.append(CGPoint.init(x: -hm_0_5 - r, y: -c))
            positionOrigins.append(CGPoint.init(x: +hm_0_5 + r, y: -c))
            positionOrigins.append(CGPoint.init(x: -b_2_0, y: a))
            positionOrigins.append(CGPoint.init(x: 0, y: a))
            positionOrigins.append(CGPoint.init(x: +b_2_0, y: a))
        case .dot_5_3:
            positionOrigins.append(CGPoint.init(x: 0, y: -vm - r_2_0))
            positionOrigins.append(CGPoint.init(x: -hm - r_2_0, y: 0))
            positionOrigins.append(CGPoint.init(x: 0, y: 0))
            positionOrigins.append(CGPoint.init(x: +hm + r_2_0, y: 0))
            positionOrigins.append(CGPoint.init(x: 0, y: +vm + r_2_0))
        case .dot_5_4:
            positionOrigins.append(CGPoint.init(x: -a, y: -a))
            positionOrigins.append(CGPoint.init(x: +a, y: -a))
            positionOrigins.append(CGPoint.init(x: 0, y: 0))
            positionOrigins.append(CGPoint.init(x: -a, y: +a))
            positionOrigins.append(CGPoint.init(x: +a, y: +a))
        case .dot_6_1:
            positionOrigins.append(CGPoint.init(x: -hm - r_2_0, y: -vm_0_5 - r))
            positionOrigins.append(CGPoint.init(x: 0, y: -vm_0_5 - r))
            positionOrigins.append(CGPoint.init(x: +hm + r_2_0, y: -vm_0_5 - r))
            positionOrigins.append(CGPoint.init(x: -hm - r_2_0, y: +vm_0_5 + r))
            positionOrigins.append(CGPoint.init(x: 0, y: +vm_0_5 + r))
            positionOrigins.append(CGPoint.init(x: +hm + r_2_0, y: +vm_0_5 + r))
        case .dot_6_2:
            positionOrigins.append(CGPoint.init(x: -hm_0_5 - r, y: -vm - r_2_0))
            positionOrigins.append(CGPoint.init(x: +hm_0_5 + r, y: -vm - r_2_0))
            positionOrigins.append(CGPoint.init(x: -hm_0_5 - r, y: 0))
            positionOrigins.append(CGPoint.init(x: +hm_0_5 + r, y: 0))
            positionOrigins.append(CGPoint.init(x: -hm_0_5 - r, y: +vm + r_2_0))
            positionOrigins.append(CGPoint.init(x: +hm_0_5 + r, y: +vm + r_2_0))
        case .dot_6_3:
            positionOrigins.append(CGPoint.init(x: -b, y: -a - c))
            positionOrigins.append(CGPoint.init(x: +b, y: -a - c))
            positionOrigins.append(CGPoint.init(x: -b_2_0, y: 0))
            positionOrigins.append(CGPoint.init(x: +b_2_0, y: 0))
            positionOrigins.append(CGPoint.init(x: -b, y: +a + c))
            positionOrigins.append(CGPoint.init(x: +b, y: +a + c))
        case .dot_6_4:
            positionOrigins.append(CGPoint.init(x: 0, y: -b_2_0))
            positionOrigins.append(CGPoint.init(x: -a - c, y: -b))
            positionOrigins.append(CGPoint.init(x: +a + c, y: -b))
            positionOrigins.append(CGPoint.init(x: -a - c, y: +b))
            positionOrigins.append(CGPoint.init(x: +a + c, y: +b))
            positionOrigins.append(CGPoint.init(x: 0, y: +b_2_0))
        case .dot_6_5:
            positionOrigins.append(CGPoint.init(x: -b_2_0, y: -a - c + e))
            positionOrigins.append(CGPoint.init(x: 0, y: -a - c + e))
            positionOrigins.append(CGPoint.init(x: +b_2_0, y: -a - c + e))
            positionOrigins.append(CGPoint.init(x: -hm_0_5 - r, y: e))
            positionOrigins.append(CGPoint.init(x: +hm_0_5 + r, y: e))
            positionOrigins.append(CGPoint.init(x: 0, y: +a + c + e))
        case .dot_6_6:
            positionOrigins.append(CGPoint.init(x: 0, y: -a - c - e))
            positionOrigins.append(CGPoint.init(x: -hm_0_5 - r, y: -e))
            positionOrigins.append(CGPoint.init(x: +hm_0_5 + r, y: -e))
            positionOrigins.append(CGPoint.init(x: -b_2_0, y: a + c - e))
            positionOrigins.append(CGPoint.init(x: 0, y: +a + c - e))
            positionOrigins.append(CGPoint.init(x: +b_2_0, y: a + c - e))
        case .dot_7_1:
            positionOrigins.append(CGPoint.init(x: -hm - r_2_0, y: -vm - r_2_0))
            positionOrigins.append(CGPoint.init(x: 0, y: -vm - r_2_0))
            positionOrigins.append(CGPoint.init(x: +hm + r_2_0, y: -vm - r_2_0))
            positionOrigins.append(CGPoint.init(x: -hm - r_2_0, y: 0))
            positionOrigins.append(CGPoint.init(x: 0, y: 0))
            positionOrigins.append(CGPoint.init(x: +hm + r_2_0, y: 0))
            positionOrigins.append(CGPoint.init(x: 0, y: +vm + r_2_0))
        case .dot_7_2:
            positionOrigins.append(CGPoint.init(x: 0, y: -vm - r_2_0))
            positionOrigins.append(CGPoint.init(x: -hm - r_2_0, y: 0))
            positionOrigins.append(CGPoint.init(x: 0, y: 0))
            positionOrigins.append(CGPoint.init(x: +hm + r_2_0, y: 0))
            positionOrigins.append(CGPoint.init(x: -hm - r_2_0, y: +vm + r_2_0))
            positionOrigins.append(CGPoint.init(x: 0, y: +vm + r_2_0))
            positionOrigins.append(CGPoint.init(x: +hm + r_2_0, y: +vm + r_2_0))
        case .dot_7_3:
            positionOrigins.append(CGPoint.init(x: -b, y: -a - c))
            positionOrigins.append(CGPoint.init(x: +b, y: -a - c))
            positionOrigins.append(CGPoint.init(x: -b_2_0, y: 0))
            positionOrigins.append(CGPoint.init(x: 0, y: 0))
            positionOrigins.append(CGPoint.init(x: +b_2_0, y: 0))
            positionOrigins.append(CGPoint.init(x: -b, y: a + c))
            positionOrigins.append(CGPoint.init(x: +b, y: a + c))
        case .dot_7_4:
            positionOrigins.append(CGPoint.init(x: 0, y: -b_2_0))
            positionOrigins.append(CGPoint.init(x: -a - c, y: -b))
            positionOrigins.append(CGPoint.init(x: +a + c, y: -b))
            positionOrigins.append(CGPoint.init(x: 0, y: 0))
            positionOrigins.append(CGPoint.init(x: -a - c, y: +b))
            positionOrigins.append(CGPoint.init(x: +a + c, y: +b))
            positionOrigins.append(CGPoint.init(x: 0, y: +b_2_0))
        case .dot_7_5:
            positionOrigins.append(CGPoint.init(x: -b_3_0, y: -a))
            positionOrigins.append(CGPoint.init(x: -b, y: -a))
            positionOrigins.append(CGPoint.init(x: +b, y: -a))
            positionOrigins.append(CGPoint.init(x: +b_3_0, y: -a))
            positionOrigins.append(CGPoint.init(x: -b_2_0, y: +c))
            positionOrigins.append(CGPoint.init(x: 0, y: c))
            positionOrigins.append(CGPoint.init(x: +b_2_0, y: +c))
        case .dot_7_6:
            positionOrigins.append(CGPoint.init(x: -b_2_0, y: -c))
            positionOrigins.append(CGPoint.init(x: 0, y: -c))
            positionOrigins.append(CGPoint.init(x: +b_2_0, y: -c))
            positionOrigins.append(CGPoint.init(x: -b_3_0, y: +a))
            positionOrigins.append(CGPoint.init(x: -b, y: a))
            positionOrigins.append(CGPoint.init(x: +b, y: a))
            positionOrigins.append(CGPoint.init(x: +b_3_0, y: +a))
        case .dot_8_1:
            positionOrigins.append(CGPoint.init(x: -b_2_0, y: -a - c))
            positionOrigins.append(CGPoint.init(x: 0, y: -a - c))
            positionOrigins.append(CGPoint.init(x: +b_2_0, y: -a - c))
            positionOrigins.append(CGPoint.init(x: -hm_0_5 - r, y: 0))
            positionOrigins.append(CGPoint.init(x: +hm_0_5 + r, y: 0))
            positionOrigins.append(CGPoint.init(x: -b_2_0, y: +a + c))
            positionOrigins.append(CGPoint.init(x: 0, y: +a + c))
            positionOrigins.append(CGPoint.init(x: +b_2_0, y: +a + c))
        case .dot_8_2:
            positionOrigins.append(CGPoint.init(x: -a - c, y: -b_2_0))
            positionOrigins.append(CGPoint.init(x: +a + c, y: -b_2_0))
            positionOrigins.append(CGPoint.init(x: 0, y: -vm_0_5 - r))
            positionOrigins.append(CGPoint.init(x: -a - c, y: 0))
            positionOrigins.append(CGPoint.init(x: +a + c, y: 0))
            positionOrigins.append(CGPoint.init(x: 0, y: +vm_0_5 + r))
            positionOrigins.append(CGPoint.init(x: -a - c, y: +b_2_0))
            positionOrigins.append(CGPoint.init(x: +a + c, y: +b_2_0))
        case .dot_8_3:
            positionOrigins.append(CGPoint.init(x: -hm - r_2_0, y: -vm - r_2_0))
            positionOrigins.append(CGPoint.init(x: 0, y: -vm - r_2_0))
            positionOrigins.append(CGPoint.init(x: +hm + r_2_0, y: -vm - r_2_0))
            positionOrigins.append(CGPoint.init(x: -hm - r_2_0, y: 0))
            positionOrigins.append(CGPoint.init(x: +hm + r_2_0, y: 0))
            positionOrigins.append(CGPoint.init(x: -hm - r_2_0, y: +vm + r_2_0))
            positionOrigins.append(CGPoint.init(x: 0, y: +vm + r_2_0))
            positionOrigins.append(CGPoint.init(x: +hm + r_2_0, y: +vm + r_2_0))
        case .dot_8_4:
            positionOrigins.append(CGPoint.init(x: 0, y: -a_2_0 - c_2_0))
            positionOrigins.append(CGPoint.init(x: -hm_0_5 - r, y: -a - c))
            positionOrigins.append(CGPoint.init(x: +hm_0_5 + r, y: -a - c))
            positionOrigins.append(CGPoint.init(x: -b_2_0, y: 0))
            positionOrigins.append(CGPoint.init(x: +b_2_0, y: 0))
            positionOrigins.append(CGPoint.init(x: -hm_0_5 - r, y: +a + c))
            positionOrigins.append(CGPoint.init(x: +hm_0_5 + r, y: +a + c))
            positionOrigins.append(CGPoint.init(x: 0, y: +a_2_0 + c_2_0))
        case .dot_8_5:
            positionOrigins.append(CGPoint.init(x: 0, y: -a_2_0))
            positionOrigins.append(CGPoint.init(x: -a, y: -a))
            positionOrigins.append(CGPoint.init(x: +a, y: -a))
            positionOrigins.append(CGPoint.init(x: -a_2_0, y: 0))
            positionOrigins.append(CGPoint.init(x: +a_2_0, y: 0))
            positionOrigins.append(CGPoint.init(x: -a, y: +a))
            positionOrigins.append(CGPoint.init(x: +a, y: +a))
            positionOrigins.append(CGPoint.init(x: 0, y: +a_2_0))
        case .dot_8_6:
            positionOrigins.append(CGPoint.init(x: -hm_1_5 - r_3_0, y: -vm_0_5 - r))
            positionOrigins.append(CGPoint.init(x: -hm_0_5 - r, y: -vm_0_5 - r))
            positionOrigins.append(CGPoint.init(x: +hm_0_5 + r, y: -vm_0_5 - r))
            positionOrigins.append(CGPoint.init(x: +hm_1_5 + r_3_0, y: -vm_0_5 - r))
            positionOrigins.append(CGPoint.init(x: -hm_1_5 - r_3_0, y: +vm_0_5 + r))
            positionOrigins.append(CGPoint.init(x: -hm_0_5 - r, y: +vm_0_5 + r))
            positionOrigins.append(CGPoint.init(x: +hm_0_5 + r, y: +vm_0_5 + r))
            positionOrigins.append(CGPoint.init(x: +hm_1_5 + r_3_0, y: +vm_0_5 + r))
        case .dot_8_7:
            positionOrigins.append(CGPoint.init(x: -hm_0_5 - r, y: -vm_1_5 - r_3_0))
            positionOrigins.append(CGPoint.init(x: +hm_0_5 + r, y: -vm_1_5 - r_3_0))
            positionOrigins.append(CGPoint.init(x: -hm_0_5 - r, y: -vm_0_5 - r))
            positionOrigins.append(CGPoint.init(x: +hm_0_5 + r, y: -vm_0_5 - r))
            positionOrigins.append(CGPoint.init(x: -hm_0_5 - r, y: +vm_0_5 + r))
            positionOrigins.append(CGPoint.init(x: +hm_0_5 + r, y: +vm_0_5 + r))
            positionOrigins.append(CGPoint.init(x: -hm_0_5 - r, y: +vm_1_5 + r_3_0))
            positionOrigins.append(CGPoint.init(x: +hm_0_5 + r, y: +vm_1_5 + r_3_0))
        case .dot_9_1:
            positionOrigins.append(CGPoint.init(x: -hm - r_2_0, y: -vm - r_2_0))
            positionOrigins.append(CGPoint.init(x: 0, y: -vm - r_2_0))
            positionOrigins.append(CGPoint.init(x: +hm + r_2_0, y: -vm - r_2_0))
            positionOrigins.append(CGPoint.init(x: -hm - r_2_0, y: 0))
            positionOrigins.append(CGPoint.init(x: 0, y: 0))
            positionOrigins.append(CGPoint.init(x: +hm + r_2_0, y: 0))
            positionOrigins.append(CGPoint.init(x: -hm - r_2_0, y: +vm + r_2_0))
            positionOrigins.append(CGPoint.init(x: 0, y: +vm + r_2_0))
            positionOrigins.append(CGPoint.init(x: +hm + r_2_0, y: +vm + r_2_0))
        case .dot_9_2:
            positionOrigins.append(CGPoint.init(x: 0, y: -a_2_0 - c_2_0))
            positionOrigins.append(CGPoint.init(x: -hm_0_5 - r, y: -a - c))
            positionOrigins.append(CGPoint.init(x: +hm_0_5 + r, y: -a - c))
            positionOrigins.append(CGPoint.init(x: -b_2_0, y: 0))
            positionOrigins.append(CGPoint.init(x: 0, y: 0))
            positionOrigins.append(CGPoint.init(x: +b_2_0, y: 0))
            positionOrigins.append(CGPoint.init(x: -hm_0_5 - r, y: +a + c))
            positionOrigins.append(CGPoint.init(x: +hm_0_5 + r, y: +a + c))
            positionOrigins.append(CGPoint.init(x: 0, y: +a_2_0 + c_2_0))
        case .dot_9_3:
            positionOrigins.append(CGPoint.init(x: 0, y: -a_2_0))
            positionOrigins.append(CGPoint.init(x: +a, y: -a))
            positionOrigins.append(CGPoint.init(x: +a_2_0, y: 0))
            positionOrigins.append(CGPoint.init(x: +a, y: +a))
            positionOrigins.append(CGPoint.init(x: 0, y: 0))
            positionOrigins.append(CGPoint.init(x: 0, y: +a_2_0))
            positionOrigins.append(CGPoint.init(x: -a, y: +a))
            positionOrigins.append(CGPoint.init(x: -a_2_0, y: 0))
            positionOrigins.append(CGPoint.init(x: -a, y: -a))
        case .custom:
            positionOrigins += bmb.customPiecePlacePositions
        default:
            assert(false, "Piece place enum not found!")
        }
        
        for point in positionOrigins {
            positions.append(CGRect.init(x: point.x + parentFrame.size.width / 2 - r,
                                         y: point.y + parentFrame.size.height / 2 - r,
                                         width: r_2_0,
                                         height: r_2_0))
        }
        
        return positions
    }
    
    static func hamPositions(boomMenuButton bmb: BoomMenuButton) -> [CGRect] {
        
        let parentFrame: CGRect = bmb.bounds
        
        var positions: [CGRect] = [CGRect]()
        var positionOrigins: [CGPoint] = [CGPoint]()
        
        let pn: Int = bmb.piecePlaceEnum.pieceNumber()
        let pn_0_5: Int = pn / 2
        
        let w: CGFloat = bmb.hamWidth
        let w_0_5: CGFloat = w / 2
        let h: CGFloat = bmb.hamHeight
        let h_0_5: CGFloat = h / 2
        
        let vm: CGFloat = bmb.pieceVerticalMargin
        let vm_0_5: CGFloat = vm / 2
        
        if bmb.piecePlaceEnum != .custom {
            if pn % 2 == 0 {
                for i in (0..<pn_0_5).reversed() {
                    positionOrigins.append(CGPoint.init(x: 0, y: -h_0_5 - vm_0_5 - CGFloat(i) * (h + vm)))
                }
                for i in 0..<pn_0_5 {
                    positionOrigins.append(CGPoint.init(x: 0, y: +h_0_5 + vm_0_5 + CGFloat(i) * (h + vm)))
                }
            } else {
                for i in (0..<pn_0_5).reversed() {
                    positionOrigins.append(CGPoint.init(x: 0, y: -h - vm - CGFloat(i) * (h + vm)))
                }
                positionOrigins.append(CGPoint.init(x: 0, y: 0))
                for i in 0..<pn_0_5 {
                    positionOrigins.append(CGPoint.init(x: 0, y: +h + vm + CGFloat(i) * (h + vm)))
                }
            }
        } else {
            positionOrigins += bmb.customPiecePlacePositions
        }
        
        for point in positionOrigins {
            positions.append(CGRect.init(x: point.x + parentFrame.size.width / 2 - w_0_5,
                                         y: point.y + parentFrame.size.height / 2 - h_0_5,
                                         width: w,
                                         height: h))
        }
        
        return positions
    }
    
    static func shareDotPositions(dotNumber n: Int, boomMenuButton bmb: BoomMenuButton) -> [CGRect] {
        
        let parentFrame: CGRect = bmb.bounds
        
        var positions: [CGRect] = [CGRect]()
        
        let r: CGFloat = bmb.dotRadius
        let h: CGFloat = bmb.shareLineLength * CGFloat(sqrt(3) / 3)
        let h_0_5: CGFloat = h / 2
        let l_0_5: CGFloat = bmb.shareLineLength / 2
        for i in 0..<n {
            switch i % 3 {
            case 0:
                positions.append(CGRect.init(x: h_0_5, y: -l_0_5, width: r + r, height: r + r))
            case 1:
                positions.append(CGRect.init(x: -h, y: 0, width: r + r, height: r + r))
            case 2:
                positions.append(CGRect.init(x: h_0_5, y: +l_0_5, width: r + r, height: r + r))
            default:
                break
            }
        }
        positions.sort { (r1, r2) -> Bool in
            return r1.origin.y <= r2.origin.y
        }
        for i in positions.indices {
            positions[i].origin.x += parentFrame.size.width / 2 - r
            positions[i].origin.y += parentFrame.size.height / 2 - r
        }
        return positions
    }
    
}
