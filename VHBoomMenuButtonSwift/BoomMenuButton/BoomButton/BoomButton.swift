//
//  BoomButton.swift
//  BoomMenuButton
//
//  Created by viktorhuang on 2017/4/28.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

import UIKit

class BoomButton: UIView {

    // MARK: - Basic
    
    var index = -1
    weak var listener: BoomButtonDelegate?
    var clickedClosure: BoomButtonDidClickClosure?
    var unable = false
    var lastStateEnum = ButtonStateEnum.unknown
    
    // MARK: - Piece
    
    var pieceColor: UIColor?
    
    // MARK: - Shadow
    
    var hasShadow = true
    var shadowPathRect: CGRect = CGRect.zero
    var shadowOffsetX: CGFloat = 0
    var shadowOffsetY: CGFloat = 8
    var shadowRadius: CGFloat = 4
    var shadowColor: UIColor!
    
    // MARK: - Image
    
    var normalImageName: String?
    var normalImage: UIImage?
    var highlightedImageName: String?
    var highlightedImage: UIImage?
    var unableImageName: String?
    var unableImage: UIImage?
    var normalImageTintColor: UIColor?
    var highlightedImageTintColor: UIColor?
    var unableImageTintColor: UIColor?
    var imageFrame: CGRect!
    var imageSize: CGSize!
    var rotateImage = true
    var imageView: UIImageView?
    
    // MARK: - Button
    
    var normalColor: UIColor!
    var highlightedColor: UIColor?
    var unableColor: UIColor?
    var radius: CGFloat = 0
    var width: CGFloat = 0
    var height: CGFloat = 0
    var cornerRadius: CGFloat = 5
    var round = true
    var buttonLayer: CAShapeLayer?
    
    // MARK: - Text
    
    var normalText: String?
    var highlightedText: String?
    var unableText: String?
    
    var normalAttributedText: NSAttributedString?
    var highlightedAttributedText: NSAttributedString?
    var unableAttributedText: NSAttributedString?
    
    var normalTextColor = UIColor.white
    var highlightedTextColor: UIColor?
    var unableTextColor: UIColor?
    
    var textFrame: CGRect!
    var textFont = UIFont.systemFont(ofSize: 8)
    var textAlignment = NSTextAlignment.center
    var textLineBreakMode = NSLineBreakMode.byWordWrapping
    var textLines = 1
    
    var textShadowColor: UIColor?
    var textShadowOffsetX: CGFloat = 0
    var textShadowOffsetY: CGFloat = 0
    
    var rotateText = true
    
    var label: UILabel?
    
    // MARK: - Sub Text
    
    var containsSubText = true
    
    var normalSubText: String?
    var highlightedSubText: String?
    var unableSubText: String?
    
    var normalAttributedSubText: NSAttributedString?
    var highlightedAttributedSubText: NSAttributedString?
    var unableAttributedSubText: NSAttributedString?
    
    var normalSubTextColor = UIColor.white
    var highlightedSubTextColor: UIColor?
    var unableSubTextColor: UIColor?
    
    var subTextFrame: CGRect!
    var subTextFont = UIFont.systemFont(ofSize: 8)
    var subTextAlignment = NSTextAlignment.center
    var subTextLineBreakMode = NSLineBreakMode.byWordWrapping
    var subTextLines = 1
    
    var subTextShadowColor: UIColor?
    var subTextShadowOffsetX: CGFloat = 0
    var subTextShadowOffsetY: CGFloat = 0
    
    var subLabel: UILabel?
    
    // MARK: - Private Properties
    
    var rotateAnchorPointInitialized = false

    // MARK: - Private Methods
    
