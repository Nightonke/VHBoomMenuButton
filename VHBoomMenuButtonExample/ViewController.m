//
//  ViewController.m
//  VHBoomMenuExample
//
//  Created by 黄伟平 on 16/7/25.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import "ViewController.h"
#import "TopLineLabel.h"
#import "BottomLineLabel.h"

#import "VHBoomMenuButton.h"
#import "VHUtils.h"
#import "VHPiecePlaceEnum.h"
#import "VHButtonPlaceEnum.h"
#import "VHButtonPlaceAlignmentEnum.h"
#import "VHPiecePlaceManager.h"
#import "VHBoomEnum.h"

@interface ViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) BottomLineLabel *warningLabel;
@property (nonatomic, strong) UILabel *buttonTypeLabel;
@property (nonatomic, strong) UISegmentedControl *buttonTypeSegmentedControl;
@property (nonatomic, strong) UILabel *placeTipLabel;
@property (nonatomic, strong) UIPickerView *placePickerView;
@property (nonatomic, strong) TopLineLabel *boomAndAlignmentTipLabel;
@property (nonatomic, strong) UIPickerView *boomAndAlignmentPickerView;
@property (nonatomic, strong) TopLineLabel *autoHideLabel;
@property (nonatomic, strong) UISwitch *autoHideSwitch;
@property (nonatomic, strong) TopLineLabel *cancelableLabel;
@property (nonatomic, strong) UISwitch *cancelableSwitch;
@property (nonatomic, strong) TopLineLabel *noBackgroundLabel;
@property (nonatomic, strong) UISwitch *noBackgroundSwitch;
@property (nonatomic, strong) TopLineLabel *draggableLabel;
@property (nonatomic, strong) UISwitch *draggableSwitch;
@property (nonatomic, strong) TopLineLabel *durationLabel;
@property (nonatomic, strong) UISlider *durationSlider;
@property (nonatomic, strong) TopLineLabel *delayLabel;
@property (nonatomic, strong) UISlider *delaySlider;
@property (nonatomic, strong) TopLineLabel *degreeLabel;
@property (nonatomic, strong) UISlider *degreeSlider;

@property (nonatomic, strong) VHBoomMenuButton *bmb;

@property (nonatomic, strong) NSArray<NSString *> *images;
@property (nonatomic, strong) NSArray<UIColor *> *buttonNormalColors;
@property (nonatomic, strong) NSArray<UIColor *> *buttonPressedColors;
@property (nonatomic, strong) NSArray<UIColor *> *imageNormalTintColors;
@property (nonatomic, strong) NSArray<UIColor *> *imagePressedTintColors;

@property (nonatomic, strong) NSArray<NSString *> *piecePlaceTypesName;
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSArray<NSString *> *> *buttonPlaceTypesName;
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSArray<NSNumber *> *> *buttonPlaceTypesValue;
@property (nonatomic, strong) NSArray<NSString *> *buttonToPiecePlaceTypesName;
@property (nonatomic, strong) NSArray<NSNumber *> *buttonToPiecePlaceTypesValue;

@property (nonatomic, assign) VHButtonEnum selectedButtonEnum;
@property (nonatomic, assign) VHPiecePlaceEnum selectedPiecePlaceEnum;
@property (nonatomic, assign) VHButtonPlaceEnum selectedButtonPlaceEnum;

@property (nonatomic, strong) NSArray<NSString *> *boomTypesName;
@property (nonatomic, strong) NSArray<NSString *> *buttonAlignmentTypesName;
@property (nonatomic, assign) VHBoomEnum selectedBoomEnum;
@property (nonatomic, assign) VHButtonPlaceAlignmentEnum selectedButtonPlaceAlignmentEnum;

@end

@implementation ViewController

