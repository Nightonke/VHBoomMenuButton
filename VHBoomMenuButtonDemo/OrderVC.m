//
//  OrderVC.m
//  VHBoomMenuButton
//
//  Created by viktorhuang on 2017/4/14.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

#import "OrderVC.h"
#import "BuilderManager.h"
#import <BoomMenuButton/BoomMenuButton.h>

@interface OrderVC ()

@property (nonatomic, strong) NSArray<NSNumber *> *orderEnums;
@property (nonatomic, strong) NSArray<NSString *> *orderEnumNames;
@property (weak, nonatomic) IBOutlet VHBoomMenuButton *bmb;

@end

@implementation OrderVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.bmb.buttonEnum = VHButtonSimpleCircle;
    self.bmb.piecePlaceEnum = VHPiecePlaceDOT_9_1;
    self.bmb.buttonPlaceEnum = VHButtonPlaceSC_9_1;
    for (int i = 0; i < self.bmb.pieceNumber; i++)
    {
        [self.bmb addBuilder:[BuilderManager simpleCircleButtonBuilder]];
    }
    
    self.orderEnums = @[@(VHOrderDefault),
                        @(VHOrderReverse),
                        @(VHOrderRandom)];
    
    self.orderEnumNames = @[@"Default",
                            @"Reverse",
                            @"Random"];
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.bmb.orderEnum = [self.orderEnums objectAtIndex:indexPath.row].intValue;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.orderEnums.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *OrderVCIdentifier = @"OrderVCIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderVCIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderVCIdentifier];
    }
    
    cell.textLabel.text = [self.orderEnumNames objectAtIndex:indexPath.row];
    return cell;
}

@end
