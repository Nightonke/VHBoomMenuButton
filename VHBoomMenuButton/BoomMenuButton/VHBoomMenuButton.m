//
//  VHBoomMenuButton.m
//  VHBoomMenuExample
//
//  Created by Nightonke on 16/7/28.
//  Copyright © 2016年 Nightonke. All rights reserved.
//

#import "VHBoomMenuButton.h"
#include <stdlib.h>
#import "VHAnimationManager.h"
#import "VHBoomStateEnum.h"
#import "VHInnerOnBoomButtonClickListener.h"
#import "VHShareLinesView.h"
#import "VHBackgroundClickDelegate.h"
#import "VHBackgroundView.h"
#import "VHUtils.h"
#import "VHErrorManager.h"
#import "VHEase.h"
#import "VHPiecePlaceManager.h"
#import "VHButtonPlaceManager.h"
#import "VHBoomButton.h"
#import "VHSimpleCircleButton.h"
#import "VHSimpleCircleButtonBuilder.h"
#import "VHTextInsideCircleButton.h"
#import "VHTextInsideCircleButtonBuilder.h"
#import "VHTextOutsideCircleButton.h"
#import "VHTextOutsideCircleButtonBuilder.h"
#import "VHHamButton.h"
#import "VHHamButtonBuilder.h"
#import "VHBoomPiece.h"
#import "VHButtonStateEnum.h"
#import "VHShareLinesView.h"

typedef void (^DelayBlock) (void);

static NSString *const kFillColorAnimation = @"kFillColorAnimation";

@interface VHBoomMenuButton ()<VHInnerOnBoomButtonClickListener, VHBackgroundClickDelegate>

#pragma mark - Button

@property (nonatomic, assign) CGFloat startPositionX;
@property (nonatomic, assign) CGFloat startPositionY;
@property (nonatomic, assign) BOOL ableToStartDragging;
@property (nonatomic, assign) BOOL isDragging;
@property (nonatomic, strong) CAShapeLayer *buttonLayer;
@property (nonatomic, assign) VHButtonStateEnum lastButtonState;

#pragma mark - Piece

@property (nonatomic, strong) NSMutableArray<VHBoomPiece *> *pieces;
@property (nonatomic, strong) NSMutableArray<NSValue *> *piecePositions;
@property (nonatomic, strong) VHShareLinesView *shareLinesView;

#pragma mark - Animation

@property (nonatomic, assign) int animatingViewsNumber;
@property (nonatomic, strong) VHEase *showMoveEase;
@property (nonatomic, strong) VHEase *showScaleEase;
@property (nonatomic, strong) VHEase *showRotateEase;
@property (nonatomic, strong) VHEase *hideMoveEase;
@property (nonatomic, strong) VHEase *hideScaleEase;
@property (nonatomic, strong) VHEase *hideRotateEase;
@property (nonatomic, assign) VHBoomStateEnum boomState;

#pragma mark - Background

@property (nonatomic, strong) VHBackgroundView *background;
@property (nonatomic, strong) UILabel *tipLabel;

#pragma mark - Boom Buttons

@property (nonatomic, strong) NSMutableArray<VHBoomButton *> *boomButtons;
@property (nonatomic, strong) NSMutableArray<VHBoomButtonBuilder *> *boomButtonBuilders;
@property (nonatomic, assign) CGFloat simpleCircleButtonRadius;
@property (nonatomic, assign) CGFloat textInsideCircleButtonRadius;
@property (nonatomic, assign) CGFloat textOutsideCircleButtonWidth;
@property (nonatomic, assign) CGFloat textOutsideCircleButtonHeight;
@property (nonatomic, assign) CGFloat hamButtonWidth;
@property (nonatomic, assign) CGFloat hamButtonHeight;
/**
 Notice that start-positions and end-positions are the position of the layers of boom-buttons.
 And in CAAnimation, the position's pivot is the center of the boom-button.
 */
@property (nonatomic, strong) NSMutableArray<NSValue *> *startPositions;
@property (nonatomic, strong) NSMutableArray<NSValue *> *endPositions;
@property (nonatomic, assign) BOOL needToCalculateStartPositions;
@property (nonatomic, assign) BOOL needToCreateButtons;

#pragma mark - Device Orientation

@property (nonatomic, assign) UIDeviceOrientation lastDeviceOrientation;

@end

@implementation VHBoomMenuButton

#pragma mark - Convenience Methods

+ (NSInteger)pieceNumber:(VHPiecePlaceEnum)placeEnum
{
    return [VHPiecePlaceManager pieceNumber:placeEnum];
}

+ (NSInteger)buttonNumber:(VHButtonPlaceEnum)placeEnum
{
    return [VHButtonPlaceManager buttonNumber:placeEnum];
}

- (NSInteger)pieceNumber
{
    return [VHPiecePlaceManager pieceNumber:self.piecePlaceEnum];
}

- (NSInteger)buttonNumber
{
    return [VHButtonPlaceManager buttonNumber:self.buttonPlaceEnum];
}

#pragma mark - Initialize

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self innerInitialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self innerInitialize];
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init])
    {
        [self innerInitialize];
    }
    return self;
}

- (void)innerInitialize
{
    [self initializeAttributes];
    [self initializeDeviceOrientation];
}

- (void)initializeAttributes
{
    _cacheOptimization = YES;
    _boomInWholeScreen = YES;
    _inList = NO;
    
    _shadowEffect = YES;
    _shadowPathRect = CGRectMake(2, 2, self.frame.size.width - 4, self.frame.size.height - 4);
    _shadowOffsetX = 0;
    _shadowOffsetY = 8;
    _shadowRadius = 4;
    _shadowColor = [VHUtils colorFromARGB:0x44000000];
    
    _buttonEnum = VHButtonUnknown;
    _backgroundEffect = YES;
    _normalColor = [VHUtils colorFromRGB:0x30a2fb];
    _highlightedColor = [VHUtils colorFromRGB:0x73bdf1];
    _unableColor = [VHUtils colorFromRGB:0x30a2fb];
    _draggable = NO;
    _edgeInsetsInSuperView = UIEdgeInsetsMake(15, 15, 15, 15);
    
    _dotRadius = 3;
    _hamWidth = 20;
    _hamHeight = 3;
    _pieceCornerRadius = -1;
    _pieceHorizontalMargin = 2;
    _pieceVerticalMargin = 2;
    _pieceInclinedMargin = 2;
    _shareLineLength = 18;
    _shareLine1Color = [UIColor whiteColor];
    _shareLine2Color = [UIColor whiteColor];
    _shareLineWidth = 1.5;
    _piecePlaceEnum = VHPiecePlaceUnknown;
    
    _blurBackground = NO;
    if ([UIBlurEffect class])
    {
        _blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    }
    _dimColor = [VHUtils colorFromARGB:0x55000000];
    _tip = nil;
    _tipBelowButtons = NO;
    _tipButtonMargin = 40;
    
    _boomDelegate = nil;
    _delay = 0.05;
    _duration = 0.3;
    _showDelay = 0.05;
    _showDuration = 0.3;
    _hideDelay = 0.05;
    _hideDuration = 0.3;
    _cancelable = YES;
    _autoHide = YES;
    _orderEnum = VHOrderRandom;
    _frames = 60;
    _boomEnum = VHBoomHorizontalThrow_2;
    _showMoveEaseName = VHEaseOutBack;
    _showMoveEaseName = VHEaseOutBack;
    _showScaleEaseName = VHEaseOutBack;
    _showRotateEaseName = VHEaseOutBack;
    _hideMoveEaseName = VHEaseInBack;
    _hideMoveEaseName = VHEaseInBack;
    _hideScaleEaseName = VHEaseInBack;
    _hideRotateEaseName = VHEaseInBack;
    _rotateDegree = M_PI * 4;
    _use3DTransformAnimation = YES;
    _autoBoom = NO;
    _autoBoomImmediately = NO;
    
    _buttonPlaceEnum = VHButtonPlaceUnknown;
    _buttonPlaceAlignmentEnum = VHButtonPlaceAlignmentCenter;
    _buttonHorizontalMargin = 12;
    _buttonVerticalMargin = 12;
    _buttonInclinedMargin = 12;
    _buttonBottomMargin = 20;
    _buttonTopMargin = 20;
    _buttonLeftMargin = 20;
    _buttonRightMargin = 20;
    _bottomHamButtonTopMargin = -1;
    
    _ableToStartDragging = NO;
    _isDragging = NO;
    _lastButtonState = VHButtonStateUnknown;
    
    _animatingViewsNumber = 0;
    _showMoveEase = [VHEase easeWithName:_showMoveEaseName];
    _showScaleEase = [VHEase easeWithName:_showScaleEaseName];
    _showRotateEase = [VHEase easeWithName:_showRotateEaseName];
    _hideMoveEase = [VHEase easeWithName:_hideMoveEaseName];
    _hideScaleEase = [VHEase easeWithName:_hideScaleEaseName];
    _hideRotateEase = [VHEase easeWithName:_hideRotateEaseName];
    _boomState = VHBoomStateDidHide;
    
    _boomButtonBuilders = [NSMutableArray array];
    
    _needToCalculateStartPositions = YES;
    _needToCreateButtons = YES;
    
    _lastDeviceOrientation = [[UIDevice currentDevice] orientation];
}

