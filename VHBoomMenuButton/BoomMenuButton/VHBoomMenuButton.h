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

/**
 Whether use a cache optimization. If @b YES , then the boom-buttons and their background view on
 screen will be kept by BMB. So BMB doesn't need to re-create them the next time it booms.
 
 The default value is @b YES .
 */
@property (nonatomic, assign)IBInspectable BOOL cacheOptimized;

/**
 Whether the BMB booms its boom-buttons in the whole screen. If @b NO, then BMB booms boom-buttons
 in its superview.
 
 The default value is @b YES .
 */
@property (nonatomic, assign)IBInspectable BOOL isBoomInWholeScreen;

/**
 Whether the BMB is used in a cell of table view. If YES, then BMB will not keep the boom-buttons 
 and the background view to avoid memory leaks and do some re-calculate jobs when table view has 
 been scrolled.
 
 This value @b MUST be @b YES when BMB is used in table view.
 
 The default value is @b NO .
 */
@property (nonatomic, assign)IBInspectable BOOL isInList;

#pragma mark - Shadow

/**
 Whether BMB has a shadow.
 
 The default value is @b YES .
 */
@property (nonatomic, assign)IBInspectable BOOL hasShadow;

/**
 Rect (in points) of shadow path of BMB.
 
 The default value is (2, 2, BMB.width - 4, BMB.height - 4) .
 */
@property (nonatomic, assign)IBInspectable CGRect shadowPathRect;

/**
 Offset (in points) of shadow on x axis.
 
 The default value is @b 0 .
 */
@property (nonatomic, assign)IBInspectable CGFloat shadowOffsetX;

/**
 Offset (in points) of shadow on y axis.
 
 The default value is @b 8 .
 */
@property (nonatomic, assign)IBInspectable CGFloat shadowOffsetY;

/**
 The blur radius (in points) used to render the BMB’s shadow.
 
 The default value is @b 4 .
 */
@property (nonatomic, assign)IBInspectable CGFloat shadowRadius;

/**
 The color of BMB's shadow.
 
 The default value is @b 0x44000000 .
 */
@property (nonatomic, strong)IBInspectable UIColor *shadowColor;

#pragma mark - Button

/**
 VHButtonEnum of BMB. This property tells BMB what kind of boom-button that it needs to boom.
 
 It should be one of the following enums: @b VHButtonSimpleCircle , @b VHButtonTextInsideCircle , @b VHButtonTextOutsideCircle and
 @b VHButtonHam .
 
 Notice that VHButtonEnum must correspond with VHPiecePlaceEnum and VHButtonPlaceEnum.
 
 Check https://github.com/Nightonke/VHBoomMenuButton/wiki for more information.
 
 The default value is @b VHButtonUnknown .
 */
@property (nonatomic, assign)VHButtonEnum buttonEnum;

/**
 Whether the BMB has the circular background. BMB should not have a background effect when used in navigation bar or table view.
 
 The default value is @b YES .
 */
@property (nonatomic, assign)IBInspectable BOOL hasBackground;

/**
 The color of BMB at normal state.
 
 The default value is @b 0x30a2fb .
 */
@property (nonatomic, strong)IBInspectable UIColor *normalColor;

/**
 The color of BMB at highlighted state.
 
 The default value is @b 0x73bdf1 .
 */
@property (nonatomic, strong)IBInspectable UIColor *highlightedColor;

/**
 The color of BMB at unable state. BMB can be set to unable state by BMB.userInteractionEnabled = NO.
 
 The default value is @b 0x30a2fb .
 */
@property (nonatomic, strong)IBInspectable UIColor *unableColor;

/**
 Whether BMB is draggable. If YES, BMB can be dragged in its superview.
 
 The default value is @b NO .
 */
@property (nonatomic, assign)IBInspectable BOOL draggable;

/**
 The top, left, bottom and right margins in BMB's superview when BMB is draggable.
 
 The default value is UIEdgeInsetsMake(15, 15, 15, 15).
 */
@property (nonatomic, assign) UIEdgeInsets edgeInsetsInSuperView;

#pragma mark - Piece

/**
 The radius (in points) of dots on BMB.
 
 The default value is @b 3 .
 */
