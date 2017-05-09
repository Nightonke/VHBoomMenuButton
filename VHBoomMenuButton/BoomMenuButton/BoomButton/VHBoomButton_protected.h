//
//  VHBoomButton_protected.h
//  VHBoomMenuButton
//
//  Created by Nightonke on 2017/4/11.
//  Copyright © 2017 Nightonke. All rights reserved.
//

#ifndef VHBoomButton_protected_h
#define VHBoomButton_protected_h

#import "VHBoomButtonDelegate.h"
#import "VHBoomButtonBuilder.h"
#import "VHButtonStateEnum.h"

@interface VHBoomButton ()

#pragma mark - Basic

@property (nonatomic, assign) int innerIndex;
@property (nonatomic, weak) id<VHBoomButtonDelegate> innerListener;
@property (nonatomic, copy) BoomButtonDidClickBlock clickedBlock;
@property (nonatomic, assign) BOOL unable;
@property (nonatomic, assign) VHButtonStateEnum lastStateEnum;

#pragma mark - Piece

@property (nonatomic, strong) UIColor *pieceColor;

#pragma mark - Shadow

@property (nonatomic, assign) BOOL hasShadow;
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
@property (nonatomic, assign) BOOL rotateImage;
@property (nonatomic, strong) UIImageView *imageView;

#pragma mark - Button

@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *highlightedColor;
@property (nonatomic, strong) UIColor *unableColor;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, assign) BOOL round;
@property (nonatomic, strong) CAShapeLayer *buttonLayer;

#pragma mark - Text

@property (nonatomic, copy) NSString *normalText;
@property (nonatomic, copy) NSString *highlightedText;
@property (nonatomic, copy) NSString *unableText;

@property (nonatomic, copy) NSAttributedString *normalAttributedText;
@property (nonatomic, copy) NSAttributedString *highlightedAttributedText;
@property (nonatomic, copy) NSAttributedString *unableAttributedText;

@property (nonatomic, strong) UIColor *normalTextColor;
@property (nonatomic, strong) UIColor *highlightedTextColor;
@property (nonatomic, strong) UIColor *unableTextColor;

@property (nonatomic, assign) CGRect textFrame;
@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, assign) NSTextAlignment textAlignment;
@property (nonatomic, assign) NSLineBreakMode textLineBreakMode;
@property (nonatomic, assign) int textLines;

@property (nonatomic, strong) UIColor *textShadowColor;
@property (nonatomic, assign) CGFloat textShadowOffsetX;
@property (nonatomic, assign) CGFloat textShadowOffsetY;

@property (nonatomic, assign) BOOL rotateText;

@property (nonatomic, strong) UILabel *label;

#pragma mark - Sub Text

@property (nonatomic, assign) BOOL containsSubText;

@property (nonatomic, copy) NSString *normalSubText;
@property (nonatomic, copy) NSString *highlightedSubText;
@property (nonatomic, copy) NSString *unableSubText;

@property (nonatomic, copy) NSAttributedString *normalAttributedSubText;
@property (nonatomic, copy) NSAttributedString *highlightedAttributedSubText;
@property (nonatomic, copy) NSAttributedString *unableAttributedSubText;

@property (nonatomic, strong) UIColor *normalSubTextColor;
@property (nonatomic, strong) UIColor *highlightedSubTextColor;
@property (nonatomic, strong) UIColor *unableSubTextColor;

@property (nonatomic, assign) CGRect subTextFrame;
@property (nonatomic, strong) UIFont *subTextFont;
@property (nonatomic, assign) NSTextAlignment subTextAlignment;
@property (nonatomic, assign) NSLineBreakMode subTextLineBreakMode;
@property (nonatomic, assign) int subTextLines;

@property (nonatomic, strong) UIColor *subTextShadowColor;
@property (nonatomic, assign) CGFloat subTextShadowOffsetX;
@property (nonatomic, assign) CGFloat subTextShadowOffsetY;

@property (nonatomic, strong) UILabel *subLabel;

#pragma mark - Private Usage

@property (nonatomic, assign) BOOL rotateAnchorPointInitialized;

- (instancetype)initWithBuilder:(VHBoomButtonBuilder *)builder;

@end

#endif /* VHBoomButton_protected_h */
