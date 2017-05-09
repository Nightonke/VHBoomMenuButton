//
//  BoomDelegate.swift
//  BoomMenuButton
//
//  Created by Nightonke on 2017/4/28.
//  Copyright © 2017 Nightonke. All rights reserved.
//

@objc public protocol BoomDelegate: class {
    
    /// When one of the sub button was clicked.
    ///
    /// - Parameters:
    ///   - bmb: The BMB
    ///   - builder: The builder of the clicked BoomButton
    ///   - index: Index of the clicked sub button
    @objc optional func boomMenuButton(_ bmb: BoomMenuButton, didClickBoomButtonOfBuilder builder: BoomButtonBuilder, at index: Int)
    
    /// When the background was clicked.
    ///
    /// - Parameter bmb: The BMB
    @objc optional func boomMenuButtonDidClickBackground(boomMenuButton bmb: BoomMenuButton)
    
    /// The reboom animation is going to start.
    ///
    /// - Parameter bmb: The BMB
    @objc optional func boomMenuButtonWillReboom(boomMenuButton bmb: BoomMenuButton)
    
    /// The reboom animation is finished.
    ///
    /// - Parameter bmb: The BMB
    @objc optional func boomMenuButtonDidReboom(boomMenuButton bmb: BoomMenuButton)
    
    /// The boom animation is going to start.
    ///
    /// - Parameter bmb: The BMB
    @objc optional func boomMenuButtonWillBoom(boomMenuButton bmb: BoomMenuButton)
    
    /// The boom animation is finished.
    ///
    /// - Parameter bmb: The BMB
    @objc optional func boomMenuButtonDidBoom(boomMenuButton bmb: BoomMenuButton)
    
}
