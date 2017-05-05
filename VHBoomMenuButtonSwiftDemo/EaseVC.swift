//
//  EaseVC.swift
//  VHBoomMenuButtonSwiftDemo
//
//  Created by viktorhuang on 2017/5/4.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

import UIKit
import BoomMenuButton

class EaseVC: BoomMenuButtonVC {

    @IBOutlet weak var bmb1: BoomMenuButton!
    @IBOutlet weak var bmb2: BoomMenuButton!
    @IBOutlet weak var bmb3: BoomMenuButton!
    @IBOutlet weak var bmb4: BoomMenuButton!
    @IBOutlet weak var bmb5: BoomMenuButton!
    @IBOutlet weak var bmb6: BoomMenuButton!
    @IBOutlet weak var bmb7: BoomMenuButton!
    @IBOutlet weak var bmb8: BoomMenuButton!
    @IBOutlet weak var bmb9: BoomMenuButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize(boomMenuButton: bmb1)
        initialize(boomMenuButton: bmb2)
        initialize(boomMenuButton: bmb3)
        initialize(boomMenuButton: bmb4)
        initialize(boomMenuButton: bmb5)
        initialize(boomMenuButton: bmb6)
        initialize(boomMenuButton: bmb7)
        initialize(boomMenuButton: bmb8)
        initialize(boomMenuButton: bmb9)

        bmb1.boomDuration = 1
        bmb1.reboomDuration = 0.5
        
        bmb2.boomEaseName = Ease.outExpo
        bmb2.reboomEaseName = Ease.inExpo
        
        bmb3.boomEaseName = Ease.outBounce
        bmb3.reboomEaseName = Ease.outBounce
        
        bmb4.boomEaseName = Ease.outElastic
        bmb4.reboomEaseName = Ease.inElastic
        bmb4.delay = 0
        
        bmb5.boomEaseName = Ease.inSine
        bmb5.reboomEaseName = Ease.inSine
        
        bmb6.boomEaseName = Ease.inCirc
        bmb6.reboomEaseName = Ease.inCirc
        
        bmb7.boomEaseName = Ease.outCirc
        bmb7.reboomEaseName = Ease.outCirc
        
        bmb8.boomMoveEaseName = Ease.inBack
        bmb8.boomRotateEaseName = Ease.inBack
        bmb8.boomScaleEaseName = Ease.linear
        bmb8.reboomMoveEaseName = Ease.inBack
        bmb8.reboomRotateEaseName = Ease.inBack
        bmb8.reboomScaleEaseName = Ease.inBack
        
        bmb9.boomEaseName = Ease.inOutQuad
        bmb9.reboomEaseName = Ease.inOutQuad
        bmb9.delay = 0
    }

    func initialize(boomMenuButton bmb: BoomMenuButton) {
        bmb.buttonEnum = .simpleCircle
        bmb.piecePlaceEnum = .dot_9_1
        bmb.buttonPlaceEnum = .sc_9_1
        for _ in 0..<bmb.piecePlaceEnum.pieceNumber() {
            bmb.addBuilder(BuilderManager.simpleCircleButtonBuilder())
        }
    }

}
