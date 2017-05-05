//
//  BoomMenuButton.swift
//  BoomMenuButton
//
//  Created by viktorhuang on 2017/4/26.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

import UIKit

typealias DelayClosure = () -> Void

@IBDesignable
public class BoomMenuButton: UIView, BoomButtonDelegate, BackgroundDelegate {

    private static let kFillColorAnimation = "kFillColorAnimation"
    
    // MARK: - Public Properties
    
    // MARK: Basic
    
    @IBInspectable public var cacheOptimized: Bool = true
    
    @IBInspectable public var isBoomInWholeScreen: Bool = true
    
    @IBInspectable public var isInList: Bool = false
    
    // MARK: Shadow
    
    @IBInspectable public var hasShadow: Bool = true {
        didSet {
            if hasShadow != oldValue {
                setNeedsDisplay()
            }
        }
    }
    
    @IBInspectable public var shadowPathRect: CGRect! {
        didSet {
            if shadowPathRect != oldValue {
                setNeedsDisplay()
            }
        }
    }
    
    @IBInspectable public var shadowOffsetX: CGFloat = 0 {
        didSet {
            if shadowOffsetX != oldValue {
                setNeedsDisplay()
            }
        }
    }
    
    @IBInspectable public var shadowOffsetY: CGFloat = 8 {
        didSet {
            if shadowOffsetY != oldValue {
                setNeedsDisplay()
            }
        }
    }
    
    @IBInspectable public var shadowRadius: CGFloat = 4 {
        didSet {
            if shadowRadius != oldValue {
                setNeedsDisplay()
            }
        }
    }
    
    @IBInspectable public var shadowColor: UIColor = Utils.color(argb: 0x44000000) {
        didSet {
            if Utils.isSameColor(shadowColor, oldValue) {
                setNeedsDisplay()
            }
        }
    }
    
    // MARK: Button
    
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
    
    @IBInspectable public var hasBackground: Bool = true {
        didSet {
            if hasBackground != oldValue {
                setNeedsDisplay()
            }
        }
    }
    
    @IBInspectable public var normalColor: UIColor = Utils.color(rgb: 0x30a2fb) {
        didSet {
            if Utils.isSameColor(normalColor, oldValue) {
                setNeedsDisplay()
            }
        }
    }
    
    @IBInspectable public var highlightedColor: UIColor = Utils.color(rgb: 0x73bdf1) {
        didSet {
            if Utils.isSameColor(highlightedColor, oldValue) {
                setNeedsDisplay()
            }
        }
    }
    
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
    
    @IBInspectable public var draggable: Bool = false
    public var edgeInsetsInSuperView: UIEdgeInsets = UIEdgeInsets.init(top: 15, left: 15, bottom: 15, right: 15) {
        didSet {
            if edgeInsetsInSuperView != oldValue {
                preventDragOutside()
            }
        }
    }
    
    // MARK: Piece
    
    @IBInspectable public var dotRadius: CGFloat = 3 {
        didSet {
            if dotRadius != oldValue {
                setNeedsLayout()
            }
        }
    }
    
    @IBInspectable public var hamWidth: CGFloat = 20 {
        didSet {
            if hamWidth != oldValue {
                setNeedsLayout()
            }
        }
    }
    
    @IBInspectable public var hamHeight: CGFloat = 3 {
        didSet {
            if hamHeight != oldValue {
                setNeedsLayout()
            }
        }
    }
    
    @IBInspectable public var pieceCornerRadius: CGFloat = -1 {
        didSet {
            if pieceCornerRadius != oldValue {
                setNeedsLayout()
            }
        }
    }
    
    @IBInspectable public var pieceHorizontalMargin: CGFloat = 2 {
        didSet {
            if pieceHorizontalMargin != oldValue {
                setNeedsLayout()
            }
        }
    }
    
    @IBInspectable public var pieceVerticalMargin: CGFloat = 2 {
        didSet {
            if pieceVerticalMargin != oldValue {
                setNeedsLayout()
            }
        }
    }
    
    @IBInspectable public var pieceInclinedMargin: CGFloat = 2 {
        didSet {
            if pieceInclinedMargin != oldValue {
                setNeedsLayout()
            }
        }
    }
    
    @IBInspectable public var shareLineLength: CGFloat = 18 {
        didSet {
            if shareLineLength != oldValue {
                setNeedsLayout()
            }
        }
    }
    
    @IBInspectable public var shareLine1Color: UIColor = UIColor.white {
        didSet {
            if Utils.isSameColor(shareLine1Color, oldValue) {
                setNeedsLayout()
            }
        }
    }
    
    @IBInspectable public var shareLine2Color: UIColor = UIColor.white {
        didSet {
            if Utils.isSameColor(shareLine2Color, oldValue) {
                setNeedsLayout()
            }
        }
    }
    
