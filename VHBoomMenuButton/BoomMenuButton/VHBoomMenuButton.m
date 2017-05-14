//
//  VHBoomMenuButton.m
//  VHBoomMenuExample
//
//  Created by Nightonke on 16/7/28.
//  Copyright © 2016 Nightonke. All rights reserved.
//

#import "VHBoomMenuButton.h"
#include <stdlib.h>
#import "VHAnimationManager.h"
#import "VHBoomStateEnum.h"
#import "VHBoomButtonDelegate.h"
#import "VHShareLinesView.h"
#import "VHBackgroundDelegate.h"
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
static NSString *const kBoomButtonAnimation = @"kBoomButtonAnimation";
static NSString *const kBoomButton3DAnimation = @"kBoomButton3DAnimation";
static NSString *const kBoomButtonRotateViewAnimation = @"kBoomButtonRotateViewAnimation";
static NSString *const kBoomButtonGoneViewAnimation = @"kBoomButtonGoneViewAnimation";
static NSString *const kFadeViewAnimation = @"kFadeViewAnimation";

@interface VHBoomMenuButton ()<VHBoomButtonDelegate, VHBackgroundDelegate>

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

#pragma mark - Fade Views

@property (nonatomic, strong) NSMutableArray<UIView *> *fadeViews;

@end

@implementation VHBoomMenuButton

#pragma mark - Convenience Methods

+ (int)pieceNumber:(VHPiecePlaceEnum)piecePlaceEnum
{
    return [VHPiecePlaceManager pieceNumber:piecePlaceEnum];
}

+ (int)minPieceNumber:(VHPiecePlaceEnum)piecePlaceEnum
{
    return [VHPiecePlaceManager minPieceNumber:piecePlaceEnum];
}

+ (int)maxPieceNumber:(VHPiecePlaceEnum)piecePlaceEnum
{
    return [VHPiecePlaceManager maxPieceNumber:piecePlaceEnum];
}

+ (int)buttonNumber:(VHButtonPlaceEnum)buttonPlaceEnum
{
    return [VHButtonPlaceManager buttonNumber:buttonPlaceEnum];
}

+ (int)minButtonNumber:(VHButtonPlaceEnum)buttonPlaceEnum
{
    return [VHButtonPlaceManager minButtonNumber:buttonPlaceEnum];
}

+ (int)maxButtonNumber:(VHButtonPlaceEnum)buttonPlaceEnum
{
    return [VHButtonPlaceManager maxButtonNumber:buttonPlaceEnum];
}

- (int)pieceNumber
{
    return [VHBoomMenuButton pieceNumber:self.piecePlaceEnum];
}

- (int)minPieceNumber
{
    return [VHBoomMenuButton minPieceNumber:self.piecePlaceEnum];
}

- (int)maxPieceNumber
{
    return [VHBoomMenuButton maxPieceNumber:self.piecePlaceEnum];
}

- (int)buttonNumber
{
    return [VHBoomMenuButton buttonNumber:self.buttonPlaceEnum];
}

- (int)minButtonNumber
{
    return [VHBoomMenuButton minButtonNumber:self.buttonPlaceEnum];
}

