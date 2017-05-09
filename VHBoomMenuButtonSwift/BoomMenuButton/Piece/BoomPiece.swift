//
//  BoomPiece.swift
//  BoomMenuButton
//
//  Created by Nightonke on 2017/4/28.
//  Copyright © 2017 Nightonke. All rights reserved.
//

import UIKit

class BoomPiece: UIView {

    var isTop = false
    var pieceBelow: BoomPiece?

    init(frame: CGRect, builder: BoomButtonBuilder, cornerRadius: CGFloat) {
        super.init(frame: frame)
        layer.allowsEdgeAntialiasing = true
        if cornerRadius >= 0 {
            layer.cornerRadius = cornerRadius
        } else {
            if builder.type() == ButtonEnum.ham {
                layer.cornerRadius = 0
            } else {
                layer.cornerRadius = frame.size.width / 2
            }
        }
        layer.backgroundColor = builder.innerPieceColor().cgColor
        builder.piece = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("BoomPiece does not support NSCoding")
    }
    
    override var backgroundColor: UIColor? {
        get {
            return nil
        }
        set {
            // We just do nothing here because when BMB is used in TableView.
            // If the tableView is selected, the background color of all its subviews will be changed.
        }
    }
    
    func setColor(color: UIColor) {
        layer.backgroundColor = color.cgColor
    }
}
