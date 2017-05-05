//
//  AnimationManager.swift
//  BoomMenuButton
//
//  Created by viktorhuang on 2017/4/27.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

import UIKit

class AnimationManager: NSObject {
    
    private static let showColorAnimationFunction = CAMediaTimingFunction.init(controlPoints: 0.78, 1.04, 0.12, 0.99)
    private static let hideColorAnimationFunction = CAMediaTimingFunction.init(controlPoints: 1, 0, 0.32, 0)
    
    // MARK: - Public Methods
    
    static func animate(_ keyPath: String!,
                        delay: CFTimeInterval,
                        duration: CFTimeInterval,
                        values: [Any]) -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation.init(keyPath: keyPath)
        animation.beginTime = CACurrentMediaTime() + delay
        animation.duration = duration
        animation.values = values
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        return animation
    }
    
    static func animate(_ keyPath: String!,
                        delay: CFTimeInterval,
                        duration: CFTimeInterval,
                        ease: Ease,
                        frames: Int,
                        start: CGFloat,
                        end: CGFloat) -> CAKeyframeAnimation {
        return AnimationManager.animate(keyPath, delay: delay, duration: duration,
                                        values: AnimationManager.values(ease: ease, frames: frames, start: start, end: end))
    }
    
    static func boomColorAnimation(_ KeyPath: String!,
                                   delay: CFTimeInterval,
                                   duration: CFTimeInterval,
                                   start: UIColor,
                                   end: UIColor) -> CABasicAnimation {
        let colorAnimation = CABasicAnimation.init(keyPath: KeyPath)
        colorAnimation.beginTime = CACurrentMediaTime() + delay
        colorAnimation.duration = duration
        colorAnimation.fromValue = start.cgColor
        colorAnimation.toValue = end.cgColor
        colorAnimation.isRemovedOnCompletion = false
        colorAnimation.fillMode = kCAFillModeForwards
        colorAnimation.timingFunction = showColorAnimationFunction
        return colorAnimation
    }
    
    static func reboomColorAnimation(_ KeyPath: String!,
                                     delay: CFTimeInterval,
                                     duration: CFTimeInterval,
                                     start: UIColor,
                                     end: UIColor) -> CABasicAnimation {
        let colorAnimation = CABasicAnimation.init(keyPath: KeyPath)
        colorAnimation.beginTime = CACurrentMediaTime() + delay
        colorAnimation.duration = duration
        colorAnimation.fromValue = start.cgColor
        colorAnimation.toValue = end.cgColor
        colorAnimation.isRemovedOnCompletion = false
        colorAnimation.fillMode = kCAFillModeForwards
        colorAnimation.timingFunction = hideColorAnimationFunction
        return colorAnimation
    }
    
    static func addAnimations(view: UIView?, animations: CAAnimation...) {
        guard view != nil else {
            return
        }
        if let view = view {
            for animation in animations {
                view.layer.add(animation, forKey: nil)
            }
        }
    }
    
    static func addAnimation(animation: CAAnimation?, views: [UIView]?) {
        guard animation != nil && views != nil else {
            return
        }
        for view in views! {
            view.layer.add(animation!, forKey: nil)
        }
    }
    
    static func calculateBoomXY(boomEnum: BoomEnum,
                                parentSize: CGSize,
                                ease: Ease,
                                frames: Int,
                                startPosition: CGPoint,
                                endPosition: CGPoint,
                                xValues xs: inout [CGFloat],
                                yValues ys: inout [CGFloat]) {
        var boomEnum = boomEnum
        if startPosition.x == endPosition.x {
            boomEnum = BoomEnum.straightLine
        }
        
        var x1 = startPosition.x
        var y1 = startPosition.y
        var x2 = endPosition.x
        var y2 = endPosition.y
        let p = 1.0 / CGFloat(frames)
        let xOffset = x2 - x1
        let yOffset = y2 - y1
        var offset = CGFloat(0)
        var x: CGFloat, y: CGFloat, x3: CGFloat, y3: CGFloat, a: CGFloat, b: CGFloat, c: CGFloat, offsetInFact: CGFloat
        
        switch boomEnum {
        case .straightLine:
            for i in 0...frames {
                offsetInFact = ease.interpolation(offset)
                xs[i] = x1 + offsetInFact * xOffset
                ys[i] = y1 + offsetInFact * yOffset
                offset += p
            }
        case .parabola1:
            x3 = (x1 + x2) / 2
            y3 = min(y1, y2) * 3 / 4
            a  = (y1 * (x2 - x3) + y2 * (x3 - x1) + y3 * (x1 - x2)) / (x1 * x1 * (x2 - x3) + x2 * x2 * (x3 - x1) + x3 * x3 * (x1 - x2))
            b  = (y1 - y2) / (x1 - x2) - a * (x1 + x2)
            c  = y1 - (x1 * x1) * a - x1 * b
            for i in 0...frames {
                x = x1 + ease.interpolation(offset) * xOffset
                xs[i] = x
                ys[i] = a * x * x + b * x + c
                offset += p
            }
        case .parabola2:
            x3 = (x1 + x2) / 2
            y3 = (parentSize.height + max(y1, y2)) / 2
            a  = (y1 * (x2 - x3) + y2 * (x3 - x1) + y3 * (x1 - x2)) / (x1 * x1 * (x2 - x3) + x2 * x2 * (x3 - x1) + x3 * x3 * (x1 - x2))
            b  = (y1 - y2) / (x1 - x2) - a * (x1 + x2)
            c  = y1 - (x1 * x1) * a - x1 * b
            for i in 0...frames {
                x = x1 + ease.interpolation(offset) * xOffset
                xs[i] = x
                ys[i] = a * x * x + b * x + c
                offset += p
            }
        case .parabola3:
            y3 = (y1 + y2) / 2
            x3 = min(x1, x2) / 2
            a  = (x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2)) / (y1 * y1 * (y2 - y3) + y2 * y2 * (y3 - y1) + y3 * y3 * (y1 - y2))
            b  = (x1 - x2) / (y1 - y2) - a * (y1 + y2)
            c  = x1 - (y1 * y1) * a - y1 * b
            for i in 0...frames {
                y = y1 + ease.interpolation(offset) * yOffset
                ys[i] = y
                xs[i] = a * y * y + b * y + c
                offset += p
            }
        case .parabola4:
            y3 = (y1 + y2) / 2
            x3 = (parentSize.width + max(x1, x2)) / 2
            a  = (x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2)) / (y1 * y1 * (y2 - y3) + y2 * y2 * (y3 - y1) + y3 * y3 * (y1 - y2))
            b  = (x1 - x2) / (y1 - y2) - a * (y1 + y2)
            c  = x1 - (y1 * y1) * a - y1 * b
            for i in 0...frames {
                y = y1 + ease.interpolation(offset) * yOffset
                ys[i] = y
                xs[i] = a * y * y + b * y + c
                offset += p
            }
        case .horizontalThrow1:
            x3 = x2 * 2 - x1
            y3 = y1
            a  = (y1 * (x3 - x2) + y3 * (x2 - x1) + y2 * (x1 - x3)) / (x1 * x1 * (x3 - x2) + x3 * x3 * (x2 - x1) + x2 * x2 * (x1 - x3))
            b  = (y1 - y3) / (x1 - x3) - a * (x1 + x3)
            c  = y1 - (x1 * x1) * a - x1 * b
            for i in 0...frames {
                x = x1 + ease.interpolation(offset) * xOffset
                xs[i] = x
                ys[i] = a * x * x + b * x + c
                offset += p
            }
        case .horizontalThrow2:
            x2 = startPosition.x
            y2 = startPosition.y
            x1 = endPosition.x
            y1 = endPosition.y
            x3 = x2 * 2 - x1
            y3 = y1
            a  = (y1 * (x3 - x2) + y3 * (x2 - x1) + y2 * (x1 - x3)) / (x1 * x1 * (x3 - x2) + x3 * x3 * (x2 - x1) + x2 * x2 * (x1 - x3))
            b  = (y1 - y3) / (x1 - x3) - a * (x1 + x3)
            c  = y1 - (x1 * x1) * a - x1 * b
            for i in 0...frames {
                x = x2 + ease.interpolation(offset) * xOffset
                xs[i] = x
                ys[i] = a * x * x + b * x + c
                offset += p
            }
        case .random:
            calculateBoomXY(boomEnum: BoomEnum(rawValue: arc4random() % BoomEnum.random.rawValue)!,
                            parentSize: parentSize,
                            ease: ease,
                            frames: frames,
                            startPosition: startPosition,
                            endPosition: endPosition,
                            xValues: &xs,
                            yValues: &ys)
        }
    }
    
    static func calculateReboomXY(boomEnum: BoomEnum,
                                parentSize: CGSize,
                                ease: Ease,
                                frames: Int,
                                startPosition: CGPoint,
                                endPosition: CGPoint,
                                xValues xs: inout [CGFloat],
                                yValues ys: inout [CGFloat]) {
        var boomEnum = boomEnum
        if startPosition.x == endPosition.x {
            boomEnum = BoomEnum.straightLine
        }
        
        var x1 = startPosition.x
        var y1 = startPosition.y
        var x2 = endPosition.x
        var y2 = endPosition.y
        let p = 1.0 / CGFloat(frames)
        let xOffset = x2 - x1
        var offset = CGFloat(0)
        var x: CGFloat, x3: CGFloat, y3: CGFloat, a: CGFloat, b: CGFloat, c: CGFloat
        
        switch boomEnum {
        case .straightLine, .parabola1, .parabola2, .parabola3, .parabola4, .random:
            calculateBoomXY(boomEnum: boomEnum,
                            parentSize: parentSize,
                            ease: ease,
                            frames: frames,
                            startPosition: startPosition,
                            endPosition: endPosition,
                            xValues: &xs,
                            yValues: &ys)
        case .horizontalThrow1:
            x2 = startPosition.x
            y2 = startPosition.y
            x1 = endPosition.x
            y1 = endPosition.y
            x3 = x2 * 2 - x1
            y3 = y1
            a  = (y1 * (x3 - x2) + y3 * (x2 - x1) + y2 * (x1 - x3)) / (x1 * x1 * (x3 - x2) + x3 * x3 * (x2 - x1) + x2 * x2 * (x1 - x3))
            b  = (y1 - y3) / (x1 - x3) - a * (x1 + x3)
            c  = y1 - (x1 * x1) * a - x1 * b
            for i in 0...frames {
                x = x2 + ease.interpolation(offset) * xOffset
                xs[i] = x
                ys[i] = a * x * x + b * x + c
                offset += p
            }
        case .horizontalThrow2:
            x3 = x2 * 2 - x1
            y3 = y1
            a  = (y1 * (x3 - x2) + y3 * (x2 - x1) + y2 * (x1 - x3)) / (x1 * x1 * (x3 - x2) + x3 * x3 * (x2 - x1) + x2 * x2 * (x1 - x3))
            b  = (y1 - y3) / (x1 - x3) - a * (x1 + x3)
            c  = y1 - (x1 * x1) * a - x1 * b
            for i in 0...frames {
                x = x1 + ease.interpolation(offset) * xOffset
                xs[i] = x
                ys[i] = a * x * x + b * x + c
                offset += p
            }
        }
    }
    
    static func orderIndexes(orderEnum: OrderEnum, size: Int) -> [Int] {
        var indexes = [Int]()
        switch orderEnum {
        case .inOrder:
            for i in 0..<size {
                indexes.append(i)
            }
        case .reverse:
            for i in 0..<size {
                indexes.append(size - i - 1)
            }
        case .random:
            var used = Array<Bool>.init(repeating: false, count: Int(size))
            var count = 0
            while count < size {
                let r = arc4random_uniform(UInt32(size))
                if used[Int(r)] == false
                {
                    used[Int(r)] = true
                    indexes.append(Int(r))
                    count += 1
                }
            }
        }
        return indexes
    }
    
    static func values(ease: Ease, frames: Int, start: CGFloat, end: CGFloat) -> [CGFloat] {
        var values = Array<CGFloat>.init(repeating: 0, count: frames + 1)
        let p = 1.0 / CGFloat(frames)
        let totalOffset = end - start
        var offset = CGFloat(0)
        for i in 0...frames {
            let offsetInFact = ease.interpolation(offset)
            values[i] = start + offsetInFact * totalOffset
            offset += p
        }
        return values
    }
    
    static func rotateXAnimation(frames: Int,
                                 startY: CGFloat,
                                 endY: CGFloat,
                                 delay: CFTimeInterval,
                                 duration: CFTimeInterval) ->CAKeyframeAnimation {
        let values = AnimationManager.values(ease: Ease.ease(name: Ease.inOutCubic), frames: frames, start: startY, end: endY)
        var rotateXs = Array<CGFloat>.init(repeating: 0, count: frames)
        var previousY = startY
        let maxDegree = CGFloat.pi / 4
        for (idx, value) in values.enumerated() {
            if idx != 0 {
                let velocity = value - previousY
                rotateXs[idx] = AnimationManager.clamp(-velocity / 12, min: -maxDegree, max: maxDegree)
            }
            previousY = value
        }
        AnimationManager.addBufferValues(&rotateXs)
        return AnimationManager.animate("transform.rotation.x", delay: delay, duration: duration, values: rotateXs)
    }
    
    static func rotateYAnimation(frames: Int,
                                 startX: CGFloat,
                                 endX: CGFloat,
                                 delay: CFTimeInterval,
                                 duration: CFTimeInterval) ->CAKeyframeAnimation {
        let values = AnimationManager.values(ease: Ease.ease(name: Ease.inOutCubic), frames: frames, start: startX, end: endX)
        var rotateYs = Array<CGFloat>.init(repeating: 0, count: frames)
        var previousX = startX
        let maxDegree = CGFloat.pi / 4
        for (idx, value) in values.enumerated() {
            if idx != 0 {
                let velocity = value - previousX
                rotateYs[idx] = AnimationManager.clamp(velocity / 12, min: -maxDegree, max: maxDegree)
            }
            previousX = value
        }
        AnimationManager.addBufferValues(&rotateYs)
        return AnimationManager.animate("transform.rotation.y", delay: delay, duration: duration, values: rotateYs)
    }
    
    static func rotateXAnimation(ys: [CGFloat], delay: CFTimeInterval, duration: CFTimeInterval) -> CAKeyframeAnimation {
        var rotateXs = Array<CGFloat>.init(repeating: 0, count: ys.count)
        var previousY: CGFloat = 0
        let maxDegree = CGFloat.pi / 4
        for (idx, y) in ys.enumerated() {
            if idx != 0 {
                let velocity = y - previousY
                rotateXs[idx] = AnimationManager.clamp(velocity / 12, min: -maxDegree, max: maxDegree)
            }
            previousY = y
        }
        AnimationManager.addBufferValues(&rotateXs)
        return AnimationManager.animate("transform.rotation.x", delay: delay, duration: duration, values: rotateXs)
    }
    
    static func rotateYAnimation(xs: [CGFloat], delay: CFTimeInterval, duration: CFTimeInterval) -> CAKeyframeAnimation {
        var rotateYs = Array<CGFloat>.init(repeating: 0, count: xs.count)
        var previousX: CGFloat = 0
        let maxDegree = CGFloat.pi / 4
        for (idx, x) in xs.enumerated() {
            if idx != 0 {
                let velocity = x - previousX
                rotateYs[idx] = AnimationManager.clamp(-velocity / 12, min: -maxDegree, max: maxDegree)
            }
            previousX = x
        }
        AnimationManager.addBufferValues(&rotateYs)
        return AnimationManager.animate("transform.rotation.y", delay: delay, duration: duration, values: rotateYs)
    }
    
    // MARK: - Private Methods
    
    private static func clamp(_ v: CGFloat, min: CGFloat, max: CGFloat) -> CGFloat {
        return v < min ? min : (v > max ? max : v)
    }
    
    private static func addBufferValues(_ values: inout [CGFloat]) {
        if values.last == 0 {
            return
        }
        guard values.last != 0 else {
            return
        }
        values.append(values.last! * 0.5)
        values.append(values.last! * 0.5)
        values.append(values.last! * 0.5)
        values.append(0)
    }
    
}