- (void)initializeDeviceOrientation
{
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver: self selector:@selector(deviceOrientationDidChange:) name: UIDeviceOrientationDidChangeNotification object: nil];
}

- (void)dealloc
{
    [self clearViews:YES];
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
}

#pragma mark - Draw

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if (self.backgroundEffect == YES)
    {
        if (self.buttonLayer)
        {
            [self.buttonLayer removeFromSuperlayer];
        }
        else
        {
            self.buttonLayer = [CAShapeLayer layer];
        }
        [self.buttonLayer setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)] CGPath]];
        [self toLastState];
        [[self layer] addSublayer:self.buttonLayer];

        if (self.shadowEffect)
        {
            self.layer.masksToBounds = NO;
            self.layer.shadowPath = [UIBezierPath bezierPathWithOvalInRect:self.shadowPathRect].CGPath;
            self.layer.shadowOffset = CGSizeMake(self.shadowOffsetX, self.shadowOffsetY);
            self.layer.shadowRadius = self.shadowRadius;
            self.layer.shadowColor = self.shadowColor.CGColor;
            self.layer.shadowOpacity = 1;
        }
        else
        {
            self.layer.shadowOpacity = 0;
        }
    }
    else
    {
        [self.buttonLayer removeFromSuperlayer];
        self.layer.shadowOpacity = 0;
    }
    [self checkAutoBoom];
}

#pragma mark - Place Pieces

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.backgroundColor = [UIColor clearColor];
    [self clearPieces];
    [self createPieces];
    [self placeShareLinesView];
    [self placePieces];
    [self calculateStartPositions];
    [self setShareLinesViewData];
}

- (void)clearPieces
{
    for (VHBoomPiece *piece in self.pieces)
    {
        [piece removeFromSuperview];
    }
    [self.pieces removeAllObjects];
}

- (void)createPieces
{
    [self calculatePiecePositons];
    int pieceNumber = [self innerPieceNumber];
    self.pieces = [NSMutableArray arrayWithCapacity:pieceNumber];
    for (int i = 0; i < pieceNumber; i++)
    {
        VHBoomPiece *piece = [[VHBoomPiece alloc] initWithFrame:[[self.piecePositions objectAtIndex:i] CGRectValue]
                                                    withBuilder:[self.boomButtonBuilders objectAtIndex:i]
                                               withCornerRadius:self.pieceCornerRadius];
        [self.pieces addObject:piece];
    }
}

- (void)placePieces
{
    NSMutableArray<NSNumber *> *indexes;
    if (self.piecePlaceEnum == VHPiecePlaceShare)
    {
        indexes = [VHAnimationManager orderIndexes:VHOrderDefault inSize:self.pieces.count];
    }
    else
    {
        indexes = [VHAnimationManager orderIndexes:self.orderEnum inSize:self.pieces.count];
    }
    [indexes enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSNumber * _Nonnull indexObj, NSUInteger i, BOOL * _Nonnull stop) {
        int index = [indexObj intValue];
        [self addSubview:[self.pieces objectAtIndex:index]];
        
    }];
    if (self.piecePlaceEnum == VHPiecePlaceShare)
    {
        // For share-style, the edges of overrided pieces are still visible.
        // So we have to make them hidden.
        __block int pieceNumbers[3] = {0, 0, 0};
        int totalPieceNumber = [self innerPieceNumber];
        for (int i = 0; i < totalPieceNumber; i++)
        {
            pieceNumbers[i % 3]++;
        }
        NSMutableArray<NSMutableArray<VHBoomPiece *> *> *piecesOn3Positions = [NSMutableArray arrayWithCapacity:3];
        [piecesOn3Positions addObject:[NSMutableArray arrayWithCapacity:3]];
        [piecesOn3Positions addObject:[NSMutableArray arrayWithCapacity:3]];
        [piecesOn3Positions addObject:[NSMutableArray arrayWithCapacity:3]];
        
        int currentPosition = 0;
        for (VHBoomPiece *piece in self.pieces)
        {
            [[piecesOn3Positions objectAtIndex:currentPosition] addObject:piece];
            if ([piecesOn3Positions objectAtIndex:currentPosition].count >= pieceNumbers[currentPosition])
            {
                currentPosition++;
            }
        }
        
        [[piecesOn3Positions objectAtIndex:0] firstObject].isTop = YES;
        [[piecesOn3Positions objectAtIndex:1] firstObject].isTop = YES;
        [[piecesOn3Positions objectAtIndex:2] firstObject].isTop = YES;
        
        for (NSMutableArray<VHBoomPiece *> *piecesOnSamePosition in piecesOn3Positions)
        {
            [piecesOnSamePosition enumerateObjectsUsingBlock:^(VHBoomPiece * _Nonnull piece, NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx + 1 < piecesOnSamePosition.count)
                {
                    piece.pieceBelow = [piecesOnSamePosition objectAtIndex:idx + 1];
                }
            }];
        }
        
        [self.pieces enumerateObjectsUsingBlock:^(VHBoomPiece * _Nonnull piece, NSUInteger idx, BOOL * _Nonnull stop) {
            piece.hidden = !piece.isTop;
        }];
    }
}

- (void)calculatePiecePositons
{
    if (self.piecePlaceEnum == VHPiecePlaceUnknown)
    {
        return;
    }
    switch (self.buttonEnum) {
        case VHButtonSimpleCircle:
        case VHButtonTextInsideCircle:
        case VHButtonTextOutsideCircle:
        {
            if (self.piecePlaceEnum == VHPiecePlaceShare)
            {
                self.piecePositions = [VHPiecePlaceManager positionsForShareStyleWithParentFrame:self.bounds
                                                                                   withDotRadius:self.dotRadius
                                                                                   withDotNumber:self.boomButtonBuilders.count
                                                                             withShareLineLength:self.shareLineLength];
            }
            else
            {
                self.piecePositions = [VHPiecePlaceManager positionsWithEnum:self.piecePlaceEnum
                                                             withParentFrame:self.bounds
                                                               withDotRadius:self.dotRadius
                                                        withHorizontalMargin:self.pieceHorizontalMargin
                                                          withVerticalMargin:self.pieceVerticalMargin
                                                          withInclinedMargin:self.pieceInclinedMargin];
            }
            break;
        }
        case VHButtonHam:
            self.piecePositions = [VHPiecePlaceManager positionsWithEnum:self.piecePlaceEnum
                                                         withParentFrame:self.bounds
                                                            withHamWidth:self.hamWidth
                                                           withHamHeight:self.hamHeight
                                                    withHorizontalMargin:self.pieceHorizontalMargin
                                                      withVerticalMargin:self.pieceInclinedMargin];
            break;
        default:
            break;
    }
}

