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

- (void)onBoomButton:(VHBoomButton *)boomButton clickedAt:(int)index
{
    VHHamButtonBuilder *builder = (VHHamButtonBuilder *)[self.bmb builder:index];
    switch (index)
    {
        case 0:
            builder.normalText = @"Changed!";
            builder.highlightedText = @"Highlighted, changed!";
            builder.normalSubText = @"Sub-text, changed!";
            builder.normalTextColor = [UIColor yellowColor];
            builder.highlightedColor = [UIColor purpleColor];
            builder.normalSubTextColor = [UIColor blackColor];
            break;
        case 1:
            builder.normalImageName = @"bat";
            builder.highlightedImageName = @"bear";
            break;
        case 2:
            builder.normalColor = [UIColor redColor];
            break;
        case 3:
            builder.pieceColor = [UIColor whiteColor];
            break;
        case 4:
            builder.unable = YES;
            break;
        default:
            break;
    }
}

@end
