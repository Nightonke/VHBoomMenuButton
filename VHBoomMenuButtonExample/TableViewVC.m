//
//  TableViewVC.m
//  VHBoomMenuButton
//
//  Created by viktorhuang on 2017/4/18.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

#import "TableViewVC.h"
#import "BMBTableViewCell.h"
#import "BuilderManager.h"

@interface TableViewVC ()

@end

@implementation TableViewVC

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1000;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *TableViewVCIdentifier = @"TableViewVCIdentifier";
    BMBTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableViewVCIdentifier];
    
    cell.label.text = [NSString stringWithFormat:@"No.%zd", indexPath.row];
    
    cell.bmb1.buttonEnum = VHButtonSimpleCircle;
    cell.bmb1.piecePlaceEnum = VHPiecePlaceShare;
    cell.bmb1.buttonPlaceEnum = VHButtonPlace_SC_9_1;
    [cell.bmb1 clearBuilders];
    for (int i = 0; i < [VHBoomMenuButton buttonNumber:cell.bmb1.buttonPlaceEnum]; i++)
    {
        [cell.bmb1 addBuilder:[BuilderManager simpleCircleButtonBuilder]];
    }
    
    cell.bmb2.buttonEnum = VHButtonHam;
    cell.bmb2.piecePlaceEnum = VHPiecePlace_HAM_3;
    cell.bmb2.buttonPlaceEnum = VHButtonPlace_HAM_3;
    [cell.bmb2 clearBuilders];
    for (int i = 0; i < [VHBoomMenuButton pieceNumber:cell.bmb2.piecePlaceEnum]; i++)
    {
        [cell.bmb2 addBuilder:[BuilderManager hamButtonBuilder]];
    }
    
    cell.bmb3.buttonEnum = VHButtonSimpleCircle;
    cell.bmb3.piecePlaceEnum = VHPiecePlace_DOT_9_1;
    cell.bmb3.buttonPlaceEnum = VHButtonPlace_SC_9_1;
    [cell.bmb3 clearBuilders];
    for (int i = 0; i < [VHBoomMenuButton pieceNumber:cell.bmb3.piecePlaceEnum]; i++)
    {
        [cell.bmb3 addBuilder:[BuilderManager simpleCircleButtonBuilder]];
    }
    
    return cell;
}

@end