#pragma mark - Touch Action

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *anyTouch = [touches anyObject];
    CGPoint touchLocation = [anyTouch locationInView:self];
    if (CGRectContainsPoint(self.bounds, touchLocation) && self.userInteractionEnabled)
    {
        [self toHighlighted];
        if (self.draggable)
        {
            self.startPositionX      = touchLocation.x;
            self.startPositionY      = touchLocation.y;
            self.ableToStartDragging = YES;
        }
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *anyTouch = [touches anyObject];
    if (self.draggable && self.ableToStartDragging)
    {
        self.isDragging = YES;
        CGPoint touchLocationInParent = [anyTouch locationInView:self.superview];
        self.frame = CGRectMake(touchLocationInParent.x - self.startPositionX, touchLocationInParent.y - self.startPositionY, self.frame.size.width, self.frame.size.height);
    }
    else
    {
        CGPoint touchLocation = [anyTouch locationInView:self];
        if (!CGRectContainsPoint(self.bounds, touchLocation))
        {
            [self toNormal];
        }
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.isDragging)
    {
        self.ableToStartDragging = NO;
        self.isDragging = NO;
        self.needToCalculateStartPositions = YES;
        [self preventDragOutside];
    }
    else
    {
        UITouch *anyTouch = [touches anyObject];
        CGPoint touchLocation = [anyTouch locationInView:self];
        if (CGRectContainsPoint(self.bounds, touchLocation))
        {
            [self boom];
        }        
    }
    
    [self toNormal];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self toNormal];
    
    if (self.isDragging)
    {
        self.ableToStartDragging = NO;
        self.isDragging = NO;
        self.needToCalculateStartPositions = YES;
        [self preventDragOutside];
        return;
    }
}

- (void)toUnable
{
    if (self.lastButtonState == VHButtonStateUnable)
    {
        return;
    }
    self.lastButtonState = VHButtonStateUnable;
    [self.buttonLayer setFillColor:self.unableColor.CGColor];
}

- (void)toHighlighted
{
    if (self.lastButtonState == VHButtonStateHighlighted)
    {
        return;
    }
    self.lastButtonState = VHButtonStateHighlighted;
    [self.buttonLayer setFillColor:self.highlightedColor.CGColor];
}

- (void)toNormal
{
    if (self.lastButtonState == VHButtonStateNormal)
    {
        return;
    }
    self.lastButtonState = VHButtonStateNormal;
    [self.buttonLayer setFillColor:self.normalColor.CGColor];
}

- (void)toLastState
{
    switch (self.lastButtonState)
    {
        case VHButtonStateHighlighted:
            [self.buttonLayer setFillColor:self.highlightedColor.CGColor];
            break;
        case VHButtonStateUnable:
            [self.buttonLayer setFillColor:self.unableColor.CGColor];
            break;
        case VHButtonStateNormal:
        case VHButtonStateUnknown:
            [self.buttonLayer setFillColor:self.normalColor.CGColor];
            break;
    }
}

#pragma mark - Animation

- (BOOL)isAnimating
{
    return self.animatingViewsNumber != 0;
}

- (void)boom
{
    [self innerBoom:NO];
}

- (void)boomImmediately
{
    [self innerBoom:YES];
}

- (void)innerBoom:(BOOL)immediately
{
    if ([self uninitializedBoomButtons])
    {
        return;
    }
    [VHErrorManager judge:self withBuilders:self.boomButtonBuilders];
    if ([self isAnimating] || self.boomState != VHBoomStateDidHide)
    {
        return;
    }
    self.boomState = VHBoomStateWillShow;
    if (self.boomDelegate && [self.boomDelegate respondsToSelector:@selector(onBoomWillShow)])
    {
        [self.boomDelegate onBoomWillShow];
    }
    [self calculateStartPositions];
    [self createButtons];
    [self dimBackground:immediately];
    [self startShowAnimations:immediately];
    [self adjustTipLabel];
}

- (void)reboom
{
    [self innerReboom:NO];
}

- (void)reboomImmediately
{
    [self innerReboom:YES];
}

- (void)innerReboom:(BOOL)immediately
{
    if ([self isAnimating] || self.boomState != VHBoomStateDidShow)
    {
        return;
    }
    self.boomState = VHBoomStateWillHide;
    if (self.boomDelegate && [self.boomDelegate respondsToSelector:@selector(onBoomWillHide)])
    {
        [self.boomDelegate onBoomWillHide];
    }
    [self lightBackground:immediately];
    [self startHideAnimation:immediately];
}

- (void)dimBackground:(BOOL)immediately
{
    [self createBackground];
    CFTimeInterval duration = immediately ? 0.001 : self.showDuration + (self.pieces.count - 1) * self.showDelay;
    [self.background dim:duration completion:^(BOOL finished) {
        self.boomState = VHBoomStateDidShow;
        if (self.boomDelegate && [self.boomDelegate respondsToSelector:@selector(onBoomDidShow)])
        {
            [self.boomDelegate onBoomDidShow];
        }
    }];
}

- (void)lightBackground:(BOOL)immediately
{
    [self createBackground];
    CFTimeInterval duration = immediately ? 0.001 : self.hideDuration + (self.pieces.count - 1) * self.hideDelay;
    [self.background light:duration completion:nil];
}

- (void)finishHideAnimations
{
    if ([self isAnimating])
    {
        return;
    }
    self.boomState = VHBoomStateDidHide;
    if (self.boomDelegate && [self.boomDelegate respondsToSelector:@selector(onBoomDidHide)])
    {
        [self.boomDelegate onBoomDidHide];
    }
    self.background.hidden = YES;
    [self clearViews:NO];
}

- (void)startShowAnimations:(BOOL)immediately
{
    [self.background removeAllBoomButtons];
    [self calculateEndPositions];
    NSMutableArray<NSNumber *> *indexes;
    if (self.piecePlaceEnum == VHPiecePlaceShare)
    {
        indexes = [VHAnimationManager orderIndexes:VHOrderDefault inSize:self.pieces.count];
    }
    else
    {
        indexes = [VHAnimationManager orderIndexes:self.orderEnum inSize:self.pieces.count];
    }
    [indexes enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSNumber * _Nonnull indexObj, NSUInteger i, BOOL * _Nonnull stop) {
        int index = [indexObj intValue];
        VHBoomButton *boomButton = [self.boomButtons objectAtIndex:index];
        CGPoint startPosition = [[self.startPositions objectAtIndex:index] CGPointValue];
        CGPoint startPositionOfBoomButton = CGPointMake(startPosition.x, startPosition.y);
        [self putBoomButtonInBackground:boomButton withPosition:startPositionOfBoomButton];
        [self startEachShowAnimation:[self.pieces objectAtIndex:index]
                              button:boomButton
                       startPosition:startPositionOfBoomButton
                         endPosition:[[self.endPositions objectAtIndex:index] CGPointValue]
                         delayFactor:i
                         immediately:immediately];
    }];
}

- (void)startHideAnimation:(BOOL)immediately
{
    NSMutableArray<NSNumber *> *indexes;
    if (self.piecePlaceEnum == VHPiecePlaceShare)
    {
        indexes = [VHAnimationManager orderIndexes:VHOrderReverse inSize:self.pieces.count];
    }
    else
    {
        indexes = [VHAnimationManager orderIndexes:self.orderEnum inSize:self.pieces.count];
    }
    for (NSNumber *number in indexes)
    {
        [self.background bringSubviewToFront:[self.boomButtons objectAtIndex:[number integerValue]]];
    }
    [indexes enumerateObjectsUsingBlock:^(NSNumber * _Nonnull indexObj, NSUInteger i, BOOL * _Nonnull stop) {
        int index = [indexObj intValue];
        VHBoomButton *boomButton = [self.boomButtons objectAtIndex:index];
        CGPoint startPosition = [[self.startPositions objectAtIndex:index] CGPointValue];
        CGPoint startPositionOfBoomButton = CGPointMake(startPosition.x, startPosition.y);
        [self startEachHideAnimation:[self.pieces objectAtIndex:index]
                              button:boomButton
                       startPosition:[[self.endPositions objectAtIndex:index] CGPointValue]
                         endPosition:startPositionOfBoomButton
                         delayFactor:i
                         immediately:immediately];
    }];
}

