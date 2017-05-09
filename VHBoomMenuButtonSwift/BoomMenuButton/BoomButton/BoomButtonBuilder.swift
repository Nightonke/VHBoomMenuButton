//
//  BoomButtonBuilder.swift
//  BoomMenuButton
//
//  Created by Nightonke on 2017/4/28.
//  Copyright © 2017 Nightonke. All rights reserved.
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
    
    /// Event closure when the boom-button corresponding the builder itself is clicked.
    ///
    ///     builder.clickedClosure = { (index: Int) -> Void in
    ///         // logic
    ///     }
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **nil**.
    public var clickedClosure: BoomButtonDidClickClosure? {
        didSet {
            button?.clickedClosure = clickedClosure
        }
    }
    
    /// Whether the boom-button is unable (for click event).
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **false**.
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
    
    /// Whether the image in boom-button plays a rotation animation.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **true**.
    public var rotateImage = true {
        didSet {
            if oldValue == rotateImage {
                return
            }
            button?.rotateImage = rotateImage
        }
    }
    
    // MARK: - Piece
    
    /// The color of the corresponding piece. If the color of piece is nil (by default), then BMB will use the color of boom-button at normal state (if the boom-buttons is unable, then use color at unable state) to draw the piece. If the color of piece is different from boom-button's, then BMB will play a discoloration animation when booming or rebooming.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **nil**.
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
    
    /// Whether the boom-button has a shadow effect.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    /// 
    /// The default value is **true**.
    public var hasShadow = true {
        didSet {
            if oldValue == hasShadow {
                return
            }
            button?.hasShadow = hasShadow
            button?.setNeedsDisplay()
        }
    }
    
    /// The rect of shadow path of boom-button.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value depends on different type of boom-buttons. Check the init methods in builders of different boom-buttons for more information.
    public var shadowPathRect: CGRect = CGRect.zero {
        didSet {
            if shadowPathRect.equalTo(oldValue) {
                return
            }
            button?.shadowPathRect = shadowPathRect
            button?.setNeedsDisplay()
        }
    }
    
    /// The offset (in points) of shadow in x axis.
    /// 
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **0**.
    public var shadowOffsetX: CGFloat = 0 {
        didSet {
            if shadowOffsetX == oldValue {
                return
            }
            button?.shadowOffsetX = shadowOffsetX
            button?.setNeedsDisplay()
        }
    }
    
    /// The offset (in points) of shadow in y axis.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **8**.
    public var shadowOffsetY: CGFloat = 8 {
        didSet {
            if shadowOffsetY == oldValue {
                return
            }
            button?.shadowOffsetY = shadowOffsetY
            button?.setNeedsDisplay()
        }
    }
    
    /// The blur radius (in points) used to render the boom-button's shadow.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **4**.
    public var shadowRadius: CGFloat = 4 {
        didSet {
            if shadowRadius == oldValue {
                return
            }
            button?.shadowRadius = shadowRadius
            button?.setNeedsDisplay()
        }
    }
    
    /// The color of the boom-button's shadow.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **0x44000000**.
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
    
    /// The name of the image on the boom-button at normal state.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **nil**.
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
    
    /// The image on the boom-button at normal state.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **nil**.
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
    
    /// The name of the image on the boom-button at highlighted state.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **nil**.
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
    
    /// The image on the boom-button at highlighted state.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **nil**.
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
    
    /// The name of the image on the boom-button at unable state.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **nil**.
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
    
    /// The image on the boom-button at unable state.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **nil**.
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
    
    /// The tint color of image on boom-button at normal state.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **nil**.
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
    
    /// The tint color of image on boom-button at highlighted state.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **nil**.
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
    
    /// The tint color of image on boom-button at unable state.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **nil**.
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
    
    /// The frame of the image view on boom-button.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is CGRect.init(x: 10, y: 10, width: 60, height: 60).
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
    
    /// The image size of the image view on boom-button.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is CGSize.init(width: 60, height: 60).
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
    
    /// The color of boom-button at normal state.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is a random color.
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
    
    /// The color of boom-button at highlighted state.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is a random color.
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
    
    /// The color of boom-button at unable state.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is a random color.
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
    
    /// The corner radius (in points) of boom-button.
    ///
    /// **Synchronicity:** Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
    ///
    /// The default value is **5**.
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
        return BoomButton.init(builder: self)
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
        return .unknown
    }
}