- (void)loadView
{
    [self initTestValues];
    
    CGRect screenFrame         = [[UIScreen mainScreen] bounds];
    self.view                  = [[UIView alloc] initWithFrame:screenFrame];
    self.view.backgroundColor  = UIColorFromRGB(0x2699ea);
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    // Scroll view
    self.scrollView                 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 80, screenFrame.size.width, screenFrame.size.height - 80)];
    self.scrollView.contentSize     = CGSizeMake(screenFrame.size.width, screenFrame.size.height * 2);
    self.scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    
    // Current status of BMB
    self.statusLabel                 = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 60)];
    self.statusLabel.textAlignment   = NSTextAlignmentCenter;
    self.statusLabel.lineBreakMode   = NSLineBreakByWordWrapping;
    self.statusLabel.numberOfLines   = 0;
    self.statusLabel.text            = @"Click the BMB to make it BOOM!";
    self.statusLabel.backgroundColor = UIColorFromRGB(0x2699ea);
    self.statusLabel.textColor       = [UIColor whiteColor];
    [self.view addSubview:self.statusLabel];
    
    // Warning label
    self.warningLabel               = [[BottomLineLabel alloc] initWithFrame:CGRectMake(20,
                                                                          0,
                                                                          screenFrame.size.width - 40,
                                                                          40)];
    self.warningLabel.textAlignment = NSTextAlignmentCenter;
    self.warningLabel.text          = @"Warning! You cannot change BMB's properties when the sub-buttons are showing. In this example, if you click the BMB when the picker views are still scrolling, the app will crash surely!";
    self.warningLabel.textColor     = [UIColor redColor];
    self.warningLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.warningLabel.numberOfLines = 0;
    [self.warningLabel sizeToFit];
    [self.scrollView addSubview:self.warningLabel];
    
    // Button type label
    self.buttonTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,
                                                                             self.warningLabel.frame.origin.y + self.warningLabel.frame.size.height + 10,
                                                                             screenFrame.size.width - 40,
                                                                             40)];
    self.buttonTypeLabel.text          = @"Select the button type.\nSCB: Simple Circle Button\nTICB: Text Inside Circle Button\nTOCB: Text OUtside Circle Butotn\nHAM:Ham";
    self.buttonTypeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.buttonTypeLabel.numberOfLines = 0;
    [self.buttonTypeLabel sizeToFit];
    [self.scrollView addSubview:self.buttonTypeLabel];
    
    // Button type segmentedControl
    self.buttonTypeSegmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"SCB", @"TICB", @"TOCB", @"HAM"]];
    self.buttonTypeSegmentedControl.frame = CGRectMake(20,
                                                       self.buttonTypeLabel.frame.origin.y + self.buttonTypeLabel.frame.size.height + 10,
                                                       screenFrame.size.width - 40,
                                                    30);
    self.buttonTypeSegmentedControl.selectedSegmentIndex = 0;
    [self.buttonTypeSegmentedControl addTarget:self action:@selector(setButtonType) forControlEvents:UIControlEventValueChanged];
    [self.scrollView addSubview:self.buttonTypeSegmentedControl];
    
    // Place tip label
    self.placeTipLabel               = [[UILabel alloc] initWithFrame:CGRectMake(20,
                                                                   self.buttonTypeSegmentedControl.frame.origin.y + self.buttonTypeSegmentedControl.frame.size.height + 10,
                                                                   screenFrame.size.width - 40,
                                                                   40)];
    self.placeTipLabel.textAlignment = NSTextAlignmentCenter;
    self.placeTipLabel.text          = @"Select the place type of pieces on BMB and sub-buttons on screen. Notice that the number of pieces must equals to sub-buttons'.";
    self.placeTipLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.placeTipLabel.numberOfLines = 0;
    [self.placeTipLabel sizeToFit];
    [self.scrollView addSubview:self.placeTipLabel];
    
    // Place picker view
    self.placePickerView            = [[UIPickerView alloc] initWithFrame:CGRectMake(20,
                                                                          self.placeTipLabel.frame.origin.y + self.placeTipLabel.frame.size.height,
                                                                          screenFrame.size.width - 40,
                                                                          150)];
    self.placePickerView.dataSource = self;
    self.placePickerView.delegate   = self;
    [self.scrollView addSubview:self.placePickerView];
    
    // Boom and alignment label
    self.boomAndAlignmentTipLabel               = [[TopLineLabel alloc] initWithFrame:CGRectMake(20,
                                                                                   self.placePickerView.frame.origin.y + self.placePickerView.frame.size.height,
                                                                                   screenFrame.size.width - 40,
                                                                                   40)];
    self.boomAndAlignmentTipLabel.textAlignment = NSTextAlignmentCenter;
    self.boomAndAlignmentTipLabel.text          = @"Select the boom type for BMB and the button alignment on the screen.";
    self.boomAndAlignmentTipLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.boomAndAlignmentTipLabel.numberOfLines = 0;
    [self.boomAndAlignmentTipLabel sizeToFit];
    [self.scrollView addSubview:self.boomAndAlignmentTipLabel];
    
    // Boom and alignment picker view
    self.boomAndAlignmentPickerView            = [[UIPickerView alloc] initWithFrame:CGRectMake(20,
                                                                                     self.boomAndAlignmentTipLabel.frame.origin.y + self.boomAndAlignmentTipLabel.frame.size.height,
                                                                                     screenFrame.size.width - 40,
                                                                                     150)];
    self.boomAndAlignmentPickerView.dataSource = self;
    self.boomAndAlignmentPickerView.delegate   = self;
    [self.scrollView addSubview:self.boomAndAlignmentPickerView];
    
    // Auto hide label
    self.autoHideLabel               = [[TopLineLabel alloc] initWithFrame:CGRectMake(20,
                                                                        self.boomAndAlignmentPickerView.frame.origin.y + self.boomAndAlignmentPickerView.frame.size.height,
                                                                        screenFrame.size.width - 40,
                                                                        40)];
    self.autoHideLabel.textAlignment = NSTextAlignmentCenter;
    self.autoHideLabel.text          = @"Switch whether the BMB will automatically hide when one of the sub-buttons is clicked.";
    self.autoHideLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.autoHideLabel.numberOfLines = 0;
    [self.autoHideLabel sizeToFit];
    [self.scrollView addSubview:self.autoHideLabel];
    
    // Auto hide switch
    self.autoHideSwitch    = [[UISwitch alloc] initWithFrame:CGRectMake(20,
                                                                     self.autoHideLabel.frame.origin.y + self.autoHideLabel.frame.size.height,
                                                                     screenFrame.size.width - 40,
                                                                     40)];
    self.autoHideSwitch.on = YES;
    [self.autoHideSwitch addTarget:self action:@selector(setAutoHide) forControlEvents:UIControlEventValueChanged];
    [self.scrollView addSubview:self.autoHideSwitch];
    
    // Cancelable label
    self.cancelableLabel               = [[TopLineLabel alloc] initWithFrame:CGRectMake(20,
                                                                          self.autoHideSwitch.frame.origin.y + self.autoHideSwitch.frame.size.height + 10,
                                                                          screenFrame.size.width - 40,
                                                                          40)];
    self.cancelableLabel.textAlignment = NSTextAlignmentCenter;
    self.cancelableLabel.text          = @"Switch whether the BMB is able to hide when its background is clicked.";
    self.cancelableLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.cancelableLabel.numberOfLines = 0;
    [self.cancelableLabel sizeToFit];
    [self.scrollView addSubview:self.cancelableLabel];
    
    // Cancelable switch
    self.cancelableSwitch    = [[UISwitch alloc] initWithFrame:CGRectMake(20,
                                                                       self.cancelableLabel.frame.origin.y + self.cancelableLabel.frame.size.height,
                                                                       screenFrame.size.width - 40,
                                                                       40)];
    self.cancelableSwitch.on = YES;
    [self.cancelableSwitch addTarget:self action:@selector(setCancelable) forControlEvents:UIControlEventValueChanged];
    [self.scrollView addSubview:self.cancelableSwitch];
    
    // No background label
    self.noBackgroundLabel               = [[TopLineLabel alloc] initWithFrame:CGRectMake(20,
                                                                        self.cancelableSwitch.frame.origin.y + self.cancelableSwitch.frame.size.height + 10,
                                                                        screenFrame.size.width - 40,
                                                                        40)];
    self.noBackgroundLabel.textAlignment = NSTextAlignmentCenter;
    self.noBackgroundLabel.text          = @"Switch whether the background of BMB is hidden. This property is for using BMB in some situation, for instance, in navigation bar.";
    self.noBackgroundLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.noBackgroundLabel.numberOfLines = 0;
    [self.noBackgroundLabel sizeToFit];
    [self.scrollView addSubview:self.noBackgroundLabel];
    
    // No background switch
    self.noBackgroundSwitch    = [[UISwitch alloc] initWithFrame:CGRectMake(20,
                                                                         self.noBackgroundLabel.frame.origin.y + self.noBackgroundLabel.frame.size.height,
                                                                         screenFrame.size.width - 40,
                                                                         40)];
    self.noBackgroundSwitch.on = NO;
    [self.noBackgroundSwitch addTarget:self action:@selector(setNoBackground) forControlEvents:UIControlEventValueChanged];
    [self.scrollView addSubview:self.noBackgroundSwitch];
    
    // Draggable label
    self.draggableLabel               = [[TopLineLabel alloc] initWithFrame:CGRectMake(20,
                                                                         self.noBackgroundSwitch.frame.origin.y + self.noBackgroundSwitch.frame.size.height + 10,
                                                                         screenFrame.size.width - 40,
                                                                         40)];
    self.draggableLabel.textAlignment = NSTextAlignmentCenter;
    self.draggableLabel.text          = @"Switch whether the BMB is draggable.";
    self.draggableLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.draggableLabel.numberOfLines = 0;
    [self.draggableLabel sizeToFit];
    [self.scrollView addSubview:self.draggableLabel];
    
    // Draggable switch
    self.draggableSwitch    = [[UISwitch alloc] initWithFrame:CGRectMake(20,
                                                                      self.draggableLabel.frame.origin.y + self.draggableLabel.frame.size.height,
                                                                      screenFrame.size.width - 40,
                                                                      40)];
    self.draggableSwitch.on = NO;
    [self.draggableSwitch addTarget:self action:@selector(setDraggable) forControlEvents:UIControlEventValueChanged];
    [self.scrollView addSubview:self.draggableSwitch];
    
    // Duration label
    self.durationLabel               = [[TopLineLabel alloc] initWithFrame:CGRectMake(20,
                                                                        self.draggableSwitch.frame.origin.y + self.draggableSwitch.frame.size.height + 10,
                                                                        screenFrame.size.width - 40,
                                                                        40)];
    self.durationLabel.textAlignment = NSTextAlignmentCenter;
    self.durationLabel.text          = [NSString stringWithFormat:@"Slide the duration(%.3f second) of the boom/reboom animation. Notice that the full duration equals to the sum of duration you set and the start-delays of every sub-button.", 0.7];
    self.durationLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.durationLabel.numberOfLines = 0;
    [self.durationLabel sizeToFit];
    [self.scrollView addSubview:self.durationLabel];
    
    // Duration Slider
    self.durationSlider              = [[UISlider alloc] initWithFrame:CGRectMake(20,
                                                                     self.durationLabel.frame.origin.y + self.durationLabel.frame.size.height,
                                                                     screenFrame.size.width - 40,
                                                                     40)];
    self.durationSlider.minimumValue = 0.3f;
    self.durationSlider.maximumValue = 5.0f;
    self.durationSlider.value        = 0.7f;
    [self.durationSlider addTarget:self action:@selector(setDuration) forControlEvents:UIControlEventValueChanged];
    [self.scrollView addSubview:self.durationSlider];
    
    // Delay label
    self.delayLabel               = [[TopLineLabel alloc] initWithFrame:CGRectMake(20,
                                                                     self.durationSlider.frame.origin.y + self.durationSlider.frame.size.height + 10,
                                                                     screenFrame.size.width - 40,
                                                                     40)];
    self.delayLabel.textAlignment = NSTextAlignmentCenter;
    self.delayLabel.text          = [NSString stringWithFormat:@"Slide the delay(%.3f second) of the boom/reboom animation.", 0.1f];
    self.delayLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.delayLabel.numberOfLines = 0;
    [self.delayLabel sizeToFit];
    [self.scrollView addSubview:self.delayLabel];
    
    // Delay Slider
    self.delaySlider              = [[UISlider alloc] initWithFrame:CGRectMake(20,
                                                                  self.delayLabel.frame.origin.y + self.delayLabel.frame.size.height,
                                                                  screenFrame.size.width - 40,
                                                                  40)];
    self.delaySlider.minimumValue = 0.0f;
    self.delaySlider.maximumValue = 1.0f;
    self.delaySlider.value        = 0.1f;
    [self.delaySlider addTarget:self action:@selector(setDelay) forControlEvents:UIControlEventValueChanged];
    [self.scrollView addSubview:self.delaySlider];
    
    // Degree label
    self.degreeLabel               = [[TopLineLabel alloc] initWithFrame:CGRectMake(20,
                                                                     self.delaySlider.frame.origin.y + self.delaySlider.frame.size.height + 10,
                                                                     screenFrame.size.width - 40,
                                                                     40)];
    self.degreeLabel.textAlignment = NSTextAlignmentCenter;
    self.degreeLabel.text          = [NSString stringWithFormat:@"Slide the degree(%dπ) of the rotation animation.", 4];
    self.degreeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.degreeLabel.numberOfLines = 0;
    [self.degreeLabel sizeToFit];
    [self.scrollView addSubview:self.degreeLabel];
    
    // Degree Slider
    self.degreeSlider              = [[UISlider alloc] initWithFrame:CGRectMake(20,
                                                                  self.degreeLabel.frame.origin.y + self.degreeLabel.frame.size.height,
                                                                  screenFrame.size.width - 40,
                                                                  40)];
    self.degreeSlider.minimumValue = -8;
    self.degreeSlider.maximumValue = 8;
    self.degreeSlider.value        = 4;
    [self.degreeSlider addTarget:self action:@selector(setRotateDegree) forControlEvents:UIControlEventValueChanged];
    [self.scrollView addSubview:self.degreeSlider];
    
    // BMB
    CGFloat bmbRadius = 60;
    self.bmb                    = [[VHBoomMenuButton alloc] initWithFrame:CGRectMake(screenFrame.size.width - 20 - bmbRadius,
                                                                  screenFrame.size.height - 20 - bmbRadius,
                                                                  bmbRadius,
                                                                  bmbRadius)];
    CGRect contentRect          = CGRectZero;
    for (UIView *view in self.scrollView.subviews)
    {
    contentRect                 = CGRectUnion(contentRect, view.frame);
    }
    self.scrollView.contentSize = contentRect.size;
    
    self.bmb.buttonEnum               = VHButtonSimpleCircle;
    self.bmb.boomEnum                 = VHBoomParabola_1;
    self.bmb.buttonPlaceAlignmentEnum = VHButtonPlaceAlignmentBottom;
    self.bmb.boomDelegate             = self;
    [self.view addSubview:self.bmb];
    
    [self updateBMB];
}

