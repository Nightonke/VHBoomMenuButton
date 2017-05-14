//
//  BoomMenuButton.swift
//  BoomMenuButton
//
//  Created by Nightonke on 2017/4/26.
//  Copyright © 2017 Nightonke. All rights reserved.
//

import UIKit

typealias DelayClosure = () -> Void

@IBDesignable
public class BoomMenuButton: UIView, BoomButtonDelegate, BackgroundDelegate {

    private static let kFillColorAnimation: String = "kFillColorAnimation"
    private static let kBoomButtonAnimation: String = "kBoomButtonAnimation"
    private static let kBoomButton3DAnimation: String = "kBoomButton3DAnimation"
    private static let kBoomButtonRotateViewAnimation: String = "kBoomButtonRotateViewAnimation"
    private static let kBoomButtonGoneViewAnimation: String = "kBoomButtonGoneViewAnimation"
    private static let kFadeViewAnimation: String = "kFadeViewAnimation"
    
    // MARK: - Public Properties
    
    // MARK: Basic
    
    /// Whether use a cache optimization. If **true** , then the boom-buttons and their background view on screen will be kept by BMB. So BMB doesn't need to re-create them the next time it booms.
    ///
    /// The default value is **true**.
    @IBInspectable public var cacheOptimized: Bool = true
    
    /// Whether the BMB booms its boom-buttons in the whole screen. If **false**, then BMB booms boom-buttons in its superview.
    ///
    /// The default value is **true**.
    @IBInspectable public var isBoomInWholeScreen: Bool = true
    
    /// Whether the BMB is used in a cell of table view. If YES, then BMB will not keep the boom-buttons and the background view to avoid memory leaks and do some re-calculate jobs when table view has been scrolled.
    ///
    /// The default value is **false**.
    @IBInspectable public var isInList: Bool = false
    
    // MARK: Shadow
    
    /// Whether BMB has a shadow.
    ///
    /// The default value is **true**.
    @IBInspectable public var hasShadow: Bool = true {
        didSet {
            if hasShadow != oldValue {
                setNeedsDisplay()
            }
        }
    }
    
    /// Rect (in points) of shadow path of BMB.
    ///
    /// The default value is (2, 2, BMB.width - 4, BMB.height - 4).
    @IBInspectable public var shadowPathRect: CGRect! {
        didSet {
            if shadowPathRect != oldValue {
                setNeedsDisplay()
            }
        }
    }
    
    /// Offset (in points) of shadow on x axis.
    ///
    /// The default value is **0**.
    @IBInspectable public var shadowOffsetX: CGFloat = 0 {
        didSet {
            if shadowOffsetX != oldValue {
                setNeedsDisplay()
            }
        }
    }
    
    /// Offset (in points) of shadow on y axis.
    ///
    /// The default value is **8**.
    @IBInspectable public var shadowOffsetY: CGFloat = 8 {
        didSet {
            if shadowOffsetY != oldValue {
                setNeedsDisplay()
            }
        }
    }
    
    /// The blur radius (in points) used to render the BMB’s shadow.
    ///
    /// The default value is **4**.
    @IBInspectable public var shadowRadius: CGFloat = 4 {
        didSet {
            if shadowRadius != oldValue {
                setNeedsDisplay()
            }
        }
    }
    
    /// The color of BMB's shadow.
    ///
    /// The default value is **0x44000000**.
    @IBInspectable public var shadowColor: UIColor = Utils.color(argb: 0x44000000) {
        didSet {
            if Utils.isSameColor(shadowColor, oldValue) {
                setNeedsDisplay()
            }
        }
    }
    
    // MARK: Button
    
    /// ButtonEnum of BMB. This property tells BMB what kind of boom-button that it needs to boom.
    ///
    /// It should be one of the following enums: 
    /// 1. **simpleCircle**
    /// 2. **textInsideCircle**
    /// 3. **textOutsideCircle**
    /// 4. **ham**
    ///
    /// Notice that ButtonEnum must correspond with PiecePlaceEnum and ButtonPlaceEnum.
    ///
    /// Check https://github.com/Nightonke/VHBoomMenuButton/wiki for more information.
    ///
    /// The default value is **unknown**.
    public var buttonEnum: ButtonEnum = ButtonEnum.unknown {
        didSet {
            if buttonEnum != oldValue {
                clearPieces()
                clearBuilders()
                clearButtons()
                setNeedsDisplay()
            }
        }
    }
    
    /// Whether the BMB has the circular background. BMB should not have a background effect when used in navigation bar or table view.
    ///
    /// The default value is **true**.
    @IBInspectable public var hasBackground: Bool = true {
        didSet {
            if hasBackground != oldValue {
                setNeedsDisplay()
            }
        }
    }
    
    /// The color of BMB at normal state.
    ///
    /// The default value is **0x30a2fb**.
    @IBInspectable public var normalColor: UIColor = Utils.color(rgb: 0x30a2fb) {
        didSet {
            if Utils.isSameColor(normalColor, oldValue) {
                setNeedsDisplay()
            }
        }
    }
    
    /// The color of BMB at highlighted state.
    ///
    /// The default value is **0x73bdf1**.
    @IBInspectable public var highlightedColor: UIColor = Utils.color(rgb: 0x73bdf1) {
        didSet {
            if Utils.isSameColor(highlightedColor, oldValue) {
                setNeedsDisplay()
            }
        }
    }
    
    /// The color of BMB at unable state. BMB can be set to unable state by isUserInteractionEnabled = false.
    ///
    /// The default value is **0x30a2fb**.
    @IBInspectable public var unableColor: UIColor = Utils.color(rgb: 0x30a2fb) {
        didSet {
            if Utils.isSameColor(unableColor, oldValue) {
                setNeedsDisplay()
            }
        }
    }
    
    public override var isUserInteractionEnabled: Bool {
        didSet {
            if isUserInteractionEnabled != oldValue {
                if isUserInteractionEnabled {
                    toNormal()
                } else {
                    toUnable()
                }
            }
        }
    }
    
    /// Whether BMB is draggable. If YES, BMB can be dragged in its superview.
    ///
    /// The default value is **false**.
    @IBInspectable public var draggable: Bool = false
    
    /// The top, left, bottom and right margins in BMB's superview when BMB is draggable.
    ///
    /// The default value is UIEdgeInsets.init(top: 15, left: 15, bottom: 15, right: 15).
    public var edgeInsetsInSuperView: UIEdgeInsets = UIEdgeInsets.init(top: 15, left: 15, bottom: 15, right: 15) {
        didSet {
            if edgeInsetsInSuperView != oldValue {
                preventDragOutside()
            }
        }
    }
    
    // MARK: Piece
    
    /// The radius (in points) of dots on BMB.
    ///
    /// The default value is **3**.
    @IBInspectable public var dotRadius: CGFloat = 3 {
        didSet {
            if dotRadius != oldValue {
                setNeedsLayout()
            }
        }
    }
    
    /// The width (in points) of hams on BMB.
    ///
    /// The default value is **20**.
    @IBInspectable public var hamWidth: CGFloat = 20 {
        didSet {
            if hamWidth != oldValue {
                setNeedsLayout()
            }
        }
    }
    
    /// The height (in points) of hams on BMB.
    ///
    /// The default value is **3**.
    @IBInspectable public var hamHeight: CGFloat = 3 {
        didSet {
            if hamHeight != oldValue {
                setNeedsLayout()
            }
        }
    }
    
    /// The corner radius (in points) of pieces on BMB. Pieces include dots and hams. This property can make the dots look like blocks, which is useful when boom-buttons are square. A negative corner radius does no effect.
    ///
    /// The default value is **-1**.
    @IBInspectable public var pieceCornerRadius: CGFloat = -1 {
        didSet {
            if pieceCornerRadius != oldValue {
                setNeedsLayout()
            }
        }
    }
    
    /// The horizontal margin (in points) of pieces on BMB.
    ///
    /// The default value is **2**.
    @IBInspectable public var pieceHorizontalMargin: CGFloat = 2 {
        didSet {
            if pieceHorizontalMargin != oldValue {
                setNeedsLayout()
            }
        }
    }
    
    /// The vertical margin (in points) of pieces on BMB.
    ///
    /// The default value is **2**.
    @IBInspectable public var pieceVerticalMargin: CGFloat = 2 {
        didSet {
            if pieceVerticalMargin != oldValue {
                setNeedsLayout()
            }
        }
    }
    
