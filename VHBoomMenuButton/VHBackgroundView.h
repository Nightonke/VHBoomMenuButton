//
//  VHBackgroundView.h
//  VHBoomMenuExample
//
//  Created by Nightonke on 16/7/31.
//  Copyright © 2016年 Nightonke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VHBackgroundClickDelegate.h"

@interface VHBackgroundView : UIView

@property (nonatomic, strong) UIColor * _Nonnull dimColor;
@property (nonatomic, assign) BOOL blurBackground;
@property (nonatomic, strong) UIBlurEffect * _Nullable blurEffect NS_AVAILABLE_IOS(8_0);
@property (nonatomic, strong) NSString * _Nullable tip;
@property (nonatomic, weak) id<VHBackgroundClickDelegate> _Nullable delegate;

- (void)dim:(CFTimeInterval)duration
 completion:(void (^ __nullable)(BOOL finished))completion;

- (void)light:(CFTimeInterval)duration
   completion:(void (^ __nullable)(BOOL finished))completion;

- (void)removeAllSubViews;

@end