    init(builder: BoomButtonBuilder) {
        index = builder.index
        listener = builder.listener
        clickedClosure = builder.clickedClosure
        unable = builder.unable
        
        pieceColor = builder.pieceColor
        
        hasShadow = builder.hasShadow
        shadowRadius = builder.shadowRadius
        shadowOffsetX = builder.shadowOffsetX
        shadowOffsetY = builder.shadowOffsetY
        shadowColor = builder.shadowColor
        
        normalImageName = builder.normalImageName
        normalImage = builder.normalImage
        highlightedImageName = builder.highlightedImageName
        highlightedImage = builder.highlightedImage
        unableImageName = builder.unableImageName
        normalImageTintColor = builder.normalImageTintColor
        highlightedImageTintColor = builder.highlightedImageTintColor
        unableImageTintColor = builder.unableImageTintColor
        imageFrame = builder.imageFrame
        imageSize = builder.imageSize
        rotateImage = builder.rotateImage
        
        normalColor = builder.normalColor
        highlightedColor = builder.highlightedColor
        unableColor = builder.unableColor
        cornerRadius = builder.cornerRadius
        
        super.init(frame: CGRect.zero)
        
        isExclusiveTouch = true
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("BoomButton does not support NSCoding")
    }
    
    func willBoom() {
        
    }
    
    func didBoom() {
        buttonLayer?.removeAllAnimations()
    }
    
    func willReboom() {
        
    }
    
    func didReboom() {
        buttonLayer?.removeAllAnimations()
    }
    
    func clearListener() {
        
    }
    
    func needsColorAnimation() -> Bool {
        if pieceColor == nil {
            return false
        } else {
            if unable {
                return !Utils.isSameColor(pieceColor, unableColor)
            } else {
                return !Utils.isSameColor(pieceColor, normalColor)
            }
        }
    }
    
    func buttonColor() -> UIColor {
        if unable && unableColor != nil {
            return unableColor!
        } else {
            return normalColor
        }
    }
    
    func stopAnimations() {
        layer.removeAllAnimations()
        buttonLayer?.removeAllAnimations()
        imageView?.layer.removeAllAnimations()
        label?.layer.removeAllAnimations()
        subLabel?.layer.removeAllAnimations()
    }
    
    func showAllGoneViews() {
        for view in goneViews() {
            view.alpha = 1
        }
    }
    
    func hideAllGoneViews() {
        for view in goneViews() {
            view.alpha = 0
        }
    }
    
    // MARK: - Resetters
    
    func resetImageView() {
        if imageView == nil {
            imageView = UIImageView.init()
            addSubview(imageView!)
        }
        imageView?.frame = imageFrame
        imageView?.contentMode = UIViewContentMode.center
    }
    
    func resetLabel() {
        if label == nil {
            label = UILabel.init()
            addSubview(label!)
        }
        label?.frame = textFrame
        label?.font = textFont
        label?.textAlignment = textAlignment
        label?.lineBreakMode = textLineBreakMode
        label?.numberOfLines = textLines
        label?.shadowColor = textShadowColor
        label?.shadowOffset = CGSize.init(width: textShadowOffsetX, height: textShadowOffsetY)
    }
    
    func resetSubLabel() {
        if !containsSubText {
            if let subLabel = subLabel {
                subLabel.removeFromSuperview()
                self.subLabel = nil
            }
            return
        }
        if subLabel == nil {
            subLabel = UILabel.init()
            addSubview(subLabel!)
        }
        subLabel?.frame = subTextFrame
        subLabel?.font = subTextFont
        subLabel?.textAlignment = subTextAlignment
        subLabel?.lineBreakMode = subTextLineBreakMode
        subLabel?.numberOfLines = subTextLines
        subLabel?.shadowColor = subTextShadowColor
        subLabel?.shadowOffset = CGSize.init(width: subTextShadowOffsetX, height: subTextShadowOffsetY)
    }
    
    func resetButtonLayer() {
        buttonLayer?.removeFromSuperlayer()
        buttonLayer = CAShapeLayer.init()
        switch type() {
        case .simpleCircle, .textInsideCircle:
            if round {
                buttonLayer?.path = UIBezierPath.init(ovalIn: CGRect.init(x: 0, y: 0, width: radius + radius, height: radius + radius)).cgPath
            } else {
                buttonLayer?.path = UIBezierPath.init(roundedRect: CGRect.init(x: 0, y: 0, width: radius + radius, height: radius + radius),
                                                      cornerRadius: cornerRadius).cgPath
            }
            buttonLayer?.frame = bounds
        case .textOutsideCircle:
            if round {
                buttonLayer?.path = UIBezierPath.init(ovalIn: CGRect.init(x: 0, y: 0, width: width, height: width)).cgPath
            } else {
                buttonLayer?.path = UIBezierPath.init(roundedRect: CGRect.init(x: 0, y: 0, width: width, height: width),
                                                      cornerRadius: cornerRadius).cgPath
            }
            buttonLayer?.frame = CGRect.init(x: 0, y: 0, width: width, height: width)
        case .ham:
            buttonLayer?.path = UIBezierPath.init(roundedRect: CGRect.init(x: 0, y: 0, width: width, height: height),
                                                  cornerRadius: cornerRadius).cgPath
            buttonLayer?.frame = CGRect.init(x: 0, y: 0, width: width, height: height)
        default:
            break
        }
        layer.insertSublayer(buttonLayer!, at: 0)
    }
    