    /// The inclined margin (in points) of pieces on BMB.
    ///
    /// The default value is **2**.
    @IBInspectable public var pieceInclinedMargin: CGFloat = 2 {
        didSet {
            if pieceInclinedMargin != oldValue {
                setNeedsLayout()
            }
        }
    }
    
    /// The length (in points) of the 2 lines in share style.
    ///
    /// The default value is **18**.
    @IBInspectable public var shareLineLength: CGFloat = 18 {
        didSet {
            if shareLineLength != oldValue {
                setNeedsLayout()
            }
        }
    }
    
    /// The color of the first line (the higher one) in share style.
    ///
    /// The default value is **UIColor.white**.
    @IBInspectable public var shareLine1Color: UIColor = UIColor.white {
        didSet {
            if Utils.isSameColor(shareLine1Color, oldValue) {
                setNeedsLayout()
            }
        }
    }
    
    /// The color of the second line (the lower one) in share style.
    ///
    /// The default value is **UIColor.white**.
    @IBInspectable public var shareLine2Color: UIColor = UIColor.white {
        didSet {
            if Utils.isSameColor(shareLine2Color, oldValue) {
                setNeedsLayout()
            }
        }
    }
    
    /// The width (in points) of the 2 lines in share style.
    ///
    /// The default value is **1.5**.
    @IBInspectable public var shareLineWidth: CGFloat = 1.5 {
        didSet {
            if shareLineWidth != oldValue {
                setNeedsLayout()
            }
        }
    }
    
    /// PiecePlaceEnum tells BMB how the pieces should be placed on BMB.
    ///
    /// Check PiecePlaceEnum.swift file to check all piece-place-enums.
    ///
    /// Notice that PiecePlaceEnum must correspond with ButtonEnum and ButtonPlaceEnum.
    ///
    /// Check https://github.com/Nightonke/VHBoomMenuButton/wiki for more information.
    public var piecePlaceEnum = PiecePlaceEnum.unknown {
        didSet {
            // We have to clear pieces because the pieces may be changed even though the piece-place-enum is still the same
            clearPieces()
            needToCalculateStartPositions = true
        }
    }
    
    /// The customize-positions of pieces. Only works when the piece-place-enum is **custom**. The elements in positions-array must be CGPoint.
    ///
    /// The default value is an empty array.
    public var customPiecePlacePositions: [CGPoint] = [CGPoint]() {
        didSet {
            clearPieces()
            needToCalculateStartPositions = true
        }
    }
    
    // MARK: Background
    