- (void)startEachShowAnimation:(VHBoomPiece *)piece
                        button:(VHBoomButton *)boomButton
                 startPosition:(CGPoint)startPosition
                   endPosition:(CGPoint)endPosition
                   delayFactor:(NSUInteger)delayFactor
                   immediately:(BOOL)immediately
{
    self.animatingViewsNumber++;
    NSMutableArray *xs = [NSMutableArray arrayWithCapacity:self.frames + 1];
    NSMutableArray *ys = [NSMutableArray arrayWithCapacity:self.frames + 1];
    CGFloat scaleX = piece.frame.size.width / boomButton.contentWidth;
    CGFloat scaleY = piece.frame.size.height / boomButton.contentHeight;
    CFTimeInterval delay = immediately ? 0 : self.showDelay * delayFactor;
    CFTimeInterval duration = immediately ? 0.001 : self.showDuration;
    [boomButton setSelfScaleAnchorPoint];
    [boomButton setRotateAnchorPoints];
    [boomButton setAnchorPointOfLayer];
    [boomButton innerHiddenAllGoneViews];
    if (self.use3DTransformAnimation)
    {
        CGFloat buttonMaxHeight = [self buttonMaxHeight];
        CATransform3D transfrom3d = CATransform3DIdentity;
        transfrom3d.m34 = 1.0f / 500;
        boomButton.layer.transform = transfrom3d;
        boomButton.layer.zPosition = buttonMaxHeight * 10 - delayFactor * buttonMaxHeight;
    }
    boomButton.userInteractionEnabled = NO;
    [VHAnimationManager calculateShowXY:self.boomEnum
                             parentSize:self.background.bounds.size
                                   ease:self.showMoveEase
                                 frames:self.frames
                          startPosition:startPosition
                            endPosition:endPosition
                                xValues:xs
                                yValues:ys];
    
    DelayBlock block = ^{
        // onAnimationStart
        piece.hidden = YES;
        boomButton.hidden = NO;
        [boomButton willShow];
        if (self.piecePlaceEnum == VHPiecePlaceShare)
        {
            [self.shareLinesView pieceStartShowAnimation:delayFactor withDuration:immediately ? 0.001 : self.showDelay];
            piece.pieceBelow.hidden = NO;
        }
        
        [CATransaction begin];
        [CATransaction setCompletionBlock:^(void)
         {
             // onAnimationEnd
             boomButton.userInteractionEnabled = YES;
             [boomButton didShow];
             self.animatingViewsNumber--;
         }];
        
        if ([boomButton innerNeedsColorAnimation])
        {
            CABasicAnimation *fillColorAnimation = [VHAnimationManager showColorAnimateKeyPath:@"fillColor"
                                                                                         delay:0
                                                                                      duration:duration
                                                                                         start:[boomButton innerPieceColor]
                                                                                           end:[boomButton innerButtonColor]];
            [[boomButton innerButtonLayer] addAnimation:fillColorAnimation forKey:kFillColorAnimation];
        }
        else
        {
            [[boomButton innerButtonLayer] removeAnimationForKey:kFillColorAnimation];
        }
        
        CAKeyframeAnimation *xPositionAnimation = [VHAnimationManager animateKeyPath:@"position.x"
                                                                               delay:0
                                                                            duration:duration
                                                                              values:xs];
        xPositionAnimation.removedOnCompletion = YES;
        CAKeyframeAnimation *yPositionAnimation = [VHAnimationManager animateKeyPath:@"position.y"
                                                                               delay:0
                                                                            duration:duration
                                                                              values:ys];
        yPositionAnimation.removedOnCompletion = YES;
        CAKeyframeAnimation *rotateAnimation = [VHAnimationManager animateKeyPath:@"transform.rotation.z"
                                                                            delay:0
                                                                         duration:duration
                                                                             ease:self.showRotateEase
                                                                           frames:self.frames
                                                                            start:0
                                                                              end:self.rotateDegree];
        CAKeyframeAnimation *opacityAnimation = [VHAnimationManager animateKeyPath:@"opacity"
                                                                             delay:0
                                                                          duration:duration
                                                                            values:@[@(0), @(1)]];
        CAKeyframeAnimation *xScaleAnimation = [VHAnimationManager animateKeyPath:@"transform.scale.x"
                                                                            delay:0
                                                                         duration:duration
                                                                             ease:self.showScaleEase
                                                                           frames:self.frames
                                                                            start:scaleX
                                                                              end:1];
        CAKeyframeAnimation *yScaleAnimation = [VHAnimationManager animateKeyPath:@"transform.scale.y"
                                                                            delay:0
                                                                         duration:duration
                                                                             ease:self.showScaleEase
                                                                           frames:self.frames
                                                                            start:scaleY
                                                                              end:1];
        [VHAnimationManager addAnimations:boomButton, xPositionAnimation, yPositionAnimation, xScaleAnimation, yScaleAnimation, nil];
        [VHAnimationManager addAnimation:rotateAnimation toViews:boomButton.rotateViews];
        [VHAnimationManager addAnimation:opacityAnimation toViews:boomButton.goneViews];
        
        if (self.use3DTransformAnimation)
        {
//            CAKeyframeAnimation *rotateXAnimation = [VHAnimationManager rotateXAnimationFromFrames:self.frames startY:startPosition.y endY:endPosition.y delay:0 duration:duration];
//            CAKeyframeAnimation *rotateYAnimation = [VHAnimationManager rotateYAnimationFromFrames:self.frames startX:startPosition.x endX:endPosition.x delay:0 duration:duration];
            CAKeyframeAnimation *rotateXAnimation = [VHAnimationManager rotateXAnimationFromVelocity:ys delay:0 duration:duration];
            CAKeyframeAnimation *rotateYAnimation = [VHAnimationManager rotateYAnimationFromVelocity:xs delay:0 duration:duration];
            [VHAnimationManager addAnimations:boomButton, rotateXAnimation, rotateYAnimation, nil];
        }
        
        boomButton.frame = CGRectMake(endPosition.x - boomButton.centerPoint.x,
                                      endPosition.y - boomButton.centerPoint.y,
                                      boomButton.frame.size.width,
                                      boomButton.frame.size.height);
        
        [CATransaction commit];
    };
    [self delay:delay toBlock:block];
}

