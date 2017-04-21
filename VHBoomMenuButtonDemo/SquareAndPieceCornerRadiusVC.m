//
//  SquareAndPieceCornerRadiusVC.m
//  VHBoomMenuButton
//
//  Created by viktorhuang on 2017/4/14.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

#import "SquareAndPieceCornerRadiusVC.h"
#import "BuilderManager.h"
#import "VHBoomMenuButton.h"

@interface SquareAndPieceCornerRadiusVC ()

@property (weak, nonatomic) IBOutlet VHBoomMenuButton *bmb1;
@property (weak, nonatomic) IBOutlet VHBoomMenuButton *bmb2;
@property (weak, nonatomic) IBOutlet VHBoomMenuButton *bmb3;
@property (weak, nonatomic) IBOutlet VHBoomMenuButton *bmb4;

@end

@implementation SquareAndPieceCornerRadiusVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.bmb1.buttonEnum = VHButtonSimpleCircle;
    self.bmb1.piecePlaceEnum = VHPiecePlaceDOT_9_1;
    self.bmb1.buttonPlaceEnum = VHButtonPlaceSC_9_1;
    self.bmb1.pieceCornerRadius = 1;
    for (int i = 0; i < self.bmb1.pieceNumber; i++)
    {
        [self.bmb1 addBuilder:[BuilderManager squaresSimpleCircleButtonBuilder]];
    }
    
    self.bmb2.buttonEnum = VHButtonTextInsideCircle;
    self.bmb2.piecePlaceEnum = VHPiecePlaceDOT_9_1;
    self.bmb2.buttonPlaceEnum = VHButtonPlaceSC_9_1;
    self.bmb2.pieceCornerRadius = 2;
    for (int i = 0; i < self.bmb2.pieceNumber; i++)
    {
        [self.bmb2 addBuilder:[BuilderManager squareTextInsideCircleButtonBuilder]];
    }
    
    self.bmb3.buttonEnum = VHButtonTextOutsideCircle;
    self.bmb3.piecePlaceEnum = VHPiecePlaceDOT_9_1;
    self.bmb3.buttonPlaceEnum = VHButtonPlaceSC_9_1;
    self.bmb3.pieceCornerRadius = 0;
    for (int i = 0; i < self.bmb3.pieceNumber; i++)
    {
        [self.bmb3 addBuilder:[BuilderManager squareTextOutsideCircleButtonBuilder]];
    }
    
    self.bmb4.buttonEnum = VHButtonHam;
    self.bmb4.piecePlaceEnum = VHPiecePlaceHAM_4;
    self.bmb4.buttonPlaceEnum = VHButtonPlaceHAM_4;
    self.bmb4.pieceCornerRadius = 1.5;
    for (int i = 0; i < self.bmb4.pieceNumber; i++)
    {
        [self.bmb4 addBuilder:[BuilderManager hamButtonBuilder]];
    }
}

@end
