//
//  ButtonEnum.swift
//  BoomMenuButton
//
//  Created by viktorhuang on 2017/4/27.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

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
