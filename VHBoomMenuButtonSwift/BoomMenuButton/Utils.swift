//
//  Utils.swift
//  BoomMenuButton
//
//  Created by Nightonke on 2017/4/27.
//  Copyright © 2017 Nightonke. All rights reserved.
//

import UIKit

class Utils: NSObject {
    
    private static var colors: Array<UIColor> = [Utils.color(rgb: 0xF44336),
                                                 Utils.color(rgb: 0xE91E63),
                                                 Utils.color(rgb: 0x9C27B0),
                                                 Utils.color(rgb: 0x673AB7),
                                                 Utils.color(rgb: 0x3F51B5),
                                                 Utils.color(rgb: 0x2196F3),
                                                 Utils.color(rgb: 0x03A9F4),
                                                 Utils.color(rgb: 0x00BCD4),
                                                 Utils.color(rgb: 0x009688),
                                                 Utils.color(rgb: 0x4CAF50),
                                                 Utils.color(rgb: 0x009688),
                                                 Utils.color(rgb: 0xCDDC39),
                                                 Utils.color(rgb: 0xFFEB3B),
                                                 Utils.color(rgb: 0xFF9800),
                                                 Utils.color(rgb: 0xFF5722),
                                                 Utils.color(rgb: 0x795548),
                                                 Utils.color(rgb: 0x9E9E9E),
                                                 Utils.color(rgb: 0x607D8B)]
    
    private static var usedColors = [Int]()

    // MARK: Public Methods
    
    static func setAnchorPoint(_ anchorPoint: CGPoint, layer: CALayer) {
        let originalFrame = layer.frame
        layer.anchorPoint = anchorPoint
        layer.frame = originalFrame
    }
    
    static func color() -> UIColor {
        while true {
            let colorIndex = Int(arc4random_uniform(UInt32(colors.count)))
            if usedColors.contains(colorIndex) == false {
                usedColors.append(colorIndex)
                while usedColors.count > 6 {
                    usedColors.removeFirst()
                }
                return colors[colorIndex]
            }
        }
    }
    
    static func darkerColor(color: UIColor) -> UIColor {
        var hue: CGFloat = 0, saturation: CGFloat = 0, brightness: CGFloat = 0, alpha: CGFloat = 0
        color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        saturation *= 0.9
        return UIColor.init(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }
    
    static func lightColor(color: UIColor) -> UIColor {
        var hue: CGFloat = 0, saturation: CGFloat = 0, brightness: CGFloat = 0, alpha: CGFloat = 0
        color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        saturation *= 1.1
        return UIColor.init(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }
    
    static func color(rgb: Int) -> UIColor {
        return UIColor.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
                            green: CGFloat((rgb & 0xFF00) >> 8) / 255.0,
                            blue: CGFloat(rgb & 0xFF) / 255.0,
                            alpha: 1)
    }
    
    static func color(argb: Int64) -> UIColor {
        return UIColor.init(red: CGFloat((argb & 0x00FF0000) >> 16) / 255.0,
                            green: CGFloat((argb & 0x0000FF00) >> 8) / 255.0,
                            blue: CGFloat(argb & 0x000000FF) / 255.0,
                            alpha: CGFloat((argb & 0xFF000000) >> 24) / 255.0)
    }
    
    static func image(image: UIImage?, newSize: CGSize) -> UIImage? {
        guard image != nil else {
            return nil
        }
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        image?.draw(in: CGRect.init(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    static func isSameColor(_ color1: UIColor?, _ color2: UIColor?) -> Bool {
        if (color1 == nil && color2 != nil) || (color2 == nil && color1 != nil) {
            return false
        } else if color1 == nil && color2 == nil {
            return true
        }
        return color1?.cgColor == color2?.cgColor
    }
    
    static func isSameAttributedString(_ s1: NSAttributedString?, _ s2: NSAttributedString?) -> Bool {
        if (s1 == nil && s2 != nil) || (s2 == nil && s1 != nil) {
            return false
        } else if s1 == nil && s2 == nil {
            return true
        }
        return s1!.isEqual(to: s2!)
    }
}
