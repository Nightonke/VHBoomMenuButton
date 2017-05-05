//
//  BoomButtonBuilder.swift
//  BoomMenuButton
//
//  Created by viktorhuang on 2017/4/28.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

import UIKit

public typealias BoomButtonDidClickClosure = (Int) -> Void

public class BoomButtonBuilder: NSObject {

    // MARK: - In-BMB-Only Properties
    
    var index = -1
    
    weak var listener: BoomButtonDelegate?
    
    weak var piece: BoomPiece?
    
    weak var button: BoomButton?
    
    // MARK: - Basic
    
    public var clickedClosure: BoomButtonDidClickClosure? {
        didSet {
            button?.clickedClosure = clickedClosure
        }
    }
    
    public var unable = false {
        didSet {
            if oldValue == unable {
                return
            }
            button?.unable = unable
            piece?.setColor(color: innerPieceColor())
            if unable {
                button?.toUnable()
            } else {
                button?.toNormal()
            }
        }
    }
    
    public var rotateImage = true {
        didSet {
            if oldValue == rotateImage {
                return
            }
            button?.rotateImage = rotateImage
        }
    }
    
    // MARK: - Piece
    
    public var pieceColor: UIColor? {
        didSet {
            if Utils.isSameColor(pieceColor, oldValue) {
                return
            }
            button?.pieceColor = pieceColor
            piece?.setColor(color: innerPieceColor())
        }
    }
    
    // MARK: - Shadow
    
    public var hasShadow = true {
        didSet {
            if oldValue == hasShadow {
                return
            }
            button?.hasShadow = hasShadow
            button?.setNeedsDisplay()
        }
    }
    
    public var shadowPathRect: CGRect = CGRect.zero {
        didSet {
            if shadowPathRect.equalTo(oldValue) {
                return
            }
            button?.shadowPathRect = shadowPathRect
            button?.setNeedsDisplay()
        }
    }
    
    public var shadowOffsetX: CGFloat = 0 {
        didSet {
            if shadowOffsetX == oldValue {
                return
            }
            button?.shadowOffsetX = shadowOffsetX
            button?.setNeedsDisplay()
        }
    }
    
    public var shadowOffsetY: CGFloat = 8 {
        didSet {
            if shadowOffsetY == oldValue {
                return
            }
            button?.shadowOffsetY = shadowOffsetY
            button?.setNeedsDisplay()
        }
    }
    
    public var shadowRadius: CGFloat = 4 {
        didSet {
            if shadowRadius == oldValue {
                return
            }
            button?.shadowRadius = shadowRadius
            button?.setNeedsDisplay()
        }
    }
    
    public var shadowColor = Utils.color(argb: 0x44000000) {
        didSet {
            if Utils.isSameColor(shadowColor, oldValue) {
                return
            }
            button?.shadowColor = shadowColor
            button?.setNeedsDisplay()
        }
    }
    
    // MARK: - Image
    
    public var normalImageName: String? {
        didSet {
            if normalImageName == oldValue {
                return
            }
            button?.resetNormalImage(builder: self)
            if button?.lastStateEnum == .normal {
                button?.toNormalImage()
            }
        }
    }
    
    public var normalImage: UIImage? {
        didSet {
            if normalImage == oldValue {
                return
            }
            button?.resetNormalImage(builder: self)
            if button?.lastStateEnum == .normal {
                button?.toNormalImage()
            }
        }
    }
    
    public var highlightedImageName: String? {
        didSet {
            if highlightedImageName == oldValue {
                return
            }
            button?.resetHighlightedImage(builder: self)
            if button?.lastStateEnum == .highlighted {
                button?.toHighlightedImage()
            }
        }
    }
    
    public var highlightedImage: UIImage? {
        didSet {
            if highlightedImage == oldValue {
                return
            }
            button?.resetHighlightedImage(builder: self)
            if button?.lastStateEnum == .highlighted {
                button?.toHighlightedImage()
            }
        }
    }
    
    public var unableImageName: String? {
        didSet {
            if unableImageName == oldValue {
                return
            }
            button?.resetUnableImage(builder: self)
            if button?.lastStateEnum == .unable {
                button?.toUnableImage()
            }
        }
    }
    