- (void)updateBMB
{
    [self.bmb removeBuilders];
    
    self.bmb.buttonEnum = self.selectedButtonEnum;
    self.bmb.piecePlaceEnum = self.selectedPiecePlaceEnum;
    self.bmb.buttonPlaceEnum = self.selectedButtonPlaceEnum;
    self.bmb.boomEnum = self.selectedBoomEnum;
    self.bmb.buttonPlaceAlignmentEnum = self.selectedButtonPlaceAlignmentEnum;
    
    [self addButtons:(int)[[VHPiecePlaceManager sharedManager] numbersWithEnum:self.selectedPiecePlaceEnum]];
    
    [self.bmb setNeedsLayout];
}

- (void)addButtons:(int)size
{
    for (int i = 0; i < [[VHPiecePlaceManager sharedManager] numbersWithEnum:self.selectedPiecePlaceEnum]; i++)
    {
        __weak typeof(self) weakSelf = self;
        switch (self.selectedButtonEnum)
        {
            case VHButtonSimpleCircle:
            {
                [self.bmb addSimpleCircleButtonBuilderBlock:^(VHSimpleCircleButtonBuilder *builder) {
                    __strong typeof(weakSelf) strongSelf = weakSelf;
                    builder.imageNormal                  = [strongSelf.images objectAtIndex:i];
                    builder.buttonNormalColor            = [strongSelf.buttonNormalColors objectAtIndex:i];
                    builder.buttonPressedColor           = [strongSelf.buttonPressedColors objectAtIndex:i];
                    builder.imageNormalTintColor         = [strongSelf.imageNormalTintColors objectAtIndex:i];
                    builder.imagePressedTintColor        = [strongSelf.imagePressedTintColors objectAtIndex:i];
                    builder.imageFrame                   = CGRectMake(10, 10, 60, 60);
                }];
            }
                break;
            case VHButtonTextInsideCircle:
            {
                [self.bmb addTextInsideCircleButtonBuilderBlock:^(VHTextInsideCircleButtonBuilder *builder) {
                    __strong typeof(weakSelf) strongSelf = weakSelf;
                    builder.imageNormal                  = [strongSelf.images objectAtIndex:i];
                    builder.buttonNormalColor            = [strongSelf.buttonNormalColors objectAtIndex:i];
                    builder.buttonPressedColor           = [strongSelf.buttonPressedColors objectAtIndex:i];
                    builder.imageNormalTintColor         = [strongSelf.imageNormalTintColors objectAtIndex:i];
                    builder.imagePressedTintColor        = [strongSelf.imagePressedTintColors objectAtIndex:i];
                    builder.textContent                  = [[strongSelf.images objectAtIndex:i] substringToIndex:[strongSelf.images objectAtIndex:i].length - 4];
                    builder.textPressedColor             = [strongSelf.buttonNormalColors objectAtIndex:i];
                    builder.imageFrame                   = CGRectMake(10, 10, 60, 60);
                    builder.rotateImage                  = YES;
                    builder.rotateText                   = NO;
                }];
            }
                break;
            case VHButtonTextOutsideCircle:
            {
                [self.bmb addTextOutsideCircleButtonBuilderBlock:^(VHTextOutsideCircleButtonBuilder *builder) {
                    __strong typeof(weakSelf) strongSelf = weakSelf;
                    builder.imageNormal                  = [strongSelf.images objectAtIndex:i];
                    builder.buttonNormalColor            = [strongSelf.buttonNormalColors objectAtIndex:i];
                    builder.buttonPressedColor           = [strongSelf.buttonPressedColors objectAtIndex:i];
                    builder.textNormalColor              = UIColorFromRGB(0xffffff);
                    builder.textPressedColor             = [strongSelf.buttonNormalColors objectAtIndex:i];
                    builder.imageNormalTintColor         = [strongSelf.imageNormalTintColors objectAtIndex:i];
                    builder.imagePressedTintColor        = [strongSelf.imagePressedTintColors objectAtIndex:i];
                    builder.textContent                  = [[strongSelf.images objectAtIndex:i] substringToIndex:[strongSelf.images objectAtIndex:i].length - 4];
                    builder.rotateImage                  = YES;
                    builder.rotateText                   = YES;
                }];
            }
                break;
            case VHButtonHam:
            {
                [self.bmb addHamButtonBuilderBlock:^(VHHamButtonBuilder *builder) {
                    __strong typeof(weakSelf) strongSelf = weakSelf;
                    builder.imageNormal           = [strongSelf.images objectAtIndex:i];
                    builder.buttonNormalColor     = [strongSelf.buttonNormalColors objectAtIndex:i];
                    builder.buttonPressedColor    = [strongSelf.buttonPressedColors objectAtIndex:i];
                    builder.imageNormalTintColor  = [strongSelf.imageNormalTintColors objectAtIndex:i];
                    builder.imagePressedTintColor = [strongSelf.imagePressedTintColors objectAtIndex:i];
                    builder.titleContent          = [[strongSelf.images objectAtIndex:i] substringToIndex:[strongSelf.images objectAtIndex:i].length - 4];
                    builder.subTitleContent       = [[strongSelf.images objectAtIndex:i] substringToIndex:[strongSelf.images objectAtIndex:i].length - 4];
                    builder.rotateImage           = YES;
                    
                    if (i == [[VHPiecePlaceManager sharedManager] numbersWithEnum:self.selectedPiecePlaceEnum] - 1 && i != 0)
                    {
                        builder.containImage    = NO;
                        builder.titleContent    = @"Cancel";
                        builder.titleAlignment  = NSTextAlignmentCenter;
                        builder.subTitleContent = nil;
                    }
                }];
            }
                break;
            default:
                break;
        }
        
    }
}

