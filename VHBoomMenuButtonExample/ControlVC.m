//
//  ControlVC.m
//  VHBoomMenuButton
//
//  Created by viktorhuang on 2017/4/14.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

#import "ControlVC.h"
#import "BuilderManager.h"
#import "VHBoomMenuButton.h"

@interface ControlVC ()

@property (weak, nonatomic) IBOutlet UIButton *boomButton;
@property (weak, nonatomic) IBOutlet UIButton *reboomButton;
@property (weak, nonatomic) IBOutlet UIButton *boomImmediatelyButton;
@property (weak, nonatomic) IBOutlet UIButton *reboomImmediatelyButton;

@property (weak, nonatomic) IBOutlet VHBoomMenuButton *bmb;

@end

@implementation ControlVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.bmb.buttonEnum = VHButtonSimpleCircle;
    self.bmb.piecePlaceEnum = VHPiecePlace_DOT_9_1;
    self.bmb.buttonPlaceEnum = VHButtonPlace_SC_9_1;
    self.bmb.boomInWholeScreen = NO;
    for (int i = 0; i < [VHBoomMenuButton pieceNumber:self.bmb.piecePlaceEnum]; i++)
    {
        [self.bmb addBuilder:[BuilderManager simpleCircleButtonBuilder]];
    }
}

- (IBAction)onButtonClicked:(UIButton *)sender
{
    if (sender == self.boomButton)
    {
        [self.bmb boom];
    }
    else if (sender == self.reboomButton)
    {
        [self.bmb reboom];
    }
    else if (sender == self.boomImmediatelyButton)
    {
        [self.bmb boomImmediately];
    }
    else if (sender == self.reboomImmediatelyButton)
    {
        [self.bmb reboomImmediately];
    }
}

@end
