//
//  BoomVC.m
//  VHBoomMenuButton
//
//  Created by Nightonke on 2017/4/14.
//  Copyright © 2017 Nightonke. All rights reserved.
//

#import "BoomVC.h"
#import "BuilderManager.h"
#import <BoomMenuButton/BoomMenuButton.h>

@interface BoomVC ()

@property (nonatomic, strong) NSArray<NSNumber *> *boomEnums;
@property (nonatomic, strong) NSArray<NSString *> *boomEnumNames;
@property (weak, nonatomic) IBOutlet VHBoomMenuButton *bmb;

@end

@implementation BoomVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.bmb.buttonEnum = VHButtonSimpleCircle;
    self.bmb.piecePlaceEnum = VHPiecePlaceDOT_9_1;
    self.bmb.buttonPlaceEnum = VHButtonPlaceSC_9_1;
    self.bmb.duration = 2;
    for (int i = 0; i < self.bmb.pieceNumber; i++)
    {
        [self.bmb addBuilder:[BuilderManager simpleCircleButtonBuilder]];
    }
    
    self.boomEnums = @[@(VHBoomStraightLine),
                       @(VHBoomParabola1),
                       @(VHBoomParabola2),
                       @(VHBoomParabola3),
                       @(VHBoomParabola4),
                       @(VHBoomHorizontalThrow1),
                       @(VHBoomHorizontalThrow2),
                       @(VHBoomRandom)];
    
    self.boomEnumNames = @[@"StraightLine",
                           @"Parabola1",
                           @"Parabola2",
                           @"Parabola3",
                           @"Parabola4",
                           @"HorizontalThrow1",
                           @"HorizontalThrow2",
                           @"Random"];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.bmb.boomEnum = [self.boomEnums objectAtIndex:indexPath.row].intValue;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.boomEnums.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *BoomVCIdentifier = @"BoomVCIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BoomVCIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BoomVCIdentifier];
    }
    
    cell.textLabel.text = [self.boomEnumNames objectAtIndex:indexPath.row];
    return cell;
}

@end
