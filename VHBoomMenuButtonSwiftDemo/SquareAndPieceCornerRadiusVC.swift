//
//  SquareAndPieceCornerRadiusVC.swift
//  VHBoomMenuButtonSwiftDemo
//
//  Created by viktorhuang on 2017/5/4.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

import UIKit
import BoomMenuButton

class SquareAndPieceCornerRadiusVC: BoomMenuButtonVC {

    @IBOutlet weak var bmb1: BoomMenuButton!
    @IBOutlet weak var bmb2: BoomMenuButton!
    @IBOutlet weak var bmb3: BoomMenuButton!
    @IBOutlet weak var bmb4: BoomMenuButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bmb1.buttonEnum = .simpleCircle
        bmb1.piecePlaceEnum = .dot_9_1
        bmb1.buttonPlaceEnum = .sc_9_1
        bmb1.pieceCornerRadius = 1
        for _ in 0..<bmb1.piecePlaceEnum.pieceNumber() {
            bmb1.addBuilder(BuilderManager.squareSimpleCircleButtonBuilder())
        }
        
        bmb2.buttonEnum = .textInsideCircle
        bmb2.piecePlaceEnum = .dot_9_1
        bmb2.buttonPlaceEnum = .sc_9_1
        bmb2.pieceCornerRadius = 2
        for _ in 0..<bmb2.piecePlaceEnum.pieceNumber() {
            bmb2.addBuilder(BuilderManager.squareTextInsideCircleButtonBuilder())
        }
        
        bmb3.buttonEnum = .textOutsideCircle
        bmb3.piecePlaceEnum = .dot_9_1
        bmb3.buttonPlaceEnum = .sc_9_1
        bmb3.pieceCornerRadius = 0
        for _ in 0..<bmb3.piecePlaceEnum.pieceNumber() {
            bmb3.addBuilder(BuilderManager.squareTextOutsideCircleButtonBuilder())
        }
        
        bmb4.buttonEnum = .ham
        bmb4.piecePlaceEnum = .ham_4
        bmb4.buttonPlaceEnum = .ham_4
        bmb4.pieceCornerRadius = 1.5
        for _ in 0..<bmb4.piecePlaceEnum.pieceNumber() {
            bmb4.addBuilder(BuilderManager.hamButtonBuilder())
        }
    }

}
