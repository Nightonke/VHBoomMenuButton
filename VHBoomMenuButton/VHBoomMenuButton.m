//
//  VHBoomMenuButton.m
//  VHBoomMenuExample
//
//  Created by 黄伟平 on 16/7/28.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import "VHBoomMenuButton.h"
#include <stdlib.h>

@interface VHBoomMenuButton ()

@property (nonatomic, strong) NSMutableArray<NSValue *> *piecePositions;
@property (nonatomic, assign) CGFloat startPositionX;
@property (nonatomic, assign) CGFloat startPositionY;
@property (nonatomic, assign) BOOL    ableToStartDragging;
@property (nonatomic, assign) BOOL    isDragging;
@property (nonatomic, assign) CGFloat simpleCircleButtonRadius;
@property (nonatomic, assign) CGFloat textInsideCircleButtonRadius;
@property (nonatomic, assign) CGFloat textOutsideCircleButtonWidth;
@property (nonatomic, assign) CGFloat textOutsideCircleButtonHeight;
@property (nonatomic, assign) CGFloat hamButtonWidth;
@property (nonatomic, assign) CGFloat hamButtonHeight;
@property (nonatomic, assign) BOOL    needToAdjustTextOutsideCircleButtonHeightError;

@end

@implementation VHBoomMenuButton

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.shadowRadius               = frame.size.width / 2 + DEFAULT_BOOM_MENU_BUTTON_SHADOW_WIDTH;
        self.shadowOffset               = CGSizeMake(DEFAULT_BOOM_MENU_BUTTON_SHADOW_OFFSET_X, DEFAULT_BOOM_MENU_BUTTON_SHADOW_OFFSET_Y);
        self.shadowOpacity              = DEFAULT_BOOM_MENU_BUTTON_SHADOW_OPACITY;
        self.shadowColor                = DEFAULT_BOOM_MENU_BUTTON_SHADOW_COLOR;

        self.dotRadius                  = DEFAULT_BOOM_MENU_BUTTON_DOT_RADIUS;
        self.hamWidth                   = DEFAULT_BOOM_MENU_BUTTON_HAM_WIDTH;
        self.hamHeight                  = DEFAULT_BOOM_MENU_BUTTON_HAM_HEIGHT;

        self.buttonNormalColor          = DEFAULT_BOOM_MENU_BUTTON_NORMAL_COLOR;
        self.buttonPressedColor         = DEFAULT_BOOM_MENU_BUTTON_PRESSED_COLOR;

        self.buttonPlaceAlignmentEnum   = DEFAULT_BOOM_MENU_BUTTON_PLACE_ALIGNMENT;
        self.showOrderEnum              = DEFAULT_BOOM_MENU_BUTTON_SHOW_ORDER;
        self.hideOrderEnum              = DEFAULT_BOOM_MENU_BUTTON_HIDE_ORDER;
        self.boomEnum                   = DEFAULT_BOOM_MENU_BUTTON_BOOM_ENUM;

        self.showMoveEaseEnum           = DEFAULT_BOOM_MENU_BUTTON_SHOW_MOVE_EASE_ENUM;
        self.showScaleEaseEnum          = DEFAULT_BOOM_MENU_BUTTON_SHOW_SCALE_EASE_ENUM;
        self.showRotateEaseEnum         = DEFAULT_BOOM_MENU_BUTTON_SHOW_ROTATE_EASE_ENUM;
        self.hideMoveEaseEnum           = DEFAULT_BOOM_MENU_BUTTON_HIDE_MOVE_EASE_ENUM;
        self.hideScaleEaseEnum          = DEFAULT_BOOM_MENU_BUTTON_HIDE_SCALE_EASE_ENUM;
        self.hideRotateEaseEnum         = DEFAULT_BOOM_MENU_BUTTON_HIDE_ROTATE_EASE_ENUM;

        self.dimColor                   = DEFAULT_BOOM_MENU_BUTTON_DIM_COLOR;
        self.autoHide                   = DEFAULT_BOOM_MENU_BUTTON_AUTO_HIDE;
        self.cancelable                 = DEFAULT_BOOM_MENU_BUTTON_CANCELABLE;
        self.noBackground               = DEFAULT_BOOM_MENU_BUTTON_NO_BACKGROUND;
        self.draggable                  = DEFAULT_BOOM_MENU_BUTTON_DRAGGABLE;
        self.frames                     = DEFAULT_BOOM_MENU_BUTTON_FRAMES;
        self.duration                   = DEFAULT_BOOM_MENU_BUTTON_DURATION;
        self.delay                      = DEFAULT_BOOM_MENU_BUTTON_DELAY;
        self.rotationDegree             = DEFAULT_BOOM_MENU_BUTTON_ROTATION_DEGREE;

        self.buttonHorizontalMargin     = DEFAULT_BOOM_MENU_BUTTON_HORIZONTAL_MARGIN;
        self.buttonVerticalMargin       = DEFAULT_BOOM_MENU_BUTTON_VERTICAL_MARGIN;
        self.buttonInclinedMargin       = DEFAULT_BOOM_MENU_BUTTON_INCLINED_MARGIN;
        self.buttonBottomMargin         = DEFAULT_BOOM_MENU_BUTTON_BOTTOM_MARGIN;
        self.buttonTopMargin            = DEFAULT_BOOM_MENU_BUTTON_TOP_MARGIN;
        self.buttonLeftMargin           = DEFAULT_BOOM_MENU_BUTTON_LEFT_MARGIN;
        self.buttonRightMargin          = DEFAULT_BOOM_MENU_BUTTON_RIGHT_MARGIN;
        self.pieceHorizontalMargin      = DEFAULT_BOOM_MENU_BUTTON_PIECE_HORIZONTAL_MARGIN;
        self.pieceVerticalMargin        = DEFAULT_BOOM_MENU_BUTTON_PIECE_VERTICAL_MARGIN;
        self.pieceInclinedMargin        = DEFAULT_BOOM_MENU_BUTTON_PIECE_INCLINED_MARGIN;
        self.lastHamButtonMarginMoreTop = DEFAULT_BOOM_MENU_BUTTON_LAST_HAM_BUTTON_MARGIN_MORE_TOP;
        self.lastHamButtonTopMargin     = DEFAULT_BOOM_MENU_BUTTON_LAST_HAM_BUTTOM_TOP_MARGIN;

        self.boomButtonBuilders         = [NSMutableArray array];

        self.backgroundColor            = [UIColor clearColor];

        self.ableToStartDragging        = NO;
        self.isDragging                 = NO;

        self.animatingViewsNumber       = 0;
    }
    return self;
}

