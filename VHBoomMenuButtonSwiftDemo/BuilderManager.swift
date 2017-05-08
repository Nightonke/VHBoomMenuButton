//
//  BuilderManager.swift
//  VHBoomMenuButtonSwiftDemo
//
//  Created by viktorhuang on 2017/5/2.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

import UIKit
import BoomMenuButton

class BuilderManager: NSObject {
    
    // MARK: - Builders
    
    static func simpleCircleButtonBuilder() -> SimpleCircleButtonBuilder {
        let builder = SimpleCircleButtonBuilder.init()
        builder.normalImageName = BuilderManager.imageName()
        return builder
    }
    
    static func squareSimpleCircleButtonBuilder() -> SimpleCircleButtonBuilder {
        let builder = BuilderManager.simpleCircleButtonBuilder()
        builder.round = false
        builder.cornerRadius = 10
        return builder
    }
    
    static func textInsideCircleButtonBuilder() -> TextInsideCircleButtonBuilder {
        let builder = TextInsideCircleButtonBuilder.init()
        builder.normalImageName = BuilderManager.imageName()
        builder.normalText = "Text Inside"
        return builder
    }
    
    static func squareTextInsideCircleButtonBuilder() -> TextInsideCircleButtonBuilder {
        let builder = BuilderManager.textInsideCircleButtonBuilder()
        builder.round = false
        builder.cornerRadius = 20
        return builder
    }
    
    static func textInsideCircleButtonBuilderWithDifferentPieceColor() -> TextInsideCircleButtonBuilder {
        let builder = BuilderManager.textInsideCircleButtonBuilder()
        builder.pieceColor = UIColor.white
        return builder
    }
    
    static func textOutsideCircleButtonBuilder() -> TextOutsideCircleButtonBuilder {
        let builder = TextOutsideCircleButtonBuilder.init()
        builder.normalImageName = BuilderManager.imageName()
        builder.normalText = "Text Outside"
        return builder
    }
    
    static func squareTextOutsideCircleButtonBuilder() -> TextOutsideCircleButtonBuilder {
        let builder = BuilderManager.textOutsideCircleButtonBuilder()
        builder.round = false
        return builder
    }
    
    static func textOutsideCircleButtonBuilderWithDifferentPieceColor() -> TextOutsideCircleButtonBuilder {
        let builder = BuilderManager.textOutsideCircleButtonBuilder()
        builder.pieceColor = UIColor.white
        return builder
    }
    
    static func hamButtonBuilder() -> HamButtonBuilder {
        let builder = HamButtonBuilder.init()
        builder.normalImageName = BuilderManager.imageName()
        builder.normalText = "Ham Button Text"
        builder.normalSubText = "Ham Button Sub Text"
        return builder
    }
    
    static func hamButtonBuilderWithDifferentPieceColor() -> HamButtonBuilder {
        let builder = BuilderManager.hamButtonBuilder()
        builder.pieceColor = UIColor.white
        return builder
    }
    
    static func hamButtonBuilder(withText text: String, withSubText subText: String) -> HamButtonBuilder {
        let builder = hamButtonBuilder()
        builder.normalText = text
        builder.normalSubText = subText
        return builder
    }

    static func imageName() -> String {
        imageNameIndex += 1
        if imageNameIndex >= imageNames.count {
            imageNameIndex = 0
        }
        return imageNames[imageNameIndex]
    }
    
    // MARK: - List Data
    
    static func initializeDatasForSimpleCircleButton(datas: inout [String],
                                                     piecesAndButtons: inout [(PiecePlaceEnum, ButtonPlaceEnum)]) {
        for p in 0..<PiecePlaceEnum.count {
            for b in 0..<ButtonPlaceEnum.count {
                let piecePlaceEnum: PiecePlaceEnum = PiecePlaceEnum.init(rawValue: p)!
                let buttonPlaceEnum: ButtonPlaceEnum = ButtonPlaceEnum.init(rawValue: b)!
                if piecePlaceEnum.pieceNumber() == buttonPlaceEnum.buttonNumber()
                    || buttonPlaceEnum == .horizontal
                    || buttonPlaceEnum == .vertical {
                    datas.append("\(piecePlaceEnumStrings[p]) \(buttonPlaceEnumStrings[b])")
                    piecesAndButtons.append((piecePlaceEnum, buttonPlaceEnum))
                    if piecePlaceEnum == .ham_1
                        || piecePlaceEnum == .ham_2
                        || piecePlaceEnum == .ham_3
                        || piecePlaceEnum == .ham_4
                        || piecePlaceEnum == .ham_5
                        || piecePlaceEnum == .ham_6
                        || piecePlaceEnum == .share
                        || piecePlaceEnum == .custom
                        || buttonPlaceEnum == .ham_1
                        || buttonPlaceEnum == .ham_2
                        || buttonPlaceEnum == .ham_3
                        || buttonPlaceEnum == .ham_4
                        || buttonPlaceEnum == .ham_5
                        || buttonPlaceEnum == .ham_6
                        || buttonPlaceEnum == .custom {
                        datas.removeLast()
                        piecesAndButtons.removeLast()
                    }
                }
            }
        }
    }
    