@property (nonatomic, assign)IBInspectable CGFloat dotRadius;

/**
 The width (in points) of hams on BMB.
 
 The default value is @b 20 .
 */
@property (nonatomic, assign)IBInspectable CGFloat hamWidth;

/**
 The height (in points) of hams on BMB.
 
 The default value is @b 3 .
 */
@property (nonatomic, assign)IBInspectable CGFloat hamHeight;

/**
 The corner radius (in points) of pieces on BMB. Pieces include dots and hams. 
 This property can make the dots look like blocks, which is useful when boom-buttons are square. 
 A negative corner radius does no effect.
 
 The default value is @b -1 .
 */
@property (nonatomic, assign)IBInspectable CGFloat pieceCornerRadius;

/**
 The horizontal margin (in points) of pieces on BMB.
 
 The default value is @b 2 .
 */
@property (nonatomic, assign)IBInspectable CGFloat pieceHorizontalMargin;

/**
 The vertical margin (in points) of pieces on BMB.
 
 The default value is @b 2 .
 */
@property (nonatomic, assign)IBInspectable CGFloat pieceVerticalMargin;

/**
 The inclined margin (in points) of pieces on BMB.
 
 The default value is @b 2 .
 */
@property (nonatomic, assign)IBInspectable CGFloat pieceInclinedMargin;

/**
 The length (in points) of the 2 lines in share style.
 
 The default value is @b 18 .
 */
@property (nonatomic, assign)IBInspectable CGFloat shareLineLength;

/**
 The color of the first line (the higher one) in share style.
 
 The default value is [UIColor whiteColor].
 */
@property (nonatomic, strong)IBInspectable UIColor *shareLine1Color;

/**
 The color of the second line (the lower one) in share style.
 
 The default value is [UIColor whiteColor].
 */
@property (nonatomic, strong)IBInspectable UIColor *shareLine2Color;

/**
 The width (in points) of the 2 lines in share style.
 
 The default value is @b 1.5 .
 */
@property (nonatomic, assign)IBInspectable CGFloat shareLineWidth;

/**
 VHPiecePlaceEnum tells BMB how the pieces should be placed on BMB.
 
 Check VHPiecePlaceEnum.h file to check all piece-place-enums.
 
 Notice that VHPiecePlaceEnum must correspond with VHButtonEnum and VHButtonPlaceEnum.
 
 Check https://github.com/Nightonke/VHBoomMenuButton/wiki for more information.
 */
@property (nonatomic, assign) VHPiecePlaceEnum piecePlaceEnum;

#pragma mark - Background

/**
 Whether use a blur background. Notice that blur effect only works on iOS 8.0 or above.
 
 The default value is NO.
 */
@property (nonatomic, assign)IBInspectable BOOL backgroundBlurred;

/**
 Blur effect of background. Notice that blur effect only works on iOS 8.0 or above.
 
 The default value is [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark].
 */
@property (nonatomic, strong)UIBlurEffect *blurEffect NS_AVAILABLE_IOS(8_0);

/**
 The color of the background-dim animation when BMB booms.
 
 The default value is @b 0x55000000 .
 */
@property (nonatomic, strong)IBInspectable UIColor *dimColor;

/**
 The tip string on background when BMB finishes the booming animation.
 
 The default valus is @b nil .
 */
@property (nonatomic, strong)IBInspectable NSString *tip;

/**
 Whether the tip string is put below the boom-buttons on background.
 
 The default value is @b NO .
 */
@property (nonatomic, assign)IBInspectable BOOL tipBelowButtons;

/**
 The margin (in points) between label of tip and the highest boom-button (if tipBelowButtons is NO) or 
 the lowest boom-button (if tipBelowButtons is YES).
 
 The default value is @b 40 .
 */
@property (nonatomic, assign)IBInspectable CGFloat tipButtonMargin;

#pragma mark - Animation

/**
 The VHBoomDelegate of BMB. Check VHBoomDelegate.h for more information.
 
 The default value is nil.
 */
@property (nonatomic, weak) id<VHBoomDelegate> boomDelegate;

/**
 The delay (in seconds) among each boom-button when booming and rebooming.
 
 The default value is @b 0.05 .
 */