/**
 *  Draw the background, notice that we don't need to draw it if we don't even need a background
 *
 *  @param rect The rect
 */
- (void)drawRect:(CGRect)rect
{
    if (self.noBackground == NO)
    {
        self.buttonCircle        = [CAShapeLayer layer];
        [self.buttonCircle setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0,
                                                                                      0,
                                                                                      self.frame.size.width,
                                                                                      self.frame.size.height)] CGPath]];
        [self.buttonCircle setFillColor:self.buttonNormalColor.CGColor];
        [[self layer] addSublayer:self.buttonCircle];

        CGRect shadowRect        = CGRectMake(0, 0, self.shadowRadius * 2, self.shadowRadius * 2);
        UIBezierPath *shadowPath = [UIBezierPath bezierPathWithOvalInRect:shadowRect];
        self.layer.masksToBounds = NO;
        self.layer.shadowColor   = self.shadowColor.CGColor;
        CGSize shadowOffset      = CGSizeMake(self.shadowOffset.width - (self.shadowRadius - self.frame.size.width / 2),
                                         self.shadowOffset.height - (self.shadowRadius - self.frame.size.height / 2));
        self.layer.shadowOffset  = shadowOffset;
        self.layer.shadowOpacity = self.shadowOpacity;
        self.layer.shadowPath    = shadowPath.CGPath;
    }
    else
    {
        [self.buttonCircle removeFromSuperlayer];
        self.layer.shadowOpacity = 0.0f;
    }
}

#pragma mark - Place Dots, Bars or Blocks

/**
 *  Layout all the pieces.
 */
- (void)layoutSubviews
{
    [self removePieces];

    [super layoutSubviews];

    self.piecePositions = [self calculatePiecePositons];

    long pieceNumber    = [[VHPiecePlaceManager sharedManager] numbersWithEnum:self.piecePlaceEnum];

    [[VHErrorManager sharedManager] errorJudgeWithPieceNumber:pieceNumber andBuilderNumber:[self.boomButtonBuilders count]];

    self.pieces         = [NSMutableArray arrayWithCapacity:pieceNumber];

    for (int i = 0; i < pieceNumber; i++)
    {
        VHBoomPiece *piece = [self getBoomPieceAt:[self.piecePositions objectAtIndex:i] withColor:[self.boomButtonBuilders objectAtIndex:i].buttonNormalColor];
        [self.pieces addObject:piece];
        [self addSubview:piece];
    }

    [self calculateStartPositions];
}

/**
 *  Calculate where should the pieces lay
 *
 *  @return The positions
 */
- (NSMutableArray<NSValue *> *)calculatePiecePositons
{
    switch (self.buttonEnum) {
        case VHButtonSimpleCircle:
        case VHButtonTextInsideCircle:
        case VHButtonTextOutsideCircle:
            return [[VHPiecePlaceManager sharedManager] positionsWithEnum:self.piecePlaceEnum
                                                          withParentFrame:self.bounds
                                                            withDotRadius:self.dotRadius
                                                     withHorizontalMargin:self.pieceHorizontalMargin
                                                       withVerticalMargin:self.pieceVerticalMargin
                                                       withInclinedMargin:self.pieceInclinedMargin];
            break;
        case VHButtonHam:
            return [[VHPiecePlaceManager sharedManager] positionsWithEnum:self.piecePlaceEnum
                                                          withParentFrame:self.bounds
                                                             withHamWidth:self.hamWidth
                                                            withHamHeight:self.hamHeight
                                                     withHorizontalMargin:self.pieceHorizontalMargin
                                                       withVerticalMargin:self.pieceInclinedMargin];
            break;
        default:
            break;
    }
    return [NSMutableArray arrayWithCapacity:0];
}