    @IBInspectable public var shareLineWidth: CGFloat = 1.5 {
        didSet {
            if shareLineWidth != oldValue {
                setNeedsLayout()
            }
        }
    }
    
    public var piecePlaceEnum = PiecePlaceEnum.unknown {
        didSet {
            // We have to clear pieces because the pieces may be changed even though the piece-place-enum is still the same
            clearPieces()
            needToCalculateStartPositions = true
        }
    }
    
    // MARK: Background
    
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
    
    @available(iOS 8.0, *)
    public var blurEffect: UIBlurEffect? {
        get {
            return _blurEffect as? UIBlurEffect
        }
        set {
            _blurEffect = newValue
        }
    }
    
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
    
    @IBInspectable public var tip: String? {
        didSet {
            if tip != oldValue {
                background?.tip = tip
            }
        }
    }
    
    @IBInspectable public var tipBelowButtons: Bool = false {
        didSet {
            if tipBelowButtons != oldValue {
                adjustTipLabel()
            }
        }
    }
    
    @IBInspectable public var tipButtonMargin: CGFloat = 40 {
        didSet {
            if tipButtonMargin != oldValue {
                adjustTipLabel()
            }
        }
    }
    
    // MARK: Animation
    
    public weak var boomDelegate: BoomDelegate?
    
    @IBInspectable public var delay: CFTimeInterval {
        get {
            return boomDelay
        }
        set {
            boomDelay = newValue
            reboomDelay = newValue
        }
    }
    
    @IBInspectable public var duration: CFTimeInterval {
        get {
            return boomDuration
        }
        set {
            boomDuration = newValue
            reboomDuration = newValue
        }
    }
    
    @IBInspectable public var boomDelay: CFTimeInterval = 0.05
    
    @IBInspectable public var boomDuration: CFTimeInterval = 0.3 {
        didSet {
            if boomDuration <= 0 {
                boomDuration = 0.001
            }
        }
    }
    
    @IBInspectable public var reboomDelay: CFTimeInterval = 0.05
    
    @IBInspectable public var reboomDuration: CFTimeInterval = 0.3 {
        didSet {
            if reboomDuration <= 0 {
                reboomDuration = 0.001
            }
        }
    }
    
    @IBInspectable public var cancelable: Bool = true
    
    @IBInspectable public var autoHide: Bool = true
    
    public var orderEnum = OrderEnum.random
    
    @IBInspectable public var frames: Int = 60
    
    @IBInspectable public var boomEnum = BoomEnum.horizontalThrow2
    
    public var boomEaseName: String! = Ease.outBack {
        didSet {
            boomMoveEaseName = boomEaseName
            boomScaleEaseName = boomEaseName
            boomRotateEaseName = boomEaseName
        }
    }
    
    public var boomMoveEaseName = Ease.outBack {
        didSet {
            boomMoveEase = Ease.ease(name: boomMoveEaseName)
        }
    }
    
    public var boomScaleEaseName = Ease.outBack {
        didSet {
            boomScaleEase = Ease.ease(name: boomScaleEaseName)
        }
    }
    
    public var boomRotateEaseName = Ease.outBack {
        didSet {
            boomRotateEase = Ease.ease(name: boomRotateEaseName)
        }
    }
    
    public var reboomEaseName: String! = Ease.inBack {
        didSet {
            reboomMoveEaseName = reboomEaseName
            reboomScaleEaseName = reboomEaseName
            reboomRotateEaseName = reboomEaseName
        }
    }
    
    public var reboomMoveEaseName = Ease.inBack {
        didSet {
            reboomMoveEase = Ease.ease(name: reboomMoveEaseName)
        }
    }
    
    public var reboomScaleEaseName = Ease.inBack {
        didSet {
            reboomScaleEase = Ease.ease(name: reboomScaleEaseName)
        }
    }
    
    public var reboomRotateEaseName = Ease.inBack {
        didSet {
            reboomRotateEase = Ease.ease(name: reboomRotateEaseName)
        }
    }
    
    @IBInspectable public var rotateDegree: CGFloat = 4 * CGFloat.pi
    
    @IBInspectable public var use3DTransformAnimation: Bool = true
    
    @IBInspectable public var autoBoom: Bool = false
    
    @IBInspectable public var autoBoomImmediately: Bool = false
    
    // MARK: Boom Buttons
    public var buttonPlaceEnum = ButtonPlaceEnum.unknown {
        didSet {
            // We have to clear pieces because the buttons may be changed even though the button-place-enum is still the same
            clearButtons()
            needToCalculateStartPositions = true
        }
    }
    
    public var buttonPlaceAlignmentEnum = ButtonPlaceAlignmentEnum.center
    
    @IBInspectable public var buttonHorizontalMargin: CGFloat = 12
    
    @IBInspectable public var buttonVerticalMargin: CGFloat = 12
    
    @IBInspectable public var buttonInclinedMargin: CGFloat = 12
    
    @IBInspectable public var buttonBottomMargin: CGFloat = 20
    
