//
//  Ease.swift
//  BoomMenuButton
//
//  Created by Nightonke on 2017/4/26.
//  Copyright © 2017 Nightonke. All rights reserved.
//

import UIKit

/// Check https://github.com/Nightonke/VHBoomMenuButton/wiki/Ease-Animations-for-Buttons for more information about ease-animation.
public class Ease: NSObject, TimeInterpolator {
    
    /// Linear timing function.
    public static let linear = "EaseLinear"
    
    /// In-Sine timing function.
    public static let inSine = "EaseInSine"
    /// Out-Sine timing function.
    public static let outSine = "EaseOutSine"
    /// In-Out-Sine timing function.
    public static let inOutSine = "EaseInOutSine"
    
    /// In-Quad timing function.
    public static let inQuad = "EaseInQuad"
    /// Out-Quad timing function.
    public static let outQuad = "EaseOutQuad"
    /// In-Out-Quad timing function.
    public static let inOutQuad = "EaseInOutQuad"
    
    /// In-Cubic timing function.
    public static let inCubic = "EaseInCubic"
    /// Out-Cubic timing function.
    public static let outCubic = "EaseOutCubic"
    /// In-Out-Cubic timing function.
    public static let inOutCubic = "EaseInOutCubic"
    
    /// In-Quart timing function.
    public static let inQuart = "EaseInQuart"
    /// Out-Quart timing function.
    public static let outQuart = "EaseOutQuart"
    /// In-Out-Quart timing function.
    public static let inOutQuart = "EaseInOutQuart"
    
    /// In-Quint timing function.
    public static let inQuint = "EaseInQuint"
    /// Out-Quint timing function.
    public static let outQuint = "EaseOutQuint"
    /// In-Out-Quint timing function.
    public static let inOutQuint = "EaseInOutQuint"
    
    /// In-Circ timing function.
    public static let inCirc = "EaseInCirc"
    /// Out-Circ timing function.
    public static let outCirc = "EaseOutCirc"
    /// In-Out-Circ timing function.
    public static let inOutCirc = "EaseInOutCirc"
    
    /// In-Expo timing function.
    public static let inExpo = "EaseInExpo"
    /// Out-Expo timing function.
    public static let outExpo = "EaseOutExpo"
    /// In-Out-Expo timinig function.
    public static let inOutExpo = "EaseInOutExpo"
    
    /// In-Back timing function.
    public static let inBack = "EaseInBack"
    /// Out-Back timing function.
    public static let outBack = "EaseOutBack"
    /// In-Out-Back timing function.
    public static let inOutBack = "EaseInOutBack"
    
    /// In-Elastic timing function.
    public static let inElastic = "EaseInElastic"
    /// Out-Elastic timing function.
    public static let outElastic = "EaseOutElastic"
    /// In-Out-Elastic timing function.
    public static let inOutElastic = "EaseInOutElastic"
    
    /// In-Bounce timing function.
    public static let inBounce = "EaseInBounce"
    /// Out-Bounce timing function.
    public static let outBounce = "EaseOutBounce"
    /// In-Out-Bounce timing function.
    public static let inOutBounce = "EaseInOutBounce"
    
    private static var eases = [String: Ease]()

    private var start = CGPoint.init(x: 0, y: 0)
    private var end = CGPoint.init(x: 1, y: 1)
    private var a = CGPoint.init(x: 0, y: 0)
    private var b = CGPoint.init(x: 0, y: 0)
    private var c = CGPoint.init(x: 0, y: 0)
    private var ableToDefineWithControlPoints = false
    private var name: String?
    
    internal static func ease(name: String) -> Ease! {
        if let ease = eases[name] {
            return ease
        } else {
            let ease = innerEase(name: name)
            eases[name] = ease
            return ease
        }
    }
    