/**
 *  Initialise the a piece
 *
 *  @param position The position of the piece
 *  @param color    THe color of the piece
 *
 *  @return The piece
 */
- (VHBoomPiece *)getBoomPieceAt:(NSValue *)position withColor:(UIColor *)color
{
    switch (self.buttonEnum) {
        case VHButtonSimpleCircle:
        case VHButtonTextInsideCircle:
        case VHButtonTextOutsideCircle:
            return [[VHDot alloc] initWithFrame:[position CGRectValue] withColor:color];
            break;
        case VHButtonHam:
            return [[VHHam alloc] initWithFrame:[position CGRectValue] withColor:color];
            break;
        default:
            break;
    }
    return nil;
}

#pragma mark - Touch Action

/**
 *  Touch begin
 *
 *  @param touches <#touches description#>
 *  @param event   <#event description#>
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *anyTouch        = [touches anyObject];
    CGPoint touchLocation    = [anyTouch locationInView:self];
    CGRect selfRect          = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    if (CGRectContainsPoint(selfRect, touchLocation))
    {
        [self.buttonCircle setFillColor:self.buttonPressedColor.CGColor];
        if (self.draggable)
        {
            self.startPositionX      = touchLocation.x;
            self.startPositionY      = touchLocation.y;
            self.ableToStartDragging = YES;
        }
    }
}

/**
 *  Touch moved
 *
 *  @param touches <#touches description#>
 *  @param event   <#event description#>
 */
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.draggable && self.ableToStartDragging)
    {
        self.isDragging = YES;
        UITouch *anyTouch = [touches anyObject];
        CGPoint touchLocationInParent = [anyTouch locationInView:self.superview];
        self.frame = CGRectMake(touchLocationInParent.x - self.startPositionX, touchLocationInParent.y - self.startPositionY, self.frame.size.width, self.frame.size.height);
    }
}

/**
 *  Touch end
 *
 *  @param touches <#touches description#>
 *  @param event   <#event description#>
 */
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.buttonCircle setFillColor:self.buttonNormalColor.CGColor];
    
    if (self.isDragging)
    {
        self.ableToStartDragging = NO;
        self.isDragging = NO;
        [self calculateStartPositions];
        return;
    }
    
    UITouch *anyTouch = [touches anyObject];
    CGPoint touchLocation = [anyTouch locationInView:self];
    CGRect selfRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    if (CGRectContainsPoint(selfRect, touchLocation))
    {
        [self boom];
    }
}

/**
 *  Touch cancel
 *
 *  @param touches <#touches description#>
 *  @param event   <#event description#>
 */
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.buttonCircle setFillColor:self.buttonNormalColor.CGColor];
    
    if (self.isDragging)
    {
        self.ableToStartDragging = NO;
        self.isDragging = NO;
        [self calculateStartPositions];
        return;
    }
}

#pragma mark Animation

/**
 *  Boom the BMB
 */
- (void)boom
{
    if (self.animatingViewsNumber != 0)
    {
        return;
    }
    if ([self.boomDelegate respondsToSelector:@selector(onBoomWillShow)])
    {
        [self.boomDelegate onBoomWillShow];
    }
    [self createButtons];
    [self dimBackground];
    [self startShowAnimations];
}

/**
 *  Re boom the BMB
 */
- (void)reboom
{
    if (self.animatingViewsNumber != 0)
    {
        return;
    }
    if ([self.boomDelegate respondsToSelector:@selector(onBoomWillHide)])
    {
        [self.boomDelegate onBoomWillHide];
    }
    [self lightBackground];
    [self startHideAnimations];
}

/**
 *  Dim the background when the buttons show up
 */
- (void)dimBackground
{
    [self createBackground];
    self.background.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:self.duration + (self.pieces.count - 1) * self.delay animations:^
    {
        self.background.backgroundColor = self.dimColor;
    }
                     completion:^(BOOL finished)
    {
        if ([self.boomDelegate respondsToSelector:@selector(onBoomDidShow)])
        {
            [self.boomDelegate onBoomDidShow];
        }
    }];
}

/**
 *  Light the background when the buttons hide
 */
- (void)lightBackground
{
    [self createBackground];
    self.background.backgroundColor = self.dimColor;
    [UIView animateWithDuration:self.duration + (self.pieces.count - 1) * self.delay animations:^
     {
         self.background.backgroundColor = [UIColor clearColor];
     }
                     completion:^(BOOL finished)
     {
         if ([self.boomDelegate respondsToSelector:@selector(onBoomDidHide)])
         {
             [self.boomDelegate onBoomDidHide];
         }
     }];
}