@property (nonatomic, assign)IBInspectable CFTimeInterval delay;

/**
 The duration (in seconds) of each boom-button when booming and rebooming.
 
 The default value is @b 0.3 .
 */
@property (nonatomic, assign)IBInspectable CFTimeInterval duration;

/**
 The delay (in seconds) among each boom-button when booming.
 
 The default value is @b 0.05 .
 */
@property (nonatomic, assign)IBInspectable CFTimeInterval boomDelay;

/**
 The duration (in seconds) of each boom-button when booming.
 
 The default value is @b 0.3 .
 */
@property (nonatomic, assign)IBInspectable CFTimeInterval boomDuration;

/**
 The delay (in seconds) among each boom-button when rebooming.
 
 The default value is @b 0.05 .
 */
@property (nonatomic, assign)IBInspectable CFTimeInterval reboomDelay;

/**
 The duration (in seconds) of each boom-button when rebooming.
 
 The default value is @b 0.3 .
 */
@property (nonatomic, assign)IBInspectable CFTimeInterval reboomDuration;

/**
 Whether BMB rebooms when the background view is clicked.
 
 The default value is @b YES .
 */
@property (nonatomic, assign)IBInspectable BOOL cancelable;

/**
 Whether BMB rebooms when one of the boom-buttons is clicked.
 
 The default value is @b YES .
 */
@property (nonatomic, assign)IBInspectable BOOL autoHide;

/**
 The order of animtions of boom-buttons when booming and rebooming.
 
 The default value is @b VHOrderRandom .
 */
@property (nonatomic, assign) VHOrderEnum orderEnum;

/**
 How many frames should the booming and rebooming animations have.
 
 The default value is @b 60 .
 */
@property (nonatomic, assign)IBInspectable int frames;

/**
 The boom-enum of booming and rebooming animations. This property changes the track of the boom-buttons' movement.
 
 The default value is VHBoomHorizontalThrow2;
 */
@property (nonatomic, assign) VHBoomEnum boomEnum;

/**
 The name of the ease using in movement, scale and rotation animations of boom-buttons when booming. This property is used to change movement, scale and rotation animations' ease name with a line of code.
 
 Check VHEase.h to find all the ease-names supported by BMB.
 
 The default value is @b VHEaseOutBack .
 */
@property (nonatomic, strong) NSString *boomEaseName;

/**
 The name of the ease using in movement animations of boom-buttons when booming.
 
 Check VHEase.h to find all the ease-names supported by BMB.
 
 The default value is @b VHEaseOutBack .
 */
@property (nonatomic, strong) NSString *boomMoveEaseName;

/**
 The name of the ease using in scale animations of boom-buttons when booming.
 
 Check VHEase.h to find all the ease-names supported by BMB.
 
 The default value is @b VHEaseOutBack .
 */
@property (nonatomic, strong) NSString *boomScaleEaseName;

/**
 The name of the ease using in rotation animations of boom-buttons when booming.
 
 Check VHEase.h to find all the ease-names supported by BMB.
 
 The default value is @b VHEaseOutBack .
 */
@property (nonatomic, strong) NSString *boomRotateEaseName;

/**
 The name of the ease using in movement, scale and rotation animations of boom-buttons when rebooming. This property is used to change movement, scale and rotation animations' ease name with a line of code.
 
 Check VHEase.h to find all the ease-names supported by BMB.
 
 The default value is @b VHEaseInBack .
 */
@property (nonatomic, strong) NSString *reboomEaseName;

/**
 The name of the ease using in movement animations of boom-buttons when rebooming.
 
 Check VHEase.h to find all the ease-names supported by BMB.
 
 The default value is @b VHEaseInBack .
 */
@property (nonatomic, strong) NSString *reboomMoveEaseName;

/**
 The name of the ease using in scale animations of boom-buttons when rebooming.
 
 Check VHEase.h to find all the ease-names supported by BMB.
 
 The default value is @b VHEaseInBack .
 */
@property (nonatomic, strong) NSString *reboomScaleEaseName;