    private static func innerEase(name: String) -> Ease! {
        switch name {
        case Ease.linear:
            return Ease.init(startX: 0.000, startY: 0.000, endX: 1.000, endY: 1.000)
        case Ease.inSine:
            return Ease.init(startX: 0.470, startY: 0.000, endX: 0.745, endY: 0.715)
        case Ease.outSine:
            return Ease.init(startX: 0.390, startY: 0.575, endX: 0.565, endY: 1.000)
        case Ease.inOutSine:
            return Ease.init(startX: 0.445, startY: 0.050, endX: 0.550, endY: 0.950)
        case Ease.inQuad:
            return Ease.init(startX: 0.550, startY: 0.085, endX: 0.680, endY: 0.530)
        case Ease.outQuad:
            return Ease.init(startX: 0.165, startY: 0.840, endX: 0.440, endY: 1.000)
        case Ease.inOutQuad:
            return Ease.init(startX: 0.455, startY: 0.030, endX: 0.515, endY: 0.955)
        case Ease.inCubic:
            return Ease.init(startX: 0.550, startY: 0.055, endX: 0.675, endY: 0.190)
        case Ease.outCubic:
            return Ease.init(startX: 0.215, startY: 0.610, endX: 0.355, endY: 1.000)
        case Ease.inOutCubic:
            return Ease.init(startX: 0.645, startY: 0.045, endX: 0.335, endY: 1.000)
        case Ease.inQuart:
            return Ease.init(startX: 0.895, startY: 0.030, endX: 0.685, endY: 0.220)
        case Ease.outQuart:
            return Ease.init(startX: 0.165, startY: 0.840, endX: 0.440, endY: 1.000)
        case Ease.inOutQuart:
            return Ease.init(startX: 0.770, startY: 0.000, endX: 0.175, endY: 1.000)
        case Ease.inQuint:
            return Ease.init(startX: 0.755, startY: 0.050, endX: 0.855, endY: 0.060)
        case Ease.outQuint:
            return Ease.init(startX: 0.230, startY: 1.000, endX: 0.320, endY: 1.000)
        case Ease.inOutQuint:
            return Ease.init(startX: 0.860, startY: 0.000, endX: 0.070, endY: 1.000)
        case Ease.inCirc:
            return Ease.init(startX: 0.600, startY: 0.040, endX: 0.980, endY: 0.335)
        case Ease.outCirc:
            return Ease.init(startX: 0.075, startY: 0.820, endX: 0.165, endY: 1.000)
        case Ease.inOutCirc:
            return Ease.init(startX: 0.785, startY: 0.135, endX: 0.150, endY: 0.860)
        case Ease.inExpo:
            return Ease.init(startX: 0.950, startY: 0.050, endX: 0.795, endY: 0.035)
        case Ease.outExpo:
            return Ease.init(startX: 0.190, startY: 1.000, endX: 0.220, endY: 1.000)
        case Ease.inOutExpo:
            return Ease.init(startX: 1.000, startY: 0.000, endX: 0.000, endY: 1.000)
        case Ease.inBack:
            return Ease.init(startX: 0.600, startY: -0.20, endX: 0.735, endY: 0.045)
        case Ease.outBack:
            return Ease.init(startX: 0.174, startY: 0.885, endX: 0.320, endY: 1.275)
        case Ease.inOutBack:
            return Ease.init(startX: 0.680, startY: -0.55, endX: 0.265, endY: 1.550)
        default:
            return Ease.init(name: name)
        }
    }
    
    private init(startX: CGFloat, startY: CGFloat, endX: CGFloat, endY: CGFloat) {
        ableToDefineWithControlPoints = true
        start = CGPoint.init(x: startX, y: startY)
        end = CGPoint.init(x: endX, y: endY)
    }
    
    private init(name: String) {
        ableToDefineWithControlPoints = false
        self.name = name
    }
    
    public func interpolation(_ offset: CGFloat) -> CGFloat {
        if ableToDefineWithControlPoints {
            return getBezierCoordinateY(time:offset)
        } else {
            if name == Ease.inElastic {
                return easeInElasticOffset(offset:offset)
            } else if name == Ease.inBounce {
                return easeInBounceOffset(offset:offset)
            } else if name == Ease.outElastic {
                return easeOutElasticOffset(offset:offset)
            } else if name == Ease.outBounce {
                return easeOutBounceOffset(offset:offset)
            } else if name == Ease.inOutElastic {
                return easeInOutElasticOffset(offset:offset)
            } else if name == Ease.inOutBounce {
                return easeInOutBounceOffset(offset:offset)
            } else {
                assert(false, "Unknown ease name")
                return offset
            }
        }
    }
    
    private func getBezierCoordinateY(time: CGFloat) -> CGFloat {
        if start.x == 0 && start.y == 0 && end.x == 0 && end.y == 0 {
            return time
        }
        c = CGPoint.init(x: c.x, y: 3 * start.y)
        b = CGPoint.init(x: b.x, y: 3 * (end.y - start.y) - c.y)
        a = CGPoint.init(x: a.x, y: 1 - c.y - b.y)
        return time * (c.y + time * (b.y + time * a.y))
    }
    
    private func getXDerivate(t: CGFloat) -> CGFloat {
        return  c.x + t * (2 * b.x + 3 * a.x * t)
    }
    
