//
//  FadeViewsVC.swift
//  VHBoomMenuButtonSwiftDemo
//
//  Created by Nightonke on 2017/5/8.
//  Copyright © 2017 Nightonke. All rights reserved.
//

import UIKit
import BoomMenuButton

class FadeViewsVC: BoomMenuButtonVC {

    @IBOutlet weak var bmb1: BoomMenuButton!
    @IBOutlet weak var bmb2: BoomMenuButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializeBmb1()
        initializeBmb2()
    }
    
    func initializeBmb1() {
        bmb1.buttonEnum = .simpleCircle
        bmb1.piecePlaceEnum = .dot_9_1
        bmb1.buttonPlaceEnum = .sc_9_1
        for _ in 0..<bmb1.piecePlaceEnum.pieceNumber() {
            bmb1.addBuilder(BuilderManager.simpleCircleButtonBuilder())
        }
        bmb1.dotRadius = 0
        bmb1.draggable = true
        
        let imageView: UIImageView = UIImageView.init(frame: CGRect.init(x: 10, y: 10, width: 40, height: 40))
        imageView.image = UIImage.init(named: BuilderManager.imageName())
        bmb1.addFadeView(imageView)
    }
    
    func initializeBmb2() {
        bmb2.buttonEnum = .ham
        bmb2.piecePlaceEnum = .ham_4
        bmb2.buttonPlaceEnum = .ham_4
        for _ in 0..<bmb2.piecePlaceEnum.pieceNumber() {
            bmb2.addBuilder(BuilderManager.hamButtonBuilderWithDifferentPieceColor())
        }
        bmb2.hamWidth = 0
        bmb2.hamHeight = 0
        bmb2.draggable = true
        
        let imageView: UIImageView = UIImageView.init(frame: CGRect.init(x: 10, y: 8, width: 40, height: 40))
        imageView.image = UIImage.init(named: BuilderManager.imageName())
        bmb2.addFadeView(imageView)
        
        let label: UILabel = UILabel.init(frame: CGRect.init(x: 10, y: 42, width: 40, height: 10))
        label.font = UIFont.systemFont(ofSize: 8)
        label.text = "BOOM!"
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        bmb2.addFadeView(label)
    }
}
