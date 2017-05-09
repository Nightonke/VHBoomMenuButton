//
//  ShareLinesLayer.swift
//  BoomMenuButton
//
//  Created by Nightonke on 2017/4/28.
//  Copyright © 2017 Nightonke. All rights reserved.
//

import UIKit

class ShareLinesLayer: CALayer {

    @NSManaged var processForLine1: CGFloat
    @NSManaged var processForLine2: CGFloat
    
    override init() {
        super.init()
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
        
        if let shareLinesLayer = layer as? ShareLinesLayer {
            processForLine1 = shareLinesLayer.processForLine1
            processForLine2 = shareLinesLayer.processForLine2
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("ShareLinesLayer does not support NSCoding")
    }
    
    static func isCustomAnimKey(_ key: String) -> Bool {
        return key == "processForLine1" || key == "processForLine2"
    }
    
    class override func needsDisplay(forKey key: String) -> Bool {
        if isCustomAnimKey(key) {
            return true
        } else {
            return super.needsDisplay(forKey: key)
        }
    }
    
    override func action(forKey event: String) -> CAAction? {
        if ShareLinesLayer.isCustomAnimKey(event) {
            if let animation = super.action(forKey: "backgroundColor") as? CABasicAnimation {
                animation.keyPath = event
                if let pLayer = presentation() {
                    if event == "processForLine1" {
                        animation.fromValue = pLayer.processForLine1
                    } else if event == "processForLine2" {
                        animation.fromValue = pLayer.processForLine2
                    }
                }
                animation.toValue = nil
                return animation
            }
            setNeedsDisplay()
            return nil
        }
        return super.action(forKey: event)
    }
    
    override func draw(in ctx: CGContext) {
        super.draw(in: ctx)
    }
    
}