/**
 *  Start all show animations
 */
- (void)startShowAnimations
{
    if (nil != self.background)
    {
        [self removeAllSubViews:self.background];
    }
    
    if (self.buttonEnum == VHButtonTextOutsideCircle)
    {
        [self adjustErrorForTextOutSideCircleButtonForStartYPosition];
    }
    
    [self calculateEndPositions];
    
    NSMutableArray<NSNumber *> *indexs = [self getOrderIndex:self.showOrderEnum inSize:(int)self.pieces.count];
    for (int i = 0; i < indexs.count; i++)
    {
        int index = [[indexs objectAtIndex:i] intValue];
        VHBoomButton *button = [self putSubButtonInBackground:[self.boomButtons objectAtIndex:index] withPosition:[[self.startPositions objectAtIndex:index] CGPointValue]];
        
        CGPoint startPosition = CGPointMake([[self.startPositions objectAtIndex:index] CGPointValue].x, [[self.startPositions objectAtIndex:index] CGPointValue].y);
        CGPoint endPosition = CGPointMake([[self.endPositions objectAtIndex:index] CGPointValue].x, [[self.endPositions objectAtIndex:index] CGPointValue].y);
        
        // [[self.endPositions objectAtIndex:i] CGPointValue] != endPosition ????
        
        [self setShowAnimationForEverySubButton:[self.pieces objectAtIndex:index]
                                         button:button
                                  startPosition:startPosition
                                    endPosition:endPosition
                                          index:index
                                    delayFactor:i];
    }
}

/**
 *  Set animation for each button and piece
 *
 *  @param piece         The piece
 *  @param button        The button
 *  @param startPosition Start position
 *  @param endPosition   End position
 *  @param index         The index of button
 *  @param delayFactor   Delay factor
 */
- (void)setShowAnimationForEverySubButton:(VHBoomPiece *)piece
                                   button:(VHBoomButton *)button
                            startPosition:(CGPoint)startPosition
                              endPosition:(CGPoint)endPosition
                                    index:(int)index
                              delayFactor:(int)delayFactor
{
    self.animatingViewsNumber++;
    
    [[button superview] bringSubviewToFront:button];
    
    NSMutableArray *xs = [NSMutableArray arrayWithCapacity:self.frames];
    NSMutableArray *ys = [NSMutableArray arrayWithCapacity:self.frames];
    [[VHAnimationManager sharedManager] calculateShowXY:self.boomEnum
                                                   ease:self.showMoveEaseEnum
                                                 frames:self.frames
                                          startPosition:startPosition
                                            endPosition:endPosition
                                                xValues:xs
                                                yValues:ys];
    
    for (UIView *goneView in button.goneViews)
    {
        goneView.alpha = 0;
    }
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:^(void)
     {
         piece.hidden = YES;
         button.hidden = NO;
         
         [CATransaction begin];
         [CATransaction setCompletionBlock:^(void)
          {
              self.animatingViewsNumber--;
          }];
         
         CAAnimationGroup *group = [CAAnimationGroup animation];
         group.duration = self.duration;
         group.removedOnCompletion = YES;
         group.fillMode = kCAFillModeForwards;
         
         
         CAKeyframeAnimation *xAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
         xAnimation.values = xs;
         
         CAKeyframeAnimation *yAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
         yAnimation.values = ys;
         
         CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
         scaleAnimation.values = [[VHAnimationManager sharedManager] calculateScale:self.showScaleEaseEnum
                                                                             frames:self.frames
                                                                         startScale:piece.frame.size.width / button.frame.size.width
                                                                           endScale:1];
         
         CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
         opacityAnimation.values = @[@0, @1];
         opacityAnimation.duration = self.duration;
         opacityAnimation.removedOnCompletion = NO;
         opacityAnimation.fillMode = kCAFillModeForwards;
         for (UIView *goneView in button.goneViews)
         {
             [goneView.layer addAnimation:opacityAnimation forKey:nil];
         }
         
         CAKeyframeAnimation *rotateAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
         rotateAnimation.values = [[VHAnimationManager sharedManager] calculateRotate:self.showRotateEaseEnum frames:self.frames startRotate:0 endRotate:self.rotationDegree];
         rotateAnimation.duration = self.duration;
         rotateAnimation.removedOnCompletion = NO;
         rotateAnimation.fillMode = kCAFillModeForwards;
         for (UIView *rotateView in button.rotateViews)
         {
             // http://joeshang.github.io/2014/12/19/understand-anchorpoint-position-frame/
             if (rotateView.frame.size.width == 0 || rotateView.frame.size.height == 0) continue;
             CGFloat anchorPointX = (button.rotateAnchorPoint.x - (rotateView.frame.origin.x + rotateView.frame.size.width / 2)) / rotateView.frame.size.width + 0.5;
             CGFloat anchorPointY = (button.rotateAnchorPoint.y - (rotateView.frame.origin.y + rotateView.frame.size.height / 2)) / rotateView.frame.size.height + 0.5;
             CGRect originalFrame = rotateView.layer.frame;
             [rotateView.layer setAnchorPoint:CGPointMake(anchorPointX, anchorPointY)];
             rotateView.layer.frame = originalFrame;
             [rotateView.layer addAnimation:rotateAnimation forKey:nil];
         }
         
         button.frame = CGRectMake(endPosition.x - button.frame.size.width / 2, endPosition.y - button.frame.size.height / 2, button.frame.size.width, button.frame.size.height);
         button.layer.frame = button.frame;
         
         [group setAnimations:@[xAnimation, yAnimation, scaleAnimation]];
         [button.layer addAnimation:group forKey:[NSString stringWithFormat:@"%d", index]];
         [CATransaction commit];

     }];
    
    CAKeyframeAnimation *scaleAnimationAtFirst = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimationAtFirst.values = @[@(piece.frame.size.width / button.frame.size.width)];
    scaleAnimationAtFirst.duration = delayFactor * self.delay;
    scaleAnimationAtFirst.removedOnCompletion = NO;
    scaleAnimationAtFirst.fillMode = kCAFillModeForwards;
    [button.layer addAnimation:scaleAnimationAtFirst forKey:[NSString stringWithFormat:@"%d", index]];
    
    [CATransaction commit];
}

