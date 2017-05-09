//
//  BoomMenuButtonVC.m
//  VHBoomMenuButton
//
//  Created by Nightonke on 2017/4/11.
//  Copyright © 2017 Nightonke. All rights reserved.
//

#import "BoomMenuButtonVC.h"
#import <BoomMenuButton/BoomMenuButton.h>

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
    self.overlapWindow.backgroundColor = [self colorFromRGB:0x30a2fb];
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

- (void)dimBMBLogoAnimation:(CFTimeInterval)duration
{
    [UIView animateWithDuration:duration animations:^{
        self.animateView.backgroundColor = [self colorFromARGB:0x55000000];
    }];
}

- (void)lightBMBLogoAnimation:(CFTimeInterval)duration
{
    [UIView animateWithDuration:duration animations:^{
        self.animateView.backgroundColor = [self colorFromARGB:0x00000000];
    }];
}

- (void)boomMenuButtonWillBoom:(VHBoomMenuButton *)bmb
{
    [self dimBMBLogoAnimation:bmb.boomDuration + bmb.boomDelay * (bmb.pieceNumber - 1)];
}

- (void)boomMenuButtonWillReboom:(VHBoomMenuButton *)bmb
{
    [self lightBMBLogoAnimation:bmb.reboomDuration + bmb.reboomDelay * (bmb.pieceNumber - 1)];
}

- (UIColor *)colorFromARGB:(int)color
{
    return [UIColor colorWithRed:((float)((color & 0x00FF0000) >> 16)) / 255.0 green:((float)((color & 0x0000FF00) >> 8)) / 255.0 blue:((float)(color & 0x000000FF)) / 255.0 alpha:((float)((color & 0xFF000000) >> 24)) / 255.0];
}

- (UIColor *)colorFromRGB:(int)color
{
    return [UIColor colorWithRed:((float)((color & 0xFF0000) >> 16)) / 255.0 green:((float)((color & 0xFF00) >> 8)) / 255.0 blue:((float)(color & 0xFF)) / 255.0 alpha:1.0];
}

@end
