//
//  VHBoomPiece.m
//  VHBoomMenuExample
//
//  Created by Nightonke on 16/7/31.
//  Copyright © 2016 Nightonke. All rights reserved.
//

#import "VHBoomPiece.h"
#import "VHBoomButtonBuilder_protected.h"

@implementation VHBoomPiece

#pragma mark - In-BMB-Only Methods

- (instancetype)initWithFrame:(CGRect)frame
                  withBuilder:(VHBoomButtonBuilder *)builder
             withCornerRadius:(CGFloat)cornerRadius
{
    if (self = [super initWithFrame:frame])
    {
        self.layer.allowsEdgeAntialiasing = YES;

        if (cornerRadius >= 0)
        {
            self.layer.cornerRadius = cornerRadius;
        }
        else
        {
            if ([builder innerType] == VHButtonHam)
            {
                self.layer.cornerRadius = 0;
            }
            else
            {
                self.layer.cornerRadius = frame.size.width / 2;
            }
        }
        self.layer.backgroundColor = builder.innerPieceColor.CGColor;
        builder.piece = self;
    }
    return self;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    // We just do nothing here because when BMB is used in TableView.
    // If the tableView is selected, the background color of all its subviews will be changed.
}

- (void)innerSetColor:(UIColor *)color
{
    self.layer.backgroundColor = color.CGColor;
}

#pragma mark - Private Methods

@end
