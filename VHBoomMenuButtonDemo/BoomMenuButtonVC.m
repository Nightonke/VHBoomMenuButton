//
//  BoomMenuButtonVC.m
//  VHBoomMenuButton
//
//  Created by viktorhuang on 2017/4/11.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

#import "BoomMenuButtonVC.h"
#import "VHUtils.h"
#import "VHBoomMenuButton.h"

@interface BoomMenuButtonVC ()<VHBoomDelegate>

@property (nonatomic, strong) UIWindow *overlapWindow;
@property (nonatomic, strong) UILabel *logo;
@property (nonatomic, strong) UIView *animateView;

@end

@implementation BoomMenuButtonVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UIApplication *app = [UIApplication sharedApplication];
    
    self.overlapWindow = [UIWindow new];
    self.overlapWindow.windowLevel = UIWindowLevelStatusBar + 1;
    self.overlapWindow.frame = CGRectMake(app.statusBarFrame.origin.x,
                                        app.statusBarFrame.origin.y,
                                        130,
                                        app.statusBarFrame.size.height);
    self.overlapWindow.hidden = NO;
    self.overlapWindow.backgroundColor = [VHUtils colorFromRGB:0x30a2fb];
    [self.overlapWindow makeKeyAndVisible];
    
    self.animateView = [UIView new];
    self.animateView.frame = self.overlapWindow.bounds;
    [self.overlapWindow addSubview:self.animateView];
    
    self.logo = [[UILabel alloc] initWithFrame:self.overlapWindow.bounds];
    self.logo.text = @"Nightonke BMB";
    self.logo.textColor = [UIColor whiteColor];
    self.logo.font = [UIFont fontWithName:@"HelveticaNeue-bold" size:12.0f];
    [self.logo sizeToFit];
    self.logo.frame = CGRectMake(8,
                             (20 - self.logo.frame.size.height) / 2,
                             self.logo.frame.size.width,
                             self.logo.frame.size.height);
    [self.overlapWindow addSubview:self.logo];
}

- (void)dimBMBLogoAnimation
{
    [UIView animateWithDuration:1.4 animations:^{
        self.animateView.backgroundColor = [VHUtils colorFromARGB:0x55000000];
    }];
}

- (void)lightBMBLogoAnimation
{
    [UIView animateWithDuration:1.4 animations:^{
        self.animateView.backgroundColor = [VHUtils colorFromARGB:0x00000000];
    }];
}

- (void)onBoomWillShow
{
    [self dimBMBLogoAnimation];
}

- (void)onBoomWillHide
{
    [self lightBMBLogoAnimation];
}

@end
