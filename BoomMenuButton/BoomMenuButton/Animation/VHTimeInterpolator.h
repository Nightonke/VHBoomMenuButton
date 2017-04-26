//
//  VHTimeInterpolator.h
//  VHBoomMenuButton
//
//  Created by viktorhuang on 2017/4/9.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol VHTimeInterpolator <NSObject>

@required
- (CGFloat)interpolation:(CGFloat)offset;

@end
