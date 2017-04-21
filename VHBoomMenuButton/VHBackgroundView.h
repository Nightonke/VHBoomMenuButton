//
//  VHBackgroundView.h
//  VHBoomMenuExample
//
//  Created by Nightonke on 16/7/31.
//  Copyright © 2016年 Nightonke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VHBackgroundClickDelegate.h"
#import "VHBoomButton.h"

@interface VHBackgroundView : UIView

@property (nonatomic, strong) UIColor * _Nonnull dimColor;
@property (nonatomic, assign) BOOL blurBackground;
@property (nonatomic, strong) UIBlurEffect * _Nullable blurEffect;
@property (nonatomic, strong) NSString * _Nullable tip;
@property (nonatomic, weak) id<VHBackgroundClickDelegate> _Nullable delegate;

@property (nonatomic, strong) UILabel * _Nullable tipLabel;

- (void)dim:(CFTimeInterval)duration
 completion:(void (^ __nullable)(BOOL finished))completion;

- (void)light:(CFTimeInterval)duration
   completion:(void (^ __nullable)(BOOL finished))completion;

- (void)removeAllBoomButtons;

- (void)removeAllAnimations;

- (void)addGoneView:(UIView *_Nonnull)view;

- (void)adjustTipLabel:(BOOL)tipBelowButton
   withTipButtonMargin:(CGFloat)tipButtonMargin
       withEndPosition:(NSArray<NSValue *> * _Nullable)endPositions
      withButtonHeight:(CGFloat)buttonHeight;

@end
