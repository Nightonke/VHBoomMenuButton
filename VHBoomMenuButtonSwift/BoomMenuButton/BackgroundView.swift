//
//  BackgroundView.swift
//  BoomMenuButton
//
//  Created by Nightonke on 2017/4/28.
//  Copyright © 2017 Nightonke. All rights reserved.
//

import UIKit

class BackgroundView: UIView {

    private static let kOpacityAnimation: String = "kOpacityAnimation"
    
    var dimColor: UIColor
    
    var backgroundBlurred: Bool {
        didSet {
            if #available(iOS 8.0, *), backgroundBlurred && visualEffectView == nil {
                visualEffectView = UIVisualEffectView.init(effect: nil)
                visualEffectView?.frame = self.bounds
                self.addSubview(visualEffectView!)
            }
        }
    }
    
    private var _blurEffect: AnyObject?
    @available(iOS 8.0, *)
    public var blurEffect: UIBlurEffect? {
        get {
            return _blurEffect as? UIBlurEffect
        }
        set {
            _blurEffect = newValue
        }
    }
    
    var tip: String? {
        didSet {
            tipLabel.text = tip
            tipLabel.sizeToFit()
            tipLabel.frame.origin.x = bounds.width / 2 - tipLabel.frame.size.width / 2
        }
    }
    weak var delegate: BackgroundDelegate?
    
    var tipLabel: UILabel {
        didSet {
            oldValue.removeFromSuperview()
            if let index = goneViews.index(of: oldValue) {
                goneViews.remove(at: index)
            }
            self.addGoneView(tipLabel)
        }
    }
    
    private var _visualEffectView: AnyObject?
    @available(iOS 8.0, *)
    private var visualEffectView: UIVisualEffectView? {
        get {
            return _visualEffectView as? UIVisualEffectView
        }
        set {
            _visualEffectView = newValue
        }
    }
    
    private var goneViews: [UIView]
    
    override var frame: CGRect {
        didSet {
            if #available(iOS 8.0, *) {
                visualEffectView?.frame = bounds
            }
        }
    }
    
    // MARK: - In-BMB-Only Methods
    
    func dim(duration: CFTimeInterval, completion: ((Bool) -> Swift.Void)? = nil) {
        isHidden = false
        if #available(iOS 8.0, *), backgroundBlurred {
            UIView.animate(withDuration: duration, animations: {
                self.visualEffectView?.effect = self.blurEffect
            }, completion: completion)
        } else {
            backgroundColor = UIColor.clear
            UIView.animate(withDuration: duration, animations: { 
                self.backgroundColor = self.dimColor
            }, completion: completion)
        }
        
        let opacityAnimation = AnimationManager.animate("opacity", delay: 0, duration: duration, values: [0, 1])
        AnimationManager.addAnimation(animation: opacityAnimation,
                                      key: BackgroundView.kOpacityAnimation,
                                      views: goneViews)
    }
    
    func light(duration: CFTimeInterval, completion: ((Bool) -> Swift.Void)? = nil) {
        if #available(iOS 8.0, *), backgroundBlurred {
            UIView.animate(withDuration: duration, animations: {
                self.visualEffectView?.effect = nil
            }, completion: completion)
        } else {
            backgroundColor = dimColor
            UIView.animate(withDuration: duration, animations: {
                self.backgroundColor = UIColor.clear
            }, completion: completion)
        }
        
        let opacityAnimation = AnimationManager.animate("opacity", delay: 0, duration: duration, values: [1, 0])
        AnimationManager.addAnimation(animation: opacityAnimation,
                                      key: BackgroundView.kOpacityAnimation,
                                      views: goneViews)
    }
    
    func removeAllBoomButtons() {
        for view in subviews {
            if view is BoomButton {
                view.removeFromSuperview()
            }
        }
    }
    
    func removeAllAnimations() {
        if #available(iOS 8.0, *) {
            visualEffectView?.layer.removeAllAnimations()
        }
        for view in goneViews {
            view.layer.removeAllAnimations()
        }
    }
    
    func addGoneView(_ goneView: UIView?) {
        guard goneView != nil else {
            return
        }
        goneViews.append(goneView!)
        addSubview(goneView!)
    }
    
    func removeGoneView(_ goneView: UIView?) {
        guard goneView != nil else {
            return
        }
        if self.subviews.contains(goneView!){
            goneView!.removeFromSuperview()
        }
        if let index = goneViews.index(of: goneView!) {
            goneViews.remove(at: index)
        }
    }
    
    func adjustTipLabel(tipBelowButton: Bool, tipButtonMargin: CGFloat, boomButtonEndPositions endPositions: [CGPoint], buttonHeight: CGFloat) {
        tipLabel.frame.origin.x = bounds.size.width / 2 - tipLabel.frame.size.width / 2
        if tipBelowButton {
            var maxY = CGFloat.leastNormalMagnitude
            for point in endPositions {
                maxY = max(maxY, point.y)
            }
            tipLabel.frame.origin.y = maxY + buttonHeight / 2 + tipButtonMargin
        } else {
            var minY = CGFloat.greatestFiniteMagnitude
            for point in endPositions {
                minY = min(minY, point.y)
            }
            tipLabel.frame.origin.y = minY - buttonHeight / 2 - tipButtonMargin - tipLabel.frame.size.height
        }
        bringSubview(toFront: tipLabel)
    }
    
    // MARK: - Private Methods

    init(frame: CGRect, boomMenuButton bmb: BoomMenuButton) {
        dimColor = bmb.dimColor
        backgroundBlurred = bmb.backgroundBlurred
        tip = bmb.tip
        delegate = bmb
        
        tipLabel = UILabel.init()
        tipLabel.text = bmb.tip
        tipLabel.textColor = UIColor.white
        tipLabel.font = UIFont.systemFont(ofSize: 20)
        
        goneViews = [UIView]()
        
        super.init(frame: frame)
        
        if #available(iOS 8.0, *) {
            blurEffect = bmb.blurEffect
            if backgroundBlurred {
                visualEffectView = UIVisualEffectView.init(effect: nil)
                visualEffectView?.frame = self.bounds
                self.addSubview(visualEffectView!)
            }
        }
        
        addGoneView(tipLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("BackgroundView does not support NSCoding")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let anyTouch = touches.first
        let touchLocation = anyTouch?.location(in: self)
        if bounds.contains(touchLocation!) {
            delegate?.backgroundDidClick()
        }
    }
}
