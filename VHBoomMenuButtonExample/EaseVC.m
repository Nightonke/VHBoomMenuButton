//
//  EaseVC.m
//  VHBoomMenuButton
//
//  Created by viktorhuang on 2017/4/14.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

#import "EaseVC.h"
#import "BuilderManager.h"
#import "VHBoomMenuButton.h"

@interface EaseVC ()

@property (weak, nonatomic) IBOutlet VHBoomMenuButton *bmb1;
@property (weak, nonatomic) IBOutlet VHBoomMenuButton *bmb2;
@property (weak, nonatomic) IBOutlet VHBoomMenuButton *bmb3;
@property (weak, nonatomic) IBOutlet VHBoomMenuButton *bmb4;
@property (weak, nonatomic) IBOutlet VHBoomMenuButton *bmb5;
@property (weak, nonatomic) IBOutlet VHBoomMenuButton *bmb6;
@property (weak, nonatomic) IBOutlet VHBoomMenuButton *bmb7;
@property (weak, nonatomic) IBOutlet VHBoomMenuButton *bmb8;
@property (weak, nonatomic) IBOutlet VHBoomMenuButton *bmb9;

@end

@implementation EaseVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initializeBMB:self.bmb1];
    [self initializeBMB:self.bmb2];
    [self initializeBMB:self.bmb3];
    [self initializeBMB:self.bmb4];
    [self initializeBMB:self.bmb5];
    [self initializeBMB:self.bmb6];
    [self initializeBMB:self.bmb7];
    [self initializeBMB:self.bmb8];
    [self initializeBMB:self.bmb9];
    
    self.bmb1.showDuration = 1;
    self.bmb1.hideDuration = 0.5;
    
    self.bmb2.showEaseName = VHEaseOutExpo;
    self.bmb2.hideEaseName = VHEaseInExpo;
    
    self.bmb3.showEaseName = VHEaseOutBounce;
    self.bmb3.hideEaseName = VHEaseOutBounce;
    
    self.bmb4.showEaseName = VHEaseOutElastic;
    self.bmb4.hideEaseName = VHEaseInElastic;
    self.bmb4.showDelay = 0;
    self.bmb4.hideDelay = 0;
    
    self.bmb5.showEaseName = VHEaseInSine;
    self.bmb5.hideEaseName = VHEaseInSine;
    
    self.bmb6.showEaseName = VHEaseInCirc;
    self.bmb6.hideEaseName = VHEaseInCirc;
    
    self.bmb7.showEaseName = VHEaseOutCirc;
    self.bmb7.hideEaseName = VHEaseOutCirc;
    
    self.bmb8.showMoveEaseName = VHEaseInBack;
    self.bmb8.showRotateEaseName = VHEaseInBack;
    self.bmb8.showScaleEaseName = VHEaseLinear;
    self.bmb8.hideMoveEaseName = VHEaseInBack;
    self.bmb8.hideRotateEaseName = VHEaseInBack;
    self.bmb8.hideScaleEaseName = VHEaseInBack;
    
    self.bmb9.showEaseName = VHEaseInOutQuad;
    self.bmb9.hideEaseName = VHEaseInOutQuad;
    self.bmb9.showDelay = 0;
    self.bmb9.hideDelay = 0;
}

- (void)initializeBMB:(VHBoomMenuButton *)bmb
{
    bmb.buttonEnum = VHButtonSimpleCircle;
    bmb.piecePlaceEnum = VHPiecePlace_DOT_9_1;
    bmb.buttonPlaceEnum = VHButtonPlace_SC_9_1;
    for (int i = 0; i < [VHBoomMenuButton pieceNumber:bmb.piecePlaceEnum]; i++)
    {
        [bmb addBuilder:[BuilderManager simpleCircleButtonBuilder]];
    }
}

@end