/**
 *  Start all hide animations
 */
- (void)startHideAnimations
{
    NSMutableArray<NSNumber *> *indexs = [self getOrderIndex:self.hideOrderEnum inSize:(int)self.pieces.count];
    for (int i = 0; i < indexs.count; i++)
    {
        int index = [[indexs objectAtIndex:i] intValue];

        CGPoint startPosition = CGPointMake([[self.startPositions objectAtIndex:index] CGPointValue].x, [[self.startPositions objectAtIndex:index] CGPointValue].y);
        CGPoint endPosition = CGPointMake([[self.endPositions objectAtIndex:index] CGPointValue].x, [[self.endPositions objectAtIndex:index] CGPointValue].y);
        
        [self setHideAnimationForEverySubButton:[self.pieces objectAtIndex:index]
                                         button:[self.boomButtons objectAtIndex:index]
                                  startPosition:endPosition
                                    endPosition:startPosition
                                          index:index
                                    delayFactor:i];
    }
}

/**
 *  Set hide animation for each button and piece
 *
 *  @param piece         The piece
 *  @param button        The button
 *  @param startPosition Start position
 *  @param endPosition   End position
 *  @param index         Index of button
 *  @param delayFactor   Delay factor
 */
- (void)setHideAnimationForEverySubButton:(VHBoomPiece *)piece
                                   button:(VHBoomButton *)button
                            startPosition:(CGPoint)startPosition
                              endPosition:(CGPoint)endPosition
                                    index:(int)index
                              delayFactor:(int)delayFactor
{
    self.animatingViewsNumber++;
    
    NSMutableArray *xs = [NSMutableArray arrayWithCapacity:self.frames];
    NSMutableArray *ys = [NSMutableArray arrayWithCapacity:self.frames];
    [[VHAnimationManager sharedManager] calculateHideXY:self.boomEnum
                                                   ease:self.hideMoveEaseEnum
                                                 frames:self.frames
                                          startPosition:startPosition
                                            endPosition:endPosition
                                                xValues:xs
                                                yValues:ys];
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:^(void)
     {
         piece.hidden = NO;
         button.hidden = YES;
         self.animatingViewsNumber--;
         if (self.animatingViewsNumber == 0)
         {
             [self.background removeFromSuperview];
         }
     }];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = self.duration;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    group.beginTime = [button.layer convertTime:CACurrentMediaTime() fromLayer:nil] + delayFactor * self.delay;
    
    CAKeyframeAnimation *xAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    xAnimation.values = xs;
    
    CAKeyframeAnimation *yAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
    yAnimation.values = ys;
    
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.values = [[VHAnimationManager sharedManager] calculateScale:self.hideScaleEaseEnum
                                                                        frames:self.frames
                                                                    startScale:1
                                                                      endScale:piece.frame.size.width / button.frame.size.width];
    
    CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.values = @[@1, @0];
    opacityAnimation.duration = self.duration;
    opacityAnimation.removedOnCompletion = NO;
    opacityAnimation.fillMode = kCAFillModeForwards;
    opacityAnimation.beginTime = [button.layer convertTime:CACurrentMediaTime() fromLayer:nil] + delayFactor * self.delay;
    for (UIView *goneView in button.goneViews)
    {
        [goneView.layer addAnimation:opacityAnimation forKey:nil];
    }
    
    CAKeyframeAnimation *rotateAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAnimation.values = [[VHAnimationManager sharedManager] calculateRotate:self.hideRotateEaseEnum frames:self.frames startRotate:self.rotationDegree endRotate:0];
    rotateAnimation.duration = self.duration;
    rotateAnimation.removedOnCompletion = NO;
    rotateAnimation.fillMode = kCAFillModeForwards;
    rotateAnimation.beginTime = [button.layer convertTime:CACurrentMediaTime() fromLayer:nil] + delayFactor * self.delay;
    for (UIView *rotateView in button.rotateViews)
    {
        [rotateView.layer addAnimation:rotateAnimation forKey:nil];
    }
    
    [group setAnimations:@[xAnimation, yAnimation, scaleAnimation]];
    [button.layer addAnimation:group forKey:[NSString stringWithFormat:@"%d", index]];
    [CATransaction commit];
}