- (void)startEachHideAnimation:(VHBoomPiece *)piece
                        button:(VHBoomButton *)boomButton
                 startPosition:(CGPoint)startPosition
                   endPosition:(CGPoint)endPosition
                   delayFactor:(NSUInteger)delayFactor
                   immediately:(BOOL)immediately
{
    self.animatingViewsNumber++;
    NSMutableArray *xs = [NSMutableArray arrayWithCapacity:self.frames + 1];
    NSMutableArray *ys = [NSMutableArray arrayWithCapacity:self.frames + 1];
    CGFloat scaleX = piece.frame.size.width / boomButton.contentWidth;
    CGFloat scaleY = piece.frame.size.height / boomButton.contentHeight;
    CFTimeInterval delay = immediately ? 0 : self.hideDelay * delayFactor;
    CFTimeInterval duration = immediately ? 0.001 : self.hideDuration;
    [boomButton setSelfScaleAnchorPoint];
    [boomButton setRotateAnchorPoints];
    [boomButton setAnchorPointOfLayer];
    if (self.use3DTransformAnimation)
    {
        CATransform3D transfrom3d = CATransform3DIdentity;
        transfrom3d.m34 = 1.0f / 500;
        boomButton.layer.transform = transfrom3d;
    }
    boomButton.userInteractionEnabled = NO;
    [VHAnimationManager calculateHideXY:self.boomEnum
                             parentSize:self.background.bounds.size
                                   ease:self.hideMoveEase
                                 frames:self.frames
                          startPosition:startPosition
                            endPosition:endPosition
                                xValues:xs
                                yValues:ys];
    
    DelayBlock block = ^{
        // onAnimationStart
        [boomButton willHide];
        
        [CATransaction begin];
        [CATransaction setCompletionBlock:^(void)
         {
             // onAnimationEnd
             piece.hidden = NO;
             boomButton.hidden = YES;
             [boomButton didHide];
             [boomButton clearListener];
             self.animatingViewsNumber--;
             [self finishHideAnimations];
             
             if (self.piecePlaceEnum == VHPiecePlaceShare)
             {
                 [self.shareLinesView pieceFinishHideAnimation:[self innerPieceNumber] - delayFactor - 1 withDuration:immediately ? 0.001 : self.hideDelay];
                 piece.pieceBelow.hidden = YES;
             }
         }];
        
        if ([boomButton innerNeedsColorAnimation])
        {
            CABasicAnimation *fillColorAnimation = [VHAnimationManager hideColorAnimateKeyPath:@"fillColor"
                                                                                         delay:0
                                                                                      duration:duration
                                                                                         start:[boomButton innerButtonColor]
                                                                                           end:[boomButton innerPieceColor]];
            [[boomButton innerButtonLayer] addAnimation:fillColorAnimation forKey:kFillColorAnimation];
        }
        else
        {
            [[boomButton innerButtonLayer] removeAnimationForKey:kFillColorAnimation];
        }
        
        CAKeyframeAnimation *xPositionAnimation = [VHAnimationManager animateKeyPath:@"position.x"
                                                                               delay:0
                                                                            duration:duration
                                                                              values:xs];
        xPositionAnimation.removedOnCompletion = YES;
        CAKeyframeAnimation *yPositionAnimation = [VHAnimationManager animateKeyPath:@"position.y"
                                                                               delay:0
                                                                            duration:duration
                                                                              values:ys];
        yPositionAnimation.removedOnCompletion = YES;
        CAKeyframeAnimation *rotateAnimation = [VHAnimationManager animateKeyPath:@"transform.rotation.z"
                                                                            delay:0
                                                                         duration:duration
                                                                             ease:self.hideRotateEase
                                                                           frames:self.frames
                                                                            start:0
                                                                              end:-self.rotateDegree];
        CAKeyframeAnimation *opacityAnimation = [VHAnimationManager animateKeyPath:@"opacity"
                                                                             delay:0
                                                                          duration:duration
                                                                            values:@[@(1), @(0)]];
        CAKeyframeAnimation *xScaleAnimation = [VHAnimationManager animateKeyPath:@"transform.scale.x"
                                                                            delay:0
                                                                         duration:duration
                                                                             ease:self.hideScaleEase
                                                                           frames:self.frames
                                                                            start:1
                                                                              end:scaleX];
        CAKeyframeAnimation *yScaleAnimation = [VHAnimationManager animateKeyPath:@"transform.scale.y"
                                                                            delay:0
                                                                         duration:duration
                                                                             ease:self.hideScaleEase
                                                                           frames:self.frames
                                                                            start:1
                                                                              end:scaleY];
        [VHAnimationManager addAnimations:boomButton, xPositionAnimation, yPositionAnimation, xScaleAnimation, yScaleAnimation, nil];
        [VHAnimationManager addAnimation:rotateAnimation toViews:boomButton.rotateViews];
        [VHAnimationManager addAnimation:opacityAnimation toViews:boomButton.goneViews];
        
        if (self.use3DTransformAnimation)
        {
//            CAKeyframeAnimation *rotateXAnimation = [VHAnimationManager rotateXAnimationFromFrames:self.frames startY:startPosition.y endY:endPosition.y delay:0 duration:duration];
//            CAKeyframeAnimation *rotateYAnimation = [VHAnimationManager rotateYAnimationFromFrames:self.frames startX:startPosition.x endX:endPosition.x delay:0 duration:duration];
            CAKeyframeAnimation *rotateXAnimation = [VHAnimationManager rotateXAnimationFromVelocity:ys delay:0 duration:duration];
            CAKeyframeAnimation *rotateYAnimation = [VHAnimationManager rotateYAnimationFromVelocity:xs delay:0 duration:duration];
            [VHAnimationManager addAnimations:boomButton, rotateXAnimation, rotateYAnimation, nil];
        }
        
        boomButton.frame = CGRectMake(endPosition.x - boomButton.centerPoint.x,
                                      endPosition.y - boomButton.centerPoint.y,
                                      boomButton.frame.size.width,
                                      boomButton.frame.size.height);
        
        [CATransaction commit];
    };
    
    [self delay:delay toBlock:block];
}

#pragma mark - Support Methods

- (void)createBackground
{
    if (!self.background)
    {
        UIView *parentView = [self parentView];
        self.background = [[VHBackgroundView alloc] initWithFrame:CGRectMake(0, 0, parentView.bounds.size.width, parentView.bounds.size.height)];
        self.background.dimColor = self.dimColor;
        self.background.blurBackground = self.blurBackground;
        if ([UIBlurEffect class])
        {
            self.background.blurEffect = self.blurEffect;
        }
        self.background.delegate = self;
        if (self.tipLabel)
        {
            // tip-label has been set by developer
            self.background.tipLabel = self.tipLabel;
        }
        else
        {
            self.tipLabel = self.background.tipLabel;
        }
        self.background.tip = self.tip;
        [parentView addSubview:self.background];
    }
}

- (void)createButtons
{
    if (!self.needToCreateButtons)
    {
        return;
    }
    self.needToCreateButtons = NO;
    self.boomButtons = [NSMutableArray arrayWithCapacity:self.pieces.count];
    switch (self.buttonEnum)
    {
        case VHButtonSimpleCircle:
        {
            [self.boomButtonBuilders enumerateObjectsUsingBlock:^(VHBoomButtonBuilder * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                VHSimpleCircleButtonBuilder *builder = (VHSimpleCircleButtonBuilder *)obj;
                builder.innerIndex = idx;
                builder.innerListener = self;
                [self.boomButtons setObject:[builder innerBuild] atIndexedSubscript:idx];
                self.simpleCircleButtonRadius = builder.radius;
            }];
            break;
        }
        case VHButtonTextInsideCircle:
        {
            [self.boomButtonBuilders enumerateObjectsUsingBlock:^(VHBoomButtonBuilder * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                VHTextInsideCircleButtonBuilder *builder = (VHTextInsideCircleButtonBuilder *)obj;
                builder.innerIndex = idx;
                builder.innerListener = self;
                [self.boomButtons setObject:[builder innerBuild] atIndexedSubscript:idx];
                self.textInsideCircleButtonRadius = builder.radius;
            }];
            break;
        }
        case VHButtonTextOutsideCircle:
        {
            [self.boomButtonBuilders enumerateObjectsUsingBlock:^(VHBoomButtonBuilder * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                VHTextOutsideCircleButtonBuilder *builder = (VHTextOutsideCircleButtonBuilder *)obj;
                builder.innerIndex = idx;
                builder.innerListener = self;
                [self.boomButtons setObject:[builder innerBuild] atIndexedSubscript:idx];
                self.textOutsideCircleButtonWidth = builder.width;
                self.textOutsideCircleButtonHeight = builder.height;
            }];
            break;
        }
        case VHButtonHam:
        {
            [self.boomButtonBuilders enumerateObjectsUsingBlock:^(VHBoomButtonBuilder * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                VHHamButtonBuilder *builder = (VHHamButtonBuilder *)obj;
                builder.innerIndex = idx;
                builder.innerListener = self;
                [self.boomButtons setObject:[builder innerBuild] atIndexedSubscript:idx];
                self.hamButtonWidth = builder.width;
                self.hamButtonHeight = builder.height;
            }];
            break;
        }
        default:
            break;
    }
}

- (UIView *)parentView
{
    if (self.boomInWholeScreen)
    {
        return [[[UIApplication sharedApplication] delegate] window];
    }
    else
    {
        return [self superview];
    }
}

- (void)calculateStartPositions
{
    if (!self.needToCalculateStartPositions && !self.inList) return;
    self.needToCalculateStartPositions = NO;
    
    long pieceNumber = [self innerPieceNumber];
    self.startPositions = [NSMutableArray arrayWithCapacity:pieceNumber];
    UIView *parentView = [self parentView];
    
    [self.pieces enumerateObjectsUsingBlock:^(VHBoomPiece * _Nonnull piece, NSUInteger idx, BOOL * _Nonnull stop) {
        CGPoint bmbPosition = [self convertPoint:CGPointZero toView:parentView];
        CGPoint piecePositionInBmb = [[self.piecePositions objectAtIndex:idx] CGRectValue].origin;
        CGFloat pieceCenterInParentViewX = bmbPosition.x + piecePositionInBmb.x + piece.frame.size.width / 2;
        CGFloat pieceCenterInParentViewY = bmbPosition.y + piecePositionInBmb.y + piece.frame.size.height / 2;
        CGPoint pieceCenterInParentView = CGPointMake(pieceCenterInParentViewX, pieceCenterInParentViewY);
        [self.startPositions addObject:[NSValue valueWithCGPoint:pieceCenterInParentView]];
    }];
}

