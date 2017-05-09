//
//  VHErrorManager.h
//  VHBoomMenuButton
//
//  Created by Nightonke on 16/8/2.
//  Copyright © 2016 Nightonke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VHBoomMenuButton.h"

@class VHBoomMenuButton;

@interface VHErrorManager : NSObject

+ (void)judge:(VHBoomMenuButton *)bmb withBuilders:(NSMutableArray<VHBoomButtonBuilder *> *)builders;

@end
