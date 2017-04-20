//
//  VHBoomMenuButton.h
//  VHBoomMenuExample
//
//  Created by Nightonke on 16/7/28.
//  Copyright © 2016年 Nightonke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "VHButtonEnum.h"
#import "VHBoomDelegate.h"
#import "VHOrderEnum.h"
#import "VHBoomEnum.h"
#import "VHPiecePlaceEnum.h"
#import "VHButtonPlaceEnum.h"
#import "VHButtonPlaceAlignmentEnum.h"
#import "VHBoomButtonBuilder.h"
#import "VHSimpleCircleButtonBuilder.h"
#import "VHTextInsideCircleButtonBuilder.h"
#import "VHTextOutsideCircleButtonBuilder.h"
#import "VHHamButtonBuilder.h"
#import "VHEase.h"

IB_DESIGNABLE
@interface VHBoomMenuButton : UIView

#pragma mark - Basic

@property (nonatomic, assign)IBInspectable BOOL cacheOptimization;
@property (nonatomic, assign)IBInspectable BOOL boomInWholeScreen;
@property (nonatomic, assign)IBInspectable BOOL inList;

#pragma mark - Shadow

@property (nonatomic, assign)IBInspectable BOOL shadowEffect;
@property (nonatomic, assign) CGRect shadowPathRect;
@property (nonatomic, assign)IBInspectable CGFloat shadowOffsetX;
@property (nonatomic, assign)IBInspectable CGFloat shadowOffsetY;
@property (nonatomic, assign)IBInspectable CGFloat shadowRadius;
@property (nonatomic, strong)IBInspectable UIColor *shadowColor;

#pragma mark - Button

@property (nonatomic, assign)VHButtonEnum buttonEnum;
@property (nonatomic, assign)IBInspectable BOOL backgroundEffect;
@property (nonatomic, strong)IBInspectable UIColor *normalColor;
@property (nonatomic, strong)IBInspectable UIColor *highlightedColor;
@property (nonatomic, strong)IBInspectable UIColor *unableColor;
@property (nonatomic, assign) BOOL draggable;
@property (nonatomic, assign) UIEdgeInsets edgeInsetsInSuperView;

#pragma mark - Piece

@property (nonatomic, assign)IBInspectable CGFloat dotRadius;
@property (nonatomic, assign)IBInspectable CGFloat hamWidth;
@property (nonatomic, assign)IBInspectable CGFloat hamHeight;
@property (nonatomic, assign)IBInspectable CGFloat pieceCornerRadius;
@property (nonatomic, assign)IBInspectable CGFloat pieceHorizontalMargin;
@property (nonatomic, assign)IBInspectable CGFloat pieceVerticalMargin;
@property (nonatomic, assign)IBInspectable CGFloat pieceInclinedMargin;
@property (nonatomic, assign)IBInspectable CGFloat shareLineLength;
@property (nonatomic, strong)IBInspectable UIColor *shareLine1Color;
@property (nonatomic, strong)IBInspectable UIColor *shareLine2Color;
@property (nonatomic, assign)IBInspectable CGFloat shareLineWidth;
@property (nonatomic, assign) VHPiecePlaceEnum piecePlaceEnum;

#pragma mark - Background

@property (nonatomic, assign)IBInspectable BOOL blurBackground;
@property (nonatomic, strong)UIBlurEffect *blurEffect NS_AVAILABLE_IOS(8_0);
@property (nonatomic, strong)IBInspectable UIColor *dimColor;
@property (nonatomic, strong)IBInspectable NSString *tip;

#pragma mark - Animation

@property (nonatomic, weak) id<VHBoomDelegate> boomDelegate;
@property (nonatomic, assign)IBInspectable CFTimeInterval delay;
@property (nonatomic, assign)IBInspectable CFTimeInterval duration;
@property (nonatomic, assign)IBInspectable CFTimeInterval showDelay;
@property (nonatomic, assign)IBInspectable CFTimeInterval showDuration;
@property (nonatomic, assign)IBInspectable CFTimeInterval hideDelay;
@property (nonatomic, assign)IBInspectable CFTimeInterval hideDuration;
@property (nonatomic, assign)IBInspectable BOOL cancelable;
@property (nonatomic, assign)IBInspectable BOOL autoHide;
@property (nonatomic, assign) VHOrderEnum orderEnum;
@property (nonatomic, assign)IBInspectable int frames;
@property (nonatomic, assign) VHBoomEnum boomEnum;
@property (nonatomic, strong) NSString *showEaseName;
@property (nonatomic, strong) NSString *showMoveEaseName;
@property (nonatomic, strong) NSString *showScaleEaseName;
@property (nonatomic, strong) NSString *showRotateEaseName;
@property (nonatomic, strong) NSString *hideEaseName;
@property (nonatomic, strong) NSString *hideMoveEaseName;
@property (nonatomic, strong) NSString *hideScaleEaseName;
@property (nonatomic, strong) NSString *hideRotateEaseName;
@property (nonatomic, assign)IBInspectable CGFloat rotateDegree;
@property (nonatomic, assign) BOOL use3DTransformAnimation;

#pragma mark - Boom Buttons

@property (nonatomic, assign) VHButtonPlaceEnum buttonPlaceEnum;
@property (nonatomic, assign) VHButtonPlaceAlignmentEnum buttonPlaceAlignmentEnum;
@property (nonatomic, assign)IBInspectable CGFloat buttonHorizontalMargin;
@property (nonatomic, assign)IBInspectable CGFloat buttonVerticalMargin;
@property (nonatomic, assign)IBInspectable CGFloat buttonInclinedMargin;
@property (nonatomic, assign)IBInspectable CGFloat buttonBottomMargin;
@property (nonatomic, assign)IBInspectable CGFloat buttonTopMargin;
@property (nonatomic, assign)IBInspectable CGFloat buttonLeftMargin;
@property (nonatomic, assign)IBInspectable CGFloat buttonRightMargin;
@property (nonatomic, assign)IBInspectable CGFloat bottomHamButtonTopMargin;

#pragma mark - Static Methods

+ (NSInteger)pieceNumber:(VHPiecePlaceEnum)placeEnum;

+ (NSInteger)buttonNumber:(VHButtonPlaceEnum)placeEnum;

#pragma mark - Animation

- (BOOL)isAnimating;

- (void)boom;

- (void)boomImmediately;

- (void)reboom;

- (void)reboomImmediately;

#pragma mark - Builders

- (void)addBuilder:(VHBoomButtonBuilder *)builder;

- (void)setBuilder:(VHBoomButtonBuilder *)builder at:(NSUInteger)index;

- (void)setBuilders:(NSMutableArray<VHBoomButtonBuilder *> *)builders;

- (VHBoomButtonBuilder *)builder:(NSUInteger)index;

- (void)removeBuilder:(VHBoomButtonBuilder *)builder;

- (void)removeBuilderAtIndex:(NSUInteger)index;

- (void)clearBuilders;

@end