    func resetShadow() {
        if hasShadow {
            var shadowPath: UIBezierPath
            if round {
                shadowPath = UIBezierPath.init(ovalIn: shadowPathRect)
            } else {
                shadowPath = UIBezierPath.init(roundedRect: shadowPathRect, cornerRadius: cornerRadius)
            }
            layer.masksToBounds = false
            layer.shadowPath = shadowPath.cgPath
            layer.shadowOffset = CGSize.init(width: shadowOffsetX, height: shadowOffsetY)
            layer.shadowRadius = shadowRadius
            layer.shadowColor = shadowColor.cgColor
            layer.shadowOpacity = 1
        } else {
            layer.shadowOpacity = 0
        }
    }
    
    func resetNormalImage(builder: BoomButtonBuilder) {
        normalImage = builder.normalImage
        normalImageName = builder.normalImageName
        if normalImage == nil {
            if normalImageName != nil {
                normalImage = UIImage.init(named: normalImageName!)
            }
        }
        normalImage = Utils.image(image: normalImage, newSize: imageSize)
        if normalImageTintColor != nil || highlightedImageTintColor != nil || unableImageTintColor != nil {
            normalImage = normalImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        }
    }
    
    func resetHighlightedImage(builder: BoomButtonBuilder) {
        highlightedImage = builder.highlightedImage
        highlightedImageName = builder.highlightedImageName
        if highlightedImage == nil {
            if highlightedImageName != nil {
                highlightedImage = UIImage.init(named: highlightedImageName!)
            }
        }
        highlightedImage = Utils.image(image: highlightedImage, newSize: imageSize)
        if normalImageTintColor != nil || highlightedImageTintColor != nil || unableImageTintColor != nil {
            highlightedImage = highlightedImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        }
    }
    
    func resetUnableImage(builder: BoomButtonBuilder) {
        unableImage = builder.unableImage
        unableImageName = builder.unableImageName
        if unableImage == nil {
            if unableImageName != nil {
                unableImage = UIImage.init(named: unableImageName!)
            }
        }
        unableImage = Utils.image(image: unableImage, newSize: imageSize)
        if normalImageTintColor != nil || highlightedImageTintColor != nil || unableImageTintColor != nil {
            unableImage = unableImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        }
    }
    
    // MARK: - States
    
    func toNormalButton() {
        lastStateEnum = .normal
        buttonLayer?.fillColor = normalColor.cgColor
    }
    
    func toHighlightedButton() {
        lastStateEnum = .highlighted
        buttonLayer?.fillColor = highlightedColor?.cgColor
    }
    
    func toUnableButton() {
        lastStateEnum = .unable
        buttonLayer?.fillColor = unableColor?.cgColor
    }
    
    func toNormalImage() {
        imageView?.tintColor = normalImageTintColor
        if normalImage != nil {
            imageView!.image = normalImage
        }
    }
    
    func toHighlightedImage() {
        imageView?.tintColor = highlightedImageTintColor
        if highlightedImage != nil {
            imageView!.image = highlightedImage
        }
    }
    
    func toUnableImage() {
        imageView?.tintColor = unableImageTintColor
        if unableImage != nil {
            imageView?.image = unableImage
        }
    }
    
    func toNormalText() {
        if normalText != nil {
            label?.text = normalText
        }
        if normalAttributedText != nil {
            label?.attributedText = normalAttributedText
        }
        label?.textColor = normalTextColor
    }
    
    func toHighlightedText() {
        if highlightedText != nil {
            label?.text = highlightedText
        }
        if highlightedAttributedText != nil {
            label?.attributedText = highlightedAttributedText
        }
        if highlightedTextColor != nil {
            label?.textColor = highlightedTextColor
        }
    }
    
