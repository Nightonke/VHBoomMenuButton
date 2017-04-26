//
//  ButtonPlaceAlignmentVC.m
//  VHBoomMenuButton
//
//  Created by viktorhuang on 2017/4/14.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

#import "ButtonPlaceAlignmentVC.h"
#import "BuilderManager.h"
#import <BoomMenuButton/BoomMenuButton.h>

@interface ButtonPlaceAlignmentVC ()

@property (weak, nonatomic) IBOutlet VHBoomMenuButton *bmb;

@property (weak, nonatomic) IBOutlet UISlider *topMarginSlider;
@property (weak, nonatomic) IBOutlet UISlider *bottomMarginSlider;
@property (weak, nonatomic) IBOutlet UISlider *leftMarginSlider;
@property (weak, nonatomic) IBOutlet UISlider *rightMarginSlider;

@property (weak, nonatomic) IBOutlet UILabel *topMarginLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomMarginLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftMarginLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightMarginLabel;

@property (nonatomic, strong) NSArray<NSNumber *> *buttonPlaceAlignmentEnums;
@property (nonatomic, strong) NSArray<NSString *> *buttonPlaceAlignmentEnumNames;

@end

@implementation ButtonPlaceAlignmentVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.bmb.buttonEnum = VHButtonSimpleCircle;
    self.bmb.piecePlaceEnum = VHPiecePlaceDOT_4_1;
    self.bmb.buttonPlaceEnum = VHButtonPlaceSC_4_1;
    for (int i = 0; i < self.bmb.pieceNumber; i++)
    {
        [self.bmb addBuilder:[BuilderManager simpleCircleButtonBuilder]];
    }
    
    self.buttonPlaceAlignmentEnums = @[@(VHButtonPlaceAlignmentCenter),
                                       @(VHButtonPlaceAlignmentTop),
                                       @(VHButtonPlaceAlignmentBottom),
                                       @(VHButtonPlaceAlignmentLeft),
                                       @(VHButtonPlaceAlignmentRight),
                                       @(VHButtonPlaceAlignmentTL),
                                       @(VHButtonPlaceAlignmentTR),
                                       @(VHButtonPlaceAlignmentBL),
                                       @(VHButtonPlaceAlignmentBR)];
    
    self.buttonPlaceAlignmentEnumNames = @[@"Center",
                                           @"Top",
                                           @"Bottom",
                                           @"Left",
                                           @"Right",
                                           @"TL",
                                           @"TR",
                                           @"BL",
                                           @"BR"];
    
    [self onSliderValueChanged:self.topMarginSlider];
    [self onSliderValueChanged:self.bottomMarginSlider];
    [self onSliderValueChanged:self.leftMarginSlider];
    [self onSliderValueChanged:self.rightMarginSlider];
}

#pragma mark - Sliders

- (IBAction)onSliderValueChanged:(UISlider *)sender
{
    if (sender == self.topMarginSlider)
    {
        self.bmb.buttonTopMargin = self.topMarginSlider.value;
        self.topMarginLabel.text = [NSString stringWithFormat:@"Top margin = %.0lf point(s)", self.topMarginSlider.value];
    }
    else if (sender == self.bottomMarginSlider)
    {
        self.bmb.buttonBottomMargin = self.bottomMarginSlider.value;
        self.bottomMarginLabel.text = [NSString stringWithFormat:@"Bottom margin = %.0lf point(s)", self.bottomMarginSlider.value];
    }
    else if (sender == self.leftMarginSlider)
    {
        self.bmb.buttonLeftMargin = self.leftMarginSlider.value;
        self.leftMarginLabel.text = [NSString stringWithFormat:@"Left margin = %.0lf point(s)", self.leftMarginSlider.value];
    }
    else if (sender == self.rightMarginSlider)
    {
        self.bmb.buttonRightMargin = self.rightMarginSlider.value;
        self.rightMarginLabel.text = [NSString stringWithFormat:@"Right margin = %.0lf point(s)", self.rightMarginSlider.value];
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.bmb.buttonPlaceAlignmentEnum = [self.buttonPlaceAlignmentEnums objectAtIndex:indexPath.row].intValue;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.buttonPlaceAlignmentEnums.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ButtonPlaceAlignmentVCIdentifier = @"ButtonPlaceAlignmentVCIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ButtonPlaceAlignmentVCIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ButtonPlaceAlignmentVCIdentifier];
    }
    
    cell.textLabel.text = [self.buttonPlaceAlignmentEnumNames objectAtIndex:indexPath.row];
    return cell;
}

@end
