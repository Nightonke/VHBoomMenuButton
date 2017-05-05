//
//  DraggableVC.swift
//  VHBoomMenuButtonSwiftDemo
//
//  Created by viktorhuang on 2017/5/4.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

import UIKit
import BoomMenuButton

class DraggableVC: BoomMenuButtonVC {

    @IBOutlet weak var bmb: BoomMenuButton!
    
    @IBOutlet weak var draggableSwitch: UISwitch!
    @IBOutlet weak var hasBackgroundSwitch: UISwitch!
    @IBOutlet weak var hasShadowSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Prevent the bmbs being dragged behind navigation bar.
        bmb.edgeInsetsInSuperView.top += 66
        
        bmb.buttonEnum = .simpleCircle
        bmb.piecePlaceEnum = .dot_9_1
        bmb.buttonPlaceEnum = .sc_9_1
        for _ in 0..<bmb.piecePlaceEnum.pieceNumber() {
            bmb.addBuilder(BuilderManager.simpleCircleButtonBuilder())
        }
    }

    @IBAction func onSwitchValueChanged(_ sender: UISwitch) {
        if sender == draggableSwitch {
            bmb.draggable = sender.isOn
        } else if sender == hasBackgroundSwitch {
            bmb.hasBackground = sender.isOn
        } else if sender == hasShadowSwitch {
            bmb.hasShadow = sender.isOn
        }
    }
}
