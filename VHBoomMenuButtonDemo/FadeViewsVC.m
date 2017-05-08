//
//  FadeViewsVC.m
//  VHBoomMenuButtonDemo
//
//  Created by viktorhuang on 2017/5/7.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

#import "FadeViewsVC.h"
#import "BuilderManager.h"
#import <BoomMenuButton/BoomMenuButton.h>

@interface FadeViewsVC ()

@property (weak, nonatomic) IBOutlet VHBoomMenuButton *bmb1;
@property (weak, nonatomic) IBOutlet VHBoomMenuButton *bmb2;

@end

@implementation FadeViewsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initializeBmb1];
    [self initializeBmb2];
}

- (void)initializeBmb1
{
    self.bmb1.buttonEnum = VHButtonSimpleCircle;
    self.bmb1.piecePlaceEnum = VHPiecePlaceDOT_9_1;
    self.bmb1.buttonPlaceEnum = VHButtonPlaceSC_9_1;
    for (int i = 0; i < self.bmb1.pieceNumber; i++)
    {
        [self.bmb1 addBuilder:[BuilderManager simpleCircleButtonBuilder]];
    }
    self.bmb1.dotRadius = 0;
    self.bmb1.draggable = YES;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    imageView.image = [UIImage imageNamed:[BuilderManager imageName]];
    [self.bmb1 addFadeView:imageView];
}

- (void)initializeBmb2
{
    self.bmb2.buttonEnum = VHButtonHam;
    self.bmb2.piecePlaceEnum = VHPiecePlaceHAM_4;
    self.bmb2.buttonPlaceEnum = VHButtonPlaceHAM_4;
    for (int i = 0; i < self.bmb2.pieceNumber; i++)
    {
        [self.bmb2 addBuilder:[BuilderManager hamButtonBuilderWithDifferentPieceColor]];
    }
    self.bmb2.hamWidth = 0;
    self.bmb2.hamHeight = 0;
    self.bmb2.draggable = YES;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 40, 40)];
    imageView.image = [UIImage imageNamed:[BuilderManager imageName]];
    [self.bmb2 addFadeView:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 42, 40, 10)];
    label.font = [UIFont systemFontOfSize:8];
    label.text = @"BOOM!";
    label.textColor = UIColor.whiteColor;
    label.textAlignment = NSTextAlignmentCenter;
    [self.bmb2 addFadeView:label];
}

@end
