//
//  BlurBackgroundAndTipVC.swift
//  VHBoomMenuButtonSwiftDemo
//
//  Created by viktorhuang on 2017/5/5.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

import UIKit
import BoomMenuButton

class BlurBackgroundAndTipVC: BoomMenuButtonVC {

    @IBOutlet weak var bmb1: BoomMenuButton!
    @IBOutlet weak var bmb2: BoomMenuButton!
    @IBOutlet weak var bmb3: BoomMenuButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bmb1.buttonEnum = .simpleCircle
        bmb1.piecePlaceEnum = .dot_9_1
        bmb1.buttonPlaceEnum = .sc_9_1
        bmb1.pieceCornerRadius = 1
        bmb1.backgroundBlurred = true
        bmb1.blurEffect = UIBlurEffect.init(style: UIBlurEffectStyle.extraLight)
        bmb1.tip = "Select an animal to feed!"
        bmb1.tipButtonMargin = 30
        bmb1.tipLabel().textColor = UIColor.darkGray
        for _ in 0..<bmb1.piecePlaceEnum.pieceNumber() {
            bmb1.addBuilder(BuilderManager.squareSimpleCircleButtonBuilder())
        }
        
        bmb2.buttonEnum = .ham
        bmb2.piecePlaceEnum = .ham_4
        bmb2.buttonPlaceEnum = .ham_4
        bmb2.backgroundBlurred = true
        bmb2.blurEffect = UIBlurEffect.init(style: UIBlurEffectStyle.dark)
        bmb2.tip = "Nightonke BMB"
        for _ in 0..<bmb2.piecePlaceEnum.pieceNumber() {
            bmb2.addBuilder(BuilderManager.hamButtonBuilderWithDifferentPieceColor())
        }
        
        bmb3.buttonEnum = .textOutsideCircle
        bmb3.piecePlaceEnum = .dot_9_1
        bmb3.buttonPlaceEnum = .sc_9_1
        bmb3.backgroundBlurred = true
        bmb3.blurEffect = UIBlurEffect.init(style: UIBlurEffectStyle.light)
        bmb3.tip = "Select an animal to feed"
        bmb3.tipLabel().textColor = UIColor.darkGray
        bmb3.tipLabel().font = UIFont.systemFont(ofSize: 15)
        for _ in 0..<bmb3.piecePlaceEnum.pieceNumber() {
            let builder = BuilderManager.textOutsideCircleButtonBuilder()
            builder.normalTextColor = UIColor.darkGray
            builder.highlightedTextColor = UIColor.lightGray
            bmb3.addBuilder(builder)
        }
    }
}