#pragma mark - Picker View Delegate and DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    if (pickerView == self.placePickerView)
    {
        return 2;
    }
    else if (pickerView == self.boomAndAlignmentPickerView)
    {
        return 2;
    }
    return 0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == self.placePickerView)
    {
        if (component == 0)
        {
            return self.piecePlaceTypesName.count;
        }
        else if (component == 1)
        {
            return self.buttonToPiecePlaceTypesName.count;
        }
    }
    else
    {
        if (component == 0)
        {
            return self.boomTypesName.count;
        }
        else if (component == 1)
        {
            return self.buttonAlignmentTypesName.count;
        }
    }
    
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == self.placePickerView)
    {
        if (component == 0)
        {
            return [self.piecePlaceTypesName objectAtIndex:row];
        }
        else if (component == 1)
        {
            return [self.buttonToPiecePlaceTypesName objectAtIndex:row];
        }
    }
    else if (pickerView == self.boomAndAlignmentPickerView)
    {
        if (component == 0)
        {
            return [self.boomTypesName objectAtIndex:row];
        }
        else if (component == 1)
        {
            return [self.buttonAlignmentTypesName objectAtIndex:row];
        }
    }
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == self.placePickerView)
    {
        if (component == 0)
        {
            self.buttonToPiecePlaceTypesName = [self.buttonPlaceTypesName objectForKey:[self.piecePlaceTypesName objectAtIndex:row]];
            self.buttonToPiecePlaceTypesValue = [self.buttonPlaceTypesValue objectForKey:[self.piecePlaceTypesName objectAtIndex:row]];
            [self.placePickerView reloadComponent:1];
            [self.placePickerView selectRow:0 inComponent:1 animated:YES];
            switch (self.selectedButtonEnum) {
                case VHButtonSimpleCircle:
                case VHButtonTextInsideCircle:
                case VHButtonTextOutsideCircle:
                    self.selectedPiecePlaceEnum = row;
                    break;
                case VHButtonHam:
                    self.selectedPiecePlaceEnum = row + VHPiecePlace_HAM_1;
                    break;
                default:
                    break;
            }
            
            self.selectedButtonPlaceEnum = [[self.buttonToPiecePlaceTypesValue objectAtIndex:0] intValue];
        }
        else if (component == 1)
        {
            self.selectedButtonPlaceEnum = [[self.buttonToPiecePlaceTypesValue objectAtIndex:row] intValue];
        }
    }
    else
    {
        if (component == 0)
        {
            self.selectedBoomEnum = row;
        }
        else if (component == 1)
        {
            self.selectedButtonPlaceAlignmentEnum = row;
        }
    }
    [self updateBMB];
}

