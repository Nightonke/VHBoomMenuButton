//
//  VHTimeInterpolator.h
//  VHBoomMenuButton
//
//  Created by Nightonke on 2017/4/9.
//  Copyright © 2017 Nightonke. All rights reserved.
//

@protocol VHTimeInterpolator <NSObject>

@required
- (CGFloat)interpolation:(CGFloat)offset;

@end
