//
//  CustomPositionVC.swift
//  VHBoomMenuButtonSwiftDemo
//
//  Created by viktorhuang on 2017/5/6.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

import UIKit
import BoomMenuButton

class CustomPositionVC: BoomMenuButtonVC {

    @IBOutlet weak var bmb1: BoomMenuButton!
    @IBOutlet weak var bmb2: BoomMenuButton!
    @IBOutlet weak var bmb3: BoomMenuButton!
    @IBOutlet weak var bmb4: BoomMenuButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeBmb1()
        initializeBmb2()
        initializeBmb3()
        initializeBmb4()
    }
    
    func initializeBmb1() {
        bmb1.buttonEnum = .ham
        bmb1.piecePlaceEnum = .custom
        bmb1.hamWidth = 10
        bmb1.buttonPlaceEnum = .ham_4
        for _ in 0..<bmb1.buttonPlaceEnum.buttonNumber() {
            bmb1.addBuilder(BuilderManager.hamButtonBuilder())
        }
        
        let w_0_5: CGFloat = bmb1.hamWidth / 2
        let h_0_5: CGFloat = bmb1.hamHeight / 2
        
        let hm_0_5: CGFloat = bmb1.pieceHorizontalMargin / 2
        let vm_0_5: CGFloat = bmb1.pieceVerticalMargin / 2
        
        bmb1.customPiecePlacePositions.append(CGPoint.init(x: -w_0_5 - hm_0_5, y: -h_0_5 - vm_0_5))
        bmb1.customPiecePlacePositions.append(CGPoint.init(x: +w_0_5 + hm_0_5, y: -h_0_5 - vm_0_5))
        bmb1.customPiecePlacePositions.append(CGPoint.init(x: -w_0_5 - hm_0_5, y: +h_0_5 + vm_0_5))
        bmb1.customPiecePlacePositions.append(CGPoint.init(x: +w_0_5 + hm_0_5, y: +h_0_5 + vm_0_5))
    }
    
    func initializeBmb2() {
        bmb2.buttonEnum = .simpleCircle
        bmb2.piecePlaceEnum = .dot_3_1
        bmb2.buttonPlaceEnum = .custom
        for _ in 0..<bmb2.piecePlaceEnum.pieceNumber() {
            bmb2.addBuilder(BuilderManager.simpleCircleButtonBuilder())
        }
        
        bmb2.customButtonPlacePositions.append(CGPoint.init(x: -60, y: -60))
        bmb2.customButtonPlacePositions.append(CGPoint.init(x: 0, y: 0))
        bmb2.customButtonPlacePositions.append(CGPoint.init(x: +60, y: +60))
    }
    
    func initializeBmb3() {
        bmb3.buttonEnum = .textOutsideCircle
        bmb3.piecePlaceEnum = .share
        bmb3.buttonPlaceEnum = .custom
        for _ in 0..<12 {
            bmb3.addBuilder(BuilderManager.textOutsideCircleButtonBuilderWithDifferentPieceColor())
        }
        
        let w: CGFloat = 80
        let h: CGFloat = 96
        let h_0_5: CGFloat = h / 2
        let h_1_5: CGFloat = h * 1.5
        
        let hm: CGFloat = bmb3.buttonHorizontalMargin
        let vm: CGFloat = bmb3.buttonVerticalMargin
        let vm_0_5: CGFloat = vm / 2
        let vm_1_5: CGFloat = vm * 1.5
        
        bmb3.customButtonPlacePositions.append(CGPoint.init(x: -w - hm, y: -h_1_5 - vm_1_5))
        bmb3.customButtonPlacePositions.append(CGPoint.init(x:       0, y: -h_1_5 - vm_1_5))
        bmb3.customButtonPlacePositions.append(CGPoint.init(x: +w + hm, y: -h_1_5 - vm_1_5))
        bmb3.customButtonPlacePositions.append(CGPoint.init(x: -w - hm, y: -h_0_5 - vm_0_5))
        bmb3.customButtonPlacePositions.append(CGPoint.init(x:       0, y: -h_0_5 - vm_0_5))
        bmb3.customButtonPlacePositions.append(CGPoint.init(x: +w + hm, y: -h_0_5 - vm_0_5))
        bmb3.customButtonPlacePositions.append(CGPoint.init(x: -w - hm, y: +h_0_5 + vm_0_5))
        bmb3.customButtonPlacePositions.append(CGPoint.init(x:       0, y: +h_0_5 + vm_0_5))
        bmb3.customButtonPlacePositions.append(CGPoint.init(x: +w + hm, y: +h_0_5 + vm_0_5))
        bmb3.customButtonPlacePositions.append(CGPoint.init(x: -w - hm, y: +h_1_5 + vm_1_5))
        bmb3.customButtonPlacePositions.append(CGPoint.init(x:       0, y: +h_1_5 + vm_1_5))
        bmb3.customButtonPlacePositions.append(CGPoint.init(x: +w + hm, y: +h_1_5 + vm_1_5))
    }
    
    func initializeBmb4() {
        bmb4.buttonEnum = .textInsideCircle
        bmb4.piecePlaceEnum = .custom
        bmb4.buttonPlaceEnum = .custom
        for _ in 0..<3 {
            bmb4.addBuilder(BuilderManager.textInsideCircleButtonBuilder())
        }
        
        bmb4.customPiecePlacePositions.append(CGPoint.init(x: +6, y: -6))
        bmb4.customPiecePlacePositions.append(CGPoint.init(x: 0, y: 0))
        bmb4.customPiecePlacePositions.append(CGPoint.init(x: -6, y: +6))
        
        bmb4.customButtonPlacePositions.append(CGPoint.init(x: -60, y: -60))
        bmb4.customButtonPlacePositions.append(CGPoint.init(x: 0, y: 0))
        bmb4.customButtonPlacePositions.append(CGPoint.init(x: +60, y: +60))
    }

}
