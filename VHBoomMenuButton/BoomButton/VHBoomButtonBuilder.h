//
//  VHBoomButtonBuilder.h
//  VHBoomMenuExample
//
//  Created by Nightonke on 16/7/31.
//  Copyright © 2016年 Nightonke. All rights reserved.
//

#import "VHInnerOnBoomButtonClickListener.h"
#import "VHBoomButton.h"

@class VHBoomButton;

typedef void (^OnBoomButtonClickedBlock)(int index);

@interface VHBoomButtonBuilder : NSObject

#pragma mark - Basic

@property (nonatomic, assign) int innerIndex;
@property (nonatomic, weak) id<VHInnerOnBoomButtonClickListener> innerListener;
@property (nonatomic, copy) OnBoomButtonClickedBlock clickedBlock;
@property (nonatomic, assign) BOOL unable;
@property (nonatomic, assign) BOOL rotateImage;

#pragma mark - Piece

@property (nonatomic, strong) UIColor *pieceColor;

#pragma mark - Shadow

@property (nonatomic, assign) BOOL shadowEffect;
@property (nonatomic, assign) CGRect shadowPathRect;
@property (nonatomic, assign) CGFloat shadowOffsetX;
@property (nonatomic, assign) CGFloat shadowOffsetY;
@property (nonatomic, assign) CGFloat shadowRadius;
@property (nonatomic, strong) UIColor *shadowColor;

#pragma mark - Image

@property (nonatomic, copy) NSString *normalImageName;
@property (nonatomic, strong) UIImage *normalImage;
@property (nonatomic, copy) NSString *highlightedImageName;
@property (nonatomic, strong) UIImage *highlightedImage;
@property (nonatomic, copy) NSString *unableImageName;
@property (nonatomic, strong) UIImage *unableImage;
@property (nonatomic, strong) UIColor *normalImageTintColor;
@property (nonatomic, strong) UIColor *highlightedImageTintColor;
@property (nonatomic, strong) UIColor *unableImageTintColor;
@property (nonatomic, assign) CGRect imageFrame;
@property (nonatomic, assign) CGSize imageSize;

#pragma mark - Button

@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *highlightedColor;
@property (nonatomic, strong) UIColor *unableColor;
@property (nonatomic, assign) CGFloat cornerRadius;

#pragma mark - Public Methods

+ (VHBoomButtonBuilder *)builder;

#pragma mark - In-BMB-Only Methods

- (VHBoomButton *)innerBuild;

- (UIColor *)innerPieceColor;

- (VHButtonEnum)innerType;

@end
