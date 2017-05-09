//
//  ErrorManager.swift
//  BoomMenuButton
//
//  Created by Nightonke on 2017/4/28.
//  Copyright © 2017 Nightonke. All rights reserved.
//

class ErrorManager: NSObject {

    static func judge(boomMenuButton bmb: BoomMenuButton, withBuilders builders: [BoomButtonBuilder]) {
        
        assert(bmb.buttonEnum != .unknown, "[BMB] Unknown button enum!")
        assert(bmb.piecePlaceEnum.rawValue < PiecePlaceEnum.count, "[BMB] Unknown piece-place-enum!")
        assert(bmb.buttonPlaceEnum.rawValue < ButtonPlaceEnum.count, "[BMB] Unknown button-place-enum!")
        assert(bmb.boomEnum.rawValue < BoomEnum.count, "[BMB] Unknown boom-enum!")
        assert(builders.count > 0, "[BMB] Empty builders!")
        
        let pieceNumber = bmb.piecePlaceEnum.pieceNumber()
        let minPieceNumber = bmb.piecePlaceEnum.minPieceNumber()
        let maxPieceNumber = bmb.piecePlaceEnum.maxPieceNumber()
        let customPiecePositionsNumber = bmb.customPiecePlacePositions.count
        
        let buttonNumber = bmb.buttonPlaceEnum.buttonNumber()
        let minButtonNumber = bmb.buttonPlaceEnum.minButtonNumber()
        let maxButtonNumber = bmb.buttonPlaceEnum.maxButtonNumber()
        let customButtonPositionsNumber = bmb.customButtonPlacePositions.count
        
        let builderNumber = builders.count
        
        if pieceNumber == -1 {
            // The piece number is in a range
            if buttonNumber != -1 && !(minPieceNumber <= buttonNumber && buttonNumber <= maxPieceNumber) {
                // The button-place-enum has a certain number of buttons, then it must be in the range
                assert(false, "[BMB] The number(\(buttonNumber)) of buttons of button-place-enum(\(bmb.buttonPlaceEnum)) is not in the range([\(minPieceNumber), \(maxPieceNumber)]) of the piece-place-enum(\(bmb.piecePlaceEnum))")
            }
            if !(minPieceNumber <= builderNumber && builderNumber <= maxPieceNumber) {
                // The number of builders must be in the range
                assert(false, "[BMB] The number of builders(\(builderNumber)) is not in the range([\(minPieceNumber), \(maxPieceNumber)]) of the piece-place-enum(\(bmb.piecePlaceEnum))")
            }
        } else {
            if buttonNumber != -1 {
                // The piece-place-enum and button-place-enum both have a certain number of pieces and buttons. They must be the same
                assert(pieceNumber == buttonNumber, "[BMB] The number of piece(\(pieceNumber)) is not equal to buttons'(\(buttonNumber))")
                assert(pieceNumber == builderNumber, "[BMB] The number of piece(\(pieceNumber)) is not equal to builders'(\(builderNumber))")
            }
        }
        
        if bmb.piecePlaceEnum == .custom {
            assert(customPiecePositionsNumber > 0, "[BMB] When the positions of pieces is customized, the custom-piece-place-positions array is empty")
            if buttonNumber == -1 {
                // The button number is in a range
                assert(minButtonNumber <= customPiecePositionsNumber && customPiecePositionsNumber <= maxButtonNumber,
                       "[BMB] When the positions of pieces is customized, the length(\(customPiecePositionsNumber)) of custom-piece-place-positions array is not in the range([\(minButtonNumber), \(maxButtonNumber)])")
            } else {
                assert(customPiecePositionsNumber == buttonNumber, "[BMB] The number of piece(\(customPiecePositionsNumber)) is not equal to buttons'(\(buttonNumber))")
            }
            assert(customPiecePositionsNumber == builderNumber, "[BMB] The number of piece(\(customPiecePositionsNumber)) is not equal to builders'(\(builderNumber))")
        }
        
        if bmb.buttonPlaceEnum == .custom {
            assert(customButtonPositionsNumber > 0, "[BMB] When the positions of buttons is customized, the custom-button-place-positions array is empty")
            if pieceNumber == -1 {
                // The piece number is in a range
                assert(minPieceNumber <= customButtonPositionsNumber && customButtonPositionsNumber <= maxPieceNumber,
                       "[BMB] When the positions of buttons is customized, the length(\(customButtonPositionsNumber)) of custom-button-place-positions array is not in the range([\(minPieceNumber), \(maxPieceNumber)])")
            } else {
                assert(customButtonPositionsNumber == pieceNumber, "[BMB] The number of button(\(customButtonPositionsNumber)) is not equal to pieces'(\(pieceNumber))")
            }
            assert(customButtonPositionsNumber == builderNumber, "[BMB] The number of button(\(customButtonPositionsNumber)) is not equal to builders'(\(builderNumber))")
        }
    }
}
