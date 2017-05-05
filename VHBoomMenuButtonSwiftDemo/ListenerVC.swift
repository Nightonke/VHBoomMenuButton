//
//  ListenerVC.swift
//  VHBoomMenuButtonSwiftDemo
//
//  Created by viktorhuang on 2017/5/5.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

import UIKit
import BoomMenuButton

class ListenerVC: BoomMenuButtonVC, BoomDelegate {

    @IBOutlet weak var buttonLabel: UILabel!
    @IBOutlet weak var animationLabel: UILabel!
    
    @IBOutlet weak var bmb: BoomMenuButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bmb.buttonEnum = .simpleCircle
        bmb.piecePlaceEnum = .dot_6_3
        bmb.buttonPlaceEnum = .sc_6_3
        bmb.boomDelegate = self
        for _ in 0..<bmb.piecePlaceEnum.pieceNumber() {
            addBuilder()
        }
    }

    func addBuilder() {
        let builder = BuilderManager.simpleCircleButtonBuilder()
        builder.clickedClosure = { [weak self] (index: Int) -> Void in
            self?.buttonLabel.text = String.init(format: "No.%d boom-button is clicked!", index)
        }
        bmb.addBuilder(builder)
    }
    
    // MARK: - BoomDelegate
    
    func boomMenuButton(_ bmb: BoomMenuButton, didClickBoomButtonOfBuilder builder: BoomButtonBuilder, at index: Int) {
        // If you have implement clickedClosures for boom-buttons in builders,
        // then you shouldn't add any listener here for duplicate callbacks.
        // buttonLabel.text = builder.normalImageName
    }
    
    func boomMenuButtonDidClickBackground(boomMenuButton bmb: BoomMenuButton) {
        animationLabel.text = "Click background!!!"
    }
    
    func boomMenuButtonWillReboom(boomMenuButton bmb: BoomMenuButton) {
        animationLabel.text = "Will RE-BOOM!!!";
    }
    
    func boomMenuButtonDidReboom(boomMenuButton bmb: BoomMenuButton) {
        animationLabel.text = "Did RE-BOOM!!!"
    }
    
    func boomMenuButtonWillBoom(boomMenuButton bmb: BoomMenuButton) {
        animationLabel.text = "Will BOOM!!!"
    }
    
    func boomMenuButtonDidBoom(boomMenuButton bmb: BoomMenuButton) {
        animationLabel.text = "Did BOOM!!!"
    }
}
