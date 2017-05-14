//
//  BlurBackgroundAndTipVC.m
//  VHBoomMenuButtonDemo
//
//  Created by Nightonke on 2017/4/21.
//  Copyright © 2017 Nightonke. All rights reserved.
//

#import "BlurBackgroundAndTipVC.h"
#import "BuilderManager.h"
#import <BoomMenuButton/BoomMenuButton.h>

@interface BlurBackgroundAndTipVC ()

@property (weak, nonatomic) IBOutlet VHBoomMenuButton *bmb1;
@property (weak, nonatomic) IBOutlet VHBoomMenuButton *bmb2;
@property (weak, nonatomic) IBOutlet VHBoomMenuButton *bmb3;

@end

@implementation BlurBackgroundAndTipVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.bmb1.buttonEnum = VHButtonSimpleCircle;
    self.bmb1.piecePlaceEnum = VHPiecePlaceDOT_9_1;
    self.bmb1.buttonPlaceEnum = VHButtonPlaceSC_9_1;
    self.bmb1.pieceCornerRadius = 1;
    self.bmb1.backgroundBlurred = YES;
    self.bmb1.blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    self.bmb1.tip = @"Select an animal to feed!";
    self.bmb1.tipBelowButtons = YES;
    self.bmb1.tipButtonMargin = 30;
    self.bmb1.tipLabel.textColor = [UIColor darkGrayColor];
    for (int i = 0; i < self.bmb1.pieceNumber; i++)
    {
        [self.bmb1 addBuilder:[BuilderManager squareSimpleCircleButtonBuilder]];
    }
    
    self.bmb2.buttonEnum = VHButtonHam;
    self.bmb2.piecePlaceEnum = VHPiecePlaceHAM_4;
    self.bmb2.buttonPlaceEnum = VHButtonPlaceHAM_4;
    self.bmb2.backgroundBlurred = YES;
    self.bmb2.blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    self.bmb2.tip = @"Nightonke BMB";
    for (int i = 0; i < [VHBoomMenuButton pieceNumber:self.bmb2.piecePlaceEnum]; i++)
    {
        [self.bmb2 addBuilder:[BuilderManager hamButtonBuilderWithDifferentPieceColor]];
    }
    
    self.bmb3.buttonEnum = VHButtonTextOutsideCircle;
    self.bmb3.piecePlaceEnum = VHPiecePlaceDOT_9_1;
    self.bmb3.buttonPlaceEnum = VHButtonPlaceSC_9_1;
    self.bmb3.backgroundBlurred = YES;
    self.bmb3.blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    self.bmb3.tip = @"Select an animal to feed!";
    self.bmb3.tipLabel.textColor = [UIColor darkGrayColor];
    self.bmb3.tipLabel.font = [UIFont systemFontOfSize:15];
    for (int i = 0; i < [VHBoomMenuButton pieceNumber:self.bmb3.piecePlaceEnum]; i++)
    {
        VHTextOutsideCircleButtonBuilder *builder = [BuilderManager textOutsideCircleButtonBuilder];
        builder.normalTextColor = [UIColor darkGrayColor];
        builder.highlightedTextColor = [UIColor lightGrayColor];
        [self.bmb3 addBuilder:builder];
    }
}

@end
