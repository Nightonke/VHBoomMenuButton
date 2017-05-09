//
//  ShareLinesView.swift
//  BoomMenuButton
//
//  Created by Nightonke on 2017/4/28.
//  Copyright © 2017 Nightonke. All rights reserved.
//

import UIKit

class ShareLinesView: UIView {

    var line1Color: UIColor = UIColor.white {
        didSet {
            if !Utils.isSameColor(line1Color, oldValue) {
                setNeedsDisplay()
            }
        }
    }
    
    var line2Color: UIColor = UIColor.white {
        didSet {
            if !Utils.isSameColor(line2Color, oldValue) {
                setNeedsDisplay()
            }
        }
    }
    
    var lineWidth: CGFloat = 1.5 {
        didSet {
            if lineWidth != oldValue {
                setNeedsDisplay()
            }
        }
    }
    
    override class var layerClass: AnyClass {
        return ShareLinesLayer.self
    }
    
    var processForLine1: CGFloat {
        set {
            if let layer = layer as? ShareLinesLayer {
                layer.processForLine1 = newValue
            }
        }
        get {
            if let layer = layer as? ShareLinesLayer {
                return layer.processForLine1
            }
            return CGFloat(0)
        }
    }
    
    var processForLine2: CGFloat {
        set {
            if let layer = layer as? ShareLinesLayer {
                layer.processForLine2 = newValue
            }
        }
        get {
            if let layer = layer as? ShareLinesLayer {
                return layer.processForLine2
            }
            return CGFloat(0)
        }
    }
    
    private var piecePositions: [CGPoint]?
    
    private var pieceNumbers: [Int] = Array<Int>.init(repeating: 0, count: 3)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        processForLine1 = 1
        processForLine2 = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("ShareLinesView does not support NSCoding")
    }
    
    func set(piecePositions: [CGRect], dotRadius: CGFloat) {
        let xOffset: CGFloat = dotRadius - lineWidth / CGFloat(4)
        let yOffset: CGFloat = dotRadius - lineWidth * CGFloat(sqrt(3) / 4) + CGFloat(0.5)
        
        self.piecePositions = [CGPoint]()
        for piecePositionValue in piecePositions {
            var exist: Bool = false
            let piecePosition: CGPoint = piecePositionValue.origin
            for value in self.piecePositions! {
                if value == piecePosition {
                    exist = true
                    break
                }
            }
            if !exist {
                self.piecePositions?.append(piecePosition)
            }
        }
        for i in self.piecePositions!.indices {
            self.piecePositions![i].x += xOffset
            self.piecePositions![i].y += yOffset
        }
        
        var pieceNumbers: [Int] = Array<Int>.init(repeating: 0, count: 3)
        for i in 0..<piecePositions.count {
            pieceNumbers[i % 3] += 1
        }
        self.pieceNumbers = Array<Int>.init(repeating: 0, count: 3)
        self.pieceNumbers[0] = pieceNumbers[0]
        self.pieceNumbers[1] = pieceNumbers[0] + pieceNumbers[1]
        self.pieceNumbers[2] = pieceNumbers[0] + pieceNumbers[1] + pieceNumbers[2]
        
        setNeedsDisplay()
    }
    
    func pieceStartShowAnimation(atIndex index: Int, withDuration duration: CFTimeInterval) {
        if index == pieceNumbers[0] - 1 {
            // The lowest piece on the top-right position starts show-animation
            processForLine1 = 1
            UIView.animate(withDuration: duration,
                           delay: 0,
                           options: UIViewAnimationOptions.curveLinear,
                           animations: { 
                            self.processForLine1 = 0
            }, completion: nil)
        } else if index == pieceNumbers[1] - 1 {
            // The lowest piece on the middle-left position starts show-animation
            processForLine2 = 1
            UIView.animate(withDuration: duration,
                           delay: 0,
                           options: UIViewAnimationOptions.curveLinear,
                           animations: {
                            self.processForLine2 = 0
            }, completion: nil)
        }
    }
    
    func pieceFinishHideAnimation(atIndex index: Int, withDuration duration: CFTimeInterval) {
        if index == pieceNumbers[1] {
            // The highest piece on the bottom-right position finishes hide-animation
            processForLine2 = 0
            UIView.animate(withDuration: duration,
                           delay: 0,
                           options: UIViewAnimationOptions.curveLinear,
                           animations: {
                            self.processForLine2 = 1
            }, completion: nil)
        } else if index == pieceNumbers[0] {
            // The highest piece on the middle-left position finishes hide-animation
            processForLine1 = 0
            UIView.animate(withDuration: duration,
                           delay: 0,
                           options: UIViewAnimationOptions.curveLinear,
                           animations: {
                            self.processForLine1 = 1
            }, completion: nil)
        }
    }
    
    override func draw(_ rect: CGRect) {
        let processForLine1: CGFloat
        let processForLine2: CGFloat
        if let l = layer.presentation() as? ShareLinesLayer {
            processForLine1 = l.processForLine1
            processForLine2 = l.processForLine2
        } else {
            processForLine1 = CGFloat(1)
            processForLine2 = CGFloat(1)
        }
        if piecePositions == nil || piecePositions!.count < 3 {
            return
        }
        
        let point0 = piecePositions?[0]  // top-right
        let point1 = piecePositions?[1]  // middle-left
        let point2 = piecePositions?[2]  // bottom-right
        
        if let context = UIGraphicsGetCurrentContext() {
            context.setAllowsAntialiasing(true)
            context.setShouldAntialias(true)
            
            context.setLineWidth(lineWidth)
            context.setStrokeColor(line1Color.cgColor)
            context.move(to: point1!)
            context.addLine(to: CGPoint.init(x: (point0!.x - point1!.x) * processForLine1 + point1!.x,
                                             y: (point0!.y - point1!.y) * processForLine1 + point1!.y))
            context.strokePath()
            
            context.setStrokeColor(line2Color.cgColor)
            context.move(to: point2!)
            context.addLine(to: CGPoint.init(x: (point1!.x - point2!.x) * processForLine2 + point2!.x,
                                             y: (point1!.y - point2!.y) * processForLine2 + point2!.y))
            context.strokePath()
        }
    }
}
