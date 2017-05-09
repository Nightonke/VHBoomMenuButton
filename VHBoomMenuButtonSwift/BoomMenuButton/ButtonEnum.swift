//
//  ButtonEnum.swift
//  BoomMenuButton
//
//  Created by Nightonke on 2017/4/27.
//  Copyright © 2017 Nightonke. All rights reserved.
//

/// Button type supported by BMB.
/// - simpleCircle: Boom-button with only an image in a circular or a square shape.
/// - textInsideCircle: Boom-button with an image and a text inside in a circular or a square shape.
/// - textOutsideCircle: Boom-button with an image and a text outside in a circular or a square shape.
/// - ham: Boom-button with an image, a text and a sub-text inside in a rectangle shape.
/// - unknown: Boom-button unknown.
public enum ButtonEnum {
    case simpleCircle
    case textInsideCircle
    case textOutsideCircle
    case ham
    case unknown
    
    static var count: Int {
        return ButtonEnum.ham.hashValue + 1
    }
}
