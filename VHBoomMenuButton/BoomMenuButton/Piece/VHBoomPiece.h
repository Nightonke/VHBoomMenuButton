//
//  VHBoomPiece.h
//  VHBoomMenuExample
//
//  Created by Nightonke on 16/7/31.
//  Copyright © 2016 Nightonke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VHBoomButtonBuilder.h"

@interface VHBoomPiece : UIView

@property (nonatomic, assign) BOOL isTop;
@property (nonatomic, strong) VHBoomPiece *pieceBelow;

#pragma mark - In-BMB-Only Methods

- (instancetype)initWithFrame:(CGRect)frame
                  withBuilder:(VHBoomButtonBuilder *)builder
             withCornerRadius:(CGFloat)cornerRadius;

- (void)innerSetColor:(UIColor *)color;

@end
