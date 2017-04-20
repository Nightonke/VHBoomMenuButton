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
    self.bmb1.piecePlaceEnum = VHPiecePlace_DOT_9_1;
    self.bmb1.buttonPlaceEnum = VHButtonPlace_SC_9_1;
    self.bmb1.pieceCornerRadius = 1;
    for (int i = 0; i < [VHBoomMenuButton pieceNumber:self.bmb1.piecePlaceEnum]; i++)
    {
        [self.bmb1 addBuilder:[BuilderManager squaresSimpleCircleButtonBuilder]];
    }
    
    self.bmb2.buttonEnum = VHButtonTextInsideCircle;
    self.bmb2.piecePlaceEnum = VHPiecePlace_DOT_9_1;
    self.bmb2.buttonPlaceEnum = VHButtonPlace_SC_9_1;
    self.bmb2.pieceCornerRadius = 2;
    for (int i = 0; i < [VHBoomMenuButton pieceNumber:self.bmb2.piecePlaceEnum]; i++)
    {
        [self.bmb2 addBuilder:[BuilderManager squareTextInsideCircleButtonBuilder]];
    }
    
    self.bmb3.buttonEnum = VHButtonTextOutsideCircle;
    self.bmb3.piecePlaceEnum = VHPiecePlace_DOT_9_1;
    self.bmb3.buttonPlaceEnum = VHButtonPlace_SC_9_1;
    self.bmb3.pieceCornerRadius = 0;
    for (int i = 0; i < [VHBoomMenuButton pieceNumber:self.bmb3.piecePlaceEnum]; i++)
    {
        [self.bmb3 addBuilder:[BuilderManager squareTextOutsideCircleButtonBuilder]];
    }
    
    self.bmb4.buttonEnum = VHButtonHam;
    self.bmb4.piecePlaceEnum = VHPiecePlace_HAM_4;
    self.bmb4.buttonPlaceEnum = VHButtonPlace_HAM_4;
    self.bmb4.pieceCornerRadius = 1.5;
    for (int i = 0; i < [VHBoomMenuButton pieceNumber:self.bmb4.piecePlaceEnum]; i++)
    {
        [self.bmb4 addBuilder:[BuilderManager hamButtonBuilder]];
    }
}

@end
