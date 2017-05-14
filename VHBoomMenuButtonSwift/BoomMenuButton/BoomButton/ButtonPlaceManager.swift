//
//  ButtonPlaceManager.swift
//  BoomMenuButton
//
//  Created by Nightonke on 2017/4/28.
//  Copyright © 2017 Nightonke. All rights reserved.
//

class ButtonPlaceManager: NSObject {
    
    static func positions(parentFrame: CGRect,
                          buttonWidth w: CGFloat,
                          buttonHeight h: CGFloat,
                          buttonNumber: Int,
                          boomMenuButton bmb: BoomMenuButton) -> [CGPoint] {
        var positions = [CGPoint]()
        
        let halfButtonNumber: Int = buttonNumber / 2
        
        let hm: CGFloat = bmb.buttonHorizontalMargin
        let hm_0_5: CGFloat = hm / 2
        let hm_1_5: CGFloat = hm * 1.5
        let hm_2_0: CGFloat = hm * 2
        
        let vm: CGFloat = bmb.buttonVerticalMargin
        let vm_0_5: CGFloat = vm / 2
        let vm_1_5: CGFloat = vm * 1.5
        let vm_2_0: CGFloat = vm * 2
        
        let w_0_5: CGFloat = w / 2
        let w_1_5: CGFloat = w * 1.5
        let w_2_0: CGFloat = w * 2
        
        let h_0_5: CGFloat = h / 2
        let h_1_5: CGFloat = h * 1.5
        let h_2_0: CGFloat = h * 2
        
        switch bmb.buttonPlaceEnum {
        case .horizontal:
            if buttonNumber % 2 == 0 {
                for i in (0..<halfButtonNumber).reversed() {
                    positions.append(CGPoint.init(x: -w_0_5 - hm_0_5 - CGFloat(i) * (w + hm), y: 0))
                }
                for i in 0..<halfButtonNumber {
                    positions.append(CGPoint.init(x: +w_0_5 + hm_0_5 + CGFloat(i) * (w + hm), y: 0))
                }
            } else {
                for i in (0..<halfButtonNumber).reversed() {
                    positions.append(CGPoint.init(x: -w - hm - CGFloat(i) * (w + hm), y: 0))
                }
                positions.append(CGPoint.init(x: 0, y: 0))
                for i in 0..<halfButtonNumber {
                    positions.append(CGPoint.init(x: +w + hm + CGFloat(i) * (w + hm), y: 0))
                }
            }
        case .vertical, .ham_1, .ham_2, .ham_3, .ham_3, .ham_4, .ham_5, .ham_6:
            if buttonNumber % 2 == 0 {
                for i in (0..<halfButtonNumber).reversed() {
                    positions.append(CGPoint.init(x: 0, y: -h_0_5 - vm_0_5 - CGFloat(i) * (h + vm)))
                }
                for i in 0..<halfButtonNumber {
                    positions.append(CGPoint.init(x: 0, y: +h_0_5 + vm_0_5 + CGFloat(i) * (h + vm)))
                }
            } else {
                for i in (0..<halfButtonNumber).reversed() {
                    positions.append(CGPoint.init(x: 0, y: -h - vm - CGFloat(i) * (h + vm)))
                }
                positions.append(CGPoint.init(x: 0, y: 0))
                for i in 0..<halfButtonNumber {
                    positions.append(CGPoint.init(x: 0, y: +h + vm + CGFloat(i) * (h + vm)))
                }
            }
        case .sc_1:
            positions.append(CGPoint.init(x: 0, y: 0))
        case .sc_2_1:
            positions.append(CGPoint.init(x: -hm_0_5 - w_0_5, y: 0))
            positions.append(CGPoint.init(x: +hm_0_5 + w_0_5, y: 0))
        case .sc_2_2:
            positions.append(CGPoint.init(x: 0, y: -vm_0_5 - h_0_5))
            positions.append(CGPoint.init(x: 0, y: +vm_0_5 + h_0_5))
        case .sc_3_1:
            positions.append(CGPoint.init(x: -hm - w, y: 0))
            positions.append(CGPoint.init(x: 0, y: 0))
            positions.append(CGPoint.init(x: +hm + w, y: 0))
        case .sc_3_2:
            positions.append(CGPoint.init(x: 0, y: -vm - h))
            positions.append(CGPoint.init(x: 0, y: 0))
            positions.append(CGPoint.init(x: 0, y: +vm + h))
        case .sc_3_3:
            positions.append(CGPoint.init(x: -hm_0_5 - w_0_5, y: -vm_0_5 - h_0_5))
            positions.append(CGPoint.init(x: +hm_0_5 + w_0_5, y: -vm_0_5 - h_0_5))
            positions.append(CGPoint.init(x: 0, y: vm_0_5 + h_0_5))
        case .sc_3_4:
            positions.append(CGPoint.init(x: 0, y: -vm_0_5 - h_0_5))
            positions.append(CGPoint.init(x: -hm_0_5 - w_0_5, y: +vm_0_5 + h_0_5))
            positions.append(CGPoint.init(x: +hm_0_5 + w_0_5, y: +vm_0_5 + h_0_5))
        case .sc_4_1:
            positions.append(CGPoint.init(x: -hm_0_5 - w_0_5, y: -vm_0_5 - h_0_5))
            positions.append(CGPoint.init(x: +hm_0_5 + w_0_5, y: -vm_0_5 - h_0_5))
            positions.append(CGPoint.init(x: -hm_0_5 - w_0_5, y: +vm_0_5 + h_0_5))
            positions.append(CGPoint.init(x: +hm_0_5 + w_0_5, y: +vm_0_5 + h_0_5))
        case .sc_4_2:
            positions.append(CGPoint.init(x: 0, y: -vm_0_5 - h_0_5))
            positions.append(CGPoint.init(x: -hm - w, y: 0))
            positions.append(CGPoint.init(x: +hm + w, y: 0))
            positions.append(CGPoint.init(x: 0, y: +vm_0_5 + h_0_5))
        case .sc_5_1:
            positions.append(CGPoint.init(x: -hm - w, y: -vm_0_5 - h_0_5))
            positions.append(CGPoint.init(x: 0, y: -vm_0_5 - h_0_5))
            positions.append(CGPoint.init(x: +hm + w, y: -vm_0_5 - h_0_5))
            positions.append(CGPoint.init(x: -hm_0_5 - w_0_5, y: +vm_0_5 + h_0_5))
            positions.append(CGPoint.init(x: +hm_0_5 + w_0_5, y: +vm_0_5 + h_0_5))
        case .sc_5_2:
            positions.append(CGPoint.init(x: -hm_0_5 - w_0_5, y: -vm_0_5 - h_0_5))
            positions.append(CGPoint.init(x: +hm_0_5 + w_0_5, y: -vm_0_5 - h_0_5))
            positions.append(CGPoint.init(x: -hm - w, y: +vm_0_5 + h_0_5))
            positions.append(CGPoint.init(x: 0, y: +vm_0_5 + h_0_5))
            positions.append(CGPoint.init(x: +hm + w, y: +vm_0_5 + h_0_5))
        case .sc_5_3:
            positions.append(CGPoint.init(x: 0, y: -vm - h))
            positions.append(CGPoint.init(x: -hm - w, y: 0))
            positions.append(CGPoint.init(x: 0, y: 0))
            positions.append(CGPoint.init(x: +hm + w, y: 0))
            positions.append(CGPoint.init(x: 0, y: +vm + h))
        case .sc_5_4:
            positions.append(CGPoint.init(x: -hm - w, y: -vm_0_5 - h_0_5))
            positions.append(CGPoint.init(x: +hm + w, y: -vm_0_5 - h_0_5))
            positions.append(CGPoint.init(x: 0, y: 0))
            positions.append(CGPoint.init(x: -hm - w, y: +vm_0_5 + h_0_5))
            positions.append(CGPoint.init(x: +hm + w, y: +vm_0_5 + h_0_5))
        case .sc_6_1:
            positions.append(CGPoint.init(x: -hm - w, y: -vm_0_5 - h_0_5))
            positions.append(CGPoint.init(x: 0, y: -vm_0_5 - h_0_5))
            positions.append(CGPoint.init(x: +hm + w, y: -vm_0_5 - h_0_5))
            positions.append(CGPoint.init(x: -hm - w, y: +vm_0_5 + h_0_5))
            positions.append(CGPoint.init(x: 0, y: +vm_0_5 + h_0_5))
            positions.append(CGPoint.init(x: +hm + w, y: +vm_0_5 + h_0_5))
        case .sc_6_2:
            positions.append(CGPoint.init(x: -hm_0_5 - w_0_5, y: -vm - h))
            positions.append(CGPoint.init(x: +hm_0_5 + w_0_5, y: -vm - h))
            positions.append(CGPoint.init(x: -hm_0_5 - w_0_5, y: 0))
            positions.append(CGPoint.init(x: +hm_0_5 + w_0_5, y: 0))
            positions.append(CGPoint.init(x: -hm_0_5 - w_0_5, y: +vm + h))
            positions.append(CGPoint.init(x: +hm_0_5 + w_0_5, y: +vm + h))
        case .sc_6_3:
            positions.append(CGPoint.init(x: -hm_0_5 - w_0_5, y: -vm - h))
            positions.append(CGPoint.init(x: +hm_0_5 + w_0_5, y: -vm - h))
            positions.append(CGPoint.init(x: -hm - w, y: 0))
            positions.append(CGPoint.init(x: +hm + w, y: 0))
            positions.append(CGPoint.init(x: -hm_0_5 - w_0_5, y: +vm + h))
            positions.append(CGPoint.init(x: +hm_0_5 + w_0_5, y: +vm + h))
        case .sc_6_4:
            positions.append(CGPoint.init(x: 0, y: -vm - h))
            positions.append(CGPoint.init(x: -hm - w, y: -vm_0_5 - h_0_5))
            positions.append(CGPoint.init(x: +hm + w, y: -vm_0_5 - h_0_5))
            positions.append(CGPoint.init(x: -hm - w, y: +vm_0_5 + h_0_5))
            positions.append(CGPoint.init(x: +hm + w, y: +vm_0_5 + h_0_5))
            positions.append(CGPoint.init(x: 0, y: +vm + h))
        case .sc_6_5:
            positions.append(CGPoint.init(x: -hm - w, y: -vm - h))
            positions.append(CGPoint.init(x: 0, y: -vm - h))
            positions.append(CGPoint.init(x: +hm + w, y: -vm - h))
            positions.append(CGPoint.init(x: -hm_0_5 - w_0_5, y: 0))
            positions.append(CGPoint.init(x: +hm_0_5 + w_0_5, y: 0))
            positions.append(CGPoint.init(x: 0, y: vm + h))
        case .sc_6_6:
            positions.append(CGPoint.init(x: 0, y: -vm - h))
            positions.append(CGPoint.init(x: -hm_0_5 - w_0_5, y: 0))
            positions.append(CGPoint.init(x: +hm_0_5 + w_0_5, y: 0))
            positions.append(CGPoint.init(x: -hm - w, y: vm + h))
            positions.append(CGPoint.init(x: 0, y: vm + h))
            positions.append(CGPoint.init(x: +hm + w, y: vm + h))
        case .sc_7_1:
            positions.append(CGPoint.init(x: -hm - w, y: -vm - h))
            positions.append(CGPoint.init(x: 0, y: -vm - h))
            positions.append(CGPoint.init(x: +hm + w, y: -vm - h))
            positions.append(CGPoint.init(x: -hm - w, y: 0))
            positions.append(CGPoint.init(x: 0, y: 0))
            positions.append(CGPoint.init(x: +hm + w, y: 0))
            positions.append(CGPoint.init(x: 0, y: vm + h))
        case .sc_7_2:
            positions.append(CGPoint.init(x: 0, y: -vm - h))
            positions.append(CGPoint.init(x: -hm - w, y: 0))
            positions.append(CGPoint.init(x: 0, y: 0))
            positions.append(CGPoint.init(x: +hm + w, y: 0))
            positions.append(CGPoint.init(x: -hm - w, y: vm + h))
            positions.append(CGPoint.init(x: 0, y: vm + h))
            positions.append(CGPoint.init(x: +hm + w, y: vm + h))
        case .sc_7_3:
            positions.append(CGPoint.init(x: -hm_0_5 - w_0_5, y: -vm - h))
            positions.append(CGPoint.init(x: +hm_0_5 + w_0_5, y: -vm - h))
            positions.append(CGPoint.init(x: -hm - w, y: 0))
            positions.append(CGPoint.init(x: 0, y: 0))
            positions.append(CGPoint.init(x: +hm + w, y: 0))
            positions.append(CGPoint.init(x: -hm_0_5 - w_0_5, y: +vm + h))
            positions.append(CGPoint.init(x: +hm_0_5 + w_0_5, y: +vm + h))
        case .sc_7_4:
            positions.append(CGPoint.init(x: 0, y: -vm - h))
            positions.append(CGPoint.init(x: -hm - w, y: -vm_0_5 - h_0_5))
            positions.append(CGPoint.init(x: +hm + w, y: -vm_0_5 - h_0_5))
            positions.append(CGPoint.init(x: 0, y: 0))
            positions.append(CGPoint.init(x: -hm - w, y: +vm_0_5 + h_0_5))
            positions.append(CGPoint.init(x: +hm + w, y: +vm_0_5 + h_0_5))
            positions.append(CGPoint.init(x: 0, y: +vm + h))
        case .sc_7_5:
            positions.append(CGPoint.init(x: -hm_1_5 - w_1_5, y: -vm_0_5 - h_0_5))
            positions.append(CGPoint.init(x: -hm_0_5 - w_0_5, y: -vm_0_5 - h_0_5))
            positions.append(CGPoint.init(x: +hm_0_5 + w_0_5, y: -vm_0_5 - h_0_5))
            positions.append(CGPoint.init(x: +hm_1_5 + w_1_5, y: -vm_0_5 - h_0_5))
            positions.append(CGPoint.init(x: -hm - w, y: vm_0_5 + h_0_5))
            positions.append(CGPoint.init(x: 0, y: vm_0_5 + h_0_5))
            positions.append(CGPoint.init(x: +hm + w, y: vm_0_5 + h_0_5))
        case .sc_7_6:
            positions.append(CGPoint.init(x: -hm - w, y: vm_0_5 - h_0_5))
            positions.append(CGPoint.init(x: 0, y: vm_0_5 - h_0_5))
            positions.append(CGPoint.init(x: +hm + w, y: vm_0_5 - h_0_5))
            positions.append(CGPoint.init(x: -hm_1_5 - w_1_5, y: +vm_0_5 + h_0_5))
            positions.append(CGPoint.init(x: -hm_0_5 - w_0_5, y: +vm_0_5 + h_0_5))
            positions.append(CGPoint.init(x: +hm_0_5 + w_0_5, y: +vm_0_5 + h_0_5))
            positions.append(CGPoint.init(x: +hm_1_5 + w_1_5, y: +vm_0_5 + h_0_5))
        case .sc_8_1:
            positions.append(CGPoint.init(x: -hm - w, y: -vm - h))
            positions.append(CGPoint.init(x: 0, y: -vm - h))
            positions.append(CGPoint.init(x: +hm + w, y: -vm - h))
            positions.append(CGPoint.init(x: -hm_0_5 - w_0_5, y: 0))
            positions.append(CGPoint.init(x: +hm_0_5 + w_0_5, y: 0))
            positions.append(CGPoint.init(x: -hm - w, y: +vm + h))
            positions.append(CGPoint.init(x: 0, y: +vm + h))
            positions.append(CGPoint.init(x: +hm + w, y: +vm + h))
        case .sc_8_2:
            positions.append(CGPoint.init(x: -hm - w, y: -vm - h))
            positions.append(CGPoint.init(x: +hm + w, y: -vm - h))
            positions.append(CGPoint.init(x: 0, y: -vm_0_5 - h_0_5))
            positions.append(CGPoint.init(x: -hm - w, y: 0))
            positions.append(CGPoint.init(x: +hm + w, y: 0))
            positions.append(CGPoint.init(x: 0, y: +vm_0_5 + h_0_5))
            positions.append(CGPoint.init(x: -hm - w, y: +vm + h))
            positions.append(CGPoint.init(x: +hm + w, y: +vm + h))
        case .sc_8_3:
            positions.append(CGPoint.init(x: -hm - w, y: -vm - h))
            positions.append(CGPoint.init(x: 0, y: -vm - h))
            positions.append(CGPoint.init(x: +hm + w, y: -vm - h))
            positions.append(CGPoint.init(x: -hm - w, y: 0))
            positions.append(CGPoint.init(x: +hm + w, y: 0))
            positions.append(CGPoint.init(x: -hm - w, y: +vm + h))
            positions.append(CGPoint.init(x: 0, y: +vm + h))
            positions.append(CGPoint.init(x: +hm + w, y: +vm + h))
        case .sc_8_4:
            positions.append(CGPoint.init(x: 0, y: -vm_2_0 - h_2_0))
            positions.append(CGPoint.init(x: +hm_0_5 + w_0_5, y: -vm - h))
            positions.append(CGPoint.init(x: -hm_0_5 - w_0_5, y: -vm - h))
            positions.append(CGPoint.init(x: -hm - w, y: 0))
            positions.append(CGPoint.init(x: +hm + w, y: 0))
            positions.append(CGPoint.init(x: -hm_0_5 - w_0_5, y: +vm + h))
            positions.append(CGPoint.init(x: +hm_0_5 + w_0_5, y: +vm + h))
            positions.append(CGPoint.init(x: 0, y: +vm_2_0 + h_2_0))
        case .sc_8_5:
            positions.append(CGPoint.init(x: 0, y: -vm - h))
            positions.append(CGPoint.init(x: -hm - w, y: -vm_0_5 - h_0_5))
            positions.append(CGPoint.init(x: +hm + w, y: -vm_0_5 - h_0_5))
            positions.append(CGPoint.init(x: -hm_2_0 - w_2_0, y: 0))
            positions.append(CGPoint.init(x: +hm_2_0 + w_2_0, y: 0))
            positions.append(CGPoint.init(x: -hm - w, y: +vm_0_5 + h_0_5))
            positions.append(CGPoint.init(x: +hm + w, y: +vm_0_5 + h_0_5))
            positions.append(CGPoint.init(x: 0, y: +vm + h))
        case .sc_8_6:
            positions.append(CGPoint.init(x: -hm_1_5 - w_1_5, y: -vm_0_5 - h_0_5))
            positions.append(CGPoint.init(x: -hm_0_5 - w_0_5, y: -vm_0_5 - h_0_5))
            positions.append(CGPoint.init(x: +hm_0_5 + w_0_5, y: -vm_0_5 - h_0_5))
            positions.append(CGPoint.init(x: +hm_1_5 + w_1_5, y: -vm_0_5 - h_0_5))
            positions.append(CGPoint.init(x: -hm_1_5 - w_1_5, y: +vm_0_5 + h_0_5))
            positions.append(CGPoint.init(x: -hm_0_5 - w_0_5, y: +vm_0_5 + h_0_5))
            positions.append(CGPoint.init(x: +hm_0_5 + w_0_5, y: +vm_0_5 + h_0_5))
            positions.append(CGPoint.init(x: +hm_1_5 + w_1_5, y: +vm_0_5 + h_0_5))
        case .sc_8_7:
            positions.append(CGPoint.init(x: -hm_0_5 - w_0_5, y: -vm_1_5 - h_1_5))
            positions.append(CGPoint.init(x: +hm_0_5 + w_0_5, y: -vm_1_5 - h_1_5))
            positions.append(CGPoint.init(x: -hm_0_5 - w_0_5, y: -vm_0_5 - h_0_5))
            positions.append(CGPoint.init(x: +hm_0_5 + w_0_5, y: -vm_0_5 - h_0_5))
            positions.append(CGPoint.init(x: -hm_0_5 - w_0_5, y: +vm_0_5 + h_0_5))
            positions.append(CGPoint.init(x: +hm_0_5 + w_0_5, y: +vm_0_5 + h_0_5))
            positions.append(CGPoint.init(x: -hm_0_5 - w_0_5, y: +vm_1_5 + h_1_5))
            positions.append(CGPoint.init(x: +hm_0_5 + w_0_5, y: +vm_1_5 + h_1_5))
        case .sc_9_1:
            positions.append(CGPoint.init(x: -hm - w, y: -vm - h))
            positions.append(CGPoint.init(x: 0, y: -vm - h))
            positions.append(CGPoint.init(x: +hm + w, y: -vm - h))
            positions.append(CGPoint.init(x: -hm - w, y: 0))
            positions.append(CGPoint.init(x: 0, y: 0))
            positions.append(CGPoint.init(x: +hm + w, y: 0))
            positions.append(CGPoint.init(x: -hm - w, y: +vm + h))
            positions.append(CGPoint.init(x: 0, y: +vm + h))
            positions.append(CGPoint.init(x: +hm + w, y: +vm + h))
        case .sc_9_2:
            positions.append(CGPoint.init(x: 0, y: -vm_2_0 - h_2_0))
            positions.append(CGPoint.init(x: -hm_0_5 - w_0_5, y: -vm - h))
            positions.append(CGPoint.init(x: +hm_0_5 + w_0_5, y: -vm - h))
            positions.append(CGPoint.init(x: -hm - w, y: 0))
            positions.append(CGPoint.init(x: 0, y: 0))
            positions.append(CGPoint.init(x: +hm + w, y: 0))
            positions.append(CGPoint.init(x: -hm_0_5 - w_0_5, y: +vm + h))
            positions.append(CGPoint.init(x: +hm_0_5 + w_0_5, y: +vm + h))
            positions.append(CGPoint.init(x: 0, y: +vm_2_0 + h_2_0))
        case .sc_9_3:
            positions.append(CGPoint.init(x: 0, y: -vm - h))
            positions.append(CGPoint.init(x: -hm - w, y: -vm_0_5 - h_0_5))
            positions.append(CGPoint.init(x: +hm + w, y: -vm_0_5 - h_0_5))
            positions.append(CGPoint.init(x: -hm_2_0 - w_2_0, y: 0))
            positions.append(CGPoint.init(x: 0, y: 0))
            positions.append(CGPoint.init(x: +hm_2_0 + w_2_0, y: 0))
            positions.append(CGPoint.init(x: -hm - w, y: +vm_0_5 + h_0_5))
            positions.append(CGPoint.init(x: +hm + w, y: +vm_0_5 + h_0_5))
            positions.append(CGPoint.init(x: 0, y: +vm + h))
        case .custom:
            positions += bmb.customButtonPlacePositions
        default:
            assert(false, "Button place enum not found!")
            break
        }
        
        switch bmb.buttonPlaceEnum {
        case .sc_3_3:
            adjust(positions: &positions, offsetX: 0, offsetY: +pow(hm_0_5 + w_0_5, 2) / (vm + h))
        case .sc_3_4:
            adjust(positions: &positions, offsetX: 0, offsetY: -pow(hm_0_5 + w_0_5, 2) / (vm + h))
        case .sc_4_2, .sc_5_1, .sc_5_2, .sc_5_3, .sc_5_4, .sc_6_1, .sc_6_2, .sc_6_3, .sc_6_4, .sc_6_5, .sc_6_6,
             .sc_7_1, .sc_7_2, .sc_7_3, .sc_7_4, .sc_7_5, .sc_7_6, .sc_8_1, .sc_8_2, .sc_8_3, .sc_8_4, .sc_8_5,
             .sc_8_6, .sc_8_7, .sc_9_1, .sc_9_2, .sc_9_3:
            adjust(positions: &positions, offsetX: 0, offsetY: h_0_5 - w_0_5)
        default:
            if buttonNumber >= 2
                && bmb.buttonEnum == .ham
                && bmb.buttonHamButtonTopMargin > 0
                && bmb.buttonPlaceEnum != .horizontal {
                positions[buttonNumber - 1].y += bmb.buttonHamButtonTopMargin - vm
            }
        }
        
        adjust(positions: &positions, offsetX: parentFrame.size.width / 2, offsetY: parentFrame.size.height / 2)
        adjust(positions: &positions, parentFrame: parentFrame, halfButtonWidth: w_0_5, halfButtonHeight: h_0_5, boomMenuButton: bmb)
        
        return positions
    }

