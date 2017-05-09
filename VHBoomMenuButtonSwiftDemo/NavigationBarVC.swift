//
//  NavigationBarVC.swift
//  VHBoomMenuButtonSwiftDemo
//
//  Created by Nightonke on 2017/5/4.
//  Copyright © 2017 Nightonke. All rights reserved.
//

import UIKit
import BoomMenuButton

class NavigationBarVC: BoomMenuButtonVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        let bmb1: BoomMenuButton = BoomMenuButton.init(frame: CGRect.init(x: 0, y: 0, width: 44, height: 44))
        bmb1.buttonEnum = .textOutsideCircle
        bmb1.piecePlaceEnum = .dot_9_1
        bmb1.buttonPlaceEnum = .sc_9_1
        bmb1.hasBackground = false
        bmb1.duration = 1
        for _ in 0..<bmb1.piecePlaceEnum.pieceNumber() {
            bmb1.addBuilder(BuilderManager.textOutsideCircleButtonBuilderWithDifferentPieceColor())
        }
        
        let bmb2: BoomMenuButton = BoomMenuButton.init(frame: CGRect.init(x: 44, y: 0, width: 44, height: 44))
        bmb2.buttonEnum = .ham
        bmb2.piecePlaceEnum = .ham_4
        bmb2.buttonPlaceEnum = .ham_4
        bmb2.hasBackground = false
        bmb2.duration = 1
        bmb2.boomEaseName = Ease.outCubic
        bmb2.reboomEaseName = Ease.outCubic
        for _ in 0..<bmb2.piecePlaceEnum.pieceNumber() {
            bmb2.addBuilder(BuilderManager.hamButtonBuilderWithDifferentPieceColor())
        }
        
        let nagativeSpacer: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        nagativeSpacer.width = -16
        
        let bmbs: UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 88, height: 44))
        bmbs.addSubview(bmb1)
        bmbs.addSubview(bmb2)
        
        self.navigationItem.rightBarButtonItems = [nagativeSpacer, UIBarButtonItem.init(customView: bmbs)]
    }

}
