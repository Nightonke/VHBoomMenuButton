//
//  VHHamButtonBuilder.h
//  VHBoomMenuButton
//
//  Created by Nightonke on 16/8/7.
//  Copyright © 2016年 Nightonke. All rights reserved.
//

#import "VHBoomButtonWithTextBuilder.h"

@interface VHHamButtonBuilder : VHBoomButtonWithTextBuilder

#pragma mark - Button

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

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

#pragma mark - Public Methods

+ (VHHamButtonBuilder *)builder;

@end