#pragma mark - Set Values of BMB

- (void)setButtonType
{
    self.selectedButtonEnum = self.buttonTypeSegmentedControl.selectedSegmentIndex;
    [self initPieceAndButtonPlaceTypes];
    [self.placePickerView reloadAllComponents];
    [self.placePickerView selectRow:0 inComponent:0 animated:NO];
    [self.placePickerView selectRow:0 inComponent:1 animated:NO];
    [self updateBMB];
    
    if (self.bmb.buttonEnum == VHButtonTextOutsideCircle)
    {
        // Make the background darker to show the label clearly
        self.bmb.dimColor = UIColorFromARGB(0x77000000);
    }
    else
    {
        self.bmb.dimColor = UIColorFromARGB(0x33000000);
    }
}

- (void)setAutoHide
{
    self.bmb.autoHide = self.autoHideSwitch.on;
}

- (void)setCancelable
{
    self.bmb.cancelable = self.cancelableSwitch.on;
}

- (void)setNoBackground
{
    self.bmb.noBackground = self.noBackgroundSwitch.on;
    [self.bmb setNeedsLayout];
    [self.bmb setNeedsDisplay];
}

- (void)setDraggable
{
    self.bmb.draggable = self.draggableSwitch.on;
}

- (void)setDuration
{
    self.bmb.duration = self.durationSlider.value;
    self.durationLabel.text = [NSString stringWithFormat:@"Slide the duration(%.3f second) of the boom/reboom animation. Notice that the full duration equals to the sum of duration you set and the start-delays of every sub-button.", self.bmb.duration];
}

- (void)setDelay
{
    self.bmb.delay = self.delaySlider.value;
    self.delayLabel.text = [NSString stringWithFormat:@"Slide the delay(%.3f second) of the boom/reboom animation.", self.bmb.delay];
}

- (void)setRotateDegree
{
    int discreteValue = roundl([self.degreeSlider value]);
    [self.degreeSlider setValue:(float)discreteValue];
    self.bmb.rotationDegree = discreteValue * M_PI;
    self.degreeLabel.text = [NSString stringWithFormat:@"Slide the degree(%dπ) of the rotation animation.", discreteValue];
}

#pragma mark - Delegates from BMB

- (void)onBoomClicked:(int)index
{
    NSString *name = [[self.images objectAtIndex:index] substringToIndex:[self.images objectAtIndex:index].length - 4];
    self.statusLabel.text = [NSString stringWithFormat:@"%@ was clicked!", [[[name substringToIndex:1] uppercaseString] stringByAppendingString:[name substringFromIndex:1]]];
    if (self.bmb.cancelable == NO)
    {
        [self.bmb reboom];
    }
}

- (void)onBoomBackgroundClicked
{
    self.statusLabel.text = [NSString stringWithFormat:@"Background was clicked!"];
}

- (void)onBoomWillShow
{
    self.statusLabel.text = @"Boom will show.";
}

- (void)onBoomDidShow
{
    self.statusLabel.text = @"Boom did show.";
}

- (void)onBoomWillHide
{
    self.statusLabel.text = [self.statusLabel.text stringByAppendingString:@"\nBoom will hide."];
}

