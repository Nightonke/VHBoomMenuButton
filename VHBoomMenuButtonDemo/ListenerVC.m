//
//  ListenerVC.m
//  VHBoomMenuButton
//
//  Created by viktorhuang on 2017/4/14.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

#import "ListenerVC.h"
#import "BuilderManager.h"
#import "VHBoomMenuButton.h"

@interface ListenerVC ()<VHBoomDelegate>

@property (weak, nonatomic) IBOutlet UILabel *buttonLabel;
@property (weak, nonatomic) IBOutlet UILabel *animationLabel;

@property (weak, nonatomic) IBOutlet VHBoomMenuButton *bmb;

@end

@implementation ListenerVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.bmb.buttonEnum = VHButtonSimpleCircle;
    self.bmb.piecePlaceEnum = VHPiecePlaceDOT_6_3;
    self.bmb.buttonPlaceEnum = VHButtonPlaceSC_6_3;
    self.bmb.boomDelegate = self;
    for (int i = 0; i < self.bmb.pieceNumber; i++)
    {
        [self addBuilder];
    }
}

- (void)addBuilder
{
    __weak ListenerVC *weakSelf = self;
    VHSimpleCircleButtonBuilder *builder = [VHSimpleCircleButtonBuilder builder];
    builder.normalImageName = [BuilderManager imageName];
    builder.clickedBlock = ^(int index) {
        weakSelf.buttonLabel.text = [NSString stringWithFormat:@"No.%d boom-button is clicked!", index];
    };
    [self.bmb addBuilder:builder];
}

#pragma mark - VHBoomDelegate

- (void)onBoomButton:(VHBoomButton *)boomButton clickedAt:(int)index
{
    // If you have implement clickedBlocks for boom-buttons in builders,
    // then you shouldn't add any listener here for duplicate callbacks.
}

- (void)onBoomBackgroundClicked
{
    self.animationLabel.text = @"Click background!!!";
}

- (void)onBoomWillHide
{
    self.animationLabel.text = @"Will RE-BOOM!!!";
}

- (void)onBoomDidHide
{
    self.animationLabel.text = @"Did RE-BOOM!!!";
}

- (void)onBoomWillShow
{
    self.animationLabel.text = @"Will BOOM!!!";
}

- (void)onBoomDidShow
{
    self.animationLabel.text = @"Did BOOM!!!";
}

@end
