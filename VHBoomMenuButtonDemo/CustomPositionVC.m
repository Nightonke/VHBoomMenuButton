//
//  CustomPositionVC.m
//  VHBoomMenuButtonDemo
//
//  Created by Nightonke on 2017/5/7.
//  Copyright © 2017 Nightonke. All rights reserved.
//

#import "CustomPositionVC.h"
#import "BuilderManager.h"
#import <BoomMenuButton/BoomMenuButton.h>

@interface CustomPositionVC ()

@property (weak, nonatomic) IBOutlet VHBoomMenuButton *bmb1;
@property (weak, nonatomic) IBOutlet VHBoomMenuButton *bmb2;
@property (weak, nonatomic) IBOutlet VHBoomMenuButton *bmb3;
@property (weak, nonatomic) IBOutlet VHBoomMenuButton *bmb4;

@end

@implementation CustomPositionVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initializeBmb1];
    [self initializeBmb2];
    [self initializeBmb3];
    [self initializeBmb4];
}

- (void)initializeBmb1
{
    self.bmb1.buttonEnum = VHButtonHam;
    self.bmb1.piecePlaceEnum = VHPiecePlaceCustom;
    self.bmb1.hamWidth = 10;
    self.bmb1.buttonPlaceEnum = VHButtonPlaceHAM_4;
    for (int i = 0; i < self.bmb1.buttonNumber; i++)
    {
        [self.bmb1 addBuilder:[BuilderManager hamButtonBuilder]];
    }
    
    CGFloat w_0_5 = self.bmb1.hamWidth / 2;
    CGFloat h_0_5 = self.bmb1.hamHeight / 2;
    
    CGFloat hm_0_5 = self.bmb1.pieceHorizontalMargin / 2;
    CGFloat vm_0_5 = self.bmb1.pieceVerticalMargin / 2;
    
    [self.bmb1.customPiecePositions addObject:[NSValue valueWithCGPoint:CGPointMake(-w_0_5 - hm_0_5, -h_0_5 - vm_0_5)]];
    [self.bmb1.customPiecePositions addObject:[NSValue valueWithCGPoint:CGPointMake(+w_0_5 + hm_0_5, -h_0_5 - vm_0_5)]];
    [self.bmb1.customPiecePositions addObject:[NSValue valueWithCGPoint:CGPointMake(-w_0_5 - hm_0_5, +h_0_5 + vm_0_5)]];
    [self.bmb1.customPiecePositions addObject:[NSValue valueWithCGPoint:CGPointMake(+w_0_5 + hm_0_5, +h_0_5 + vm_0_5)]];
}

- (void)initializeBmb2
{
    self.bmb2.buttonEnum = VHButtonSimpleCircle;
    self.bmb2.piecePlaceEnum = VHPiecePlaceDOT_3_1;
    self.bmb2.buttonPlaceEnum = VHButtonPlaceCustom;
    for (int i = 0; i < self.bmb2.pieceNumber; i++)
    {
        [self.bmb2 addBuilder:[BuilderManager simpleCircleButtonBuilder]];
    }
    
    [self.bmb2.customButtonPositions addObject:[NSValue valueWithCGPoint:CGPointMake(-60, -60)]];
    [self.bmb2.customButtonPositions addObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)]];
    [self.bmb2.customButtonPositions addObject:[NSValue valueWithCGPoint:CGPointMake(+60, +60)]];
}

- (void)initializeBmb3
{
    self.bmb3.buttonEnum = VHButtonTextOutsideCircle;
    self.bmb3.piecePlaceEnum = VHPiecePlaceShare;
    self.bmb3.buttonPlaceEnum = VHButtonPlaceCustom;
    for (int i = 0; i < 12; i++)
    {
        [self.bmb3 addBuilder:[BuilderManager textOutsideCircleButtonBuilderWithDifferentPieceColor]];
    }
    
    CGFloat w = 80;
    CGFloat h = 96;
    CGFloat h_0_5 = h / 2;
    CGFloat h_1_5 = h * 1.5;
    
    CGFloat hm = self.bmb3.buttonHorizontalMargin;
    CGFloat vm = self.bmb3.buttonVerticalMargin;
    CGFloat vm_0_5 = vm / 2;
    CGFloat vm_1_5 = vm * 1.5;
    
    [self.bmb3.customButtonPositions addObject:[NSValue valueWithCGPoint:CGPointMake(-w - hm, -h_1_5 - vm_1_5)]];
    [self.bmb3.customButtonPositions addObject:[NSValue valueWithCGPoint:CGPointMake(      0, -h_1_5 - vm_1_5)]];
    [self.bmb3.customButtonPositions addObject:[NSValue valueWithCGPoint:CGPointMake(+w + hm, -h_1_5 - vm_1_5)]];
    [self.bmb3.customButtonPositions addObject:[NSValue valueWithCGPoint:CGPointMake(-w - hm, -h_0_5 - vm_0_5)]];
    [self.bmb3.customButtonPositions addObject:[NSValue valueWithCGPoint:CGPointMake(      0, -h_0_5 - vm_0_5)]];
    [self.bmb3.customButtonPositions addObject:[NSValue valueWithCGPoint:CGPointMake(+w + hm, -h_0_5 - vm_0_5)]];
    [self.bmb3.customButtonPositions addObject:[NSValue valueWithCGPoint:CGPointMake(-w - hm, +h_0_5 + vm_0_5)]];
    [self.bmb3.customButtonPositions addObject:[NSValue valueWithCGPoint:CGPointMake(      0, +h_0_5 + vm_0_5)]];
    [self.bmb3.customButtonPositions addObject:[NSValue valueWithCGPoint:CGPointMake(+w + hm, +h_0_5 + vm_0_5)]];
    [self.bmb3.customButtonPositions addObject:[NSValue valueWithCGPoint:CGPointMake(-w - hm, +h_1_5 + vm_1_5)]];
    [self.bmb3.customButtonPositions addObject:[NSValue valueWithCGPoint:CGPointMake(      0, +h_1_5 + vm_1_5)]];
    [self.bmb3.customButtonPositions addObject:[NSValue valueWithCGPoint:CGPointMake(+w + hm, +h_1_5 + vm_1_5)]];
}

- (void)initializeBmb4
{
    self.bmb4.buttonEnum = VHButtonTextInsideCircle;
    self.bmb4.piecePlaceEnum = VHPiecePlaceCustom;
    self.bmb4.buttonPlaceEnum = VHButtonPlaceCustom;
    for (int i = 0; i < 3; i++)
    {
        [self.bmb4 addBuilder:[BuilderManager textInsideCircleButtonBuilder]];
    }
    
    [self.bmb4.customPiecePositions addObject:[NSValue valueWithCGPoint:CGPointMake(+6, -6)]];
    [self.bmb4.customPiecePositions addObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)]];
    [self.bmb4.customPiecePositions addObject:[NSValue valueWithCGPoint:CGPointMake(-6, +6)]];
    
    [self.bmb4.customButtonPositions addObject:[NSValue valueWithCGPoint:CGPointMake(-60, -60)]];
    [self.bmb4.customButtonPositions addObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)]];
    [self.bmb4.customButtonPositions addObject:[NSValue valueWithCGPoint:CGPointMake(+60, +60)]];
}

@end
