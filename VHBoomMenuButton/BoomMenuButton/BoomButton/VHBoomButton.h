//
//  VHBoomButton.h
//  VHBoomMenuExample
//
//  Created by Nightonke on 16/7/29.
//  Copyright © 2016 Nightonke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VHButtonEnum.h"

@class VHBoomButtonBuilder;

@interface VHBoomButton : UIView

#pragma mark - In-BMB-Only Methods

- (instancetype)initWithBuilder:(VHBoomButtonBuilder *)builder;

- (void)willBoom;

- (void)didBoom;

- (void)willReboom;

- (void)didReboom;

- (void)clearListener;

- (BOOL)innerNeedsColorAnimation;

- (CAShapeLayer *)innerButtonLayer;

- (UIColor *)innerPieceColor;

- (UIColor *)innerButtonColor;

- (void)innerStopAnimations;

- (void)innerShowAllGoneViews;

- (void)innerHideAllGoneViews;

#pragma mark Setters

- (void)innerSetImageView;

- (void)innerSetLabel;

- (void)innerSetSubLabel;

- (void)innerSetButtonLayer;

- (void)innerSetShadow;

- (void)innerSetNormalImage:(VHBoomButtonBuilder *)builder;

- (void)innerSetHighlightedImage:(VHBoomButtonBuilder *)builder;

- (void)innerSetUnableImage:(VHBoomButtonBuilder *)builder;

#pragma mark States

- (void)innerToNormalButton;

- (void)innerToHighlightedButton;

- (void)innerToUnableButton;

- (void)innerToNormalImage;

- (void)innerToHighlightedImage;

- (void)innerToUnableImage;

- (void)innerToNormalText;

- (void)innerToHighlightedText;

- (void)innerToUnableText;

- (void)innerToNormalSubText;

- (void)innerToHighlightedSubText;

- (void)innerToUnableSubText;

#pragma mark - Abstract Methods

- (VHButtonEnum)type;

- (NSArray<UIView *> *)goneViews;

- (NSArray<UIView *> *)rotateViews;

- (CGFloat)buttonWidth;

- (CGFloat)buttonHeight;

- (void)toNormal;

- (void)toHighlighted;

- (void)toUnable;

- (void)setRotateAnchorPoints;

- (void)setAnchorPointOfLayer;

- (CGPoint)centerPoint;

#pragma mark - Public Methods

- (UIImageView *)imageView;

- (UILabel *)label;

- (UILabel *)subLabel;

- (CAShapeLayer *)buttonLayer;

@end