- (void)calculateEndPositions
{
    switch (self.buttonEnum) {
        case VHButtonSimpleCircle:
            self.endPositions = [VHButtonPlaceManager positionsWithEnum:self.buttonPlaceEnum
                                                          withAlignment:self.buttonPlaceAlignmentEnum
                                                        withParentFrame:[self parentView].bounds
                                                       withButtonRadius:self.simpleCircleButtonRadius
                                                       withButtonNumber:self.boomButtonBuilders.count
                                             withButtonHorizontalMargin:self.buttonHorizontalMargin
                                               withButtonInclinedMargin:self.buttonInclinedMargin
                                               withButtonVerticalMargin:self.buttonVerticalMargin
                                                    withButtonTopMargin:self.buttonTopMargin
                                                 withButtonBottomMargin:self.buttonBottomMargin
                                                   withButtonLeftMargin:self.buttonLeftMargin
                                                  withButtonRightMargin:self.buttonRightMargin];
            break;
        case VHButtonTextInsideCircle:
            self.endPositions = [VHButtonPlaceManager positionsWithEnum:self.buttonPlaceEnum
                                                          withAlignment:self.buttonPlaceAlignmentEnum
                                                        withParentFrame:[self parentView].bounds
                                                       withButtonRadius:self.textInsideCircleButtonRadius
                                                       withButtonNumber:self.boomButtonBuilders.count
                                             withButtonHorizontalMargin:self.buttonHorizontalMargin
                                               withButtonInclinedMargin:self.buttonInclinedMargin
                                               withButtonVerticalMargin:self.buttonVerticalMargin
                                                    withButtonTopMargin:self.buttonTopMargin
                                                 withButtonBottomMargin:self.buttonBottomMargin
                                                   withButtonLeftMargin:self.buttonLeftMargin
                                                  withButtonRightMargin:self.buttonRightMargin];
            break;
        case VHButtonTextOutsideCircle:
            self.endPositions = [VHButtonPlaceManager positionsWithEnum:self.buttonPlaceEnum
                                                          withAlignment:self.buttonPlaceAlignmentEnum
                                                        withParentFrame:[self parentView].bounds
                                                        withButtonWidth:self.textOutsideCircleButtonWidth
                                                       withButtonHeight:self.textOutsideCircleButtonHeight
                                                       withButtonNumber:self.boomButtonBuilders.count
                                             withButtonHorizontalMargin:self.buttonHorizontalMargin
                                               withButtonInclinedMargin:self.buttonInclinedMargin
                                               withButtonVerticalMargin:self.buttonVerticalMargin
                                                    withButtonTopMargin:self.buttonTopMargin
                                                 withButtonBottomMargin:self.buttonBottomMargin
                                                   withButtonLeftMargin:self.buttonLeftMargin
                                                  withButtonRightMargin:self.buttonRightMargin];
            break;
        case VHButtonHam:
            self.endPositions = [VHButtonPlaceManager positionsForHamWithEnum:self.buttonPlaceEnum
                                                                withAlignment:self.buttonPlaceAlignmentEnum
                                                              withParentFrame:[self parentView].bounds
                                                              withButtonWidth:self.hamButtonWidth
                                                             withButtonHeight:self.hamButtonHeight
                                                             withButtonNumber:self.boomButtonBuilders.count
                                                   withButtonHorizontalMargin:self.buttonHorizontalMargin
                                                     withButtonVerticalMargin:self.buttonVerticalMargin
                                                          withButtonTopMargin:self.buttonTopMargin
                                                       withButtonBottomMargin:self.buttonBottomMargin
                                                         withButtonLeftMargin:self.buttonLeftMargin
                                                        withButtonRightMargin:self.buttonRightMargin
                                                  withLastButtonMarginMoreTop:self.bottomHamButtonTopMargin > 0
                                                      withLastButtonTopMargin:self.bottomHamButtonTopMargin];
            break;
        default:
            break;
    }
    
}

- (VHBoomButton *)putBoomButtonInBackground:(VHBoomButton *)button withPosition:(CGPoint)position
{
    [self createBackground];
    button.frame = CGRectMake(position.x,
                              position.y,
                              button.frame.size.width,
                              button.frame.size.height);
    button.hidden = YES;
    [self.background addSubview:button];
    return button;
}

- (void)clearViews:(BOOL)force
{
    if (force || !self.cacheOptimization || self.inList)
    {
        [self.background removeAllBoomButtons];
        [self.background removeFromSuperview];
        self.background = nil;
        [self clearButtons];
    }
}

- (int)innerPieceNumber
{
    if (self.piecePlaceEnum == VHPiecePlaceUnknown)
    {
        return 0;
    }
    else if (self.piecePlaceEnum == VHPiecePlaceShare)
    {
        return (int)self.boomButtonBuilders.count;
    }
    else
    {
        return (int)[VHPiecePlaceManager pieceNumber:self.piecePlaceEnum];
    }
}

- (void)placeShareLinesView
{
    if (self.piecePlaceEnum != VHPiecePlaceShare)
    {
        return;
    }
    if (self.shareLinesView)
    {
        [self.shareLinesView removeFromSuperview];
    }
    self.shareLinesView = [[VHShareLinesView alloc] initWithFrame:self.bounds];
    self.shareLinesView.backgroundColor = [UIColor clearColor];
    self.shareLinesView.line1Color = self.shareLine1Color;
    self.shareLinesView.line2Color = self.shareLine2Color;
    self.shareLinesView.lineWidth = self.shareLineWidth;
    [self addSubview:self.shareLinesView];
}

- (void)setShareLinesViewData
{
    if (self.piecePlaceEnum != VHPiecePlaceShare)
    {
        return;
    }
    [self.shareLinesView setPiecePositions:self.piecePositions
                                 dotRadius:self.dotRadius
                                 showDelay:self.showDelay
                              showDuration:self.showDuration
                                 hideDelay:self.hideDelay
                              hideDuration:self.hideDuration];
}

- (BOOL)uninitializedBoomButtons
{
    return self.buttonEnum == VHButtonUnknown || self.piecePlaceEnum == VHPiecePlaceUnknown || self.buttonPlaceEnum == VHButtonPlaceUnknown;
}

- (void)delay:(CFTimeInterval)delay toBlock:(DelayBlock)block
{
    if (delay == 0)
    {
        block();
    }
    else
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            block();
        });
    }
}

- (BOOL)needToDrawShadow
{
    return _backgroundEffect && _shadowEffect;
}

- (void)clearButtons
{
    self.needToCreateButtons = YES;
    for (VHBoomButton *button in self.boomButtons)
    {
        [button removeFromSuperview];
    }
    [self.boomButtons removeAllObjects];
}

- (CGFloat)buttonMaxHeight
{
    switch (self.buttonEnum)
    {
        case VHButtonSimpleCircle: return self.simpleCircleButtonRadius * 2;
        case VHButtonTextInsideCircle: return self.textInsideCircleButtonRadius * 2;
        case VHButtonTextOutsideCircle: return self.textOutsideCircleButtonHeight;
        case VHButtonHam: return self.hamButtonHeight;
        case VHButtonUnknown: return 0;
    }
    return 0;
}

- (void)preventDragOutside
{
    BOOL needToAdjustFrame = NO;
    CGRect newFrame = self.frame;
    
    if (newFrame.origin.x < self.edgeInsetsInSuperView.left)
    {
        newFrame.origin.x = self.edgeInsetsInSuperView.left;
        needToAdjustFrame = YES;
    }
    
    if (newFrame.origin.y < self.edgeInsetsInSuperView.top)
    {
        newFrame.origin.y = self.edgeInsetsInSuperView.top;
        needToAdjustFrame = YES;
    }
    
    if (newFrame.origin.x + newFrame.size.width > self.superview.frame.size.width - self.edgeInsetsInSuperView.right)
    {
        newFrame.origin.x = self.superview.frame.size.width - newFrame.size.width - self.edgeInsetsInSuperView.right;
        needToAdjustFrame = YES;
    }
    
    if (newFrame.origin.y + newFrame.size.height > self.superview.frame.size.height - self.edgeInsetsInSuperView.bottom)
    {
        newFrame.origin.y = self.superview.frame.size.height - newFrame.size.height - self.edgeInsetsInSuperView.bottom;
        needToAdjustFrame = YES;
    }
    
    if (needToAdjustFrame)
    {
        [UIView animateWithDuration:0.3
                              delay:0
             usingSpringWithDamping:0.6
              initialSpringVelocity:0.5
                            options:UIViewAnimationOptionLayoutSubviews
                         animations:^{
                             [self setFrame:newFrame];
                         } completion:nil];
    }
}

