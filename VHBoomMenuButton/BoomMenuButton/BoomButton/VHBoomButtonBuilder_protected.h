//
//  VHBoomButtonBuilder_protected.h
//  VHBoomMenuButton
//
//  Created by Nightonke on 2017/4/12.
//  Copyright © 2017 Nightonke. All rights reserved.
//

#ifndef VHBoomButtonBuilder_protected_h
#define VHBoomButtonBuilder_protected_h

#import "VHBoomPiece.h"
#import "VHBoomButton.h"

@interface VHBoomButtonBuilder ()

#pragma mark - Piece

@property (nonatomic, weak) VHBoomPiece *piece;

#pragma mark - Button

@property (nonatomic, weak) VHBoomButton *button;

@end

#endif /* VHBoomButtonBuilder_protected_h */
