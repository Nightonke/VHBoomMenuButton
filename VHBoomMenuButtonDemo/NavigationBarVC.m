//
//  NavigationBarVC.m
//  VHBoomMenuButton
//
//  Created by viktorhuang on 2017/4/14.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

#import "NavigationBarVC.h"
#import "BuilderManager.h"
#import "VHBoomMenuButton.h"

@interface NavigationBarVC ()

@end

@implementation NavigationBarVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    VHBoomMenuButton *bmb1 = [[VHBoomMenuButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    bmb1.buttonEnum = VHButtonTextOutsideCircle;
    bmb1.piecePlaceEnum = VHPiecePlace_DOT_9_1;
    bmb1.buttonPlaceEnum = VHButtonPlace_SC_9_1;
    bmb1.backgroundEffect = NO;
    bmb1.showDuration = 1;
    bmb1.hideDuration = 1;
    for (int i = 0; i < [VHBoomMenuButton pieceNumber:bmb1.piecePlaceEnum]; i++)
    {
        [bmb1 addBuilder:[BuilderManager textOutsideCircleButtonBuilderWithDifferentPieceColor]];
    }
    
    VHBoomMenuButton *bmb2 = [[VHBoomMenuButton alloc] initWithFrame:CGRectMake(44, 0, 44, 44)];
    bmb2.buttonEnum = VHButtonHam;
    bmb2.piecePlaceEnum = VHPiecePlace_HAM_4;
    bmb2.buttonPlaceEnum = VHButtonPlace_HAM_4;
    bmb2.backgroundEffect = NO;
    bmb2.showDuration = 1;
    bmb2.hideDuration = 1;
    bmb2.boomEnum = VHBoomParabola_2;
    for (int i = 0; i < [VHBoomMenuButton pieceNumber:bmb2.piecePlaceEnum]; i++)
    {
        [bmb2 addBuilder:[BuilderManager hamButtonBuilderWithDifferentPieceColor]];
    }
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [negativeSpacer setWidth:-16];
    
    UIView *bmbs = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 88, 44)];
    [bmbs addSubview:bmb1];
    [bmbs addSubview:bmb2];
    
    self.navigationItem.rightBarButtonItems = @[negativeSpacer,
                                                [[UIBarButtonItem alloc] initWithCustomView:bmbs]];
}

@end