- (int)maxButtonNumber
{
    return [VHBoomMenuButton maxButtonNumber:self.buttonPlaceEnum];
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
    _cacheOptimized = YES;
    _isBoomInWholeScreen = YES;
    _isInList = NO;
    
    _hasShadow = YES;
    _shadowPathRect = CGRectMake(2, 2, self.frame.size.width - 4, self.frame.size.height - 4);
    _shadowOffsetX = 0;
    _shadowOffsetY = 8;
    _shadowRadius = 4;
    _shadowColor = [VHUtils colorFromARGB:0x44000000];
    
    _buttonEnum = VHButtonUnknown;
    _hasBackground = YES;
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
    _customPiecePositions = [NSMutableArray array];
    
    _backgroundBlurred = NO;
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
    _boomDelay = 0.05;
    _boomDuration = 0.3;
    _reboomDelay = 0.05;
    _reboomDuration = 0.3;
    _cancelable = YES;
    _autoHide = YES;
    _orderEnum = VHOrderRandom;
    _frames = 60;
    _boomEnum = VHBoomHorizontalThrow2;
    _boomEaseName = VHEaseOutBack;
    _boomMoveEaseName = VHEaseOutBack;
    _boomScaleEaseName = VHEaseOutBack;
    _boomRotateEaseName = VHEaseOutBack;
    _reboomEaseName = VHEaseInBack;
    _reboomMoveEaseName = VHEaseInBack;
    _reboomScaleEaseName = VHEaseInBack;
    _reboomRotateEaseName = VHEaseInBack;
    _rotateDegree = M_PI * 4;
    _use3DTransformAnimation = YES;
    _autoBoom = NO;
    _autoBoomImmediately = NO;
    
    _buttonPlaceEnum = VHButtonPlaceUnknown;
    _customButtonPositions = [NSMutableArray array];
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
    _boomMoveEase = [VHEase easeWithName:_boomMoveEaseName];
    _boomScaleEase = [VHEase easeWithName:_boomScaleEaseName];
    _boomRotateEase = [VHEase easeWithName:_boomRotateEaseName];
    _reboomMoveEase = [VHEase easeWithName:_reboomMoveEaseName];
    _reboomScaleEase = [VHEase easeWithName:_reboomScaleEaseName];
    _reboomRotateEase = [VHEase easeWithName:_reboomRotateEaseName];
    _boomState = VHBoomStateDidReboom;
    
    _boomButtonBuilders = [NSMutableArray array];
    
    _needToCalculateStartPositions = YES;
    _needToCreateButtons = YES;
    
    _lastDeviceOrientation = [[UIDevice currentDevice] orientation];
    
    _fadeViews = [NSMutableArray array];
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
    if (self.hasBackground == YES && !self.isInList)
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

        if (self.hasShadow)
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
    if ([self uninitializedBoomButtons])
    {
        return;
    }
    [self placeFadeViews];
    [self clearPieces];
    [self createPieces];
    [self placeShareLinesView];
    [self placePieces];
    [self calculateStartPositions:NO];
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
    self.pieces = [NSMutableArray array];
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
        indexes = [VHAnimationManager orderIndexes:VHOrderInOrder inSize:self.pieces.count];
    }
    else
    {
        indexes = [VHAnimationManager orderIndexes:self.orderEnum inSize:self.pieces.count];
    }
    [indexes enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSNumber * _Nonnull indexObj, NSUInteger i, BOOL * _Nonnull stop) {
        int index = [indexObj intValue];
        [self addSubview:[self.pieces objectAtIndex:index]];
        if (self.boomState != VHBoomStateDidReboom)
        {
            [self.pieces objectAtIndex:index].hidden = YES;
        }
        
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
                self.piecePositions = [VHPiecePlaceManager shareDotPositionsWithDotNumber:self.boomButtonBuilders.count
                                                                       withBoomMenuButton:self];
            }
            else
            {
                self.piecePositions = [VHPiecePlaceManager dotPositions:self];
            }
            break;
        }
        case VHButtonHam:
            self.piecePositions = [VHPiecePlaceManager hamPositions:self];
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
        self.frame = CGRectMake(touchLocationInParent.x - self.startPositionX,
                                touchLocationInParent.y - self.startPositionY,
                                self.frame.size.width,
                                self.frame.size.height);
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

- (BOOL)isBoomed
{
    return self.boomState == VHBoomStateDidBoom;
}

- (BOOL)isReboomed
{
    return self.boomState == VHBoomStateDidReboom;
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
    if ([self isAnimating] || self.boomState != VHBoomStateDidReboom)
    {
        return;
    }
    [VHErrorManager judge:self withBuilders:self.boomButtonBuilders];
    self.boomState = VHBoomStateWillBoom;
    if (self.boomDelegate && [self.boomDelegate respondsToSelector:@selector(boomMenuButtonWillBoom:)])
    {
        [self.boomDelegate boomMenuButtonWillBoom:self];
    }
    [self calculateStartPositions:NO];
    [self createButtons];
    [self dimBackground:immediately];
    [self startBoomAnimations:immediately];
    [self startBoomAnimationForFadeViews:immediately];
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
    if ([self isAnimating] || self.boomState != VHBoomStateDidBoom)
    {
        return;
    }
    self.boomState = VHBoomStateWillReboom;
    if (self.boomDelegate && [self.boomDelegate respondsToSelector:@selector(boomMenuButtonWillReboom:)])
    {
        [self.boomDelegate boomMenuButtonWillReboom:self];
    }
    [self lightBackground:immediately];
    [self startReboomAnimation:immediately];
    [self startReboomAnimationForFadeViews:immediately];
}

- (void)dimBackground:(BOOL)immediately
{
    [self createBackground];
    CFTimeInterval duration = immediately ? 0.001 : self.boomDuration + (self.pieces.count - 1) * self.boomDelay;
    [self.background dim:duration completion:^(BOOL finished) {
        self.boomState = VHBoomStateDidBoom;
        if (self.boomDelegate && [self.boomDelegate respondsToSelector:@selector(boomMenuButtonDidBoom:)])
        {
            [self.boomDelegate boomMenuButtonDidBoom:self];
        }
    }];
}