    static func initializeDatasForTextInsideCircleButton(datas: inout [String],
                                                         piecesAndButtons: inout [(PiecePlaceEnum, ButtonPlaceEnum)]) {
        initializeDatasForSimpleCircleButton(datas: &datas, piecesAndButtons: &piecesAndButtons)
    }
    
    static func initializeDatasForTextOutsideCircleButton(datas: inout [String],
                                                          piecesAndButtons: inout [(PiecePlaceEnum, ButtonPlaceEnum)]) {
        initializeDatasForSimpleCircleButton(datas: &datas, piecesAndButtons: &piecesAndButtons)
    }
    
    static func initializeDatasForHamButton(datas: inout [String],
                                            piecesAndButtons: inout [(PiecePlaceEnum, ButtonPlaceEnum)]) {
        for p in 0..<PiecePlaceEnum.count {
            for b in 0..<ButtonPlaceEnum.count {
                let piecePlaceEnum: PiecePlaceEnum = PiecePlaceEnum.init(rawValue: p)!
                let buttonPlaceEnum: ButtonPlaceEnum = ButtonPlaceEnum.init(rawValue: b)!
                if piecePlaceEnum.pieceNumber() == buttonPlaceEnum.buttonNumber()
                    || buttonPlaceEnum == .horizontal
                    || buttonPlaceEnum == .vertical {
                    datas.append("\(piecePlaceEnumStrings[p]) \(buttonPlaceEnumStrings[b])")
                    piecesAndButtons.append((piecePlaceEnum, buttonPlaceEnum))
                    if piecePlaceEnum.rawValue < PiecePlaceEnum.ham_1.rawValue
                        || piecePlaceEnum == .share
                        || piecePlaceEnum == .custom
                        || buttonPlaceEnum.rawValue < ButtonPlaceEnum.ham_1.rawValue
                        || buttonPlaceEnum == .custom {
                        datas.removeLast()
                        piecesAndButtons.removeLast()
                    }
                }
            }
        }
    }
    
    // MARK: - Private Properties or Methods
    
    private static let imageNames: [String] = ["butterfly",
                                               "peacock",
                                               "rat",
                                               "jellyFish",
                                               "horse",
                                               "dolphin",
                                               "deer",
                                               "cat",
                                               "bear",
                                               "snake",
                                               "pig",
                                               "eagle",
                                               "bat",
                                               "bee",
                                               "owl",
                                               "squirrel"]
    
    private static var imageNameIndex: Int = 0
    
    private static let piecePlaceEnumStrings: [String] = ["DOT_1",
                                                          "DOT_2_1",
                                                          "DOT_2_2",
                                                          "DOT_3_1",
                                                          "DOT_3_2",
                                                          "DOT_3_3",
                                                          "DOT_3_4",
                                                          "DOT_4_1",
                                                          "DOT_4_2",
                                                          "DOT_5_1",
                                                          "DOT_5_2",
                                                          "DOT_5_3",
                                                          "DOT_5_4",
                                                          "DOT_6_1",
                                                          "DOT_6_2",
                                                          "DOT_6_3",
                                                          "DOT_6_4",
                                                          "DOT_6_5",
                                                          "DOT_6_6",
                                                          "DOT_7_1",
                                                          "DOT_7_2",
                                                          "DOT_7_3",
                                                          "DOT_7_4",
                                                          "DOT_7_5",
                                                          "DOT_7_6",
                                                          "DOT_8_1",
                                                          "DOT_8_2",
                                                          "DOT_8_3",
                                                          "DOT_8_4",
                                                          "DOT_8_5",
                                                          "DOT_8_6",
                                                          "DOT_8_7",
                                                          "DOT_9_1",
                                                          "DOT_9_2",
                                                          "DOT_9_3",
                                                          "HAM_1",
                                                          "HAM_2",
                                                          "HAM_3",
                                                          "HAM_4",
                                                          "HAM_5",
                                                          "HAM_6",
                                                          "Share",
                                                          "Custom"]
    
    private static let buttonPlaceEnumStrings: [String] = ["SC_1",
                                                           "SC_2_1",
                                                           "SC_2_2",
                                                           "SC_3_1",
                                                           "SC_3_2",
                                                           "SC_3_3",
                                                           "SC_3_4",
                                                           "SC_4_1",
                                                           "SC_4_2",
                                                           "SC_5_1",
                                                           "SC_5_2",
                                                           "SC_5_3",
                                                           "SC_5_4",
                                                           "SC_6_1",
                                                           "SC_6_2",
                                                           "SC_6_3",
                                                           "SC_6_4",
                                                           "SC_6_5",
                                                           "SC_6_6",
                                                           "SC_7_1",
                                                           "SC_7_2",
                                                           "SC_7_3",
                                                           "SC_7_4",
                                                           "SC_7_5",
                                                           "SC_7_6",
                                                           "SC_8_1",
                                                           "SC_8_2",
                                                           "SC_8_3",
                                                           "SC_8_4",
                                                           "SC_8_5",
                                                           "SC_8_6",
                                                           "SC_8_7",
                                                           "SC_9_1",
                                                           "SC_9_2",
                                                           "SC_9_3",
                                                           "HAM_1",
                                                           "HAM_2",
                                                           "HAM_3",
                                                           "HAM_4",
                                                           "HAM_5",
                                                           "HAM_6",
                                                           "Horizontal",
                                                           "Vertical",
                                                           "Custom"]
}
