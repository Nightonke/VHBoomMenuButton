//
//  ViewController.m
//  VHBoomMenuExample
//
//  Created by 黄伟平 on 16/7/25.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import "ViewController.h"
#import "VHBoomMenuButton.h"
#import "VHUtils.h"

@interface ViewController ()

@property (nonatomic, strong) VHBoomMenuButton *bmb;
@property (nonatomic, strong) UILabel *label;

@end

@implementation ViewController

- (void)loadView
{
    CGRect screenFrame = [[UIScreen mainScreen] bounds];
    
    self.view = [[UIView alloc] initWithFrame:screenFrame];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    CGFloat bmbRadius = 60;
    
    self.bmb = [[VHBoomMenuButton alloc] initWithFrame:CGRectMake(screenFrame.size.width - 20 - bmbRadius, screenFrame.size.height - 20 - bmbRadius, bmbRadius, bmbRadius)];
    self.bmb.buttonEnum = VHSimpleCircle;
    self.bmb.piecePlaceEnum = DOT_2;
    self.bmb.buttonPlaceEnum = SC_2;
    [self.bmb addBuilderBlock:^(VHSimpleCircleButtonBuilder *builder) {
        builder.imageNormal = @"ios.png";
        builder.buttonNormalColor = UIColorFromRGB(0x90156b);
        builder.buttonPressedColor = UIColorFromRGB(0xda20a2);
        builder.imageNormalTintColor = UIColorFromRGB(0xff0000);
        builder.imagePressedTintColor = UIColorFromRGB(0xffffff);
    }];
    [self.bmb addBuilderBlock:^(VHSimpleCircleButtonBuilder *builder) {
        builder.imageNormal = @"android.png";
        builder.buttonNormalColor = UIColorFromRGB(0x90156b);
        builder.buttonPressedColor = UIColorFromRGB(0xda20a2);
    }];
    self.bmb.boomDelegate = self;
    [self.view addSubview:self.bmb];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 2)];
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.label];
}

- (void)onBoomClick:(int)index
{
    self.label.text = [NSString stringWithFormat:@"Boom %d was clicked!", index];
}

- (void)onBoomBackgroundClick
{
    self.label.text = [NSString stringWithFormat:@"Background was clicked!"];
}

@end