- (void)onBoomDidHide
{
    self.statusLabel.text = @"Boom did hide.";
}

#pragma mark - Init Some Values for Test

- (void)initTestValues
{
    self.selectedButtonEnum = VHButtonSimpleCircle;
    self.selectedPiecePlaceEnum = VHPiecePlace_DOT_1;
    self.selectedButtonPlaceEnum = VHButtonPlace_SC_1;
    self.selectedBoomEnum = VHBoomStraightLine;
    self.selectedButtonPlaceAlignmentEnum = VHButtonPlaceAlignmentCenter;
    
    [self initButtons];
    [self initPieceAndButtonPlaceTypes];
    [self initBoomAndButtonAlignmentTypes];
}

- (void)initButtons
{
    self.images = @[@"butterfly.png",
                    @"peacock.png",
                    @"rat.png",
                    @"jellyFish.png",
                    @"horse.png",
                    @"dolphin.png",
                    @"deer.png",
                    @"cat.png",
                    @"bear.png",
                    @"snake.png",
                    @"pig.png",
                    @"eagle.png",
                    @"bat.png",
                    @"bee.png",
                    @"owl.png",
                    @"squirrel.png"];
    
    self.buttonNormalColors = @[UIColorFromRGB(0xD32F2F),
                                UIColorFromRGB(0xC2185B),
                                UIColorFromRGB(0x7B1FA2),
                                UIColorFromRGB(0x512DA8),
                                UIColorFromRGB(0x1976D2),
                                UIColorFromRGB(0x0097A7),
                                UIColorFromRGB(0x00796B),
                                UIColorFromRGB(0x388E3C),
                                UIColorFromRGB(0x689F38),
                                UIColorFromRGB(0xFBC02D),
                                UIColorFromRGB(0xFFA000),
                                UIColorFromRGB(0xF57C00),
                                UIColorFromRGB(0xE64A19),
                                UIColorFromRGB(0x5D4037),
                                UIColorFromRGB(0x616161),
                                UIColorFromRGB(0x455A64)];
    
    self.buttonPressedColors = @[UIColorFromRGB(0xF44336),
                                 UIColorFromRGB(0xE91E63),
                                 UIColorFromRGB(0x9C27B0),
                                 UIColorFromRGB(0x673AB7),
                                 UIColorFromRGB(0x2196F3),
                                 UIColorFromRGB(0x00BCD4),
                                 UIColorFromRGB(0x009688),
                                 UIColorFromRGB(0x4CAF50),
                                 UIColorFromRGB(0x8BC34A),
                                 UIColorFromRGB(0xFFEB3B),
                                 UIColorFromRGB(0xFFC107),
                                 UIColorFromRGB(0xFF9800),
                                 UIColorFromRGB(0xFF5722),
                                 UIColorFromRGB(0x795548),
                                 UIColorFromRGB(0x9E9E9E),
                                 UIColorFromRGB(0x607D8B)];
    
    self.imageNormalTintColors = @[UIColorFromRGB(0xffffff),
                                   UIColorFromRGB(0xffffff),
                                   UIColorFromRGB(0xffffff),
                                   UIColorFromRGB(0xffffff),
                                   UIColorFromRGB(0xffffff),
                                   UIColorFromRGB(0xffffff),
                                   UIColorFromRGB(0xffffff),
                                   UIColorFromRGB(0xffffff),
                                   UIColorFromRGB(0xffffff),
                                   UIColorFromRGB(0xffffff),
                                   UIColorFromRGB(0xffffff),
                                   UIColorFromRGB(0xffffff),
                                   UIColorFromRGB(0xffffff),
                                   UIColorFromRGB(0xffffff),
                                   UIColorFromRGB(0xffffff),
                                   UIColorFromRGB(0xffffff)];
    
    self.imagePressedTintColors = @[UIColorFromRGB(0xFFCDD2),
                                    UIColorFromRGB(0xF8BBD0),
                                    UIColorFromRGB(0xE1BEE7),
                                    UIColorFromRGB(0xD1C4E9),
                                    UIColorFromRGB(0xBBDEFB),
                                    UIColorFromRGB(0xB2EBF2),
                                    UIColorFromRGB(0xB2DFDB),
                                    UIColorFromRGB(0xC8E6C9),
                                    UIColorFromRGB(0xDCEDC8),
                                    UIColorFromRGB(0xFFF9C4),
                                    UIColorFromRGB(0xFFECB3),
                                    UIColorFromRGB(0xFFE0B2),
                                    UIColorFromRGB(0xFFCCBC),
                                    UIColorFromRGB(0xD7CCC8),
                                    UIColorFromRGB(0xF5F5F5),
                                    UIColorFromRGB(0xCFD8DC)];
}

- (void)initPieceAndButtonPlaceTypes
{
    switch (self.selectedButtonEnum) {
        case VHButtonSimpleCircle:
        case VHButtonTextInsideCircle:
        case VHButtonTextOutsideCircle:
            [self initCircleButtonValues];
            break;
        case VHButtonHam:
            [self initHamButtonValues];
            break;
        default:
            break;
    }
}