- (void)adjustTipLabel
{
    [self.background adjustTipLabel:self.tipBelowButtons
                withTipButtonMargin:self.tipButtonMargin
                    withEndPosition:self.endPositions
                   withButtonHeight:[self buttonMaxHeight]];
}

- (void)checkAutoBoom
{
    if (self.autoBoomImmediately)
    {
        [self boomImmediately];
    }
    else if (self.autoBoom)
    {
        [self boom];
    }
    self.autoBoom = NO;
    self.autoBoomImmediately = NO;
}

#pragma mark - Device Orientation

- (void)deviceOrientationDidChange:(NSNotification *)notification
{
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    if (orientation != self.lastDeviceOrientation)
    {
        self.background.frame = [self parentView].bounds;
        self.needToCalculateStartPositions = YES;
        [self calculateStartPositions];
        [self calculateEndPositions];
        switch (self.boomState)
        {
            case VHBoomStateDidHide:
                
                break;
            case VHBoomStateDidShow:
                [self placeButtons];
                [self adjustTipLabel];
                break;
            case VHBoomStateWillShow:
            case VHBoomStateWillHide:
                [self stopAllAnimations:self.boomState == VHBoomStateWillShow];
                [self placeButtons];
                [self adjustTipLabel];
                break;
        }
    }
    self.lastDeviceOrientation = orientation;
}

- (void)placeButtons
{
    [self.boomButtons enumerateObjectsUsingBlock:^(VHBoomButton * _Nonnull button, NSUInteger idx, BOOL * _Nonnull stop) {
        CGPoint endPosition = [[self.endPositions objectAtIndex:idx] CGPointValue];
        button.frame = CGRectMake(endPosition.x - button.centerPoint.x,
                                  endPosition.y - button.centerPoint.y,
                                  button.frame.size.width,
                                  button.frame.size.height);
    }];
}

- (void)stopAllAnimations:(BOOL)isShowAnimation
{
    [self.background removeAllAnimations];
    [self.boomButtons enumerateObjectsUsingBlock:^(VHBoomButton * _Nonnull button, NSUInteger idx, BOOL * _Nonnull stop) {
        [button innerStopAnimations];
        if (isShowAnimation)
        {
            [button innerVisibleAllGoneViews];
        }
        else
        {
            [button innerHiddenAllGoneViews];
        }
    }];
}

#pragma mark - Builders

- (void)addBuilder:(VHBoomButtonBuilder *)builder
{
    [self.boomButtonBuilders addObject:builder];
    [self setNeedsLayout];
}

- (void)setBuilder:(VHBoomButtonBuilder *)builder at:(NSUInteger)index
{
    [self.boomButtonBuilders setObject:builder atIndexedSubscript:index];
    [self setNeedsLayout];
}

- (void)setBuilders:(NSMutableArray<VHBoomButtonBuilder *> *)builders
{
    self.boomButtonBuilders = builders;
    [self setNeedsLayout];
}

- (VHBoomButtonBuilder *)builder:(NSUInteger)index
{
    return [self.boomButtonBuilders objectAtIndex:index];
}

- (void)removeBuilder:(VHBoomButtonBuilder *)builder
{
    [self.boomButtonBuilders removeObject:builder];
    [self setNeedsLayout];
}

- (void)removeBuilderAtIndex:(NSUInteger)index
{
    [self.boomButtonBuilders removeObjectAtIndex:index];
    [self setNeedsLayout];
}

- (void)clearBuilders
{
    [self.boomButtonBuilders removeAllObjects];
}

#pragma mark - On Button Clicked

- (void)onButton:(VHBoomButton *)boomButton clickedAt:(int)index
{
    if ([self.boomDelegate respondsToSelector:@selector(onBoomButton:clickedAt:)])
    {
        [self.boomDelegate onBoomButton:boomButton clickedAt:index];
    }
    if (self.autoHide)
    {
        [self reboom];
    }
}

#pragma mark - On Background Clicked

- (void)onBackgroundClick
{
    if (self.animatingViewsNumber != 0)
    {
        return;
    }
    if ([self.boomDelegate respondsToSelector:@selector(onBoomBackgroundClicked)])
    {
        [self.boomDelegate onBoomBackgroundClicked];
    }
    if (self.cancelable)
    {
        [self reboom];
    }
}

#pragma mark - Add Views toBackground

- (void)addViewToBackground:(UIView *)view
{
    [self createBackground];
    [self.background addGoneView:view];
}

- (UILabel *)tipLabel
{
    if (!self.background.tipLabel)
    {
        _tipLabel = [UILabel new];
    }
    return _tipLabel;
}

#pragma mark - Setters

#pragma mark Basic

#pragma mark Shadow

- (void)setShadowEffect:(BOOL)shadowEffect
{
    if (_shadowEffect == shadowEffect)
    {
        return;
    }
    _shadowEffect = shadowEffect;
    if (_backgroundEffect)
    {
        [self setNeedsDisplay];
    }
}

- (void)setShadowPathRect:(CGRect)shadowPathRect
{
    if (CGRectEqualToRect(_shadowPathRect, shadowPathRect))
    {
        return;
    }
    _shadowPathRect = shadowPathRect;
    if ([self needToDrawShadow])
    {
        [self setNeedsDisplay];
    }
}

- (void)setShadowOffsetX:(CGFloat)shadowOffsetX
{
    if (_shadowOffsetX == shadowOffsetX)
    {
        return;
    }
    _shadowOffsetX = shadowOffsetX;
    if ([self needToDrawShadow])
    {
        [self setNeedsDisplay];
    }
}

- (void)setShadowOffsetY:(CGFloat)shadowOffsetY
{
    if (_shadowOffsetY == shadowOffsetY)
    {
        return;
    }
    _shadowOffsetY = shadowOffsetY;
    if ([self needToDrawShadow])
    {
        [self setNeedsDisplay];
    }
}

- (void)setShadowRadius:(CGFloat)shadowRadius
{
    if (_shadowRadius == shadowRadius)
    {
        return;
    }
    _shadowRadius = shadowRadius;
    if ([self needToDrawShadow])
    {
        [self setNeedsDisplay];
    }
}

- (void)setShadowColor:(UIColor *)shadowColor
{
    if ([VHUtils sameColor:_shadowColor asColor:shadowColor])
    {
        return;
    }
    _shadowColor = shadowColor;
    if ([self needToDrawShadow])
    {
        [self setNeedsDisplay];
    }
}

#pragma mark Button

- (void)setButtonEnum:(VHButtonEnum)buttonEnum
{
    if (_buttonEnum == buttonEnum)
    {
        return;
    }
    _buttonEnum = buttonEnum;
    [self clearPieces];
    [self clearBuilders];
    [self clearButtons];
//    [self setNeedsLayout];
    [self setNeedsDisplay];
}

- (void)setBackgroundEffect:(BOOL)backgroundEffect
{
    if (_backgroundEffect == backgroundEffect)
    {
        return;
    }
    _backgroundEffect = backgroundEffect;
    [self setNeedsDisplay];
}

- (void)setNormalColor:(UIColor *)normalColor
{
    if ([VHUtils sameColor:_normalColor asColor:normalColor])
    {
        return;
    }
    _normalColor = normalColor;
    if (_backgroundEffect)
    {
        [self setNeedsDisplay];
    }
}

- (void)setHighlightedColor:(UIColor *)highlightedColor
{
    if ([VHUtils sameColor:_highlightedColor asColor:highlightedColor])
    {
        return;
    }
    _highlightedColor = highlightedColor;
    if (_backgroundEffect)
    {
        [self setNeedsDisplay];
    }
}

- (void)setUnableColor:(UIColor *)unableColor
{
    if ([VHUtils sameColor:_unableColor asColor:unableColor])
    {
        return;
    }
    _unableColor = unableColor;
    if (_backgroundEffect)
    {
        [self setNeedsDisplay];
    }
}

- (void)setUserInteractionEnabled:(BOOL)userInteractionEnabled
{
    [super setUserInteractionEnabled:userInteractionEnabled];
    if (!userInteractionEnabled)
    {
        [self toUnable];
    }
    else
    {
        [self toNormal];
    }
}

