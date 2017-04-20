//
//  DraggableVC.m
//  VHBoomMenuButton
//
//  Created by viktorhuang on 2017/4/14.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

#import "DraggableVC.h"
#import "BuilderManager.h"
#import "VHBoomMenuButton.h"

@interface DraggableVC ()

@property (weak, nonatomic) IBOutlet VHBoomMenuButton *bmb;

@property (weak, nonatomic) IBOutlet UISwitch *draggableSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *backgroundEffectSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *shadowEffectSwitch;

@end

@implementation DraggableVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIEdgeInsets edgeInsets = self.bmb.edgeInsetsInSuperView;
    // Prevent the bmbs being dragged behind navigation bar.
    edgeInsets.top += 66;
    
    self.bmb.buttonEnum = VHButtonSimpleCircle;
    self.bmb.piecePlaceEnum = VHPiecePlace_DOT_9_1;
    self.bmb.buttonPlaceEnum = VHButtonPlace_SC_9_1;
    self.bmb.edgeInsetsInSuperView = edgeInsets;
    for (int i = 0; i < [VHBoomMenuButton pieceNumber:self.bmb.piecePlaceEnum]; i++)
    {
        [self.bmb addBuilder:[BuilderManager simpleCircleButtonBuilder]];
    }
}

- (IBAction)onSwitchValueChanged:(UISwitch *)sender
{
    if (sender == self.draggableSwitch)
    {
        self.bmb.draggable = sender.on;
    }
    else if (sender == self.backgroundEffectSwitch)
    {
        self.bmb.backgroundEffect = sender.on;
    }
    else if (sender == self.shadowEffectSwitch)
    {
        self.bmb.shadowEffect = sender.on;
    }
}

@end
