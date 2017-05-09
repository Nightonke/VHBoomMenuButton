//
//  ThreeDAnimationVC.m
//  VHBoomMenuButton
//
//  Created by Nightonke on 2017/4/19.
//  Copyright © 2017 Nightonke. All rights reserved.
//

#import "ThreeDAnimationVC.h"
#import "BuilderManager.h"
#import <BoomMenuButton/BoomMenuButton.h>

@interface ThreeDAnimationVC ()

@property (weak, nonatomic) IBOutlet VHBoomMenuButton *bmb1;
@property (weak, nonatomic) IBOutlet VHBoomMenuButton *bmb2;
@property (weak, nonatomic) IBOutlet VHBoomMenuButton *bmb3;

@property (weak, nonatomic) IBOutlet UISwitch *threeDAnimationSwitch;
@property (weak, nonatomic) IBOutlet UISlider *durationSlider;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;

@end

@implementation ThreeDAnimationVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIEdgeInsets edgeInsets = self.bmb1.edgeInsetsInSuperView;
    // Prevent the bmbs being dragged behind navigation bar.
    edgeInsets.top += 66;
    
    self.bmb1.buttonEnum = VHButtonSimpleCircle;
    self.bmb1.piecePlaceEnum = VHPiecePlaceDOT_9_1;
    self.bmb1.buttonPlaceEnum = VHButtonPlaceSC_9_1;
    self.bmb1.draggable = YES;
    self.bmb1.edgeInsetsInSuperView = edgeInsets;
    self.bmb1.pieceCornerRadius = 1;
    for (int i = 0; i < self.bmb1.pieceNumber; i++)
    {
        [self.bmb1 addBuilder:[BuilderManager squareSimpleCircleButtonBuilder]];
    }
    
    self.bmb2.buttonEnum = VHButtonHam;
    self.bmb2.piecePlaceEnum = VHPiecePlaceHAM_4;
    self.bmb2.buttonPlaceEnum = VHButtonPlaceHAM_4;
    self.bmb2.draggable = YES;
    self.bmb2.edgeInsetsInSuperView = edgeInsets;
    for (int i = 0; i < [VHBoomMenuButton pieceNumber:self.bmb2.piecePlaceEnum]; i++)
    {
        [self.bmb2 addBuilder:[BuilderManager hamButtonBuilderWithDifferentPieceColor]];
    }
    
    self.bmb3.buttonEnum = VHButtonTextOutsideCircle;
    self.bmb3.piecePlaceEnum = VHPiecePlaceDOT_9_1;
    self.bmb3.buttonPlaceEnum = VHButtonPlaceSC_9_1;
    self.bmb3.draggable = YES;
    self.bmb3.edgeInsetsInSuperView = edgeInsets;
    for (int i = 0; i < [VHBoomMenuButton pieceNumber:self.bmb3.piecePlaceEnum]; i++)
    {
        [self.bmb3 addBuilder:[BuilderManager textOutsideCircleButtonBuilder]];
    }
    
    [self onDurationSliderValueChanged:self.durationSlider];
}

- (IBAction)on3DAnimationSwitchValueChanged:(id)sender
{
    self.bmb1.use3DTransformAnimation = self.bmb2.use3DTransformAnimation = self.bmb3.use3DTransformAnimation = self.threeDAnimationSwitch.on;
}

- (IBAction)onDurationSliderValueChanged:(UISlider *)sender
{
    self.durationLabel.text = [NSString stringWithFormat:@"Show/Hide duration = %.0lf ms", sender.value];
    self.bmb1.duration = self.bmb2.duration = self.bmb3.duration = sender.value / 1000;
}

@end
