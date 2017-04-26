//
//  NavigationBarVC.m
//  VHBoomMenuButton
//
//  Created by viktorhuang on 2017/4/14.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

#import "NavigationBarVC.h"
#import "BuilderManager.h"
#import <BoomMenuButton/BoomMenuButton.h>

@interface NavigationBarVC ()

@end

@implementation NavigationBarVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    VHBoomMenuButton *bmb1 = [[VHBoomMenuButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    bmb1.buttonEnum = VHButtonTextOutsideCircle;
    bmb1.piecePlaceEnum = VHPiecePlaceDOT_9_1;
    bmb1.buttonPlaceEnum = VHButtonPlaceSC_9_1;
    bmb1.backgroundEffect = NO;
    bmb1.showDuration = 1;
    bmb1.hideDuration = 1;
    for (int i = 0; i < bmb1.pieceNumber; i++)
    {
        [bmb1 addBuilder:[BuilderManager textOutsideCircleButtonBuilderWithDifferentPieceColor]];
    }
    
    VHBoomMenuButton *bmb2 = [[VHBoomMenuButton alloc] initWithFrame:CGRectMake(44, 0, 44, 44)];
    bmb2.buttonEnum = VHButtonHam;
    bmb2.piecePlaceEnum = VHPiecePlaceHAM_4;
    bmb2.buttonPlaceEnum = VHButtonPlaceHAM_4;
    bmb2.backgroundEffect = NO;
    bmb2.showDuration = 1;
    bmb2.hideDuration = 1;
    bmb2.showEaseName = VHEaseOutCubic;
    bmb2.hideEaseName = VHEaseOutCubic;
    bmb2.boomEnum = VHBoomParabola_2;
    for (int i = 0; i < bmb2.pieceNumber; i++)
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