- (void)initCircleButtonValues
{
    self.piecePlaceTypesName = @[@"DOT_1",
                                 @"DOT_2_1",
                                 @"DOT_2_2",
                                 @"DOT_3_1",
                                 @"DOT_3_2",
                                 @"DOT_3_3",
                                 @"DOT_3_4",
                                 @"DOT_4_1",
                                 @"DOT_4_2",
                                 @"DOT_5_1",
                                 @"DOT_5_2",
                                 @"DOT_5_3",
                                 @"DOT_5_4",
                                 @"DOT_6_1",
                                 @"DOT_6_2",
                                 @"DOT_6_3",
                                 @"DOT_6_4",
                                 @"DOT_6_5",
                                 @"DOT_6_6",
                                 @"DOT_7_1",
                                 @"DOT_7_2",
                                 @"DOT_7_3",
                                 @"DOT_7_4",
                                 @"DOT_7_5",
                                 @"DOT_7_6",
                                 @"DOT_8_1",
                                 @"DOT_8_2",
                                 @"DOT_8_3",
                                 @"DOT_8_4",
                                 @"DOT_8_5",
                                 @"DOT_8_6",
                                 @"DOT_8_7",
                                 @"DOT_9_1",
                                 @"DOT_9_2",
                                 @"DOT_9_3"];
    
    self.buttonPlaceTypesName = [NSMutableDictionary dictionaryWithCapacity:self.piecePlaceTypesName.count];
    self.buttonPlaceTypesValue = [NSMutableDictionary dictionaryWithCapacity:self.piecePlaceTypesName.count];
    
    for (int i = 0; i <= 0; i++)
    {
        [self.buttonPlaceTypesName setObject:@[@"SC_1",
                                               @"Horizontal",
                                               @"Vertical"] forKey:[self.piecePlaceTypesName objectAtIndex:i]];
        [self.buttonPlaceTypesValue setObject:@[@(VHButtonPlace_SC_1),
                                                @(VHButtonPlace_Horizontal),
                                                @(VHButtonPlace_Vertical)] forKey:[self.piecePlaceTypesName objectAtIndex:i]];
    }
    
    for (int i = 1; i <= 2; i++)
    {
        [self.buttonPlaceTypesName setObject:@[@"SC_2_1",
                                               @"SC_2_2",
                                               @"Horizontal",
                                               @"Vertical"] forKey:[self.piecePlaceTypesName objectAtIndex:i]];
        [self.buttonPlaceTypesValue setObject:@[@(VHButtonPlace_SC_2_1),
                                                @(VHButtonPlace_SC_2_2),
                                                @(VHButtonPlace_Horizontal),
                                                @(VHButtonPlace_Vertical)] forKey:[self.piecePlaceTypesName objectAtIndex:i]];
    }
    
    for (int i = 3; i <= 6; i++)
    {
        [self.buttonPlaceTypesName setObject:@[@"SC_3_1",
                                               @"SC_3_2",
                                               @"SC_3_3",
                                               @"SC_3_4",
                                               @"Horizontal",
                                               @"Vertical"] forKey:[self.piecePlaceTypesName objectAtIndex:i]];
        [self.buttonPlaceTypesValue setObject:@[@(VHButtonPlace_SC_3_1),
                                                @(VHButtonPlace_SC_3_2),
                                                @(VHButtonPlace_SC_3_3),
                                                @(VHButtonPlace_SC_3_4),
                                                @(VHButtonPlace_Horizontal),
                                                @(VHButtonPlace_Vertical)] forKey:[self.piecePlaceTypesName objectAtIndex:i]];
    }
    
    for (int i = 7; i <= 8; i++)
    {
        [self.buttonPlaceTypesName setObject:@[@"SC_4_1",
                                               @"SC_4_2",
                                               @"Horizontal",
                                               @"Vertical"] forKey:[self.piecePlaceTypesName objectAtIndex:i]];
        [self.buttonPlaceTypesValue setObject:@[@(VHButtonPlace_SC_4_1),
                                                @(VHButtonPlace_SC_4_2),
                                                @(VHButtonPlace_Horizontal),
                                                @(VHButtonPlace_Vertical)] forKey:[self.piecePlaceTypesName objectAtIndex:i]];
    }
    
    for (int i = 9; i <= 12; i++)
    {
        [self.buttonPlaceTypesName setObject:@[@"SC_5_1",
                                               @"SC_5_2",
                                               @"SC_5_3",
                                               @"SC_5_4",
                                               @"Horizontal",
                                               @"Vertical"] forKey:[self.piecePlaceTypesName objectAtIndex:i]];
        [self.buttonPlaceTypesValue setObject:@[@(VHButtonPlace_SC_5_1),
                                                @(VHButtonPlace_SC_5_2),
                                                @(VHButtonPlace_SC_5_3),
                                                @(VHButtonPlace_SC_5_4),
                                                @(VHButtonPlace_Horizontal),
                                                @(VHButtonPlace_Vertical)] forKey:[self.piecePlaceTypesName objectAtIndex:i]];
    }
    
    for (int i = 13; i <= 18; i++)
    {
        [self.buttonPlaceTypesName setObject:@[@"SC_6_1",
                                               @"SC_6_2",
                                               @"SC_6_3",
                                               @"SC_6_4",
                                               @"SC_6_5",
                                               @"SC_6_6",
                                               @"Horizontal",
                                               @"Vertical"] forKey:[self.piecePlaceTypesName objectAtIndex:i]];
        [self.buttonPlaceTypesValue setObject:@[@(VHButtonPlace_SC_6_1),
                                                @(VHButtonPlace_SC_6_2),
                                                @(VHButtonPlace_SC_6_3),
                                                @(VHButtonPlace_SC_6_4),
                                                @(VHButtonPlace_SC_6_5),
                                                @(VHButtonPlace_SC_6_6),
                                                @(VHButtonPlace_Horizontal),
                                                @(VHButtonPlace_Vertical)] forKey:[self.piecePlaceTypesName objectAtIndex:i]];
    }
    
    for (int i = 19; i <= 24; i++)
    {
        [self.buttonPlaceTypesName setObject:@[@"SC_7_1",
                                               @"SC_7_2",
                                               @"SC_7_3",
                                               @"SC_7_4",
                                               @"SC_7_5",
                                               @"SC_7_6",
                                               @"Horizontal",
                                               @"Vertical"] forKey:[self.piecePlaceTypesName objectAtIndex:i]];
        [self.buttonPlaceTypesValue setObject:@[@(VHButtonPlace_SC_7_1),
                                                @(VHButtonPlace_SC_7_2),
                                                @(VHButtonPlace_SC_7_3),
                                                @(VHButtonPlace_SC_7_4),
                                                @(VHButtonPlace_SC_7_5),
                                                @(VHButtonPlace_SC_7_6),
                                                @(VHButtonPlace_Horizontal),
                                                @(VHButtonPlace_Vertical)] forKey:[self.piecePlaceTypesName objectAtIndex:i]];
    }
    
    for (int i = 25; i <= 31; i++)
    {
        [self.buttonPlaceTypesName setObject:@[@"SC_8_1",
                                               @"SC_8_2",
                                               @"SC_8_3",
                                               @"SC_8_4",
                                               @"SC_8_5",
                                               @"SC_8_6",
                                               @"SC_8_7",
                                               @"Horizontal",
                                               @"Vertical"] forKey:[self.piecePlaceTypesName objectAtIndex:i]];
        [self.buttonPlaceTypesValue setObject:@[@(VHButtonPlace_SC_8_1),
                                                @(VHButtonPlace_SC_8_2),
                                                @(VHButtonPlace_SC_8_3),
                                                @(VHButtonPlace_SC_8_4),
                                                @(VHButtonPlace_SC_8_5),
                                                @(VHButtonPlace_SC_8_6),
                                                @(VHButtonPlace_SC_8_7),
                                                @(VHButtonPlace_Horizontal),
                                                @(VHButtonPlace_Vertical)] forKey:[self.piecePlaceTypesName objectAtIndex:i]];
    }
    
    for (int i = 32; i <= 34; i++)
    {
        [self.buttonPlaceTypesName setObject:@[@"SC_9_1",
                                               @"SC_9_2",
                                               @"SC_9_3",
                                               @"Horizontal",
                                               @"Vertical"] forKey:[self.piecePlaceTypesName objectAtIndex:i]];
        [self.buttonPlaceTypesValue setObject:@[@(VHButtonPlace_SC_9_1),
                                                @(VHButtonPlace_SC_9_2),
                                                @(VHButtonPlace_SC_9_3),
                                                @(VHButtonPlace_Horizontal),
                                                @(VHButtonPlace_Vertical)] forKey:[self.piecePlaceTypesName objectAtIndex:i]];
    }
    
    self.selectedPiecePlaceEnum = VHPiecePlace_DOT_1;
    self.selectedButtonPlaceEnum = VHButtonPlace_SC_1;
    self.buttonToPiecePlaceTypesName = [self.buttonPlaceTypesName objectForKey:[self.piecePlaceTypesName objectAtIndex:0]];
    self.buttonToPiecePlaceTypesValue = [self.buttonPlaceTypesValue objectForKey:[self.piecePlaceTypesName objectAtIndex:0]];
}

