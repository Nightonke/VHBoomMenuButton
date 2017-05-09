//
//  ShareVC.swift
//  VHBoomMenuButtonSwiftDemo
//
//  Created by Nightonke on 2017/5/5.
//  Copyright © 2017 Nightonke. All rights reserved.
//

import UIKit
import BoomMenuButton

class ShareVC: BoomMenuButtonVC {
    
    @IBOutlet weak var boomDelaySlider: UISlider!
    @IBOutlet weak var boomDurationSlider: UISlider!
    @IBOutlet weak var reboomDelaySlider: UISlider!
    @IBOutlet weak var reboomDurationSlider: UISlider!
    
    @IBOutlet weak var boomDelayLabel: UILabel!
    @IBOutlet weak var boomDurationLabel: UILabel!
    @IBOutlet weak var reboomDelayLabel: UILabel!
    @IBOutlet weak var reboomDurationLabel: UILabel!
    
    @IBOutlet weak var bmb1: BoomMenuButton!
    @IBOutlet weak var bmb2: BoomMenuButton!
    @IBOutlet weak var bmb3: BoomMenuButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        initialize(boomMenuButton: bmb1, withDifferentPieceColor: false)
        initialize(boomMenuButton: bmb2, withDifferentPieceColor: true)
        initialize(boomMenuButton: bmb3, withDifferentPieceColor: false)
        
        bmb1.shareLineLength = 25
        bmb1.shareLineWidth = 3
        bmb1.dotRadius = 6
                
        bmb3.shareLine1Color = UIColor.black
        bmb3.shareLine2Color = UIColor.black
        
        onSliderValueChanged(boomDelaySlider)
        onSliderValueChanged(boomDurationSlider)
        onSliderValueChanged(reboomDelaySlider)
        onSliderValueChanged(reboomDurationSlider)
    }
    
    func initialize(boomMenuButton bmb: BoomMenuButton, withDifferentPieceColor isDifferentPieceColor: Bool) {
        bmb.buttonEnum = .textInsideCircle
        bmb.piecePlaceEnum = .share
        bmb.buttonPlaceEnum = .sc_9_1
        // Notice that you should use 'bmb.buttonPlaceEnum.buttonNumber()' as a loop number.
        // Because 'bmb.piecePlaceEnum.pieceNumber()' could NOT know the number of the pieces
        // when the piece-place-enum is Share.
        for _ in 0..<bmb.buttonPlaceEnum.buttonNumber() {
            if isDifferentPieceColor {
                bmb.addBuilder(BuilderManager.textInsideCircleButtonBuilderWithDifferentPieceColor())
            } else {
                bmb.addBuilder(BuilderManager.textInsideCircleButtonBuilder())
            }
        }
    }

    @IBAction func onSliderValueChanged(_ sender: UISlider) {
        if sender == boomDelaySlider {
            boomDelayLabel.text = String.init(format: "Boom delay = %.0lf ms", sender.value)
            bmb1.boomDelay = CFTimeInterval(sender.value / 1000)
            bmb2.boomDelay = CFTimeInterval(sender.value / 1000)
            bmb3.boomDelay = CFTimeInterval(sender.value / 1000)
        } else if sender == boomDurationSlider {
            boomDurationLabel.text = String.init(format: "Boom duration = %.0lf ms", sender.value)
            bmb1.boomDuration = CFTimeInterval(sender.value / 1000)
            bmb2.boomDuration = CFTimeInterval(sender.value / 1000)
            bmb3.boomDuration = CFTimeInterval(sender.value / 1000)
        } else if sender == reboomDelaySlider {
            reboomDelayLabel.text = String.init(format: "Reboom delay = %.0lf ms", sender.value)
            bmb1.reboomDelay = CFTimeInterval(sender.value / 1000)
            bmb2.reboomDelay = CFTimeInterval(sender.value / 1000)
            bmb3.reboomDelay = CFTimeInterval(sender.value / 1000)
        } else if sender == reboomDurationSlider {
            reboomDurationLabel.text = String.init(format: "Reboom duration = %.0lf ms", sender.value)
            bmb1.reboomDuration = CFTimeInterval(sender.value / 1000)
            bmb2.reboomDuration = CFTimeInterval(sender.value / 1000)
            bmb3.reboomDuration = CFTimeInterval(sender.value / 1000)
        }
    }
}