#pragma mark Other Methods

/**
 *  Create a background if it does not exist
 */
- (void)createBackground
{
    if (nil == self.background)
    {
        self.background = [[VHBackgroundView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        self.background.delegate = self;
    }
    [[[[UIApplication sharedApplication] delegate] window] addSubview:self.background];
}

/**
 *  Create buttons from button-builders
 */
- (void)createButtons
{
    [[VHErrorManager sharedManager] errorJudgeWithPiecePlaceEnum:self.piecePlaceEnum andButtonPlaceEnum:self.buttonPlaceEnum];
    
    self.boomButtons = [NSMutableArray arrayWithCapacity:self.pieces.count];
    int buttonNumber = (int)self.pieces.count;
    
    switch (self.buttonEnum)
    {
        case VHButtonSimpleCircle:
            for (int i = 0; i < buttonNumber; i++)
            {
                VHSimpleCircleButtonBuilder *builder = (VHSimpleCircleButtonBuilder *)[self.boomButtonBuilders objectAtIndex:i];
                builder.delegate = self;
                builder.index = i;
                VHSimpleCircleButton *simpleCircleButton = [builder createButton];
                [self.boomButtons setObject:simpleCircleButton atIndexedSubscript:i];
                
                self.simpleCircleButtonRadius = builder.buttonRadius;
            }
            break;
        case VHButtonTextInsideCircle:
            for (int i = 0; i < buttonNumber; i++)
            {
                VHTextInsideCircleButtonBuilder *builder = (VHTextInsideCircleButtonBuilder *)[self.boomButtonBuilders objectAtIndex:i];
                builder.delegate = self;
                builder.index = i;
                VHTextInsideCircleButton *textInsideCircleButton = [builder createButton];
                [self.boomButtons setObject:textInsideCircleButton atIndexedSubscript:i];
                
                self.textInsideCircleButtonRadius = builder.buttonRadius;
            }
            break;
        case VHButtonTextOutsideCircle:
            for (int i = 0; i < buttonNumber; i++)
            {
                VHTextOutsideCircleButtonBuilder *builder = (VHTextOutsideCircleButtonBuilder *)[self.boomButtonBuilders objectAtIndex:i];
                builder.delegate = self;
                builder.index = i;
                VHTextOutsideCircleButton *textOutsideCircleButton = [builder createButton];
                [self.boomButtons setObject:textOutsideCircleButton atIndexedSubscript:i];
                
                self.textOutsideCircleButtonWidth = builder.buttonWidth;
                self.textOutsideCircleButtonHeight = builder.buttonHeight;
            }
            break;
        case VHButtonHam:
            for (int i = 0; i < buttonNumber; i++)
            {
                VHHamButtonBuilder *builder = (VHHamButtonBuilder *)[self.boomButtonBuilders objectAtIndex:i];
                builder.delegate = self;
                builder.index = i;
                VHHamButton *hamButton = [builder createButton];
                [self.boomButtons setObject:hamButton atIndexedSubscript:i];
                
                self.hamButtonWidth = builder.buttonWidth;
                self.hamButtonHeight = builder.buttonHeight;
            }
            break;
        default:
            break;
    }
}

/**
 *  Remove all sub views in the parent view
 *
 *  @param parentView The parent view
 */
- (void)removeAllSubViews:(UIView *)parentView
{
    for (UIView *subViews in parentView.subviews)
    {
        [subViews removeFromSuperview];
    }
}

/**
 *  Calculate out the start positionss
 */
- (void)calculateStartPositions
{
    self.needToAdjustTextOutsideCircleButtonHeightError = YES;
    
    long pieceNumber = [[VHPiecePlaceManager sharedManager] numbersWithEnum:self.piecePlaceEnum];
    self.startPositions = [NSMutableArray arrayWithCapacity:pieceNumber];
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    for (int i = 0; i < pieceNumber; i++)
    {
        VHBoomPiece *piece = [self getBoomPieceAt:[self.piecePositions objectAtIndex:i] withColor:[self.boomButtonBuilders objectAtIndex:i].buttonNormalColor];
        CGPoint centerPointOfPieceInWindow = [self convertPoint:piece.frame.origin toView:window];
        centerPointOfPieceInWindow = CGPointMake(centerPointOfPieceInWindow.x + piece.frame.size.width / 2, centerPointOfPieceInWindow.y + piece.frame.size.height / 2);
        [self.startPositions addObject:[NSValue valueWithCGPoint:centerPointOfPieceInWindow]];
    }
}

/**
 *  Calculate out the end position
 */
- (void)calculateEndPositions
{
    switch (self.buttonEnum) {
        case VHButtonSimpleCircle:
            self.endPositions = [[VHButtonPlaceManager sharedManager] positionsWithEnum:self.buttonPlaceEnum
                                                                          withAlignment:self.buttonPlaceAlignmentEnum
                                                                        withParentFrame:[UIScreen mainScreen].bounds
                                                                       withButtonRadius:self.simpleCircleButtonRadius
                                                                       withButtonNumber:self.boomButtonBuilders.count
                                                             withButtonHorizontalMargin:self.buttonHorizontalMargin
                                                               withButtonInclinedMargin:self.buttonVerticalMargin
                                                               withButtonVerticalMargin:self.buttonInclinedMargin
                                                                    withButtonTopMargin:self.buttonTopMargin
                                                                 withButtonBottomMargin:self.buttonBottomMargin
                                                                   withButtonLeftMargin:self.buttonLeftMargin
                                                                  withButtonRightMargin:self.buttonRightMargin];
            break;
        case VHButtonTextInsideCircle:
            self.endPositions = [[VHButtonPlaceManager sharedManager] positionsWithEnum:self.buttonPlaceEnum
                                                                          withAlignment:self.buttonPlaceAlignmentEnum
                                                                        withParentFrame:[UIScreen mainScreen].bounds
                                                                       withButtonRadius:self.textInsideCircleButtonRadius
                                                                       withButtonNumber:self.boomButtonBuilders.count
                                                             withButtonHorizontalMargin:self.buttonHorizontalMargin
                                                               withButtonInclinedMargin:self.buttonVerticalMargin
                                                               withButtonVerticalMargin:self.buttonInclinedMargin
                                                                    withButtonTopMargin:self.buttonTopMargin
                                                                 withButtonBottomMargin:self.buttonBottomMargin
                                                                   withButtonLeftMargin:self.buttonLeftMargin
                                                                  withButtonRightMargin:self.buttonRightMargin];
            break;
        case VHButtonTextOutsideCircle:
            self.endPositions = [[VHButtonPlaceManager sharedManager] positionsWithEnum:self.buttonPlaceEnum
                                                                          withAlignment:self.buttonPlaceAlignmentEnum
                                                                        withParentFrame:[UIScreen mainScreen].bounds
                                                                        withButtonWidth:self.textOutsideCircleButtonWidth
                                                                       withButtonHeight:self.textOutsideCircleButtonHeight
                                                                       withButtonNumber:self.boomButtonBuilders.count
                                                             withButtonHorizontalMargin:self.buttonHorizontalMargin
                                                               withButtonInclinedMargin:self.buttonVerticalMargin
                                                               withButtonVerticalMargin:self.buttonInclinedMargin
                                                                    withButtonTopMargin:self.buttonTopMargin
                                                                 withButtonBottomMargin:self.buttonBottomMargin
                                                                   withButtonLeftMargin:self.buttonLeftMargin
                                                                  withButtonRightMargin:self.buttonRightMargin];
            break;
        case VHButtonHam:
            self.endPositions = [[VHButtonPlaceManager sharedManager] positionsForHamWithEnum:self.buttonPlaceEnum
                                                                                withAlignment:self.buttonPlaceAlignmentEnum
                                                                              withParentFrame:[UIScreen mainScreen].bounds
                                                                              withButtonWidth:self.hamButtonWidth
                                                                             withButtonHeight:self.hamButtonHeight
                                                                             withButtonNumber:self.boomButtonBuilders.count
                                                                   withButtonHorizontalMargin:self.buttonHorizontalMargin
                                                                     withButtonVerticalMargin:self.buttonVerticalMargin
                                                                          withButtonTopMargin:self.buttonTopMargin
                                                                       withButtonBottomMargin:self.buttonBottomMargin
                                                                         withButtonLeftMargin:self.buttonLeftMargin
                                                                        withButtonRightMargin:self.buttonRightMargin
                                                                  withLastButtonMarginMoreTop:self.lastHamButtonMarginMoreTop
                                                                      withLastButtonTopMargin:self.lastHamButtonTopMargin];
            break;
        default:
            break;
    }
    
}

/**
 *  Add the sub button in the background
 *
 *  @param button   The button
 *  @param position The position on the background
 *
 *  @return The added button
 */
- (VHBoomButton *)putSubButtonInBackground:(VHBoomButton *)button withPosition:(CGPoint)position
{
    [self createBackground];
    button.frame = CGRectMake(position.x - button.frame.size.width / 2, position.y - button.frame.size.height / 2, button.frame.size.width, button.frame.size.height);
    [self.background addSubview:button];
    return button;
}

/**
 *  Get current button index in different order
 *
 *  @param orderEnum Order
 *  @param size      The number of buttons
 *
 *  @return The order for showing or hiding buttons
 */
- (NSMutableArray<NSNumber *> *)getOrderIndex:(VHOrderEnum)orderEnum inSize:(int)size
{
    NSMutableArray<NSNumber *> *indexs = [NSMutableArray arrayWithCapacity:size];
    
    switch (orderEnum)
    {
        case VHOrderDefault:
            for (int i = 0; i < size; i++)
            {
                [indexs addObject:[NSNumber numberWithInteger:i]];
            }
            break;
        case VHOrderReverse:
            for (int i = 0; i < size; i++)
            {
                [indexs addObject:[NSNumber numberWithInteger:size - i - 1]];
            }
            break;
        case VHOrderRandom:
            {
                BOOL used[size];
                for (int i = 0; i < size; i++)
                {
                    used[i] = NO;
                }
                int count = 0;
                while (YES)
                {
                    int r = arc4random() % size;
                    if (used[r] == NO)
                    {
                        used[r] = YES;
                        [indexs addObject:[NSNumber numberWithInteger:r]];
                        count++;
                        
                        if (count == size)
                        {
                            break;
                        }
                    }
                }
            }
            break;
    }
    return indexs;
}

#pragma mark - On Button Clicked

/**
 *  Delegate - When a button was clicked
 *
 *  @param index The index of button
 */
- (void)onButtonClick:(int)index
{
    if ([self.boomDelegate respondsToSelector:@selector(onBoomClicked:)])
    {
        [self.boomDelegate onBoomClicked:index];
    }
    if (self.autoHide)
    {
        [self reboom];
    }
}

#pragma mark - On Background Clicked

/**
 *  Delegate - When the background was clicked
 */
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

#pragma mark - Builders

/**
 *  Add a simiple circle button builder
 *
 *  @param block The block where you set the properties for the builder
 */
- (void)addSimpleCircleButtonBuilderBlock:(void (^)(VHSimpleCircleButtonBuilder *))block
{
    VHSimpleCircleButtonBuilder *builder = [[VHSimpleCircleButtonBuilder alloc] init];
    block(builder);
    [self.boomButtonBuilders addObject:builder];
}

/**
 *  Add a text inside button builder
 *
 *  @param block The block where you set the properties for the builder
 */
- (void)addTextInsideCircleButtonBuilderBlock:(void (^)(VHTextInsideCircleButtonBuilder *))block
{
    VHTextInsideCircleButtonBuilder *builder = [[VHTextInsideCircleButtonBuilder alloc] init];
    block(builder);
    [self.boomButtonBuilders addObject:builder];
}

/**
 *  Add a text outside button builder
 *
 *  @param block The block where you set the properties for the builder
 */
- (void)addTextOutsideCircleButtonBuilderBlock:(void (^)(VHTextOutsideCircleButtonBuilder *))block
{
    VHTextOutsideCircleButtonBuilder *builder = [[VHTextOutsideCircleButtonBuilder alloc] init];
    block(builder);
    [self.boomButtonBuilders addObject:builder];
}

/**
 *  Add a ham button builder
 *
 *  @param block The block where you set the properties for the builder
 */
- (void)addHamButtonBuilderBlock:(void(^)(VHHamButtonBuilder *))block
{
    VHHamButtonBuilder *builder = [[VHHamButtonBuilder alloc] init];
    block(builder);
    [self.boomButtonBuilders addObject:builder];
}

/**
 *  Remove all builders added
 */
- (void)removeBuilders
{
    [self.boomButtonBuilders removeAllObjects];
    [self removePieces];
}

/**
 *  Remove pieces
 */
- (void)removePieces
{
    if (self.pieces != nil)
    {
        for (VHBoomPiece *piece in self.pieces)
        {
            [piece removeFromSuperview];
        }
    }
}

/**
 *  Adjust error
 */
- (void)adjustErrorForTextOutSideCircleButtonForStartYPosition
{
    if (self.needToAdjustTextOutsideCircleButtonHeightError == NO)
    {
        return;
    }
    
    CGFloat dotWidth = 2 * self.dotRadius;
    CGFloat dotHeight = dotWidth * self.textOutsideCircleButtonHeight / self.textOutsideCircleButtonWidth;
    CGFloat yOffset = (dotHeight - dotWidth) / 2;
    for (int i = 0; i < self.startPositions.count; i++)
    {
        CGPoint startPosition = [[self.startPositions objectAtIndex:i] CGPointValue];
        [self.startPositions setObject:[NSValue valueWithCGPoint:CGPointMake(startPosition.x, startPosition.y + yOffset)] atIndexedSubscript:i];
    }
    
    self.needToAdjustTextOutsideCircleButtonHeightError = NO;
}

@end
