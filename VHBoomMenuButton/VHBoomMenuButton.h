//
//  VHBoomMenuButton.h
//  VHBoomMenuExample
//
//  Created by 黄伟平 on 16/7/28.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "VHBackgroundClickDelegate.h"
#import "VHBackgroundView.h"
#import "VHBoomDelegate.h"
#import "VHButtonClickDelegate.h"
#import "VHButtonEnum.h"
#import "VHDefaults.h"
#import "VHUtils.h"
#import "VHErrorManager.h"

#import "VHAnimationManager.h"
#import "VHBoomEnum.h"
#import "VHEase.h"
#import "VHEaseEnum.h"
#import "VHEaseManager.h"
#import "VHOrderEnum.h"

#import "VHButtonPlaceManager.h"
#import "VHButtonPlaceEnum.h"
#import "VHButtonPlaceAlignmentEnum.h"
#import "VHBoomButton.h"
#import "VHBoomButtonBuilder.h"
#import "VHSimpleCircleButton.h"
#import "VHSimpleCircleButtonBuilder.h"
#import "VHTextInsideCircleButton.h"
#import "VHTextInsideCircleButtonBuilder.h"
#import "VHTextOutsideCircleButton.h"
#import "VHTextOutsideCircleButtonBuilder.h"
#import "VHHamButton.h"
#import "VHHamButtonBuilder.h"

#import "VHBoomPiece.h"
#import "VHDot.h"
#import "VHHam.h"
#import "VHPiecePlaceEnum.h"
#import "VHPiecePlaceManager.h"

@interface VHBoomMenuButton : UIView<VHButtonClickDelegate, VHBackgroundClickDelegate>

@property (nonatomic, assign) CGFloat                    shadowRadius;// BMB's shadow radius
@property (nonatomic, assign) CGSize                     shadowOffset;// BMB's shadow offset relative to itself
@property (nonatomic, assign) CGFloat                    shadowOpacity;// BMB's shadow opacity
@property (nonatomic, strong) UIColor                    *shadowColor;

@property (nonatomic, strong) CAShapeLayer               *buttonCircle;
@property (nonatomic, strong) VHBackgroundView           *background;

@property (nonatomic, assign) CGFloat                    dotRadius;
@property (nonatomic, assign) CGFloat                    hamWidth;
@property (nonatomic, assign) CGFloat                    hamHeight;

@property (nonatomic, strong) UIColor                    *buttonNormalColor;
@property (nonatomic, strong) UIColor                    *buttonPressedColor;

@property (nonatomic, strong) NSMutableArray<VHBoomPiece *> *pieces;

@property (nonatomic, strong) NSMutableArray<VHBoomButton *> *boomButtons;
@property (nonatomic, strong) NSMutableArray<VHBoomButtonBuilder *> *boomButtonBuilders;

@property (nonatomic, assign) VHButtonEnum               buttonEnum;
@property (nonatomic, assign) VHPiecePlaceEnum           piecePlaceEnum;
@property (nonatomic, assign) VHButtonPlaceEnum          buttonPlaceEnum;
@property (nonatomic, assign) VHButtonPlaceAlignmentEnum buttonPlaceAlignmentEnum;
@property (nonatomic, assign) VHOrderEnum                showOrderEnum;
@property (nonatomic, assign) VHOrderEnum                hideOrderEnum;
@property (nonatomic, assign) VHBoomEnum                 boomEnum;

@property (nonatomic, strong) NSMutableArray<NSValue *>  *startPositions;
@property (nonatomic, strong) NSMutableArray<NSValue *>  *endPositions;

@property (nonatomic, assign) VHEaseEnum                 showMoveEaseEnum;
@property (nonatomic, assign) VHEaseEnum                 showScaleEaseEnum;
@property (nonatomic, assign) VHEaseEnum                 showRotateEaseEnum;
@property (nonatomic, assign) VHEaseEnum                 hideMoveEaseEnum;
@property (nonatomic, assign) VHEaseEnum                 hideScaleEaseEnum;
@property (nonatomic, assign) VHEaseEnum                 hideRotateEaseEnum;

@property (nonatomic, strong) UIColor                    *dimColor;
@property (nonatomic, assign) BOOL                       autoHide;
@property (nonatomic, assign) BOOL                       cancelable;
@property (nonatomic, assign) BOOL                       noBackground;
@property (nonatomic, assign) BOOL                       draggable;
@property (nonatomic, assign) int                        frames;
@property (nonatomic, assign) float                      duration;
@property (nonatomic, assign) float                      delay;
@property (nonatomic, assign) float                      rotationDegree;
@property (nonatomic, weak  ) id< VHBoomDelegate>        boomDelegate;

@property (nonatomic, assign) int                        animatingViewsNumber;

@property (nonatomic, assign) CGFloat                    buttonHorizontalMargin;
@property (nonatomic, assign) CGFloat                    buttonVerticalMargin;
@property (nonatomic, assign) CGFloat                    buttonInclinedMargin;
@property (nonatomic, assign) CGFloat                    buttonBottomMargin;
@property (nonatomic, assign) CGFloat                    buttonTopMargin;
@property (nonatomic, assign) CGFloat                    buttonLeftMargin;
@property (nonatomic, assign) CGFloat                    buttonRightMargin;
@property (nonatomic, assign) BOOL                       lastHamButtonMarginMoreTop;
@property (nonatomic, assign) CGFloat                    lastHamButtonTopMargin;

@property (nonatomic, assign) CGFloat                    pieceHorizontalMargin;
@property (nonatomic, assign) CGFloat                    pieceVerticalMargin;
@property (nonatomic, assign) CGFloat                    pieceInclinedMargin;

/**
 *  Boom the BMB programmatically
 */
- (void)boom;

/**
 *  Reboom the BMB programmatically
 */
- (void)reboom;

/**
 *  Add a simiple circle button builder
 *
 *  @param block The block where you set the properties for the builder
 */
- (void)addSimpleCircleButtonBuilderBlock:(void(^)(VHSimpleCircleButtonBuilder *))block;

/**
 *  Add a text inside button builder
 *
 *  @param block The block where you set the properties for the builder
 */
- (void)addTextInsideCircleButtonBuilderBlock:(void(^)(VHTextInsideCircleButtonBuilder *))block;

/**
 *  Add a text outside button builder
 *
 *  @param block The block where you set the properties for the builder
 */
- (void)addTextOutsideCircleButtonBuilderBlock:(void(^)(VHTextOutsideCircleButtonBuilder *))block;

/**
 *  Add a ham button builder
 *
 *  @param block The block where you set the properties for the builder
 */
- (void)addHamButtonBuilderBlock:(void(^)(VHHamButtonBuilder *))block;

/**
 *  Remove all builders added
 */
- (void)removeBuilders;

@end
