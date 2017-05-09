//
//  ControlVC.swift
//  VHBoomMenuButtonSwiftDemo
//
//  Created by Nightonke on 2017/5/5.
//  Copyright © 2017 Nightonke. All rights reserved.
//

import UIKit
import BoomMenuButton

class ControlVC: BoomMenuButtonVC {

    @IBOutlet weak var boomButton: UIButton!
    @IBOutlet weak var reboomButton: UIButton!
    @IBOutlet weak var boomImmediatelyButton: UIButton!
    @IBOutlet weak var reboomImmediatelyButton: UIButton!
    
    @IBOutlet weak var bmb: BoomMenuButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bmb.buttonEnum = .simpleCircle
        bmb.piecePlaceEnum = .dot_9_1
        bmb.buttonPlaceEnum = .sc_9_1
        bmb.isBoomInWholeScreen = false
        for _ in 0..<bmb.piecePlaceEnum.pieceNumber() {
            bmb.addBuilder(BuilderManager.simpleCircleButtonBuilder())
        }
    }

    @IBAction func onButtonClicked(_ sender: UIButton) {
        if sender == boomButton {
            bmb.boom()
        } else if sender == reboomButton {
            bmb.reboom()
        } else if sender == boomImmediatelyButton {
            bmb.boomImmediately()
        } else if sender == reboomImmediatelyButton {
            bmb.reboomImmediately()
        }
    }
}