    static func positions(parentFrame: CGRect,
                          buttonRadius r: CGFloat,
                          buttonNumber: Int,
                          boomMenuButton bmb: BoomMenuButton) -> [CGPoint] {
        var positions = [CGPoint]()
        
        let halfButtonNumber: Int = buttonNumber / 2
        
        let hm: CGFloat = bmb.buttonHorizontalMargin
        let hm_0_5: CGFloat = hm / 2
        let hm_1_5: CGFloat = hm * 1.5
        
        let vm: CGFloat = bmb.buttonVerticalMargin
        let vm_0_5: CGFloat = vm / 2
        let vm_1_5: CGFloat = vm * 1.5
        
        let im: CGFloat = bmb.buttonInclinedMargin
        
        let r_2_0: CGFloat = 2 * r
        let r_3_0: CGFloat = 3 * r
        
        var a: CGFloat, b: CGFloat, c: CGFloat, e: CGFloat
        b = hm_0_5 + r
        c = b / (sqrt(3) / 2)
        a = c / 2
        e = c - a
        switch bmb.buttonPlaceEnum {
        case .sc_4_2, .sc_5_4, .sc_8_5, .sc_9_3:
            a = (r_2_0 + im) / sqrt(2)
        case .sc_8_2:
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
        
        switch bmb.buttonPlaceEnum {
        case .horizontal:
            if buttonNumber % 2 == 0 {
                for i in (0..<halfButtonNumber).reversed() {
                    positions.append(CGPoint.init(x: -r - hm_0_5 - CGFloat(i) * (r_2_0 + hm), y: 0))
                }
                for i in 0..<halfButtonNumber {
                    positions.append(CGPoint.init(x: +r + hm_0_5 + CGFloat(i) * (r_2_0 + hm), y: 0))
                }
            } else {
                for i in (0..<halfButtonNumber).reversed() {
                    positions.append(CGPoint.init(x: -r_2_0 - hm - CGFloat(i) * (r_2_0 + hm), y: 0))
                }
                positions.append(CGPoint.init(x: 0, y: 0))
                for i in 0..<halfButtonNumber {
                    positions.append(CGPoint.init(x: +r_2_0 + hm + CGFloat(i) * (r_2_0 + hm), y: 0))
                }
            }
        case .vertical:
            if buttonNumber % 2 == 0 {
                for i in (0..<halfButtonNumber).reversed() {
                    positions.append(CGPoint.init(x: 0, y: -r - vm_0_5 - CGFloat(i) * (r_2_0 + vm)))
                }
                for i in 0..<halfButtonNumber {
                    positions.append(CGPoint.init(x: 0, y: +r + vm_0_5 + CGFloat(i) * (r_2_0 + vm)))
                }
            } else {
                for i in (0..<halfButtonNumber).reversed() {
                    positions.append(CGPoint.init(x: 0, y: -r_2_0 - vm - CGFloat(i) * (r_2_0 + vm)))
                }
                positions.append(CGPoint.init(x: 0, y: 0))
                for i in 0..<halfButtonNumber {
                    positions.append(CGPoint.init(x: 0, y: +r_2_0 + vm + CGFloat(i) * (r_2_0 + vm)))
                }
            }
        case .sc_1:
            positions.append(CGPoint.init(x: 0, y: 0))
        case .sc_2_1:
            positions.append(CGPoint.init(x: -hm_0_5 - r, y: 0))
            positions.append(CGPoint.init(x: +hm_0_5 + r, y: 0))
        case .sc_2_2:
            positions.append(CGPoint.init(x: 0, y: -vm_0_5 - r))
            positions.append(CGPoint.init(x: 0, y: +vm_0_5 + r))
        case .sc_3_1:
            positions.append(CGPoint.init(x: -hm - r_2_0, y: 0))
            positions.append(CGPoint.init(x: 0, y: 0))
            positions.append(CGPoint.init(x: +hm + r_2_0, y: 0))
        case .sc_3_2:
            positions.append(CGPoint.init(x: 0, y: -vm - r_2_0))
            positions.append(CGPoint.init(x: 0, y: 0))
            positions.append(CGPoint.init(x: 0, y: +vm + r_2_0))
        case .sc_3_3:
            positions.append(CGPoint.init(x: -b, y: -a))
            positions.append(CGPoint.init(x: +b, y: -a))
            positions.append(CGPoint.init(x: 0, y: c))
        case .sc_3_4:
            positions.append(CGPoint.init(x: 0, y: -c))
            positions.append(CGPoint.init(x: -b, y: a))
            positions.append(CGPoint.init(x: +b, y: a))
        case .sc_4_1:
            positions.append(CGPoint.init(x: -hm_0_5 - r, y: -vm_0_5 - r))
            positions.append(CGPoint.init(x: +hm_0_5 + r, y: -vm_0_5 - r))
            positions.append(CGPoint.init(x: -hm_0_5 - r, y: +vm_0_5 + r))
            positions.append(CGPoint.init(x: +hm_0_5 + r, y: +vm_0_5 + r))
        case .sc_4_2:
            positions.append(CGPoint.init(x: 0, y: -a))
            positions.append(CGPoint.init(x: -a, y: 0))
            positions.append(CGPoint.init(x: +a, y: 0))
            positions.append(CGPoint.init(x: 0, y: +a))
        case .sc_5_1:
            positions.append(CGPoint.init(x: -b_2_0, y: -c))
            positions.append(CGPoint.init(x: 0, y: -c))
            positions.append(CGPoint.init(x: +b_2_0, y: -c))
            positions.append(CGPoint.init(x: -hm_0_5 - r, y: a))
            positions.append(CGPoint.init(x: +hm_0_5 + r, y: a))
        case .sc_5_2:
            positions.append(CGPoint.init(x: -hm_0_5 - r, y: -a))
            positions.append(CGPoint.init(x: +hm_0_5 + r, y: -a))
            positions.append(CGPoint.init(x: -b_2_0, y: c))
            positions.append(CGPoint.init(x: 0, y: c))
            positions.append(CGPoint.init(x: +b_2_0, y: c))
        case .sc_5_3:
            positions.append(CGPoint.init(x: 0, y: -vm - r_2_0))
            positions.append(CGPoint.init(x: -hm - r_2_0, y: 0))
            positions.append(CGPoint.init(x: 0, y: 0))
            positions.append(CGPoint.init(x: +hm + r_2_0, y: 0))
            positions.append(CGPoint.init(x: 0, y: +vm + r_2_0))
        case .sc_5_4:
            positions.append(CGPoint.init(x: -a, y: -a))
            positions.append(CGPoint.init(x: +a, y: -a))
            positions.append(CGPoint.init(x: 0, y: 0))
            positions.append(CGPoint.init(x: -a, y: +a))
            positions.append(CGPoint.init(x: +a, y: +a))
        case .sc_6_1:
            positions.append(CGPoint.init(x: -hm - r_2_0, y: -vm_0_5 - r))
            positions.append(CGPoint.init(x: 0, y: -vm_0_5 - r))
            positions.append(CGPoint.init(x: +hm + r_2_0, y: -vm_0_5 - r))
            positions.append(CGPoint.init(x: -hm - r_2_0, y: +vm_0_5 + r))
            positions.append(CGPoint.init(x: 0, y: +vm_0_5 + r))
            positions.append(CGPoint.init(x: +hm + r_2_0, y: +vm_0_5 + r))
        case .sc_6_2:
            positions.append(CGPoint.init(x: -hm_0_5 - r, y: -vm - r_2_0))
            positions.append(CGPoint.init(x: +hm_0_5 + r, y: -vm - r_2_0))
            positions.append(CGPoint.init(x: -hm_0_5 - r, y: 0))
            positions.append(CGPoint.init(x: +hm_0_5 + r, y: 0))
            positions.append(CGPoint.init(x: -hm_0_5 - r, y: +vm + r_2_0))
            positions.append(CGPoint.init(x: +hm_0_5 + r, y: +vm + r_2_0))
        case .sc_6_3:
            positions.append(CGPoint.init(x: -b, y: -a - c))
            positions.append(CGPoint.init(x: +b, y: -a - c))
            positions.append(CGPoint.init(x: -b_2_0, y: 0))
            positions.append(CGPoint.init(x: +b_2_0, y: 0))
            positions.append(CGPoint.init(x: -b, y: +a + c))
            positions.append(CGPoint.init(x: +b, y: +a + c))
        case .sc_6_4:
            positions.append(CGPoint.init(x: 0, y: -b_2_0))
            positions.append(CGPoint.init(x: -a - c, y: -b))
            positions.append(CGPoint.init(x: +a + c, y: -b))
            positions.append(CGPoint.init(x: -a - c, y: +b))
            positions.append(CGPoint.init(x: +a + c, y: +b))
            positions.append(CGPoint.init(x: 0, y: +b_2_0))
        case .sc_6_5:
            positions.append(CGPoint.init(x: -b_2_0, y: -a - c + e))
            positions.append(CGPoint.init(x: 0, y: -a - c + e))
            positions.append(CGPoint.init(x: +b_2_0, y: -a - c + e))
            positions.append(CGPoint.init(x: -hm_0_5 - r, y: +e))
            positions.append(CGPoint.init(x: +hm_0_5 + r, y: +e))
            positions.append(CGPoint.init(x: 0, y: +a + c + e))
        case .sc_6_6:
            positions.append(CGPoint.init(x: 0, y: -a - c - e))
            positions.append(CGPoint.init(x: -hm_0_5 - r, y: -e))
            positions.append(CGPoint.init(x: +hm_0_5 + r, y: -e))
            positions.append(CGPoint.init(x: -b_2_0, y: +a + c - e))
            positions.append(CGPoint.init(x: 0, y: +a + c - e))
            positions.append(CGPoint.init(x: +b_2_0, y: +a + c - e))
        case .sc_7_1:
            positions.append(CGPoint.init(x: -hm - r_2_0, y: -vm - r_2_0))
            positions.append(CGPoint.init(x: 0, y: -vm - r_2_0))
            positions.append(CGPoint.init(x: +hm + r_2_0, y: -vm - r_2_0))
            positions.append(CGPoint.init(x: -hm - r_2_0, y: 0))
            positions.append(CGPoint.init(x: 0, y: 0))
            positions.append(CGPoint.init(x: +hm + r_2_0, y: 0))
            positions.append(CGPoint.init(x: 0, y: +vm + r_2_0))
        case .sc_7_2:
            positions.append(CGPoint.init(x: 0, y: -vm - r_2_0))
            positions.append(CGPoint.init(x: -hm - r_2_0, y: 0))
            positions.append(CGPoint.init(x: 0, y: 0))
            positions.append(CGPoint.init(x: +hm + r_2_0, y: 0))
            positions.append(CGPoint.init(x: -hm - r_2_0, y: vm + r_2_0))
            positions.append(CGPoint.init(x: 0, y: vm + r_2_0))
            positions.append(CGPoint.init(x: +hm + r_2_0, y: vm + r_2_0))
        case .sc_7_3:
            positions.append(CGPoint.init(x: -b, y: -a - c))
            positions.append(CGPoint.init(x: +b, y: -a - c))
            positions.append(CGPoint.init(x: -b_2_0, y: 0))
            positions.append(CGPoint.init(x: 0, y: 0))
            positions.append(CGPoint.init(x: +b_2_0, y: 0))
            positions.append(CGPoint.init(x: -b, y: +a + c))
            positions.append(CGPoint.init(x: +b, y: +a + c))
        case .sc_7_4:
            positions.append(CGPoint.init(x: 0, y: -b_2_0))
            positions.append(CGPoint.init(x: -a - c, y: -b))
            positions.append(CGPoint.init(x: +a + c, y: -b))
            positions.append(CGPoint.init(x: 0, y: 0))
            positions.append(CGPoint.init(x: -a - c, y: +b))
            positions.append(CGPoint.init(x: +a + c, y: +b))
            positions.append(CGPoint.init(x: 0, y: +b_2_0))
        case .sc_7_5:
            positions.append(CGPoint.init(x: -b_3_0, y: -a))
            positions.append(CGPoint.init(x: -b, y: -a))
            positions.append(CGPoint.init(x: +b, y: -a))
            positions.append(CGPoint.init(x: +b_3_0, y: -a))
            positions.append(CGPoint.init(x: -b_2_0, y: c))
            positions.append(CGPoint.init(x: 0, y: c))
            positions.append(CGPoint.init(x: +b_2_0, y: c))
        case .sc_7_6:
            positions.append(CGPoint.init(x: -b_2_0, y: -c))
            positions.append(CGPoint.init(x: 0, y: -c))
            positions.append(CGPoint.init(x: +b_2_0, y: -c))
            positions.append(CGPoint.init(x: -b_3_0, y: a))
            positions.append(CGPoint.init(x: -b, y: a))
            positions.append(CGPoint.init(x: +b, y: a))
            positions.append(CGPoint.init(x: +b_3_0, y: a))
        case .sc_8_1:
            positions.append(CGPoint.init(x: -b_2_0, y: -a - c))
            positions.append(CGPoint.init(x: 0, y: -a - c))
            positions.append(CGPoint.init(x: +b_2_0, y: -a - c))
            positions.append(CGPoint.init(x: -hm_0_5 - r, y: 0))
            positions.append(CGPoint.init(x: +hm_0_5 + r, y: 0))
            positions.append(CGPoint.init(x: -b_2_0, y: +a + c))
            positions.append(CGPoint.init(x: 0, y: +a + c))
            positions.append(CGPoint.init(x: +b_2_0, y: +a + c))
        case .sc_8_2:
            positions.append(CGPoint.init(x: -a - c, y: -b_2_0))
            positions.append(CGPoint.init(x: +a + c, y: -b_2_0))
            positions.append(CGPoint.init(x: 0, y: -vm_0_5 - r))
            positions.append(CGPoint.init(x: -a - c, y: 0))
            positions.append(CGPoint.init(x: +a + c, y: 0))
            positions.append(CGPoint.init(x: 0, y: +vm_0_5 + r))
            positions.append(CGPoint.init(x: -a - c, y: +b_2_0))
            positions.append(CGPoint.init(x: +a + c, y: +b_2_0))
        case .sc_8_3:
            positions.append(CGPoint.init(x: -hm - r_2_0, y: -vm - r_2_0))
            positions.append(CGPoint.init(x: 0, y: -vm - r_2_0))
            positions.append(CGPoint.init(x: +hm + r_2_0, y: -vm - r_2_0))
            positions.append(CGPoint.init(x: -hm - r_2_0, y: 0))
            positions.append(CGPoint.init(x: +hm + r_2_0, y: 0))
            positions.append(CGPoint.init(x: -hm - r_2_0, y: +vm + r_2_0))
            positions.append(CGPoint.init(x: 0, y: +vm + r_2_0))
            positions.append(CGPoint.init(x: +hm + r_2_0, y: +vm + r_2_0))
        case .sc_8_4:
            positions.append(CGPoint.init(x: 0, y: -a_2_0 - c_2_0))
            positions.append(CGPoint.init(x: -hm_0_5 - r, y: -a - c))
            positions.append(CGPoint.init(x: +hm_0_5 + r, y: -a - c))
            positions.append(CGPoint.init(x: -b_2_0, y: 0))
            positions.append(CGPoint.init(x: +b_2_0, y: 0))
            positions.append(CGPoint.init(x: -hm_0_5 - r, y: +a + c))
            positions.append(CGPoint.init(x: +hm_0_5 + r, y: +a + c))
            positions.append(CGPoint.init(x: 0, y: +a_2_0 + c_2_0))
        case .sc_8_5:
            positions.append(CGPoint.init(x: 0, y: -a_2_0))
            positions.append(CGPoint.init(x: -a, y: -a))
            positions.append(CGPoint.init(x: +a, y: -a))
            positions.append(CGPoint.init(x: -a_2_0, y: 0))
            positions.append(CGPoint.init(x: +a_2_0, y: 0))
            positions.append(CGPoint.init(x: -a, y: +a))
            positions.append(CGPoint.init(x: +a, y: +a))
            positions.append(CGPoint.init(x: 0, y: +a_2_0))
        case .sc_8_6:
            positions.append(CGPoint.init(x: -hm_1_5 - r_3_0, y: -vm_0_5 - r))
            positions.append(CGPoint.init(x: -hm_0_5 - r, y: -vm_0_5 - r))
            positions.append(CGPoint.init(x: +hm_0_5 + r, y: -vm_0_5 - r))
            positions.append(CGPoint.init(x: +hm_1_5 + r_3_0, y: -vm_0_5 - r))
            positions.append(CGPoint.init(x: -hm_1_5 - r_3_0, y: +vm_0_5 + r))
            positions.append(CGPoint.init(x: -hm_0_5 - r, y: +vm_0_5 + r))
            positions.append(CGPoint.init(x: +hm_0_5 + r, y: +vm_0_5 + r))
            positions.append(CGPoint.init(x: +hm_1_5 + r_3_0, y: +vm_0_5 + r))
        case .sc_8_7:
            positions.append(CGPoint.init(x: -hm_0_5 - r, y: -vm_1_5 - r_3_0))
            positions.append(CGPoint.init(x: +hm_0_5 + r, y: -vm_1_5 - r_3_0))
            positions.append(CGPoint.init(x: -hm_0_5 - r, y: -vm_0_5 - r))
            positions.append(CGPoint.init(x: +hm_0_5 + r, y: -vm_0_5 - r))
            positions.append(CGPoint.init(x: -hm_0_5 - r, y: +vm_0_5 + r))
            positions.append(CGPoint.init(x: +hm_0_5 + r, y: +vm_0_5 + r))
            positions.append(CGPoint.init(x: -hm_0_5 - r, y: +vm_1_5 + r_3_0))
            positions.append(CGPoint.init(x: +hm_0_5 + r, y: +vm_1_5 + r_3_0))
        case .sc_9_1:
            positions.append(CGPoint.init(x: -hm - r_2_0, y: -vm - r_2_0))
            positions.append(CGPoint.init(x: 0, y: -vm - r_2_0))
            positions.append(CGPoint.init(x: +hm + r_2_0, y: -vm - r_2_0))
            positions.append(CGPoint.init(x: -hm - r_2_0, y: 0))
            positions.append(CGPoint.init(x: 0, y: 0))
            positions.append(CGPoint.init(x: +hm + r_2_0, y: 0))
            positions.append(CGPoint.init(x: -hm - r_2_0, y: +vm + r_2_0))
            positions.append(CGPoint.init(x: 0, y: +vm + r_2_0))
            positions.append(CGPoint.init(x: +hm + r_2_0, y: +vm + r_2_0))
        case .sc_9_2:
            positions.append(CGPoint.init(x: 0, y: -a_2_0 - c_2_0))
            positions.append(CGPoint.init(x: -hm_0_5 - r, y: -a - c))
            positions.append(CGPoint.init(x: +hm_0_5 + r, y: -a - c))
            positions.append(CGPoint.init(x: -b_2_0, y: 0))
            positions.append(CGPoint.init(x: 0, y: 0))
            positions.append(CGPoint.init(x: +b_2_0, y: 0))
            positions.append(CGPoint.init(x: -hm_0_5 - r, y: +a + c))
            positions.append(CGPoint.init(x: +hm_0_5 + r, y: +a + c))
            positions.append(CGPoint.init(x: 0, y: +a_2_0 + c_2_0))
        case .sc_9_3:
            positions.append(CGPoint.init(x: 0, y: -a_2_0))
            positions.append(CGPoint.init(x: -a, y: -a))
            positions.append(CGPoint.init(x: +a, y: -a))
            positions.append(CGPoint.init(x: -a_2_0, y: 0))
            positions.append(CGPoint.init(x: 0, y: 0))
            positions.append(CGPoint.init(x: +a_2_0, y: 0))
            positions.append(CGPoint.init(x: -a, y: +a))
            positions.append(CGPoint.init(x: +a, y: +a))
            positions.append(CGPoint.init(x: 0, y: +a_2_0))
        case .custom:
            positions += bmb.customButtonPlacePositions
        default:
            assert(false, "Button place enum not found!")
            break
        }
        
        adjust(positions: &positions, offsetX: parentFrame.size.width / 2, offsetY: parentFrame.size.height / 2)
        adjust(positions: &positions, parentFrame: parentFrame, halfButtonWidth: r, halfButtonHeight: r, boomMenuButton: bmb)
        
        return positions
    }
    
    private static func adjust(positions: inout [CGPoint], offsetX x: CGFloat, offsetY y: CGFloat) {
        for i in positions.indices {
            positions[i].x += x
            positions[i].y += y
        }
    }
    
    private static func adjust(positions: inout [CGPoint],
                               parentFrame: CGRect,
                               halfButtonWidth halfWidth: CGFloat,
                               halfButtonHeight halfHeight: CGFloat,
                               boomMenuButton bmb: BoomMenuButton) {
        var minY: CGFloat = CGFloat.greatestFiniteMagnitude
        var maxY: CGFloat = CGFloat.leastNormalMagnitude
        var minX: CGFloat = CGFloat.greatestFiniteMagnitude
        var maxX: CGFloat = CGFloat.leastNormalMagnitude
        
        for position in positions {
            maxY = max(maxY, position.y)
            minY = min(minY, position.y)
            maxX = max(maxX, position.x)
            minX = min(minX, position.x)
        }
        
        var yOffset: CGFloat = 0
        var xOffset: CGFloat = 0
        switch bmb.buttonPlaceAlignmentEnum {
        case .center:
            break
        case .top:
            yOffset = halfHeight + bmb.buttonTopMargin - minY
        case .bottom:
            yOffset = parentFrame.size.height - halfHeight - maxY - bmb.buttonBottomMargin
        case .left:
            xOffset = halfWidth + bmb.buttonLeftMargin - minX
        case .right:
            xOffset = parentFrame.size.width - halfHeight - maxX - bmb.buttonRightMargin
        case .topLeft:
            yOffset = halfHeight + bmb.buttonTopMargin - minY
            xOffset = halfWidth + bmb.buttonLeftMargin - minX
        case .topRight:
            yOffset = halfHeight + bmb.buttonTopMargin - minY
            xOffset = parentFrame.size.width - halfWidth - maxX - bmb.buttonRightMargin
        case .bottomLeft:
            yOffset = parentFrame.size.height - halfHeight - maxY - bmb.buttonBottomMargin
            xOffset = halfWidth + bmb.buttonLeftMargin - minX
        case .bottomRight:
            yOffset = parentFrame.size.height - halfHeight - maxY - bmb.buttonBottomMargin
            xOffset = parentFrame.size.width - halfWidth - maxX - bmb.buttonRightMargin
        }
        
        adjust(positions: &positions, offsetX: xOffset, offsetY: yOffset)
    }
}
