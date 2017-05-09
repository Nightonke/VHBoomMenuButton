//
//  ChangeBoomButtonVC.swift
//  VHBoomMenuButtonSwiftDemo
//
//  Created by Nightonke on 2017/5/5.
//  Copyright © 2017 Nightonke. All rights reserved.
//

import UIKit
import BoomMenuButton

class ChangeBoomButtonVC: BoomMenuButtonVC, BoomDelegate {

    @IBOutlet weak var bmb: BoomMenuButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bmb.buttonEnum = .ham
        bmb.piecePlaceEnum = .ham_5
        bmb.buttonPlaceEnum = .ham_5
        bmb.boomDelegate = self
        bmb.autoHide = false
        
        var builder = BuilderManager.hamButtonBuilder(withText: "Change Text", withSubText: "...")
        bmb.addBuilder(builder)
        
        builder = BuilderManager.hamButtonBuilder(withText: "Change Image", withSubText: "...")
        builder.normalImageName = "eagle"
        bmb.addBuilder(builder)
        
        builder = BuilderManager.hamButtonBuilder(withText: "Change Color", withSubText: "...")
        builder.normalColor = UIColor.blue
        bmb.addBuilder(builder)
        
        builder = BuilderManager.hamButtonBuilder(withText: "Change Piece Color", withSubText: "...")
        bmb.addBuilder(builder)
        
        builder = BuilderManager.hamButtonBuilder(withText: "Change Unable", withSubText: "...")
        builder.unableColor = UIColor.gray
        builder.unableImageName = "butterfly"
        builder.unableText = "Unable!"
        bmb.addBuilder(builder)
    }
    
    func boomMenuButton(_ bmb: BoomMenuButton, didClickBoomButtonOfBuilder builder: BoomButtonBuilder, at index: Int) {
        if let hamBuilder = builder as? HamButtonBuilder {
            switch index {
            case 0:
                hamBuilder.normalText = "Changed!"
                hamBuilder.highlightedText = "Highlighted, changed!"
                hamBuilder.normalSubText = "Sub-text, changed!"
                hamBuilder.normalTextColor = UIColor.yellow
                hamBuilder.highlightedColor = UIColor.purple
                hamBuilder.normalSubTextColor = UIColor.black
            case 1:
                hamBuilder.normalImageName = "bat"
                hamBuilder.highlightedImageName = "bear"
            case 2:
                hamBuilder.normalColor = UIColor.red
            case 3:
                hamBuilder.pieceColor = UIColor.white
            case 4:
                hamBuilder.unable = true
            default:
                break
            }
        }
    }

}
