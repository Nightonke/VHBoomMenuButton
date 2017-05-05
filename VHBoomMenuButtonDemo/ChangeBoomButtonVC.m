//
//  ChangeBoomButtonVC.m
//  VHBoomMenuButton
//
//  Created by viktorhuang on 2017/4/18.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

#import "ChangeBoomButtonVC.h"
#import "BuilderManager.h"
#import <BoomMenuButton/BoomMenuButton.h>

@interface ChangeBoomButtonVC ()<VHBoomDelegate>

@property (weak, nonatomic) IBOutlet VHBoomMenuButton *bmb;

@end

@implementation ChangeBoomButtonVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.bmb.buttonEnum = VHButtonHam;
    self.bmb.piecePlaceEnum = VHPiecePlaceHAM_5;
    self.bmb.buttonPlaceEnum = VHButtonPlaceHAM_5;
    self.bmb.boomDelegate = self;
    self.bmb.autoHide = NO;
    
    VHHamButtonBuilder *builder;
    
    [self.bmb addBuilder:[BuilderManager hamButtonBuilderWithText:@"Change Text" withSubText:@"..."]];
    
    builder = [BuilderManager hamButtonBuilderWithText:@"Change Image" withSubText:@"..."];
    builder.normalImageName = @"eagle";
    [self.bmb addBuilder:builder];
    
    builder = [BuilderManager hamButtonBuilderWithText:@"Change Color" withSubText:@"..."];
    builder.normalColor = [UIColor blueColor];
    [self.bmb addBuilder:builder];
    
    [self.bmb addBuilder:[BuilderManager hamButtonBuilderWithText:@"Change Piece Color" withSubText:@"..."]];
    
    builder = [BuilderManager hamButtonBuilderWithText:@"Change Unable" withSubText:@"..."];
    builder.unableColor = [UIColor grayColor];
    builder.unableImageName = @"butterfly";
    builder.unableText = @"Unable!";
    [self.bmb addBuilder:builder];
}

#pragma mark - VHBoomDelegate

- (void)boomMenuButton:(VHBoomMenuButton *)bmb didClickBoomButtonOfBuilder:(VHBoomButtonBuilder *)builder at:(int)index
{
    VHHamButtonBuilder *hamBuilder = (VHHamButtonBuilder *)[self.bmb builder:index];
    switch (index)
    {
        case 0:
            hamBuilder.normalText = @"Changed!";
            hamBuilder.highlightedText = @"Highlighted, changed!";
            hamBuilder.normalSubText = @"Sub-text, changed!";
            hamBuilder.normalTextColor = [UIColor yellowColor];
            hamBuilder.highlightedColor = [UIColor purpleColor];
            hamBuilder.normalSubTextColor = [UIColor blackColor];
            break;
        case 1:
            hamBuilder.normalImageName = @"bat";
            hamBuilder.highlightedImageName = @"bear";
            break;
        case 2:
            hamBuilder.normalColor = [UIColor redColor];
            break;
        case 3:
            hamBuilder.pieceColor = [UIColor whiteColor];
            break;
        case 4:
            hamBuilder.unable = YES;
            break;
        default:
            break;
    }
}

@end