- (void)setEdgeInsetsInSuperView:(UIEdgeInsets)edgeInsetsInSuperView
{
    if (UIEdgeInsetsEqualToEdgeInsets(_edgeInsetsInSuperView, edgeInsetsInSuperView))
    {
        return;
    }
    _edgeInsetsInSuperView = edgeInsetsInSuperView;
    [self preventDragOutside];
}

#pragma mark Piece

- (void)setDotRadius:(CGFloat)dotRadius
{
    if (_dotRadius == dotRadius)
    {
        return;
    }
    _dotRadius = dotRadius;
    self.needToCalculateStartPositions = YES;
    [self setNeedsLayout];
}

- (void)setHamWidth:(CGFloat)hamWidth
{
    if (_hamWidth == hamWidth)
    {
        return;
    }
    _hamWidth = hamWidth;
    self.needToCalculateStartPositions = YES;
    [self setNeedsLayout];
}

- (void)setHamHeight:(CGFloat)hamHeight
{
    if (_hamHeight == hamHeight)
    {
        return;
    }
    _hamHeight = hamHeight;
    self.needToCalculateStartPositions = YES;
    [self setNeedsLayout];
}

- (void)setPieceCornerRadius:(CGFloat)pieceCornerRadius
{
    if (_pieceCornerRadius == pieceCornerRadius)
    {
        return;
    }
    _pieceCornerRadius = pieceCornerRadius;
    [self setNeedsLayout];
}

- (void)setPieceHorizontalMargin:(CGFloat)pieceHorizontalMargin
{
    if (_pieceHorizontalMargin == pieceHorizontalMargin)
    {
        return;
    }
    _pieceHorizontalMargin = pieceHorizontalMargin;
    self.needToCalculateStartPositions = YES;
    [self setNeedsLayout];
}

- (void)setPieceVerticalMargin:(CGFloat)pieceVerticalMargin
{
    if (_pieceVerticalMargin == pieceVerticalMargin)
    {
        return;
    }
    _pieceVerticalMargin = pieceVerticalMargin;
    self.needToCalculateStartPositions = YES;
    [self setNeedsLayout];
}

- (void)setPieceInclinedMargin:(CGFloat)pieceInclinedMargin
{
    if (_pieceInclinedMargin == _pieceInclinedMargin)
    {
        return;
    }
    _pieceInclinedMargin = pieceInclinedMargin;
    [self setNeedsLayout];
}

- (void)setPiecePlaceEnum:(VHPiecePlaceEnum)piecePlaceEnum
{
    if (_piecePlaceEnum == piecePlaceEnum)
    {
        return;
    }
    _piecePlaceEnum = piecePlaceEnum;
    [self clearPieces];
    self.needToCalculateStartPositions = YES;
//    [self setNeedsLayout];
}

#pragma mark Background

- (void)setBlurBackground:(BOOL)blurBackground
{
    if (_blurBackground == blurBackground)
    {
        return;
    }
    if (blurBackground)
    {
        if ([UIVisualEffectView class])
        {
            self.background.blurBackground = _blurBackground = blurBackground;
        }
    }
    else
    {
        self.background.blurBackground = _blurBackground = blurBackground;
    }
}

- (void)setBlurEffect:(UIBlurEffect *)blurEffect NS_AVAILABLE_IOS(8_0)
{
    if ([_blurEffect isEqual:blurEffect])
    {
        return;
    }
    self.background.blurEffect = _blurEffect = blurEffect;
}

- (void)setDimColor:(UIColor *)dimColor
{
    if ([VHUtils sameColor:_dimColor asColor:dimColor])
    {
        return;
    }
    _dimColor = dimColor;
    if (self.boomState == VHBoomStateDidShow)
    {
        self.background.backgroundColor = dimColor;
    }
}

- (void)setTip:(NSString *)tip
{
    if ([_tip isEqualToString:tip])
    {
        return;
    }
    self.background.tip = _tip = tip;
}

- (void)setTipBelowButtons:(BOOL)tipBelowButtons
{
    if (_tipBelowButtons == tipBelowButtons)
    {
        return;
    }
    _tipBelowButtons = tipBelowButtons;
    [self adjustTipLabel];
}

- (void)setTipButtonMargin:(CGFloat)tipButtonMargin
{
    if (_tipButtonMargin == tipButtonMargin)
    {
        return;
    }
    _tipButtonMargin = tipButtonMargin;
    [self adjustTipLabel];
}

#pragma mark Animation

- (void)setDelay:(CFTimeInterval)delay
{
    if (_delay == delay)
    {
        return;
    }
    _delay = delay;
    [self setShowDelay:delay];
    [self setHideDelay:delay];
}

- (void)setDuration:(CFTimeInterval)duration
{
    if (_duration == duration)
    {
        return;
    }
    _duration = duration;
    [self setShowDuration:duration];
    [self setHideDuration:duration];
}

- (void)setShowDuration:(CFTimeInterval)showDuration
{
    if (_showDuration == showDuration)
    {
        return;
    }
    _showDuration = showDuration;
    if (_showDuration <= 0)
    {
        _showDuration = 0.001;
    }
}

- (void)setHideDuration:(CFTimeInterval)hideDuration
{
    if (_hideDuration == hideDuration)
    {
        return;
    }
    _hideDuration = hideDuration;
    if (_hideDuration <= 0)
    {
        _hideDuration = 0.001;
    }
}

- (void)setShowEaseName:(NSString *)showEaseName
{
    if ([_showEaseName isEqualToString:showEaseName])
    {
        return;
    }
    _showEaseName = showEaseName;
    [self setShowMoveEaseName:showEaseName];
    [self setShowRotateEaseName:showEaseName];
    [self setShowScaleEaseName:showEaseName];
}

- (void)setShowMoveEaseName:(NSString *)showMoveEaseName
{
    if ([_showMoveEaseName isEqualToString:showMoveEaseName])
    {
        return;
    }
    _showMoveEaseName = showMoveEaseName;
    self.showMoveEase = [VHEase easeWithName:_showMoveEaseName];
}

- (void)setShowRotateEaseName:(NSString *)showRotateEaseName
{
    if ([_showRotateEaseName isEqualToString:showRotateEaseName])
    {
        return;
    }
    _showRotateEaseName = showRotateEaseName;
    self.showRotateEase = [VHEase easeWithName:_showRotateEaseName];
}

- (void)setShowScaleEaseName:(NSString *)showScaleEaseName
{
    if ([_showScaleEaseName isEqualToString:showScaleEaseName])
    {
        return;
    }
    _showScaleEaseName = showScaleEaseName;
    self.showScaleEase = [VHEase easeWithName:showScaleEaseName];
}

- (void)setHideEaseName:(NSString *)hideEaseName
{
    if ([_hideEaseName isEqualToString:hideEaseName])
    {
        return;
    }
    _hideEaseName = hideEaseName;
    [self setHideMoveEaseName:_hideEaseName];
    [self setHideRotateEaseName:_hideEaseName];
    [self setHideScaleEaseName:_hideEaseName];
}

- (void)setHideMoveEaseName:(NSString *)hideMoveEaseName
{
    if ([_hideMoveEaseName isEqualToString:hideMoveEaseName])
    {
        return;
    }
    _hideMoveEaseName = hideMoveEaseName;
    self.hideMoveEase = [VHEase easeWithName:_hideMoveEaseName];
}

- (void)setHideRotateEaseName:(NSString *)hideRotateEaseName
{
    if ([_hideRotateEaseName isEqualToString:hideRotateEaseName])
    {
        return;
    }
    _hideRotateEaseName = hideRotateEaseName;
    self.hideRotateEase = [VHEase easeWithName:_hideRotateEaseName];
}

- (void)setHideScaleEaseName:(NSString *)hideScaleEaseName
{
    if ([_hideScaleEaseName isEqualToString:hideScaleEaseName])
    {
        return;
    }
    _hideScaleEaseName = hideScaleEaseName;
    self.hideScaleEase = [VHEase easeWithName:_hideScaleEaseName];
}

#pragma mark Boom Buttons

- (void)setButtonPlaceEnum:(VHButtonPlaceEnum)buttonPlaceEnum
{
    if (_buttonPlaceEnum == buttonPlaceEnum)
    {
        return;
    }
    _buttonPlaceEnum = buttonPlaceEnum;
    [self clearButtons];
    self.needToCalculateStartPositions = YES;
//    [self setNeedsLayout];
}

@end
