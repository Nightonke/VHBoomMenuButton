//
//  TextInsideCircleButtonVC.m
//  VHBoomMenuButton
//
//  Created by viktorhuang on 2017/4/13.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

#import "TextInsideCircleButtonVC.h"
#import "BuilderManager.h"
#import "VHBoomMenuButton.h"

@interface TextInsideCircleButtonVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray<NSString *> *datas;
@property (nonatomic, strong) NSMutableArray<NSValue *> *piecesAndButtons;
@property (weak, nonatomic) IBOutlet VHBoomMenuButton *bmb;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TextInsideCircleButtonVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.bmb.buttonEnum = VHButtonTextInsideCircle;
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        VHTextInsideCircleButtonBuilder *builder = (VHTextInsideCircleButtonBuilder *)[self.bmb builder:0];
        builder.normalText = @"Changed!";
    });
    
    [self initializeDatas];
    [self tableView:self.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
}

- (void)initializeDatas
{
    self.datas = [NSMutableArray array];
    self.piecesAndButtons = [NSMutableArray array];
    [BuilderManager initializeDatasForTextInsideCircleButton:self.datas piecesAndButtons:self.piecesAndButtons];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.bmb.piecePlaceEnum = [[self.piecesAndButtons objectAtIndex:indexPath.row] CGPointValue].x;
    self.bmb.buttonPlaceEnum = [[self.piecesAndButtons objectAtIndex:indexPath.row] CGPointValue].y;
    [self.bmb clearBuilders];
    for (int i = 0; i < [VHBoomMenuButton pieceNumber:self.bmb.piecePlaceEnum]; i++)
    {
        [self.bmb addBuilder:[BuilderManager textInsideCircleButtonBuilder]];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *TextInsideCircleButtonVCIdentifier = @"TextInsideCircleButtonVCIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TextInsideCircleButtonVCIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TextInsideCircleButtonVCIdentifier];
    }
    
    cell.textLabel.text = [self.datas objectAtIndex:indexPath.row];
    return cell;
}

@end
