//
//  VHBoomButtonWithTextBuilder.h
//  VHBoomMenuButton
//
//  Created by viktorhuang on 2017/4/13.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

#import "VHBoomButtonBuilder.h"

@interface VHBoomButtonWithTextBuilder : VHBoomButtonBuilder

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

@end
