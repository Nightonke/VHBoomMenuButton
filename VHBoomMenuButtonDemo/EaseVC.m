//
//  EaseVC.m
//  VHBoomMenuButton
//
//  Created by Nightonke on 2017/4/14.
//  Copyright © 2017 Nightonke. All rights reserved.
//

#import "EaseVC.h"
#import "BuilderManager.h"
#import <BoomMenuButton/BoomMenuButton.h>

@interface CustomTimeInterpolator : NSObject<VHTimeInterpolator>

@end

@implementation CustomTimeInterpolator

- (CGFloat)interpolation:(CGFloat)offset
{
    return offset < 0.5 ? offset : MIN(offset * 1.5, 1);
}

@end

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
    
    self.bmb1.boomDuration = 1;
    self.bmb1.reboomDuration = 0.5;
    
    self.bmb2.boomEaseName = VHEaseOutExpo;
    self.bmb2.reboomEaseName = VHEaseInExpo;
    
    self.bmb3.boomEaseName = VHEaseOutBounce;
    self.bmb3.reboomEaseName = VHEaseOutBounce;
    
    self.bmb4.boomEaseName = VHEaseOutElastic;
    self.bmb4.reboomEaseName = VHEaseInElastic;
    self.bmb4.delay = 0;
    
    self.bmb5.boomEase = [CustomTimeInterpolator new];
    self.bmb5.reboomEase = [CustomTimeInterpolator new];
    self.bmb5.duration = 2;
    
    self.bmb6.boomEaseName = VHEaseInCirc;
    self.bmb6.reboomEaseName = VHEaseInCirc;
    
    self.bmb7.boomEaseName = VHEaseOutCirc;
    self.bmb7.reboomEaseName = VHEaseOutCirc;
    
    self.bmb8.boomMoveEaseName = VHEaseInBack;
    self.bmb8.boomRotateEaseName = VHEaseInBack;
    self.bmb8.boomScaleEaseName = VHEaseLinear;
    self.bmb8.reboomMoveEaseName = VHEaseInBack;
    self.bmb8.reboomRotateEaseName = VHEaseInBack;
    self.bmb8.reboomScaleEaseName = VHEaseInBack;
    
    self.bmb9.boomEaseName = VHEaseInOutQuad;
    self.bmb9.reboomEaseName = VHEaseInOutQuad;
    self.bmb9.delay = 0;
}

- (void)initializeBMB:(VHBoomMenuButton *)bmb
{
    bmb.buttonEnum = VHButtonSimpleCircle;
    bmb.piecePlaceEnum = VHPiecePlaceDOT_9_1;
    bmb.buttonPlaceEnum = VHButtonPlaceSC_9_1;
    for (int i = 0; i < bmb.pieceNumber; i++)
    {
        [bmb addBuilder:[BuilderManager simpleCircleButtonBuilder]];
    }
}

@end