    func toUnableText() {
        if unableText != nil {
            label?.text = unableText
        }
        if unableAttributedText != nil {
            label?.attributedText = unableAttributedText
        }
        if unableTextColor != nil {
            label?.textColor = unableTextColor
        }
    }
    
    func toNormalSubText() {
        if normalSubText != nil {
            subLabel?.text = normalSubText
        }
        if normalAttributedSubText != nil {
            subLabel?.attributedText = normalAttributedSubText
        }
        subLabel?.textColor = normalSubTextColor
    }
    
    func toHighlightedSubText() {
        if highlightedSubText != nil {
            subLabel?.text = highlightedSubText
        }
        if highlightedAttributedSubText != nil {
            subLabel?.attributedText = highlightedAttributedSubText
        }
        if highlightedSubTextColor != nil {
            subLabel?.textColor = highlightedSubTextColor
        }
    }
    
    func toUnableSubText() {
        if unableSubText != nil {
            subLabel?.text = unableSubText
        }
        if unableAttributedSubText != nil {
            subLabel?.attributedText = unableAttributedSubText
        }
        if unableSubTextColor != nil {
            subLabel?.textColor = unableSubTextColor
        }
    }
    
    // MARK: - Private Methods
    
    override func draw(_ rect: CGRect) {
        resetShadow()
    }
    
    // MARK: - Touch Action
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let anyTouch = touches.first
        let touchLocation = anyTouch?.location(in: self)
        if touchLocation != nil && buttonLayer != nil && buttonLayer!.frame.contains(touchLocation!) {
            if !unable {
                toHighlighted()
            }
        } else {
            super.touchesBegan(touches, with: event)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let anyTouch = touches.first
        let touchLocation = anyTouch?.location(in: self)
        if touchLocation != nil && buttonLayer != nil && !buttonLayer!.frame.contains(touchLocation!) && !unable {
            toNormal()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let anyTouch = touches.first
        let touchLocation = anyTouch?.location(in: self)
        if touchLocation != nil && buttonLayer != nil && buttonLayer!.frame.contains(touchLocation!) && !unable {
            click()
        }
        if !unable {
            toNormal()
        }
    }
    
    func click() {
        clickedClosure?(index)
        listener?.boomButton(self, didClickAt: index)
    }
    
    // MARK: - Abstract Methods
    
    func type() -> ButtonEnum {
        assert(false, "Method type should be overrided in child class")
        return .unknown
    }
    
    func goneViews() -> [UIView] {
        assert(false, "Method type should be overrided in child class")
        return [UIView]()
    }
    
    func rotateViews() -> [UIView] {
        assert(false, "Method type should be overrided in child class")
        return [UIView]()
    }
    
    func buttonWidth() -> CGFloat {
        assert(false, "Method type should be overrided in child class")
        return CGFloat.init(0)
    }
    
    func buttonHeight() -> CGFloat {
        assert(false, "Method type should be overrided in child class")
        return CGFloat.init(0)
    }
    
    func toUnable() {
        assert(false, "Method type should be overrided in child class")
    }
    
    func toHighlighted() {
        assert(false, "Method type should be overrided in child class")
    }
    
    func toNormal() {
        assert(false, "Method type should be overrided in child class")
    }
    
    func setRotateAnchorPoints() {
        if rotateAnchorPointInitialized {
            return
        }
        rotateAnchorPointInitialized = true
        
        let x = rotateAnchorPoint().x
        let y = rotateAnchorPoint().y
        for view in rotateViews() {
            let anchorPointX = (x - view.frame.origin.x) / view.frame.size.width
            let anchorPointY = (y - view.frame.origin.y) / view.frame.size.height
            Utils.setAnchorPoint(CGPoint.init(x: anchorPointX, y: anchorPointY), layer: view.layer)
        }
    }
    
    func rotateAnchorPoint() -> CGPoint {
        assert(false, "Method type should be overrided in child class")
        return CGPoint.zero
    }
    
    func setAnchorPointOfLayer() {
        assert(false, "Method type should be overrided in child class")
    }
    
    func centerPoint() -> CGPoint {
        assert(false, "Method type should be overrided in child class")
        return CGPoint.zero
    }
    
}