- (void)lightBackground:(BOOL)immediately
{
    [self createBackground];
    CFTimeInterval duration = immediately ? 0.001 : self.reboomDuration + (self.pieces.count - 1) * self.reboomDelay;
    [self.background light:duration completion:nil];
}

- (void)finishReboomAnimations
{
    if ([self isAnimating])
    {
        return;
    }
    self.boomState = VHBoomStateDidReboom;
    if (self.boomDelegate && [self.boomDelegate respondsToSelector:@selector(boomMenuButtonDidReboom:)])
    {
        [self.boomDelegate boomMenuButtonDidReboom:self];
    }
    self.background.hidden = YES;
    [self clearViews:NO];
}

- (void)startBoomAnimations:(BOOL)immediately
{
    [self.background removeAllBoomButtons];
    [self calculateEndPositions];
    NSMutableArray<NSNumber *> *indexes;
    if (self.piecePlaceEnum == VHPiecePlaceShare)
    {
        indexes = [VHAnimationManager orderIndexes:VHOrderInOrder inSize:self.pieces.count];
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
        [self placeBoomButtonInBackground:boomButton withPosition:startPositionOfBoomButton];
        [self startEachBoomAnimation:[self.pieces objectAtIndex:index]
                              button:boomButton
                       startPosition:startPositionOfBoomButton
                         endPosition:[[self.endPositions objectAtIndex:index] CGPointValue]
                         delayFactor:i
                         immediately:immediately];
    }];
}

- (void)startReboomAnimation:(BOOL)immediately
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
    [indexes enumerateObjectsUsingBlock:^(NSNumber * _Nonnull indexObj, NSUInteger i, BOOL * _Nonnull stop) {
        int index = [indexObj intValue];
        VHBoomButton *boomButton = [self.boomButtons objectAtIndex:index];
        CGPoint startPosition = [[self.startPositions objectAtIndex:index] CGPointValue];
        CGPoint startPositionOfBoomButton = CGPointMake(startPosition.x, startPosition.y);
        [self startEachReboomAnimation:[self.pieces objectAtIndex:index]
                                button:boomButton
                         startPosition:[[self.endPositions objectAtIndex:index] CGPointValue]
                           endPosition:startPositionOfBoomButton
                           delayFactor:i
                           immediately:immediately];
    }];
}

