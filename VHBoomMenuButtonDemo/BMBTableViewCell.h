//
//  BMBTableViewCell.h
//  VHBoomMenuButton
//
//  Created by viktorhuang on 2017/4/18.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BoomMenuButton/BoomMenuButton.h>

@interface BMBTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet VHBoomMenuButton *bmb1;
@property (weak, nonatomic) IBOutlet VHBoomMenuButton *bmb2;
@property (weak, nonatomic) IBOutlet VHBoomMenuButton *bmb3;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end