    /// Whether use a blur background. Notice that blur effect only works on iOS 8.0 or above.
    ///
    /// The default value is **false**.
    @IBInspectable public var backgroundBlurred: Bool = false {
        didSet {
            if backgroundBlurred == oldValue {
                return
            }
            if backgroundBlurred {
                if #available(iOS 8.0, *) {
                    self.background?.backgroundBlurred = backgroundBlurred
                }
            } else {
                self.background?.backgroundBlurred = backgroundBlurred
            }
        }
    }
    
    private var _blurEffect: AnyObject? {
        didSet {
            if _blurEffect == nil {
                return
            }
            if _blurEffect!.isEqual(oldValue) {
                return
            }
            background?.blurEffect = _blurEffect as? UIBlurEffect
        }
    }
    
    /// Blur effect of background. Notice that blur effect only works on iOS 8.0 or above.
    ///
    /// The default value is UIBlurEffect.init(style: UIBlurEffectStyle.dark).
    @available(iOS 8.0, *)
    public var blurEffect: UIBlurEffect? {
        get {
            return _blurEffect as? UIBlurEffect
        }
        set {
            _blurEffect = newValue
        }
    }
    
    /// The color of the background-dim animation when BMB booms.
    ///
    /// The default value is **0x55000000**.
    @IBInspectable public var dimColor: UIColor = Utils.color(argb: 0x55000000) {
        didSet {
            if Utils.isSameColor(dimColor, oldValue) {
                return
            }
            if boomState == .didBoom {
                background?.backgroundColor = dimColor
            }
        }
    }
    
    /// The tip string on background when BMB finishes the booming animation.
    ///
    /// The default value is **nil**.
    @IBInspectable public var tip: String? {
        didSet {
            if tip != oldValue {
                background?.tip = tip
            }
        }
    }
    
    /// Whether the tip string is put below the boom-buttons on background.
    ///
    /// The default value is **false**.
    @IBInspectable public var tipBelowButtons: Bool = false {
        didSet {
            if tipBelowButtons != oldValue {
                adjustTipLabel()
            }
        }
    }
    
    /// The margin (in points) between label of tip and the highest boom-button (if tipBelowButtons is NO) or the lowest boom-button (if tipBelowButtons is false).
    ///
    /// The default value is **40**.
    @IBInspectable public var tipButtonMargin: CGFloat = 40 {
        didSet {
            if tipButtonMargin != oldValue {
                adjustTipLabel()
            }
        }
    }
    
    // MARK: Animation
    
    /// The BoomDelegate of BMB. Check BoomDelegate.swift for more information.
    ///
    /// The default value is **nil**.
    public weak var boomDelegate: BoomDelegate?
    
    /// The delay (in seconds) among each boom-button when booming and rebooming.
    ///
    /// The default value is **0.05**.
    @IBInspectable public var delay: CFTimeInterval {
        get {
            return boomDelay
        }
        set {
            boomDelay = newValue
            reboomDelay = newValue
        }
    }
    
    /// The duration (in seconds) of each boom-button when booming and rebooming.
    ///
    /// The default value is **0.3**.
    @IBInspectable public var duration: CFTimeInterval {
        get {
            return boomDuration
        }
        set {
            boomDuration = newValue
            reboomDuration = newValue
        }
    }
    
    /// The delay (in seconds) among each boom-button when booming.
    ///
    /// The default value is **0.05**.
    @IBInspectable public var boomDelay: CFTimeInterval = 0.05
    
    /// The duration (in seconds) of each boom-button when booming.
    ///
    /// The default value is **0.3**.
    @IBInspectable public var boomDuration: CFTimeInterval = 0.3 {
        didSet {
            if boomDuration <= 0 {
                boomDuration = 0.001
            }
        }
    }
    
    /// The delay (in seconds) among each boom-button when rebooming.
    ///
    /// The default value is **0.05**.
    @IBInspectable public var reboomDelay: CFTimeInterval = 0.05
    
    /// The duration (in seconds) of each boom-button when rebooming.
    ///
    /// The default value is **0.3**.
    @IBInspectable public var reboomDuration: CFTimeInterval = 0.3 {
        didSet {
            if reboomDuration <= 0 {
                reboomDuration = 0.001
            }
        }
    }
    
    /// Whether BMB rebooms when the background view is clicked.
    ///
    /// The default value is **true**.
    @IBInspectable public var cancelable: Bool = true
    
    /// Whether BMB rebooms when one of the boom-buttons is clicked.
    ///
    /// The default value is **true**.
    @IBInspectable public var autoHide: Bool = true
    
    /// The order of animtions of boom-buttons when booming and rebooming.
    ///
    /// The default value is **random**.
    public var orderEnum = OrderEnum.random
    
    /// How many frames should the booming and rebooming animations have.
    ///
    /// The default value is **60**.
    @IBInspectable public var frames: Int = 60
    
    /// The boom-enum of booming and rebooming animations. This property changes the track of the boom-buttons' movement.
    ///
    /// The default value is **horizontalThrow2**.
    @IBInspectable public var boomEnum = BoomEnum.horizontalThrow2
    
    /// The name of the ease using in movement, scale and rotation animations of boom-buttons when booming. This property is used to change movement, scale and rotation animations' ease name with a line of code.
    ///
    /// Check Ease.swift to find all the ease-names supported by BMB.
    ///
    /// The default value is **outBack**.
    public var boomEaseName: String! = Ease.outBack {
        didSet {
            boomMoveEaseName = boomEaseName
            boomScaleEaseName = boomEaseName
            boomRotateEaseName = boomEaseName
        }
    }
    
    /// The time-interpolator using in movement, scale and rotation animations of boom-buttons when booming. This property is used to change movement, scale and rotation animations' ease name with a line of code.
    ///
    /// The default value is **outBack-ease**.
    public var boomEase: TimeInterpolator! = Ease.ease(name: Ease.outBack) {
        didSet {
            boomMoveEase = boomEase
            boomScaleEase = boomEase
            boomRotateEase = boomEase
        }
    }
    
    /// The name of the ease using in movement animations of boom-buttons when booming.
    ///
    /// Check Ease.swift to find all the ease-names supported by BMB.
    ///
    /// The default value is **outBack**.
    public var boomMoveEaseName = Ease.outBack {
        didSet {
            boomMoveEase = Ease.ease(name: boomMoveEaseName)
        }
    }
    
    /// The time-interpolator using in movement animations of boom-buttons when booming.
    ///
    /// The default value is **out-back-ease**.
    public var boomMoveEase: TimeInterpolator! = Ease.ease(name: Ease.outBack)
    
    /// The name of the ease using in scale animations of boom-buttons when booming.
    ///
    /// Check Ease.swift to find all the ease-names supported by BMB.
    ///
    /// The default value is **outBack**.
    public var boomScaleEaseName = Ease.outBack {
        didSet {
            boomScaleEase = Ease.ease(name: boomScaleEaseName)
        }
    }
    
    /// The time-interpolator using in scale animations of boom-buttons when booming.
    ///
    /// The default value is **out-back-ease**.
    public var boomScaleEase: TimeInterpolator! = Ease.ease(name: Ease.outBack)
    
    /// The name of the ease using in rotation animations of boom-buttons when booming.
    ///
    /// Check Ease.swift to find all the ease-names supported by BMB.
    ///
    /// The default value is **outBack**.
    public var boomRotateEaseName = Ease.outBack {
        didSet {
            boomRotateEase = Ease.ease(name: boomRotateEaseName)
        }
    }
    
    /// The time-interpolator using in rotation animations of boom-buttons when booming.
    ///
    /// The default value is **out-back-ease**.
    public var boomRotateEase: TimeInterpolator! = Ease.ease(name: Ease.outBack)
    
    /// The name of the ease using in movement, scale and rotation animations of boom-buttons when rebooming. This property is used to change movement, scale and rotation animations' ease name with a line of code.
    ///
    /// Check Ease.swift to find all the ease-names supported by BMB.
    ///
    /// The default value is **inBack**.
    public var reboomEaseName: String! = Ease.inBack {
        didSet {
            reboomMoveEaseName = reboomEaseName
            reboomScaleEaseName = reboomEaseName
            reboomRotateEaseName = reboomEaseName
        }
    }
    
    /// The time-interpolator using in movement, scale and rotation animations of boom-buttons when rebooming. This property is used to change movement, scale and rotation animations' ease name with a line of code.
    ///
    /// The default value is **in-back-ease**.
    public var reboomEase: TimeInterpolator! = Ease.ease(name: Ease.inBack) {
        didSet {
            reboomMoveEase = reboomEase
            reboomScaleEase = reboomEase
            reboomRotateEase = reboomEase
        }
    }
    
    /// The name of the ease using in movement animations of boom-buttons when rebooming.
    ///
    /// Check Ease.swift to find all the ease-names supported by BMB.
    ///
    /// The default value is **inBack**.
    public var reboomMoveEaseName = Ease.inBack {
        didSet {
            reboomMoveEase = Ease.ease(name: reboomMoveEaseName)
        }
    }
    
    /// The time-interpolator using in movement animations of boom-buttons when rebooming.
    ///
    /// The default value is **in-back-ease**.
    public var reboomMoveEase: TimeInterpolator! = Ease.ease(name: Ease.inBack)
    
    /// The name of the ease using in scale animations of boom-buttons when rebooming.
    ///
    /// Check Ease.swift to find all the ease-names supported by BMB.
    ///
    /// The default value is **inBack**.
    public var reboomScaleEaseName = Ease.inBack {
        didSet {
            reboomScaleEase = Ease.ease(name: reboomScaleEaseName)
        }
    }
    
    /// The time-interpolator using in scale animations of boom-buttons when rebooming.
    ///
    /// The default value is **in-back-ease**.
    public var reboomScaleEase: TimeInterpolator! = Ease.ease(name: Ease.inBack)
    
    /// The name of the ease using in rotation animations of boom-buttons when rebooming.
    ///
    /// Check Ease.swift to find all the ease-names supported by BMB.
    ///
    /// The default value is **inBack**.
    public var reboomRotateEaseName = Ease.inBack {
        didSet {
            reboomRotateEase = Ease.ease(name: reboomRotateEaseName)
        }
    }
    
    /// The time-interpolator using in rotation animations of boom-buttons when rebooming.
    ///
    /// The default value is **in-back-ease**.
    public var reboomRotateEase: TimeInterpolator! = Ease.ease(name: Ease.inBack)
    
    /// The degree (in π) of rotation animations when booming. In reboomming, the value is -degree.
    ///
    /// The default value is **4π**.
    @IBInspectable public var rotateDegree: CGFloat = 4 * CGFloat.pi
    
    /// Whether use a 3D transform animation when booming or rebooming.
    ///
    /// The default value is **true**.
    @IBInspectable public var use3DTransformAnimation: Bool = true
    
    /// Whether BMB will boom automatically with animations when its drawRect method is called. This property can be useful if the BMB is supposed to boom when its view-controller appears.
    ///
    /// The default value is **false**.
    @IBInspectable public var autoBoom: Bool = false
    
    /// Whether BMB will boom automatically without animations when its drawRect method is called. This property can be useful if the BMB is supposed to boom when its view-controller appears.
    ///
    /// The default value is **false**.
    @IBInspectable public var autoBoomImmediately: Bool = false
    
    // MARK: Boom Buttons
    
    /// ButtonPlaceEnum tells BMB how the boom-buttons should be placed on the background when booming.
    ///
    /// Check ButtonPlaceEnum.swift file to check all button-place-enums.
    ///
    /// Notice that ButtonPlaceEnum must correspond with ButtonEnum and PiecePlaceEnum.
    ///
    /// Check https://github.com/Nightonke/VHBoomMenuButton/wiki for more information.
    ///
    /// The default value is **unknown** .
    public var buttonPlaceEnum = ButtonPlaceEnum.unknown {
        didSet {
            // We have to clear pieces because the buttons may be changed even though the button-place-enum is still the same
            clearButtons()
            needToCalculateStartPositions = true
        }
    }
    
    /// The customize-positions of boom-buttons. Only works when the button-place-enum is **custom**. The elements in positions-array must be CGPoint.
    ///
    /// The default value is an empty array.
    public var customButtonPlacePositions: [CGPoint] = [CGPoint]() {
        didSet {
            clearButtons()
            needToCalculateStartPositions = true
        }
    }
    
    /// ButtonPlaceAlignmentEnum tells BMB the boom-buttons' alignment position. For instance, you can put all the boom-buttons align-bottom with ButtonPlaceAlignmentEnum.bottom.
    ///
    /// The default value is **ButtonPlaceAlignmentEnum.center**.
    public var buttonPlaceAlignmentEnum = ButtonPlaceAlignmentEnum.center
    
    /// The horizontal margin (in points) among boom-buttons.
    ///
    /// The default value is **12**.
    @IBInspectable public var buttonHorizontalMargin: CGFloat = 12
    
    /// The vertical margin (in points) among boom-buttons.
    ///
    /// The default value is **12**.
    @IBInspectable public var buttonVerticalMargin: CGFloat = 12
    
    /// The inclined margin (in points) among boom-buttons.
    ///
    /// The default value is **12**.
    @IBInspectable public var buttonInclinedMargin: CGFloat = 12
    
    /// The margin (in points) between boom-buttons and the bottom of screen when booming. Notice that this property only works when buttonPlaceAlignmentEnum is bottom, bottomLeft or bottomRight.
    ///
    /// The default value is **20**.
    @IBInspectable public var buttonBottomMargin: CGFloat = 20
    
    /// The margin (in points) between boom-buttons and the top of screen when booming. Notice that this property only works when buttonPlaceAlignmentEnum is top, topLeft and topRight.
    ///
    /// The default value is **20**.
    @IBInspectable public var buttonTopMargin: CGFloat = 20
    
    /// The margin (in points) between boom-buttons and the left of screen when booming. Notice that this property only works when buttonPlaceAlignmentEnum is left, topLeft or bottomLeft.
    ///
    /// The default value is **20**.
    @IBInspectable public var buttonLeftMargin: CGFloat = 20
    
    /// The margin (in points) between boom-buttons and the right of screen when booming. Notice that this property only works when buttonPlaceAlignmentEnum is right, topRight or bottomRight.
    ///
    /// The default value is **20**.
    @IBInspectable public var buttonRightMargin: CGFloat = 20
    
    /// The margin (in points) between the last boom-button and the last but one. This property is useful when the last boom-button is used as a 'Cancel' choice. Notice that this property only works when buttonEnum is ham and its value must be positive.
    ///
    /// The default value is **-1**.
    @IBInspectable public var buttonHamButtonTopMargin: CGFloat = -1
    
    // MARK: - Private Properties
    
    // MARK: Button
    
    private var startPositionX: CGFloat = 0
    private var startPositionY: CGFloat = 0
    private var ableToStartDragging = false
    private var isDragging = false
    private var buttonLayer: CAShapeLayer?
    private var lastButtonState = ButtonStateEnum.unknown
    
    // MARK: Piece
    
    private var pieces = [BoomPiece]()
    private var piecePositions = [CGRect]()
    private var shareLinesView: ShareLinesView?
    
    // MARK: Animation
    
    private var animatingViewsNumber = 0
    private var boomState = BoomStateEnum.didReboom
    
    // MARK: Background
    
    private var background: BackgroundView?
    private var _tipLabel: UILabel?
    
    // MARK: Boom Buttons
    
    private var boomButtons = [BoomButton]()
    private var boomButtonBuilders = [BoomButtonBuilder]()
    private var simpleCircleButtonRadius: CGFloat = 0
    private var textInsideCircleButtonRadius: CGFloat = 0
    private var textOutsideCircleButtonWidth: CGFloat = 0
    private var textOutsideCircleButtonHeight: CGFloat = 0
    private var hamButtonWidth: CGFloat = 0
    private var hamButtonHeight: CGFloat = 0
    private var startPositions = [CGPoint]()
    private var endPositions = [CGPoint]()
    private var needToCalculateStartPositions = true
    private var needToCreateButtons = true
    
    // MARK: Device Orientation
    
    private var lastDeviceOrientation = UIDevice.current.orientation
    
    // MARK: Fade Views
    
    private var fadeViews: [UIView] = [UIView]()
    
    // MARK: - Initialize
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        innerInitialize()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        innerInitialize()
    }
    
    private func innerInitialize() {
        initializeAttributes()
        initializeDeviceOrientation()
    }
    
    private func initializeAttributes() {
        shadowPathRect = CGRect.init(x: 2, y: 2, width: frame.size.width - 4, height: frame.size.height - 4)
        if #available(iOS 8, *) {
            blurEffect = UIBlurEffect.init(style: UIBlurEffectStyle.dark)
        }
    }
    
    private func initializeDeviceOrientation() {
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.deviceOrientationDidChange(notification:)),
                                               name: .UIDeviceOrientationDidChange,
                                               object: nil)
    }
    
    deinit {
        clearViews(force: true)
        NotificationCenter.default.removeObserver(self)
        UIDevice.current.endGeneratingDeviceOrientationNotifications()
    }
    
    // MARK: - Draw
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        if hasBackground && !isInList {
            if buttonLayer != nil {
               buttonLayer?.removeFromSuperlayer()
            } else {
                buttonLayer = CAShapeLayer.init()
            }
            buttonLayer!.path = UIBezierPath.init(ovalIn: CGRect.init(x: 0, y: 0, width: frame.size.width, height: frame.size.height)).cgPath
            toLastState()
            layer.addSublayer(buttonLayer!)
            
            if hasShadow {
                layer.masksToBounds = false
                layer.shadowPath = UIBezierPath.init(ovalIn: shadowPathRect).cgPath
                layer.shadowOffset = CGSize.init(width: shadowOffsetX, height: shadowOffsetY)
                layer.shadowRadius = shadowRadius
                layer.shadowColor = shadowColor.cgColor
                layer.shadowOpacity = 1
            } else {
                layer.shadowOpacity = 0
            }
        } else {
            buttonLayer?.removeFromSuperlayer()
            layer.shadowOpacity = 0
        }
        checkAutoBoom()
    }
    
    // MARK: - Place Pieces
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = UIColor.clear
        if uninitializedBoomButtons() {
            return
        }
        placeFadeViews()
        clearPieces()
        createPieces()
        placeShareLinesView()
        placePieces()
        calculateStartPositions(force: false)
        setShareLinesViewData()
    }
    
    private func clearPieces() {
        for piece in pieces {
            piece.removeFromSuperview()
        }
        pieces.removeAll()
    }
    
    private func createPieces() {
        calculatePiecePositions()
        let pieceNumber = self.pieceNumber()
        pieces = [BoomPiece]()
        for i in 0..<pieceNumber {
            pieces.append(BoomPiece.init(frame: piecePositions[i], builder: boomButtonBuilders[i], cornerRadius: pieceCornerRadius))
        }
    }
    
    private func placePieces() {
        var indexes: [Int]
        if piecePlaceEnum == .share {
            indexes = AnimationManager.orderIndexes(orderEnum: .inOrder, size: pieces.count)
        } else {
            indexes = AnimationManager.orderIndexes(orderEnum: orderEnum, size: pieces.count)
        }
        for i in indexes.reversed() {
            self.addSubview(pieces[i])
            if boomState != .didReboom {
                pieces[i].isHidden = true
            }
        }
        if piecePlaceEnum == .share {
            // For share-style, the edges of overrided pieces are still visible.
            // So we have to make them hidden.
            var pieceNumbers: [Int] = Array<Int>.init(repeating: 0, count: 3)
            for i in 0..<pieceNumber() {
                pieceNumbers[i % 3] += 1
            }
            var piecesOn3Positions: [[BoomPiece]] = Array<[BoomPiece]>.init(repeating: [BoomPiece](), count: 3)
            var currentPosition = 0
            for piece in pieces {
                piecesOn3Positions[currentPosition].append(piece)
                if piecesOn3Positions[currentPosition].count >= pieceNumbers[currentPosition] {
                    currentPosition += 1
                }
            }
            
            piecesOn3Positions[0].first?.isTop = true
            piecesOn3Positions[1].first?.isTop = true
            piecesOn3Positions[2].first?.isTop = true
            
            for piecesOnSamePosition in piecesOn3Positions {
                for (idx, piece) in piecesOnSamePosition.enumerated() {
                    if idx + 1 < piecesOnSamePosition.count {
                        piece.pieceBelow = piecesOnSamePosition[idx + 1]
                    }
                }
            }
            
            for piece in pieces {
                piece.isHidden = !piece.isTop
            }
        }
    }
    
    private func calculatePiecePositions() {
        if piecePlaceEnum == .unknown {
            return
        }
        switch buttonEnum {
        case .simpleCircle, .textInsideCircle, .textOutsideCircle:
            if piecePlaceEnum == .share {
                piecePositions = PiecePlaceManager.shareDotPositions(dotNumber: boomButtonBuilders.count, boomMenuButton: self)
            } else {
                piecePositions = PiecePlaceManager.dotPositions(boomMenuButton: self)
            }
        case .ham:
            piecePositions = PiecePlaceManager.hamPositions(boomMenuButton: self)
        case .unknown:
            break
        }
    }
    
    // MARK: - Touch Action
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let anyTouch = touches.first
        let touchLocation = anyTouch?.location(in: self)
        if touchLocation != nil && bounds.contains(touchLocation!) && isUserInteractionEnabled {
            toHighlighted()
            if draggable {
                startPositionX = touchLocation!.x
                startPositionY = touchLocation!.y
                ableToStartDragging = true
            }
        }
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let anyTouch = touches.first
        if draggable && ableToStartDragging {
            isDragging = true
            if let touchLocationInParent = anyTouch?.location(in: superview) {
                frame.origin.x = touchLocationInParent.x - startPositionX
                frame.origin.y = touchLocationInParent.y - startPositionY
            }
        } else {
            let touchLocation = anyTouch?.location(in: self)
            if touchLocation != nil && !bounds.contains(touchLocation!) {
                toNormal()
            }
        }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isDragging {
            ableToStartDragging = false
            isDragging = false
            needToCalculateStartPositions = true
            preventDragOutside()
        } else {
            let anyTouch = touches.first
            let touchLocation = anyTouch?.location(in: self)
            if touchLocation != nil && bounds.contains(touchLocation!) {
                boom()
            }
        }
        toNormal()
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        toNormal()
        if isDragging {
            ableToStartDragging = false
            isDragging = false
            needToCalculateStartPositions = true
            preventDragOutside()
        }
    }
    
    private func toUnable() {
        if lastButtonState == .unable {
            return
        }
        lastButtonState = .unable
        buttonLayer?.fillColor = unableColor.cgColor
    }
    
    private func toHighlighted() {
        if lastButtonState == .highlighted {
            return
        }
        lastButtonState = .highlighted
        buttonLayer?.fillColor = highlightedColor.cgColor
    }
    
    private func toNormal() {
        if lastButtonState == .normal {
            return
        }
        lastButtonState = .normal
        buttonLayer?.fillColor = normalColor.cgColor
    }
    
    private func toLastState() {
        switch lastButtonState {
        case .highlighted:
            buttonLayer?.fillColor = highlightedColor.cgColor
        case .unable:
            buttonLayer?.fillColor = unableColor.cgColor
        case .normal, .unknown:
            buttonLayer?.fillColor = normalColor.cgColor
        }
    }
    
    // MARK: - Animation
    
    /// Whether BMB is animating.
    ///
    /// - Returns: Is animating.
    public func isAnimating() -> Bool! {
        return animatingViewsNumber != 0
    }
    
    /// Whether BMB is boomed.
    ///
    /// - Returns: Is boomed.
    public func isBoomed() -> Bool! {
        return boomState == .didBoom
    }
    
    /// Whether BMB is reboomed.
    ///
    /// - Returns: Is reboomed.
    public func isReboomed() -> Bool! {
        return boomState == .didReboom
    }
    
    /// Make BMB boom. BMB can only boom when it's NOT animating and it has finished rebooming.
    public func boom() {
        innerBoom(immediately: false)
    }
    
    /// Make BMB boom immediately without animation. In fact, this method does the same job as boom with 1-millisecond duration.
    public func boomImmediately() {
        innerBoom(immediately: true)
    }
    
    private func innerBoom(immediately: Bool) {
        if isAnimating() || boomState != .didReboom {
            return
        }
        ErrorManager.judge(boomMenuButton: self, withBuilders: self.boomButtonBuilders)
        boomState = .willBoom
        boomDelegate?.boomMenuButtonWillBoom?(boomMenuButton: self)
        calculateStartPositions(force: false)
        createButtons()
        dimBackground(immediately: immediately)
        startBoomAnimations(immediately: immediately)
        startBoomAnimationForFadeViews(immediately: immediately)
        adjustTipLabel()
    }
    
    /// Make BMB reboom. BMB can only reboom when it's NOT animatiing and it has finished booming.
    public func reboom() {
        innerReboom(immediately: false)
    }
    
    /// Make BMB reboom immdiately without animation. In fact, this method does the same job as reboom with 1-millisecond duration.
    public func reboomImmediately() {
        innerReboom(immediately: true)
    }
    
    private func innerReboom(immediately: Bool) {
        if isAnimating() || boomState != .didBoom {
            return
        }
        boomState = .willReboom
        boomDelegate?.boomMenuButtonWillReboom?(boomMenuButton: self)
        lightBackground(immediately: immediately)
        startReboomAnimation(immediately: immediately)
        startReboomAnimationForFadeViews(immediately: immediately)
    }
    
    private func dimBackground(immediately: Bool) {
        createBackground()
        let duration = immediately ? 0.001 : boomDuration + CFTimeInterval(pieces.count - 1) * boomDelay
        background?.dim(duration: duration, completion: { (finished) in
            self.boomState = .didBoom
            self.boomDelegate?.boomMenuButtonDidBoom?(boomMenuButton: self)
        })
    }
    
    private func lightBackground(immediately: Bool) {
        createBackground()
        let duration = immediately ? 0.001 : reboomDuration + CFTimeInterval(pieces.count - 1) * reboomDelay
        background?.light(duration: duration, completion: nil)
    }
    
    private func finishReboomAnimations() {
        if isAnimating() {
            return
        }
        boomState = .didReboom
        boomDelegate?.boomMenuButtonDidReboom?(boomMenuButton: self)
        background?.isHidden = true
        clearViews(force: false)
    }
    
    private func startBoomAnimations(immediately: Bool) {
        background?.removeAllBoomButtons()
        calculateEndPositions()
        var indexes = [Int]()
        if piecePlaceEnum == .share {
            indexes = AnimationManager.orderIndexes(orderEnum: .inOrder, size: pieces.count)
        } else {
            indexes = AnimationManager.orderIndexes(orderEnum: orderEnum, size: pieces.count)
        }
        for i in (0..<indexes.count).reversed() {
            let index = indexes[i]
            let boomButton = boomButtons[index]
            let startPosition = startPositions[index]
            let startPositionOfBoomButton = startPosition
            placeBoomButton(boomButton, inBackgroundWithPosition: startPositionOfBoomButton)
            startEachBoomAnimation(piece: pieces[index],
                                   boomButton: boomButton,
                                   startPosition: startPositionOfBoomButton,
                                   endPosition: endPositions[index],
                                   delayFactor: i,
                                   immediately: immediately)
        }
    }
    
    private func startReboomAnimation(immediately: Bool) {
        var indexes = [Int]()
        if piecePlaceEnum == .share {
            indexes = AnimationManager.orderIndexes(orderEnum: .reverse, size: pieces.count)
        } else {
            indexes = AnimationManager.orderIndexes(orderEnum: orderEnum, size: pieces.count)
        }
        for i in 0..<indexes.count {
            let index = indexes[i]
            let boomButton = boomButtons[index]
            let startPosition = startPositions[index]
            let startPositionOfBoomButton = startPosition
            startEachReboomAnimation(piece: pieces[index],
                                     boomButton: boomButton,
                                     startPosition: endPositions[index],
                                     endPosition: startPositionOfBoomButton,
                                     delayFactor: i,
                                     immediately: immediately)
        }
    }
    
    private func startEachBoomAnimation(piece: BoomPiece,
                                        boomButton: BoomButton,
                                        startPosition: CGPoint,
                                        endPosition: CGPoint,
                                        delayFactor: Int,
                                        immediately: Bool) {
        animatingViewsNumber += 1
        var xs = Array<CGFloat>.init(repeating: 0, count: frames + 1)
        var ys = Array<CGFloat>.init(repeating: 0, count: frames + 1)
        let scaleX = piece.frame.size.width / boomButton.buttonWidth()
        let scaleY = piece.frame.size.height / boomButton.buttonHeight()
        let delay = immediately ? 0 : boomDelay * CFTimeInterval(delayFactor)
        let duration = immediately ? 0.001 : boomDuration
        boomButton.setRotateAnchorPoints()
        boomButton.setAnchorPointOfLayer()
        boomButton.hideAllGoneViews()
        boomButton.isUserInteractionEnabled = false
        let buttonMaxHeight = self.buttonMaxHeight()
        boomButton.layer.zPosition = buttonMaxHeight * CGFloat(boomButtons.count + 1) - CGFloat(delayFactor) * buttonMaxHeight
        if use3DTransformAnimation {
            var transform3d = CATransform3DIdentity
            transform3d.m34 = 1.0 / 500
            boomButton.layer.transform = transform3d
        }
        AnimationManager.calculateBoomXY(boomEnum: boomEnum,
                                         parentSize: background!.bounds.size,
                                         ease: boomMoveEase,
                                         frames: frames,
                                         startPosition: startPosition,
                                         endPosition: endPosition,
                                         xValues: &xs,
                                         yValues: &ys)
        let delayClosure: DelayClosure = {
            // onAnimationStart
            piece.isHidden = true
            boomButton.isHidden = false
            boomButton.willBoom()
            if self.piecePlaceEnum == .share {
                self.shareLinesView?.pieceStartShowAnimation(atIndex: delayFactor,
                                                        withDuration: immediately ? 0.001 : self.boomDelay)
                piece.pieceBelow?.isHidden = false
            }
            CATransaction.begin()
            CATransaction.setCompletionBlock({ 
                // onAnimationEnd
                boomButton.isUserInteractionEnabled = true
                boomButton.didBoom()
                self.animatingViewsNumber -= 1
            })
            
            if boomButton.needsColorAnimation() {
                let fillColorAnimation = AnimationManager.boomColorAnimation("fillColor",
                                                                             delay: 0,
                                                                             duration: duration,
                                                                             start: boomButton.pieceColor!,
                                                                             end: boomButton.buttonColor())
                boomButton.buttonLayer?.add(fillColorAnimation, forKey: BoomMenuButton.kFillColorAnimation)
            } else {
                boomButton.buttonLayer?.removeAnimation(forKey: BoomMenuButton.kFillColorAnimation)
            }
            
            let xPositionAnimation = AnimationManager.animate("position.x", delay: 0, duration: duration, values: xs)
            xPositionAnimation.isRemovedOnCompletion = true
            let yPositionAnimation = AnimationManager.animate("position.y", delay: 0, duration: duration, values: ys)
            yPositionAnimation.isRemovedOnCompletion = true
            let rotateAnimation = AnimationManager.animate("transform.rotation.z",
                                                           delay: 0,
                                                           duration: duration,
                                                           ease: self.boomRotateEase,
                                                           frames: self.frames,
                                                           start: 0,
                                                           end: self.rotateDegree)
            let opacityAnimation = AnimationManager.animate("opacity", delay: 0, duration: duration, values: Array<Int>.init(arrayLiteral: 0, 1))
            let xScaleAnimation = AnimationManager.animate("transform.scale.x",
                                                           delay: 0,
                                                           duration: duration,
                                                           ease: self.boomScaleEase,
                                                           frames: self.frames,
                                                           start: scaleX,
                                                           end: 1)
            let yScaleAnimation = AnimationManager.animate("transform.scale.y",
                                                           delay: 0,
                                                           duration: duration,
                                                           ease: self.boomScaleEase,
                                                           frames: self.frames,
                                                           start: scaleY,
                                                           end: 1)
            AnimationManager.addAnimations(view: boomButton,
                                           key: BoomMenuButton.kBoomButtonAnimation,
                                           animations: xPositionAnimation, yPositionAnimation, xScaleAnimation, yScaleAnimation)
            AnimationManager.addAnimation(animation: rotateAnimation,
                                          key: BoomMenuButton.kBoomButtonRotateViewAnimation,
                                          views: boomButton.rotateViews())
            AnimationManager.addAnimation(animation: opacityAnimation,
                                          key: BoomMenuButton.kBoomButtonGoneViewAnimation,
                                          views: boomButton.goneViews())
            
            if self.use3DTransformAnimation {
                let rotateXAnimation = AnimationManager.rotateXAnimation(ys: ys, delay: 0, duration: duration)
                let rotateYAnimation = AnimationManager.rotateYAnimation(xs: xs, delay: 0, duration: duration)
                AnimationManager.addAnimations(view: boomButton,
                                               key: BoomMenuButton.kBoomButton3DAnimation,
                                               animations: rotateXAnimation, rotateYAnimation)
            }
            
            boomButton.frame = CGRect.init(x: endPosition.x - boomButton.centerPoint().x,
                                           y: endPosition.y - boomButton.centerPoint().y,
                                           width: boomButton.frame.size.width,
                                           height: boomButton.frame.size.height)
            
            CATransaction.commit()
        }
        self.delay(delay, toExecute: delayClosure)
    }
    
    private func startEachReboomAnimation(piece: BoomPiece,
                                          boomButton: BoomButton,
                                          startPosition: CGPoint,
                                          endPosition: CGPoint,
                                          delayFactor: Int,
                                          immediately: Bool) {
        animatingViewsNumber += 1
        var xs = Array<CGFloat>.init(repeating: 0, count: frames + 1)
        var ys = Array<CGFloat>.init(repeating: 0, count: frames + 1)
        let scaleX = piece.frame.size.width / boomButton.buttonWidth()
        let scaleY = piece.frame.size.height / boomButton.buttonHeight()
        let delay = immediately ? 0 : reboomDelay * CFTimeInterval(delayFactor)
        let duration = immediately ? 0.001 : reboomDuration
        boomButton.setRotateAnchorPoints()
        boomButton.setAnchorPointOfLayer()
        boomButton.isUserInteractionEnabled = false
        let buttonMaxHeight = self.buttonMaxHeight()
        boomButton.layer.zPosition = CGFloat(delayFactor + 1) * buttonMaxHeight
        if use3DTransformAnimation {
            var transform3d = CATransform3DIdentity
            transform3d.m34 = 1.0 / 500
            boomButton.layer.transform = transform3d
        }
        AnimationManager.calculateReboomXY(boomEnum: boomEnum,
                                           parentSize: background!.bounds.size,
                                           ease: reboomMoveEase,
                                           frames: frames,
                                           startPosition: startPosition,
                                           endPosition: endPosition,
                                           xValues: &xs,
                                           yValues: &ys)
        let delayClosure: DelayClosure = {
            // onAnimationStart
            boomButton.willReboom()
            
            CATransaction.begin()
            CATransaction.setCompletionBlock { 
                // onAnimationEnd
                piece.isHidden = false
                boomButton.isHidden = true
                boomButton.didReboom()
                boomButton.clearListener()
                self.animatingViewsNumber -= 1
                self.finishReboomAnimations()
                
                if self.piecePlaceEnum == .share {
                    self.shareLinesView?.pieceFinishHideAnimation(atIndex: self.pieceNumber() - delayFactor - 1,
                                                                  withDuration: immediately ? 0.001 : self.reboomDelay)
                    piece.pieceBelow?.isHidden = true
                }
            }
            
            if boomButton.needsColorAnimation() {
                let fillColorAnimation = AnimationManager.boomColorAnimation("fillColor",
                                                                             delay: 0,
                                                                             duration: duration,
                                                                             start: boomButton.buttonColor(),
                                                                             end: boomButton.pieceColor!)
                boomButton.buttonLayer?.add(fillColorAnimation, forKey: BoomMenuButton.kFillColorAnimation)
            } else {
                boomButton.buttonLayer?.removeAnimation(forKey: BoomMenuButton.kFillColorAnimation)
            }
            
            let xPositionAnimation = AnimationManager.animate("position.x", delay: 0, duration: duration, values: xs)
            xPositionAnimation.isRemovedOnCompletion = true
            let yPositionAnimation = AnimationManager.animate("position.y", delay: 0, duration: duration, values: ys)
            yPositionAnimation.isRemovedOnCompletion = true
            let rotateAnimation = AnimationManager.animate("transform.rotation.z",
                                                           delay: 0,
                                                           duration: duration,
                                                           ease: self.reboomRotateEase,
                                                           frames: self.frames,
                                                           start: 0,
                                                           end: -self.rotateDegree)
            let opacityAnimation = AnimationManager.animate("opacity", delay: 0, duration: duration, values: Array<Int>.init(arrayLiteral: 1, 0))
            let xScaleAnimation = AnimationManager.animate("transform.scale.x",
                                                           delay: 0,
                                                           duration: duration,
                                                           ease: self.reboomScaleEase,
                                                           frames: self.frames,
                                                           start: 1,
                                                           end: scaleX)
            let yScaleAnimation = AnimationManager.animate("transform.scale.y",
                                                           delay: 0,
                                                           duration: duration,
                                                           ease: self.reboomScaleEase,
                                                           frames: self.frames,
                                                           start: 1,
                                                           end: scaleY)
            AnimationManager.addAnimations(view: boomButton,
                                           key: BoomMenuButton.kBoomButtonAnimation,
                                           animations: xPositionAnimation, yPositionAnimation, xScaleAnimation, yScaleAnimation)
            AnimationManager.addAnimation(animation: rotateAnimation,
                                          key: BoomMenuButton.kBoomButtonRotateViewAnimation,
                                          views: boomButton.rotateViews())
            AnimationManager.addAnimation(animation: opacityAnimation,
                                          key: BoomMenuButton.kBoomButtonGoneViewAnimation,
                                          views: boomButton.goneViews())
            
            if self.use3DTransformAnimation {
                let rotateXAnimation = AnimationManager.rotateXAnimation(ys: ys, delay: 0, duration: duration)
                let rotateYAnimation = AnimationManager.rotateYAnimation(xs: xs, delay: 0, duration: duration)
                AnimationManager.addAnimations(view: boomButton, 
                                               key: BoomMenuButton.kBoomButton3DAnimation,
                                               animations: rotateXAnimation, rotateYAnimation)
            }
            
            boomButton.frame = CGRect.init(x: endPosition.x - boomButton.centerPoint().x,
                                           y: endPosition.y - boomButton.centerPoint().y,
                                           width: boomButton.frame.size.width,
                                           height: boomButton.frame.size.height)
            
            CATransaction.commit()
        }
        self.delay(delay, toExecute: delayClosure)
    }
    
    // MARK: - Support Methods
    
    private func createBackground() {
        if background == nil && parentView() != nil {
            background = BackgroundView.init(frame: parentView()!.bounds, boomMenuButton: self)
            if _tipLabel != nil {
                // tip-label has been set by developer
                background?.tipLabel = _tipLabel!
            } else {
                _tipLabel = background?.tipLabel
            }
            background?.tip = tip
            parentView()!.addSubview(background!)
        }
        if boomState == .didReboom {
            background?.isHidden = true
        }
    }
    
    private func createButtons() {
        if !needToCreateButtons {
            return
        }
        needToCreateButtons = false
        boomButtons = [BoomButton]()
        for (index, builder) in boomButtonBuilders.enumerated() {
            builder.index = index
            builder.listener = self
            boomButtons.append(builder.build())
        }
        switch buttonEnum {
        case .simpleCircle:
            simpleCircleButtonRadius = (boomButtonBuilders.first as! SimpleCircleButtonBuilder).radius
        case .textInsideCircle:
            textInsideCircleButtonRadius = (boomButtonBuilders.first as! TextInsideCircleButtonBuilder).radius
        case .textOutsideCircle:
            textOutsideCircleButtonWidth = (boomButtonBuilders.first as! TextOutsideCircleButtonBuilder).width
            textOutsideCircleButtonHeight = (boomButtonBuilders.first as! TextOutsideCircleButtonBuilder).height
        case .ham:
            hamButtonWidth = (boomButtonBuilders.first as! HamButtonBuilder).width
            hamButtonHeight = (boomButtonBuilders.first as! HamButtonBuilder).height
        case .unknown:
            break
        }
    }
    
    private func parentView() -> UIView? {
        if isBoomInWholeScreen {
            if let delegate = UIApplication.shared.delegate {
                if let window = delegate.window {
                    return window!
                } else {
                    return nil
                }
            } else {
                return nil
            }
        } else {
            return superview
        }
    }
    
    private func calculateStartPositions(force: Bool) {
        guard force || needToCalculateStartPositions || isInList else {
            return
        }
        if !force {
            needToCalculateStartPositions = false
        }
        
        startPositions = Array<CGPoint>.init(repeating: CGPoint.zero, count: pieceNumber())
        let parentView = self.parentView()
        
        for (index, piece) in pieces.enumerated() {
            let bmbPosition: CGPoint!
            bmbPosition = convert(CGPoint.zero, to: parentView)
            let piecePositionInBmb = piecePositions[index].origin
            let pieceCenterInParentViewX = bmbPosition.x + piecePositionInBmb.x + piece.frame.size.width / 2
            let pieceCenterInParentViewY = bmbPosition.y + piecePositionInBmb.y + piece.frame.size.height / 2
            let pieceCenterInParentView = CGPoint.init(x: pieceCenterInParentViewX, y: pieceCenterInParentViewY)
            startPositions[index] = pieceCenterInParentView
        }
    }
    
    private func calculateEndPositions() {
        guard parentView() != nil else {
            return
        }
        switch buttonEnum {
        case .simpleCircle:
            endPositions = ButtonPlaceManager.positions(parentFrame: parentView()!.bounds,
                                                        buttonRadius: simpleCircleButtonRadius,
                                                        buttonNumber: self.boomButtonBuilders.count,
                                                        boomMenuButton: self)
        case .textInsideCircle:
            endPositions = ButtonPlaceManager.positions(parentFrame: parentView()!.bounds,
                                                        buttonRadius: textInsideCircleButtonRadius,
                                                        buttonNumber: self.boomButtonBuilders.count,
                                                        boomMenuButton: self)
        case .textOutsideCircle:
            endPositions = ButtonPlaceManager.positions(parentFrame: parentView()!.bounds,
                                                        buttonWidth: textOutsideCircleButtonWidth,
                                                        buttonHeight: textOutsideCircleButtonHeight,
                                                        buttonNumber: self.boomButtonBuilders.count,
                                                        boomMenuButton: self)
        case .ham:
            endPositions = ButtonPlaceManager.positions(parentFrame: parentView()!.bounds,
                                                        buttonWidth: hamButtonWidth,
                                                        buttonHeight: hamButtonHeight,
                                                        buttonNumber: self.boomButtonBuilders.count,
                                                        boomMenuButton: self)
        case .unknown:
            break
        }
    }
    
    private func placeBoomButton(_ boomButton: BoomButton, inBackgroundWithPosition position: CGPoint) {
        createBackground()
        boomButton.frame.origin = position
        boomButton.isHidden = true
        background?.addSubview(boomButton)
    }
    
    private func clearViews(force: Bool) {
        if force || !cacheOptimized || isInList {
            background?.removeAllBoomButtons()
            background?.removeFromSuperview()
            background = nil
            clearButtons()
        }
    }
    
    private func pieceNumber() -> Int {
        if piecePlaceEnum == .unknown {
            return 0
        } else if piecePlaceEnum == .share {
            return boomButtonBuilders.count
        } else if piecePlaceEnum == .custom {
            return customPiecePlacePositions.count
        } else {
            return piecePlaceEnum.pieceNumber()
        }
    }
    
    private func placeShareLinesView() {
        if piecePlaceEnum != .share {
            return
        }
        if shareLinesView != nil {
            shareLinesView?.removeFromSuperview()
        }
        shareLinesView = ShareLinesView.init(frame: bounds)
        shareLinesView?.backgroundColor = UIColor.clear
        shareLinesView?.line1Color = shareLine1Color
        shareLinesView?.line2Color = shareLine2Color
        shareLinesView?.lineWidth = shareLineWidth
        addSubview(shareLinesView!)
        if boomState != .didReboom {
            shareLinesView?.alpha = 0
        }
    }
    
    private func setShareLinesViewData() {
        if piecePlaceEnum != .share {
            return
        }
        shareLinesView?.set(piecePositions: piecePositions, dotRadius: dotRadius)
    }
    
    private func uninitializedBoomButtons() -> Bool {
        return buttonEnum == .unknown || piecePlaceEnum == .unknown || buttonPlaceEnum == .unknown
    }
    
    private func delay(_ delay: CFTimeInterval, toExecute closure: @escaping DelayClosure) {
        if delay == 0 {
            closure()
        } else {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay, execute: closure)
        }
    }
    
    private func needToDrawShadow() -> Bool {
        return self.hasBackground && self.hasShadow
    }
    
    private func clearButtons() {
        needToCreateButtons = true
        for button in boomButtons {
            button.removeFromSuperview()
        }
        boomButtons.removeAll()
    }
    
    private func buttonMaxHeight() -> CGFloat {
        switch self.buttonEnum {
        case .simpleCircle:
            return self.simpleCircleButtonRadius * 2
        case .textInsideCircle:
            return self.textInsideCircleButtonRadius * 2
        case .textOutsideCircle:
            return self.textOutsideCircleButtonHeight
        case .ham:
            return self.hamButtonHeight
        case .unknown:
            return 0
        }
    }
    
    private func preventDragOutside() {
        var needToAdjustFrame = false
        var newFrame = frame
        
        if newFrame.origin.x < edgeInsetsInSuperView.left {
            newFrame.origin.x = edgeInsetsInSuperView.left
            needToAdjustFrame = true
        }
        
        if newFrame.origin.y < edgeInsetsInSuperView.top {
            newFrame.origin.y = edgeInsetsInSuperView.top
            needToAdjustFrame = true
        }
        
        if superview == nil {
            return
        }
        
        if newFrame.origin.x + newFrame.size.width > superview!.bounds.size.width - edgeInsetsInSuperView.right {
            newFrame.origin.x = superview!.bounds.size.width - newFrame.size.width - edgeInsetsInSuperView.right
            needToAdjustFrame = true
        }
        
        if newFrame.origin.y + newFrame.size.height > superview!.bounds.size.height - edgeInsetsInSuperView.bottom {
            newFrame.origin.y = superview!.bounds.size.height - newFrame.size.height - edgeInsetsInSuperView.bottom
            needToAdjustFrame = true
        }
        
        if needToAdjustFrame {
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           usingSpringWithDamping: 0.6,
                           initialSpringVelocity: 0.5,
                           options: UIViewAnimationOptions.layoutSubviews,
                           animations: {
                            self.frame = newFrame
            }, completion: nil)
        }
    }
    
    private func adjustTipLabel() {
        background?.adjustTipLabel(tipBelowButton: tipBelowButtons,
                                   tipButtonMargin: tipButtonMargin,
                                   boomButtonEndPositions: endPositions,
                                   buttonHeight: buttonMaxHeight())
    }
    
    private func checkAutoBoom() {
        if autoBoomImmediately {
            boomImmediately()
        } else if autoBoom {
            boom()
        }
        autoBoom = false
        autoBoomImmediately = false
    }
    
    // MARK: - Device Orientation
    
    @objc private func deviceOrientationDidChange(notification: Notification) {
        let orientation = UIDevice.current.orientation
        if orientation != lastDeviceOrientation && parentView() != nil {
            background?.frame = parentView()!.bounds
            calculateStartPositions(force: true)
            calculateEndPositions()
            switch boomState {
            case .didReboom:
                break
            case .didBoom:
                placeButtons()
                adjustTipLabel()
            case .willBoom, .willReboom:
                stopAllAnimations(isBoomAnimation: boomState == .willBoom)
                placeButtons()
                adjustTipLabel()
            }
        }
        lastDeviceOrientation = orientation
    }
    
    private func placeButtons() {
        for (index, button) in boomButtons.enumerated() {
            let endPosition = endPositions[index]
            button.frame = CGRect.init(x: endPosition.x - button.centerPoint().x,
                                       y: endPosition.y - button.centerPoint().y,
                                       width: button.frame.size.width,
                                       height: button.frame.size.height)
        }
    }
    
    private func stopAllAnimations(isBoomAnimation: Bool) {
        background?.removeAllAnimations()
        for button in boomButtons {
            button.stopAnimations()
            if isBoomAnimation {
                button.showAllGoneViews()
            } else {
                button.hideAllGoneViews()
            }
        }
    }
    
    // MARK: - Builders
    
    /// Add a builder for a boom-button. Notice that boom-button is the sub-button of BMB and one builder for one boom-button.
    ///
    /// The builder should be a instance of: 
    /// 1. SimpleCircleButtonBuilder
    /// 2. TextInsideCircleButtonBuilder
    /// 3. TextOutsideCircleButtonBuilder
    /// 4. HamButtonBuilder.
    ///
    /// - Parameter builder: Builder for a boom-button.
    public func addBuilder(_ builder: BoomButtonBuilder) {
        boomButtonBuilders.append(builder)
        setNeedsLayout()
    }
    
    /// Replace a builder at the certain index.
    ///
    /// - Parameters:
    ///   - builder: Builder.
    ///   - index: Index.
    public func setBuilder(_ builder: BoomButtonBuilder, at index: Int) {
        boomButtonBuilders[index] = builder
        setNeedsLayout()
    }
    
    /// Replace all builders.
    ///
    /// - Parameter builders: Builders.
    public func setBuilders(_ builders: [BoomButtonBuilder]) {
        boomButtonBuilders = builders
        setNeedsLayout()
    }
    
    /// Get a builder at a centain index. This method is useful when a boom-button needs to change its attributes. The attributes of boom-button are able to be changed from its corresponding builder.
    ///
    /// - Parameter index: Index.
    /// - Returns: Builder.
    public func builder(at index: Int) -> BoomButtonBuilder? {
        return boomButtonBuilders[index]
    }
    
    /// Remove a certain builder.
    ///
    /// - Parameter builder: Builder.
    public func removeBuilder(_ builder: BoomButtonBuilder) {
        let index = boomButtonBuilders.index(of: builder)
        if index != nil {
            removeBuilder(at: index!)
            setNeedsLayout()
        }
    }
    
    /// Remove a builder at index.
    ///
    /// - Parameter index: Index.
    public func removeBuilder(at index: Int) {
        boomButtonBuilders.remove(at: index)
        setNeedsLayout()
    }
    
    /// Remove all builders.
    public func clearBuilders() {
        boomButtonBuilders.removeAll()
    }
    
    /// Get the boom-button at index. Notice that the boom-buttons may not be created by BMB, so this method may return nil.
    ///
    /// - Parameter index: Index.
    /// - Returns: The boom-button at the given index, may be nil.
    public func boomButton(at index: Int) -> BoomButton? {
        if 0 <= index && index < boomButtons.count {
            return boomButtons[index]
        }
        return nil
    }
    
    // MARK: - On Button Clicked
    
    internal func boomButton(_ boomButton: BoomButton, didClickAt index: Int) {
        boomDelegate?.boomMenuButton?(self, didClickBoomButtonOfBuilder: boomButtonBuilders[index], at: index)
        if autoHide {
            reboom()
        }
    }
    
    // MARK: - On Background Clicked

    internal func backgroundDidClick() {
        if isAnimating() {
            return
        }
        boomDelegate?.boomMenuButtonDidClickBackground?(boomMenuButton: self)
        if cancelable {
            reboom()
        }
    }
    
    // MARK: - Background
    
    /// Add views to background view. The background view is the superview of boom-buttons when the animations are processing. The views added from this method will play alpha-animations when booming and rebooming.
    ///
    /// - Parameter view: View that's to be added into background.
    public func addViewToBackground(view: UIView) {
        createBackground()
        background?.addGoneView(view)
    }
    
    /// Remove views from background view. The background view is the superview of boom-buttons when the animations are processing.
    ///
    /// - Parameter view: View that's to be removed into background.
    public func removeViewFromBackground(view: UIView) {
        createBackground()
        background?.removeGoneView(view)
    }
    
    /// Get the tip-label that shows a tip in background. Use this method to customize the tip-label.
    ///
    /// - Returns: UILabel of tip in background.
    public func tipLabel() -> UILabel! {
        if _tipLabel == nil {
            _tipLabel = UILabel.init()
        }
        return _tipLabel
    }
    
    // MARK: - Fade Views
    
    private func placeFadeViews() {
        for view in fadeViews {
            view.removeFromSuperview()
            self.addSubview(view)
            if boomState != .didReboom {
                view.alpha = 0
            }
        }
    }
    
    /// Add a fade view which plays fade-in and fade-out animations when booming or rebooming on BMB.
    ///
    /// - Parameter view: The fading view.
    public func addFadeView(_ view: UIView) {
        fadeViews.append(view)
        self.addSubview(view)
    }
    
    /// Remove a fade view which plays fade-in and fade-out animations when booming or rebooming on BMB.
    ///
    /// - Parameter view: The fade view.
    public func removeFadeView(_ view: UIView) {
        if let index = fadeViews.index(of: view) {
            fadeViews.remove(at: index)
        }
        view.removeFromSuperview()
    }
    
    /// Remove all fade views which play fade-in and fade-out animations when booming or rebooming on BMB.
    public func clearFadeViews() {
        for view in fadeViews {
            view.removeFromSuperview()
        }
        fadeViews.removeAll()
    }
    
    private func startBoomAnimationForFadeViews(immediately: Bool) {
        let duration = immediately ? 0.001 : boomDuration + CFTimeInterval(pieces.count - 1) * boomDelay
        let opacityAnimation = AnimationManager.fadeViewsOpacityAnimation(isBooming: true, duration: duration)
        AnimationManager.addAnimation(animation: opacityAnimation, key: BoomMenuButton.kFadeViewAnimation, views: fadeViews)
    }
    
    private func startReboomAnimationForFadeViews(immediately: Bool) {
        let duration = immediately ? 0.001 : reboomDuration + CFTimeInterval(pieces.count - 1) * reboomDelay
        let opacityAnimation = AnimationManager.fadeViewsOpacityAnimation(isBooming: false, duration: duration)
        AnimationManager.addAnimation(animation: opacityAnimation, key: BoomMenuButton.kFadeViewAnimation, views: fadeViews)
    }
}