    public var unableImage: UIImage? {
        didSet {
            if unableImage == oldValue {
                return
            }
            button?.resetUnableImage(builder: self)
            if button?.lastStateEnum == .unable {
                button?.toUnableImage()
            }
        }
    }
    
    public var normalImageTintColor: UIColor? {
        didSet {
            if Utils.isSameColor(normalImageTintColor, oldValue) {
                return
            }
            button?.normalImageTintColor = normalImageTintColor
            button?.resetNormalImage(builder: self)
            if button?.lastStateEnum == .normal {
                button?.toNormalImage()
            }
        }
    }
    
    public var highlightedImageTintColor: UIColor? {
        didSet {
            if Utils.isSameColor(highlightedColor, oldValue) {
                return
            }
            button?.highlightedImageTintColor = highlightedImageTintColor
            button?.resetHighlightedImage(builder: self)
            if button?.lastStateEnum == .highlighted {
                button?.toHighlightedImage()
            }
        }
    }
    
    public var unableImageTintColor: UIColor? {
        didSet {
            if Utils.isSameColor(unableImageTintColor, oldValue) {
                return
            }
            button?.unableImageTintColor = unableImageTintColor
            button?.resetUnableImage(builder: self)
            if button?.lastStateEnum == .unable {
                button?.toUnableImage()
            }
        }
    }
    
    public var imageFrame = CGRect.init(x: 10, y: 10, width: 60, height: 60) {
        didSet {
            if imageFrame.equalTo(oldValue) {
                return
            }
            button?.rotateAnchorPointInitialized = false
            button?.imageFrame = imageFrame
            button?.resetImageView()
        }
    }
    
    public var imageSize = CGSize.init(width: 60, height: 60) {
        didSet {
            if imageSize.equalTo(oldValue) {
                return
            }
            button?.rotateAnchorPointInitialized = false
            button?.imageSize = imageSize
            button?.resetNormalImage(builder: self)
            button?.resetHighlightedImage(builder: self)
            button?.resetUnableImage(builder: self)
            if button?.lastStateEnum == .normal {
                button?.toNormalImage()
            } else if button?.lastStateEnum == .highlighted {
                button?.toHighlightedImage()
            } else if button?.lastStateEnum == .unable {
                button?.toUnableImage()
            }
        }
    }
    
    // MARK: - Button
    
    public var normalColor: UIColor = Utils.color() {
        didSet {
            if Utils.isSameColor(normalColor, oldValue) {
                return
            }
            button?.normalColor = normalColor
            if button?.lastStateEnum == .normal {
                button?.toNormalButton()
            }
            piece?.setColor(color: self.innerPieceColor())
        }
    }
    
    public var highlightedColor: UIColor? = Utils.color() {
        didSet {
            if Utils.isSameColor(highlightedColor, oldValue) {
                return
            }
            button?.highlightedColor = highlightedColor
            if button?.lastStateEnum == .highlighted {
                button?.toHighlightedButton()
            }
            piece?.setColor(color: self.innerPieceColor())
        }
    }
    
    public var unableColor: UIColor? = Utils.color() {
        didSet {
            if Utils.isSameColor(unableColor, oldValue) {
                return
            }
            button?.unableColor = unableColor
            if button?.lastStateEnum == .unable {
                button?.toUnableButton()
            }
            piece?.setColor(color: self.innerPieceColor())
        }
    }
    
    public var cornerRadius: CGFloat = 5 {
        didSet {
            if cornerRadius == oldValue {
                return
            }
            button?.cornerRadius = cornerRadius
            button?.resetButtonLayer()
            button?.resetShadow()
            if button?.lastStateEnum == .normal {
                button?.toNormalButton()
            } else if button?.lastStateEnum == .highlighted {
                button?.toHighlightedButton()
            } else if button?.lastStateEnum == .unable {
                button?.toUnableButton()
            }
        }
    }

    // MARK: - In-BMB-Only Methods
    
    func build() -> BoomButton {
        assert(false, "Method type should be overrided in child class")
    }
    
    func innerPieceColor() -> UIColor {
        if pieceColor != nil {
            return pieceColor!
        } else {
            if unable && unableColor != nil {
                return unableColor!
            } else {
                return normalColor
            }
        }
    }
    
    func type() -> ButtonEnum {
        assert(false, "Method type should be overrided in child class")
    }
}