- (void)startEachBoomAnimation:(VHBoomPiece *)piece
                        button:(VHBoomButton *)boomButton
                 startPosition:(CGPoint)startPosition
                   endPosition:(CGPoint)endPosition
                   delayFactor:(NSUInteger)delayFactor
                   immediately:(BOOL)immediately
{
    self.animatingViewsNumber++;
    NSMutableArray *xs = [NSMutableArray arrayWithCapacity:self.frames + 1];
    NSMutableArray *ys = [NSMutableArray arrayWithCapacity:self.frames + 1];
    CGFloat scaleX = piece.frame.size.width / boomButton.buttonWidth;
    CGFloat scaleY = piece.frame.size.height / boomButton.buttonHeight;
    CFTimeInterval delay = immediately ? 0 : self.boomDelay * delayFactor;
    CFTimeInterval duration = immediately ? 0.001 : self.boomDuration;
    [boomButton setRotateAnchorPoints];
    [boomButton setAnchorPointOfLayer];
    [boomButton innerHideAllGoneViews];
    boomButton.userInteractionEnabled = NO;
    CGFloat buttonMaxHeight = [self buttonMaxHeight];
    boomButton.layer.zPosition = buttonMaxHeight * (self.boomButtons.count + 1) - delayFactor * buttonMaxHeight;
    if (self.use3DTransformAnimation)
    {
        CATransform3D transform3d = CATransform3DIdentity;
        transform3d.m34 = 1.0f / 500;
        boomButton.layer.transform = transform3d;
    }
    [VHAnimationManager calculateBoomXY:self.boomEnum
                             parentSize:self.background.bounds.size
                                   ease:self.boomMoveEase
                                 frames:self.frames
                          startPosition:startPosition
                            endPosition:endPosition
                                xValues:xs
                                yValues:ys];
    
    DelayBlock block = ^{
        // onAnimationStart
        piece.hidden = YES;
        boomButton.hidden = NO;
        [boomButton willBoom];
        if (self.piecePlaceEnum == VHPiecePlaceShare)
        {
            [self.shareLinesView pieceStartShowAnimation:delayFactor withDuration:immediately ? 0.001 : self.boomDelay];
            piece.pieceBelow.hidden = NO;
        }
        
        [CATransaction begin];
        [CATransaction setCompletionBlock:^(void)
         {
             // onAnimationEnd
             boomButton.userInteractionEnabled = YES;
             [boomButton didBoom];
             self.animatingViewsNumber--;
         }];
        
        if ([boomButton innerNeedsColorAnimation])
        {
            CABasicAnimation *fillColorAnimation = [VHAnimationManager boomColorAnimateKeyPath:@"fillColor"
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
                                                                             ease:self.boomRotateEase
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
                                                                             ease:self.boomScaleEase
                                                                           frames:self.frames
                                                                            start:scaleX
                                                                              end:1];
        CAKeyframeAnimation *yScaleAnimation = [VHAnimationManager animateKeyPath:@"transform.scale.y"
                                                                            delay:0
                                                                         duration:duration
                                                                             ease:self.boomScaleEase
                                                                           frames:self.frames
                                                                            start:scaleY
                                                                              end:1];
        [VHAnimationManager addAnimations:boomButton forKey:kBoomButtonAnimation, xPositionAnimation, yPositionAnimation, xScaleAnimation, yScaleAnimation, nil];
        [VHAnimationManager addAnimation:rotateAnimation forKey:kBoomButtonRotateViewAnimation toViews:boomButton.rotateViews];
        [VHAnimationManager addAnimation:opacityAnimation forKey:kBoomButtonGoneViewAnimation toViews:boomButton.goneViews];
        
        if (self.use3DTransformAnimation)
        {
//            CAKeyframeAnimation *rotateXAnimation = [VHAnimationManager rotateXAnimationFromFrames:self.frames startY:startPosition.y endY:endPosition.y delay:0 duration:duration];
//            CAKeyframeAnimation *rotateYAnimation = [VHAnimationManager rotateYAnimationFromFrames:self.frames startX:startPosition.x endX:endPosition.x delay:0 duration:duration];
            CAKeyframeAnimation *rotateXAnimation = [VHAnimationManager rotateXAnimationFromVelocity:ys delay:0 duration:duration];
            CAKeyframeAnimation *rotateYAnimation = [VHAnimationManager rotateYAnimationFromVelocity:xs delay:0 duration:duration];
            [VHAnimationManager addAnimations:boomButton forKey:kBoomButton3DAnimation, rotateXAnimation, rotateYAnimation, nil];
        }
        
        boomButton.frame = CGRectMake(endPosition.x - boomButton.centerPoint.x,
                                      endPosition.y - boomButton.centerPoint.y,
                                      boomButton.frame.size.width,
                                      boomButton.frame.size.height);
        
        [CATransaction commit];
    };
    [self delay:delay toBlock:block];
}

- (void)startEachReboomAnimation:(VHBoomPiece *)piece
                          button:(VHBoomButton *)boomButton
                   startPosition:(CGPoint)startPosition
                     endPosition:(CGPoint)endPosition
                     delayFactor:(NSUInteger)delayFactor
                     immediately:(BOOL)immediately
{
    self.animatingViewsNumber++;
    NSMutableArray *xs = [NSMutableArray arrayWithCapacity:self.frames + 1];
    NSMutableArray *ys = [NSMutableArray arrayWithCapacity:self.frames + 1];
    CGFloat scaleX = piece.frame.size.width / boomButton.buttonWidth;
    CGFloat scaleY = piece.frame.size.height / boomButton.buttonHeight;
    CFTimeInterval delay = immediately ? 0 : self.reboomDelay * delayFactor;
    CFTimeInterval duration = immediately ? 0.001 : self.reboomDuration;
    [boomButton setRotateAnchorPoints];
    [boomButton setAnchorPointOfLayer];
    boomButton.userInteractionEnabled = NO;
    CGFloat buttonMaxHeight = [self buttonMaxHeight];
    boomButton.layer.zPosition = (delayFactor + 1) * buttonMaxHeight;
    if (self.use3DTransformAnimation)
    {
        CATransform3D transform3d = CATransform3DIdentity;
        transform3d.m34 = 1.0f / 500;
        boomButton.layer.transform = transform3d;
    }
    [VHAnimationManager calculateReboomXY:self.boomEnum
                               parentSize:self.background.bounds.size
                                     ease:self.reboomMoveEase
                                   frames:self.frames
                            startPosition:startPosition
                              endPosition:endPosition
                                  xValues:xs
                                  yValues:ys];
    
    DelayBlock block = ^{
        // onAnimationStart
        [boomButton willReboom];
        
        [CATransaction begin];
        [CATransaction setCompletionBlock:^(void)
         {
             // onAnimationEnd
             piece.hidden = NO;
             boomButton.hidden = YES;
             [boomButton didReboom];
             [boomButton clearListener];
             self.animatingViewsNumber--;
             [self finishReboomAnimations];
             
             if (self.piecePlaceEnum == VHPiecePlaceShare)
             {
                 [self.shareLinesView pieceFinishHideAnimation:[self innerPieceNumber] - delayFactor - 1
                                                  withDuration:immediately ? 0.001 : self.reboomDelay];
                 piece.pieceBelow.hidden = YES;
             }
         }];
        
        if ([boomButton innerNeedsColorAnimation])
        {
            CABasicAnimation *fillColorAnimation = [VHAnimationManager reboomColorAnimateKeyPath:@"fillColor"
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
                                                                             ease:self.reboomRotateEase
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
                                                                             ease:self.reboomScaleEase
                                                                           frames:self.frames
                                                                            start:1
                                                                              end:scaleX];
        CAKeyframeAnimation *yScaleAnimation = [VHAnimationManager animateKeyPath:@"transform.scale.y"
                                                                            delay:0
                                                                         duration:duration
                                                                             ease:self.reboomScaleEase
                                                                           frames:self.frames
                                                                            start:1
                                                                              end:scaleY];
        [VHAnimationManager addAnimations:boomButton forKey:kBoomButtonAnimation, xPositionAnimation, yPositionAnimation, xScaleAnimation, yScaleAnimation, nil];
        [VHAnimationManager addAnimation:rotateAnimation forKey:kBoomButtonRotateViewAnimation toViews:boomButton.rotateViews];
        [VHAnimationManager addAnimation:opacityAnimation forKey:kBoomButtonGoneViewAnimation toViews:boomButton.goneViews];
        
        if (self.use3DTransformAnimation)
        {
//            CAKeyframeAnimation *rotateXAnimation = [VHAnimationManager rotateXAnimationFromFrames:self.frames startY:startPosition.y endY:endPosition.y delay:0 duration:duration];
//            CAKeyframeAnimation *rotateYAnimation = [VHAnimationManager rotateYAnimationFromFrames:self.frames startX:startPosition.x endX:endPosition.x delay:0 duration:duration];
            CAKeyframeAnimation *rotateXAnimation = [VHAnimationManager rotateXAnimationFromVelocity:ys delay:0 duration:duration];
            CAKeyframeAnimation *rotateYAnimation = [VHAnimationManager rotateYAnimationFromVelocity:xs delay:0 duration:duration];
            [VHAnimationManager addAnimations:boomButton forKey:kBoomButton3DAnimation, rotateXAnimation, rotateYAnimation, nil];
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
        self.background.backgroundBlurred = self.backgroundBlurred;
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
    if (self.boomState == VHBoomStateDidReboom)
    {
        self.background.hidden = YES;
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
                builder.innerIndex = (int)idx;
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
                builder.innerIndex = (int)idx;
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
                builder.innerIndex = (int)idx;
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
                builder.innerIndex = (int)idx;
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
    if (self.isBoomInWholeScreen)
    {
        return [[[UIApplication sharedApplication] delegate] window];
    }
    else
    {
        return [self superview];
    }
}

- (void)calculateStartPositions:(BOOL)force
{
    if (!force && !self.needToCalculateStartPositions && !self.isInList) return;
    if (!force)
    {
        self.needToCalculateStartPositions = NO;
    }
    
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
            self.endPositions = [VHButtonPlaceManager positionsWithParentFrame:[self parentView].bounds
                                                              withButtonRadius:self.simpleCircleButtonRadius
                                                              withButtonNumber:self.boomButtonBuilders.count
                                                            withBoomMenuButton:self];
            break;
        case VHButtonTextInsideCircle:
            self.endPositions = [VHButtonPlaceManager positionsWithParentFrame:[self parentView].bounds
                                                              withButtonRadius:self.textInsideCircleButtonRadius
                                                              withButtonNumber:self.boomButtonBuilders.count
                                                            withBoomMenuButton:self];
            break;
        case VHButtonTextOutsideCircle:
            self.endPositions = [VHButtonPlaceManager positionsWithParentFrame:[self parentView].bounds
                                                               withButtonWidth:self.textOutsideCircleButtonWidth
                                                              withButtonHeight:self.textOutsideCircleButtonHeight
                                                              withButtonNumber:self.boomButtonBuilders.count
                                                            withBoomMenuButton:self];
            break;
        case VHButtonHam:
            self.endPositions = [VHButtonPlaceManager positionsWithParentFrame:[self parentView].bounds
                                                               withButtonWidth:self.hamButtonWidth
                                                              withButtonHeight:self.hamButtonHeight
                                                              withButtonNumber:self.boomButtonBuilders.count
                                                            withBoomMenuButton:self];
            break;
        default:
            break;
    }
    
}

- (VHBoomButton *)placeBoomButtonInBackground:(VHBoomButton *)button withPosition:(CGPoint)position
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
    if (force || !self.cacheOptimized || self.isInList)
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
    else if (self.piecePlaceEnum == VHPiecePlaceCustom)
    {
        return (int)self.customPiecePositions.count;
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
    if (self.boomState != VHBoomStateDidReboom)
    {
        self.shareLinesView.alpha = 0;
    }
}

- (void)setShareLinesViewData
{
    if (self.piecePlaceEnum != VHPiecePlaceShare)
    {
        return;
    }
    [self.shareLinesView setPiecePositions:self.piecePositions dotRadius:self.dotRadius];
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
    return self.hasBackground && self.hasShadow;
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
    
    if (newFrame.origin.x + newFrame.size.width > self.superview.bounds.size.width - self.edgeInsetsInSuperView.right)
    {
        newFrame.origin.x = self.superview.bounds.size.width - newFrame.size.width - self.edgeInsetsInSuperView.right;
        needToAdjustFrame = YES;
    }
    
    if (newFrame.origin.y + newFrame.size.height > self.superview.bounds.size.height - self.edgeInsetsInSuperView.bottom)
    {
        newFrame.origin.y = self.superview.bounds.size.height - newFrame.size.height - self.edgeInsetsInSuperView.bottom;
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
        [self calculateStartPositions:YES];
        [self calculateEndPositions];
        switch (self.boomState)
        {
            case VHBoomStateDidReboom:
                break;
            case VHBoomStateDidBoom:
                [self placeButtons];
                [self adjustTipLabel];
                break;
            case VHBoomStateWillBoom:
            case VHBoomStateWillReboom:
                [self stopAllAnimations:self.boomState == VHBoomStateWillBoom];
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

- (void)stopAllAnimations:(BOOL)isBoomAnimation
{
    [self.background removeAllAnimations];
    [self.boomButtons enumerateObjectsUsingBlock:^(VHBoomButton * _Nonnull button, NSUInteger idx, BOOL * _Nonnull stop) {
        [button innerStopAnimations];
        if (isBoomAnimation)
        {
            [button innerShowAllGoneViews];
        }
        else
        {
            [button innerHideAllGoneViews];
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

- (VHBoomButton *)boomButtonAtIndex:(NSUInteger)index
{
    if (index < self.boomButtons.count)
    {
        return [self.boomButtons objectAtIndex:index];
    }
    return nil;
}

#pragma mark - On Button Clicked

- (void)onButton:(VHBoomButton *)boomButton clickedAt:(int)index
{
    if ([self.boomDelegate respondsToSelector:@selector(boomMenuButton:didClickBoomButtonOfBuilder:at:)])
    {
        [self.boomDelegate boomMenuButton:self didClickBoomButtonOfBuilder:[self.boomButtonBuilders objectAtIndex:index] at:index];
    }
    if (self.autoHide)
    {
        [self reboom];
    }
}

#pragma mark - On Background Clicked

- (void)backgroundDidClick
{
    if (self.isAnimating)
    {
        return;
    }
    if ([self.boomDelegate respondsToSelector:@selector(boomMenuButtonDidClickBackground:)])
    {
        [self.boomDelegate boomMenuButtonDidClickBackground:self];
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

- (void)removeViewFromBackground:(UIView *)view
{
    [self createBackground];
    [self.background removeGoneView:view];
}

- (UILabel *)tipLabel
{
    if (!self.background.tipLabel)
    {
        _tipLabel = [UILabel new];
    }
    return _tipLabel;
}

#pragma mark - Fade Views

- (void)placeFadeViews
{
    for (UIView *view in self.fadeViews)
    {
        [view removeFromSuperview];
        [self addSubview:view];
        if (self.boomState != VHBoomStateDidReboom)
        {
            view.alpha = 0;
        }
    }
}

- (void)addFadeView:(UIView *)view
{
    if (!view)
    {
        return;
    }
    [self.fadeViews addObject:view];
    [self addSubview:view];
}

- (void)removeFadeView:(UIView *)view
{
    if (!view)
    {
        return;
    }
    [self.fadeViews removeObject:view];
    [view removeFromSuperview];
}

- (void)clearFadeViews
{
    for (UIView *view in self.fadeViews)
    {
        [view removeFromSuperview];
    }
    [self.fadeViews removeAllObjects];
}

- (void)startBoomAnimationForFadeViews:(BOOL)immediately
{
    CFTimeInterval duration = immediately ? 0.001 : self.boomDuration + (self.pieces.count - 1) * self.boomDelay;
    CAAnimation *opacityAnimation = [VHAnimationManager fadeViewsOpacityAnimation:YES duration:duration];
    [VHAnimationManager addAnimation:opacityAnimation forKey:kFadeViewAnimation toViews:self.fadeViews];
}

- (void)startReboomAnimationForFadeViews:(BOOL)immediately
{
    CFTimeInterval duration = immediately ? 0.001 : self.reboomDuration + (self.pieces.count - 1) * self.reboomDelay;
    CAAnimation *opacityAnimation = [VHAnimationManager fadeViewsOpacityAnimation:NO duration:duration];
    [VHAnimationManager addAnimation:opacityAnimation forKey:kFadeViewAnimation toViews:self.fadeViews];
}

#pragma mark - Setters

#pragma mark Basic

#pragma mark Shadow

- (void)setHasShadow:(BOOL)hasShadow
{
    if (_hasShadow == hasShadow)
    {
        return;
    }
    _hasShadow = hasShadow;
    if (_hasBackground)
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

- (void)setHasBackground:(BOOL)hasBackground
{
    if (_hasBackground == hasBackground)
    {
        return;
    }
    _hasBackground = hasBackground;
    [self setNeedsDisplay];
}

- (void)setNormalColor:(UIColor *)normalColor
{
    if ([VHUtils sameColor:_normalColor asColor:normalColor])
    {
        return;
    }
    _normalColor = normalColor;
    if (_hasBackground)
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
    if (_hasBackground)
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
    if (_hasBackground)
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
    if (_pieceInclinedMargin == pieceInclinedMargin)
    {
        return;
    }
    _pieceInclinedMargin = pieceInclinedMargin;
    [self setNeedsLayout];
}

- (void)setShareLineLength:(CGFloat)shareLineLength
{
    if (_shareLineLength == shareLineLength)
    {
        return;
    }
    _shareLineLength = shareLineLength;
    [self setNeedsLayout];
}

- (void)setShareLine1Color:(UIColor *)shareLine1Color
{
    if ([VHUtils sameColor:_shareLine1Color asColor:shareLine1Color])
    {
        return;
    }
    _shareLine1Color = shareLine1Color;
    [self setNeedsLayout];
}

- (void)setShareLine2Color:(UIColor *)shareLine2Color
{
    if ([VHUtils sameColor:_shareLine2Color asColor:shareLine2Color])
    {
        return;
    }
    _shareLine2Color = shareLine2Color;
    [self setNeedsLayout];
}

- (void)setShareLineWidth:(CGFloat)shareLineWidth
{
    if (_shareLineWidth == shareLineWidth)
    {
        return;
    }
    _shareLineWidth = shareLineWidth;
    [self setNeedsLayout];
}

- (void)setPiecePlaceEnum:(VHPiecePlaceEnum)piecePlaceEnum
{
    // We have to clear pieces because the pieces may be changed even though the piece-place-enum is still the same
    _piecePlaceEnum = piecePlaceEnum;
    [self clearPieces];
    self.needToCalculateStartPositions = YES;
}

#pragma mark Background

- (void)setBackgroundBlurred:(BOOL)backgroundBlurred
{
    if (_backgroundBlurred == backgroundBlurred)
    {
        return;
    }
    if (backgroundBlurred)
    {
        if ([UIVisualEffectView class])
        {
            self.background.backgroundBlurred = _backgroundBlurred = backgroundBlurred;
        }
    }
    else
    {
        self.background.backgroundBlurred = _backgroundBlurred = backgroundBlurred;
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
    if (self.boomState == VHBoomStateDidBoom)
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
    [self setBoomDelay:delay];
    [self setReboomDelay:delay];
}

- (void)setDuration:(CFTimeInterval)duration
{
    if (_duration == duration)
    {
        return;
    }
    _duration = duration;
    [self setBoomDuration:duration];
    [self setReboomDuration:duration];
}

- (void)setBoomDuration:(CFTimeInterval)boomDuration
{
    if (_boomDuration == boomDuration)
    {
        return;
    }
    _boomDuration = boomDuration;
    if (_boomDuration <= 0)
    {
        _boomDuration = 0.001;
    }
}

- (void)setReboomDuration:(CFTimeInterval)reboomDuration
{
    if (_reboomDuration == reboomDuration)
    {
        return;
    }
    _reboomDuration = reboomDuration;
    if (_reboomDuration <= 0)
    {
        _reboomDuration = 0.001;
    }
}

- (void)setBoomEaseName:(NSString *)boomEaseName
{
    if ([_boomEaseName isEqualToString:boomEaseName])
    {
        return;
    }
    _boomEaseName = boomEaseName;
    [self setBoomMoveEaseName:boomEaseName];
    [self setBoomRotateEaseName:boomEaseName];
    [self setBoomScaleEaseName:boomEaseName];
}

- (void)setBoomEase:(id<VHTimeInterpolator>)boomEase
{
    if ([_boomEase isEqual:boomEase])
    {
        return;
    }
    _boomEase = boomEase;
    [self setBoomMoveEase:boomEase];
    [self setBoomRotateEase:boomEase];
    [self setBoomScaleEase:boomEase];
}

- (void)setBoomMoveEaseName:(NSString *)boomMoveEaseName
{
    if ([_boomMoveEaseName isEqualToString:boomMoveEaseName])
    {
        return;
    }
    _boomMoveEaseName = boomMoveEaseName;
    self.boomMoveEase = [VHEase easeWithName:_boomMoveEaseName];
}

- (void)setBoomMoveEase:(id<VHTimeInterpolator>)boomMoveEase
{
    if ([_boomMoveEase isEqual:boomMoveEase])
    {
        return;
    }
    _boomMoveEase = boomMoveEase;
}

- (void)setBoomRotateEaseName:(NSString *)boomRotateEaseName
{
    if ([_boomRotateEaseName isEqualToString:boomRotateEaseName])
    {
        return;
    }
    _boomRotateEaseName = boomRotateEaseName;
    self.boomRotateEase = [VHEase easeWithName:_boomRotateEaseName];
}

- (void)setBoomRotateEase:(id<VHTimeInterpolator>)boomRotateEase
{
    if ([_boomRotateEase isEqual:boomRotateEase])
    {
        return;
    }
    _boomRotateEase = boomRotateEase;
}

- (void)setBoomScaleEaseName:(NSString *)boomScaleEaseName
{
    if ([_boomScaleEaseName isEqualToString:boomScaleEaseName])
    {
        return;
    }
    _boomScaleEaseName = boomScaleEaseName;
    self.boomScaleEase = [VHEase easeWithName:boomScaleEaseName];
}

- (void)setBoomScaleEase:(id<VHTimeInterpolator>)boomScaleEase
{
    if ([_boomScaleEase isEqual:boomScaleEase])
    {
        return;
    }
    _boomScaleEase = boomScaleEase;
}

- (void)setReboomEaseName:(NSString *)reboomEaseName
{
    if ([_reboomEaseName isEqualToString:reboomEaseName])
    {
        return;
    }
    _reboomEaseName = reboomEaseName;
    [self setReboomMoveEaseName:_reboomEaseName];
    [self setReboomRotateEaseName:_reboomEaseName];
    [self setReboomScaleEaseName:_reboomEaseName];
}

- (void)setReboomEase:(id<VHTimeInterpolator>)reboomEase
{
    if ([_reboomEase isEqual:reboomEase])
    {
        return;
    }
    _reboomEase = reboomEase;
    [self setReboomMoveEase:reboomEase];
    [self setReboomRotateEase:reboomEase];
    [self setReboomScaleEase:reboomEase];
}

- (void)setReboomMoveEaseName:(NSString *)reboomMoveEaseName
{
    if ([_reboomMoveEaseName isEqualToString:reboomMoveEaseName])
    {
        return;
    }
    _reboomMoveEaseName = reboomMoveEaseName;
    self.reboomMoveEase = [VHEase easeWithName:_reboomMoveEaseName];
}

- (void)setReboomMoveEase:(id<VHTimeInterpolator>)reboomMoveEase
{
    if ([_reboomMoveEase isEqual:reboomMoveEase])
    {
        return;
    }
    _reboomMoveEase = reboomMoveEase;
}

- (void)setReboomRotateEaseName:(NSString *)reboomRotateEaseName
{
    if ([_reboomRotateEaseName isEqualToString:reboomRotateEaseName])
    {
        return;
    }
    _reboomRotateEaseName = reboomRotateEaseName;
    self.reboomRotateEase = [VHEase easeWithName:_reboomRotateEaseName];
}

- (void)setReboomRotateEase:(id<VHTimeInterpolator>)reboomRotateEase
{
    if ([_reboomRotateEase isEqual:reboomRotateEase])
    {
        return;
    }
    _reboomRotateEase = reboomRotateEase;
}

- (void)setReboomScaleEaseName:(NSString *)reboomScaleEaseName
{
    if ([_reboomScaleEaseName isEqualToString:reboomScaleEaseName])
    {
        return;
    }
    _reboomScaleEaseName = reboomScaleEaseName;
    self.reboomScaleEase = [VHEase easeWithName:_reboomScaleEaseName];
}

- (void)setReboomScaleEase:(id<VHTimeInterpolator>)reboomScaleEase
{
    if ([_reboomScaleEase isEqual:reboomScaleEase])
    {
        return;
    }
    _reboomScaleEase = reboomScaleEase;
}

#pragma mark Boom Buttons

- (void)setButtonPlaceEnum:(VHButtonPlaceEnum)buttonPlaceEnum
{
    // We have to clear pieces because the buttons may be changed even though the button-place-enum is still the same
    _buttonPlaceEnum = buttonPlaceEnum;
    [self clearButtons];
    self.needToCalculateStartPositions = YES;
}

@end