/**
 The name of the ease using in rotation animations of boom-buttons when rebooming.
 
 Check VHEase.h to find all the ease-names supported by BMB.
 
 The default value is @b VHEaseInBack .
 */
@property (nonatomic, strong) NSString *reboomRotateEaseName;

/**
 The degree (in π) of rotation animations when booming.
 In reboomming, the value is -degree.
 
 The default value is @b 4π .
 */
@property (nonatomic, assign)IBInspectable CGFloat rotateDegree;

/**
 Whether use a 3D transform animation when booming or rebooming.
 
 The default value is @b YES .
 */
@property (nonatomic, assign)IBInspectable BOOL use3DTransformAnimation;

/**
 Whether BMB will boom automatically with animations when its drawRect method is called. This property can be useful if the BMB is supposed to boom when its view-controller appears.
 
 The defalut value is @b NO .
 */
@property (nonatomic, assign)IBInspectable BOOL autoBoom;

/**
 Whether BMB will boom automatically without animations when its drawRect method is called. This property can be useful if the BMB is supposed to boom when its view-controller appears.
 
 The defalut value is @b NO .
 */
@property (nonatomic, assign)IBInspectable BOOL autoBoomImmediately;

#pragma mark - Boom Buttons

/**
 VHButtonPlaceEnum tells BMB how the boom-buttons should be placed on the background when booming.
 
 Check VHButtonPlaceEnum.h file to check all button-place-enums.
 
 Notice that VHButtonPlaceEnum must correspond with VHButtonEnum and VHPiecePlaceEnum.
 
 Check https://github.com/Nightonke/VHBoomMenuButton/wiki for more information.
 
 The default value is @b VHButtonPlaceUnknown .
 */
@property (nonatomic, assign) VHButtonPlaceEnum buttonPlaceEnum;

/**
 VHButtonPlaceAlignmentEnum tells BMB the boom-buttons' alignment position. For instance, you can put all the boom-buttons align-bottom with VHButtonPlaceAlignmentBottom.
 
 The default value is @b VHButtonPlaceAlignmentCenter .
 */
@property (nonatomic, assign) VHButtonPlaceAlignmentEnum buttonPlaceAlignmentEnum;

/**
 The horizontal margin (in points) among boom-buttons.
 
 The default value is @b 12 .
 */
@property (nonatomic, assign)IBInspectable CGFloat buttonHorizontalMargin;

/**
 The vertical margin (in points) among boom-buttons.
 
 The default value is @b 12 .
 */
@property (nonatomic, assign)IBInspectable CGFloat buttonVerticalMargin;

/**
 The inclined margin (in points) among boom-buttons.
 
 The default value is @b 12 .
 */
@property (nonatomic, assign)IBInspectable CGFloat buttonInclinedMargin;

/**
 The margin (in points) between boom-buttons and the bottom of screen when booming. Notice that this property only works when buttonPlaceAlignmentEnum is VHButtonPlaceAlignmentBottom, VHButtonPlaceAlignmentBottomLeft or VHButtonPlaceAlignmentBottomRight.
 
 The default value is @b 20 .
 */
@property (nonatomic, assign)IBInspectable CGFloat buttonBottomMargin;

/**
 The margin (in points) between boom-buttons and the top of screen when booming. Notice that this property only works when buttonPlaceAlignmentEnum is VHButtonPlaceAlignmentTop, VHButtonPlaceAlignmentTopLeft and VHButtonPlaceAlignmentTopRight.
 
 The default value is @b 20 .
 */
@property (nonatomic, assign)IBInspectable CGFloat buttonTopMargin;

/**
 The margin (in points) between boom-buttons and the left of screen when booming. Notice that this property only works when buttonPlaceAlignmentEnum is VHButtonPlaceAlignmentLeft, VHButtonPlaceAlignmentTopLeft or VHButtonPlaceAlignmentBottomLeft.
 
 The default value is @b 20 .
 */
@property (nonatomic, assign)IBInspectable CGFloat buttonLeftMargin;

/**
 The margin (in points) between boom-buttons and the right of screen when booming. Notice that this property only works when buttonPlaceAlignmentEnum is VHButtonPlaceAlignmentRight, VHButtonPlaceAlignmentTopRight or VHButtonPlaceAlignmentBottomRight.
 
 The default value is @b 20 .
 */