    @IBInspectable public var buttonTopMargin: CGFloat = 20
    
    @IBInspectable public var buttonLeftMargin: CGFloat = 20
    
    @IBInspectable public var buttonRightMargin: CGFloat = 20
    
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
    private var boomMoveEase: Ease! = Ease.ease(name: Ease.outBack)
    private var boomScaleEase: Ease! = Ease.ease(name: Ease.outBack)
    private var boomRotateEase: Ease! = Ease.ease(name: Ease.outBack)
    private var reboomMoveEase: Ease! = Ease.ease(name: Ease.inBack)
    private var reboomScaleEase: Ease! = Ease.ease(name: Ease.inBack)
    private var reboomRotateEase: Ease! = Ease.ease(name: Ease.inBack)
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
                piecePositions = PiecePlaceManager.positions(radius: dotRadius, dotNumber: boomButtonBuilders.count, boomMenuButton: self)
            } else {
                piecePositions = PiecePlaceManager.positions(radius: dotRadius, boomMenuButton: self)
            }
        case .ham:
            piecePositions = PiecePlaceManager.positions(width: hamWidth, height: hamHeight, boomMenuButton: self)
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
    
    public func isAnimating() -> Bool! {
        return animatingViewsNumber != 0
    }
    
    public func boom() {
        innerBoom(immediately: false)
    }
    
    public func boomImmediately() {
        innerBoom(immediately: true)
    }
    
    private func innerBoom(immediately: Bool) {
        if uninitializedBoomButtons() || isAnimating() || boomState != .didReboom {
            return
        }
        ErrorManager.judge(boomMenuButton: self, withBuilders: self.boomButtonBuilders)
        boomState = .willBoom
        boomDelegate?.boomMenuButtonWillBoom?(boomMenuButton: self)
        calculateStartPositions(force: false)
        createButtons()
        dimBackground(immediately: immediately)
        startBoomAnimations(immediately: immediately)
        adjustTipLabel()
    }
    
    public func reboom() {
        innerReboom(immediately: false)
    }
    
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
            AnimationManager.addAnimations(view: boomButton, animations: xPositionAnimation, yPositionAnimation, xScaleAnimation, yScaleAnimation)
            AnimationManager.addAnimation(animation: rotateAnimation, views: boomButton.rotateViews())
            AnimationManager.addAnimation(animation: opacityAnimation, views: boomButton.goneViews())
            
            if self.use3DTransformAnimation {
                let rotateXAnimation = AnimationManager.rotateXAnimation(ys: ys, delay: 0, duration: duration)
                let rotateYAnimation = AnimationManager.rotateYAnimation(xs: xs, delay: 0, duration: duration)
                AnimationManager.addAnimations(view: boomButton, animations: rotateXAnimation, rotateYAnimation)
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
            AnimationManager.addAnimations(view: boomButton, animations: xPositionAnimation, yPositionAnimation, xScaleAnimation, yScaleAnimation)
            AnimationManager.addAnimation(animation: rotateAnimation, views: boomButton.rotateViews())
            AnimationManager.addAnimation(animation: opacityAnimation, views: boomButton.goneViews())
            
            if self.use3DTransformAnimation {
                let rotateXAnimation = AnimationManager.rotateXAnimation(ys: ys, delay: 0, duration: duration)
                let rotateYAnimation = AnimationManager.rotateYAnimation(xs: xs, delay: 0, duration: duration)
                AnimationManager.addAnimations(view: boomButton, animations: rotateXAnimation, rotateYAnimation)
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
        if background == nil && parentView() != nil{
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
    
    
    public func addBuilder(_ builder: BoomButtonBuilder) {
        boomButtonBuilders.append(builder)
        setNeedsLayout()
    }
    
    public func setBuilder(_ builder: BoomButtonBuilder, at index: Int) {
        boomButtonBuilders[index] = builder
        setNeedsLayout()
    }
    
    public func setBuilders(_ builders: [BoomButtonBuilder]) {
        boomButtonBuilders = builders
        setNeedsLayout()
    }
    
    public func builder(at index: Int) -> BoomButtonBuilder? {
        return boomButtonBuilders[index]
    }
    
    public func removeBuilder(_ builder: BoomButtonBuilder) {
        let index = boomButtonBuilders.index(of: builder)
        if index != nil {
            removeBuilder(at: index!)
            setNeedsLayout()
        }
    }
    
    public func removeBuilder(at index: Int) {
        boomButtonBuilders.remove(at: index)
        setNeedsLayout()
    }
    
    public func clearBuilders() {
        boomButtonBuilders.removeAll()
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
    
    // MARK: Background
    
    public func addViewToBackground(view: UIView) {
        createBackground()
        background?.addGoneView(view)
    }
    
    public func tipLabel() -> UILabel! {
        if _tipLabel == nil {
            _tipLabel = UILabel.init()
        }
        return _tipLabel
    }
}
