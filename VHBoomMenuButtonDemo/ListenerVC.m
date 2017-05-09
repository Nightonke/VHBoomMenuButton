//
//  ListenerVC.m
//  VHBoomMenuButton
//
//  Created by Nightonke on 2017/4/14.
//  Copyright © 2017 Nightonke. All rights reserved.
//

#import "ListenerVC.h"
#import "BuilderManager.h"
#import <BoomMenuButton/BoomMenuButton.h>

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
    
    VHSimpleCircleButtonBuilder *builder = [BuilderManager simpleCircleButtonBuilder];
    builder.clickedBlock = ^(int index) {
        weakSelf.buttonLabel.text = [NSString stringWithFormat:@"No.%d boom-button is clicked!", index];
    };
    [self.bmb addBuilder:builder];
}

#pragma mark - VHBoomDelegate

- (void)boomMenuButton:(VHBoomMenuButton *)bmb didClickBoomButtonOfBuilder:(VHBoomButtonBuilder *)builder at:(int)index
{
    // If you have implement clickedBlocks for boom-buttons in builders,
    // then you shouldn't add any listener here for duplicate callbacks.
    
    // self.buttonLabel.text = builder.normalImageName;
}

- (void)boomMenuButtonDidClickBackground:(VHBoomMenuButton *)bmb
{
    self.animationLabel.text = @"Click background!!!";
}

- (void)boomMenuButtonWillReboom:(VHBoomMenuButton *)bmb
{
    self.animationLabel.text = @"Will RE-BOOM!!!";
}

- (void)boomMenuButtonDidReboom:(VHBoomMenuButton *)bmb
{
    self.animationLabel.text = @"Did RE-BOOM!!!";
}

- (void)boomMenuButtonWillBoom:(VHBoomMenuButton *)bmb
{
    self.animationLabel.text = @"Will BOOM!!!";
}

- (void)boomMenuButtonDidBoom:(VHBoomMenuButton *)bmb
{
    self.animationLabel.text = @"Did BOOM!!!";
}

@end
