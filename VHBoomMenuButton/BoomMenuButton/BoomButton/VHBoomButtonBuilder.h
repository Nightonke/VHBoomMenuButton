//
//  VHBoomButtonBuilder.h
//  VHBoomMenuExample
//
//  Created by Nightonke on 16/7/31.
//  Copyright © 2016 Nightonke. All rights reserved.
//

#import "VHBoomButtonDelegate.h"
#import "VHBoomButton.h"

@class VHBoomButton;

/**
 Event block when the boom-button corresponding the builder itself is clicked.
 @code
 builder.clickedBlock = ^(int index) {
     // logic
 };
 @endcode
 
 @param index The index of the boom-button.
 */
typedef void (^BoomButtonDidClickBlock)(int index);

@interface VHBoomButtonBuilder : NSObject

#pragma mark - In-BMB-Only Properties

/**
 This property is @b only used in BMB package! @b DON'T modify it!
 */
@property (nonatomic, assign) int innerIndex;

/**
 This property is @b only used in BMB package! @b DON'T modify it!
 */
@property (nonatomic, weak) id<VHBoomButtonDelegate> innerListener;

#pragma mark - Basic

/**
 Event block when the boom-button corresponding the builder itself is clicked.
 @code
 builder.clickedBlock = ^(int index) {
     // logic
 };
 @endcode
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b nil .
 */
@property (nonatomic, copy) BoomButtonDidClickBlock clickedBlock;

/**
 Whether the boom-button is unable (for click event).
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b NO .
 */
@property (nonatomic, assign) BOOL unable;

/**
 Whether the image in boom-button plays a rotation animation.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b YES .
 */
@property (nonatomic, assign) BOOL rotateImage;

#pragma mark - Piece

/**
 The color of the corresponding piece. If the color of piece is nil (by default), then BMB will use the color of boom-button at normal state (if the boom-buttons is unable, then use color at unable state) to draw the piece. If the color of piece is different from boom-button's, then BMB will play a discoloration animation when booming or rebooming.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b nil .
 */
@property (nonatomic, strong) UIColor *pieceColor;

#pragma mark - Shadow

/**
 Whether the boom-button has a shadow effect.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b YES .
 */
@property (nonatomic, assign) BOOL hasShadow;

/**
 The rect of shadow path of boom-button.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value depends on different type of boom-buttons. Check the init methods in builders of different boom-buttons for more information.
 */
@property (nonatomic, assign) CGRect shadowPathRect;

/**
 The offset (in points) of shadow in x axis.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b 0 .
 */
@property (nonatomic, assign) CGFloat shadowOffsetX;

/**
 The offset (in points) of shadow in y axis.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b 8 .
 */
@property (nonatomic, assign) CGFloat shadowOffsetY;

/**
 The blur radius (in points) used to render the boom-button's shadow.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b 4 .
 */
@property (nonatomic, assign) CGFloat shadowRadius;

/**
 The color of the boom-button's shadow.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b 0x44000000 .
 */
@property (nonatomic, strong) UIColor *shadowColor;

#pragma mark - Image

/**
 The name of the image on the boom-button at normal state.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b nil .
 */
@property (nonatomic, copy) NSString *normalImageName;

/**
 The image on the boom-button at normal state.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b nil .
 */
@property (nonatomic, strong) UIImage *normalImage;

/**
 The name of the image on the boom-button at highlighted state.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b nil .
 */
@property (nonatomic, copy) NSString *highlightedImageName;

/**
 The image on the boom-button at highlighted state.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b nil .
 */
@property (nonatomic, strong) UIImage *highlightedImage;

/**
 The name of the image on the boom-button at unable state.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b nil .
 */
@property (nonatomic, copy) NSString *unableImageName;

/**
 The image on the boom-button at unable state.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b nil .
 */
@property (nonatomic, strong) UIImage *unableImage;

/**
 The tint color of image on boom-button at normal state.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b nil .
 */
@property (nonatomic, strong) UIColor *normalImageTintColor;

/**
 The tint color of image on boom-button at highlighted state.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b nil .
 */
@property (nonatomic, strong) UIColor *highlightedImageTintColor;

/**
 The tint color of image on boom-button at unable state.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b nil .
 */
@property (nonatomic, strong) UIColor *unableImageTintColor;

/**
 The frame of the image view on boom-button.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is CGRectMake(10, 10, 60, 60).
 */
@property (nonatomic, assign) CGRect imageFrame;

/**
 The image size of the image view on boom-button.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is CGSizeMake(60, 60).
 */
@property (nonatomic, assign) CGSize imageSize;

#pragma mark - Button

/**
 The color of boom-button at normal state.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is a random color.
 */
@property (nonatomic, strong) UIColor *normalColor;

/**
 The color of boom-button at highlighted state.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is a random color.
 */
@property (nonatomic, strong) UIColor *highlightedColor;

/**
 The color of boom-button at unable state.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is a random color.
 */
@property (nonatomic, strong) UIColor *unableColor;

/**
 The corner radius (in points) of boom-button.
 
 @b Synchronicity : Changing this property from builder will synchronically affect the corresponding boom-button, even the boom-button has been shown on the screen.
 
 The default value is @b 5 .
 */
@property (nonatomic, assign) CGFloat cornerRadius;

#pragma mark - Public Methods

/**
 Get a builder instance with default properties.

 @return An instance of builder.
 */
+ (VHBoomButtonBuilder *)builder;

#pragma mark - In-BMB-Only Methods

/**
 This method is @b only used in BMB package! @b DON'T modify it!
 */
- (VHBoomButton *)innerBuild;

/**
 This method is @b only used in BMB package! @b DON'T modify it!
 */
- (UIColor *)innerPieceColor;

/**
 This method is @b only used in BMB package! @b DON'T modify it!
 */
- (VHButtonEnum)innerType;

@end
