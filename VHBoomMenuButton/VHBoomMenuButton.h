//
//  VHBoomMenuButton.h
//  VHBoomMenuExample
//
//  Created by 黄伟平 on 16/7/28.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VHDot.h"
#import "VHPiecePlaceEnum.h"
#import "VHButtonEnum.h"
#import "VHOrderEnum.h"
#import "VHPiecePlaceManager.h"
#import "VHButtonPlaceEnum.h"
#import "VHButtonPlaceManager.h"
#import "VHUtils.h"
#import "VHSimpleCircleButton.h"
#import "VHSimpleCircleButtonBuilder.h"
#import "VHAnimationManager.h"
#import "VHBoomEnum.h"
#import "VHDefaults.h"
#import "VHButtonClickDelegate.h"
#import "VHBackgroundView.h"
#import "VHBackgroundClickDelegate.h"
#import "VHBoomDelegate.h"
#import "VHBoomButtonBuilder.h"
#import "VHBoomPiece.h"
#import "VHEaseEnum.h"

@interface VHBoomMenuButton : UIView<VHButtonClickDelegate, VHBackgroundClickDelegate>

@property (nonatomic        ) CGFloat             shadowRadius;// BMB's shadow radius
@property (nonatomic        ) CGSize              shadowOffset;// BMB's shadow offset relative to itself
@property (nonatomic        ) CGFloat             shadowOpacity;// BMB's shadow opacity
@property (nonatomic        ) UIColor             *shadowColor;

@property (nonatomic        ) CGFloat             buttonRadius;
@property (nonatomic, strong) CAShapeLayer        *buttonCircle;
@property (nonatomic, strong) VHBackgroundView    *background;

@property (nonatomic        ) CGFloat             dotRadius;
@property (nonatomic        ) CGFloat             barWidth;
@property (nonatomic        ) CGFloat             barHeight;
@property (nonatomic        ) CGFloat             blockWidth;
@property (nonatomic        ) CGFloat             blockHeight;

@property (nonatomic        ) CGFloat             simpleCircleButtonRadius;
// Values for other buttons here.

@property (nonatomic, strong) UIColor             *buttonNormalColor;
@property (nonatomic, strong) UIColor             *buttonPressedColor;

@property (nonatomic, strong) NSMutableArray<VHBoomPiece         *> *pieces;

@property (nonatomic, strong) NSMutableArray<VHBoomButton        *> *boomButtons;
@property (nonatomic, strong) NSMutableArray<VHBoomButtonBuilder *> *boomButtonBuilders;

@property (nonatomic        ) VHButtonEnum        buttonEnum;
@property (nonatomic        ) VHPiecePlaceEnum    piecePlaceEnum;
@property (nonatomic        ) VHButtonPlaceEnum   buttonPlaceEnum;
@property (nonatomic        ) VHOrderEnum         showOrderEnum;
@property (nonatomic        ) VHOrderEnum         hideOrderEnum;
@property (nonatomic        ) VHBoomEnum          boomEnum;

@property (nonatomic, strong) NSMutableArray<NSValue             *> *startPositions;
@property (nonatomic, strong) NSMutableArray<NSValue             *> *endPositions;

@property (nonatomic        ) VHEaseEnum          showMoveEaseEnum;
@property (nonatomic        ) VHEaseEnum          showScaleEaseEnum;
@property (nonatomic        ) VHEaseEnum          showRotateEaseEnum;
@property (nonatomic        ) VHEaseEnum          hideMoveEaseEnum;
@property (nonatomic        ) VHEaseEnum          hideScaleEaseEnum;
@property (nonatomic        ) VHEaseEnum          hideRotateEaseEnum;

@property (nonatomic        ) UIColor             *dimColor;
@property (nonatomic        ) BOOL                autoHide;
@property (nonatomic        ) BOOL                cancelable;
@property (nonatomic        ) int                 frames;
@property (nonatomic        ) float               duration;
@property (nonatomic        ) float               delay;
@property (nonatomic        ) float               rotationDegree;
@property (nonatomic, weak  ) id<VHBoomDelegate > boomDelegate;

@property (nonatomic        ) int                 animatingViewsNumber;

- (void)addBuilderBlock:(void(^)(VHSimpleCircleButtonBuilder *))block;

@end