    private func getBezierCoordinateX(time: CGFloat) -> CGFloat {
        c = CGPoint.init(x: 3 * start.x, y: c.y)
        b = CGPoint.init(x: 3 * (end.x - start.x) - c.x, y: b.y)
        a = CGPoint.init(x: 1 - c.x - b.x, y: a.y)
        return time * (c.x + time * (b.x + time * a.x))
    }
    
    private func easeInBounceOffset(offset: CGFloat) -> CGFloat {
        let b: CGFloat = 0
        let c: CGFloat = 1
        let d: CGFloat = 1
        return c - easeBounceOffsetHelper2(t: d - offset, b: 0, c: c, d: d) + b
    }
    
    private func easeBounceOffsetHelper1(t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) -> CGFloat {
        return c - easeBounceOffsetHelper2(t:t, b:b, c:c, d:d)
    }
    
    private func easeBounceOffsetHelper2(t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) -> CGFloat {
        var t = t / d
        if t < 1 / 2.75 {
            return c * (7.5625 * t * t) + b
        } else if t < 2 / 2.75 {
            t -= 1.5 / 2.75
            return c * (7.5625 * t * t + 0.75) + b
        } else if t < 2 / 2.75 {
            t -= 1.5 / 2.75;
            return c * (7.5625 * t * t + 0.9375) + b
        } else {
            t -= 2.625 / 2.75;
            return c * (7.5625 * t * t + 0.984375) + b
        }
    }
    
    private func easeOutBounceOffset(offset: CGFloat) -> CGFloat {
        let b: CGFloat = 0
        let c: CGFloat = 1
        let d: CGFloat = 1
        var offset = offset / d
        if offset < 1 / 2.75 {
            return c * (7.5625 * offset * offset) + b
        } else if offset < 2 / 2.75 {
            offset -= (1.5 / 2.75);
            return c * (7.5625 * offset * offset + 0.75) + b
        } else if offset < 2.5 / 2.75 {
            offset -= (2.25 / 2.75);
            return c * (7.5625 * offset * offset + 0.9375) + b
        } else {
            offset -= 2.625 / 2.75;
            return c * (7.5625 * offset * offset + 0.984375) + b
        }
    }
    
    private func easeInOutBounceOffset(offset: CGFloat) -> CGFloat {
        let b: CGFloat = 0
        let c: CGFloat = 1
        let d: CGFloat = 1
        if offset < d / 2 {
            return easeBounceOffsetHelper1(t: offset * 2, b: 0, c: c, d: d) * 0.5 + b
        } else {
            return easeBounceOffsetHelper2(t: offset * 2 - d, b: 0, c: c, d: d) * 0.5 + c * 0.5 + b
        }
    }
    
    private func easeInElasticOffset(offset: CGFloat) -> CGFloat {
        let b: CGFloat = 0
        let c: CGFloat = 1
        let d: CGFloat = 1
        if offset == 0 {
            return b
        }
        var offset = offset / d
        if offset == 1 {
            return b + c
        }
        let p = d * 0.3
        let a = c
        let s = p / 4
        offset -= 1
        return -(a * pow(2, 10 * offset) * sin((offset * d - s) * (2 * CGFloat.pi) / p)) + b
    }
    
    private func easeOutElasticOffset(offset: CGFloat) -> CGFloat {
        let b: CGFloat = 0
        let c: CGFloat = 1
        let d: CGFloat = 1
        if offset == 0 {
            return b
        }
        let offset = offset / d
        if offset == 1 {
            return b + c
        }
        let p = d * 0.3
        let a = c
        let s = p / 4
        return (a * pow(2, -10 * offset) * sin((offset * d - s) * (2 * CGFloat.pi) / p) + c + b)
    }
    
    private func easeInOutElasticOffset(offset: CGFloat) -> CGFloat {
        let b: CGFloat = 0
        let c: CGFloat = 1
        let d: CGFloat = 1
        if offset == 0 {
            return b
        }
        var offset = offset / d
        if offset == 1 {
            return b + c
        }
        let p = d * 0.3 * 1.5
        let a = c
        let s = p / 4
        offset -= 1
        if offset < 1 {
            return -0.5 * (a * pow(2, 10 * offset) * sin((offset * d - s) * (2 * CGFloat.pi) / p)) + b
        } else {
            return a * pow(2, -10 * offset) * sin((offset * d - s) * (2 * CGFloat.pi) / p) * 0.5 + c + b
        }
    }
    
}
