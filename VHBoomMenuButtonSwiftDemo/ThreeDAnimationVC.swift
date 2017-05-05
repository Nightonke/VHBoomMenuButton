//
//  ThreeDAnimationVC.swift
//  VHBoomMenuButtonSwiftDemo
//
//  Created by viktorhuang on 2017/5/5.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

import UIKit
import BoomMenuButton

class ThreeDAnimationVC: BoomMenuButtonVC {

    @IBOutlet weak var bmb1: BoomMenuButton!
    @IBOutlet weak var bmb2: BoomMenuButton!
    @IBOutlet weak var bmb3: BoomMenuButton!
    
    @IBOutlet weak var threeDAnimationSwitch: UISwitch!
    @IBOutlet weak var durationSlider: UISlider!
    @IBOutlet weak var durationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bmb1.buttonEnum = .simpleCircle
        bmb1.piecePlaceEnum = .dot_9_1
        bmb1.buttonPlaceEnum = .sc_9_1
        bmb1.draggable = true
        bmb1.edgeInsetsInSuperView.top += 66
        bmb1.pieceCornerRadius = 1
        for _ in 0..<bmb1.piecePlaceEnum.pieceNumber() {
            bmb1.addBuilder(BuilderManager.squareSimpleCircleButtonBuilder())
        }
        
        bmb2.buttonEnum = .ham
        bmb2.piecePlaceEnum = .ham_4
        bmb2.buttonPlaceEnum = .ham_4
        bmb2.draggable = true
        bmb2.edgeInsetsInSuperView.top += 66
        for _ in 0..<bmb2.piecePlaceEnum.pieceNumber() {
            bmb2.addBuilder(BuilderManager.hamButtonBuilderWithDifferentPieceColor())
        }
        
        bmb3.buttonEnum = .textOutsideCircle
        bmb3.piecePlaceEnum = .dot_9_1
        bmb3.buttonPlaceEnum = .sc_9_1
        bmb3.draggable = true
        bmb3.edgeInsetsInSuperView.top += 66
        for _ in 0..<bmb3.piecePlaceEnum.pieceNumber() {
            bmb3.addBuilder(BuilderManager.textOutsideCircleButtonBuilder())
        }
    }

    @IBAction func onThreeDAnimationSwitchValueChanged(_ sender: UISwitch) {
        bmb1.use3DTransformAnimation = sender.isOn
        bmb2.use3DTransformAnimation = sender.isOn
        bmb3.use3DTransformAnimation = sender.isOn
    }

    @IBAction func onSliderValueChanged(_ sender: UISlider) {
        durationLabel.text = String.init(format: "Show/Hide duration = %.0lf ms", sender.value)
        bmb1.duration = CFTimeInterval(sender.value / 1000)
        bmb2.duration = CFTimeInterval(sender.value / 1000)
        bmb3.duration = CFTimeInterval(sender.value / 1000)
    }
}