@property (nonatomic, assign)IBInspectable CGFloat buttonRightMargin;

/**
 The margin (in points) between the last boom-button and the last but one. This property is useful when the last boom-button is used as a 'Cancel' choice. Notice that this property only works when buttonEnum is VHButtonHam and its value must be positive.
 
 The default value is @b -1 .
 */
@property (nonatomic, assign)IBInspectable CGFloat bottomHamButtonTopMargin;

#pragma mark - Convenience Methods

/**
 Get the number of pieces from VHPiecePlaceEnum.
 Notice that in share-style BMB, the number of piece is NOT able to determined 
 from VHPiecePlaceEnum.

 @param placeEnum Piece-place-enum.
 @return Number of pieces.
 */
+ (NSInteger)pieceNumber:(VHPiecePlaceEnum)placeEnum;

/**
 Get the number of buttons from VHButtonPlaceEnum.

 @param placeEnum Button-place-enum.
 @return Number of buttons.
 */
+ (NSInteger)buttonNumber:(VHButtonPlaceEnum)placeEnum;

/**
 Get the number of pieces from VHPiecePlaceEnum.
 This method works only after the VHPiecePlaceEnum of BMB is set.

 @return Number of pieces.
 */
- (NSInteger)pieceNumber;

/**
 Get the number of buttons from VHButtonPlaceEnum.
 This method works only after the VHButtonPlaceEnum of BMB is set.

 @return Number of buttons.
 */
- (NSInteger)buttonNumber;

#pragma mark - Background

/**
 Add views to background view.
 The background view is the superview of boom-buttons when the animations are processing.
 The views added from this method will play alpha-animations when booming and rebooming.

 @param view View that's to be added into background.
 */
- (void)addViewToBackground:(UIView *)view;

/**
 Get the tip-label that shows a tip in background.
 Use this method to customize the tip-label.

 @return UILabel of tip in background.
 */
- (UILabel *)tipLabel;

#pragma mark - Animation

/**
 Whether BMB is animating.

 @return Is animating.
 */
- (BOOL)isAnimating;

/**
 Make BMB boom.
 BMB can only boom when it's NOT animating and it has finished rebooming.
 */
- (void)boom;

/**
 Make BMB boom immediately without animation.
 In fact, this method does the same job as boom with 1-millisecond duration.
 */
- (void)boomImmediately;

/**
 Make BMB reboom.
 BMB can only reboom when it's NOT animatiing and it has finished booming.
 */
- (void)reboom;

/**
 Make BMB reboom immdiately without animation.
 In fact, this method does the same job as reboom with 1-millisecond duration.
 */
- (void)reboomImmediately;

#pragma mark - Builders

/**
 Add a builder for a boom-button.
 Notice that boom-button is the sub-button of BMB and one builder for one boom-button.
 The builder should be a instance of: VHSimpleCircleButtonBuilder, VHTextInsideCircleButtonBuilder, 
 VHTextOutsideCircleButtonBuilder or VHHamButtonBuilder.

 @param builder Builder for a boom-button.
 */
- (void)addBuilder:(VHBoomButtonBuilder *)builder;

/**
 Replace a builder at the certain index.

 @param builder Builder.
 @param index Index.
 */
- (void)setBuilder:(VHBoomButtonBuilder *)builder at:(NSUInteger)index;

/**
 Replace all builders.

 @param builders Builders.
 */
- (void)setBuilders:(NSMutableArray<VHBoomButtonBuilder *> *)builders;

/**
 Get a builder at a centain index.
 This method is useful when a boom-button needs to change its attributes.
 The attributes of boom-button are able to be changed from its corresponding builder.

 @param index Index.
 @return The Builder.
 */
- (VHBoomButtonBuilder *)builder:(NSUInteger)index;

/**
 Remove a certain builder.

 @param builder Builder.
 */
- (void)removeBuilder:(VHBoomButtonBuilder *)builder;

/**
 Remove a builder at index.

 @param index Index.
 */
- (void)removeBuilderAtIndex:(NSUInteger)index;

/**
 Remove all builders.
 */
- (void)clearBuilders;

@end