- (void)initHamButtonValues
{
    self.piecePlaceTypesName = @[@"HAM_1",
                                 @"HAM_2",
                                 @"HAM_3",
                                 @"HAM_4",
                                 @"HAM_5"];
    
    self.buttonPlaceTypesName = [NSMutableDictionary dictionaryWithCapacity:self.piecePlaceTypesName.count];
    self.buttonPlaceTypesValue = [NSMutableDictionary dictionaryWithCapacity:self.piecePlaceTypesName.count];
    
    [self.buttonPlaceTypesName setObject:@[@"HAM_1",
                                           @"Horizontal",
                                           @"Vertical"] forKey:[self.piecePlaceTypesName objectAtIndex:0]];
    [self.buttonPlaceTypesValue setObject:@[@(VHButtonPlace_HAM_1),
                                            @(VHButtonPlace_Horizontal),
                                            @(VHButtonPlace_Vertical)] forKey:[self.piecePlaceTypesName objectAtIndex:0]];
    
    [self.buttonPlaceTypesName setObject:@[@"HAM_2",
                                           @"Horizontal",
                                           @"Vertical"] forKey:[self.piecePlaceTypesName objectAtIndex:1]];
    [self.buttonPlaceTypesValue setObject:@[@(VHButtonPlace_HAM_2),
                                            @(VHButtonPlace_Horizontal),
                                            @(VHButtonPlace_Vertical)] forKey:[self.piecePlaceTypesName objectAtIndex:1]];
    
    [self.buttonPlaceTypesName setObject:@[@"HAM_3",
                                           @"Horizontal",
                                           @"Vertical"] forKey:[self.piecePlaceTypesName objectAtIndex:2]];
    [self.buttonPlaceTypesValue setObject:@[@(VHButtonPlace_HAM_3),
                                            @(VHButtonPlace_Horizontal),
                                            @(VHButtonPlace_Vertical)] forKey:[self.piecePlaceTypesName objectAtIndex:2]];
    
    [self.buttonPlaceTypesName setObject:@[@"HAM_4",
                                           @"Horizontal",
                                           @"Vertical"] forKey:[self.piecePlaceTypesName objectAtIndex:3]];
    [self.buttonPlaceTypesValue setObject:@[@(VHButtonPlace_HAM_4),
                                            @(VHButtonPlace_Horizontal),
                                            @(VHButtonPlace_Vertical)] forKey:[self.piecePlaceTypesName objectAtIndex:3]];
    
    [self.buttonPlaceTypesName setObject:@[@"HAM_5",
                                           @"Horizontal",
                                           @"Vertical"] forKey:[self.piecePlaceTypesName objectAtIndex:4]];
    [self.buttonPlaceTypesValue setObject:@[@(VHButtonPlace_HAM_5),
                                            @(VHButtonPlace_Horizontal),
                                            @(VHButtonPlace_Vertical)] forKey:[self.piecePlaceTypesName objectAtIndex:4]];
    
    self.selectedPiecePlaceEnum = VHPiecePlace_HAM_1;
    self.selectedButtonPlaceEnum = VHButtonPlace_HAM_1;
    self.buttonToPiecePlaceTypesName = [self.buttonPlaceTypesName objectForKey:[self.piecePlaceTypesName objectAtIndex:0]];
    self.buttonToPiecePlaceTypesValue = [self.buttonPlaceTypesValue objectForKey:[self.piecePlaceTypesName objectAtIndex:0]];
}

- (void)initBoomAndButtonAlignmentTypes
{
    self.boomTypesName = @[@"Straight Line",
                           @"Parabola 1",
                           @"Parabola 2",
                           @"Parabola 3",
                           @"Parabola 4",
                           @"Horizontal Throw 1",
                           @"Horizontal Throw 2",
                           @"Random"];
    
    self.buttonAlignmentTypesName = @[@"Center",
                                      @"Top",
                                      @"Bottom",
                                      @"Left",
                                      @"Right",
                                      @"Top Left",
                                      @"Top Right",
                                      @"Bottom Left",
                                      @"Bottom Right"];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
